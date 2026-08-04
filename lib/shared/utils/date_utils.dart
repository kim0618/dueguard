import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../features/item/reminder_item.dart';

String formatRelativeDate(DateTime dueAt, AppLocalizations l10n) {
  final local = dueAt.toLocal();
  final today = DateUtils.dateOnly(DateTime.now());
  final due = DateUtils.dateOnly(local);
  final diff = due.difference(today).inDays;

  if (diff == 0) return l10n.date_relative_today;
  if (diff == 1) return l10n.date_relative_tomorrow;
  if (diff == 2) return l10n.date_relative_day_after_tomorrow;
  if (diff > 2) return l10n.date_relative_in_n_days(diff);
  return l10n.date_relative_overdue(-diff);
}

String formatFullDateTime(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('y년 M월 d일 (E) a h:mm', 'ko').format(local);
  }
  return DateFormat('EEE, MMM d, y  h:mm a', 'en').format(local);
}

String formatDateOnly(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('M월 d일 (E)', 'ko').format(local);
  }
  return DateFormat('EEE, MMM d', 'en').format(local);
}

String formatTimeOnly(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('a h:mm', 'ko').format(local);
  }
  return DateFormat('h:mm a', 'en').format(local);
}

String formatNotificationBody(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('M월 d일 a h:mm', 'ko').format(local);
  }
  return DateFormat('MMM d, h:mm a', 'en').format(local);
}

/// 반복 유형에 맞춰 일정을 요약 표시한다.
/// once는 절대 날짜시간, 그 외는 주기 + 시각으로 보여준다.
/// 예) 매일 오후 4:45 / 매주 월요일 오후 4:45 / 매달 27일 오후 4:45 / 매년 4월 27일 오후 4:45
String formatRepeatSchedule(
  ReminderItem item,
  AppLocalizations l10n,
  String locale,
) {
  final local = item.dueAt.toLocal();
  final time = formatTimeOnly(item.dueAt, locale);
  switch (item.repeatType) {
    case RepeatType.once:
      return formatFullDateTime(item.dueAt, locale);
    case RepeatType.daily:
      return l10n.repeat_schedule_daily(time);
    case RepeatType.weekly:
      final weekday = DateFormat('EEEE', locale).format(local);
      return l10n.repeat_schedule_weekly(weekday, time);
    case RepeatType.monthly:
      final day = item.anchorDay ?? local.day;
      return l10n.repeat_schedule_monthly(day, time);
    case RepeatType.yearly:
      final day = item.anchorDay ?? local.day;
      final month = item.anchorMonth ?? local.month;
      return l10n.repeat_schedule_yearly(month, day, time);
  }
}

/// 매년 돌아오는 특정 월/일의 다음 발생일(오전 9시).
/// 올해 해당 날짜가 이미 지났으면 내년으로 넘긴다. (세금 프리셋용)
DateTime nextAnnualOccurrence(int month, int day) {
  final now = DateTime.now();
  var candidate = DateTime(now.year, month, day, 9, 0);
  if (!candidate.isAfter(now)) {
    candidate = DateTime(now.year + 1, month, day, 9, 0);
  }
  return candidate;
}

DateTime defaultDueAt() {
  final now = DateTime.now();
  final candidate = DateTime(now.year, now.month, now.day, 9, 0);
  if (candidate.isAfter(now)) return candidate;
  final tomorrow = now.add(const Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 9, 0);
}
