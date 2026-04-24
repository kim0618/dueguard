# DueGuard Data Model

## 저장소
- **Isar** (로컬 DB). 서버/동기화 없음.
- 컬렉션 1개로 시작: `ReminderItem`.
- 추후 완료 이력을 따로 쌓을 필요가 생기면 `ReminderOccurrence` 컬렉션을 분리할 수 있으나, **MVP에는 추가하지 않는다.**

## Category (enum)
고정 enum. 자유 입력 금지. 로컬라이즈드 라벨은 리소스에서 조회한다.

| key | ko 라벨 (예시) | en 라벨 (예시) |
|---|---|---|
| `card` | 카드/결제 | Card |
| `subscription` | 구독 | Subscription |
| `utility` | 공과금/관리비 | Utility |
| `tax` | 세금 | Tax |
| `insurance` | 보험 | Insurance |
| `loan` | 대출/이자 | Loan |
| `other` | 기타 | Other |

- 7종 고정. MVP 기간에 추가/제거는 코드 변경으로만.
- 로컬라이즈드 라벨은 ARB 리소스에 `category_card`, `category_subscription` 형태로 저장한다.

## RepeatType (enum)

| key | 의미 |
|---|---|
| `once` | 1회 (기본값) |
| `daily` | 매일 |
| `weekly` | 매주 같은 요일 |
| `monthly` | 매달 같은 날짜 |
| `yearly` | 매년 같은 월/일 |

- 위 5종 외 금지. RRULE 전체 지원 금지.

## ReminderItem 필드

| 필드명 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `id` | `Id` (auto) | Y | Isar auto-increment |
| `title` | `String` | Y | 사용자 입력 제목. 공백 제거 후 1자 이상 |
| `note` | `String?` | N | 선택 메모. 빈 문자열은 null로 정규화 |
| `category` | `Category` | Y | enum |
| `repeatType` | `RepeatType` | Y | enum |
| `dueAt` | `DateTime` | Y | **다음 예정 시각** (local time, UTC로 저장 권장). 반복 항목의 경우 이 값이 진행에 따라 미래로 전진한다 |
| `notificationId` | `int?` | N | flutter_local_notifications에 예약된 알림 ID. 미예약 시 null |
| `createdAt` | `DateTime` | Y | 최초 생성 시각 |
| `updatedAt` | `DateTime` | Y | 마지막 수정 시각 |
| `completedCount` | `int` | Y | 완료 누적 횟수. 기본 0 |
| `lastCompletedAt` | `DateTime?` | N | 마지막 완료 시각 |
| `isArchived` | `bool` | Y | 삭제 대신 숨길지 여부. 기본 false. MVP에서는 삭제만 쓰되 필드는 남겨둔다 |

### 저장 규칙
- `dueAt`은 **UTC 기반 `DateTime`**으로 저장하되, 표시/계산은 local timezone으로 변환한다. (Isar의 DateTime은 UTC 저장이 안정적)
- `title`은 trim 후 저장. 빈 문자열 저장 금지.
- `note`는 trim 후 빈 문자열이면 null로.
- `notificationId`는 예약 성공 시에만 채우고, 취소/재예약 시 갱신한다.

## 파생 값 (저장 안 함)

| 이름 | 계산 로직 |
|---|---|
| `nextOccurrenceAt` | `dueAt` 그대로. MVP에서는 항목당 "다음 1회"만 다룬다 |
| `isDue` | `dueAt <= now` |
| `isUpcomingToday` | `dueAt.localDate == today` |
| `humanReadableSchedule` | 예: "매달 25일", "매년 7월 20일" - 로컬라이즈드 문자열 조합 |

## 인덱스 (Isar)
- `dueAt` 오름차순 인덱스 (홈 리스트 정렬용)
- `isArchived` 인덱스 (기본 쿼리 필터)
- 필요 시 `category` 인덱스는 나중에 추가

## 기본값 전략 (입력 속도 최적화)
- 카테고리 기본값: 마지막으로 선택한 카테고리 (SharedPreferences에 캐시)
- 시간 기본값: 09:00 (알림 받기 무난한 시간)
- 반복 기본값: `once`
- 날짜 기본값: 오늘 날짜, 시간은 09:00 (이미 지났으면 내일 09:00)

## 확장 금지 (명시)
- 태그, 우선순위, 색상, 첨부파일, 하위 할 일, 반복 종료일, 반복 횟수 제한 등 **추가 금지**.
- 추가하고 싶어지면 CLAUDE.md의 "손실 방지 포지션"을 다시 읽을 것.
