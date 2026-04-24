import 'package:flutter/material.dart';
import '../../features/item/reminder_item.dart';
import '../../l10n/generated/app_localizations.dart';

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
