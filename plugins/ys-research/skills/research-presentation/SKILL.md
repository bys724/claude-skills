---
name: research-presentation
description: "This skill should be used when the user wants to create academic or research presentation slides, or says \"\ud300 \ubbf8\ud305 \ubc1c\ud45c \uc790\ub8cc \ub9cc\ub4e4\uc5b4\uc918\", \"\uc774 \ub17c\ubb38 \ubc1c\ud45c \uc2ac\ub77c\uc774\ub4dc\", \"\uc5f0\uad6c \uc9c4\ud589 \ubc1c\ud45c\", \"\uc138\ubbf8\ub098 \uc790\ub8cc\", \"deck \ub9cc\ub4e4\uc5b4\uc918\", or mentions creating slides for paper introductions, literature reviews, research ideas, or progress reports. Pulls paper notes and concept notes from the Obsidian vault to compose slides. Covers single-paper intro, multi-paper comparison, research idea sharing, progress reports, and literature review presentations. Not for internal status updates or general business decks."
---

# Research Presentation

대화하며 반복적으로 개선하는 학술 발표 자료 제작 스킬. 한 번에 완성하지 않고 단계별로 사용자 피드백을 받으며 진행.

## Workflow

### Phase 1: 발표 목적·내용 확인

사용자에게 질문:

1. **발표 주제**: 논문 소개(단일/비교) / 연구 아이디어 / 동향 정리 / 진행 상황
2. **청중**: 팀 내부(기술 상세) / 외부(하이레벨)
3. **시간**:
   - 10분 이하: 5-7 슬라이드
   - 15-20분: 10-12 슬라이드
   - 30분+: 15-20 슬라이드
4. **디자인 테마**: Classic Academic / Modern Research / Bold Presentation / Minimal Professional / Custom — 색상 디테일은 [`references/themes.md`](references/themes.md)
5. **참조 자료**: Obsidian vault 활용 여부
   - 논문 노트 (`Sources/papers/XXX.md`)
   - 개념 노트 (`Concepts/XXX.md`)
   - 연구 컨텍스트 (`RESEARCH_CONTEXT.md`)

### Phase 2: 구조 제안

발표 목적에 맞는 슬라이드 구조 제안. 사용자 피드백으로 조정.

**논문 소개:**
1. Title & Motivation
2. Problem Statement
3. Related Work (간략히)
4. Proposed Method
5. Key Results
6. Discussion & Takeaways

**연구 아이디어:**
1. Background & Motivation
2. Current Limitations
3. Our Idea
4. Expected Contributions
5. Challenges & Next Steps

**연구 동향:**
1. Overview of the Field
2. Recent Advances (논문 2-3개)
3. Key Techniques/Trends
4. Future Directions

### Phase 3: 내용 초안 (마크다운)

각 슬라이드를 마크다운으로 작성. PPT 변환 전 단계라 빠르게 검토·수정 가능.

```markdown
## Slide 1: Title
**제목**: [논문명 또는 발표 주제]
**부제**: [간단한 설명]
**발표자**: [이름]
**날짜**: [날짜]

---

## Slide 2: Motivation
**Why This Matters**
- Point 1
- Point 2
- Point 3

**Visual**: [다이어그램 설명]
```

**Vault 활용:**
- 논문 노트에서 핵심 기여·결과 추출 → Related Work / Method 슬라이드
- 개념 노트에서 정의·수식 → Method 설명
- 관련 논문 링크 자동 표기

### Phase 4: 반복 개선

사용자와 대화하며 슬라이드 순서·내용·강조점 조정. 시각 자료(Mermaid 다이어그램 등)도 이 단계에서 초안 제시.

### Phase 5: PPT 파일 생성

최종 승인 후 공식 pptx 스킬의 html2pptx 워크플로우로 .pptx 생성. 선택한 테마는 `references/themes.md`의 색상·배경에 따라 자동 적용.

## Key Features

### Obsidian Vault 통합

```
Sources/papers/DINO (2021).md에서:
- 핵심 기여: "Self-distillation with momentum teacher"
- 주요 결과: "Semantic segmentation without labels"
→ Related Work 슬라이드에 자동 삽입

Concepts/EMA (Exponential Moving Average).md에서:
- 정의·수식 → Method 설명 슬라이드
```

### 학술 발표 템플릿

- Single Paper Deep Dive
- Paper Comparison (2-3 papers)
- Research Proposal
- Progress Update
- Literature Review

### 비주얼 제안

각 슬라이드에 적합한 시각 자료 제안 → Mermaid로 초안 → 사용자 확인 후 PPT 삽입.

- **Process flow**: "Step 1 → Step 2 → Step 3"
- **Architecture**: 모델 구조 다이어그램
- **Comparison table**: 논문 비교표
- **Results**: 그래프·차트

### 레퍼런스 관리

마지막 슬라이드에 References 섹션 자동 생성 (논문명·저자·연도).

## Example

```
사용자: "DINO 논문을 팀에 소개하는 발표 자료 만들어줘"

Claude: "몇 가지 확인할게요:
1. 청중: 팀 내부 기술 미팅인가요?
2. 시간: 몇 분 발표인가요?
3. 디자인 테마 (Classic / Modern / Bold / Minimal / Custom)?
4. Obsidian vault의 DINO.md 노트를 활용할까요?"

사용자: "팀 내부 15분, Modern Research 테마, vault 활용해줘"

Claude: "Modern Research 테마(Teal & Emerald)로 제작하겠습니다. 구조 제안:
1. Title & Motivation
2. Problem: Why Self-Supervised Learning?
3. DINO Method (EMA + Self-Distillation)
4. Key Results (Segmentation without labels)
5. Comparison with CLIP
6. Takeaways for Our Research"

[반복 개선...]

사용자: "완성이야, PPT 만들어줘"
→ html2pptx로 .pptx 생성
```

## 원칙

- **대화형**: 단계별 피드백, 한 번에 완성하지 않음
- **Vault 재사용**: 이미 작성한 노트를 쓰면 시간 절약 + 일관성
- **학술 스타일**: 화려함보다 명확성·전문성

## Dependencies

- 공식 pptx 스킬의 html2pptx 워크플로우
- Obsidian vault 경로: 전역 CLAUDE.md
- markitdown, python-pptx (공식 스킬에서 제공)
