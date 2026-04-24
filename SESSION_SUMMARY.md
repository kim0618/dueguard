# DueGuard Session Summary

## Current status

| 세션 | 날짜 | 상태 |
|---|---|---|
| Session A - Product + rules definition | 2026-04-24 | 완료 |
| Session B-design - Design concept + UX copy + Wireframes | 2026-04-24 | 완료 |
| Session B-flutter - Flutter MVP 구현 | 2026-04-24 | 완료 |
| Session C - 로컬 알림 + 반복 + 내부 테스트 준비 | 2026-04-24 | 완료 |
| Session D - UI/UX 전면 리팩토링 | 2026-04-24 | 완료 |

`flutter analyze` issue 0건. 데이터/알림/반복/localization 구조 유지, UI 레이어만 전면 개선.
**판정: 내부 테스트 가능 (단, 실기 QA 선행 필요)** - 자세한 판단 이유는 아래 섹션 참조.

---

## 이번 세션에서 한 일 (Session D, 2026-04-24)

### UI/UX 전면 리팩토링 - 기능 유지, 디자인 개선

**원칙**: 데이터 모델·알림 로직·반복 규칙·localization 구조 전부 유지. UI 레이어만 수정.

#### 변경 내용

1. **`lib/shared/theme/app_theme.dart` 전면 개편**
   - 배경색 `#F2F4F8` (아주 옅은 청회색), 카드 흰색 분리
   - `cardShadow` static getter: 약한 그림자 (blur 8, black @6%)
   - 카드 radius 16dp, 버튼 radius 16dp, 칩 radius 12dp
   - `textSecondary`, `dividerColor`, `surfaceVariant` 컬러 정리
   - ElevatedButton: height 52, letterSpacing 0.2, w600
   - InputDecoration: enabledBorder/focusedBorder/errorBorder 완성 + labelSmall hintStyle
   - AppBar: scrolledUnderElevation 0, titleTextStyle 20/w700

2. **`lib/shared/widgets/reminder_card.dart` 완전 재설계**
   - Card 위젯 → Container + BoxDecoration (그림자, radius 16) + Material/InkWell
   - `_CategoryIconBox`: 44×44, radius 12, 긴급도에 따라 red/orange/primary tinted bg
   - `_StatusChip`: title 우측 고정, 오늘=red / 이번 주=orange / 예정=gray
   - `_SmallLabel`: 카테고리·반복 chip (6px radius, 옅은 bg)
   - 하단 행: 알림 아이콘(11px) + 날짜텍스트 ellipsis
   - Dismissible 배경도 radius 16 정렬

3. **`lib/shared/widgets/empty_state.dart` 개선**
   - 아이콘을 72×72 rounded box(radius 20, primary @8%)로 감쌈
   - CTA: OutlinedButton → ElevatedButton (200px 고정폭)

4. **`lib/features/home/screens/home_screen.dart` 개선**
   - `_SectionHeader`: 레이블 + count 칩 (긴급도 색상 분기)
   - `_PermissionBanner`: MaterialBanner → 스타일드 Container (orange tint border)
   - ListView padding: top 8, bottom 100 (FAB 여백)
   - 설정 아이콘: `settings` → `settings_outlined`

5. **`lib/features/item/screens/item_form_screen.dart` 3섹션 재구성**
   - `_FormSection` 컴포넌트: label(uppercase small) + 흰 카드 컨테이너
   - **섹션1 기본 정보**: 제목 필드(borderless, titleMedium w600) + divider + 카테고리 FilterChip(아이콘 포함)
   - **섹션2 일정 정보**: 날짜 InkWell 행 + divider + 반복 DropdownButton 인라인 행 (`_FieldIconBox` 통일)
   - **섹션3 메모**: notes 아이콘 + borderless multiline TextFormField
   - 저장 버튼: theme의 ElevatedButton 그대로(height 52, radius 16)
   - ARB 키 추가: `form_section_basic`, `form_section_schedule`

6. **`lib/features/item/screens/item_detail_screen.dart` 위계 재정리**
   - `_DetailHeaderCard`: 52×52 아이콘 박스(radius 14) + title(titleLarge w700) + 카테고리칩 + urgency칩
   - `_InfoCard`: 모든 정보 행을 카드 컨테이너로 묶음, `_InfoRow`(34×34 아이콘 박스 + label/value 스택)
   - `_NoteCard`: 별도 카드로 분리
   - 버튼 위계: ElevatedButton(완료) → TextButton 빨간색(삭제) 순서
   - 기존 OutlinedButton 완료 → ElevatedButton으로 격상

