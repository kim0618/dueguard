import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'features/home/screens/home_screen.dart';
import 'features/item/reminder_actions.dart';
import 'features/item/reminder_item.dart';
import 'features/item/reminder_providers.dart';
import 'features/item/reminder_repository.dart';
import 'features/notifications/notification_providers.dart';
import 'features/notifications/notification_scheduler.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/providers/locale_provider.dart';
import 'shared/theme/app_theme.dart';
import 'shared/utils/date_utils.dart' as du;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ko');
  await initializeDateFormatting('en');

  final isar = await ReminderRepository.openIsar();
  final scheduler = await NotificationScheduler.create();

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        notificationSchedulerProvider.overrideWithValue(scheduler),
      ],
      child: const DueGuardApp(),
    ),
  );
}

class DueGuardApp extends ConsumerStatefulWidget {
  const DueGuardApp({super.key});

  @override
  ConsumerState<DueGuardApp> createState() => _DueGuardAppState();
}

class _DueGuardAppState extends ConsumerState<DueGuardApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _catchUp());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh permission providers (user may have changed system settings)
      ref.invalidate(notificationPermissionProvider);
      ref.invalidate(exactAlarmPermissionProvider);
      ref.invalidate(batteryOptimizationOffProvider);
      _catchUp();
    }
  }

  void _catchUp() {
    if (!mounted) return;
    final locale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final resolved = (locale == 'ko') ? 'ko' : 'en';
    catchUpAction(
      ref: ref,
      copyFor: (item) => _notificationCopy(item, resolved),
    ).catchError((_) {
      // Best-effort sync; ignore failures so app still launches
    });
  }

  NotificationCopy _notificationCopy(ReminderItem item, String locale) {
    return NotificationCopy(
      title: item.title,
      body: du.formatNotificationBody(item.dueAt, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'DueGuard',
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
