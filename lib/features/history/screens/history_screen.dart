import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/category_utils.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../completion_event.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final eventsAsync = ref.watch(completionEventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.history_title),
        leading: const BackButton(),
      ),
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 48, color: AppTheme.textTertiary),
                    const SizedBox(height: 12),
                    Text(
                      l10n.history_empty,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          // Group by month using locale-aware date format
          final locale = Localizations.localeOf(context).languageCode;
          final grouped = <String, List<CompletionEvent>>{};
          for (final e in events) {
            final local = e.completedAt.toLocal();
            final key = locale == 'ko'
                ? '${local.year}년 ${local.month}월'
                : '${_monthName(local.month)} ${local.year}';
            grouped.putIfAbsent(key, () => []).add(e);
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: grouped.entries.expand((entry) {
              return [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 14, 2, 6),
                  child: Row(
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppTheme.successAccent
                              .withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${entry.value.length}',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.successAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < entry.value.length; i++) ...[
                        if (i > 0)
                          Divider(
                              color: AppTheme.dividerLight,
                              height: 1,
                              indent: 16,
                              endIndent: 16),
                        _CompletionRow(event: entry.value[i], l10n: l10n),
                      ]
                    ],
                  ),
                ),
              ];
            }).toList(),
          );
        },
      ),
    );
  }

  String _monthName(int m) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return names[m - 1];
  }
}

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({required this.event, required this.l10n});

  final CompletionEvent event;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final local = event.completedAt.toLocal();
    final dueLocal = event.dueAtAtCompletion.toLocal();

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: categoryBgColor(event.category),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              categoryIcon(event.category),
              color: categoryFgColor(event.category),
              size: 16,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryBgColor(event.category),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        categoryLabel(event.category, l10n),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: categoryFgColor(event.category),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.history_due_prefix(
                          '${dueLocal.month}/${dueLocal.day}'),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppTheme.successAccent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: AppTheme.successAccent,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${local.month}/${local.day}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
