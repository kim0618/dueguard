import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/generated/app_localizations.dart';

String formatRelativeDate(DateTime dueAt, AppLocalizations l10n) {
  final local = dueAt.toLocal();
  final today = DateUtils.dateOnly(DateTime.now());
  final due = DateUtils.dateOnly(local);
  final diff = due.difference(today).inDays;

  if (diff == 0) return l10n.date_relative_today;
  if (diff == 1) return l10n.date_relative_tomorrow;
  if (diff == 2) return l10n.date_relative_day_after_tomorrow;
  if (diff > 2) return l10n.date_relative_in_n_days(diff);
  return l10n.date_relative_overdue(-diff);
}

String formatFullDateTime(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('y년 M월 d일 (E) a h:mm', 'ko').format(local);
  }
  return DateFormat('EEE, MMM d, y  h:mm a', 'en').format(local);
}

String formatDateOnly(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('M월 d일 (E)', 'ko').format(local);
  }
  return DateFormat('EEE, MMM d', 'en').format(local);
}

String formatTimeOnly(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('a h:mm', 'ko').format(local);
  }
  return DateFormat('h:mm a', 'en').format(local);
}

String formatNotificationBody(DateTime dueAt, String locale) {
  final local = dueAt.toLocal();
  if (locale == 'ko') {
    return DateFormat('M월 d일 a h:mm', 'ko').format(local);
  }
  return DateFormat('MMM d, h:mm a', 'en').format(local);
}

DateTime defaultDueAt() {
  final now = DateTime.now();
  final candidate = DateTime(now.year, now.month, now.day, 9, 0);
  if (candidate.isAfter(now)) return candidate;
  final tomorrow = now.add(const Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 9, 0);
}
