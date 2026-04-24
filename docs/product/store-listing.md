# DueGuard Play Store Listing (초안)

Internal Testing용 초안. 정식 출시 전 다듬을 것. en은 네이티브 감수 미실시 (MVP 원칙).

---

## Short description (80자 이내)

### ko
놓치면 돈이 나가는 일정만 지켜드립니다. 카드·구독·공과금·세금 알림.

### en
Reminders for the dates that cost you money when missed.

---

## Full description

### ko

DueGuard는 "놓치면 돈 나가는 일정"만 관리하는 작은 앱입니다.

카드 결제일, 구독 갱신, 공과금, 세금, 보험료, 대출 이자 - 놓치면 수수료, 연체금, 자동 결제로 돈이 새는 날짜를 한 곳에 모아 관리하고, 정확한 시각에 알림을 받습니다.

주요 기능
- 놓치면 돈 나가는 일정 전용 카테고리: 카드, 구독, 공과금, 세금, 보험, 대출, 기타
- 반복 주기: 1회, 매일, 매주, 매달, 매년
- 정확한 로컬 알림 (서버 없이 기기 내부에서 동작)
- 완료 처리 시 다음 회차 자동 생성
- 매달 31일처럼 월마다 일자가 다른 경우 자동 조정 (월말 보정)
- 첫 항목 등록 15초 목표, 불필요한 입력 제거

이런 분께 권장합니다
- 카드 대금을 매달 다른 날짜로 결제해 놓치기 쉬우신 분
- 넷플릭스, 디즈니+ 같은 구독을 바꾸거나 해지할 타이밍을 놓치는 분
- 자동차세, 종합소득세 같은 세금 신고일을 매번 찾아보는 분
- "달력"이 아니라 "돈 나가는 날"만 정리해두고 싶은 분

이런 분께는 적합하지 않습니다
- 할 일 전체를 체계적으로 관리하고 싶은 분 (일반 To-Do 앱을 추천합니다)
- 가족/팀과 일정을 공유해야 하는 분
- 캘린더 동기화가 꼭 필요하신 분

개인정보 안내
- DueGuard는 로컬 저장 기반입니다.
- 계정 로그인이 없고, 어떤 데이터도 외부 서버로 보내지 않습니다.
- 입력한 모든 항목은 기기 내부에만 저장됩니다.

요청 권한
- 알림: 예약된 시각에 알림을 보내기 위함
- 정확한 알람: 분 단위 정확도를 위한 Android 12+ 권한
- 기기 부팅 완료: 재부팅 이후에도 예약을 유지하기 위함

문의
- 피드백이나 버그 제보는 개발자 이메일 또는 Play 리뷰로 부탁드립니다.

### en

DueGuard is a tiny app that only manages "the dates that cost you money when missed".

Credit card due dates, subscription renewals, utility bills, taxes, insurance, loan interest - keep every money-related deadline in one place and get a precise reminder at the right moment.

Main features
- Seven money-focused categories: card, subscription, utility, tax, insurance, loan, other
- Repeat types: once, daily, weekly, monthly, yearly
- Precise local notifications (no server, runs entirely on device)
- Automatic next occurrence when you mark an item done
- Handles month-end edge cases automatically (e.g. the 31st in a 30-day month)
- First item in under 15 seconds - minimum required fields

Who this is for
- People who forget when their credit card statement is due
- People who miss the moment to cancel or downgrade Netflix or similar services
- People who never remember vehicle tax or annual insurance renewal
- People who want a short list of "money-out dates", not a full calendar

Who this is NOT for
- Anyone looking for a full task manager (use a general To-Do app)
- Anyone who needs family or team sharing
- Anyone who must sync with Google Calendar

Privacy
- DueGuard stores everything locally on your device.
- There is no account, no login, and no data is sent to any server.

Permissions
- Notifications: to alert you at the scheduled time
- Exact alarms: for minute-level accuracy on Android 12+
- Boot completed: so scheduled alerts survive a device reboot

Feedback
- Please send feedback via email or a Play Store review.

---

## Store graphic assets (체크리스트, 이번 내부 테스트에선 minimum only)

- [ ] Feature graphic (1024 x 500)
- [ ] Phone screenshot 2장 이상 (ko: 홈, 추가 화면)
- [ ] App icon (Play Console 업로드용)
- [ ] Short description ko/en
- [ ] Full description ko/en
- [ ] Category: "생산성" / "Productivity"
- [ ] Content rating 설문 완료
- [ ] Privacy Policy URL (정식 출시 전까지 반드시 준비)
- [ ] Data safety 선언: "No data collected"

정식 출시 전에 en 네이티브 감수, 스크린샷 추가(3~5장), 프로모션 비디오(선택)를 진행한다.
