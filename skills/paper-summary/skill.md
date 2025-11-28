---
name: paper-summary
description: Interactive academic paper reading, discussion, and comprehensive note generation. Creates a single detailed note combining personal context, objective content, and discussion highlights for Obsidian. The note can later be processed by another Claude instance for reorganization. Use when researcher wants to discuss and deeply document papers.
---

# Paper Summary Skill

A comprehensive skill for interactive paper reading, discussion, and unified personalized documentation.

## Overview

This skill helps researchers:
- Read and discuss academic papers interactively
- Create a single comprehensive note that includes:
  - **Personal context**: Why read this? What did I expect?
  - **Objective content**: Core ideas, methodology, results
  - **Discussion highlights**: Questions asked, papers compared, topics explored
  - **Personal evaluation**: Honest assessment, insights, connections to own research
  - **Related papers**: Network of relationships using typed links
- Organize papers with searchable tags
- Provide rich, detailed notes that can be later reorganized by another Claude instance

## Workflow

### Phase 1: Interactive Discussion

**User provides:**
- Paper link or file
- (Optional) Initial questions or points of interest

**Claude's role:**
- Read and understand the paper
- Engage in free-form discussion
- Listen to researcher's questions, interests, and interpretations
- **Do NOT create any output documents during this phase**
- **Continuously check**: "Would you like to proceed with the final summary?"

### Phase 2: Comprehensive Note Generation

When the user confirms readiness, Claude creates **ONE** comprehensive note that will serve as the complete record of this paper.

**CRITICAL: Before generating output, READ the template.md file in this skill directory for detailed format specifications and examples.**

**Output Characteristics**:
- Single unified document combining personal and objective elements
- Ready to paste into Obsidian
- Rich enough for future Claude instance to reorganize/refine
- Includes YAML frontmatter with metadata
- Flexible structure adapted to the discussion

**Content Scope** - The note must include:

1. **📌 Reading Context**
   - Why this paper was read
   - What was expected to learn
   - Connection to current research interests

2. **🎯 Core Ideas** (Objective)
   - One-sentence summary
   - Main contributions (3-5 bullet points)
   - Key approach with technical details

3. **🔬 Methodology Details**
   - Architecture/algorithm specifics
   - Data and experimental setup
   - Implementation details discussed
   - Flexible subsections based on discussion depth

4. **📊 Results & Analysis**
   - Key experimental findings
   - Ablation studies
   - Acknowledged limitations

5. **💬 Discussion Highlights**
   - Questions asked during conversation
   - Papers compared and discussed
   - Topics explored in depth

6. **💭 Personal Evaluation & Insights**
   - Honest assessment (strengths, weaknesses, novelty, impact)
   - Connections to own research
   - New insights and ideas sparked
   - What stood out

7. **🔗 Related Papers** (Typed Links)
   - Essential papers only (3-5 max)
   - Use Juggle format: `[[Paper|builds-on]]`, `[[Paper|vs]]`, `[[Paper|ref]]`
   - Include specific explanations

8. **❓ Questions & Future Exploration**
   - Unresolved questions
   - Papers to read next
   - Experiments or applications to try

**Tag Guidelines**:
- Use 3-5 general English keywords for classification
- Focus on searchable categories: research area, method, domain
- Examples: Robot, Transformer, Imitation Learning, Vision, Manipulation, VLA
- Classification over specificity

**Typed Link Criteria**:
- **builds-on**: Directly uses code/model/data or builds directly upon it
- **vs**: Direct experimental comparison with numbers/benchmarks
- **ref**: Referenced for background or context
- Only include papers explicitly discussed

### Phase 3: Future Usage (Paper Organization & Retrieval)

Based on accumulated summaries:
- Request paper classification by specific topics or perspectives
- Get recommendations for papers related to new research directions
- Analyze connections and citation networks between papers

## Claude's Core Responsibilities

