import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dueguard/l10n/generated/app_localizations.dart';
import 'package:dueguard/features/item/reminder_item.dart';
import 'package:dueguard/shared/utils/date_utils.dart';

ReminderItem _item({
  required RepeatType repeat,
  required DateTime dueAt,
  int? anchorDay,
  int? anchorMonth,
}) {
  final i = ReminderItem();
  i.title = 'test';
  i.category = Category.card;
  i.repeatType = repeat;
  i.dueAt = dueAt;
  i.anchorDay = anchorDay;
  i.anchorMonth = anchorMonth;
  i.createdAt = dueAt;
  i.updatedAt = dueAt;
  return i;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late AppLocalizations ko;
  late AppLocalizations en;

  setUpAll(() async {
    await initializeDateFormatting('ko');
    await initializeDateFormatting('en');
    ko = await AppLocalizations.delegate.load(const Locale('ko'));
    en = await AppLocalizations.delegate.load(const Locale('en'));
  });

  // 2026-04-27은 월요일, 오후 4:45
  final monday = DateTime(2026, 4, 27, 16, 45);

  group('ko 표시', () {
    test('once는 절대 날짜시간', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.once, dueAt: monday), ko, 'ko');
      expect(s, contains('2026'));
      expect(s, contains('4월 27일'));
    });

    test('daily는 "매일 + 시각"', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.daily, dueAt: monday), ko, 'ko');
      expect(s, startsWith('매일'));
      expect(s, contains('4:45'));
      expect(s, isNot(contains('27일'))); // 날짜는 안 나와야 함
    });

    test('weekly는 "매주 + 요일"', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.weekly, dueAt: monday), ko, 'ko');
      expect(s, startsWith('매주'));
      expect(s, contains('월요일'));
    });

    test('monthly는 "매달 N일", anchorDay 우선', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.monthly, dueAt: monday, anchorDay: 31),
          ko,
          'ko');
      expect(s, startsWith('매달'));
      expect(s, contains('31일')); // dueAt.day(27)가 아니라 anchorDay(31)
    });

    test('monthly anchorDay 없으면 dueAt.day로 fallback', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.monthly, dueAt: monday), ko, 'ko');
      expect(s, contains('27일'));
    });

    test('yearly는 "매년 M월 N일", anchor 우선', () {
      final s = formatRepeatSchedule(
          _item(
              repeat: RepeatType.yearly,
              dueAt: monday,
              anchorDay: 25,
              anchorMonth: 12),
          ko,
          'ko');
      expect(s, startsWith('매년'));
      expect(s, contains('12월'));
      expect(s, contains('25일'));
    });

    test('yearly anchor 없으면 dueAt로 fallback', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.yearly, dueAt: monday), ko, 'ko');
      expect(s, contains('4월'));
      expect(s, contains('27일'));
    });
  });

  group('en 회귀', () {
    test('daily', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.daily, dueAt: monday), en, 'en');
      expect(s, startsWith('Daily'));
    });

    test('weekly에 요일명', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.weekly, dueAt: monday), en, 'en');
      expect(s, contains('Monday'));
    });

    test('monthly', () {
      final s = formatRepeatSchedule(
          _item(repeat: RepeatType.monthly, dueAt: monday, anchorDay: 15),
          en,
          'en');
      expect(s, contains('15'));
    });
  });
}
