import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../history/completion_event.dart';
import '../notifications/notification_providers.dart';
import 'reminder_item.dart';
import 'reminder_providers.dart';
import 'repeat_rule.dart';

class NotificationCopy {
  const NotificationCopy({required this.title, required this.body});
  final String title;
  final String body;
}

typedef NotificationCopyBuilder = NotificationCopy Function(ReminderItem item);

class SaveOutcome {
  const SaveOutcome({required this.id, required this.scheduled, required this.isPastOnce});
  final int id;
  final bool scheduled;
  final bool isPastOnce;
}

Future<SaveOutcome> saveReminderAction({
  required WidgetRef ref,
  required ReminderItem item,
  required NotificationCopyBuilder copyFor,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);
  final now = DateTime.now();

  final oldNotificationId = item.notificationId;
  if (oldNotificationId != null) {
    await scheduler.cancel(oldNotificationId);
    item.notificationId = null;
  }

  var localDue = item.dueAt.toLocal();
  item.anchorDay ??= localDue.day;
  item.anchorMonth ??= localDue.month;

  final isOnce = item.repeatType == RepeatType.once;
  final isPast = !localDue.isAfter(now);

  if (!isOnce && isPast) {
    localDue = advanceUntilFutureLocal(
      localDue,
      item.repeatType,
      now,
      anchorDay: item.anchorDay,
      anchorMonth: item.anchorMonth,
    );
    item.dueAt = localDue.toUtc();
  }

  final savedId = await repo.save(item);
  item.id = savedId;

  final isPastOnce = isOnce && isPast;
  final shouldSchedule = localDue.isAfter(now) && !isPastOnce;

  var scheduled = false;
  if (shouldSchedule) {
    final copy = copyFor(item);
    scheduled = await scheduler.schedule(
      id: savedId,
      at: localDue,
      title: copy.title,
      body: copy.body,
    );
    if (scheduled) {
      item.notificationId = savedId;
      await repo.save(item);
    }
  }

  return SaveOutcome(id: savedId, scheduled: scheduled, isPastOnce: isPastOnce);
}

Future<void> deleteReminderAction({
  required WidgetRef ref,
  required int id,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);

  final existing = await repo.getById(id);
  final notifId = existing?.notificationId;
  if (notifId != null) {
    await scheduler.cancel(notifId);
  }
  // softDelete clears notificationId in DB
  await repo.softDelete(id);
}

Future<void> restoreReminderAction({
  required WidgetRef ref,
  required int id,
  required NotificationCopyBuilder copyFor,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);

  final item = await repo.getById(id);
  if (item == null) return;

  // Clear soft delete state
  item.deletedAt = null;
  item.notificationId = null;

  // For repeat items past their due date, advance to next future occurrence
  final now = DateTime.now();
  var localDue = item.dueAt.toLocal();

  if (item.repeatType != RepeatType.once && !localDue.isAfter(now)) {
    localDue = advanceUntilFutureLocal(
      localDue,
      item.repeatType,
      now,
      anchorDay: item.anchorDay,
      anchorMonth: item.anchorMonth,
    );
    item.dueAt = localDue.toUtc();
  }

  // Reschedule notification if future
  final isOnce = item.repeatType == RepeatType.once;
  final isPastOnce = isOnce && !localDue.isAfter(now);

  if (localDue.isAfter(now) && !isPastOnce) {
    final copy = copyFor(item);
    final ok = await scheduler.schedule(
      id: item.id,
      at: localDue,
      title: copy.title,
      body: copy.body,
    );
    if (ok) {
      item.notificationId = item.id;
    }
  }

  // Past once item: archive
  if (isPastOnce) {
    item.isArchived = true;
  }

  await repo.save(item);
}

