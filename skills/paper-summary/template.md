# Output Templates for Paper Summary Skill

This file contains the detailed templates for the two output documents. **Always read this file before generating the final outputs.**

---

## 📋 Zotero Summary Template

```markdown
**[논문 제목 - Same title as the paper]**

**Tags**: [keyword1, keyword2, keyword3, keyword4, keyword5]

**핵심 요약**:
[First paragraph: Main contribution and problem being solved]

[Second paragraph: Methodology and approach]

[Third paragraph: Key results and implications]

**Related Papers**:
- [[Paper A|builds-on]] - [Specific explanation of how this work directly uses/builds upon Paper A]
- [[Paper B|vs]] - [Specific comparison details and experimental results]
- [[Paper C|ref]] - [Brief explanation of how Paper C provides context]
```

**Important Guidelines for Zotero Summary**:
- Keep it objective and factual
- Anyone should understand the paper from this summary
- Each paragraph should be 2-4 sentences
- Only include papers explicitly discussed during conversation
- Maximum 3-4 related papers

---

## 📝 Obsidian Note Template

```markdown
**[논문 제목 - Same title as the paper]**

**왜 이 논문을 읽었나?**
[Write 2-3 sentences about the context from discussion: What sparked interest? What problem or question led to reading this paper?]

**핵심 아이디어**
[Detailed explanation of the core concepts. Include:
- Main hypothesis or approach
- Key innovations or unique aspects
- How it differs from existing work
Reflect discussion points and researcher's interpretation.]

**방법론 상세**
[Technical details, especially:
- Architecture or algorithm specifics
- Data collection/processing methods
- Implementation details discussed
- Any technical questions raised during conversation]

**주요 결과 및 분석**
[Important findings:
- Experimental results emphasized in discussion
- Performance comparisons
- Ablation studies or key analyses
- Limitations noted]

**개인적 통찰**
[Personal insights from the discussion:
- Connections to other research
- Potential applications in researcher's work
- Interesting observations or implications
- How this fits into broader research context]

**의문점 / 추후 탐구사항**
[Remaining questions or future exploration:
- Unanswered questions from discussion
- Aspects to investigate further
- Related papers to read
- Potential experiments or applications to try]
```

**Flexibility Guidelines for Obsidian Note**:
- The above structure is a **starting point**
- **Adapt based on discussion**:
  - Add sections for deeply explored topics (e.g., "Dataset Details", "Comparison with X")
  - Merge sections if they flow naturally together
  - Rename sections to match discussion focus (e.g., "방법론 상세" → "Data Collection Process")
  - Reorder to reflect conversation flow
  - Skip sections that weren't discussed in depth
- **Prioritize discussion content**: Include questions asked, comparisons made, insights gained
- **Length**: Each section should be 1-3 paragraphs based on depth of discussion

---

## Output Format

When delivering final outputs, use this exact structure:

```
## 📋 Zotero Summary

[Complete Zotero summary following the template above]

---

## 📝 Obsidian Note

[Complete Obsidian note following the template above, adapted to the discussion]
```

**Delivery Checklist**:
- [ ] Both outputs are in plain markdown (no code blocks wrapping the content)
- [ ] Zotero Summary is objective and concise (2-3 paragraphs)
- [ ] Obsidian Note reflects actual discussion content
- [ ] Related papers use correct typed link format: [[Paper|type]]
- [ ] Tags are general classification keywords (not paper-specific terms)
- [ ] Both outputs are complete and copy-paste ready