7. **`lib/features/settings/screens/settings_screen.dart` 섹션 카드화**
   - `_SectionLabel` / `_SettingsCard` / `_SettingsTile` / `_TilesDivider` / `_AboutDescriptionTile` 컴포넌트 분리
   - 알림·앱정보 각 섹션이 흰 카드 컨테이너로 묶임
   - 셀 높이 통일 (px 14 vertical padding), 34×34 아이콘 박스 일관 적용
   - DividerTheme 기반 `_TilesDivider` (horizontal 16 margin)

8. **Localization 키 2개 추가**
   - `form_section_basic`: ko "기본 정보" / en "Basic info"
   - `form_section_schedule`: ko "일정 정보" / en "Schedule"
   - `app_ko.arb`, `app_en.arb`, 생성된 Dart 3파일 모두 동기화

**검증**: `flutter analyze` 이슈 0건. 기능 흐름(저장/알림/반복/완료/삭제) 코드 변경 없음.

---

## 변경 파일 (Session D)

수정:
- `lib/shared/theme/app_theme.dart`
- `lib/shared/widgets/reminder_card.dart`
- `lib/shared/widgets/empty_state.dart`
- `lib/features/home/screens/home_screen.dart`
- `lib/features/item/screens/item_form_screen.dart`
- `lib/features/item/screens/item_detail_screen.dart`
- `lib/features/settings/screens/settings_screen.dart`
- `lib/l10n/app_ko.arb`
- `lib/l10n/app_en.arb`
- `lib/l10n/generated/app_localizations.dart`
- `lib/l10n/generated/app_localizations_ko.dart`
- `lib/l10n/generated/app_localizations_en.dart`
- `SESSION_SUMMARY.md`

---

## 남아 있는 UI 개선 후보 (Session D 이후)

1. **홈 화면 상단 요약 배너**: 오늘 N건 · 이번주 M건 등 숫자 요약 카드 (현재는 섹션 카운트 칩만 있음)
2. **완료 항목 아카이브 화면**: `isArchived=true` 항목 확인 뷰 (현재 없음)
3. **카드 롱프레스 컨텍스트 메뉴**: 완료/수정/삭제를 한 번에 선택 가능한 팝업
4. **항목 추가 화면 날짜 퀵셀렉트**: "오늘", "내일", "다음주" 빠른 선택 칩 행
5. **다크모드 지원**: `AppTheme.dark` 추가 (현재 light 강제 - MVP 범위 외)

---

## 이번 세션에서 한 일 (Session C, 2026-04-24)

### 알림 + 반복 로직 구현 (요청 1~7)

1. **`lib/features/item/repeat_rule.dart` 신규**: `nextOccurrenceLocal`, `advanceUntilFutureLocal`, `daysInMonth` 순수 함수. anchorDay/anchorMonth 파라미터로 월말·윤년 복원 보장.
2. **`ReminderItem`에 `anchorDay` / `anchorMonth` 추가**: Isar 스키마 재생성. 최초 저장 시 `dueAt.day` / `dueAt.month`를 anchor로 고정, 이후 31일 → 30일 → 31일 복귀 패턴 정상 동작.
3. **`lib/features/notifications/notification_scheduler.dart` 신규**: `flutter_local_notifications` + `permission_handler` + `timezone` 래퍼. `create()` 생성자로 채널/타임존 초기화, `schedule`, `cancel`, `cancelAll`, `hasPermission`, `requestPermission`, `openSystemSettings` 제공.
4. **`lib/features/notifications/notification_providers.dart`**: `notificationSchedulerProvider`(override), `notificationPermissionProvider`(FutureProvider).
5. **`lib/features/item/reminder_actions.dart` 신규**: UI/저장/알림을 묶는 유일한 진입점.
   - `saveReminderAction`: edit 시 기존 notificationId 취소 → anchor 설정 → past+repeat면 `advanceUntilFutureLocal` → 저장 → future면 schedule → notificationId 기록.
   - `deleteReminderAction`: cancel → delete.
   - `markDoneAction`: cancel → archived(once) or 다음 회차 계산 후 재예약.
   - `catchUpAction`: `isArchived=false` 전체 스캔, repeat past-due는 전진 + 재예약, once past는 notificationId만 정리.