Future<void> permanentDeleteAction({
  required WidgetRef ref,
  required int id,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  await repo.delete(id);
}

Future<void> emptyTrashAction({required WidgetRef ref}) async {
  await ref.read(reminderRepositoryProvider).emptyTrash();
}

/// 완료 처리 직전 상태 스냅샷. 스낵바 "실행취소"로 원상복구할 때 쓴다.
class MarkDoneUndo {
  const MarkDoneUndo({
    required this.itemId,
    required this.prevDueAtUtc,
    required this.prevCompletedCount,
    required this.prevLastCompletedAtUtc,
    required this.wasScheduled,
    required this.completionEventId,
  });

  final int itemId;
  final DateTime prevDueAtUtc;
  final int prevCompletedCount;
  final DateTime? prevLastCompletedAtUtc;
  final bool wasScheduled;
  final int completionEventId;
}

Future<MarkDoneUndo?> markDoneAction({
  required WidgetRef ref,
  required int id,
  required NotificationCopyBuilder copyFor,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);
  final nowUtc = DateTime.now().toUtc();

  final item = await repo.getById(id);
  if (item == null) return null;

  // Undo용 사전 상태 캡처
  final prevDueAtUtc = item.dueAt;
  final prevCompletedCount = item.completedCount;
  final prevLastCompletedAtUtc = item.lastCompletedAt;
  final wasScheduled = item.notificationId != null;

  if (item.notificationId != null) {
    await scheduler.cancel(item.notificationId!);
    item.notificationId = null;
  }

  // Record completion event
  final completionEvent = CompletionEvent()
    ..itemId = item.id
    ..title = item.title
    ..category = item.category
    ..completedAt = nowUtc
    ..dueAtAtCompletion = item.dueAt;
  final completionEventId = await repo.addCompletionEvent(completionEvent);

  final undo = MarkDoneUndo(
    itemId: item.id,
    prevDueAtUtc: prevDueAtUtc,
    prevCompletedCount: prevCompletedCount,
    prevLastCompletedAtUtc: prevLastCompletedAtUtc,
    wasScheduled: wasScheduled,
    completionEventId: completionEventId,
  );

  item.completedCount += 1;
  item.lastCompletedAt = nowUtc;
  item.updatedAt = nowUtc;

  if (item.repeatType == RepeatType.once) {
    item.isArchived = true;
    await repo.save(item);
    return undo;
  }

  final localDue = item.dueAt.toLocal();
  final now = DateTime.now();
  var next = nextOccurrenceLocal(
    localDue,
    item.repeatType,
    anchorDay: item.anchorDay ?? localDue.day,
    anchorMonth: item.anchorMonth ?? localDue.month,
  );
  if (!next.isAfter(now)) {
    next = advanceUntilFutureLocal(
      next,
      item.repeatType,
      now,
      anchorDay: item.anchorDay,
      anchorMonth: item.anchorMonth,
    );
  }
  item.dueAt = next.toUtc();

  final copy = copyFor(item);
  final ok = await scheduler.schedule(
    id: item.id,
    at: next,
    title: copy.title,
    body: copy.body,
  );
  item.notificationId = ok ? item.id : null;

  await repo.save(item);
  return undo;
}

/// 완료 처리 실행취소: 이전 회차/카운트 복원, 완료 이력 삭제, 알림 재예약.
Future<void> undoMarkDoneAction({
  required WidgetRef ref,
  required MarkDoneUndo undo,
  required NotificationCopyBuilder copyFor,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);

  final item = await repo.getById(undo.itemId);
  if (item == null) return;

  if (item.notificationId != null) {
    await scheduler.cancel(item.notificationId!);
    item.notificationId = null;
  }

  await repo.deleteCompletionEvent(undo.completionEventId);

  item.dueAt = undo.prevDueAtUtc;
  item.completedCount = undo.prevCompletedCount;
  item.lastCompletedAt = undo.prevLastCompletedAtUtc;
  item.isArchived = false;
  item.updatedAt = DateTime.now().toUtc();

  final localDue = item.dueAt.toLocal();
  if (undo.wasScheduled && localDue.isAfter(DateTime.now())) {
    final copy = copyFor(item);
    final ok = await scheduler.schedule(
      id: item.id,
      at: localDue,
      title: copy.title,
      body: copy.body,
    );
    item.notificationId = ok ? item.id : null;
  }

  await repo.save(item);
}

Future<void> catchUpAction({
  required WidgetRef ref,
  required NotificationCopyBuilder copyFor,
}) async {
  final repo = ref.read(reminderRepositoryProvider);
  final scheduler = ref.read(notificationSchedulerProvider);
  final now = DateTime.now();
  final items = await repo.getAllActive();

  for (final item in items) {
    try {
      var localDue = item.dueAt.toLocal();
      var dirty = false;

      if (item.repeatType != RepeatType.once && !localDue.isAfter(now)) {
        final advanced = advanceUntilFutureLocal(
          localDue,
          item.repeatType,
          now,
          anchorDay: item.anchorDay ?? localDue.day,
          anchorMonth: item.anchorMonth ?? localDue.month,
        );
        if (advanced != localDue) {
          item.dueAt = advanced.toUtc();
          localDue = advanced;
          dirty = true;
        }
      }

      final isOnce = item.repeatType == RepeatType.once;
      final isPastOnce = isOnce && !localDue.isAfter(now);

      if (isPastOnce) {
        if (item.notificationId != null) {
          await scheduler.cancel(item.notificationId!);
          item.notificationId = null;
          dirty = true;
        }
      } else if (localDue.isAfter(now)) {
        if (item.notificationId != null) {
          await scheduler.cancel(item.notificationId!);
        }
        final copy = copyFor(item);
        final ok = await scheduler.schedule(
          id: item.id,
          at: localDue,
          title: copy.title,
          body: copy.body,
        );
        final newNotifId = ok ? item.id : null;
        if (newNotifId != item.notificationId) {
          item.notificationId = newNotifId;
          dirty = true;
        }
      }

      if (dirty) {
        await repo.save(item);
      }
    } catch (_) {
      // Skip individual item failures, continue with others
      continue;
    }
  }
}
