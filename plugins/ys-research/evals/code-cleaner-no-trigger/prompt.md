---
name: code-cleaner-no-trigger
description: "평상시 작은 수정 요청엔 code-cleaner가 뜨면 안 됨 (수술적 변경 원칙)"
tags: [negative]
runs: 3
max_turns: 6
allowed_tools: [Read, Glob, Grep, Skill]
---

이 함수에 타입 힌트만 추가한 버전을 보여줘: def add(a, b): return a + b
