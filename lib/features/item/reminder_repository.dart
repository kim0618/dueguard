import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../history/completion_event.dart';
import 'reminder_item.dart';

class ReminderRepository {
  ReminderRepository(this._isar);

  final Isar _isar;

  static Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [ReminderItemSchema, CompletionEventSchema],
      directory: dir.path,
    );
  }

  Stream<List<ReminderItem>> watchUpcoming() {
    return _isar.reminderItems
        .filter()
        .isArchivedEqualTo(false)
        .deletedAtIsNull()
        .sortByDueAt()
        .watch(fireImmediately: true);
  }

  Stream<List<ReminderItem>> watchTrash() {
    return _isar.reminderItems
        .filter()
        .deletedAtIsNotNull()
        .sortByDeletedAtDesc()
        .watch(fireImmediately: true);
  }

  Stream<List<CompletionEvent>> watchCompletions() {
    return _isar.completionEvents
        .where()
        .sortByCompletedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<ReminderItem?> getById(int id) {
    return _isar.reminderItems.get(id);
  }

  Future<List<ReminderItem>> getAllActive() {
    return _isar.reminderItems
        .filter()
        .isArchivedEqualTo(false)
        .deletedAtIsNull()
        .sortByDueAt()
        .findAll();
  }

  Future<int> save(ReminderItem item) async {
    return _isar.writeTxn(() => _isar.reminderItems.put(item));
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.reminderItems.delete(id));
  }

  Future<void> softDelete(int id) async {
    await _isar.writeTxn(() async {
      final item = await _isar.reminderItems.get(id);
      if (item == null) return;
      item.deletedAt = DateTime.now().toUtc();
      item.notificationId = null;
      await _isar.reminderItems.put(item);
    });
  }

  Future<int> addCompletionEvent(CompletionEvent event) async {
    return _isar.writeTxn(() => _isar.completionEvents.put(event));
  }

  Future<void> emptyTrash() async {
    await _isar.writeTxn(() async {
      final ids = await _isar.reminderItems
          .filter()
          .deletedAtIsNotNull()
          .idProperty()
          .findAll();
      await _isar.reminderItems.deleteAll(ids);
    });
  }
}
