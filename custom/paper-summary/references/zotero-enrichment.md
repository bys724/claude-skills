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

## 1. Reading Origin (출처·동기) 작성

미래의 자신이 "이 논문 왜 읽었더라"를 회상할 때 가장 빠르게 답을 얻는 정보. 본문 요약과 다르므로 Summary와 분리해서 별도 callout으로 둠.

**배치:** Metadata Callout 직후 (🖼️ Key Figures 앞).

**형식:**
```markdown
> [!note]- 📌 Reading Origin
> **출처**: [어디서 발견했는지 — 원본 논문, 강연, 트위터, arxiv 검색 등]
> **이유**: [왜 읽었는지 — 한 줄]
```

`[!note]-` 의 `-`로 기본 접힘. 정보 자체는 짧으니 노트 톤을 해치지 않음.

**소스 결정 (우선순위):**

1. **`_Reading List.md`에 entry가 있었던 경우**
   - 그 entry의 형식이 곧 출처·이유:
     ```
     - [[OpenVLA (2024)]] 참고문헌 → "DiT (2023)" — vision backbone에 transformer 적용 비교
     ```
     → **출처**: `[[OpenVLA (2024)]] 참고문헌` / **이유**: `vision backbone에 transformer 적용 비교`
   - entry가 단순한 경우(`- "제목"`만 있음) → 대화 맥락 유추로 보완

2. **`_Reading List.md`에 없거나 정보가 부족한 경우**
   - Phase 1·2 대화에서 유추: 사용자가 어떤 맥락에서 이 논문을 꺼냈는지(다른 논문에서 인용? 누가 추천? 특정 문제 해결 중?)
   - 추정안을 사용자에게 제시: `"출처: X, 이유: Y로 작성하면 어떨까요?"`
   - 사용자 동의 후 작성. 동의 못 받거나 모호하면 비워두지 말고 빈 형식만 두고 "사용자 보완 필요" 메모 남김

자의 판단으로 추정만 적지 않을 것. 정확하지 않은 origin은 미래에 더 큰 혼란.

## 2. Summary 섹션 작성

개인화된 정리의 핵심 산출물. 단순 abstract 번역이 아니라 *사용자에게 이 논문이 어떤 의미인지*가 들어가야 함.

- 한 줄 요약
- 핵심 기여
- 주요 결과
- **내 연구와의 연결** — 사용자 연구 맥락(전역 CLAUDE.md의 사용자 정보 — 관심 분야·진행 중인 프로젝트)에서 이 논문이 어떤 시사점인지 한 줄. 직접 활용 / 비교 대상 / 우회 / 무관 등으로 분류
  - 명백히 무관해도 그 사실을 한 줄로 적기 (왜 읽었는데 무관했는지 미래에 도움)
  - 모호하면 사용자에게 *"내 연구 맥락에선 X로 보이는데 맞나요?"* 라고 짧게 확인 후 작성
- Typed links로 관련 논문 연결: `[[Paper|builds-on]]`, `[[Paper|vs]]`, `[[Paper|ref]]`

## 3. 파일 이름 변경 (작업 시작 시 즉시)

Zotero citekey → `[Short Title] (YYYY).md`

| Before | After |
|---|---|
| `radfordLearningTransferableVisual2021.md` | `CLIP (2021).md` |
| `patelDeFMLearningFoundation2026.md` | `DeFM (2026).md` |

Citekey가 vault 전체에서 참조 깨짐을 유발하므로 가능한 한 빨리 변경.

### 이미지 폴더 연동

Zotero가 추출한 그림은 `Sources/paper imgs/[노트명]/` 폴더에 저장되며, 노트 내 `![[Sources/paper imgs/[노트명]/img-*.png]]` 형식으로 참조된다. 노트 파일명 변경 시 반드시 함께 수행:

1. `Sources/paper imgs/` 아래 citekey 폴더를 Short Title 형식으로 rename
2. 노트 내 모든 `![[Sources/paper imgs/OLD_NAME/...]]` → `![[Sources/paper imgs/NEW_NAME/...]]` 일괄 치환

## 4. Frontmatter 검증

