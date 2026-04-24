import 'package:dueguard/features/item/reminder_item.dart';
import 'package:dueguard/features/item/repeat_rule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('daysInMonth', () {
    test('Feb 2024 (leap)', () => expect(daysInMonth(2024, 2), 29));
    test('Feb 2025 (non-leap)', () => expect(daysInMonth(2025, 2), 28));
    test('Apr 2026', () => expect(daysInMonth(2026, 4), 30));
    test('Jan 2026', () => expect(daysInMonth(2026, 1), 31));
    test('Dec 2026', () => expect(daysInMonth(2026, 12), 31));
  });

  group('nextOccurrenceLocal - basic', () {
    test('once returns same', () {
      final d = DateTime(2026, 5, 1, 9, 0);
      expect(nextOccurrenceLocal(d, RepeatType.once), d);
    });
    test('daily adds 1 day', () {
      final d = DateTime(2026, 5, 1, 9, 0);
      expect(nextOccurrenceLocal(d, RepeatType.daily), DateTime(2026, 5, 2, 9, 0));
    });
    test('weekly adds 7 days', () {
      final d = DateTime(2026, 5, 1, 9, 0);
      expect(nextOccurrenceLocal(d, RepeatType.weekly), DateTime(2026, 5, 8, 9, 0));
    });
    test('monthly basic 15th', () {
      final d = DateTime(2026, 4, 15, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 15),
        DateTime(2026, 5, 15, 9, 0),
      );
    });
    test('yearly basic 7/20', () {
      final d = DateTime(2026, 7, 20, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.yearly, anchorDay: 20, anchorMonth: 7),
        DateTime(2027, 7, 20, 9, 0),
      );
    });
    test('daily keeps time of day', () {
      final d = DateTime(2026, 5, 1, 13, 45);
      expect(
        nextOccurrenceLocal(d, RepeatType.daily),
        DateTime(2026, 5, 2, 13, 45),
      );
    });
  });

  group('monthly edge cases (doc 3-1..3-4, 3-7)', () {
    test('3-1: 31st to 30-day April', () {
      final d = DateTime(2026, 3, 31, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 31),
        DateTime(2026, 4, 30, 9, 0),
      );
    });
    test('3-2: 31st to February non-leap', () {
      final d = DateTime(2026, 1, 31, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 31),
        DateTime(2026, 2, 28, 9, 0),
      );
    });
    test('3-3: 31st to February leap', () {
      final d = DateTime(2028, 1, 31, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 31),
        DateTime(2028, 2, 29, 9, 0),
      );
    });
    test('3-4: after clamped 4/30 returns to 31 in May', () {
      final d = DateTime(2026, 4, 30, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 31),
        DateTime(2026, 5, 31, 9, 0),
      );
    });
    test('3-7: monthly 30 to February clamps to 28', () {
      final d = DateTime(2026, 1, 30, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 30),
        DateTime(2026, 2, 28, 9, 0),
      );
    });
    test('month rollover Dec -> Jan next year', () {
      final d = DateTime(2026, 12, 15, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 15),
        DateTime(2027, 1, 15, 9, 0),
      );
    });
  });

  group('yearly edge cases (doc 3-5..3-6)', () {
    test('3-5: Feb 29 leap to next year clamps to Feb 28', () {
      final d = DateTime(2024, 2, 29, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.yearly, anchorDay: 29, anchorMonth: 2),
        DateTime(2025, 2, 28, 9, 0),
      );
    });
    test('3-6: after clamped year, next leap year returns to 2/29', () {
      final d = DateTime(2027, 2, 28, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.yearly, anchorDay: 29, anchorMonth: 2),
        DateTime(2028, 2, 29, 9, 0),
      );
    });
    test('yearly simple Jan 1', () {
      final d = DateTime(2026, 1, 1, 9, 0);
      expect(
        nextOccurrenceLocal(d, RepeatType.yearly, anchorDay: 1, anchorMonth: 1),
        DateTime(2027, 1, 1, 9, 0),
      );
    });
  });

  group('advanceUntilFutureLocal', () {
    test('already future returns same', () {
      final d = DateTime(2100, 1, 1, 9, 0);
      final now = DateTime(2026, 4, 24, 12, 0);
      expect(
        advanceUntilFutureLocal(d, RepeatType.daily, now),
        d,
      );
    });
    test('once never advances', () {
      final d = DateTime(2020, 1, 1, 9, 0);
      final now = DateTime(2026, 4, 24, 12, 0);
      expect(advanceUntilFutureLocal(d, RepeatType.once, now), d);
    });
    test('daily past advances to future', () {
      final d = DateTime(2026, 4, 20, 9, 0);
      final now = DateTime(2026, 4, 24, 12, 0);
      final result = advanceUntilFutureLocal(d, RepeatType.daily, now);
      expect(result.isAfter(now), isTrue);
      expect(result, DateTime(2026, 4, 25, 9, 0));
    });
    test('monthly past 30 days skipped advances through clamps', () {
      final d = DateTime(2026, 1, 31, 9, 0);
      final now = DateTime(2026, 5, 1, 12, 0);
      final result = advanceUntilFutureLocal(
        d,
        RepeatType.monthly,
        now,
        anchorDay: 31,
      );
      expect(result.isAfter(now), isTrue);
      expect(result, DateTime(2026, 5, 31, 9, 0));
    });
    test('weekly advances', () {
      final d = DateTime(2026, 4, 1, 9, 0);
      final now = DateTime(2026, 4, 24, 12, 0);
      final result = advanceUntilFutureLocal(d, RepeatType.weekly, now);
      expect(result.isAfter(now), isTrue);
      expect(result.weekday, d.weekday);
    });
    test('yearly past advances past now', () {
      final d = DateTime(2020, 5, 1, 9, 0);
      final now = DateTime(2026, 4, 24, 12, 0);
      final result = advanceUntilFutureLocal(
        d,
        RepeatType.yearly,
        now,
        anchorDay: 1,
        anchorMonth: 5,
      );
      expect(result.isAfter(now), isTrue);
      expect(result, DateTime(2026, 5, 1, 9, 0));
    });
  });

  group('anchor not supplied falls back to current day', () {
    test('monthly without anchor clamps but does not restore', () {
      final d = DateTime(2026, 3, 31, 9, 0);
      final once = nextOccurrenceLocal(d, RepeatType.monthly);
      expect(once, DateTime(2026, 4, 30, 9, 0));
      final twice = nextOccurrenceLocal(once, RepeatType.monthly);
      expect(twice, DateTime(2026, 5, 30, 9, 0));
    });
    test('monthly with anchor restores', () {
      final d = DateTime(2026, 3, 31, 9, 0);
      final once = nextOccurrenceLocal(d, RepeatType.monthly, anchorDay: 31);
      expect(once, DateTime(2026, 4, 30, 9, 0));
      final twice = nextOccurrenceLocal(once, RepeatType.monthly, anchorDay: 31);
      expect(twice, DateTime(2026, 5, 31, 9, 0));
    });
  });
}
