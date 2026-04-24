# DueGuard UX Copy

모든 사용자 노출 문자열은 ARB 리소스 기반이다.
아래 항목들은 `app_ko.arb` / `app_en.arb`에 들어갈 키와 값을 정의한다.

---

## DueGuard 서브타이틀 제안 (5개)

스토어 등록 및 앱 내 온보딩에서 사용 가능한 한 줄 정의.

| # | ko | en |
|---|---|---|
| 1 | 놓치면 돈 나가는 일정만 지켜드립니다 | Guard the dates that cost you money |
| 2 | 청구일, 갱신일, 납부일. 빠짐없이 알림 | Bills, renewals, due dates. Never missed |
| 3 | 자동결제, 보험, 세금 - 잊기 전에 알림 | Auto-pay, insurance, taxes - notified before you forget |
| 4 | 돈이 새기 전에 막는 일정 알리미 | Your financial deadline watchdog |
| 5 | 기억 대신 알림이 지킵니다 | Let the notification remember it for you |

**추천**: #1 (ko), #2 (en) - 범위가 명확하고, 행동 동사 없이 포지션이 전달된다.

---

## 온보딩 카피 3세트

처음 앱을 설치한 사용자에게 항목 추가 화면 진입 전 표시하는 단일 메시지.
슬라이드/멀티-페이지 온보딩 금지. 화면 1개 또는 빈 홈 상태 카피로 처리.

### 세트 A - 직접적 (권장)

```
ARB key: onboarding_a_title
ko: 돈 나가는 날짜, 여기에 모아두세요
en: Keep every money deadline in one place

ARB key: onboarding_a_body
ko: 카드 대금, 자동결제, 보험 갱신일 - 직접 관리하지 않으면 계속 잊어버립니다.
en: Card bills, subscriptions, insurance renewals - they slip by if you don't track them.

ARB key: onboarding_a_cta
ko: 첫 항목 추가하기
en: Add your first item
```

### 세트 B - 공감 기반

```
ARB key: onboarding_b_title
ko: 한 번은 다 놓쳐봤을 겁니다
en: We've all missed one before

ARB key: onboarding_b_body
ko: 넷플릭스 해지를 잊거나, 카드 대금을 하루 늦겨 연체료를 낸 적 있다면 - 그게 DueGuard가 막는 일입니다.
en: Forgot to cancel a trial, or paid a late fee on your card? That's exactly what DueGuard prevents.

ARB key: onboarding_b_cta
ko: 지금 등록하기
en: Register now
```

### 세트 C - 숫자/속도 강조

```
ARB key: onboarding_c_title
ko: 15초면 됩니다
en: Takes 15 seconds

ARB key: onboarding_c_body
ko: 제목, 날짜, 카테고리만 입력하면 알림이 설정됩니다. 그게 전부입니다.
en: Enter a title, date, and category - and your notification is set. That's all.

ARB key: onboarding_c_cta
ko: 해보기
en: Try it
```

---

## 빈 상태 카피 (5개)

각 빈 상태마다 ARB 키 2개: `_title` + `_body`.

### 1. 홈 - 등록된 항목 없음

```
ARB key: home_empty_title
ko: 아직 등록된 항목이 없어요
en: No items yet

ARB key: home_empty_body
ko: 카드 대금, 구독 갱신, 보험 날짜 - 잊기 전에 등록해두세요.
en: Add card bills, subscriptions, or insurance dates before they slip by.
```

### 2. 홈 - 다가오는 항목 없음 (항목은 있으나 30일 이내 없음)

```
ARB key: home_no_upcoming_title
ko: 당분간 예정된 항목이 없어요
en: Nothing coming up soon

ARB key: home_no_upcoming_body
ko: 30일 이내에 예정된 일정이 없습니다. 모든 항목은 목록 아래에서 확인할 수 있어요.
en: Nothing scheduled in the next 30 days. All items are shown below.
```

### 3. 설정 - 알림 권한 없음 (인라인 상태)

```
ARB key: settings_notification_off_title
ko: 알림 권한이 꺼져 있어요
en: Notifications are off

ARB key: settings_notification_off_body
ko: DueGuard는 알림이 핵심입니다. 알림을 허용해야 날짜를 제때 받을 수 있어요.
en: DueGuard relies on notifications. Enable them to receive timely reminders.
```

### 4. 추가 화면 - 저장 후 다음 알림 없음 (once + 과거 날짜 엣지케이스)

```
ARB key: item_no_notification_title
ko: 알림을 예약할 수 없어요
en: Notification could not be scheduled

ARB key: item_no_notification_body
ko: 선택한 날짜가 이미 지났거나, 알림 권한이 없습니다. 날짜를 확인해 주세요.
en: The selected date has passed, or notification permission is missing. Please check the date.
```

### 5. 검색 결과 없음 (추후 검색 기능 추가 시 대비)

```
ARB key: search_empty_title
ko: 검색 결과가 없어요
en: No results found

ARB key: search_empty_body
ko: 다른 검색어를 입력하거나 항목을 새로 추가해 보세요.
en: Try a different keyword or add a new item.
```

---

## 핵심 CTA 문구 세트

### 기본 액션

```
ARB key: save_button
ko: 저장
en: Save

ARB key: cancel_button
ko: 취소
en: Cancel

ARB key: delete_button
ko: 삭제
en: Delete

ARB key: edit_button
ko: 수정
en: Edit

ARB key: done_button
ko: 완료
en: Done

ARB key: add_item_fab
ko: 항목 추가
en: Add Item
```

### 완료 처리

