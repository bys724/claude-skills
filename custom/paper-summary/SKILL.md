---
name: paper-summary
description: "This skill should be used when the user sends an arxiv link, paper title, DOI, or says \"\uc774 \ub17c\ubb38 \uc77d\uace0 \uc2f6\uc5b4\", \"\uac19\uc774 \uc77d\uc790\", \"Zotero\uc5d0\uc11c \uac00\uc838\uc654\uc5b4 \uc815\ub9ac\ud574\uc918\", \"\uc774 \ub17c\ubb38 \uc694\uc57d\ud574\uc918\", \"\ub17c\ubb38 \uc815\ub9ac\", or any paper-related request. Covers the full paper reading workflow: Phase 1 (arxiv MCP overview) \u2192 Phase 2 (deep reading Q&A) \u2192 Phase 3 (Zotero import + Obsidian note enrichment). The goal is personalized note creation, not generic summarization \u2014 integrating the paper into the user's knowledge graph. Even simple one-line summary requests should trigger this skill."
---

# Paper Summary

**핵심 목표**: generic 논문 요약이 아니라 **사용자 개인의 정리** — 사용자의 이해·발견 경위·연구 맥락·vault 지식 그래프에 통합되는 노트를 만드는 게 이 스킬의 존재 이유. 같은 논문이라도 산출물은 사람마다 달라야 한다.

이 원칙이 각 단계의 *왜*를 결정한다:

- 사용자가 직접 쌓은 이해 → "🔬 방법론 상세 이해"로 박제 (외부 요약과 구분되는 산출물)
- 어디서 발견했고 왜 읽었는지 → Reading Origin (시간 지나도 회상 가능)
- 사용자 연구와의 연결 → Summary에 한 줄 (이 논문이 *내게* 의미하는 것)
- Vault에 이미 있는 논문 → typed link로 연결 (지식 그래프 확장)
- 사용자 어휘 학습 → Vocabulary.md 분리 (Vault Quiz 시스템과 연동)

네 단계로 동작: Phase 0(어휘 퀴즈) → Phase 1(큰 그림) → Phase 2(읽으며 이해 축적) → Phase 3(이해를 vault 노트로 박제). Zotero·Obsidian이 통합 도구. 사용자 연구 맥락은 전역 CLAUDE.md 참조.

## Phase 0: Vocabulary Quiz (선택)

논문 읽기 전 Vocabulary.md에서 미숙달 단어 3개를 골라 퀴즈. 어휘 학습 사이클의 시작점 — Phase 2에서 새 단어를 만나고, Phase 3 §7에서 등록하고, 다음 세션 Phase 0에서 복습.

**진행:**
1. Vault의 `Vocabulary.md` 읽기 (없으면 Phase 0 skip)
2. ✅ 아닌 단어 중 3개 선택 (전부 ✅면 skip)
3. 단어별로 영어 예문을 제시 → 사용자가 한국어 의미 답변
4. 채점: 정답이면 마커 승급 (없음 → ✓ → ✓✓ → ✅), 오답이면 유지
5. 결과를 Vocabulary.md에 반영

**Skip 조건:** 파일 없음 / 전부 마스터 / 사용자가 "넘어가자" / 세션 재시작(이미 한 번 했으면)

퀴즈 후 "논문 읽기 시작할까요?" 로 Phase 1 진입.

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

논문 노트 위치, `_Reading List.md` 형식, 링크 컨벤션은 Vault CLAUDE.md 기준 (Vault 경로는 전역 CLAUDE.md "주요 경로" 참조).

### Vocabulary Assistance

사용자가 영어 단어/구만 보내면 의미 설명:

```
**[word/phrase]**
의미: [간결한 설명]

예시:
- [예시 문장 1]
- [예시 문장 2]
```

**확인 타이밍:** 대화가 일단락될 때 "정리 진행할까요?"라고 짧게 — 매 답변마다 기계적으로 묻지 않음

## Phase 3: Zotero 임포트 후 보강

사용자가 "Zotero에서 가져왔어", "정리해줘" 등을 말하면 시작.

상세 절차(파일명 변경, frontmatter 검증, Vocabulary 분리, 관계 링크 등)는 [`references/zotero-enrichment.md`](references/zotero-enrichment.md) 참조.

**핵심만 다시 강조:**
- **0번 (방법론 상세 이해)이 최우선** — 대화에서 쌓은 이해를 박제하는 단계. 시간 지나면 복원 불가
- **1번 Reading Origin (출처·동기) 작성** — "어디서 발견했고 왜 읽었는지" 한 줄. 미래의 자신이 회상할 때 가장 먼저 보는 정보
  - `_Reading List.md`에 entry가 있었다면 그 형식(`[[원본 논문]] 참고문헌 → "제목" — 한 줄 이유`)을 출처·이유로 그대로 사용
  - 없거나 부족하면 Phase 1·2 대화에서 유추한 안을 사용자에게 제시 → 동의 후 작성. 자의 판단으로 추정만 적지 않음
- **2번 Summary의 "내 연구와의 연결"** — 이 논문이 사용자 연구 맥락(전역 CLAUDE.md 사용자 정보)에서 어떤 시사점인지 한 줄. 개인화된 정리의 핵심 산출물. 무관해도 그렇다고 적기
- 파일명·frontmatter는 작업 시작 즉시 검증 — 깨진 채 진행하면 vault 참조가 망가짐
- **`_Reading List.md`에서 entry 제거** — 임포트된 논문이 거기 있었다면 같이 정리. 안 지우면 "읽어야 할 논문" 목록이 시그널을 잃음
- Zotero 템플릿 구조(Key Figures → Summary → Contents → Connections)는 건드리지 않음
- **8번 관계 링크는 적게·정확하게** — 인용·비교·lineage가 명확한 핵심 3-5개. *"같은 분야"*만으로는 링크 X. 0개도 정상. Phase 2에서 만든 `[[]]` / `「」` 멘션도 같은 기준으로 재검토 후 Connections에 통합

Vault 경로 및 노트 컨벤션은 전역 CLAUDE.md 및 Vault CLAUDE.md 참조.
