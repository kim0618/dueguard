import 'package:flutter/material.dart';
import '../../features/item/reminder_item.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/utils/category_utils.dart';
import '../../shared/utils/date_utils.dart' as du;

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDone,
    required this.onDelete,
  });

  final ReminderItem item;
  final VoidCallback onTap;
  final VoidCallback onDone;
  final VoidCallback onDelete;

  int _daysDiff() {
    final today = DateUtils.dateOnly(DateTime.now());
    final due = DateUtils.dateOnly(item.dueAt.toLocal());
    return due.difference(today).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final diff = _daysDiff();

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 22),
      ),
      confirmDismiss: (_) async => _confirmDelete(context, l10n),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _CategoryIconBox(category: item.category, diff: diff),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CardContent(
                      item: item,
                      l10n: l10n,
                      locale: locale,
                      diff: diff,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey[350],
                      size: 24,
                    ),
                    tooltip: l10n.mark_done_button,
                    onPressed: onDone,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(
      BuildContext context, AppLocalizations l10n) async {
    return await showDialog<bool>(
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
        ) ??
        false;
  }
}

class _CategoryIconBox extends StatelessWidget {
  const _CategoryIconBox({required this.category, required this.diff});

  final Category category;
  final int diff;

  Color get _bgColor {
    if (diff <= 0) return AppTheme.todayAccent.withValues(alpha: 0.10);
    if (diff <= 7) return AppTheme.upcomingAccent.withValues(alpha: 0.10);
    return AppTheme.primary.withValues(alpha: 0.08);
  }

  Color get _iconColor {
    if (diff <= 0) return AppTheme.todayAccent;
    if (diff <= 7) return AppTheme.upcomingAccent;
    return AppTheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(categoryIcon(category), color: _iconColor, size: 22),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.item,
    required this.l10n,
    required this.locale,
    required this.diff,
  });

  final ReminderItem item;
  final AppLocalizations l10n;
  final String locale;
  final int diff;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            _StatusChip(diff: diff, l10n: l10n),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            _SmallLabel(categoryLabel(item.category, l10n)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '·',
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              ),
            ),
            _SmallLabel(repeatLabel(item.repeatType, l10n)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              item.notificationId != null
                  ? Icons.notifications_outlined
                  : Icons.notifications_off_outlined,
              size: 11,
              color: item.notificationId != null
                  ? AppTheme.textSecondary
                  : Colors.grey[350],
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                du.formatFullDateTime(item.dueAt, locale),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.diff, required this.l10n});

  final int diff;
  final AppLocalizations l10n;

  Color get _bgColor {
    if (diff <= 0) return AppTheme.todayAccent.withValues(alpha: 0.12);
    if (diff <= 7) return AppTheme.upcomingAccent.withValues(alpha: 0.10);
    return AppTheme.surfaceVariant;
  }

  Color get _textColor {
    if (diff <= 0) return AppTheme.todayAccent;
    if (diff <= 7) return AppTheme.upcomingAccent;
    return AppTheme.textSecondary;
  }

  String _label() {
    if (diff < 0) return l10n.badge_overdue;
    if (diff == 0) return l10n.date_relative_today;
    if (diff == 1) return l10n.date_relative_tomorrow;
    return l10n.date_relative_in_n_days(diff);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _label(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _textColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _SmallLabel extends StatelessWidget {
  const _SmallLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 10,
            ),
      ),
    );
  }
}
