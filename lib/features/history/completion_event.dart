import 'package:isar/isar.dart';
import '../item/reminder_item.dart';

part 'completion_event.g.dart';

@collection
class CompletionEvent {
  Id id = Isar.autoIncrement;

  @Index()
  late int itemId;

  late String title;

  @Enumerated(EnumType.name)
  late Category category;

  @Index()
  late DateTime completedAt;

  late DateTime dueAtAtCompletion;
}
