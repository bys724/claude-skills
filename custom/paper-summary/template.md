# Output Template for Paper Summary Skill

This file contains the detailed template for the comprehensive paper note. **Always read this file before generating the final output.**

---

## 📝 Comprehensive Paper Note Template

This single note combines personal context, objective content, and discussion highlights. It will later be processed by another Claude Code instance for reorganization or refinement.

```markdown
---
title: [논문 제목 - Exact title as in paper]
tags: [keyword1, keyword2, keyword3, keyword4, keyword5]
read_date: [YYYY-MM-DD]
paper_type: [Conference/Journal/ArXiv/Workshop]
---

# [논문 제목]

## 📌 Reading Context

**왜 이 논문을 읽었는가?**
[2-4 sentences about motivation from discussion:
- What problem or question led to reading this?
- How does it relate to current research interests?
- What sparked curiosity about this paper?]

**기대했던 것**
[What did I hope to learn? What questions did I want answered?]

---

## 📚 배경 지식 및 관련 개념 (Background & Related Concepts)

[Summarize key background knowledge, concepts, and prior work needed to understand this paper. Focus on content from the Related Work section and concepts discussed during conversation:

**Key Concept A**: [Brief 1-2 sentence explanation of fundamental concept]

**Key Concept B**: [Brief 1-2 sentence explanation of another important concept]

**Prior Work/Methods**: [Major research or methodologies this paper builds upon, with brief descriptions]

**Research Context**: [The broader research area or paradigm this work fits into]

Note: Focus on 3-5 essential concepts that were discussed or are crucial for understanding. Don't list everything from Related Work - only what's truly necessary for comprehension.]

---

## 🎯 핵심 아이디어 (Core Ideas)

**한 문장 요약**
[One sentence capturing the essence of this paper]

**주요 기여 (Main Contributions)**
[3-5 bullet points of key contributions:
- What problem does it solve?
- What's novel or different?
- Why does it matter?]

**핵심 접근법 (Key Approach)**
[Detailed explanation of the core methodology/approach:
- Main hypothesis or framework
- How it differs from existing work
- Key innovations or unique aspects
Include discussion points and personal understanding.]

---

## 🔬 방법론 상세 (Methodology Details)

[Comprehensive technical details, organized by what was discussed:
- Architecture/algorithm specifics
- Data collection and processing
- Experimental setup
- Implementation details
- Any technical aspects explored during conversation

Add subsections as needed based on discussion depth, e.g.:
### Model Architecture
### Training Process
### Dataset Construction]

---

## 📊 결과 및 분석 (Results & Analysis)

**주요 실험 결과**
[Key experimental findings emphasized in discussion:
- Performance metrics
- Benchmark comparisons
- What worked well]

**Ablation Studies / 분석**
[Important ablation studies or analyses discussed]

**한계점 (Limitations)**
[Acknowledged limitations or weaknesses noted during discussion]

---

## 💬 Discussion Highlights

**토론 중 나온 질문들**
[Questions asked during the conversation:
- Technical clarifications requested
- Deeper explorations of specific aspects
- Comparisons with other work]

**비교 논의한 논문들**
[Papers compared or discussed in relation to this work:
- How they relate
- Key differences or similarities
- Why the comparison matters]

**깊이 있게 다룬 주제**
[Specific topics explored in depth during discussion]

---

## 💭 Personal Evaluation & Insights

**논문에 대한 평가**
[Honest assessment based on discussion:
- Strengths: What was impressive or well-done?
- Weaknesses: What could be improved?
- Novelty: How original is this work?
- Impact: How significant is this contribution?]

**내 연구와의 연결점**
[How this relates to my own research:
- Direct applications or implications
- Techniques to potentially adopt
- Ideas inspired by this work
- How it fits into my research context]

**새로운 통찰 및 아이디어**
[New insights gained or ideas sparked:
- Unexpected connections discovered
- Novel perspectives gained
- Creative ideas for future work]

**인상 깊었던 점**
[What stood out during reading and discussion]

---

## 🔗 Related Papers & References

**관련 논문 (Typed Links)**
[Only essential papers discussed, maximum 3-5 items using Juggle format:

- [[Paper A|builds-on]] - [Specific explanation of direct dependency/usage]
- [[Paper B|vs]] - [Comparison details and experimental contrast]
- [[Paper C|ref]] - [How it provides context or background]

Use these link types:
- builds-on: Directly uses code/model/data or builds directly upon it
- vs: Direct experimental comparison or explicit methodological contrast
- ref: Referenced for background or general context]

**인용 관계 메모**
[Any additional notes about citation relationships or paper network]

---

## ❓ Questions & Future Exploration

**미해결 질문**
[Unanswered questions from the discussion:
- Aspects unclear or not fully understood
- Questions the paper didn't address
- Curiosities for deeper investigation]

**향후 읽을 논문**
[Papers to read next based on this discussion:
- Papers cited that seem important
- Related work to explore
- Foundational papers to understand better]

**시도해볼 것**
[Potential experiments or applications to try:
- Techniques to implement
- Experiments to replicate or extend
- Applications to my own work]

---

## 📝 Additional Notes

[Any other observations, thoughts, or notes from the discussion that don't fit above categories]

```

---

## Template Guidelines

### Content Principles
1. **Personal + Objective**: Blend subjective evaluation with factual content
2. **Discussion-driven**: Heavily reflect what was actually discussed
3. **Rich context**: Include enough detail for future Claude to reorganize/refine
4. **Flexible structure**: Adapt sections based on conversation flow
5. **Comprehensive**: This is the single source of truth for this paper

### Section Flexibility
- **Add sections** for deeply explored topics (e.g., "Attention Mechanism Details")
- **Merge sections** if they naturally flow together
- **Rename sections** to better match discussion (e.g., "방법론 상세" → "Network Architecture")
- **Omit sections** that weren't relevant to the discussion
- **Expand sections** that were central to the conversation

### Writing Style
- Use Korean for personal thoughts and evaluations
- Mix Korean/English naturally as discussed
- Be detailed in technical sections
- Be honest in evaluation sections
- Include specific examples from discussion

### Tags Guidelines
- Use 3-5 general English keywords for classification
- Focus on searchable categories (research area, method, domain)
- Examples: Robot, Transformer, Imitation Learning, Vision, Manipulation, VLA

---

## Output Format

When delivering the final note:

```
## 📝 Paper Note

[Complete comprehensive note following the template above, adapted to the discussion]
```

**Delivery Checklist**:
- [ ] Output is in plain markdown (no code blocks wrapping)
- [ ] All relevant sections from discussion are included
- [ ] Personal context and evaluation are present
- [ ] Technical content is detailed and accurate
- [ ] Related papers use correct typed link format: [[Paper|type]]
- [ ] Tags are general classification keywords
- [ ] Note is complete and copy-paste ready for Obsidian
