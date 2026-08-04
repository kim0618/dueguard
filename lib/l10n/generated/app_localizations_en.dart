// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DueGuard';

  @override
  String get appSubtitle => 'Guard the dates that cost you money';

  @override
  String get home_title => 'DueGuard';

  @override
  String get item_add_title => 'New Item';

  @override
  String get item_edit_title => 'Edit Item';

  @override
  String get item_detail_title => 'Item Detail';

  @override
  String get settings_title => 'Settings';

  @override
  String get save_button => 'Save';

  @override
  String get cancel_button => 'Cancel';

  @override
  String get undo_button => 'Undo';

  @override
  String get delete_button => 'Delete';

  @override
  String get edit_button => 'Edit';

  @override
  String get done_button => 'Done';

  @override
  String get add_item_fab => 'Add Item';

  @override
  String get mark_done_button => 'Mark as done';

  @override
  String get mark_done_confirm_title => 'Mark as done?';

  @override
  String get mark_done_confirm_body_repeat =>
      'The next occurrence will be scheduled automatically.';

  @override
  String get mark_done_confirm_body_once => 'This item will be marked as done.';

  @override
  String get delete_confirm_title => 'Delete this item?';

  @override
  String get delete_confirm_body =>
      'The notification will also be cancelled. This cannot be undone.';

  @override
  String get delete_confirm_cta => 'Delete';

  @override
  String get notification_permission_banner =>
      'Notifications are off. This app relies on notifications.';

  @override
  String get notification_permission_allow_button => 'Allow';

  @override
  String notification_scheduled_label(String datetime) {
    return 'Next alert: $datetime';
  }

  @override
  String get home_empty_title => 'No items yet';

  @override
  String get home_empty_body =>
      'Add card bills, subscriptions, or insurance dates before they slip by.';

  @override
  String get preset_quick_add_label => 'Try starting with one of these';

  @override
  String get preset_card_bill => 'Card payment date';

  @override
  String get preset_netflix => 'Netflix subscription';

  @override
  String get preset_car_tax => 'Vehicle tax (June)';

  @override
  String get preset_income_tax => 'Income tax filing (May)';

  @override
  String get home_no_upcoming_title => 'Nothing coming up soon';

  @override
  String get home_no_upcoming_body =>
      'Nothing scheduled in the next 30 days. All items are shown below.';

  @override
  String get item_no_notification_title =>
      'Notification could not be scheduled';

  @override
  String get item_no_notification_body =>
      'The selected date has passed, or notification permission is missing. Please check the date.';

  @override
  String get settings_notification_off_title => 'Notifications are off';

  @override
  String get settings_notification_off_body =>
      'DueGuard relies on notifications. Enable them to receive timely reminders.';

  @override
  String get settings_notification_section => 'Notifications';

  @override
  String get settings_about_section => 'About';

  @override
  String get category_card => 'Card';

  @override
  String get category_subscription => 'Subscription';

  @override
  String get category_utility => 'Utility';

  @override
  String get category_tax => 'Tax';

  @override
  String get category_insurance => 'Insurance';

  @override
  String get category_loan => 'Loan';

  @override
  String get category_other => 'Other';

  @override
  String get repeat_once => 'Once';

  @override
  String get repeat_daily => 'Daily';

  @override
  String get repeat_weekly => 'Weekly';

  @override
  String get repeat_monthly => 'Monthly';

  @override
  String get repeat_yearly => 'Yearly';

  @override
  String repeat_schedule_daily(String time) {
    return 'Daily at $time';
  }

  @override
  String repeat_schedule_weekly(String weekday, String time) {
    return 'Every $weekday at $time';
  }

  @override
  String repeat_schedule_monthly(int day, String time) {
    return 'Monthly on day $day at $time';
  }

  @override
  String repeat_schedule_yearly(int month, int day, String time) {
    return 'Yearly on $month/$day at $time';
  }

  @override
  String next_reminder_prefix(String datetime) {
    return 'Next reminder $datetime';
  }

  @override
  String get item_title_label => 'Item name';

  @override
  String get item_title_hint => 'e.g. Credit card bill, Netflix cancellation';

  @override
  String get item_date_label => 'Date & time';

  @override
  String get item_category_label => 'Category';

  @override
  String get item_repeat_label => 'Repeat';

  @override
  String get item_note_label => 'Note (optional)';

  @override
  String get item_note_hint => 'Additional notes';

  @override
  String get error_title_required => 'Please enter an item name';

  @override
  String get error_date_required => 'Please select a date';

  @override
  String get error_date_past =>
      'This date has already passed. Select a future date to receive a notification.';

  @override
  String get error_save_failed => 'Save failed. Please try again.';

  @override
  String get error_delete_failed => 'Delete failed. Please try again.';

  @override
  String get toast_item_saved => 'Saved';

  @override
  String get toast_item_deleted => 'Deleted';

  @override
  String get toast_item_done => 'Marked as done';

  @override
  String get toast_next_scheduled => 'Next occurrence scheduled';

  @override
  String get toast_notification_set => 'Notification scheduled';

  @override
  String get toast_notification_failed =>
      'Notification scheduling failed. Check permissions.';

  @override
  String get date_relative_today => 'Today';

  @override
  String get date_relative_tomorrow => 'Tomorrow';

  @override
  String get date_relative_day_after_tomorrow => 'Day after tomorrow';

  @override
  String date_relative_in_n_days(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n days',
      one: 'In 1 day',
    );
    return '$_temp0';
  }

  @override
  String date_relative_overdue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days overdue',
      one: '1 day overdue',
    );
    return '$_temp0';
  }

  @override
  String about_app_version(String version) {
    return 'Version $version';
  }

  @override
  String get about_app_description =>
      'DueGuard reminds you of dates that cost money when missed.';

  @override
  String get about_open_source => 'Open-source licenses';

  @override
  String get section_today => 'Today';

  @override
  String get section_this_week => 'This week';

  @override
  String get section_upcoming => 'Upcoming';

  @override
  String get completed_count_none => 'Not completed yet';

  @override
  String completed_count_n(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Completed $n times',
      one: 'Completed 1 time',
    );
    return '$_temp0';
  }

  @override
  String get last_completed_label => 'Last completed';

  @override
  String get next_notification_label => 'Next notification';

  @override
  String get repeat_label => 'Repeat';

  @override
  String get note_label => 'Note';

  @override
  String get date_time_label => 'Date & time';

  @override
  String get notification_not_scheduled => 'No notification';

  @override
  String get notification_permission_required =>
      'Notification permission required';

  @override
  String get onboarding_a_title => 'Keep every money deadline in one place';

  @override
  String get onboarding_a_body =>
      'Card bills, subscriptions, insurance renewals - they slip by if you don\'t track them.';

  @override
  String get onboarding_a_cta => 'Add your first item';

  @override
  String get confirm_discard_title => 'Leave without saving?';

  @override
  String get confirm_discard_body => 'Your changes will be lost.';

  @override
  String get confirm_discard_cta => 'Leave';

  @override
  String get past_time_once_confirm_title => 'This time has already passed';

  @override
  String get past_time_once_confirm_body =>
      'A notification will not be scheduled. Save anyway?';

  @override
  String get past_time_once_confirm_cta => 'Save anyway';

  @override
  String get badge_overdue => 'Overdue';

  @override
  String get badge_notification_on => 'Alert scheduled';

  @override
  String get badge_notification_off => 'No alert';

  @override
  String get notification_body_prefix => 'Due';

  @override
  String get home_permission_banner_title => 'Notifications are off';

  @override
  String get settings_permission_allowed => 'Allowed';

  @override
  String get settings_permission_denied => 'Off';

  @override
  String get settings_notification_open_settings => 'Open system settings';

  @override
  String get form_section_basic => 'Basic info';

  @override
  String get form_section_schedule => 'Schedule';

  @override
  String get home_summary_today => 'Today';

  @override
  String get home_summary_this_week => 'This week';

  @override
  String get home_summary_total => 'Total';

  @override
  String get calendar_title => 'Calendar';

  @override
  String get calendar_no_items_for_day => 'No items for this day';

  @override
  String get history_title => 'Completion history';

  @override
  String get history_subtitle => 'View completed items';

  @override
  String get history_empty => 'No completed items yet';

  @override
  String history_due_prefix(String date) {
    return 'Due $date';
  }

  @override
  String get trash_title => 'Trash';

  @override
  String get trash_subtitle => 'Restore deleted items';

  @override
  String get trash_empty => 'Trash is empty';

  @override
  String get trash_info_banner => 'Deleted items can be restored';

  @override
  String get trash_empty_button => 'Empty';

  @override
  String get trash_restore_tooltip => 'Restore';

  @override
  String get trash_permanent_delete_tooltip => 'Delete permanently';

  @override
  String get trash_restore_toast => 'Restored';

  @override
  String get trash_permanent_delete_title => 'Delete permanently';

  @override
  String get trash_permanent_delete_body =>
      'Permanently delete this item?\nThis cannot be undone.';

  @override
  String get trash_permanent_delete_cta => 'Delete';

  @override
  String get trash_permanent_delete_toast => 'Item permanently deleted';

  @override
  String get trash_empty_confirm_title => 'Empty trash';

  @override
  String get trash_empty_confirm_body =>
      'Delete all items in trash?\nThis cannot be undone.';

  @override
  String get trash_empty_confirm_cta => 'Empty';

  @override
  String get trash_emptied_toast => 'Trash emptied';

  @override
  String trash_deleted_at(String date) {
    return 'Deleted $date';
  }

  @override
  String get settings_records_section => 'Records';

  @override
  String get date_picker_title => 'Date and time';

  @override
  String get date_picker_confirm => 'Confirm';

  @override
  String get settings_language_section => 'Language';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_language_system => 'System default';

  @override
  String get settings_language_korean => '한국어';

  @override
  String get settings_language_english => 'English';
}