6. **Repository는 순수 DB 계층으로 축소**: `save`, `delete`, `getById`, `getAllActive`, `watchUpcoming`. 기존 `markDone`/`_nextOccurrence`/`_addMonths` 제거 (repeat_rule + actions로 이동).
7. **`main.dart`**: `NotificationScheduler.create()` 초기화 후 ProviderScope override. `DueGuardApp`을 `ConsumerStatefulWidget`으로 승격, `WidgetsBindingObserver`로 `AppLifecycleState.resumed`에서 `catchUpAction` 호출 (최초 + resume).
8. **홈 화면**: `notificationPermissionProvider`로 `_PermissionBanner` 상단 고정, 탐색 후 `ref.invalidate`로 재평가. `_confirmDone`/`_deleteItem`를 actions로 연결.
9. **Form 화면**: past + once면 확인 다이얼로그 → 사용자 동의 후 알림 미예약 저장. past + repeat은 action이 다음 회차로 자동 전진. 저장 결과에 따라 `toast_notification_set` / `toast_item_saved` / `toast_notification_failed` 분기.
10. **Detail 화면**: `markDoneAction` / `deleteReminderAction`로 치환.
11. **Settings 화면**: placeholder → 실제 권한 상태 표시 + 시스템 설정 딥링크.

### AndroidManifest + 의존성

12. `pubspec.yaml`에 `flutter_local_notifications: ^17.2.4`, `permission_handler: ^11.3.1`, `timezone: ^0.9.4`, `flutter_timezone: ^3.0.1` 추가.
13. `android/app/src/main/AndroidManifest.xml`:
    - 권한: `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED`, `WAKE_LOCK`, `VIBRATE`.
    - `ScheduledNotificationReceiver` + `ScheduledNotificationBootReceiver` 등록 (BOOT_COMPLETED, MY_PACKAGE_REPLACED, QUICKBOOT_POWERON 대응).
    - `android:label`을 "DueGuard"로 수정.

### Localization (요청 7)

14. ARB 키 추가 (ko/en): `past_time_once_confirm_title/body/cta`, `badge_overdue`, `badge_notification_on/off`, `notification_body_prefix`, `home_permission_banner_title`, `settings_permission_allowed/denied`, `settings_notification_open_settings`.
15. `flutter gen-l10n` 재실행 후 `.dart_tool/flutter_gen/gen_l10n/` → `lib/l10n/generated/` 수동 동기화.
16. `date_utils.dart`에 `formatNotificationBody` 추가: ko `M월 d일 a h:mm`, en `MMM d, h:mm a` (localization-rules 기준).

### 테스트

17. **`test/repeat_rule_test.dart` 신규 (28 케이스)**:
    - `daysInMonth`: 윤년/평년/각 달 길이
    - `nextOccurrenceLocal` basic: once/daily/weekly/monthly/yearly 기본
    - monthly edge: 3-1(31→4월), 3-2(31→2월 평년), 3-3(31→2월 윤년), 3-4(4/30→5/31 복귀), 3-7(30일→2월), 12→1월 rollover
    - yearly edge: 3-5(2/29→평년 2/28), 3-6(평년 2/28→다음 윤년 2/29 복귀)
    - `advanceUntilFutureLocal`: 미래면 그대로, once 전진 안 함, 각 repeat별 past → future 전진
    - anchor 미지정 시 clamp만 (복귀 안 됨), anchor 지정 시 복귀.

### 문서 (요청 8~14)

18. `docs/engineering/release-checklist.md` - 12 섹션, 내부 테스트 전 최종 점검.
19. `docs/product/test-plan.md` - 8 섹션, 30~40분 실기 QA 플로우.
20. `docs/product/internal-tester-guide.md` - 설치, 7일 사용 가이드, 보고 범위, 개인정보.
21. `docs/product/feedback-questions.md` - 10개 질문 (5 척도 + 5 주관식) + 분석 합격선.
22. `docs/product/post-launch-kpi.md` - Acquisition/Engagement/Reliability/Qualitative 4구분, 스프레드시트 템플릿.
23. `docs/product/post-mvp-gates.md` - DB 확장 / 서버 동기화 / 수익화 / OCR / 플랫폼 확장 5개 Gate 조건.
24. `docs/product/store-listing.md` - ko/en short/full description, 권한 설명, 애셋 체크리스트.

---

## 변경 파일 (Session C)

신규:
- `lib/features/item/repeat_rule.dart`
- `lib/features/item/reminder_actions.dart`
- `lib/features/notifications/notification_scheduler.dart`
- `lib/features/notifications/notification_providers.dart`
- `test/repeat_rule_test.dart`
- `docs/engineering/release-checklist.md`
- `docs/product/test-plan.md`
- `docs/product/internal-tester-guide.md`
- `docs/product/feedback-questions.md`
- `docs/product/post-launch-kpi.md`
- `docs/product/post-mvp-gates.md`
- `docs/product/store-listing.md`