1. **Paper comprehension**: Read and understand the provided paper
2. **Discussion engagement**: Discuss researcher's questions and interests deeply
3. **Template reading**: BEFORE generating final output, read `template.md` for format specifications
4. **Comprehensive note creation**: Generate a single unified note combining personal context, objective content, and discussion highlights
5. **Progress checking**: Continuously confirm when to proceed with final output

## Note Characteristics

The comprehensive note should be:
- **Personal + Objective**: Blends subjective evaluation with factual technical content
- **Discussion-driven**: Heavily reflects what was actually discussed and explored
- **Rich in context**: Includes motivations, expectations, and connections to researcher's work
- **Honest evaluation**: Contains frank assessment of strengths, weaknesses, and significance
- **Technically detailed**: Provides enough depth on methodology and results
- **Network-aware**: Shows relationships to other papers with typed links
- **Future-oriented**: Captures questions, ideas, and next steps
- **Flexible structure**: Adapts template sections based on conversation flow
- **Reorganization-ready**: Contains enough detail for future Claude to refine/restructure

## Starting a Session

Begin new sessions with:
"Let's start the paper review process. Please provide the paper link or file, and we'll discuss it together. When you're ready, I'll create a comprehensive note for Obsidian that combines your personal context, the paper's content, and our discussion highlights."


## Additional Recommendations (with final summary)

Only recommend 1-2 papers when they meet these criteria:
- Directly related to researcher's core questions, OR
- Essential for understanding the paper's core ideas, OR
- High-impact papers in robot control field

**Recommendation format**:
"Additional reference: [Paper title or reference number] - [Brief reason to read it]"

**Important**: The researcher already has many papers to read. Don't recommend low-importance papers. Omit recommendations if there are no pressing questions or if the paper has limited impact.

## Discussion Progress Check

Regularly ask during discussion:
"Is there anything else you'd like to discuss? Or shall we proceed with creating the comprehensive note based on our conversation so far?"

## Output Delivery Format

**BEFORE generating output**: Use the Read tool to read `template.md` in this skill directory for complete format specifications.

When delivering the final note, use this format:

```
## 📝 Paper Note

[Complete comprehensive note with YAML frontmatter and all sections - copy-paste ready]
```

**Important**:
- Output is plain markdown (no code blocks wrapping the content)
- Include YAML frontmatter with title, tags, read_date, paper_type
- Use proper markdown syntax (headers, bold, lists, links)
- Ready to paste directly into Obsidian
- Follow template.md structure but adapt to discussion

## Output Example (Brief)

Here's a simplified example of how the comprehensive note should look:

```markdown
---
title: Attention Is All You Need
tags: [Transformer, NLP, Deep Learning, Attention Mechanism, Sequence-to-Sequence]
read_date: 2025-01-15
paper_type: Conference
---

# Attention Is All You Need

## 📌 Reading Context

**왜 이 논문을 읽었는가?**
최근 Vision Transformer 관련 연구를 하면서 Transformer의 기본 원리를 정확히 이해할 필요가 있었다. 특히 self-attention이 어떻게 작동하는지, 왜 이것이 효과적인지 알고 싶었다. 또한 로봇 비전 분야에 Transformer를 적용하는 최근 연구들을 이해하기 위한 기초를 다지고자 했다.

**기대했던 것**
Multi-head attention의 작동 원리, positional encoding의 필요성과 구현 방식, 그리고 왜 Transformer가 RNN을 대체할 수 있었는지에 대한 명확한 이해를 얻고자 했다.

---

## 🎯 핵심 아이디어 (Core Ideas)

**한 문장 요약**
RNN/CNN 없이 오직 attention mechanism만으로 sequence-to-sequence 모델을 구성하여 병렬화와 성능을 동시에 달성한 아키텍처.

**주요 기여 (Main Contributions)**
- Self-attention만으로 구성된 새로운 아키텍처 제안
- 병렬 처리가 가능하여 학습 시간 대폭 단축
- 기계 번역에서 SOTA 성능 달성
- 이후 NLP 전반의 표준 아키텍처로 자리잡음

**핵심 접근법 (Key Approach)**
기존 RNN/LSTM은 sequential processing으로 인해 병렬화가 어렵고 long-range dependency를 잘 포착하지 못한다. Transformer는 전체 시퀀스를 한번에 보는 self-attention을 사용하여 이 문제를 해결한다. Query, Key, Value의 개념으로 각 토큰이 다른 모든 토큰과의 관계를 학습하며, multi-head를 통해 다양한 representation subspace에서 attention을 계산한다.

---

## 🔬 방법론 상세 (Methodology Details)

### Multi-Head Attention
토론 중 왜 8개의 head를 사용하는지 질문했다. 각 head가 서로 다른 representation subspace를 학습하여 다양한 관점에서 attention을 계산할 수 있다. 예를 들어, 한 head는 구문적 관계를, 다른 head는 의미적 관계를 학습할 수 있다.

### Positional Encoding
Positional encoding은 sin/cos 함수를 사용하는데, 이는 상대적 위치 정보를 모델이 외삽(extrapolate)할 수 있게 한다. 학습된 positional embedding보다 일반화가 잘 된다는 점을 실험으로 확인했다.

---

## 📊 결과 및 분석 (Results & Analysis)

**주요 실험 결과**
WMT 2014 English-to-German에서 BLEU 28.4, English-to-French에서 41.8을 달성하며 당시 SOTA 갱신. 학습 시간은 기존 모델 대비 1/10 수준.

**한계점 (Limitations)**
긴 시퀀스에서 O(n²) 복잡도가 문제가 될 수 있다. 이미지나 오디오 같은 연속적 데이터에 바로 적용하기는 어렵다.

---

## 💬 Discussion Highlights

**토론 중 나온 질문들**
- Multi-head의 개수는 어떻게 결정하나? → Ablation study 참고
- Positional encoding vs learned embedding 차이는? → 일반화 성능 차이
- Vision에는 어떻게 적용? → Patch 기반 접근

**비교 논의한 논문들**
Seq2Seq with Attention과 비교하며 어떤 점이 근본적으로 다른지 토론. GNMT와의 성능 비교도 살펴봄.

---

## 💭 Personal Evaluation & Insights

**논문에 대한 평가**
- **Strengths**: 간결하면서도 강력한 아키텍처. 병렬화 가능성이 실용적으로 매우 중요.
- **Weaknesses**: O(n²) 복잡도가 매우 긴 시퀀스에서는 문제.
- **Novelty**: Attention을 주요 메커니즘으로 사용한 것은 혁신적.
- **Impact**: NLP 패러다임을 완전히 바꿈.

**내 연구와의 연결점**
로봇 비전에 Transformer를 적용할 때 이미지를 patch로 나누는 것이 NLP의 토큰화와 유사하다. Inductive bias가 적다는 것이 오히려 다양한 도메인에 적용 가능한 장점이 될 수 있다.

**새로운 통찰 및 아이디어**
Attention map 시각화를 통해 모델이 실제로 무엇을 학습하는지 분석하면 로봇의 시각적 추론 과정을 이해하는 데 도움이 될 것 같다.

---

## 🔗 Related Papers & References

**관련 논문 (Typed Links)**
- [[Sequence to Sequence Learning with Neural Networks|builds-on]] - Transformer의 기반이 되는 encoder-decoder 구조를 제안
- [[GNMT|vs]] - 기계 번역 성능과 학습 시간을 직접 비교
- [[Effective Approaches to Attention-based Neural Machine Translation|ref]] - Attention mechanism의 기본 개념 제공

---

## ❓ Questions & Future Exploration

**미해결 질문**
- Sparse attention 같은 변형들이 실제로 얼마나 효과적인가?
- 로봇 제어 같은 연속적 행동 공간에도 적용 가능한가?

**향후 읽을 논문**
- Vision Transformer (ViT)
- BERT (bidirectional transformer)
- Decision Transformer (RL 적용)

**시도해볼 것**
- 로봇 조작 데이터에 Transformer 적용 실험
- Attention weight 시각화 도구 구현
```

For complete templates and detailed guidelines, refer to `template.md`.
