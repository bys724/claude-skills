---
name: paper-summary
description: 논문 읽기 전 과정을 함께 진행하는 스킬. 사용자가 arxiv 링크·논문 제목을 보내거나, "이 논문 읽고 싶어"·"같이 읽자"·"Zotero에서 가져왔어 정리해줘" 등을 말할 때 트리거. 세 단계로 동작 — Phase 1 (arxiv MCP로 논문 파악) → Phase 2 (사용자가 PDF 읽으며 묻는 질문에 응답) → Phase 3 (Zotero 임포트 후 Obsidian 노트 보강). 단순한 한 줄 요약 요청도 이 스킬로 시작.
---

# Paper Summary

논문 읽기의 전체 워크플로우를 지원하는 스킬. 사용자는 보통 arxiv 링크나 제목을 던지며 시작하고, Zotero·Obsidian에 노트를 정리하는 데까지 이어진다.

## Phase 1: 논문 파악 (arxiv MCP)

사용자가 논문 제목·링크를 주면:

1. `search_papers`로 검색
2. `download_paper`로 다운로드
3. `read_paper`로 전문 파악
4. 핵심 내용을 짧게 요약 — 사용자가 PDF를 열기 전에 큰 그림을 잡도록

시작 멘트: "논문을 찾아서 읽어보겠습니다."

## Phase 2: 대화형 읽기 지원

사용자는 Zotero에서 PDF를 읽으며 질문한다. 이 단계에서 나눈 대화가 Phase 3 보강의 1차 소스이므로, 답변은 즉시 휘발되지 않게 핵심을 정리해두는 게 좋다.

**Claude의 역할:**
- 기술적 질문 응답, 방법론 설명, 비교 논의
- Vocabulary Assistance (영단어 즉석 설명)
- **관련 논문 언급 시 vault 연결** (아래 참조)
- Phase 3의 "🔬 방법론 상세 이해" 섹션 소스 축적

### 관련 논문 언급 시 처리 (이 스킬의 핵심 기능)

대화 중 다른 논문이 언급되거나 조사 결과 관련 논문이 발견되면, 그 자리에서 vault와 연결해 사용자의 지식 그래프를 확장한다. 휘발성 멘션으로 끝내지 않는다.

**처리 절차:**

1. `Sources/papers/`에서 해당 논문 노트가 있는지 확인 (파일명: `[Short Title] (YYYY).md` 컨벤션)
2. **있는 경우**: `[[PaperName]]` 위키링크 + 한 줄 맥락 멘션
   - 예: `이 부분은 [[CLIP (2021)]]의 contrastive 방식과 같은 아이디어예요`
   - 의미 관계가 명확하면 typed link: `[[builds-on::PaperName]]`, `[[vs::PaperName]]`, `[[ref::PaperName]]`
3. **없는 경우**: vault 부재 표시 `「PaperName」` 사용 + `_Reading List.md`에 추가 제안
   - 사용자에게 "이 논문 Reading List에 추가해둘까요?" 라고 짧게 묻고 동의 시 진행
   - 형식: `_Reading List.md`의 우선순위 섹션 중 적절한 곳에 한 줄 추가
     ```
     - [[현재읽는논문]] 참고문헌 → "PaperName (Year)" — 한 줄 이유
     ```
   - 우선순위 판단: 직접 비교/핵심 빌딩 블록 → 🔥 / 보조 참고 → 📖 / 미분류 → 💡

논문 노트 위치, `_Reading List.md` 형식, 링크 컨벤션은 Vault CLAUDE.md (`/Users/bys724/LocalVault/Obsidian Vault/CLAUDE.md`) 기준.

### Vocabulary Assistance

사용자가 영어 단어/구만 보내면 의미 설명:

```
**[word/phrase]**
의미: [간결한 설명]

예시:
- [예시 문장 1]
- [예시 문장 2]
```

**주기적 확인:** "더 궁금한 부분 있으세요? 정리 진행할까요?"

## Phase 3: Zotero 임포트 후 보강

사용자가 "Zotero에서 가져왔어", "정리해줘" 등을 말하면 시작.

상세 절차(파일명 변경, frontmatter 검증, Vocabulary 분리, 관계 링크 등)는 [`references/zotero-enrichment.md`](references/zotero-enrichment.md) 참조.

**핵심만 다시 강조:**
- **0번 (방법론 상세 이해)이 최우선** — 대화에서 쌓은 이해를 박제하는 단계. 시간 지나면 복원 불가
- 파일명·frontmatter는 작업 시작 즉시 검증 — 깨진 채 진행하면 vault 참조가 망가짐
- **`_Reading List.md`에서 entry 제거** — 임포트된 논문이 거기 있었다면 같이 정리. 안 지우면 "읽어야 할 논문" 목록이 시그널을 잃음
- Zotero 템플릿 구조(Key Figures → Summary → Contents → Connections)는 건드리지 않음
- Phase 2에서 만들어둔 `[[PaperName]]` / `「PaperName」` 멘션을 Connections 섹션에 통합

Vault 경로 및 노트 컨벤션은 전역 CLAUDE.md 및 Vault CLAUDE.md 참조.