수정:
- `pubspec.yaml`, `pubspec.lock`
- `android/app/src/main/AndroidManifest.xml`
- `lib/main.dart`
- `lib/features/item/reminder_item.dart` (+anchorDay/anchorMonth)
- `lib/features/item/reminder_item.g.dart` (build_runner 재생성)
- `lib/features/item/reminder_repository.dart` (thin DB layer)
- `lib/features/item/screens/item_form_screen.dart`
- `lib/features/item/screens/item_detail_screen.dart`
- `lib/features/home/screens/home_screen.dart`
- `lib/features/settings/screens/settings_screen.dart`
- `lib/shared/utils/date_utils.dart` (+formatNotificationBody)
- `lib/l10n/app_ko.arb`, `lib/l10n/app_en.arb`
- `lib/l10n/generated/app_localizations*.dart` (gen-l10n 재생성 + unused_import 무시)
- `SESSION_SUMMARY.md` (본 문서)

---

## 핵심 결정사항 (Session C)

26. **반복 anchor 필드 도입**: 문서에 "MVP 이후 고려"로 적혀있지만, test-cases 3-4/3-6이 anchor 없이는 불가능해 이번 세션에 포함. 기존 `createdAt.day`로는 "사용자가 선택한 dueAt.day"와 다를 수 있어 별도 필드가 필수.
27. **notificationId = item.id**: 문서 규칙 그대로. 저장 직후 id 확정되므로 schedule → notificationId 업데이트를 2단계 save로 처리.
28. **Action 레이어 분리**: repository는 순수 DB로 축소, notification 부수 효과는 전부 action에서 처리. 테스트 가능한 `repeat_rule`은 pure function으로 분리해 UI/IO 의존성 제거.
29. **Catch-up은 최초 실행 + resume 둘 다**: `WidgetsBindingObserver`로 `AppLifecycleState.resumed` 훅. 앱 장기 미실행 후 복구(test-case 4-3) 자동 처리.
30. **Past+once 저장 플로우**: 확인 다이얼로그 (ARB 키 3개 추가) → 알림 미예약 → "저장됐습니다" 토스트. Past+repeat는 자동 전진.
31. **알림 문구 locale 고정 시점**: 예약 시점의 앱 locale로 `formatNotificationBody` 사용. 기기 언어 변경 후 기존 예약은 바뀌지 않음 (localization-rules 허용 범위).
32. **Android 13+ 권한 요청**: `permission_handler`의 `Permission.notification.request()` 사용. 첫 항목 저장 직후 form에서 호출 (doc 6.권한 요청 시점).
33. **flutter_local_notifications receiver 수동 등록**: 패키지 manifest는 권한만 제공하므로 앱 쪽에서 명시 필요.

---

## 남은 리스크

### 우선순위 높음 (내부 테스트 시작 전)

1. **실기 빌드 미검증**: WSL2에 Android SDK 없어 `flutter build apk`가 아직 안 돌아감. 알림 등록/취소가 실제 기기에서 정확히 동작하는지 확인 필요. → `docs/product/test-plan.md`의 Section 2~6을 실기 1회 통과해야 내부 테스트 업로드 가능.
2. **알림 탭 → 앱 진입 동작 미구현**: `flutter_local_notifications`의 `onDidReceiveNotificationResponse` 콜백을 연결하지 않았다. 현재는 알림을 탭하면 앱은 열리지만 기본 홈으로만 간다 (test 5-5). 상세 화면 딥링크는 MVP 범위 외 - 필요하면 다음 세션.
3. **Exact alarm 권한 (Android 14+)**: 12L~14 기기에서 사용자가 "정확한 알람" 권한을 수동으로 켜야 하는 경우가 있음. 현재 `AndroidScheduleMode.inexactAllowWhileIdle`로 설정해 exact 권한 없이도 울리지만, 시각 정확도가 떨어질 수 있다. 실기에서 "예약 시각 ±2분" 목표 미달 시 `exactAllowWhileIdle`로 전환 고려.
4. **Privacy Policy URL 미준비**: Play Console에서 Internal Test 트랙도 최근에는 PP 요구하는 경우가 있음. 간단한 정적 페이지(Notion/Github Pages)라도 1장 필요.

### 추적 필요

