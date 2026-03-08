# Midjourney Reference (V7, 2025~)

스킬에서 참조하는 미드저니 핵심 레퍼런스.
업데이트 시 공식 문서 기준으로 갱신할 것.

## 공식 문서

- Style Creator: https://docs.midjourney.com/hc/en-us/articles/41308374558221-Style-Creator

- Prompt Basics: https://docs.midjourney.com/hc/en-us/articles/32023408776205-Prompt-Basics
- Parameter List: https://docs.midjourney.com/hc/en-us/articles/32859204029709-Parameter-List
- Art of Prompting: https://docs.midjourney.com/hc/en-us/articles/32835253061645-Art-of-Prompting
- Style Reference: https://docs.midjourney.com/hc/en-us/articles/32180011136653-Style-Reference
- Character Reference: https://docs.midjourney.com/hc/en-us/articles/32162917505293-Character-Reference
- Raw Mode: https://docs.midjourney.com/hc/en-us/articles/32634113811853-Raw-Mode
- Personalization: https://docs.midjourney.com/hc/en-us/articles/32433330574221-Personalization
- Multi-Prompts & Weights: https://docs.midjourney.com/hc/en-us/articles/32658968492557-Multi-Prompts-Weights
- Editor: https://docs.midjourney.com/hc/en-us/articles/32764383466893-Editor
- Remix: https://docs.midjourney.com/hc/en-us/articles/32799074515213-Remix
- Version: https://docs.midjourney.com/hc/en-us/articles/32199405667853-Version

## 프롬프트 구조

```
[이미지 URL (선택)] + [텍스트 프롬프트] + [파라미터]
```

텍스트 프롬프트 핵심 축 (앞에 올수록 영향력 큼):
1. Subject — 무엇을
2. Medium — 어떤 매체로
3. Environment — 어떤 환경에서
4. Lighting — 어떤 조명으로
5. Color — 어떤 색감으로
6. Mood — 어떤 분위기로
7. Composition — 어떤 구도로

## 파라미터 (V7 기준)

### 기본

| 파라미터 | 문법 | 범위 | 역할 |
|----------|------|------|------|
| Aspect Ratio | `--ar W:H` | 자유 비율 | 이미지 비율 |
| Stylize | `--s N` | 0-1000 | MJ의 예술적 해석 정도. 낮으면 프롬프트 충실, 높으면 MJ가 꾸밈 |
| Chaos | `--c N` | 0-100 | 4장 사이의 변화 정도 |
| Quality | `--q N` | 0.5, 1, 2 | 렌더 품질 vs 속도 |
| Weird | `--w N` | 0-3000 | 비일상적/초현실적 요소 |
| Negative | `--no [items]` | 텍스트 | 제외할 요소 |
| Seed | `--seed N` | 0-4294967295 | 재현/비교용 고정값 |
| Tile | `--tile` | 플래그 | 타일 패턴 생성 |
| Repeat | `--repeat N` | 2-40 | 동일 프롬프트 반복 실행 |

### 스타일 제어

| 파라미터 | 문법 | 역할 |
|----------|------|------|
| Raw Mode | `--style raw` | MJ 미화 필터 해제. 사실적/다큐 느낌 |
| Style Ref | `--sref URL/code` | 참조 이미지의 시각적 스타일(색감, 질감, 톤, 렌더링)만 추출 |
| Style Weight | `--sw N` (0-1000) | sref 영향도 |
| Personalization | `--p` | 개인 학습된 스타일 적용 |

### 레퍼런스 (V7)

| 파라미터 | 문법 | 역할 |
|----------|------|------|
| Omni Ref | `--oref URL` | 특정 캐릭터/오브젝트를 이미지에 포함 (V7, cref 대체) |
| Omni Weight | `--ow N` | oref 영향도 |
| Image Weight | `--iw N` (0-3) | 이미지 프롬프트의 영향도 |

### Multi-prompt

- `::` 로 개념 분리: `space::ship` → "space"와 "ship"을 독립 개념으로 처리
- 가중치: `space::2 ship::1` → space에 2배 가중
- 음수 가중치: `green::-0.5` → green 억제

