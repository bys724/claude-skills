---
skill-id: research-presentation
skill-name: Research Presentation
description: Create academic/research presentation slides for team meetings. Integrates with Obsidian vault to pull paper notes and concepts.
user-invocable: true
---

# Research Presentation Skill

대화하며 반복적으로 개선하는 연구 발표 자료 제작 스킬입니다.

## Overview

팀 미팅이나 세미나를 위한 PPT 발표 자료를 만듭니다. Obsidian vault의 논문 노트와 개념 노트를 활용하여 자동으로 내용을 구성합니다.

## Workflow

### Phase 1: 발표 목적 및 내용 확인

사용자에게 질문:
1. **발표 주제**: 무엇에 대한 발표인가?
   - 논문 소개 (단일 논문 또는 여러 논문 비교)
   - 연구 아이디어 공유
   - 연구 동향 정리
   - 프로젝트 진행 상황

2. **청중**: 누구에게 발표하나?
   - 팀 내부 (기술 상세)
   - 외부/일반 청중 (하이레벨)

3. **시간**: 발표 시간?
   - 10분 이하: 5-7 슬라이드
   - 15-20분: 10-12 슬라이드
   - 30분+: 15-20 슬라이드

4. **디자인 테마**: 어떤 스타일?
   - **Classic Academic** (Navy #1C2833, Gray #2E4053, Silver #AAB7B8)
     - 전통적이고 신뢰감 있는 학술 발표
   - **Modern Research** (Teal #5EA8A7, Emerald #2ECC71, Cream #FAF7F2)
     - 현대적이고 깔끔한 느낌
   - **Bold Presentation** (Deep Blue #2C3E50, Bright Orange #E67E22, White)
     - 강렬하고 기억에 남는 발표
   - **Minimal Professional** (Black #2C3E50, White #ECF0F1, Accent #3498DB)
     - 미니멀하고 전문적인 느낌
   - **Custom** (사용자가 색상 직접 지정)

5. **참조 자료**: Obsidian vault 활용?
   - 특정 논문 노트 (`Sources/papers/XXX.md`)
   - 개념 노트 (`Concepts/XXX.md`)
   - 연구 컨텍스트 (`RESEARCH_CONTEXT.md`)

### Phase 2: 구조 제안

발표 목적에 맞는 슬라이드 구조 제안:

**논문 소개 발표:**
1. Title & Motivation
2. Problem Statement
3. Related Work (간략히)
4. Proposed Method
5. Key Results
6. Discussion & Takeaways

**연구 아이디어 발표:**
1. Background & Motivation
2. Current Limitations
3. Our Idea
4. Expected Contributions
5. Challenges & Next Steps

**연구 동향 발표:**
1. Overview of the Field
2. Recent Advances (논문 2-3개)
3. Key Techniques/Trends
4. Future Directions

사용자 피드백 받고 구조 조정.

### Phase 3: 내용 초안 생성

각 슬라이드의 내용을 **마크다운 형식**으로 작성:

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

**Obsidian vault 활용:**
- 논문 노트에서 핵심 내용 추출
- 개념 노트에서 설명 가져오기
- 관련 논문 링크 자동 표기

### Phase 4: 반복 개선

사용자와 대화하며:
- 슬라이드 순서 조정
- 내용 추가/삭제
- 강조점 변경
- 시각 자료 제안

### Phase 5: PPT 파일 생성

최종 승인 후, 공식 pptx 스킬의 html2pptx 워크플로우 사용하여 PPT 파일 생성.

**디자인 원칙 (학술 발표):**

선택한 테마 자동 적용:

**Classic Academic Theme:**
- 주 색상: Navy (#1C2833)
- 보조 색상: Gray (#2E4053), Silver (#AAB7B8)
- 배경: Off-white (#F4F6F6)
- 강조: Deep blue
- 분위기: 전통적, 신뢰감, 학술적

**Modern Research Theme:**
- 주 색상: Teal (#5EA8A7)
- 보조 색상: Emerald (#2ECC71)
- 배경: Cream (#FAF7F2)
- 강조: Deep teal (#277884)
- 분위기: 현대적, 깔끔, 혁신적

**Bold Presentation Theme:**
- 주 색상: Deep Blue (#2C3E50)
- 보조 색상: Bright Orange (#E67E22)
- 배경: White (#FFFFFF)
- 강조: Orange
- 분위기: 강렬, 기억에 남는, 임팩트

**Minimal Professional Theme:**
- 주 색상: Dark Gray (#2C3E50)
- 보조 색상: Light Gray (#ECF0F1)
- 배경: White (#FFFFFF)
- 강조: Blue (#3498DB)
- 분위기: 미니멀, 세련, 전문적

**공통 원칙:**
- **폰트**: Arial, Helvetica (가독성 최우선)
- **레이아웃**: 명확한 계층 구조, 여백 충분
- **일관성**: 모든 슬라이드에 테마 일관 적용

## Key Features

### 1. Obsidian Vault 통합

**논문 노트 활용:**
```
Sources/papers/DINO (2021).md에서:
- 핵심 기여: "Self-distillation with momentum teacher"
- 주요 결과: "Semantic segmentation without labels"
→ Related Work 슬라이드에 자동 삽입
```

**개념 노트 활용:**
```
Concepts/EMA (Exponential Moving Average).md에서:
- 정의와 수식 가져오기
- Method 설명 슬라이드에 삽입
```

### 2. 학술 발표 템플릿

**기본 제공 템플릿:**
- Single Paper Deep Dive
- Paper Comparison (2-3 papers)
- Research Proposal
- Progress Update
- Literature Review

### 3. 비주얼 제안

각 슬라이드에 적합한 시각 자료 제안:
- **Process flow**: "Step 1 → Step 2 → Step 3" 다이어그램
- **Architecture**: 모델 구조 다이어그램
- **Comparison table**: 논문 비교표
- **Results**: 그래프, 차트

Mermaid 다이어그램으로 초안 제공 → 사용자 확인 후 PPT에 삽입.

### 4. 레퍼런스 관리

모든 인용 논문 자동 추적:
- 마지막 슬라이드에 References 섹션
- 논문명, 저자, 연도 자동 표기

## Example Usage

```
사용자: "DINO 논문을 팀에 소개하는 발표 자료 만들어줘"

Claude: "알겠습니다! 몇 가지 질문드릴게요:
1. 청중: 팀 내부 기술 미팅인가요?
2. 시간: 몇 분 발표인가요?
3. 디자인 테마:
   - Classic Academic (전통적)
   - Modern Research (현대적)
   - Bold Presentation (강렬)
   - Minimal Professional (미니멀)
   어떤 스타일을 선호하시나요?
4. Obsidian vault의 DINO.md 노트를 활용할까요?"

사용자: "응, 팀 내부고 15분 발표야. Modern Research 테마로, vault 활용해줘"

Claude: "좋습니다! Modern Research 테마 (Teal & Emerald)로 제작하겠습니다.
구조는 이렇게 제안드립니다:
1. Title & Motivation
2. Problem: Why Self-Supervised Learning?
3. DINO Method (EMA + Self-Distillation)
4. Key Results (Segmentation without labels)
5. Comparison with CLIP
6. Takeaways for Our Research

이 구조로 진행할까요?"

사용자: "좋아, 5번에 PVM in MBRL과의 연결도 추가해줘"

Claude: "추가했습니다! 각 슬라이드 초안을 보여드릴게요..."

[반복 개선...]

사용자: "완성이야, PPT 파일 만들어줘"

Claude: [html2pptx로 파일 생성]
"완료! research_dino_presentation.pptx 파일이 생성되었습니다."
```

## Important Notes

- **대화형**: 한 번에 완성하지 않고 단계별로 피드백 받음
- **Vault 활용**: 이미 작성한 노트를 재사용하여 시간 절약
- **학술 스타일**: 화려함보다 명확성과 전문성 우선
- **유연성**: 템플릿을 제안하되, 사용자 요구에 맞게 자유롭게 조정

## Dependencies

- 공식 pptx 스킬의 html2pptx 워크플로우 활용
- Obsidian vault 경로: 전역 CLAUDE.md 참조
- markitdown, python-pptx (공식 스킬에서 제공)