5. **Timezone 패키지의 iOS/desktop fallback**: `FlutterTimezone.getLocalTimezone()`이 실패하면 UTC로 폴백. 한국 타임존 기기에서는 문제 없음.
6. **영어 네이티브 감수 미실시** (MVP 원칙). 내부 테스터 중 en 사용자 피드백으로 기초 점검.
7. **monthly/yearly anchor가 기존 사용자 DB에 없음**: 이번 세션 이전 설치된 기기가 있다면 `anchorDay`/`anchorMonth`가 null. 다행히 fallback 로직(`anchorDay ?? localDue.day`)으로 동작은 하지만 clamp 복귀가 정확하지 않음. Internal Test 대상자에게는 "기존 앱 삭제 후 재설치" 안내 필요 (tester-guide에 포함 완료).

---

## 실기 기기 테스트 시나리오 (최소 확인 세트)

아래 6개는 내부 테스트 업로드 **직전** 반드시 실기 1회 통과:

1. **[알림 실발사]** 제목 "테스트" + 2분 뒤로 once 저장 → 2분 뒤 실제 알림 수신, title/body가 ko or en 포맷과 일치.
2. **[edit 재예약]** 1번 항목을 10분 뒤로 수정 저장 → 원래 2분 뒤 시각에 알림 안 오고, 10분 뒤 1회만 울림.
3. **[delete 취소]** 1번 항목을 알림 도달 전 삭제 → 알림 오지 않음.
4. **[완료 후 다음 회차]** daily 항목 저장 후 완료 처리 → 다음 날 동일 시각에 예약됐는지 카드의 "다음 알림" 시각으로 확인.
5. **[재부팅 생존]** 10분 뒤 알림 예약된 상태에서 기기 재부팅 → 재부팅 후에도 알림 정상 수신.
6. **[권한 거부 흐름]** 첫 항목 저장 후 권한 거부 → 홈 상단 배너 노출, "허용하기" 탭 → 시스템 설정 화면 → 허용 후 돌아오면 배너 사라짐.

---

## 현재 상태 판정: **내부 테스트 가능 / 실기 QA 선행 조건부**

### 이유
- 코드 레이어 완성 (`flutter analyze` 0, 29개 단위 테스트 green).
- 문서 레이어 완성 (릴리스 체크리스트, 테스트 플랜, 테스터 가이드, 피드백/KPI/게이트/스토어 초안).
- 다만 WSL2 환경에 Android SDK가 없어 **실기 빌드/알림 실발사**를 아직 한 번도 확인하지 못했다.
- `flutter_local_notifications`/`permission_handler`/`timezone`은 WSL2 CI에서는 플러그인 등록만 검증되고, 실제 알림 도달은 기기에서만 검증 가능.

### 전환 기준
- 위 "실기 기기 테스트 시나리오 6개"를 통과하는 순간 "내부 테스트 업로드 가능" 상태로 승격.
- 실패 항목이 있으면 Session D에서 해당 항목만 좁게 수정 (notification body, schedule mode, receiver 설정 등).

### 정식 출시 아님 (작업 범위 재확인)
- 이번 목표는 **내부/비공개 테스트 준비 완료**.
- Play Store Internal Testing 트랙 업로드 → 7일 테스트 → 피드백/KPI 취합 → Public/Production 승격 여부를 별도 세션에서 결정.

---

## 다음 세션 권장 작업 (Session C 이후)

### Session D - 실기 빌드 + 알림 실발사 확인 (최우선)

- Android SDK 설치 (또는 Android Studio 환경에서 체크아웃해서 수행).
- `flutter build apk --debug`로 빌드 성공 확인.
- 실기 또는 에뮬레이터에 설치 후 위 "실기 기기 테스트 시나리오 6개" 전부 통과.
- 실패 시 좁은 수정:
  - 알림이 예약 시각에 못 맞추면 `AndroidScheduleMode.exactAllowWhileIdle`로 전환 + `SCHEDULE_EXACT_ALARM` UX 안내.
  - 재부팅 후 알림 사라지면 receiver 등록 오류 재점검.
  - 권한 배너가 안 뜨면 `notificationPermissionProvider` invalidate 타이밍 점검.

### Session E - 알림 탭 딥링크 + 내부 테스트 업로드

- `flutter_local_notifications`의 `onDidReceiveNotificationResponse` 콜백 연결.
  - payload에 `item.id` 저장 → 탭 시 `ItemDetailScreen`으로 push.
  - `getNotificationAppLaunchDetails()`로 앱 cold start 시나리오 처리.
- Privacy Policy 정적 페이지 1장 작성(Notion/Github Pages 등) → Play Console에 URL 등록.
- `docs/engineering/release-checklist.md` 섹션 1~11 전수 체크.
- Play Console Internal Testing 트랙에 AAB 업로드, 테스터 이메일 초대.

