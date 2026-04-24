# DueGuard Post-Launch KPI

내부 테스트 ~ 공개 출시 초기에 매일/매주 보는 지표 테이블.
`docs/product/success-metrics.md`의 4개 상위 지표를 측정 가능한 단위로 분해했다.

## 데이터 소스
- **로컬 앱 내부 이벤트 카운팅** (Firebase Analytics 미연결이므로, 필요 시 수동 로그)
- **테스터 구글폼 응답** (Q6: 등록 항목 수 등)
- **Play Console Internal Test 통계** (설치, 언인스톨, 크래시)

MVP 단계에서는 "수치가 정확한가"보다 "방향이 맞는가"를 본다.

---

## 1. Acquisition & Activation

| 지표 | 정의 | MVP 목표 | 측정 방법 | 주기 |
|---|---|---|---|---|
| Internal test 설치 수 | Play Console "Installs" | 테스터 중 80% 이상 | Play Console | 주 1회 |
| First open 성공률 | 설치 후 1회 이상 실행한 비율 | ≥ 90% | Play Console | 주 1회 |
| First item save 시간 | 앱 실행 후 첫 저장까지 median | ≤ 120초 (이상적으론 15초) | Q1 설문 + 관찰 | 테스트 종료 1회 |
| 알림 권한 허용률 | POST_NOTIFICATIONS granted 비율 | ≥ 80% | 설문 + 실기 확인 | 주 1회 |

## 2. Engagement (핵심)

| 지표 | 정의 | MVP 목표 | 측정 방법 | 주기 |
|---|---|---|---|---|
| 7일차 평균 등록 항목 수 | user당 7일차 isArchived=false 개수 | ≥ 3건 | 설문 Q6 + 실기 | 테스트 종료 1회 |
| Day 7 retention | Day 0 사용자 중 Day 7에 앱을 연 비율 | ≥ 40% | 설문 + 자가 보고 | 테스트 종료 1회 |
| 평균 완료 처리 수/사용자 | markDone 탭 횟수 | ≥ 1회 | 수동 로그 or 설문 | 테스트 종료 1회 |
| 반복 항목 비율 | repeat ≠ once / 전체 | ≥ 30% | 설문 Q6 후속 | 테스트 종료 1회 |

## 3. Reliability (가장 중요 - 알림이 핵심)

| 지표 | 정의 | MVP 목표 | 측정 방법 | 주기 |
|---|---|---|---|---|
| Notification-on-time rate | 예약한 시각 ±2분 이내 실제 수신 비율 | ≥ 98% | 테스터 자가 체크 | 일 1회 수집 |
| 크래시율 | Play Console Crash-free users | ≥ 99.5% | Play Console | 일 1회 |
| ANR 비율 | Play Console ANR | ≥ 99.5% | Play Console | 주 1회 |
| 저장 실패 보고 수 | 설문/이슈 중 "저장 실패" 언급 수 | 0건 | 피드백 | 주 1회 |

## 4. Qualitative (포지션 검증)

| 지표 | 정의 | MVP 목표 | 측정 방법 | 주기 |
|---|---|---|---|---|
| Q3 "포지션 이해도" 평균 | 1~5점 | ≥ 4.0 | 설문 | 1회 |
| Q7 응답 카테고리 | 카드/구독/공과금 등 분포 | 카드 + 구독이 과반 | 설문 | 1회 |
| "일반 To-Do로 쓰려 함" 언급 수 | 자유 응답 내 | ≤ 1명 | 설문 | 1회 |
| "돈이 절약됐다" 구체 사례 | 자유 응답 내 | ≥ 1명 | 설문 | 1회 |

---

## 대시보드 (최소 버전)

Spreadsheet 한 장으로 충분. 열:
```
Week | Installs | First Open % | Perm Allow % | Avg Items D7 | Retention D7 | Notification On-time % | Crash-free % | Q3 평균 | Q4 평균 | Q5 평균 | 비고
```

## 의사결정 기준

| 관찰 | 액션 |
|---|---|
| Notification on-time < 95% | 릴리즈 보류, 알림 로직 재점검 |
| Crash-free < 99% | 즉시 hotfix |
| Avg items D7 < 2 | 포지션 또는 카테고리 예시 재검토 |
| Retention D7 < 25% | 온보딩/알림 문구 재작성 |
| Q3 < 3.5 | 스토어 헤드라인 + 서브타이틀 수정 |
| Q4 < 3.0 | MVP 가설 재검토 (다른 포지션으로 전환 논의) |
| 모두 목표 충족 | 비공개 → 공개 테스트로 승격 |
