import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/item/reminder_actions.dart';
import '../../../features/item/reminder_item.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/category_utils.dart';
import '../../../shared/utils/date_utils.dart' as du;
import 'item_form_screen.dart';

class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({super.key, required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final itemAsync = ref.watch(reminderByIdProvider(itemId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.item_detail_title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ItemFormScreen(itemId: itemId),
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primary,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(l10n.edit_button),
          ),
        ],
      ),
      body: itemAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (item) {
          if (item == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) Navigator.pop(context);
            });
            return const SizedBox.shrink();
          }
          return _buildBody(context, ref, l10n, locale, item);
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String locale,
    ReminderItem item,
  ) {
    final today = DateUtils.dateOnly(DateTime.now());
    final due = DateUtils.dateOnly(item.dueAt.toLocal());
    final diff = due.difference(today).inDays;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        _DetailHeaderCard(item: item, l10n: l10n, diff: diff),
        const SizedBox(height: 16),
        _InfoCard(item: item, l10n: l10n, locale: locale),
        if (item.note != null && item.note!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _NoteCard(note: item.note!, l10n: l10n),
        ],
        const SizedBox(height: 28),
        Row(
          children: [
            SizedBox(
              width: 76,
              height: 52,
              child: OutlinedButton(
                onPressed: () => _confirmDelete(context, ref, l10n, item.id),
                child: Text(l10n.delete_button),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _confirmDone(context, ref, l10n, item),
                child: Text(l10n.mark_done_button),
              ),
            ),
          ],
        ),
      ],
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
      NotificationCopy buildCopy(ReminderItem i) => NotificationCopy(
            title: i.title,
            body: du.formatNotificationBody(i.dueAt, locale),
          );
      final undo = await markDoneAction(
        ref: ref,
        id: item.id,
        copyFor: buildCopy,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.toast_item_done),
            action: undo == null
                ? null
                : SnackBarAction(
                    label: l10n.undo_button,
                    onPressed: () => undoMarkDoneAction(
                      ref: ref,
                      undo: undo,
                      copyFor: buildCopy,
                    ),
                  ),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    int id,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.delete_confirm_title),
        content: Text(l10n.delete_confirm_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel_button),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: Text(l10n.delete_confirm_cta),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await deleteReminderAction(ref: ref, id: id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.toast_item_deleted)),
          );
          Navigator.pop(context);
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
  }
}

class _DetailHeaderCard extends StatelessWidget {
  const _DetailHeaderCard({
    required this.item,
    required this.l10n,
    required this.diff,
  });

  final ReminderItem item;
  final AppLocalizations l10n;
  final int diff;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: categoryBgColor(item.category),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(categoryIcon(item.category),
                color: categoryFgColor(item.category), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _CategoryChip(categoryLabel(item.category, l10n), category: item.category),
                    const SizedBox(width: 6),
                    _UrgencyChip(diff: diff, l10n: l10n),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(this.label, {required this.category});
  final String label;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: categoryBgColor(category),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: categoryFgColor(category),
        ),
      ),
    );
  }
}

class _UrgencyChip extends StatelessWidget {
  const _UrgencyChip({required this.diff, required this.l10n});

  final int diff;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    final String label;

    if (diff < 0) {
      bg = AppTheme.todayAccent.withValues(alpha: 0.12);
      fg = AppTheme.todayAccent;
      label = l10n.badge_overdue;
    } else if (diff == 0) {
      bg = AppTheme.todayAccent.withValues(alpha: 0.12);
      fg = AppTheme.todayAccent;
      label = l10n.date_relative_today;
    } else if (diff == 1) {
      bg = AppTheme.warnAccent.withValues(alpha: 0.10);
      fg = AppTheme.warnAccent;
      label = l10n.date_relative_tomorrow;
    } else if (diff <= 7) {
      bg = AppTheme.warnAccent.withValues(alpha: 0.10);
      fg = AppTheme.warnAccent;
      label = l10n.date_relative_in_n_days(diff);
    } else {
      bg = AppTheme.surfaceVariant;
      fg = AppTheme.textSecondary;
      label = l10n.date_relative_in_n_days(diff);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.item,
    required this.l10n,
    required this.locale,
  });

  final ReminderItem item;
  final AppLocalizations l10n;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: l10n.date_time_label,
            value: du.formatRepeatSchedule(item, l10n, locale),
          ),
          _divider(),
          _InfoRow(
            icon: Icons.repeat,
            label: l10n.repeat_label,
            value: repeatLabel(item.repeatType, l10n),
          ),
          _divider(),
          _InfoRow(
            icon: item.notificationId != null
                ? Icons.notifications_active_outlined
                : Icons.notifications_off_outlined,
            iconColor: item.notificationId != null ? null : Colors.grey[400],
            label: l10n.next_notification_label,
            value: item.notificationId != null
                ? du.formatFullDateTime(item.dueAt, locale)
                : l10n.notification_not_scheduled,
          ),
          _divider(),
          _InfoRow(
            icon: Icons.check_circle_outline,
            label: l10n.done_button,
            value: item.completedCount == 0
                ? l10n.completed_count_none
                : l10n.completed_count_n(item.completedCount),
          ),
          if (item.lastCompletedAt != null) ...[
            _divider(),
            _InfoRow(
              icon: Icons.history_outlined,
              label: l10n.last_completed_label,
              value: du.formatDateOnly(item.lastCompletedAt!, locale),
              isLast: true,
            ),
          ] else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Divider(color: AppTheme.dividerColor, height: 1),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 14, 16, isLast ? 14 : 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              size: 17,
              color: iconColor ?? AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.l10n});

  final String note;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(Icons.notes_outlined,
                size: 17, color: AppTheme.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.note_label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