### Session F - 7일 내부 테스트 운영 + 피드백 수집

- `docs/product/internal-tester-guide.md` 배포.
- 매일 `docs/product/post-launch-kpi.md`의 Reliability 지표 수집 (crash-free, on-time rate).
- 7일 차에 `docs/product/feedback-questions.md` 10문항 구글폼 배포.
- 결과를 `docs/product/post-launch-kpi.md` 템플릿에 기록.

### Session G - 피드백 기반 후속 결정

- KPI 합격/불합격 판정 (`post-launch-kpi.md`의 의사결정 기준표).
- 합격 → 공개 테스트(Open/Production) 승격 준비.
- 불합격 지표별 좁은 개선:
  - Q3 포지션 이해도 < 3.5 → 스토어 헤드라인/서브타이틀 재작성.
  - Notification on-time < 95% → Session D로 회귀.
  - Avg items D7 < 2 → 카테고리 예시/온보딩 copy 점검.
- `docs/product/post-mvp-gates.md`의 Gate A~E 중 트리거 조건 충족한 것이 있는지 재평가 (있어도 착수는 PO 승인 후).

### 범위 밖 (Session C 이후에도 당분간 하지 말 것)

- 다중 알림(하루 전/1시간 전): Gate A 통과 전 금지.
- 서버 동기화, 로그인, 클라우드 백업: Gate B 통과 전 금지.
- 광고/결제/구독: Gate C 통과 전 금지.
- iOS 포팅, 웹 버전: Gate E 통과 전 금지.
- 복잡한 repeat 규칙(격주, 매월 마지막 평일 등): MVP 범위 명시적 제외.

---

## 이번 세션에서 한 일 (Session B-flutter, 2026-04-24)

1. Flutter SDK 설치 (Flutter 3.27.4, Dart 3.6.2) - WSL2 환경에 SDK 없어 직접 설치
2. `flutter create` 실행 후 `pubspec.yaml` 의존성 전체 구성
3. `l10n.yaml` + `app_ko.arb` / `app_en.arb` 전체 ARB 키 작성 (docs/design/ux-copy.md 기준, 하드코딩 없음)
4. `ReminderItem` Isar 컬렉션 + `Category` / `RepeatType` enum 정의, `build_runner` 코드 생성
5. `AppTheme` 구성 (Blue 800 Primary, Material 3, `ThemeMode.light` 강제)
6. `ReminderRepository`: `watchUpcoming`, `save`, `delete`, `markDone`, `_nextOccurrence` (월말/윤년 clamp 포함)
7. Riverpod providers: `isarProvider`, `reminderRepositoryProvider`, `upcomingRemindersProvider`, `reminderByIdProvider`
8. `main.dart`: `ProviderScope` + `isarProvider` override, `intl` locale 초기화 (`ko`/`en`)
9. 홈 화면: 오늘/이번 주/예정 섹션 분류, 빈 상태, Extended FAB, 완료/삭제 흐름
10. 항목 추가/수정 화면: `autofocus`, 카테고리 `FilterChip`, `DatePicker+TimePicker`, 반복 `Dropdown`, 마지막 카테고리 `SharedPreferences` 캐시, 이탈 확인 다이얼로그
11. 항목 상세 화면: 전체 필드 표시, 완료/삭제 확인 다이얼로그, 수정 화면 연결
12. 설정 화면: 알림 권한 섹션(placeholder), 버전 정보(`PackageInfo`), 오픈소스 라이선스
13. `ReminderCard` 위젯: 좌측 accent bar (오늘=Red 600, 7일 이내=Orange 700), `Dismissible` 스와이프 삭제
14. `EmptyState`, `date_utils.dart`, `category_utils.dart` 공통 위젯/유틸
15. `flutter analyze` 에러 0개 / `flutter test` 통과 확인

---

## 변경 파일 (Session B-flutter)

