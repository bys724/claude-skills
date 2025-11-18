---
name: paper-summary
description: Interactive academic paper reading, discussion, and dual output generation (Zotero summary for quick reference + Obsidian note for deep study). Creates personalized Korean notes with typed links for building paper networks. Use when researcher wants to discuss and summarize papers.
---

# Paper Summary Skill

A comprehensive skill for interactive paper reading, discussion, and dual-format personalized documentation.

## Overview

This skill helps researchers:
- Read and discuss academic papers interactively
- Create two complementary documents:
  - **Zotero Summary**: Quick reference card with objective overview and paper relationships
  - **Obsidian Note**: Detailed study note with personalized insights and flexible structure
- Build a network of paper relationships using typed links
- Organize papers with searchable tags

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

### Phase 2: Dual Output Documents

When the user confirms readiness, Claude creates **TWO** separate documents:

**Output Format Guidelines**:
- Present each document in a clearly labeled markdown code block for easy copying
- Label each output clearly: "## 📋 Zotero Summary" and "## 📝 Obsidian Note"
- Provide complete, copy-paste ready markdown
- Separate the two outputs visually with clear headers
- No additional formatting or commentary within the output blocks

#### 2A. Zotero Summary (Quick Reference Card)

**Purpose**: Fast reference for paper overview and relationships
**Format**: Concise and objective
**Usage**: Saved as Zotero note, later imported to Obsidian via Zotero Integration plugin

---

**[Same title as the paper]**

**Tags**: [3-5 general English keywords for search/filtering]

*Tag Guidelines:*
- **Purpose**: Used as filters for future paper searches
- **Classification over specificity**: Focus on general categories rather than unique features
- **Key classification dimensions** (examples based on field):
  - *Major area*: Robot, Vision, Robot Vision
  - *Learning method*: Imitation Learning, Reinforcement Learning, Unsupervised Learning, Self-Supervised Learning
  - *Architecture*: Transformer, CNN, ViT, Diffusion, Hybrid
  - *Domain/Application*: Manipulation, Navigation, Humanoid, Mobile Robot
  - *Input modality*: Vision-Only, Language-Conditioned, Multi-Modal
  - *Model type*: Foundation Model, Generative Model, VLA

*Note*: These categories are examples. Choose the most appropriate classification keywords based on the paper's core contribution and research area. Don't be constrained by order or combinations—use keywords that work best as filters for finding this paper.

**핵심 요약**:
[2-3 paragraphs summarizing the paper's main contribution, methodology, and results in an objective manner. Anyone should be able to understand the paper from this summary.]

**Related Papers**:
[Only truly essential papers, maximum 3-4 items. Use Juggle typed links format]

- [[Paper A|builds-on]] - This work directly uses the method/model/data from Paper A. [Specific explanation]
- [[Paper B|vs]] - Experimental comparison of performance or methodology. [Specific explanation]
- [[Paper C|ref]] - Referenced for background or general context. [Specific explanation]

*Typed link classification criteria:*
- **builds-on**: Directly uses code/model/data from that paper or builds directly upon it
- **vs**: Direct experimental comparison with numbers/benchmarks or explicit contrast
- **ref**: Mentioned for background or context

*Paper inclusion criteria (apply very strictly)*:
- **Core papers directly related to questions the researcher explicitly asked in discussion**
- **Original or most representative papers for the methodology/algorithm proposed in this work**
- **Most recent or representative papers among comparison baselines**
- **Exclude papers merely mentioned in intro or used as generic comparison baselines**
- **Only include papers the researcher explicitly emphasized in the discussion**

---

#### 2B. Obsidian Note (Deep Study Note)

**Purpose**: Deep understanding and research application
**Format**: Detailed and personalized based on discussion
**Usage**: Separate Obsidian note for in-depth study

**Base Structure** (adapt flexibly based on discussion):

---

**[Same title as the paper]**

**왜 이 논문을 읽었나?**
[Context and motivation from the discussion. What sparked interest?]

**핵심 아이디어**
[Detailed explanation of core ideas, reflecting discussion points and researcher's interpretation]

**방법론 상세**
[Technical details, especially aspects discussed or questioned during conversation]

**주요 결과 및 분석**
[Important results and analysis, focusing on what was emphasized in discussion]

**개인적 통찰**
[Personal insights from discussion, connections to other research, implications]

**의문점 / 추후 탐구사항**
[Remaining questions or areas for further exploration]

---

**Flexibility Guidelines for Obsidian Note**:
- The above structure is a **starting template**
- **Adapt sections based on discussion content**:
  - Add sections if specific topics were deeply explored (e.g., "Data Collection Process", "Comparison with Method X")
  - Merge sections if they naturally flow together
  - Rename sections to better match the discussion focus
  - Reorder sections to reflect logical flow of conversation
- **Prioritize discussion-driven content**: If certain aspects weren't discussed, keep them brief or omit
- **Include conversation highlights**: Questions asked, comparisons made, insights gained
- The goal is a **personalized study note** that captures deep understanding, not just a structured template

### Phase 3: Future Usage (Paper Organization & Retrieval)

Based on accumulated summaries:
- Request paper classification by specific topics or perspectives
- Get recommendations for papers related to new research directions
- Analyze connections and citation networks between papers

## Claude's Core Responsibilities

1. **Paper comprehension**: Read and understand the provided paper
2. **Discussion engagement**: Discuss researcher's questions and interests
3. **Dual document creation**: Generate both Zotero Summary and Obsidian Note based on discussion
4. **Progress checking**: Continuously confirm when to proceed with final outputs

## Document Characteristics

### Zotero Summary
- **Objective and concise**: 2-3 paragraphs anyone can understand
- **Focus on "What"**: What did this paper do? What are the results?
- **Paper relationships**: Typed links to essential related papers only
- **English keyword tags**: General classification keywords for search/filtering
- **Standardized format**: Consistent structure for quick reference

### Obsidian Note
- **Personalized and detailed**: Reflects researcher's perspective and discussion
- **Focus on "Why & How"**: Why is this important? How does it work? How to apply it?
- **Discussion-driven**: Content shaped by conversation highlights and questions
- **Flexible structure**: Adapt template based on what was actually discussed
- **Includes insights**: Personal thoughts, connections, remaining questions

## Starting a Session

Begin new sessions with:
"Let's start the paper review process. Please provide the paper link or file, and we'll discuss it together. When you're ready, I'll create two documents: a Zotero summary for quick reference and a detailed Obsidian note for deep study."


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
"Is there anything else you'd like to discuss? Or shall we proceed with creating the Zotero summary and Obsidian note based on our conversation so far?"

## Output Delivery Format

When delivering the final documents, use this exact format:

```
## 📋 Zotero Summary

[Full Zotero summary content in markdown - copy-paste ready]

---

## 📝 Obsidian Note

[Full Obsidian note content in markdown - copy-paste ready]
```

**Important**:
- Each document should be complete and ready to copy-paste directly into Zotero/Obsidian
- Use proper markdown syntax (headers, bold, lists, links)
- No code block wrapping around the content (the content itself is plain markdown)
- Clearly separate the two outputs with visual dividers
- Present outputs sequentially: Zotero Summary first, then Obsidian Note
