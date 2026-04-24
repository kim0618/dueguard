import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../features/notifications/notification_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';

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
