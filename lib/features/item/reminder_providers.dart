import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'reminder_item.dart';
import 'reminder_repository.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider must be overridden in main');
});

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository(ref.watch(isarProvider));
});

final upcomingRemindersProvider = StreamProvider<List<ReminderItem>>((ref) {
  return ref.watch(reminderRepositoryProvider).watchUpcoming();
});

final reminderByIdProvider =
    FutureProvider.family<ReminderItem?, int>((ref, id) {
  return ref.watch(reminderRepositoryProvider).getById(id);
});
