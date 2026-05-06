# Phase 3: Zotero 임포트 후 보강 — 상세 절차

사용자가 Zotero Integrator로 논문을 임포트한 후 "정리해줘" 류 요청을 했을 때 따를 절차. SKILL.md의 Phase 3에서 호출됨.

Vault 경로는 전역 CLAUDE.md 참조. 논문 노트 위치: `Sources/papers/`.

## 작업 우선순위

아래 순서로 진행. 0번이 가장 중요 — 대화에서 축적한 이해를 노트에 박제하는 단계라 시간이 지나면 복원 불가.

## 0. 방법론 상세 이해 추가 (최고 우선순위)

대화 Phase 2에서 나온 Q&A를 **"🔬 방법론 상세 이해"** 섹션으로 구성.

**포함 내용:**
- 전체 워크플로우/파이프라인
- 단계별 설명
- 핵심 개념 Q&A
- pseudo code, 다이어그램
- 혼란 포인트 명시적 설명

**배치:** 📋 Summary 위.

**작성 원칙:**
- 한글로 설명
- 코드/다이어그램 적극 활용
- 대화에서 나온 예시·비유 포함
- 개요 → 세부 → 인사이트 순서

## 1. Summary 섹션 작성

- 한 줄 요약
- 핵심 기여
- 주요 결과
- Typed links로 관련 논문 연결: `[[Paper|builds-on]]`, `[[Paper|vs]]`, `[[Paper|ref]]`

## 2. 파일 이름 변경 (작업 시작 시 즉시)

Zotero citekey → `[Short Title] (YYYY).md`

| Before | After |
|---|---|
| `radfordLearningTransferableVisual2021.md` | `CLIP (2021).md` |
| `patelDeFMLearningFoundation2026.md` | `DeFM (2026).md` |

Citekey가 vault 전체에서 참조 깨짐을 유발하므로 가능한 한 빨리 변경.

## 3. Frontmatter 검증

가장 흔한 실수: closing `---`가 들여쓰기되어 있는 경우 → 메타데이터 전체가 깨짐. 첫 컬럼 위치 확인이 우선.

- 연도: arXiv 기준 (컨퍼런스 날짜 아님)
- URL: `https://arxiv.org/abs/XXXX.XXXXX` 형식
- 대규모 협업: `Open X-Embodiment Collaboration et al.`
- 중복 frontmatter 제거
- closing `---`은 첫 컬럼 (공백·탭 금지)

## 4. Metadata Callout 링크 수정

Zotero Integration이 중첩 링크를 생성하는 알려진 버그. 수정하지 않으면 Obsidian에서 클릭 안 됨.

**잘못된 형식 (중첩):**
```markdown
[Open]([Full Text PDF](zotero://select/library/items/XXX))
```

**올바른 형식:**
```markdown
[Open in Zotero](zotero://select/library/items/XXX)
```

또는 PDF 링크면:
```markdown
[Full Text PDF](zotero://select/library/items/XXX)
```

## 5. Figure 캡션 추가

🖼️ Key Figures의 이미지에 한글 1-2문장. 영어 캡션만 있으면 빠르게 훑을 때 의미가 안 들어옴.

```markdown
**Figure N: [간략한 제목]**
![[image-path.png]]
*[한글 설명: 핵심 내용, 왜 중요한지]*
```

## 6. 단어 추출 → Vocabulary.md

논문 노트에 영어 단어가 섞여 있으면 신호와 노이즈가 분리되지 않음. 단어는 Vocabulary.md로 분리하고 노트는 연구 내용만 남김.

**추출:**
- 하이라이트/노트에서 단어만 추출
- Vocabulary.md에 알파벳순 추가

**Vocabulary.md 형식:**
```markdown
**word**
- 의미: [한글 설명]
- 예시: [영어 예시 1-2개]
```

**노트에서 정리 (두 섹션 모두):**

1. **"📌 All Highlights"**:
   - 삭제: 단어만 있는 하이라이트 (`> expedite`, `> holistic`)
   - 유지: 연구 내용 (기술 설명, 방법론, 결과)

2. **"✍️ Notes (Yellow)"**:
   - 삭제: 단어 번역 노트
   - 대체: `*(Vocabulary annotations have been extracted to Vocabulary.md)*`

**재등장 처리:** 새 논문에서 같은 단어가 다시 나오면 마스터리 마커(✓, ✓✓, ✅) 초기화.

## 7. 관계 링크 업데이트

- 기존 논문과의 양방향 링크 확인/추가
- `「PaperName」` (vault에 없는 논문) vs `[[PaperName]]` (vault에 있는 논문)
- 관계 유형: `builds-on`, `vs`, `ref`, `related`, `applied-by`, `leads-to`
- Phase 2 대화에서 만들어둔 `[[]]` / `「」` 멘션을 Connections 섹션에 통합

## 8. `_Reading List.md` 정리

지금 임포트한 논문이 `Sources/papers/_Reading List.md`의 entry 중 하나였다면 제거. 빠뜨리면 "읽어야 할 논문" 목록이 신호를 잃는다.

**절차:**

1. `_Reading List.md`를 읽고 임포트 논문과 매칭되는 entry 탐색
   - 정확한 매칭 어려울 수 있음(임시 제목·설명만 적힌 경우) → 사용자에게 확인 후 제거
2. 매칭 entry를 해당 우선순위 섹션에서 삭제
3. 섹션 헤더와 placeholder 주석(`<!-- - 여기에 추가 -->`)은 유지

매칭 모호하면 사용자에게 물어볼 것. 자의 판단으로 다른 entry를 지우면 안 됨.

## Zotero 템플릿 구조 유지

기존 구조 유지: Key Figures → Summary → Contents → Connections.
Zotero Integrator가 관리하는 영역이라 임의 재배치하면 다음 임포트에서 충돌.

## 하지 말 것

- 템플릿 구조 변경 (Zotero Integrator가 관리)
- 이미지/어노테이션 수정 (플러그인이 자동 임포트)