신규:
- `pubspec.yaml` - 의존성 전체 구성
- `l10n.yaml` - localization 출력 설정
- `lib/main.dart` - ProviderScope, Isar 초기화, DueGuardApp
- `lib/l10n/app_ko.arb` - 전체 ARB 키 (ko)
- `lib/l10n/app_en.arb` - 전체 ARB 키 (en)
- `lib/l10n/generated/app_localizations.dart` - gen-l10n 생성
- `lib/l10n/generated/app_localizations_ko.dart` - gen-l10n 생성
- `lib/l10n/generated/app_localizations_en.dart` - gen-l10n 생성
- `lib/features/item/reminder_item.dart` - ReminderItem, Category, RepeatType
- `lib/features/item/reminder_item.g.dart` - Isar build_runner 생성
- `lib/features/item/reminder_repository.dart` - ReminderRepository
- `lib/features/item/reminder_providers.dart` - Riverpod providers
- `lib/features/home/screens/home_screen.dart` - 홈 화면
- `lib/features/item/screens/item_form_screen.dart` - 추가/수정 화면
- `lib/features/item/screens/item_detail_screen.dart` - 상세 화면
- `lib/features/settings/screens/settings_screen.dart` - 설정 화면
- `lib/shared/theme/app_theme.dart` - AppTheme
- `lib/shared/widgets/reminder_card.dart` - ReminderCard
- `lib/shared/widgets/empty_state.dart` - EmptyState
- `lib/shared/utils/date_utils.dart` - 날짜 포맷 유틸 (intl, locale 명시)
- `lib/shared/utils/category_utils.dart` - 카테고리/반복 라벨/아이콘 유틸
- `test/widget_test.dart` - placeholder로 교체

수정:
- `SESSION_SUMMARY.md` - 본 문서

---

## 핵심 결정사항 (Session B-flutter)

19. **localization 생성 파일 위치**: `generate: true` 방식의 `package:flutter_gen` 경로가 WSL2 analyzer에서 인식 안 됨 → `lib/l10n/generated/`에 복사 후 상대 경로 임포트로 해결. `flutter gen-l10n` 실행 시 이 폴더도 함께 갱신 필요.
20. **riverpod_generator 버전 고정**: `isar_generator`와 analyzer 버전 충돌로 `riverpod_generator: ^2.4.0` 고정. `custom_lint`/`riverpod_lint` 제외.
21. **`isarProvider` 패턴**: `main()`에서 `Isar.open()` 후 `ProviderScope.overrides`로 주입. Provider 계층이 Isar 초기화 시점에 의존하지 않도록 단방향 의존.
22. **`watchUpcoming()`은 `isArchived == false` 전체**: 섹션 분류(오늘/이번 주/예정)는 화면 레이어에서 수행. Repository는 필터 없이 전달.
23. **`markDone()` 내 next occurrence 계산**: Repository 내부에서 처리. 화면은 결과만 받음. 월말 clamp는 `_daysInMonth()` + `day.clamp(1, maxDay)` 패턴 사용.
24. **수정 화면 진입 시 `Navigator.pushReplacement`**: 상세→수정 전환 시 back stack이 상세→수정→홈으로 쌓이는 것을 방지.
25. **`reminderByIdProvider`는 `FutureProvider.family`**: 상세 화면이 항상 DB 최신 상태를 읽도록 설계. 홈에서 넘긴 객체 캐싱 금지.

---

## 남은 리스크

### 우선순위 높음 (다음 세션 전 해결 필요)

1. **Android SDK 미설치** - WSL2에서 `flutter build apk --debug` 미실행 상태. 실기 동작은 Android SDK 설치 후에만 확인 가능.
2. **`flutter_local_notifications` 미연결** - 알림 예약 없음. `notificationId` 항상 `null`. 저장 직후 "다음 알림" 문구가 카드에 표시되지 않음.
3. **알림 권한 배너 미구현** - 홈 화면 `MaterialBanner` 없음. 권한 미허용 상태를 사용자가 인지할 방법 없음.

### 추적 필요

4. **월말/윤년 반복 계산 유닛 테스트 없음** - `_nextOccurrence` 로직은 구현됐으나 테스트 미작성. 장기 드리프트 버그 검출 불가.
5. **`localization` 생성 파일 수동 관리** - `flutter gen-l10n` 실행 후 `lib/l10n/generated/`를 수동 갱신해야 함. ARB 키 추가 시 누락 위험.
6. **`reminderByIdProvider`의 `ref.watch` 캐시 무효화** - 수정 후 상세 화면으로 돌아올 때 `FutureProvider`가 최신 값을 반환하는지 실기 확인 필요.

---

## 다음 세션 권장 작업

### Session C - 알림 연결 (최우선)

- `pubspec.yaml`에 `flutter_local_notifications: ^17`, `permission_handler: ^11`, `timezone` 추가
- `NotificationScheduler` 클래스 신규 작성: `schedule(item)`, `cancel(id)`, `replace(item)` 진입점
- `ReminderRepository.save()` 후 `NotificationScheduler.schedule()` 호출 연결
- `ReminderRepository.delete()` / `markDone()` 후 `cancel()` 호출 연결
- 홈 화면 `MaterialBanner`: `permission_handler`로 권한 상태 확인, 미허용 시 상단 고정 노출
- `android/app/src/main/AndroidManifest.xml` 알림 권한 추가

