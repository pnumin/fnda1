# K-AI 조별 성과물 아카이브 디자인 시스템

## 0. Research Log

- Embedded refs: Notion, Pinterest, Wired를 후보로 검토하고 `taste-skill` + Notion을 선택했다. 따뜻한 중립색, 속삭이는 경계선, 읽기 쉬운 카드 구조가 교육 성과물 아카이브에 적합하다.
- Lazyweb: 데스크톱 갤러리 관련 2개 검색, 12개 결과 중 Are.na와 Say Studio 화면 2개를 직접 확인했다. 섹션 제목 옆 자료 수, 가로 정렬된 썸네일, 작품 우선 레이아웃을 반영한다.
- Imagen drafts: 생략. Padlet에 올라온 실제 학생 작품이 페이지의 핵심 시각 자료이며, 생성 이미지를 추가하면 성과물의 출처와 성격을 흐릴 수 있다.
- Source inventory: Padlet의 4개 팀, 콘텐츠 브리프 4개, 포스터 8개 게시물(이미지 9개), 카드뉴스 7개, 쇼츠 3개를 기준으로 구성한다.

## 1. Atmosphere & Identity

작품을 평가하거나 과장하지 않고 또렷하게 진열하는 따뜻한 아카이브다. 시그니처는 각 팀의 번호와 한 줄 핵심 문장, 그리고 원본 비율을 살린 순번 갤러리다. 페이지 장식보다 실제 결과물이 먼저 보인다.

## 2. Color

| Role | Token | Value | Usage |
|---|---|---|---|
| Surface/primary | `--surface` | `#fffefa` | 페이지 배경 |
| Surface/secondary | `--surface-soft` | `#f6f5f1` | 섹션 배경 |
| Surface/elevated | `--surface-raised` | `#ffffff` | 카드와 미디어 |
| Text/primary | `--ink` | `#1d1c1a` | 제목과 본문 |
| Text/secondary | `--ink-muted` | `#625e58` | 설명과 메타데이터 |
| Border/default | `--line` | `rgba(29,28,26,.14)` | 구획과 카드 경계 |
| Accent/primary | `--accent` | `#176a5b` | 현재 팀, 링크, 포커스 |
| Accent/hover | `--accent-strong` | `#0f5146` | 호버·활성 상태 |
| Accent/soft | `--accent-soft` | `#e6f2ee` | 배지 배경 |
| Status/empty | `--empty` | `#8c877f` | 미제출 안내 |

색상은 이 표의 토큰만 사용한다. 강조색은 상호작용과 팀 번호에만 사용한다.

## 3. Typography

기본 글꼴은 `Pretendard Variable`, `Noto Sans KR`, 시스템 산세리프 순서다. 외부 폰트 요청 없이 한글 가독성과 성능을 우선한다.

| Level | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Display | `clamp(2.5rem,7vw,5.25rem)` | 750 | 1.02 | 페이지 제목 |
| H1 | `clamp(2rem,4vw,3.5rem)` | 720 | 1.12 | 팀 제목 |
| H2 | `clamp(1.5rem,2.4vw,2rem)` | 700 | 1.2 | 자료 유형 |
| H3 | `1.125rem` | 700 | 1.35 | 카드 제목 |
| Body/lg | `1.125rem` | 500 | 1.65 | 소개문 |
| Body | `1rem` | 400 | 1.65 | 본문 |
| Body/sm | `.875rem` | 500 | 1.5 | 메타데이터 |
| Caption | `.75rem` | 650 | 1.4 | 순번과 배지 |

한국어 제목은 `word-break: keep-all`을 기본으로 하며, 좁은 화면에서만 자연스럽게 줄바꿈한다.

## 4. Spacing & Layout

기본 단위는 4px다. `--space-1` 4px, `--space-2` 8px, `--space-3` 12px, `--space-4` 16px, `--space-6` 24px, `--space-8` 32px, `--space-12` 48px, `--space-16` 64px, `--space-20` 80px을 사용한다.

- 최대 폭: 1440px
- 데스크톱: 12열 개념의 24px 거터, 자료 갤러리는 2~4열 자동 맞춤
- 모바일: 단일 열, 좌우 16px
- 브레이크포인트: 640px, 900px, 1200px
- 포스터와 카드뉴스는 DOM과 시각적 배치 모두 오름차순이다.

## 5. Components

### Team navigation
- 구조: 팀명 버튼 4개와 자료 수
- 상태: 기본, hover, active, focus
- 접근성: 실제 앵커 링크, 44px 이상 터치 영역, 현재 팀은 `aria-current`

### Team chapter
- 구조: 팀 번호, 팀명, 핵심 브리프 요약, 자료 현황, 네 가지 자료 섹션
- 상태: 자료 있음, 일부 자료 없음
- 접근성: 팀마다 독립된 `section`과 연결된 heading

### Brief card
- 구조: 문서 아이콘, 파일명, 형식, 브라우저 열기, 다운로드
- 상태: 기본, hover, focus, unavailable
- 접근성: 파일 형식과 동작을 링크 텍스트에 포함

### Ordered media gallery
- 구조: `ol` 안의 번호 배지, 원본 비율 이미지, 제목, 다운로드 링크
- 상태: 기본, hover, focus, empty
- 접근성: 의미 있는 대체 텍스트, 번호를 텍스트로도 제공

### Shorts player
- 구조: 세로형 `video`, 제목, 재생시간, 다운로드
- 상태: poster, playing, error, unavailable
- 접근성: 기본 브라우저 컨트롤, 음소거 자동재생 금지

### Primitive showcase
- 최종 페이지의 상단 팀 탐색과 1팀 섹션 자체를 상태 하네스로 사용한다. 링크/카드의 hover, focus, active와 자료 없음 상태를 CSS에서 함께 정의한다.

## 6. Motion & Interaction

- 동작 강도 2/10: 작품 감상을 방해하지 않는 140ms 색상·변형 피드백만 사용한다.
- 팀 탐색은 기본 앵커 이동과 `scroll-margin-top`을 사용한다.
- 카드 hover는 `translateY(-2px)`과 토큰 기반 경계색 변화만 사용한다.
- `prefers-reduced-motion: reduce`에서는 모든 전환을 제거한다.

## 7. Depth & Surface

전략은 `mixed`다. 기본 구조는 얇은 경계선과 배경 톤 차이로 구분하고, 클릭 가능한 미디어 카드에만 매우 옅은 다층 그림자를 사용한다. 그림자는 `--shadow-card` 하나로 통일한다.

## 8. Accessibility Constraints & Accepted Debt

- WCAG 2.2 AA 목표, 본문 대비 4.5:1 이상, 큰 글자 3:1 이상
- 모든 조작 요소에 2px 포커스 링과 44px 이상 터치 영역
- 키보드로 팀 탐색, 문서 열기, 이미지 다운로드, 영상 제어 가능
- 이미지와 영상에 고정 종횡비 또는 명시적 크기를 부여해 레이아웃 이동 방지
- Accepted debt: Padlet 원본에 자막 파일이 없는 쇼츠 3개는 영상 자막을 제공할 수 없다. 페이지에서 자료 출처를 표시하고 원본 파일을 그대로 제공한다.
