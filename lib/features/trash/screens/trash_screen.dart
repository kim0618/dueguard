import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/item/reminder_actions.dart';
import '../../../features/item/reminder_item.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/category_utils.dart';
import '../../../shared/utils/date_utils.dart' as du;

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(trashItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trash_title),
        leading: const BackButton(),
        actions: [
          itemsAsync.maybeWhen(
            data: (items) => items.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: () => _confirmEmpty(context, ref, l10n),
                      child: Text(
                        l10n.trash_empty_button,
                        style: const TextStyle(
                          color: AppTheme.error,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delete_outline,
                        size: 48, color: AppTheme.textTertiary),
                    const SizedBox(height: 12),
                    Text(
                      l10n.trash_empty,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: AppTheme.warnAccent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: AppTheme.warnAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.trash_info_banner,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return _TrashRow(
                      item: item,
                      l10n: l10n,
                      onRestore: () => _restore(context, ref, l10n, item.id),
                      onDelete: () =>
                          _confirmPermanentDelete(context, ref, l10n, item.id),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _restore(BuildContext context, WidgetRef ref,
      AppLocalizations l10n, int id) async {
    final locale = Localizations.localeOf(context).languageCode;
    await restoreReminderAction(
      ref: ref,
      id: id,
      copyFor: (i) => NotificationCopy(
        title: i.title,
        body: du.formatNotificationBody(i.dueAt, locale),
      ),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.trash_restore_toast)),
      );
    }
  }

  Future<void> _confirmPermanentDelete(BuildContext context, WidgetRef ref,
      AppLocalizations l10n, int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trash_permanent_delete_title),
        content: Text(l10n.trash_permanent_delete_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel_button),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: Text(l10n.trash_permanent_delete_cta),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await permanentDeleteAction(ref: ref, id: id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.trash_permanent_delete_toast)),
        );
      }
    }
  }

  Future<void> _confirmEmpty(BuildContext context, WidgetRef ref,
      AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trash_empty_confirm_title),
        content: Text(l10n.trash_empty_confirm_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel_button),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: Text(l10n.trash_empty_confirm_cta),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await emptyTrashAction(ref: ref);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.trash_emptied_toast)),
        );
      }
    }
  }
}

class _TrashRow extends StatelessWidget {
  const _TrashRow({
    required this.item,
    required this.l10n,
    required this.onRestore,
    required this.onDelete,
  });

  final ReminderItem item;
  final AppLocalizations l10n;
  final VoidCallback onRestore;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final deletedLocal = item.deletedAt?.toLocal();
    final deletedLabel = deletedLocal == null
        ? ''
        : l10n.trash_deleted_at(
            '${deletedLocal.month}/${deletedLocal.day}');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      child: Row(
        children: [
          Container(
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
          const SizedBox(width: 11),
          Expanded(
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
                const SizedBox(height: 3),
                Text(
                  deletedLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.restore, size: 20),
            tooltip: l10n.trash_restore_tooltip,
            color: AppTheme.primary,
            onPressed: onRestore,
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined, size: 20),
            tooltip: l10n.trash_permanent_delete_tooltip,
            color: AppTheme.error,
            onPressed: onDelete,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
