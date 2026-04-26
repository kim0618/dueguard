import 'package:flutter/material.dart';
import '../../features/item/reminder_item.dart';
import '../../l10n/generated/app_localizations.dart';

Color categoryBgColor(Category category) {
  switch (category) {
    case Category.card:       return const Color(0xFFEAF1FF);
    case Category.subscription: return const Color(0xFFF2EAFE);
    case Category.utility:    return const Color(0xFFEAF7F0);
    case Category.tax:        return const Color(0xFFFFF4E5);
    case Category.insurance:  return const Color(0xFFEAF4FF);
    case Category.loan:       return const Color(0xFFFFF0F2);
    case Category.other:      return const Color(0xFFF3F5F9);
  }
}

Color categoryFgColor(Category category) {
  switch (category) {
    case Category.card:       return const Color(0xFF3563E9);
    case Category.subscription: return const Color(0xFF7C3AED);
    case Category.utility:    return const Color(0xFF1F8F55);
    case Category.tax:        return const Color(0xFFC76B00);
    case Category.insurance:  return const Color(0xFF2D6CDF);
    case Category.loan:       return const Color(0xFFD94A68);
    case Category.other:      return const Color(0xFF667085);
  }
}

IconData categoryIcon(Category category) {
  switch (category) {
    case Category.card:
      return Icons.credit_card;
    case Category.subscription:
      return Icons.subscriptions;
    case Category.utility:
      return Icons.bolt;
    case Category.tax:
      return Icons.receipt_long;
    case Category.insurance:
      return Icons.shield;
    case Category.loan:
      return Icons.account_balance;
    case Category.other:
      return Icons.label;
  }
}

String categoryLabel(Category category, AppLocalizations l10n) {
  switch (category) {
    case Category.card:
      return l10n.category_card;
    case Category.subscription:
      return l10n.category_subscription;
    case Category.utility:
      return l10n.category_utility;
    case Category.tax:
      return l10n.category_tax;
    case Category.insurance:
      return l10n.category_insurance;
    case Category.loan:
      return l10n.category_loan;
    case Category.other:
      return l10n.category_other;
  }
}

String repeatLabel(RepeatType repeat, AppLocalizations l10n) {
  switch (repeat) {
    case RepeatType.once:
      return l10n.repeat_once;
    case RepeatType.daily:
      return l10n.repeat_daily;
    case RepeatType.weekly:
      return l10n.repeat_weekly;
    case RepeatType.monthly:
      return l10n.repeat_monthly;
    case RepeatType.yearly:
      return l10n.repeat_yearly;
  }
}