```
ARB key: mark_done_button
ko: 완료 처리
en: Mark as done

ARB key: mark_done_confirm_title
ko: 완료 처리하시겠어요?
en: Mark as done?

ARB key: mark_done_confirm_body_repeat
ko: 다음 회차가 자동으로 설정됩니다.
en: The next occurrence will be scheduled automatically.

ARB key: mark_done_confirm_body_once
ko: 이 항목이 완료 처리됩니다.
en: This item will be marked as done.
```

### 삭제

```
ARB key: delete_confirm_title
ko: 삭제하시겠어요?
en: Delete this item?

ARB key: delete_confirm_body
ko: 삭제하면 알림도 함께 취소됩니다. 되돌릴 수 없어요.
en: The notification will also be cancelled. This cannot be undone.

ARB key: delete_confirm_cta
ko: 삭제
en: Delete
```

### 알림 권한

```
ARB key: notification_permission_banner
ko: 알림이 꺼져 있어요. 이 앱은 알림이 핵심입니다.
en: Notifications are off. This app relies on notifications.

ARB key: notification_permission_allow_button
ko: 허용하기
en: Allow

ARB key: notification_scheduled_label
ko: 다음 알림: {datetime}
en: Next alert: {datetime}
```

### 설정

```
ARB key: settings_title
ko: 설정
en: Settings

ARB key: settings_notification_section
ko: 알림
en: Notifications

ARB key: settings_about_section
ko: 앱 정보
en: About
```

---

## 카테고리 라벨

```
ARB key: category_card
ko: 카드/결제
en: Card

ARB key: category_subscription
ko: 구독
en: Subscription

ARB key: category_utility
ko: 공과금/관리비
en: Utility

ARB key: category_tax
ko: 세금
en: Tax

ARB key: category_insurance
ko: 보험
en: Insurance

ARB key: category_loan
ko: 대출/이자
en: Loan

ARB key: category_other
ko: 기타
en: Other
```

---

## 반복 주기 라벨

```
ARB key: repeat_once
ko: 1회
en: Once

ARB key: repeat_daily
ko: 매일
en: Daily

ARB key: repeat_weekly
ko: 매주
en: Weekly

ARB key: repeat_monthly
ko: 매달
en: Monthly

ARB key: repeat_yearly
ko: 매년
en: Yearly
```

---

## 화면 제목

```
ARB key: home_title
ko: DueGuard
en: DueGuard

ARB key: item_add_title
ko: 항목 추가
en: New Item

ARB key: item_edit_title
ko: 항목 수정
en: Edit Item

ARB key: item_detail_title
ko: 상세 정보
en: Item Detail

ARB key: settings_title
ko: 설정
en: Settings
```

---

## 입력 필드 라벨 / 힌트

```
ARB key: item_title_label
ko: 항목 이름
en: Item name

ARB key: item_title_hint
ko: 예: OO카드 결제일, 넷플릭스 해지
en: e.g. Credit card bill, Netflix cancellation

ARB key: item_date_label
ko: 날짜 및 시간
en: Date & time

ARB key: item_category_label
ko: 카테고리
en: Category

ARB key: item_repeat_label
ko: 반복
en: Repeat

ARB key: item_note_label
ko: 메모 (선택)
en: Note (optional)

ARB key: item_note_hint
ko: 추가로 기억할 내용
en: Additional notes
```

---

## 오류 / 유효성 검사 메시지

```
ARB key: error_title_required
ko: 항목 이름을 입력해 주세요
en: Please enter an item name

ARB key: error_date_required
ko: 날짜를 선택해 주세요
en: Please select a date

ARB key: error_date_past
ko: 이미 지난 날짜입니다. 알림을 받으려면 미래 날짜를 선택하세요.
en: This date has already passed. Select a future date to receive a notification.

ARB key: error_save_failed
ko: 저장에 실패했습니다. 다시 시도해 주세요.
en: Save failed. Please try again.

ARB key: error_delete_failed
ko: 삭제에 실패했습니다. 다시 시도해 주세요.
en: Delete failed. Please try again.
```

---

## 상태 메시지 / 토스트

```
ARB key: toast_item_saved
ko: 저장됐습니다
en: Saved

ARB key: toast_item_deleted
ko: 삭제됐습니다
en: Deleted

ARB key: toast_item_done
ko: 완료 처리됐습니다
en: Marked as done

ARB key: toast_next_scheduled
ko: 다음 회차가 설정됐습니다
en: Next occurrence scheduled

ARB key: toast_notification_set
ko: 알림이 예약됐습니다
en: Notification scheduled

ARB key: toast_notification_failed
ko: 알림 예약에 실패했습니다. 권한을 확인해 주세요.
en: Notification scheduling failed. Check permissions.
```

---

## 날짜 상대 표현

```
ARB key: date_relative_today
ko: 오늘
en: Today

ARB key: date_relative_tomorrow
ko: 내일
en: Tomorrow

ARB key: date_relative_day_after_tomorrow
ko: 모레
en: Day after tomorrow

ARB key: date_relative_in_n_days
ko: {n}일 뒤
en: {n, plural, =1{In 1 day} other{In {n} days}}

ARB key: date_relative_overdue
ko: {n}일 지남
en: {n, plural, =1{1 day overdue} other{{n} days overdue}}
```

---

## 앱 정보 (설정 화면)

```
ARB key: about_app_version
ko: 버전 {version}
en: Version {version}

ARB key: about_app_description
ko: DueGuard는 놓치면 돈이 나가는 일정을 알려주는 앱입니다.
en: DueGuard reminds you of dates that cost money when missed.

ARB key: about_open_source
ko: 오픈소스 라이선스
en: Open-source licenses
```