## 스타일 vs 프롬프트: 역할 분리

### 프롬프트의 스타일 묘사
- 말로 직접 설명: `watercolor, soft pastel tones, dreamy`
- 자유도 높지만 해석 여지가 큼
- 일관성 보장 어려움

### --sref (스타일 레퍼런스)
- 이미지의 **형식적 요소만** 복사 (색감, 질감, 톤, 렌더링 방식)
- 컨텐츠(뭐가 그려져 있는지)는 무시
- 시리즈 일관성에 적합

### --s (stylize 값)
- MJ가 자기 해석을 넣는 정도
- 0~100: 프롬프트에 충실, 밋밋할 수 있음
- 250 (기본): 균형
- 500~1000: MJ가 알아서 예쁘게, 프롬프트에서 벗어날 수 있음

### --style raw
- MJ의 기본 미화 경향을 억제
- 사실적/다큐멘터리 느낌에 적합

### --p (personalization)
- 사용자가 학습시킨 개인 스타일 적용
- MJ 웹사이트에서 이미지 좋아요로 학습

## sref로 스타일을 분리할 때의 경계

### 결과물 = 프롬프트(컨텐츠 + 연출) + 스타일(sref/텍스트) + MJ 해석(stylize)

sref는 "스타일" 층만 저장. "연출" 층은 프롬프트에 남아야 함.

| 구분 | 예시 | sref가 잡는가 | 처리 |
|------|------|-------------|------|
| 순수 스타일 | watercolor, oil painting, cel-shaded | O | 프롬프트에서 제거 가능 |
| 연출/라이팅 | dramatic lighting, golden hour, rim light | X | 프롬프트에 유지 |
| 색감/톤 | desaturated, warm earth tones | 부분적 | 강하게 원하면 프롬프트에도 유지 |
| 구도 | wide shot, close-up | X (스타일 아님) | 항상 프롬프트에 |

### 검증 방법: Seed A/B 테스트

1. 원본: `[전체 프롬프트] --seed 12345`
2. sref만: `[컨텐츠만] --sref [코드] --seed 12345`
3. 비교 → 빠진 요소를 프롬프트에 복원

## Style Creator

MJ 웹사이트 전용 도구. 그리드 이미지를 보며 선호하는 것을 고르면 취향을 학습해서 `--sref` 숫자 코드를 생성.

### 사용 흐름

1. **프롬프트 입력**: `.` (점)만 입력 권장 — 특정 컨텐츠에 종속되지 않는 범용 스타일 코드 생성
2. **그리드 선택**: 10장(소) 또는 24장(대) 그리드에서 스타일이 마음에 드는 것을 클릭
3. **반복 정제**: "Refine Style" 클릭 → 새 그리드 → 다시 선택. **최소 5라운드** 필요
4. **코드 획득**: 각 라운드마다 `--sref` 숫자 코드가 생성됨

### 핵심 특성

- **내 이미지 업로드 불가** — MJ 내부 스타일 갤러리에서만 조합
- 선택한 것뿐 아니라 **건너뛴 것도** 학습에 반영
- 5-10라운드에서 스타일 안정화, 10-15라운드에서 뉘앙스 추가, 15 이상은 변화 미미
- 프리뷰 생성마다 GPU 시간 소모
- Style Creator 코드는 `--sv 6`에서만 작동

### Style Creator vs --sref URL vs --sref code

| | Style Creator | --sref URL | --sref code |
|--|--------------|-----------|-------------|
| 용도 | 스타일 탐색/발견 | 특정 이미지 스타일 복제 | 검증된 스타일 재사용 |
| 입력 | 그리드 선택 | 이미지 URL | 숫자 코드 |
| 출력 | 숫자 코드 생성 | 직접 적용 | 직접 적용 |
| 장점 | 말로 표현 못하는 취향 발견 | 정확한 참조 가능 | 간편, 공유 가능 |
| 한계 | 내 이미지 기반 불가 | 재사용 코드 미생성 | 기존 코드만 사용 |

### sref 코드 조합

