import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../features/item/reminder_item.dart';
import '../../../features/item/reminder_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/category_utils.dart';
import '../../../shared/utils/date_utils.dart' as du;
import '../../item/screens/item_detail_screen.dart';
import '../../item/screens/item_form_screen.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<ReminderItem>> _groupByDay(List<ReminderItem> items) {
    final map = <DateTime, List<ReminderItem>>{};
    for (final i in items) {
      final d = DateUtils.dateOnly(i.dueAt.toLocal());
      map.putIfAbsent(d, () => []).add(i);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final itemsAsync = ref.watch(upcomingRemindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendar_title),
        leading: const BackButton(),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (items) {
          final byDay = _groupByDay(items);

          return Column(
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: TableCalendar<ReminderItem>(
                  locale: locale,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2035, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) =>
                      _selectedDay != null && isSameDay(_selectedDay!, day),
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: '월',
                  },
                  rowHeight: 78,
                  daysOfWeekHeight: 28,
                  eventLoader: (day) =>
                      byDay[DateUtils.dateOnly(day)] ?? const [],
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                      letterSpacing: -0.4,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left,
                        color: AppTheme.textSecondary, size: 22),
                    rightChevronIcon: Icon(Icons.chevron_right,
                        color: AppTheme.textSecondary, size: 22),
                    headerPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                    weekendStyle: TextStyle(
                      color: AppTheme.todayAccent.withValues(alpha: 0.85),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.dividerLight,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    cellMargin: EdgeInsets.zero,
                    cellPadding: EdgeInsets.zero,
                    markersMaxCount: 0,
                  ),
                  calendarBuilders: CalendarBuilders<ReminderItem>(
                    markerBuilder: (_, __, ___) => const SizedBox.shrink(),
                    defaultBuilder: (context, day, _) =>
                        _DayCell(day: day, events: byDay[DateUtils.dateOnly(day)] ?? const []),
                    todayBuilder: (context, day, _) => _DayCell(
                        day: day,
                        events: byDay[DateUtils.dateOnly(day)] ?? const [],
                        isToday: true),
                    selectedBuilder: (context, day, _) => _DayCell(
                        day: day,
                        events: byDay[DateUtils.dateOnly(day)] ?? const [],
                        isSelected: true),
                    outsideBuilder: (context, day, _) => _DayCell(
                        day: day,
                        events: byDay[DateUtils.dateOnly(day)] ?? const [],
                        isOutside: true),
                  ),
                  onDaySelected: (selected, focused) async {
                    setState(() {
                      _selectedDay = DateUtils.dateOnly(selected);
                      _focusedDay = focused;
                    });
                    final dayEvents =
                        byDay[DateUtils.dateOnly(selected)] ?? const [];
                    if (dayEvents.length == 1) {
                      await _openDetail(dayEvents.first.id);
                    } else if (dayEvents.length > 1) {
                      _showDaySheet(context, selected, dayEvents);
                    }
                  },
                  onPageChanged: (focused) {
                    _focusedDay = focused;
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ItemFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openDetail(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemDetailScreen(itemId: id)),
    );
    ref.invalidate(reminderByIdProvider(id));
  }

  void _showDaySheet(
      BuildContext context, DateTime day, List<ReminderItem> events) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateLabel = du.formatDateOnly(day, locale);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${events.length}',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, i) {
                    final e = events[i];
                    return InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.pop(ctx);
                        _openDetail(e.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: categoryBgColor(e.category),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Icon(
                                categoryIcon(e.category),
                                color: categoryFgColor(e.category),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    du.formatTimeOnly(
                                        e.dueAt, locale),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.events,
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
  });

  final DateTime day;
  final List<ReminderItem> events;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;

  Color _dateColor() {
    if (isOutside) return AppTheme.textTertiary;
    if (isToday) return AppTheme.primary;
    if (day.weekday == DateTime.sunday) return AppTheme.todayAccent;
    if (day.weekday == DateTime.saturday) return AppTheme.infoAccent;
    return AppTheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    final visibleEvents = events.take(2).toList();
    final overflow = events.length - visibleEvents.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        border: isToday && !isSelected
            ? Border.all(color: AppTheme.primary, width: 1.2)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3, bottom: 2),
            child: Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _dateColor().withValues(alpha: isOutside ? 0.5 : 1.0),
              ),
            ),
          ),
          ...visibleEvents.map((e) => _EventChip(event: e, isOutside: isOutside)),
          if (overflow > 0)
            Container(
              margin: const EdgeInsets.only(top: 1),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: BoxDecoration(
                color: AppTheme.primary
                    .withValues(alpha: isOutside ? 0.04 : 0.08),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                '+$overflow',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary
                      .withValues(alpha: isOutside ? 0.4 : 0.75),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EventChip extends StatelessWidget {
  const _EventChip({required this.event, required this.isOutside});

  final ReminderItem event;
  final bool isOutside;

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    final due = DateUtils.dateOnly(event.dueAt.toLocal());
    final diff = due.difference(today).inDays;

    final Color barColor;
    if (diff <= 0) {
      barColor = AppTheme.todayAccent;
    } else if (diff == 1) {
      barColor = AppTheme.warnAccent;
    } else {
      barColor = AppTheme.infoAccent;
    }

    final opacity = isOutside ? 0.45 : 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      height: 14,
      decoration: BoxDecoration(
        color: categoryBgColor(event.category).withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Container(
            width: 2,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: barColor.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              event.title,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color:
                    categoryFgColor(event.category).withValues(alpha: opacity),
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
