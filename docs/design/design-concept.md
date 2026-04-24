# DueGuard Design Concept

## 설계 철학

DueGuard의 디자인은 "빠름"과 "신뢰"를 중심으로 한다.

- **빠름**: 첫 항목 등록까지 15초. 불필요한 화면 전환, 불필요한 선택지, 불필요한 장식을 제거한다.
- **신뢰**: 알림이 실제로 걸렸다는 피드백을 즉시 준다. 예약 성공/실패 상태가 눈에 보여야 한다.
- **중립**: 일반 To-Do 앱처럼 보이면 안 된다. 금전 맥락의 앱이라는 인상이 첫 화면에서 전달되어야 한다.

과도한 브랜딩, 온보딩 슬라이드, 애니메이션, 그라데이션 배경은 금지한다.
MVP에서 디자인이 주목받을 필요 없다. 디자인은 사용자가 항목을 빨리 등록하고 알림을 믿게 만드는 도구다.

---

## 색상 시스템

Material 3 기반. 커스텀 색을 최소화해 시스템 색상과 충돌을 막는다.

### 기본 팔레트

| 역할 | 값 | 설명 |
|---|---|---|
| Primary | `#1565C0` (Blue 800) | 주요 액션, FAB, 선택 상태 |
| On Primary | `#FFFFFF` | Primary 위 텍스트/아이콘 |
| Surface | `#FAFAFA` | 카드, 배경 |
| On Surface | `#1A1A1A` | 기본 텍스트 |
| Surface Variant | `#F0F0F0` | 비활성 칩, 구분선 |
| Error | `#B00020` | 오류, 경고 배너 |
| On Error | `#FFFFFF` | 오류 위 텍스트 |

### 상태 색상

| 상태 | 색 | 용도 |
|---|---|---|
| 오늘 마감 | `#E53935` (Red 600) | 오늘 dueAt인 항목 강조 |
| 임박 (7일 이내) | `#F57C00` (Orange 700) | 임박 항목 레이블/점 |
| 예정 | `#1565C0` | 일반 예정 항목 |
| 완료 | `#757575` (Grey 600) | 완료 처리된 항목 (홈에서는 노출 안 함) |
| 알림 없음 경고 | `#F57C00` 배너 | 알림 권한 미허용 시 상단 경고 |

### 다크 모드
MVP 범위 밖. 시스템 테마는 Light로 고정한다. `ThemeMode.light`로 강제.

---

## 타이포그래피

Material 3 TypeScale 기반. 한국어에서 Roboto는 CJK 자소가 시스템 폰트로 대체되므로 별도 폰트 번들 없이 시스템 기본값을 사용한다.

| 역할 | TypeScale | 용도 |
|---|---|---|
| 화면 제목 | `titleLarge` (22sp) | AppBar 제목 |
| 카드 제목 | `titleMedium` (16sp, weight 500) | 항목 이름 |
| 카드 부제 | `bodyMedium` (14sp) | 날짜, 카테고리 |
| 칩/라벨 | `labelMedium` (12sp) | 카테고리 칩, 반복 라벨 |
| 상태 텍스트 | `bodySmall` (12sp) | "다음 알림: ..." 문구 |
| 빈 상태 본문 | `bodyMedium` (14sp, Grey 600) | 빈 화면 안내 |
| 오류 메시지 | `bodySmall` (12sp, Error) | 인풋 아래 오류 텍스트 |

---

## 컴포넌트 시스템

### 항목 카드 (ReminderCard)

```
┌─────────────────────────────────────────┐
│ [카테고리 아이콘]  제목                  │
│                   카테고리 칩  반복 라벨 │
│                   날짜 문자열            │
│                   다음 알림: ...         │
└─────────────────────────────────────────┘
```

- 오늘 마감 항목: 카드 좌측에 Red 600 세로 accent bar (4px)
- 임박 항목: 카드 좌측에 Orange 700 세로 accent bar (4px)
- 일반 예정 항목: accent bar 없음 (또는 투명)
- 카드 탭 시 상세 화면으로 이동
- trailing에 "완료" 체크버튼 (IconButton)
- 스와이프 우측: 삭제 확인 다이얼로그 트리거

### FAB (Floating Action Button)

- 홈 우측 하단 Extended FAB: "+ 항목 추가" / "+ Add Item"
- 추가 화면이 열리면 FAB 숨김
- 사이즈: `FloatingActionButton.extended`

### 카테고리 칩

- Material `FilterChip` 스타일
- 선택 시 Primary 색상, 미선택 시 Surface Variant
- 텍스트만 (아이콘 없음, MVP 단순화)

### 알림 권한 경고 배너

```
┌─────────────────────────────────────────┐
│ [!] 알림이 꺼져 있어요. 알림을 허용해야  │
│     놓치지 않습니다.  [허용하기]          │
└─────────────────────────────────────────┘
```

- Material `MaterialBanner` 사용
- 홈 화면 AppBar 바로 아래 고정 노출
- 권한 허용 후 자동 숨김

### 빈 상태 (EmptyState)

```
┌─────────────────────────────────────────┐
│                                         │
│         [아이콘 48dp]                    │
│                                         │
│         "제목 문구"                      │
│         "부제 문구"                      │
│                                         │
│         [CTA 버튼]                       │
│                                         │
└─────────────────────────────────────────┘
```

- 아이콘: Material Symbols `notifications_none`
- 배경 이미지, 일러스트 금지
- CTA 버튼은 TextButton 또는 OutlinedButton

---

## 아이콘

Material Symbols (outlined 스타일)을 사용한다. 커스텀 아이콘 에셋 추가 금지.

| 용도 | 아이콘 이름 |
|---|---|
| 홈 (바텀 탭 없음, AppBar용) | `home` |
| 항목 추가 | `add` |
| 설정 | `settings` |
| 카테고리: card | `credit_card` |
| 카테고리: subscription | `subscriptions` |
| 카테고리: utility | `bolt` |
| 카테고리: tax | `receipt_long` |
| 카테고리: insurance | `shield` |
| 카테고리: loan | `account_balance` |
| 카테고리: other | `label` |
| 알림 예약됨 | `notifications_active` |
| 알림 없음 | `notifications_off` |
| 완료 처리 | `check_circle` |
| 삭제 | `delete` |
| 뒤로가기 | `arrow_back` |

---

## 레이아웃 원칙

- 최대 너비 없음 (Android 폰 세로 모드 기준)
- 가로 패딩: `16dp`
- 카드 사이 간격: `8dp`
- 섹션 간 간격: `16dp`
- 터치 타깃 최소 `48dp`
- 바텀 네비게이션 없음. 화면 전환은 AppBar + 뒤로가기 + FAB만 사용.

---

## 전환 / 모션

- 화면 전환: Material 기본 `MaterialPageRoute` (슬라이드). 커스텀 트랜지션 금지.
- 완료 처리: 카드 사라짐 시 기본 `AnimatedList` fade-out. 과도한 체크 애니메이션 금지.
- 저장 성공: SnackBar 1회. 화면 전환 후 SnackBar는 이전 화면에서 보임.
- 오류 발생: SnackBar (빨간 배경) 또는 인풋 오류 텍스트. 다이얼로그는 삭제 확인에만 사용.

---

## 접근성

- 모든 아이콘에 `semanticsLabel` 지정 (ARB 리소스 키 기반)
- 컬러만으로 상태 구분 금지. 아이콘 또는 텍스트 병용.
- 최소 폰트 스케일 대응: `MediaQuery.textScaleFactor` 무시 금지. 레이아웃은 텍스트 크기 변화에 깨지지 않게 설계.