```
--sref 2213253170 4114158294          // 두 스타일 블렌딩
--sref 2213253170::2 4114158294::1    // 가중치 (앞쪽 2배 강조)
--sref random                          // 랜덤 스타일 (코드 사후 확인 가능)
```

### --sv (Style Version) 주의

- sv1: 안정적, 따뜻한 톤
- sv2: 실험적/창의적
- sv4: 프로 작업용 워크호스
- sv5: 빈티지 필름 느낌
- sv6: 균형잡힌 기본값
- Style Creator 코드는 sv6에서만 작동
- **항상 --sv를 명시적으로 지정할 것** — MJ 업데이트로 기본값이 바뀔 수 있음

### 커뮤니티 sref 코드 라이브러리

- Midlibrary: https://midlibrary.io/
- SrefHunt: https://srefhunt.com/
- PromptsRef: https://promptsref.com/
- SREF-Midjourney: https://sref-midjourney.com/

## 스타일을 보는 눈: 5가지 축

컨텐츠(무엇)를 무시하고 형식(어떻게)만 관찰:

1. **선(Line)**: 뚜렷 vs 부드러움, 직선 vs 유기적
2. **색 팔레트(Color)**: 난색/한색, 채도, 단색조/다색
3. **질감(Texture)**: 매끄러움 vs 거칠음, 디지털 vs 아날로그
4. **명암(Contrast)**: 강한 콘트라스트 vs 플랫
5. **렌더링(Rendering)**: 사실적 vs 그래픽 vs 회화적

## 용도별 프롬프트 공식

### 사진 (Photography)
```
[camera] photo of [subject] in [environment], [lighting], [lens], [mood]
--ar 3:2 --style raw
```
예시: `Canon EOS R5 photo of a weathered fisherman mending nets at dawn, golden hour lighting, 85mm f/1.4, documentary mood --ar 3:2 --style raw`

### 일러스트 (Illustration)
```
[style] illustration of [subject], [color palette], [composition], [mood]
--ar [ratio] --s [value]
```
예시: `watercolor illustration of a cozy bookshop interior, warm earth tones, wide establishing shot, nostalgic --ar 16:9 --s 750`

### 컨셉아트 (Concept Art)
```
[subject] concept art, [art style], [environment], [lighting], [detail]
--ar 16:9
```
예시: `alien marketplace concept art, sci-fi brutalism, underground cavern with bioluminescent flora, volumetric lighting, highly detailed --ar 16:9`

### 시네마틱 (Cinematic)
```
cinematic still from [genre] film, [subject/scene], [lighting], [camera], anamorphic, film grain
--ar 21:9
```

### 캐릭터 디자인
```
[character description], character design sheet, multiple poses, [art style], white background
--ar 3:2
```

### 패턴
```
seamless pattern of [elements], [style], [color palette]
--tile --ar 1:1
```

### 제품 목업
```
[product] on [surface], [lighting style], [camera angle], product photography
--ar [ratio] --style raw
```

## 전문가 워크플로우

1. **Draft Mode**: `--mode draft` — 10x 빠름, 절반 비용. 빠른 탐색용
2. **Broad → Narrow**: 간단한 프롬프트로 시작 → 결과 보고 요소 추가
3. **Seed A/B 테스트**: `--seed` 고정 → 단어 하나 변경 → 효과 비교
4. **Vary Region**: 이미지의 특정 부분만 재생성 (20-50% 영역)
5. **Remix Mode**: Vary 시 프롬프트 수정 가능
6. **Reference 체이닝**: sref(스타일) + oref(캐릭터) 고정 → 장면만 변경
7. **Upscale → Vary Region**: 업스케일 후 세부 보정

## V7 주요 변경사항

- V6와 완전히 다른 아키텍처 (점진적 업데이트 아님)
- Draft Mode 지원
- Personalization 기본 활성화
- --oref가 --cref 대체 (캐릭터 + 오브젝트 + 장면 요소 모두 지원)
- 손, 얼굴, 해부학, 텍스트 렌더링 대폭 개선
- 다국어 프롬프트 지원 향상
- --sv 파라미터 (sref 알고리즘 버전 선택, 1-6)
- V6 대비 스타일 드리프트 72% 감소
