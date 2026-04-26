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

  Color _barColor(int diff) {
    if (diff <= 0) return AppTheme.todayAccent;
    if (diff == 1) return AppTheme.warnAccent;
    return AppTheme.infoAccent;
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
      ),
      confirmDismiss: (_) async => _confirmDelete(context, l10n),
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppTheme.cardShadow,
          ),
          clipBehavior: Clip.hardEdge,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left urgency bar
                Container(
                  width: 3,
                  color: _barColor(diff),
                ),
                // Category icon
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: categoryBgColor(item.category),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      categoryIcon(item.category),
                      color: categoryFgColor(item.category),
                      size: 16,
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(9, 10, 4, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _CategoryChip(
                              label: categoryLabel(item.category, l10n),
                              bg: categoryBgColor(item.category),
                              fg: categoryFgColor(item.category),
                            ),
                            const SizedBox(width: 4),
                            _UrgencyChip(diff: diff, l10n: l10n),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_outlined,
                              size: 11,
                              color: AppTheme.textTertiary,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                du.formatFullDateTime(item.dueAt, locale),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Done button
                SizedBox(
                  width: 40,
                  child: Center(
                    child: GestureDetector(
                      onTap: onDone,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFBCC5D8),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: AppTheme.surface,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Color(0xFFBCC5D8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                style:
                    TextButton.styleFrom(foregroundColor: AppTheme.error),
                child: Text(l10n.delete_confirm_cta),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.bg, required this.fg});
  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
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
      bg = AppTheme.todayAccent.withValues(alpha: 0.10);
      fg = const Color(0xFFCF3B40);
      label = l10n.badge_overdue;
    } else if (diff == 0) {
      bg = AppTheme.todayAccent.withValues(alpha: 0.10);
      fg = const Color(0xFFCF3B40);
      label = l10n.date_relative_today;
    } else if (diff == 1) {
      bg = AppTheme.warnAccent.withValues(alpha: 0.10);
      fg = const Color(0xFFB87000);
      label = l10n.date_relative_tomorrow;
    } else {
      bg = AppTheme.infoAccent.withValues(alpha: 0.10);
      fg = const Color(0xFF3A62D4);
      label = l10n.date_relative_in_n_days(diff);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
