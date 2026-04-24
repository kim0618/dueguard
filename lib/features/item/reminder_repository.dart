import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'reminder_item.dart';

class ReminderRepository {
  ReminderRepository(this._isar);

  final Isar _isar;

  static Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [ReminderItemSchema],
      directory: dir.path,
    );
  }

  Stream<List<ReminderItem>> watchUpcoming() {
    return _isar.reminderItems
        .where()
        .isArchivedEqualTo(false)
        .sortByDueAt()
        .watch(fireImmediately: true);
  }

  Future<ReminderItem?> getById(int id) {
    return _isar.reminderItems.get(id);
  }

  Future<List<ReminderItem>> getAllActive() {
    return _isar.reminderItems
        .where()
        .isArchivedEqualTo(false)
        .sortByDueAt()
        .findAll();
  }

  Future<int> save(ReminderItem item) async {
    return _isar.writeTxn(() => _isar.reminderItems.put(item));
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.reminderItems.delete(id));
  }
}