### Session D - 실기 빌드 + QA

- Android SDK 설치 후 `flutter build apk --debug` 실행
- 에뮬레이터 또는 실기 기기에서 홈/추가/수정/삭제/완료 흐름 전체 검증
- 반복 규칙 유닛 테스트 작성 (monthly 31일, yearly 2/29 등 edge case)
- `docs/engineering/test-cases.md` 기준 QA 체크리스트 실행

---

## 이번 세션에서 한 일 (Session B-design, 2026-04-24)

- DueGuard MVP의 디자인 컨셉, UX 카피, 와이어프레임을 `docs/design/` 3개 문서로 정리.
- 4개 화면(홈/추가·수정/상세/설정) 각각의 목적, 컴포넌트 목록, CTA, 빈 상태를 구현 수준으로 정의.
- 온보딩 카피 3세트, 빈 상태 카피 5개, CTA 세트, DueGuard 서브타이틀 5개를 ko/en 쌍으로 작성.
- 모든 사용자 노출 문자열을 ARB 키 기반으로 설계 (하드코딩 없음).
- 컬러 시스템, 타이포그래피, 아이콘 맵, 레이아웃 원칙을 Material 3 기반으로 확정.
- 화면 전환 맵과 구현 주의사항(BottomSheet 금지, 4개 화면 상한, stale 데이터 방지 등) 포함.

## 변경 파일 (Session B-design)

신규:
- `docs/design/design-concept.md`
- `docs/design/ux-copy.md`
- `docs/design/wireframes.md`

## 핵심 결정사항 (Session B-design)

13. **추천 디자인 방향**: Material 3 + Blue 800 Primary. 커스텀 컬러 최소화, `ThemeMode.light` 강제, 다크모드 MVP 제외.
14. **바텀 네비게이션 없음**: 화면 전환은 AppBar back + FAB만.
15. **BottomSheet 입력 금지**: 모든 입력은 전체 화면(추가·수정) 또는 AlertDialog(확인)만.
16. **추가·수정 화면 동일 위젯 재사용**: `itemId`가 null이면 추가, 있으면 수정 모드.
17. **서브타이틀**: "놓치면 돈 나가는 일정만 지켜드립니다" (ko) / "Guard the dates that cost you money" (en).
18. **UX 원칙 5개**: autofocus + 기본값 / 알림 예약 피드백 즉시 제공 / 알림 권한 배너 상시 노출 / 화면 4개 상한 엄수 / 완료·삭제 후 즉시 홈 반영.

---

## 이번 세션에서 한 일 (Session A, 2026-04-24)

- DueGuard MVP의 제품 정의, 타깃 사용자, 성공 지표를 `docs/product/` 3개 문서로 고정.
- 데이터 모델, 알림/반복 규칙, QA 케이스, 로컬라이즈 규칙을 `docs/engineering/` 4개 문서로 고정.

## 핵심 결정사항 (Session A)

1. **포지션 고정**: "놓치면 돈 나가는 일정"만 다룬다. 일반 To-Do 확장 금지.
2. **플랫폼**: Android-only MVP. Flutter + Riverpod + Isar + flutter_local_notifications.
3. **데이터 모델**: `ReminderItem` 컬렉션 1개. 완료 이력은 `completedCount` + `lastCompletedAt`으로 흡수.
4. **Category 7종 고정 enum**: `card`, `subscription`, `utility`, `tax`, `insurance`, `loan`, `other`.
5. **RepeatType 5종 고정**: `once`, `daily`, `weekly`, `monthly`, `yearly`. RRULE 전체 지원 금지.
6. **항목당 알림은 다음 1회만**.
7. **알림 권한 요청 시점**: 첫 항목 저장 직후. 첫 실행 즉시 요청 금지.
8. **ko 소스 / en 구조 대응만**. 영어 네이티브 감수는 MVP 이후.
9. **Timezone은 local device only**.
10. **성공 지표 4개**: install→first item 중앙값 2분, 7일차 평균 항목 3건, 알림 opt-in 80%, 7일차 재방문 40%.
11. **문자열 하드코딩 금지**. 모든 사용자 노출 텍스트는 ARB 리소스.
12. **날짜 포맷은 `intl`에 locale을 명시적으로 전달**. 생략 호출 금지.
