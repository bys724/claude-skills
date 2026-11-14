---
name: code-cleaner-trigger
description: "명시적 저장소 정리 요청 → code-cleaner"
tags: [trigger]
runs: 3
max_turns: 6
allowed_tools: [Read, Glob, Grep, Skill]
---

이 저장소 전체적으로 정리해줘. 안 쓰는 파일, 중복 문서, 폴더 구조까지 깔끔하게.
