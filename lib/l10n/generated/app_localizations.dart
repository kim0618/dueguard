import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ko'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ko, this message translates to:
  /// **'DueGuard'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'놓치면 돈 나가는 일정만 지켜드립니다'**
  String get appSubtitle;

  /// No description provided for @home_title.
  ///
  /// In ko, this message translates to:
  /// **'DueGuard'**
  String get home_title;

  /// No description provided for @item_add_title.
  ///
  /// In ko, this message translates to:
  /// **'항목 추가'**
  String get item_add_title;

  /// No description provided for @item_edit_title.
  ///
  /// In ko, this message translates to:
  /// **'항목 수정'**
  String get item_edit_title;

  /// No description provided for @item_detail_title.
  ///
  /// In ko, this message translates to:
  /// **'상세 정보'**
  String get item_detail_title;

  /// No description provided for @settings_title.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings_title;

  /// No description provided for @save_button.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get save_button;

  /// No description provided for @cancel_button.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel_button;

  /// No description provided for @delete_button.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete_button;

  /// No description provided for @edit_button.
  ///
  /// In ko, this message translates to:
  /// **'수정'**
  String get edit_button;

  /// No description provided for @done_button.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get done_button;

  /// No description provided for @add_item_fab.
  ///
  /// In ko, this message translates to:
  /// **'항목 추가'**
  String get add_item_fab;

  /// No description provided for @mark_done_button.
  ///
  /// In ko, this message translates to:
  /// **'완료 처리'**
  String get mark_done_button;

  /// No description provided for @mark_done_confirm_title.
  ///
  /// In ko, this message translates to:
  /// **'완료 처리하시겠어요?'**
  String get mark_done_confirm_title;

  /// No description provided for @mark_done_confirm_body_repeat.
  ///
  /// In ko, this message translates to:
  /// **'다음 회차가 자동으로 설정됩니다.'**
  String get mark_done_confirm_body_repeat;

  /// No description provided for @mark_done_confirm_body_once.
  ///
  /// In ko, this message translates to:
  /// **'이 항목이 완료 처리됩니다.'**
  String get mark_done_confirm_body_once;

  /// No description provided for @delete_confirm_title.
  ///
  /// In ko, this message translates to:
  /// **'삭제하시겠어요?'**
  String get delete_confirm_title;

  /// No description provided for @delete_confirm_body.
  ///
  /// In ko, this message translates to:
  /// **'삭제하면 알림도 함께 취소됩니다. 되돌릴 수 없어요.'**
  String get delete_confirm_body;

  /// No description provided for @delete_confirm_cta.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete_confirm_cta;

  /// No description provided for @notification_permission_banner.
  ///
  /// In ko, this message translates to:
  /// **'알림이 꺼져 있어요. 이 앱은 알림이 핵심입니다.'**
  String get notification_permission_banner;

  /// No description provided for @notification_permission_allow_button.
  ///
  /// In ko, this message translates to:
  /// **'허용하기'**
  String get notification_permission_allow_button;

  /// No description provided for @notification_scheduled_label.
  ///
  /// In ko, this message translates to:
  /// **'다음 알림: {datetime}'**
  String notification_scheduled_label(String datetime);

  /// No description provided for @home_empty_title.
  ///
  /// In ko, this message translates to:
  /// **'아직 등록된 항목이 없어요'**
  String get home_empty_title;

  /// No description provided for @home_empty_body.
  ///
  /// In ko, this message translates to:
  /// **'카드 대금, 구독 갱신, 보험 날짜 - 잊기 전에 등록해두세요.'**
  String get home_empty_body;

  /// No description provided for @home_no_upcoming_title.
  ///
  /// In ko, this message translates to:
  /// **'당분간 예정된 항목이 없어요'**
  String get home_no_upcoming_title;

  /// No description provided for @home_no_upcoming_body.
  ///
  /// In ko, this message translates to:
  /// **'30일 이내에 예정된 일정이 없습니다. 모든 항목은 목록 아래에서 확인할 수 있어요.'**
  String get home_no_upcoming_body;

  /// No description provided for @item_no_notification_title.
  ///
  /// In ko, this message translates to:
  /// **'알림을 예약할 수 없어요'**
  String get item_no_notification_title;

  /// No description provided for @item_no_notification_body.
  ///
  /// In ko, this message translates to:
  /// **'선택한 날짜가 이미 지났거나, 알림 권한이 없습니다. 날짜를 확인해 주세요.'**
  String get item_no_notification_body;

  /// No description provided for @settings_notification_off_title.
  ///
  /// In ko, this message translates to:
  /// **'알림 권한이 꺼져 있어요'**
  String get settings_notification_off_title;

  /// No description provided for @settings_notification_off_body.
  ///
  /// In ko, this message translates to:
  /// **'DueGuard는 알림이 핵심입니다. 알림을 허용해야 날짜를 제때 받을 수 있어요.'**
  String get settings_notification_off_body;

  /// No description provided for @settings_notification_section.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get settings_notification_section;

  /// No description provided for @settings_about_section.
  ///
  /// In ko, this message translates to:
  /// **'앱 정보'**
  String get settings_about_section;

  /// No description provided for @category_card.
  ///
  /// In ko, this message translates to:
  /// **'카드/결제'**
  String get category_card;

  /// No description provided for @category_subscription.
  ///
  /// In ko, this message translates to:
  /// **'구독'**
  String get category_subscription;

  /// No description provided for @category_utility.
  ///
  /// In ko, this message translates to:
  /// **'공과금/관리비'**
  String get category_utility;

  /// No description provided for @category_tax.
  ///
  /// In ko, this message translates to:
  /// **'세금'**
  String get category_tax;

  /// No description provided for @category_insurance.
  ///
  /// In ko, this message translates to:
  /// **'보험'**
  String get category_insurance;

  /// No description provided for @category_loan.
  ///
  /// In ko, this message translates to:
  /// **'대출/이자'**
  String get category_loan;

  /// No description provided for @category_other.
  ///
  /// In ko, this message translates to:
  /// **'기타'**
  String get category_other;

  /// No description provided for @repeat_once.
  ///
  /// In ko, this message translates to:
  /// **'1회'**
  String get repeat_once;

  /// No description provided for @repeat_daily.
  ///
  /// In ko, this message translates to:
  /// **'매일'**
  String get repeat_daily;

  /// No description provided for @repeat_weekly.
  ///
  /// In ko, this message translates to:
  /// **'매주'**
  String get repeat_weekly;

  /// No description provided for @repeat_monthly.
  ///
  /// In ko, this message translates to:
  /// **'매달'**
  String get repeat_monthly;

  /// No description provided for @repeat_yearly.
  ///
  /// In ko, this message translates to:
  /// **'매년'**
  String get repeat_yearly;

  /// No description provided for @item_title_label.
  ///
  /// In ko, this message translates to:
  /// **'항목 이름'**
  String get item_title_label;

  /// No description provided for @item_title_hint.
  ///
  /// In ko, this message translates to:
  /// **'예: OO카드 결제일, 넷플릭스 해지'**
  String get item_title_hint;

  /// No description provided for @item_date_label.
  ///
  /// In ko, this message translates to:
  /// **'날짜 및 시간'**
  String get item_date_label;

  /// No description provided for @item_category_label.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get item_category_label;

  /// No description provided for @item_repeat_label.
  ///
  /// In ko, this message translates to:
  /// **'반복'**
  String get item_repeat_label;

  /// No description provided for @item_note_label.
  ///
  /// In ko, this message translates to:
  /// **'메모 (선택)'**
  String get item_note_label;

  /// No description provided for @item_note_hint.
  ///
  /// In ko, this message translates to:
  /// **'추가로 기억할 내용'**
  String get item_note_hint;

  /// No description provided for @error_title_required.
  ///
  /// In ko, this message translates to:
  /// **'항목 이름을 입력해 주세요'**
  String get error_title_required;

  /// No description provided for @error_date_required.
  ///
  /// In ko, this message translates to:
  /// **'날짜를 선택해 주세요'**
  String get error_date_required;

  /// No description provided for @error_date_past.
  ///
  /// In ko, this message translates to:
  /// **'이미 지난 날짜입니다. 알림을 받으려면 미래 날짜를 선택하세요.'**
  String get error_date_past;

  /// No description provided for @error_save_failed.
  ///
  /// In ko, this message translates to:
  /// **'저장에 실패했습니다. 다시 시도해 주세요.'**
  String get error_save_failed;

  /// No description provided for @error_delete_failed.
  ///
  /// In ko, this message translates to:
  /// **'삭제에 실패했습니다. 다시 시도해 주세요.'**
  String get error_delete_failed;

  /// No description provided for @toast_item_saved.
  ///
  /// In ko, this message translates to:
  /// **'저장됐습니다'**
  String get toast_item_saved;

  /// No description provided for @toast_item_deleted.
  ///
  /// In ko, this message translates to:
  /// **'삭제됐습니다'**
  String get toast_item_deleted;

  /// No description provided for @toast_item_done.
  ///
  /// In ko, this message translates to:
  /// **'완료 처리됐습니다'**
  String get toast_item_done;

  /// No description provided for @toast_next_scheduled.
  ///
  /// In ko, this message translates to:
  /// **'다음 회차가 설정됐습니다'**
  String get toast_next_scheduled;

  /// No description provided for @toast_notification_set.
  ///
  /// In ko, this message translates to:
  /// **'알림이 예약됐습니다'**
  String get toast_notification_set;

  /// No description provided for @toast_notification_failed.
  ///
  /// In ko, this message translates to:
  /// **'알림 예약에 실패했습니다. 권한을 확인해 주세요.'**
  String get toast_notification_failed;

  /// No description provided for @date_relative_today.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get date_relative_today;

  /// No description provided for @date_relative_tomorrow.
  ///
  /// In ko, this message translates to:
  /// **'내일'**
  String get date_relative_tomorrow;

  /// No description provided for @date_relative_day_after_tomorrow.
  ///
  /// In ko, this message translates to:
  /// **'모레'**
  String get date_relative_day_after_tomorrow;

  /// No description provided for @date_relative_in_n_days.
  ///
  /// In ko, this message translates to:
  /// **'{n}일 뒤'**
  String date_relative_in_n_days(int n);

  /// No description provided for @date_relative_overdue.
  ///
  /// In ko, this message translates to:
  /// **'{n}일 지남'**
  String date_relative_overdue(int n);

  /// No description provided for @about_app_version.
  ///
  /// In ko, this message translates to:
  /// **'버전 {version}'**
  String about_app_version(String version);

  /// No description provided for @about_app_description.
  ///
  /// In ko, this message translates to:
  /// **'DueGuard는 놓치면 돈이 나가는 일정을 알려주는 앱입니다.'**
  String get about_app_description;

  /// No description provided for @about_open_source.
  ///
  /// In ko, this message translates to:
  /// **'오픈소스 라이선스'**
  String get about_open_source;

  /// No description provided for @section_today.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get section_today;

  /// No description provided for @section_this_week.
  ///
  /// In ko, this message translates to:
  /// **'이번 주'**
  String get section_this_week;

  /// No description provided for @section_upcoming.
  ///
  /// In ko, this message translates to:
  /// **'예정'**
  String get section_upcoming;

  /// No description provided for @completed_count_none.
  ///
  /// In ko, this message translates to:
  /// **'아직 완료 없음'**
  String get completed_count_none;

  /// No description provided for @completed_count_n.
  ///
  /// In ko, this message translates to:
  /// **'{n}회 완료'**
  String completed_count_n(int n);

  /// No description provided for @last_completed_label.
  ///
  /// In ko, this message translates to:
  /// **'마지막 완료'**
  String get last_completed_label;

  /// No description provided for @next_notification_label.
  ///
  /// In ko, this message translates to:
  /// **'다음 알림'**
  String get next_notification_label;

  /// No description provided for @repeat_label.
  ///
  /// In ko, this message translates to:
  /// **'반복'**
  String get repeat_label;

  /// No description provided for @note_label.
  ///
  /// In ko, this message translates to:
  /// **'메모'**
  String get note_label;

  /// No description provided for @date_time_label.
  ///
  /// In ko, this message translates to:
  /// **'날짜 및 시간'**
  String get date_time_label;

  /// No description provided for @notification_not_scheduled.
  ///
  /// In ko, this message translates to:
  /// **'알림 없음'**
  String get notification_not_scheduled;

  /// No description provided for @notification_permission_required.
  ///
  /// In ko, this message translates to:
  /// **'알림 권한이 필요합니다'**
  String get notification_permission_required;

  /// No description provided for @onboarding_a_title.
  ///
  /// In ko, this message translates to:
  /// **'돈 나가는 날짜, 여기에 모아두세요'**
  String get onboarding_a_title;

  /// No description provided for @onboarding_a_body.
  ///
  /// In ko, this message translates to:
  /// **'카드 대금, 자동결제, 보험 갱신일 - 직접 관리하지 않으면 계속 잊어버립니다.'**
  String get onboarding_a_body;

  /// No description provided for @onboarding_a_cta.
  ///
  /// In ko, this message translates to:
  /// **'첫 항목 추가하기'**
  String get onboarding_a_cta;

  /// No description provided for @confirm_discard_title.
  ///
  /// In ko, this message translates to:
  /// **'저장하지 않고 나가시겠어요?'**
  String get confirm_discard_title;

  /// No description provided for @confirm_discard_body.
  ///
  /// In ko, this message translates to:
  /// **'입력한 내용이 사라집니다.'**
  String get confirm_discard_body;

  /// No description provided for @confirm_discard_cta.
  ///
  /// In ko, this message translates to:
  /// **'나가기'**
  String get confirm_discard_cta;

  /// No description provided for @past_time_once_confirm_title.
  ///
  /// In ko, this message translates to:
  /// **'이미 지난 시각입니다'**
  String get past_time_once_confirm_title;

  /// No description provided for @past_time_once_confirm_body.
  ///
  /// In ko, this message translates to:
  /// **'알림은 예약되지 않습니다. 그래도 저장하시겠어요?'**
  String get past_time_once_confirm_body;

  /// No description provided for @past_time_once_confirm_cta.
  ///
  /// In ko, this message translates to:
  /// **'그대로 저장'**
  String get past_time_once_confirm_cta;

  /// No description provided for @badge_overdue.
  ///
  /// In ko, this message translates to:
  /// **'기한 지남'**
  String get badge_overdue;

  /// No description provided for @badge_notification_on.
  ///
  /// In ko, this message translates to:
  /// **'알림 예약됨'**
  String get badge_notification_on;

  /// No description provided for @badge_notification_off.
  ///
  /// In ko, this message translates to:
  /// **'알림 없음'**
  String get badge_notification_off;

  /// No description provided for @notification_body_prefix.
  ///
  /// In ko, this message translates to:
  /// **'마감'**
  String get notification_body_prefix;

  /// No description provided for @home_permission_banner_title.
  ///
  /// In ko, this message translates to:
  /// **'알림이 꺼져 있어요'**
  String get home_permission_banner_title;

  /// No description provided for @settings_permission_allowed.
  ///
  /// In ko, this message translates to:
  /// **'허용됨'**
  String get settings_permission_allowed;

  /// No description provided for @settings_permission_denied.
  ///
  /// In ko, this message translates to:
  /// **'꺼져 있음'**
  String get settings_permission_denied;

  /// No description provided for @settings_notification_open_settings.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정 열기'**
  String get settings_notification_open_settings;

  /// No description provided for @form_section_basic.
  ///
  /// In ko, this message translates to:
  /// **'기본 정보'**
  String get form_section_basic;

  /// No description provided for @form_section_schedule.
  ///
  /// In ko, this message translates to:
  /// **'일정 정보'**
  String get form_section_schedule;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
