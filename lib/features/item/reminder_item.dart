import 'package:isar/isar.dart';

part 'reminder_item.g.dart';

enum Category {
  card,
  subscription,
  utility,
  tax,
  insurance,
  loan,
  other,
}

enum RepeatType {
  once,
  daily,
  weekly,
  monthly,
  yearly,
}

@collection
class ReminderItem {
  Id id = Isar.autoIncrement;

  late String title;
  String? note;

  @Enumerated(EnumType.name)
  late Category category;

  @Enumerated(EnumType.name)
  late RepeatType repeatType;

  @Index()
  late DateTime dueAt;

  int? notificationId;

  int? anchorDay;
  int? anchorMonth;

  late DateTime createdAt;
  late DateTime updatedAt;

  int completedCount = 0;
  DateTime? lastCompletedAt;

  @Index()
  bool isArchived = false;
}
