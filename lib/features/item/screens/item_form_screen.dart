import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/item/reminder_actions.dart';
import '../../../features/item/reminder_item.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../features/notifications/notification_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/category_utils.dart';
import '../../../shared/utils/date_utils.dart' as du;

const _kLastCategoryKey = 'last_category';

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({super.key, this.itemId});

  final int? itemId;

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  Category _category = Category.card;
  RepeatType _repeatType = RepeatType.once;
  DateTime _dueAt = du.defaultDueAt();
  bool _saving = false;
  bool _loaded = false;

  bool get _isEdit => widget.itemId != null;

  @override
  void initState() {
    super.initState();
    _loadDefaults();
  }

  Future<void> _loadDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCategory = prefs.getString(_kLastCategoryKey);
    if (lastCategory != null) {
      final cat =
          Category.values.where((c) => c.name == lastCategory).firstOrNull;
      if (cat != null && !_isEdit) {
        setState(() => _category = cat);
      }
    }

    if (_isEdit) {
      final item =
          await ref.read(reminderRepositoryProvider).getById(widget.itemId!);
      if (item != null && mounted) {
        setState(() {
          _titleController.text = item.title;
          _noteController.text = item.note ?? '';
          _category = item.category;
          _repeatType = item.repeatType;
          _dueAt = item.dueAt.toLocal();
          _loaded = true;
        });
      }
    } else {
      setState(() => _loaded = true);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.item_edit_title : l10n.item_add_title),
        leading: BackButton(
          onPressed: () => _handleBack(context, l10n),
        ),
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  _buildBasicSection(context, l10n),
                  const SizedBox(height: 16),
                  _buildScheduleSection(context, l10n, locale),
                  const SizedBox(height: 16),
                  _buildNoteSection(context, l10n),
                  const SizedBox(height: 28),
                  _buildSaveButton(context, l10n),
                ],
              ),
            ),
    );
  }

  Widget _buildBasicSection(BuildContext context, AppLocalizations l10n) {
    return _FormSection(
      label: l10n.form_section_basic,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            autofocus: !_isEdit,
            maxLength: 80,
            maxLines: 2,
            minLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
            decoration: InputDecoration(
              hintText: l10n.item_title_hint,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              filled: false,
              contentPadding: EdgeInsets.zero,
              counterText: '',
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return l10n.error_title_required;
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          Divider(color: AppTheme.dividerColor, height: 1),
          const SizedBox(height: 14),
          Text(
            l10n.item_category_label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: Category.values.map((cat) {
              final selected = _category == cat;
              return FilterChip(
                label: Text(
                  categoryLabel(cat, l10n),
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : AppTheme.textSecondary,
                    fontSize: 12,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                selected: selected,
                selectedColor: AppTheme.primary,
                onSelected: (_) => setState(() => _category = cat),
                avatar: selected
                    ? null
                    : Icon(categoryIcon(cat),
                        size: 14, color: AppTheme.textSecondary),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection(
    BuildContext context,
    AppLocalizations l10n,
    String locale,
  ) {
    return _FormSection(
      label: l10n.form_section_schedule,
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            onTap: () => _pickDateTime(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  _FieldIconBox(icon: Icons.calendar_today_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.item_date_label,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppTheme.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          du.formatFullDateTime(_dueAt, locale),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppTheme.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Divider(color: AppTheme.dividerColor, height: 1),
          const SizedBox(height: 4),
          Row(
            children: [
              _FieldIconBox(icon: Icons.repeat),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.item_repeat_label,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    DropdownButton<RepeatType>(
                      value: _repeatType,
                      underline: const SizedBox.shrink(),
                      isDense: true,
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurface,
                          ),
                      items: RepeatType.values.map((r) {
                        return DropdownMenuItem(
                          value: r,
                          child: Text(repeatLabel(r, l10n)),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _repeatType = v);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection(BuildContext context, AppLocalizations l10n) {
    return _FormSection(
      label: l10n.item_note_label,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _FieldIconBox(icon: Icons.notes_outlined),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: _noteController,
              maxLines: 4,
              minLines: 3,
              decoration: InputDecoration(
                hintText: l10n.item_note_hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.zero,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: _saving ? null : () => _save(context, l10n),
      child: _saving
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : Text(l10n.save_button),
    );
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueAt,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dueAt),
    );
    if (time == null) return;

    setState(() {
      _dueAt = DateTime(
          date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _save(BuildContext context, AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    final locale = Localizations.localeOf(context).languageCode;
    final isPast = !_dueAt.isAfter(DateTime.now());
    final isOnce = _repeatType == RepeatType.once;

    if (isPast && isOnce) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.past_time_once_confirm_title),
          content: Text(l10n.past_time_once_confirm_body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancel_button),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.past_time_once_confirm_cta),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }

    final schedulerReady =
        await ref.read(notificationSchedulerProvider).hasPermission();
    if (!schedulerReady && context.mounted && !isPast) {
      await ref.read(notificationSchedulerProvider).requestPermission();
    }

    setState(() => _saving = true);

    try {
      final nowUtc = DateTime.now().toUtc();

      ReminderItem item;
      if (_isEdit) {
        item = (await ref
            .read(reminderRepositoryProvider)
            .getById(widget.itemId!))!;
        item.title = _titleController.text.trim();
        item.note = _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim();
        item.category = _category;
        item.repeatType = _repeatType;
        item.dueAt = _dueAt.toUtc();
        item.updatedAt = nowUtc;
        item.anchorDay = _dueAt.day;
        item.anchorMonth = _dueAt.month;
      } else {
        item = ReminderItem()
          ..title = _titleController.text.trim()
          ..note = _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim()
          ..category = _category
          ..repeatType = _repeatType
          ..dueAt = _dueAt.toUtc()
          ..anchorDay = _dueAt.day
          ..anchorMonth = _dueAt.month
          ..createdAt = nowUtc
          ..updatedAt = nowUtc;
      }

      final outcome = await saveReminderAction(
        ref: ref,
        item: item,
        copyFor: (i) => NotificationCopy(
          title: i.title,
          body: du.formatNotificationBody(i.dueAt, locale),
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kLastCategoryKey, _category.name);

      if (context.mounted) {
        final message = outcome.scheduled
            ? l10n.toast_notification_set
            : outcome.isPastOnce
                ? l10n.toast_item_saved
                : l10n.toast_notification_failed;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: !outcome.scheduled && !outcome.isPastOnce
                ? AppTheme.error
                : null,
          ),
        );
        Navigator.pop(context);
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error_save_failed),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _handleBack(BuildContext context, AppLocalizations l10n) async {
    final hasInput = _titleController.text.isNotEmpty ||
        _noteController.text.isNotEmpty;

    if (!hasInput) {
      Navigator.pop(context);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirm_discard_title),
        content: Text(l10n.confirm_discard_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel_button),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.confirm_discard_cta),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      Navigator.pop(context);
    }
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  fontSize: 10,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppTheme.cardShadow,
          ),
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }
}

class _FieldIconBox extends StatelessWidget {
  const _FieldIconBox({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icon, color: AppTheme.primary, size: 17),
    );
  }
}
