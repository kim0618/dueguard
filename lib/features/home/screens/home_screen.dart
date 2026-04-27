import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/item/reminder_actions.dart';
import '../../../features/item/reminder_item.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../features/notifications/notification_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/date_utils.dart' as du;
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/reminder_card.dart';
import '../../item/screens/item_detail_screen.dart';
import '../../calendar/screens/calendar_screen.dart';
import '../../item/screens/item_form_screen.dart';
import '../../settings/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(upcomingRemindersProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: const Size(24, 26),
              painter: _ShieldLogoPainter(),
            ),
            const SizedBox(width: 7),
            Text(
              l10n.home_title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarScreen()),
              ),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: AppTheme.cardShadowSm,
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
                ref.invalidate(notificationPermissionProvider);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: AppTheme.cardShadowSm,
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _PermissionsBanners(),
          Expanded(
            child: itemsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (items) => _buildBody(context, ref, l10n, items),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddScreen(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l10n.add_item_fab),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    List<ReminderItem> items,
  ) {
    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.shield_outlined,
        title: l10n.home_empty_title,
        body: l10n.home_empty_body,
        ctaLabel: l10n.onboarding_a_cta,
        onCta: () => _openAddScreen(context, ref),
      );
    }

    final today = DateUtils.dateOnly(DateTime.now());
    // 오늘 + 과거 미완료 항목을 오늘 섹션에 표시
    final todayItems = items
        .where((i) => !DateUtils.dateOnly(i.dueAt.toLocal()).isAfter(today))
        .toList();
    final thisWeekItems = items.where((i) {
      final due = DateUtils.dateOnly(i.dueAt.toLocal());
      return due.isAfter(today) &&
          due.isBefore(today.add(const Duration(days: 8)));
    }).toList();
    final upcomingItems = items
        .where((i) =>
            DateUtils.dateOnly(i.dueAt.toLocal())
                .isAfter(today.add(const Duration(days: 7))))
        .toList();

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      children: [
        _SummaryCard(
          todayCount: todayItems.length,
          weekCount: thisWeekItems.length,
          totalCount: items.length,
          l10n: l10n,
        ),
        if (todayItems.isNotEmpty) ...[
          _SectionHeader(
            label: l10n.section_today,
            count: todayItems.length,
            urgency: true,
          ),
          ...todayItems
              .map((item) => _itemCard(context, ref, l10n, item)),
        ],
        if (thisWeekItems.isNotEmpty) ...[
          _SectionHeader(
            label: l10n.section_this_week,
            count: thisWeekItems.length,
          ),
          ...thisWeekItems
              .map((item) => _itemCard(context, ref, l10n, item)),
        ],
        if (upcomingItems.isNotEmpty) ...[
          _SectionHeader(
            label: l10n.section_upcoming,
            count: upcomingItems.length,
          ),
          ...upcomingItems
              .map((item) => _itemCard(context, ref, l10n, item)),
        ],
      ],
    );
  }

  Widget _itemCard(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ReminderItem item,
  ) {
    return ReminderCard(
      item: item,
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemDetailScreen(itemId: item.id),
          ),
        );
        ref.invalidate(reminderByIdProvider(item.id));
      },
      onDone: () => _confirmDone(context, ref, l10n, item),
      onDelete: () => _deleteItem(context, ref, l10n, item.id),
    );
  }

  Future<void> _confirmDone(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ReminderItem item,
  ) async {
    final isRepeat = item.repeatType != RepeatType.once;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.mark_done_confirm_title),
        content: Text(
          isRepeat
              ? l10n.mark_done_confirm_body_repeat
              : l10n.mark_done_confirm_body_once,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel_button),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.done_button),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final locale = Localizations.localeOf(context).languageCode;
      await markDoneAction(
        ref: ref,
        id: item.id,
        copyFor: (i) => NotificationCopy(
          title: i.title,
          body: du.formatNotificationBody(i.dueAt, locale),
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.toast_item_done)),
        );
      }
    }
  }

  Future<void> _deleteItem(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    int id,
  ) async {
    try {
      await deleteReminderAction(ref: ref, id: id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.toast_item_deleted)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error_delete_failed),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  void _openAddScreen(BuildContext context, WidgetRef ref) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ItemFormScreen()),
    );
    ref.invalidate(notificationPermissionProvider);
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.count,
    this.urgency = false,
  });

  final String label;
  final int count;
  final bool urgency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: urgency
                  ? AppTheme.todayAccent.withValues(alpha: 0.10)
                  : AppTheme.infoAccent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: urgency ? AppTheme.todayAccent : AppTheme.infoAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.todayCount,
    required this.weekCount,
    required this.totalCount,
    required this.l10n,
  });

  final int todayCount;
  final int weekCount;
  final int totalCount;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _SummaryCell(
                count: todayCount,
                label: l10n.home_summary_today,
                isToday: true),
            VerticalDivider(
                width: 1, thickness: 1, color: AppTheme.dividerLight),
            _SummaryCell(
                count: weekCount, label: l10n.home_summary_this_week),
            VerticalDivider(
                width: 1, thickness: 1, color: AppTheme.dividerLight),
            _SummaryCell(
                count: totalCount, label: l10n.home_summary_total),
          ],
        ),
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  const _SummaryCell({
    required this.count,
    required this.label,
    this.isToday = false,
  });

  final int count;
  final String label;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isToday) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.todayAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 2),
          ] else
            const SizedBox(height: 10),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              color: isToday ? AppTheme.todayAccent : AppTheme.primary,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppTheme.textTertiary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShieldLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.22);
    path.lineTo(0, size.height * 0.48);
    path.cubicTo(0, size.height * 0.72, size.width * 0.15, size.height * 0.91,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.85, size.height * 0.91, size.width,
        size.height * 0.72, size.width, size.height * 0.48);
    path.lineTo(size.width, size.height * 0.22);
    path.quadraticBezierTo(size.width, 0, size.width / 2, 0);
    path.close();
    canvas.drawPath(path, paint);

    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.13
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path();
    checkPath.moveTo(size.width * 0.27, size.height * 0.50);
    checkPath.lineTo(size.width * 0.44, size.height * 0.64);
    checkPath.lineTo(size.width * 0.73, size.height * 0.37);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PermissionsBanners extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notif = ref.watch(notificationPermissionProvider);
    final exact = ref.watch(exactAlarmPermissionProvider);
    final battery = ref.watch(batteryOptimizationOffProvider);

    final notifGranted = notif.maybeWhen(data: (v) => v, orElse: () => true);
    final exactGranted = exact.maybeWhen(data: (v) => v, orElse: () => true);
    final batteryOff = battery.maybeWhen(data: (v) => v, orElse: () => true);

    final scheduler = ref.read(notificationSchedulerProvider);

    final banners = <Widget>[];

    if (!notifGranted) {
      banners.add(_PermissionBanner(
        message: '알림이 꺼져 있어요. 이 앱은 알림이 핵심입니다.',
        cta: '허용',
        onTap: () async {
          await scheduler.requestPermission();
          ref.invalidate(notificationPermissionProvider);
          ref.invalidate(exactAlarmPermissionProvider);
        },
      ));
    } else if (!exactGranted) {
      banners.add(_PermissionBanner(
        message: '정확한 시간에 알림이 오려면 "알람 및 리마인더" 권한이 필요해요.',
        cta: '설정',
        onTap: () async {
          await scheduler.requestExactAlarmPermission();
          ref.invalidate(exactAlarmPermissionProvider);
        },
      ));
    } else if (!batteryOff) {
      banners.add(_PermissionBanner(
        message: '배터리 절약 모드 때문에 알림이 늦거나 안 올 수 있어요.',
        cta: '해제',
        onTap: () async {
          await scheduler.requestIgnoreBatteryOptimization();
          ref.invalidate(batteryOptimizationOffProvider);
        },
      ));
    }

    if (banners.isEmpty) return const SizedBox.shrink();
    return Column(children: banners);
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner({
    required this.message,
    required this.cta,
    required this.onTap,
  });

  final String message;
  final String cta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.warnAccent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.warnAccent.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: AppTheme.warnAccent,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurface,
                    height: 1.4,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.warnAccent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(cta),
          ),
        ],
      ),
    );
  }
}
