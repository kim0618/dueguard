import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notification_scheduler.dart';

final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  throw UnimplementedError(
      'notificationSchedulerProvider must be overridden in main');
});

final notificationPermissionProvider = FutureProvider<bool>((ref) async {
  return ref.read(notificationSchedulerProvider).hasPermission();
});

final exactAlarmPermissionProvider = FutureProvider<bool>((ref) async {
  return ref.read(notificationSchedulerProvider).hasExactAlarmPermission();
});

final batteryOptimizationOffProvider = FutureProvider<bool>((ref) async {
  return ref.read(notificationSchedulerProvider).hasBatteryOptimizationOff();
});
