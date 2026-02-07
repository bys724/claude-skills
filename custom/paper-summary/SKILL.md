---
name: paper-summary
description: 논문 읽기 지원 스킬. Phase 1 (arxiv로 논문 파악) → Phase 2 (대화형 읽기 지원) → Phase 3 (Zotero 임포트 후 보강). 사용자가 논문 제목/링크를 주면 시작.
---

# Paper Summary Skill

논문 읽기의 전체 워크플로우를 지원하는 스킬.

## Phase 1: 논문 파악 (arxiv MCP)

사용자가 논문 제목이나 링크를 제공하면:

1. `search_papers`로 논문 검색
2. `download_paper`로 다운로드
3. `read_paper`로 전문 파악
4. 핵심 내용을 간단히 요약하여 사용자의 읽기 준비 지원

시작 멘트:
"논문을 찾아서 읽어보겠습니다."

## Phase 2: 대화형 논문 읽기 지원

사용자는 Zotero에서 논문 PDF를 읽으며 질문한다.

**Claude의 역할:**
- 기술적 질문 응답, 방법론 설명, 비교 논의
- Vocabulary Assistance (영단어 즉석 설명)
- 대화 내용이 Phase 3의 "🔬 방법론 상세 이해" 섹션 소스가 됨

**Vocabulary Assistance:**

사용자가 영어 단어/구만 보내면 의미를 설명:

```
**[word/phrase]**
의미: [간결한 설명]

예시:
- [예시 문장 1]
- [예시 문장 2]
```

**주기적 확인:**
"더 궁금한 부분 있으세요? 정리 진행할까요?"

## Phase 3: Zotero 임포트 후 보강

사용자가 "Zotero에서 가져왔으니 정리해" 등의 요청을 하면 실행.

Vault 경로는 전역 CLAUDE.md 참조.
논문 노트 위치: `Sources/papers/`

### 보강 작업 (우선순위 순)

#### 0. 방법론 상세 이해 추가 (최고 우선순위)

대화에서 나온 Q&A를 **"🔬 방법론 상세 이해"** 섹션으로 구성.

**포함 내용:**
- 전체 워크플로우/파이프라인
- 단계별 설명
- 핵심 개념 Q&A
- pseudo code, 다이어그램
- 혼란 포인트 명시적 설명

**배치:** 📋 Summary 위에

**작성 원칙:**
- 한글로 설명
- 코드/다이어그램 적극 활용
- 대화에서 나온 예시와 비유 포함
- 개요 → 세부 → 인사이트 순서

#### 1. Summary 섹션 작성

- 한 줄 요약
- 핵심 기여
- 주요 결과
- Typed links로 관련 논문 연결: `[[Paper|builds-on]]`, `[[Paper|vs]]`, `[[Paper|ref]]`

#### 2. 파일 이름 변경

Zotero camelCase → `[Short Title] (YYYY).md`

예시: `radfordLearningTransferableVisual2021.md` → `CLIP (2021).md`

#### 3. Frontmatter 검증

- 연도: arXiv 기준 (컨퍼런스 날짜 아님)
- URL: `https://arxiv.org/abs/XXXX.XXXXX` 형식
- 대규모 협업: "Open X-Embodiment Collaboration et al."
- 중복 frontmatter 제거, 들여쓰기 수정

#### 4. Figure 캡션 추가

🖼️ Key Figures의 이미지에 한글 설명 1-2문장.

```markdown
**Figure N: [간략한 제목]**
![[image-path.png]]
*[한글 설명: 핵심 내용, 왜 중요한지]*
```

#### 5. 단어 추출 → Vocabulary.md

**추출:**
- 하이라이트/노트에서 단어만 추출
- Vocabulary.md에 알파벳순 추가

**형식:**
```markdown
**word**
- 의미: [한글 설명]
- 예시: [영어 예시 1-2개]
```

**정리 (반드시 두 섹션 모두 확인):**

1. **"📌 All Highlights" 섹션**:
   - 삭제: 단어만 있는 하이라이트 (`> expedite`, `> holistic`)
   - 유지: 연구 내용 하이라이트 (기술 설명, 방법론, 결과)

2. **"✍️ Notes (Yellow)" 섹션**:
   - 삭제: 단어 번역 노트
   - 대체: `*(Vocabulary annotations have been extracted to Vocabulary.md)*`

**재등장 처리:** 새 논문에서 같은 단어가 나오면 마스터리 초기화 (✓, ✓✓, ✅ 제거)

#### 6. 관계 링크 업데이트

- 기존 논문과의 양방향 링크 확인/추가
- `「PaperName」` (vault에 없는 논문) vs `[[PaperName]]` (vault에 있는 논문)
- 관계 유형: `builds-on`, `vs`, `ref`, `related`, `applied-by`, `leads-to`

### Zotero 템플릿 구조 유지

보강 시 기존 구조를 유지: Key Figures → Summary → Contents → Connections

### 하지 말 것

- 템플릿 구조 변경 (Zotero Integrator가 관리)
- 이미지/어노테이션 수정 (플러그인이 자동 임포트)