가장 흔한 실수: closing `---`가 들여쓰기되어 있는 경우 → 메타데이터 전체가 깨짐. 첫 컬럼 위치 확인이 우선.

- 연도: arXiv 기준 (컨퍼런스 날짜 아님)
- URL: `https://arxiv.org/abs/XXXX.XXXXX` 형식
- 대규모 협업: `Open X-Embodiment Collaboration et al.`
- 중복 frontmatter 제거
- closing `---`은 첫 컬럼 (공백·탭 금지)

## 5. Metadata Callout 링크 수정

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

## 6. Figure 캡션 추가

🖼️ Key Figures의 이미지에 한글 1-2문장. 영어 캡션만 있으면 빠르게 훑을 때 의미가 안 들어옴.

```markdown
**Figure N: [간략한 제목]**
![[image-path.png]]
*[한글 설명: 핵심 내용, 왜 중요한지]*
```

## 7. 단어 추출 → Vocabulary.md

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

## 8. 관계 링크 업데이트 (Connections)

이 논문과 vault 내 다른 논문들 사이의 관계를 검토해서 typed link로 연결. **목표는 지식 그래프 확장이지 카테고리 분류가 아님 — 적고 명확한 링크가 많고 약한 링크보다 훨씬 가치 있다.** 관련 없으면 추가 안 하는 게 정상.

### 후보 수집 (우선순위 순)

1. **이 논문이 인용·참고한 논문** — 가장 강한 후보. References/Bibliography 또는 본문에서 직접 인용한 논문
2. **본문에서 비교·대비한 논문** — `"Unlike X"` / `"Building on Y"` 같은 명시적 언급. 보통 abstract·intro·related work에 등장
3. **Phase 2 대화에서 등장한 논문** — 사용자와의 대화에서 비교·논의된 논문. `[[]]` / `「」` 멘션 모두 재검토 — `「」` 멘션은 그동안 vault에 추가됐을 수도 있으니 다시 매칭

### Vault 매칭

각 후보를 `Sources/papers/`에서 검색 (파일명·title·alias 기준). 매칭되면 typed link 후보로 채택, 안 되면 `「」`로만 표기 (link 만들지 않음).

### 연결 vs 보류 판단 (가드레일 — 폭증 방지의 핵심)

**연결 O** — 다음 중 하나라도 명확하면:
- 이 논문이 빌드업한 lineage (`builds-on`)
- 본문에서 explicit comparison (`vs`)
- 핵심 인용 (`ref`) — *단순 references 리스트 등장이 아니라 본문 논의에서 의미 있게 다뤄진* 경우만
- 응용·연쇄 (`applied-by`, `leads-to`)

**연결 X** — 다음에 해당하면 링크하지 않음:
- "같은 분야/카테고리" 정도의 약한 관련성
- references에 이름은 있으나 본문 논의에 안 등장
- 표면적 키워드 중복뿐

판단 모호하면 사용자에게 짧게 확인 (`"[[X]]는 ref / 무관 어느 쪽으로 보세요?"`).

### 양 제한

- 핵심 **3-5개**가 목표. 더 필요해 보이면 사용자 동의 받고 추가
- 후보가 많아 보일 때 가드레일을 *더* 엄격하게 — *"이 논문을 이해하는 데 꼭 필요한 link인가?"*
- 0개도 OK — 관련성 약하면 비워두는 게 잘못된 link보다 낫다

### 양방향 링크 (선택)

Connections에 추가한 링크 중 **핵심 1-2개**에 한해 상대 논문 노트도 역방향 link가 가치 있는지 검토. 가치 있으면 사용자에게 짧게 확인:

> `"[[상대 논문]]에도 [[이 논문|vs]] 링크 추가할까요?"`

자동으로 상대 노트를 변경하지 않음.

### 링크 형식 정리

- vault에 있음: `[[PaperName]]` 또는 typed `[[PaperName|builds-on]]`
- vault에 없음: `「PaperName」` (link로 만들지 않고 텍스트만)
- Phase 2에서 만든 멘션 그대로 통합

## 9. `_Reading List.md` 정리

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
