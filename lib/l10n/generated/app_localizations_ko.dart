import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'DueGuard';

  @override
  String get appSubtitle => '놓치면 돈 나가는 일정만 지켜드립니다';

  @override
  String get home_title => 'DueGuard';

  @override
  String get item_add_title => '항목 추가';

  @override
  String get item_edit_title => '항목 수정';

  @override
  String get item_detail_title => '상세 정보';

  @override
  String get settings_title => '설정';

  @override
  String get save_button => '저장';

  @override
  String get cancel_button => '취소';

  @override
  String get delete_button => '삭제';

  @override
  String get edit_button => '수정';

  @override
  String get done_button => '완료';

  @override
  String get add_item_fab => '항목 추가';

  @override
  String get mark_done_button => '완료 처리';

  @override
  String get mark_done_confirm_title => '완료 처리하시겠어요?';

  @override
  String get mark_done_confirm_body_repeat => '다음 회차가 자동으로 설정됩니다.';

  @override
  String get mark_done_confirm_body_once => '이 항목이 완료 처리됩니다.';

  @override
  String get delete_confirm_title => '삭제하시겠어요?';

  @override
  String get delete_confirm_body => '삭제하면 알림도 함께 취소됩니다. 되돌릴 수 없어요.';

  @override
  String get delete_confirm_cta => '삭제';

  @override
  String get notification_permission_banner => '알림이 꺼져 있어요. 이 앱은 알림이 핵심입니다.';

  @override
  String get notification_permission_allow_button => '허용하기';

  @override
  String notification_scheduled_label(String datetime) {
    return '다음 알림: $datetime';
  }

  @override
  String get home_empty_title => '아직 등록된 항목이 없어요';

  @override
  String get home_empty_body => '카드 대금, 구독 갱신, 보험 날짜 - 잊기 전에 등록해두세요.';

  @override
  String get home_no_upcoming_title => '당분간 예정된 항목이 없어요';

  @override
  String get home_no_upcoming_body => '30일 이내에 예정된 일정이 없습니다. 모든 항목은 목록 아래에서 확인할 수 있어요.';

  @override
  String get item_no_notification_title => '알림을 예약할 수 없어요';

  @override
  String get item_no_notification_body => '선택한 날짜가 이미 지났거나, 알림 권한이 없습니다. 날짜를 확인해 주세요.';

  @override
  String get settings_notification_off_title => '알림 권한이 꺼져 있어요';

  @override
  String get settings_notification_off_body => 'DueGuard는 알림이 핵심입니다. 알림을 허용해야 날짜를 제때 받을 수 있어요.';

  @override
  String get settings_notification_section => '알림';

  @override
  String get settings_about_section => '앱 정보';

  @override
  String get category_card => '카드/결제';

  @override
  String get category_subscription => '구독';

  @override
  String get category_utility => '공과금/관리비';

  @override
  String get category_tax => '세금';

  @override
  String get category_insurance => '보험';

  @override
  String get category_loan => '대출/이자';

  @override
  String get category_other => '기타';

  @override
  String get repeat_once => '1회';

  @override
  String get repeat_daily => '매일';

  @override
  String get repeat_weekly => '매주';

  @override
  String get repeat_monthly => '매달';

  @override
  String get repeat_yearly => '매년';

  @override
  String get item_title_label => '항목 이름';

  @override
  String get item_title_hint => '예: OO카드 결제일, 넷플릭스 해지';

  @override
  String get item_date_label => '날짜 및 시간';

  @override
  String get item_category_label => '카테고리';

  @override
  String get item_repeat_label => '반복';

  @override
  String get item_note_label => '메모 (선택)';

  @override
  String get item_note_hint => '추가로 기억할 내용';

  @override
  String get error_title_required => '항목 이름을 입력해 주세요';

  @override
  String get error_date_required => '날짜를 선택해 주세요';

  @override
  String get error_date_past => '이미 지난 날짜입니다. 알림을 받으려면 미래 날짜를 선택하세요.';

  @override
  String get error_save_failed => '저장에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get error_delete_failed => '삭제에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get toast_item_saved => '저장됐습니다';

  @override
  String get toast_item_deleted => '삭제됐습니다';

  @override
  String get toast_item_done => '완료 처리됐습니다';

  @override
  String get toast_next_scheduled => '다음 회차가 설정됐습니다';

  @override
  String get toast_notification_set => '알림이 예약됐습니다';

  @override
  String get toast_notification_failed => '알림 예약에 실패했습니다. 권한을 확인해 주세요.';

  @override
  String get date_relative_today => '오늘';

  @override
  String get date_relative_tomorrow => '내일';

  @override
  String get date_relative_day_after_tomorrow => '모레';

  @override
  String date_relative_in_n_days(int n) {
    return '$n일 뒤';
  }

  @override
  String date_relative_overdue(int n) {
    return '$n일 지남';
  }

  @override
  String about_app_version(String version) {
    return '버전 $version';
  }

  @override
  String get about_app_description => 'DueGuard는 놓치면 돈이 나가는 일정을 알려주는 앱입니다.';

  @override
  String get about_open_source => '오픈소스 라이선스';

  @override
  String get section_today => '오늘';

  @override
  String get section_this_week => '이번 주';

  @override
  String get section_upcoming => '예정';

  @override
  String get completed_count_none => '아직 완료 없음';

  @override
  String completed_count_n(int n) {
    return '$n회 완료';
  }

  @override
  String get last_completed_label => '마지막 완료';

  @override
  String get next_notification_label => '다음 알림';

  @override
  String get repeat_label => '반복';

  @override
  String get note_label => '메모';

  @override
  String get date_time_label => '날짜 및 시간';

  @override
  String get notification_not_scheduled => '알림 없음';

  @override
  String get notification_permission_required => '알림 권한이 필요합니다';

  @override
  String get onboarding_a_title => '돈 나가는 날짜, 여기에 모아두세요';

  @override
  String get onboarding_a_body => '카드 대금, 자동결제, 보험 갱신일 - 직접 관리하지 않으면 계속 잊어버립니다.';

  @override
  String get onboarding_a_cta => '첫 항목 추가하기';

  @override
  String get confirm_discard_title => '저장하지 않고 나가시겠어요?';

  @override
  String get confirm_discard_body => '입력한 내용이 사라집니다.';

  @override
  String get confirm_discard_cta => '나가기';

  @override
  String get past_time_once_confirm_title => '이미 지난 시각입니다';

  @override
  String get past_time_once_confirm_body => '알림은 예약되지 않습니다. 그래도 저장하시겠어요?';

  @override
  String get past_time_once_confirm_cta => '그대로 저장';

  @override
  String get badge_overdue => '기한 지남';

  @override
  String get badge_notification_on => '알림 예약됨';

  @override
  String get badge_notification_off => '알림 없음';

  @override
  String get notification_body_prefix => '마감';

  @override
  String get home_permission_banner_title => '알림이 꺼져 있어요';

  @override
  String get settings_permission_allowed => '허용됨';

  @override
  String get settings_permission_denied => '꺼져 있음';

  @override
  String get settings_notification_open_settings => '시스템 설정 열기';

  @override
  String get form_section_basic => '기본 정보';

  @override
  String get form_section_schedule => '일정 정보';

  @override
  String get home_summary_today => '오늘';

  @override
  String get home_summary_this_week => '이번 주';

  @override
  String get home_summary_total => '전체';

  @override
  String get calendar_title => '캘린더';

  @override
  String get calendar_no_items_for_day => '이 날에 등록된 항목이 없어요';

  @override
  String get history_title => '완료 이력';

  @override
  String get history_subtitle => '완료한 항목 모아보기';

  @override
  String get history_empty => '아직 완료한 항목이 없어요';

  @override
  String history_due_prefix(String date) {
    return '예정 $date';
  }

  @override
  String get trash_title => '휴지통';

  @override
  String get trash_subtitle => '삭제한 항목 복원';

  @override
  String get trash_empty => '휴지통이 비어있어요';

  @override
  String get trash_info_banner => '삭제한 항목은 복원할 수 있어요';

  @override
  String get trash_empty_button => '비우기';

  @override
  String get trash_restore_tooltip => '복원';

  @override
  String get trash_permanent_delete_tooltip => '영구 삭제';

  @override
  String get trash_restore_toast => '복원되었어요';

  @override
  String get trash_permanent_delete_title => '영구 삭제';

  @override
  String get trash_permanent_delete_body => '이 항목을 완전히 삭제할까요?\n삭제하면 복원할 수 없어요.';

  @override
  String get trash_permanent_delete_cta => '영구 삭제';

  @override
  String get trash_permanent_delete_toast => '영구 삭제되었어요';

  @override
  String get trash_empty_confirm_title => '휴지통 비우기';

  @override
  String get trash_empty_confirm_body => '휴지통의 모든 항목을 영구 삭제할까요?\n복원할 수 없어요.';

  @override
  String get trash_empty_confirm_cta => '비우기';

  @override
  String get trash_emptied_toast => '휴지통을 비웠어요';

  @override
  String trash_deleted_at(String date) {
    return '$date 삭제';
  }

  @override
  String get settings_records_section => '기록';

  @override
  String get date_picker_title => '날짜 및 시간';

  @override
  String get date_picker_confirm => '확인';

  @override
  String get settings_language_section => '언어';

  @override
  String get settings_language => '언어';

  @override
  String get settings_language_system => '시스템 기본';

  @override
  String get settings_language_korean => '한국어';

  @override
  String get settings_language_english => 'English';
}
