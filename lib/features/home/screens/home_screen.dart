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
import '../../item/screens/item_form_screen.dart';
import '../../settings/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(upcomingRemindersProvider);
    final permissionAsync = ref.watch(notificationPermissionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settings_title,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
              ref.invalidate(notificationPermissionProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          permissionAsync.maybeWhen(
            data: (granted) => granted
                ? const SizedBox.shrink()
                : _PermissionBanner(
                    onAllow: () async {
                      await ref
                          .read(notificationSchedulerProvider)
                          .requestPermission();
                      ref.invalidate(notificationPermissionProvider);
                    },
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
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
    final todayItems = items
        .where((i) => DateUtils.dateOnly(i.dueAt.toLocal()) == today)
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: urgency ? AppTheme.todayAccent : AppTheme.textSecondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: urgency
                  ? AppTheme.todayAccent.withValues(alpha: 0.10)
                  : AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: urgency
                        ? AppTheme.todayAccent
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner({required this.onAllow});
  final VoidCallback onAllow;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.upcomingAccent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.upcomingAccent.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: AppTheme.upcomingAccent,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.notification_permission_banner,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurface,
                    height: 1.4,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onAllow,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.upcomingAccent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(l10n.notification_permission_allow_button),
          ),
        ],
      ),
    );
  }
}
