# DueGuard Release Checklist

내부/비공개 테스트(Internal Test Track) 업로드 전 확인용. MVP 범위 기준.

## 0. 목적
- Google Play Internal Testing 트랙에 업로드하기 전,
  기본 기능이 실제 기기에서 동작하는지 점검한다.
- 정식 출시가 아니라 **내부 테스트**이므로,
  스토어 리스팅과 번역 네이티브 감수는 이 단계에서 요구하지 않는다.

## 1. 코드 / 빌드 준비
- [ ] `flutter analyze` 에러 0개
- [ ] `flutter test` 통과 (repeat_rule 25+ 케이스 포함)
- [ ] `pubspec.yaml`의 `version`을 `1.0.0+N` 형태로 증가
- [ ] Debug/Release 구분 없이 동일 동작 (경고성 print/log 제거)
- [ ] `flutter_local_notifications`, `permission_handler`, `timezone`,
  `flutter_timezone` 의존성이 잠긴 상태 (pubspec.lock 커밋)
- [ ] 생성물 최신화
  - [ ] `flutter pub get`
  - [ ] `flutter pub run build_runner build --delete-conflicting-outputs`
  - [ ] `flutter gen-l10n` 후 `.dart_tool/flutter_gen/gen_l10n/` → `lib/l10n/generated/` 수동 동기화

## 2. 문자열 / 로컬라이즈
- [ ] `app_ko.arb`와 `app_en.arb`의 key 집합이 동일
- [ ] `Text(')` 형태로 하드코딩된 한글/영어 리터럴 0건 (grep 기준)
- [ ] 카테고리 / 반복 / 섹션 라벨은 ARB에서 조회
- [ ] `DateFormat` 호출에 locale 문자열이 명시되어 있음
- [ ] 알림 body 포맷(`formatNotificationBody`)이 ko/en 모두 정상

## 3. 권한 / AndroidManifest
- [ ] `POST_NOTIFICATIONS` 선언
- [ ] `SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM` 선언
- [ ] `RECEIVE_BOOT_COMPLETED` 선언 및 `ScheduledNotificationBootReceiver` 등록
- [ ] `ScheduledNotificationReceiver` 등록
- [ ] `android:label` = "DueGuard"
- [ ] 불필요한 권한 없음 (READ_CONTACTS, INTERNET 등 제거)

## 4. 알림 동작
- [ ] 2분 뒤 once 항목 저장 → 실제 알림 수신
- [ ] 동일 항목 10분 뒤로 edit → 기존 알림 취소되고 새 시각에 1회만 울림
- [ ] 항목 삭제 → 예약된 알림이 울리지 않음
- [ ] 기기 재부팅 → 예약된 알림이 유지됨
- [ ] 권한 거부 상태에서는 배너 노출 + 예약 실패 토스트
- [ ] 권한 허용 후 홈 배너가 사라짐

## 5. 반복 / 완료 / 재예약
- [ ] daily / weekly / monthly / yearly 각각 완료 처리 시 다음 회차 생성
- [ ] once 완료 시 다음 회차 생성 안 됨 (archived)
- [ ] monthly 31일, 2월, 윤년 edge case 테스트 통과 (unit test)
- [ ] 앱을 하루 이상 닫았다 열면 past-due 반복 항목이 자동 전진 (catchUp)
- [ ] 과거 시각 once 저장 시 확인 다이얼로그 + 알림 미예약

## 6. 데이터 / 저장소
- [ ] Isar 스키마가 최신 (`anchorDay`, `anchorMonth` 포함)
- [ ] 기존 테스트 설치가 있다면 앱 삭제 후 재설치해 마이그레이션 문제 방지
- [ ] 앱 강제 종료 후 재실행 시 항목 유지

## 7. UI / UX 스모크
- [ ] 첫 실행 시 알림 권한 자동 요청 없음
- [ ] 첫 항목 저장 직후 권한 요청 또는 배너 노출
- [ ] 홈 / 추가 / 상세 / 설정 4개 화면만 존재
- [ ] 15초 이내 첫 항목 등록 가능 (autofocus / 기본값)
- [ ] 빈 상태 / 섹션 분류 (오늘 / 이번 주 / 예정) 정상

## 8. 빌드
- [ ] `flutter build apk --release` 성공
  (또는 `flutter build appbundle --release`)
- [ ] 서명된 AAB 생성 및 keystore 백업 확보
- [ ] APK 설치 크기 < 30MB 목표

## 9. Play Console
- [ ] Internal Testing 트랙 생성
- [ ] 테스터 이메일 리스트 업로드 (구글 그룹 또는 이메일 목록)
- [ ] ko/en 기본 스토어 설명 초안 업로드
  (docs/product/store-listing.md 참조, 정식 출시 전 정제)
- [ ] 개인정보 처리방침 URL (로컬 앱이지만 Play 정책상 필요 - MVP 이후 보강 가능)
- [ ] 콘텐츠 등급 설문 제출
- [ ] 앱 카테고리: "생산성" (ko) / "Productivity" (en)

## 10. 내부 테스트 시작
- [ ] `docs/product/internal-tester-guide.md` 배포
- [ ] `docs/product/test-plan.md`에 따른 실기 QA 1회 수행
- [ ] 피드백 채널(구글 폼/카카오톡/이메일) 공유
- [ ] 테스트 기간 공지 (권장 7일)

## 11. 출시 후 (모니터링 기간)
- [ ] Play Console crash rate 확인
- [ ] 피드백 10개 이상 수집 후 분류
- [ ] `docs/product/post-launch-kpi.md` KPI 1회 측정

## 12. 알려진 제약 (이번 내부 테스트에서 받아들이는 한계)
- Firebase Analytics 미연결 (MVP 이후 검토)
- 영어 네이티브 감수 미실시
- DST/타임존 변경 시 정확성 미보장
- 하루 전/1시간 전 등 다중 알림 미지원 (사용자 안내 필요)
- 서버 동기화 / 백업 / 다기기 동기화 없음
