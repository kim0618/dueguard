import 'reminder_item.dart';

int daysInMonth(int year, int month) {
  return DateTime(year, month + 1, 0).day;
}

DateTime nextOccurrenceLocal(
  DateTime currentLocal,
  RepeatType repeat, {
  int? anchorDay,
  int? anchorMonth,
}) {
  switch (repeat) {
    case RepeatType.once:
      return currentLocal;
    case RepeatType.daily:
      return currentLocal.add(const Duration(days: 1));
    case RepeatType.weekly:
      return currentLocal.add(const Duration(days: 7));
    case RepeatType.monthly:
      return _nextMonthly(currentLocal, anchorDay ?? currentLocal.day);
    case RepeatType.yearly:
      return _nextYearly(
        currentLocal,
        anchorDay ?? currentLocal.day,
        anchorMonth ?? currentLocal.month,
      );
  }
}

DateTime _nextMonthly(DateTime currentLocal, int anchorDay) {
  final targetMonthRaw = currentLocal.month + 1;
  final year = currentLocal.year + (targetMonthRaw - 1) ~/ 12;
  final month = ((targetMonthRaw - 1) % 12) + 1;
  final day = anchorDay.clamp(1, daysInMonth(year, month));
  return DateTime(year, month, day, currentLocal.hour, currentLocal.minute);
}

DateTime _nextYearly(DateTime currentLocal, int anchorDay, int anchorMonth) {
  final year = currentLocal.year + 1;
  final day = anchorDay.clamp(1, daysInMonth(year, anchorMonth));
  return DateTime(year, anchorMonth, day, currentLocal.hour, currentLocal.minute);
}

DateTime advanceUntilFutureLocal(
  DateTime dueLocal,
  RepeatType repeat,
  DateTime nowLocal, {
  int? anchorDay,
  int? anchorMonth,
  int maxIterations = 365,
}) {
  if (repeat == RepeatType.once) return dueLocal;
  var cursor = dueLocal;
  var i = 0;
  while (!cursor.isAfter(nowLocal) && i < maxIterations) {
    cursor = nextOccurrenceLocal(
      cursor,
      repeat,
      anchorDay: anchorDay,
      anchorMonth: anchorMonth,
    );
    i++;
  }
  return cursor;
}
