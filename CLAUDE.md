# Project: DueGuard MVP

DueGuard는 안드로이드 우선의 로컬 기반 MVP 앱이다.
핵심 포지션은 “모든 일정 관리”가 아니라 “놓치면 돈 나가는 일정 관리”다.

## Product goal
사용자가 앱을 설치하고:
1. 최소 1개 항목을 등록하고
2. 로컬 알림을 허용하고
3. 며칠 뒤 다시 앱을 열어보는지 검증한다

## App name
- Official name: DueGuard

## Localization
- Support ko and en from the beginning
- MVP validation is Korean-first
- Do not hardcode user-facing strings
- Keep all UI strings in localization resources

## In scope for MVP
- 항목 추가 / 수정 / 삭제
- 카테고리 선택
- 날짜 선택
- 반복 주기: once, daily, weekly, monthly, yearly
- 로컬 알림
- 다가오는 일정 리스트
- 완료 처리
- 완료 후 다음 회차 생성

## Out of scope for MVP
- 로그인
- 서버 API
- 클라우드 백업
- 동기화
- 가족 공유
- 광고/결제/구독
- OCR/이메일 파싱
- 자동 구독 탐지
- 웹 버전
- 복잡한 통계

## Tech stack
- Flutter
- Riverpod
- Isar
- flutter_local_notifications
- Firebase Analytics (optional)

## UX priorities
- 첫 항목 등록까지 15초 이내 목표
- 필수 입력 최소화
- 디자인보다 입력속도와 알림 신뢰성이 중요
- 돈이 새는 걸 막는 앱이라는 인상이 즉시 전달되어야 함

## Engineering rules
- 서버 코드는 명시적 요청 없이는 추가하지 말 것
- 로그인/인증은 명시적 요청 없이는 추가하지 말 것
- 과한 clean architecture 금지
- 작고 읽기 쉬운 코드 우선
- 세션 종료 시 SESSION_SUMMARY.md 갱신

## Critical risk areas
- date boundaries
- past-time scheduling
- monthly/yearly repeat edge cases
- duplicate notifications after edit
- stale notifications after delete
- localization regressions between ko and en