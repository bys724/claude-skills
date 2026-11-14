# arxiv 주간 감시 — 클라우드 루틴 지시문

> 클라우드 루틴(`/schedule`, 매주 월요일 09:00 KST)이 이 파일을 읽고 따른다. 루틴 프롬프트는 "이 파일을 따르라"뿐이라, 내용을 바꾸려면 **이 파일만 고쳐 push**하면 다음 실행부터 반영된다.
> 클라우드 세션엔 로컬 arxiv MCP·Vault·플러그인이 없다. 그래서 arxiv 공개 API를 직접 조회하고, 결과는 Claude Docs 문서로 남긴다.

## 독자

로봇 파운데이션 모델 연구원 한 명. 관심: Robot Learning · Visual Representation · Cross-embodiment. 월요일 아침에 10분 안에 읽고 "이번 주에 무엇을 읽을지"를 정하는 용도. 한국어로 쓰고 논문 제목·용어는 원문 그대로.

## 1. 수집 (지난 7일, 제출일 기준)

arxiv API (`http://export.arxiv.org/api/query`, Atom XML)를 Bash(`curl`)로 조회한다. 요청 사이 3초 간격 (arxiv 이용 규칙). 각 쿼리는 `sortBy=submittedDate&sortOrder=descending&max_results=50`로 받고 제출일이 오늘 기준 7일 이내인 것만 남긴다.

| 주제 | 쿼리 (`search_query`) |
|---|---|
| Cross-embodiment | `abs:"cross-embodiment" OR abs:"cross embodiment" OR abs:"embodiment-agnostic"` |
| Robot foundation model / VLA | `(cat:cs.RO) AND (abs:"foundation model" OR abs:"vision-language-action" OR abs:"VLA" OR abs:"generalist policy")` |
| Visual representation for robotics | `(cat:cs.RO OR cat:cs.CV) AND (abs:"visual representation" OR abs:"pretrained representation") AND (abs:robot OR abs:manipulation)` |
| World model / video for control | `(cat:cs.RO OR cat:cs.LG) AND (abs:"world model" OR abs:"video prediction") AND (abs:robot OR abs:policy)` |

`curl`이 네트워크 제한으로 실패하면 WebSearch로 같은 주제를 `arxiv.org <주제> <이번 달 연도>`로 찾는다. 이 경우 보고서 맨 위에 "API 접근 실패 → 웹 검색으로 대체(누락 가능)"라고 적는다.

중복(여러 주제에 걸린 논문)은 하나로 합친다.

## 2. 선별

전부 나열하지 않는다. 독자 관심과의 직접성으로 고른다:

- **꼭 읽을 것 (최대 5편)**: 독자의 세 관심사 중 하나에 새 방법·새 결과를 직접 내는 논문. 대형 랩·대규모 실로봇 실험·새 벤치마크는 가점
- **훑어볼 것 (최대 10편)**: 관련은 있으나 점진적 개선·응용
- 나머지는 버린다. 고른 근거는 초록에서 확인된 것만 쓴다 — 초록에 없는 성능·주장을 지어내지 않는다

## 3. 보고서 → Claude Docs

Claude Docs 커넥터로 새 문서를 만든다. 제목: `arxiv 주간 — YYYY-MM-DD` (월요일 날짜). 커넥터 사용법은 그 커넥터의 `guide`를 먼저 읽고 따른다.

문서 구조:

1. **이번 주 한 줄** — 흐름이 있으면 그 흐름 (예: "VLA의 action tokenizer 비교가 몰림"). 없으면 "뚜렷한 흐름 없음"
2. **꼭 읽을 것** — 표: 제목(arxiv 링크) · 저자/소속(초록·메타데이터에 있으면) · 핵심 아이디어 한 문장 · 왜 독자에게 중요한가 한 문장
3. **훑어볼 것** — 한 줄씩: 제목(링크) — 한 구절
4. **수집 통계** — 주제별 조회 건수 · 7일 이내 건수 · 선별 건수 (실패한 쿼리가 있으면 여기에)

문서 외에 다른 곳(저장소 커밋·PR·이메일)에는 아무것도 쓰지 않는다. 세션 마지막 메시지는 문서 링크 한 줄.
