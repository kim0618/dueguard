# DueGuard Localization Rules

## 대원칙
1. **사용자에게 보이는 모든 문자열은 ARB 리소스에서 조회한다.** 하드코딩 금지.
2. ko, en 두 개의 ARB 파일(`app_ko.arb`, `app_en.arb`)을 **항상 동일한 key 집합**으로 유지한다. 어느 한쪽에만 있는 key는 빌드 시 린트로 걸러낸다.
3. 한국어가 소스 언어다. en은 구조 대응만 한다. (품질 보증 없음 - MVP 원칙)
4. 지원 locale은 `ko`, `en` 두 개. 그 외는 en으로 폴백.

## 파일 구조
```
lib/
  l10n/
    app_ko.arb
    app_en.arb
  generated/
    ... (flutter gen-l10n 산출물)
```
- `pubspec.yaml`에 `flutter: generate: true`.
- `l10n.yaml`에서 `arb-dir`, `template-arb-file`, `output-localization-file` 명시.
- Flutter 권장 방식(`flutter gen-l10n`)을 그대로 쓴다. 별도 i18n 라이브러리 추가 금지.

## Key 네이밍 규칙
- 소문자 snake 사용: `home_title`, `save_button`, `error_title_required`.
- 화면/기능 prefix 권장: `home_`, `item_edit_`, `settings_`, `category_`.
- 오류 메시지: `error_` prefix.
- 카테고리 라벨: `category_<enum_key>` (예: `category_card`).
- 카피 스타일 불변: prefix를 한번 정하면 리팩터 외엔 안 바꾼다.

## 날짜/시간 표현 원칙 (가장 깨지기 쉬운 구간)
1. `DateTime` 포맷팅은 반드시 `intl` 패키지의 `DateFormat`에 **locale을 명시적으로 전달**한다. `DateFormat.yMd().format(dt)`처럼 locale 생략 호출 금지 (기기 언어에 따라 뒤섞임).
2. `main.dart`에서 `initializeDateFormatting('ko')`, `initializeDateFormatting('en')` 둘 다 초기화.
3. 날짜 포맷 **패턴은 ARB의 문자열로 관리하지 않는다.** 포맷 패턴은 코드 상수로 두되, 요일/월 이름 같은 지역화 텍스트는 `intl`에 맡긴다.
4. 표준 포맷 정의:

| 용도 | ko | en |
|---|---|---|
| 리스트 카드 날짜 | `M월 d일 (E) a h:mm` | `MMM d (E) h:mm a` |
| 상세 화면 날짜 | `y년 M월 d일 (E) a h:mm` | `MMM d, y (E) h:mm a` |
| 알림 body | `M월 d일 a h:mm` | `MMM d, h:mm a` |
| 다가옴 표시 | "오늘", "내일", "모레", "N일 뒤" | "Today", "Tomorrow", "In N days" |

5. "오늘/내일/모레"류 상대 표현은 **ko에만 3단계까지** 쓴다. en은 "Today / Tomorrow / In N days"로 통일.
6. 시간은 **12시간제 + AM/PM**으로 통일. ko에서도 "오전/오후"로 표기. 24시간제는 요청 있을 때 설정으로만.

## 복수형 / 플레이스홀더
- `intl` ICU 복수 문법(`plural`)을 en 문자열에서 사용. ko는 단수/복수 구분 없이 한 문자열.
  - 예: `in_n_days` - ko: `"{n}일 뒤"`, en: `"{n, plural, =1{In 1 day} other{In {n} days}}"`.
- 숫자는 `NumberFormat`을 locale과 함께 사용. MVP에서는 통화 표시가 없으므로 정수 카운터 정도만.

## 카테고리 / enum 라벨
- 모든 enum 라벨은 ARB에서 조회. 코드 내 하드코딩된 "카드", "Card" 금지.
- 카테고리 아이콘 이름도 코드 상수 맵으로 관리. ARB에 아이콘 이름 저장 금지.

## 알림 문구
- 알림의 title/body는 **알림 예약 시점**에 현재 앱 locale로 포맷해 저장하지 않고, 알림 스케줄러가 참조하는 항목 데이터(title, dueAt)에서 **예약 시점 기준 문자열**을 만든다.
- 기기 언어를 변경해도 이전에 예약된 알림의 텍스트는 바뀌지 않는다 (flutter_local_notifications 제약). MVP 허용 범위.
- 알림 기본 문구 예시:
  - ko: "{title} - {날짜}"
  - en: "{title} - {date}"

## 하드코딩 방지 체크
- CI 또는 pre-commit에서 `grep -RnE "Text\\(['\"]" lib/` 유사 린트를 둬서, 문자열 리터럴이 `Text()` 안에 들어간 경우를 잡는다. (MVP에서는 최소한 수동 리뷰 체크리스트로 관리)
- 수동 리뷰 체크리스트: PR 마다 ARB 외 문자열 리터럴 0건 확인.

## ko/en 비대칭 허용 범위
- 카테고리 한국 맥락 예시(관리비, 자동차 보험)는 en에서 **가장 가까운 일반 표현**만 제공. 네이티브 감수는 MVP 이후.
- 스크린샷, 스토어 설명, 마케팅 카피는 ko만 작성. en은 MVP 이후.
- 에러 메시지, 토스트는 양쪽 다 존재해야 하지만, en 쪽은 직역 수준이어도 무방.

## 하지 않을 것
- RTL 지원 (아랍어/히브리어 등): 범위 밖.
- 다국어 3개 이상: 범위 밖.
- 서버에서 내려주는 동적 문자열: 서버 자체가 없음.
- 사용자가 수동으로 locale 전환: 기기 언어를 따른다. 앱 내 언어 설정 UI 만들지 않는다.
