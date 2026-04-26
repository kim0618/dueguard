import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../features/history/screens/history_screen.dart';
import '../../../features/notifications/notification_providers.dart';
import '../../../features/trash/screens/trash_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/providers/locale_provider.dart';
import '../../../shared/theme/app_theme.dart';

void _showResultDialog(BuildContext context, String title, String result) {
  final l10n = AppLocalizations.of(context)!;
  final ok = result == 'ok';
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(
        ok
            ? '✅ 발사 성공\n\n📱 확인 방법:\n1. 화면 상단을 아래로 쓸어내려 알림창 열기\n2. "DueGuard" 알림 있는지 확인\n\n💡 앱이 켜져있어 배너로는 안 떠요.\n   화면을 잠그면 헤드업 알림으로 옵니다.'
            : '❌ 실패\n\n에러:\n$result\n\n해결 방법:\n1. 알림 권한 허용\n2. 알람 및 리마인더 권한 허용\n3. 배터리 최적화 해제\n4. 삼성: 디바이스 케어 > 절전앱에서 제외',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.date_picker_confirm),
        ),
      ],
    ),
  );
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final permissionAsync = ref.watch(notificationPermissionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings_title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SectionLabel(l10n.settings_notification_section),
          const SizedBox(height: 8),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: permissionAsync.maybeWhen(
                  data: (g) =>
                      g ? Icons.notifications_active_outlined : Icons.notifications_off_outlined,
                  orElse: () => Icons.notifications_outlined,
                ),
                iconColor: permissionAsync.maybeWhen(
                  data: (g) => g ? Colors.green[600]! : AppTheme.error,
                  orElse: () => AppTheme.textSecondary,
                ),
                title: l10n.settings_notification_section,
                subtitle: permissionAsync.maybeWhen(
                  data: (g) => g
                      ? l10n.settings_permission_allowed
                      : l10n.settings_permission_denied,
                  orElse: () => '',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () async {
                  final granted = permissionAsync.maybeWhen(
                    data: (g) => g,
                    orElse: () => false,
                  );
                  if (granted) {
                    await ref
                        .read(notificationSchedulerProvider)
                        .openSystemSettings();
                  } else {
                    await ref
                        .read(notificationSchedulerProvider)
                        .requestPermission();
                  }
                  ref.invalidate(notificationPermissionProvider);
                },
              ),
              _TilesDivider(),
              _SettingsTile(
                icon: Icons.open_in_new_outlined,
                title: l10n.settings_notification_open_settings,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () async {
                  await ref
                      .read(notificationSchedulerProvider)
                      .openSystemSettings();
                  ref.invalidate(notificationPermissionProvider);
                },
              ),
              _TilesDivider(),
              _SettingsTile(
                icon: Icons.notification_important_outlined,
                iconColor: AppTheme.successAccent,
                title: '즉시 알림 테스트',
                subtitle: '알림창에 바로 떠야 정상',
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () async {
                  final result = await ref
                      .read(notificationSchedulerProvider)
                      .testImmediate(
                        title: 'DueGuard 즉시 테스트',
                        body: '이 알림이 보이면 알림 시스템 정상',
                      );
                  if (context.mounted) {
                    _showResultDialog(context, '즉시 알림 결과', result);
                  }
                },
              ),
              _TilesDivider(),
              _SettingsTile(
                icon: Icons.alarm,
                iconColor: AppTheme.warnAccent,
                title: '15초 뒤 알람 테스트',
                subtitle: '예약 후 화면 잠그고 기다리세요',
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () async {
                  final result = await ref
                      .read(notificationSchedulerProvider)
                      .testSchedule(
                        title: 'DueGuard 예약 테스트',
                        body: '15초 후 알람 발사',
                      );
                  if (context.mounted) {
                    _showResultDialog(context, '예약 알람 결과', result);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionLabel(l10n.settings_records_section),
          const SizedBox(height: 8),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.check_circle_outline,
                iconColor: AppTheme.successAccent,
                title: l10n.history_title,
                subtitle: l10n.history_subtitle,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                ),
              ),
              _TilesDivider(),
              _SettingsTile(
                icon: Icons.delete_outline,
                iconColor: AppTheme.warnAccent,
                title: l10n.trash_title,
                subtitle: l10n.trash_subtitle,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrashScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionLabel(l10n.settings_language_section),
          const SizedBox(height: 8),
          _SettingsCard(
            children: [
              _LanguageTile(l10n: l10n),
            ],
          ),
          const SizedBox(height: 24),
          _SectionLabel(l10n.settings_about_section),
          const SizedBox(height: 8),
          _SettingsCard(
            children: [
              _VersionTile(l10n: l10n),
              _TilesDivider(),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: l10n.about_open_source,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onTap: () => showLicensePage(context: context),
              ),
              _TilesDivider(),
              _AboutDescriptionTile(l10n: l10n),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class _TilesDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: AppTheme.dividerColor, height: 1),
    );
  }
}

class _AboutDescriptionTile extends StatelessWidget {
  const _AboutDescriptionTile({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
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
            child: Icon(Icons.shield_outlined,
                size: 17, color: AppTheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settings_about_section,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.about_app_description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
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

class _LanguageTile extends ConsumerWidget {
  const _LanguageTile({required this.l10n});
  final AppLocalizations l10n;

  String _labelFor(Locale? locale) {
    if (locale == null) return l10n.settings_language_system;
    if (locale.languageCode == 'ko') return l10n.settings_language_korean;
    return l10n.settings_language_english;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider);
    return _SettingsTile(
      icon: Icons.language,
      iconColor: AppTheme.primary,
      title: l10n.settings_language,
      subtitle: _labelFor(current),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppTheme.textSecondary,
        size: 18,
      ),
      onTap: () => _showPicker(context, ref, current),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref, Locale? current) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.settings_language,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
              _LanguageOption(
                label: l10n.settings_language_system,
                selected: current == null,
                onTap: () {
                  ref.read(localeProvider.notifier).setLocale(null);
                  Navigator.pop(ctx);
                },
              ),
              _LanguageOption(
                label: l10n.settings_language_korean,
                selected: current?.languageCode == 'ko',
                onTap: () {
                  ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('ko'));
                  Navigator.pop(ctx);
                },
              ),
              _LanguageOption(
                label: l10n.settings_language_english,
                selected: current?.languageCode == 'en',
                onTap: () {
                  ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('en'));
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? AppTheme.primary : AppTheme.onSurface,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check, size: 20, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}

class _VersionTile extends StatefulWidget {
  const _VersionTile({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_VersionTile> createState() => _VersionTileState();
}

class _VersionTileState extends State<_VersionTile> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(Icons.smartphone_outlined,
                size: 17, color: AppTheme.textSecondary),
          ),
          const SizedBox(width: 12),
          Text(
            widget.l10n.about_app_version(_version),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
