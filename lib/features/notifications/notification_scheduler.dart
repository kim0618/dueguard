import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  NotificationScheduler._(this._plugin);

  static const String _channelId = 'dueguard_due_alerts';
  static const String _channelName = 'Due alerts';
  static const String _channelDescription = 'Scheduled reminders for upcoming due items';

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  static Future<NotificationScheduler> create() async {
    final plugin = FlutterLocalNotificationsPlugin();
    final scheduler = NotificationScheduler._(plugin);
    await scheduler._init();
    return scheduler;
  }

  Future<void> _init() async {
    if (_initialized) return;

    tzdata.initializeTimeZones();
    try {
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      ),
    );

    _initialized = true;
  }

  Future<bool> hasPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<bool> hasExactAlarmPermission() async {
    try {
      final status = await Permission.scheduleExactAlarm.status;
      return status.isGranted;
    } catch (_) {
      return true; // Older Androids don't need this
    }
  }

  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    if (!status.isGranted) return false;
    // Best-effort: request exact alarm permission too (opens system settings)
    try {
      await Permission.scheduleExactAlarm.request();
    } catch (_) {}
    return true;
  }

  Future<void> requestExactAlarmPermission() async {
    try {
      await Permission.scheduleExactAlarm.request();
    } catch (_) {}
  }

  Future<bool> hasBatteryOptimizationOff() async {
    try {
      final status = await Permission.ignoreBatteryOptimizations.status;
      return status.isGranted;
    } catch (_) {
      return true;
    }
  }

  Future<void> requestIgnoreBatteryOptimization() async {
    try {
      await Permission.ignoreBatteryOptimizations.request();
    } catch (_) {}
  }

  Future<void> openSystemSettings() async {
    await openAppSettings();
  }

  /// Test by showing an IMMEDIATE notification (bypasses scheduling).
  /// Returns "ok" or a brief failure reason for the user.
  Future<String> testImmediate({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);
    try {
      await _plugin.show(99998, title, body, details);
      return 'ok';
    } catch (e) {
      return e.toString();
    }
  }

  /// Test by scheduling a notification 15 seconds from now.
  /// Returns "ok" or a brief failure reason.
  Future<String> testSchedule({
    required String title,
    required String body,
  }) async {
    final at = DateTime.now().add(const Duration(seconds: 15));
    if (at.isBefore(DateTime.now())) return 'past_time';

    try {
      await _plugin.cancel(99999);
    } catch (_) {}

    final tz.TZDateTime scheduled;
    try {
      scheduled = tz.TZDateTime.from(at, tz.local);
    } catch (e) {
      return 'tz_error: $e';
    }

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    final errors = <String>[];
    const modes = [
      AndroidScheduleMode.exactAllowWhileIdle,
      AndroidScheduleMode.inexactAllowWhileIdle,
      AndroidScheduleMode.exact,
    ];
    for (final mode in modes) {
      try {
        await _plugin.zonedSchedule(
          99999,
          title,
          body,
          scheduled,
          details,
          androidScheduleMode: mode,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
        return 'ok';
      } catch (e) {
        errors.add('${mode.name}: $e');
        continue;
      }
    }
    return errors.join(' | ');
  }

  Future<bool> schedule({
    required int id,
    required DateTime at,
    required String title,
    required String body,
  }) async {
    try {
      if (at.isBefore(DateTime.now())) return false;

      // Always cancel any existing notification with same id first
      try {
        await _plugin.cancel(id);
      } catch (_) {}

      final scheduled = tz.TZDateTime.from(at, tz.local);

      const androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
      );
      const details = NotificationDetails(android: androidDetails);

      // Try multiple schedule modes in order of preference
      const modes = [
        AndroidScheduleMode.exactAllowWhileIdle,
        AndroidScheduleMode.inexactAllowWhileIdle,
        AndroidScheduleMode.exact,
      ];

      for (final mode in modes) {
        try {
          await _plugin.zonedSchedule(
            id,
            title,
            body,
            scheduled,
            details,
            androidScheduleMode: mode,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
          return true;
        } catch (_) {
          continue;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> cancel(int id) async {
    try {
      await _plugin.cancel(id);
    } catch (_) {}
  }

  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }
}
