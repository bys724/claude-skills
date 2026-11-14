# Nano Banana Reference (2026)

Google Gemini 이미지 생성 모델. 작업 시 공식 문서·커뮤니티 자료 기준으로 갱신.

## 모델 패밀리

| 모델 | API 식별자 | 특징 | 출시 |
|------|-----------|------|------|
| Nano Banana 2.1 | `gemini-nano-banana-2.1` | **현재 공식 권장 기본값**, 1K/2K/4K, 이미지 검색 grounding | 2026.10 |
| Nano Banana Pro | `gemini-3-pro-image` | **추론 후 생성**, 텍스트 렌더링, 스타일 레퍼런스 3장 | 2026.5 (GA) |
| Nano Banana 2 | `gemini-3.1-flash-image` | 이전 세대 Flash. 512px 지원 | 2026.5 (GA) |
| Nano Banana 2 Lite | `gemini-3.1-flash-lite-image` | 최고속. 1K 가격은 2.1과 같음, 멀티 레퍼런스·멀티턴 편집 약함 | 2026.6 |
| Nano Banana (v1) | `gemini-2.5-flash-image` | 레거시, 2027-03-15 종료 예정 | 2025.10 |

> `-preview` ID(`gemini-3.1-flash-image-preview`, `gemini-3-pro-image-preview`)는 **2026-06-25 종료**. 출처: [deprecations](https://aistudio.google.com/docs/deprecations) (2026-11-15 확인). 모델이 자주 바뀌므로 작업 전 이 페이지 확인.

## 비용 (2026-11-15 [공식 pricing](https://aistudio.google.com/docs/pricing))

이미지·영상 모델은 무료 티어 없음. 결제는 **선불 크레딧** (2026 전환 — 잔액 0이면 호출 실패, 추가 청구 없음). 원화는 1달러≈1,450원 대략치.

| 모델 | 1K | 2K | 4K | Batch |
|---|---|---|---|---|
| NB 2.1 | $0.034 (≈50원) | $0.050 | $0.113 | 반값 |
| NB Pro | $0.134 (≈195원) | $0.134 | $0.24 (≈350원) | 없음 |
| Lite | $0.034 | — | — | 반값 |
| NB 2 (3.1 Flash) | $0.067 | $0.101 | $0.151 | 없음 |

| 영상 (Omni 1.2 Flash) | 360p | 720p (기본) | 1080p | 4K |
|---|---|---|---|---|
| 초당 | $0.023 | $0.07 | $0.104 | $0.209 |
| 10초 | ≈330원 | ≈1,000원 | ≈1,500원 | ≈3,000원 |

- 입력(프롬프트·레퍼런스 이미지)은 무시할 수준 — Pro 레퍼런스 이미지가 장당 $0.0011
- Batch = 즉시가 아니라 나중에 받는 대신 반값. 같은 템플릿으로 수십 장 뽑을 때만 의미
- Search grounding: Gemini 3+ 모델 공유 월 5,000회 무료, 이후 1,000회당 $14
- 가격은 바뀐다 — 사용자에게 금액을 말하기 전에 이 표의 날짜가 3개월 넘었으면 공식 페이지 재확인

### Pro 모델의 진짜 차이: Reasoning-Guided Synthesis

Pro는 단순 디퓨전이 아니라 **프롬프트를 추론하고 씬을 계획한 뒤** 렌더링합니다.

- 물리·논리 오류 사전 검토 (그림자 방향, 손가락 개수, 원근법 등)
- Google Search Grounding으로 실존 장소·실시간 데이터 반영 (옵션)
- 레퍼런스 이미지 최대 14장 — Pro: 사물 6·인물 5·스타일 3 / NB 2.1: 사물 10·인물 4 (옵션)
- 다국어 텍스트 렌더링 (로고·표지·UI 모킹)

> "moving from aesthetic output to **reasoning-guided synthesis**" — 이게 핵심. JSON 프롬프팅이 좋아진 게 아니라 **모델이 추론 능력을 갖게 됐다**.

## 자연어 vs JSON: 선택 기준

**Google 공식 권장은 자연어 내러티브 공식입니다.** JSON은 커뮤니티 최적화 기법.

### Google 공식 내러티브 공식

```
[Subject + Adjectives] doing [Action] in [Location/Context].
[Composition/Camera Angle]. [Lighting/Atmosphere]. [Style/Media].
```

예시:
```
A confident young Japanese athlete jogging in a misty mountain trail at dawn.
Wide shot, low angle. Soft golden hour rim lighting through fog.
90s anime cel-shading style.
```

### 언제 JSON이 유리한가

| 상황 | 권장 | 이유 |
|------|------|------|
| 1회성 이미지, 단순 씬 | **자연어** | 빠르고 자연스러움. JSON 오버헤드 불필요 |
| 시리즈/캐릭터 일관성 | **JSON** | 필드만 바꿔서 재사용 |
| 복잡한 다중 객체 씬 | **JSON** | concept bleeding 방지, 요소 분리 |
| 팀 협업·템플릿화 | **JSON** | 누가 어느 필드 책임지는지 명확 |
| 정밀한 카메라/조명 제어 | 둘 다 가능 | JSON이 약간 우세 |

[Chase Jarvis 테스트](https://chasejarvis.com/blog/does-json-prompting-actually-work-tested-with-nano-banana/)에서도 JSON이 항상 더 좋은 결과를 내는 건 아님이 보고됐습니다.

## JSON 프롬프팅 구조 (2026 커뮤니티 표준)

[Atlabs Pro 가이드](https://www.atlabs.ai/blog/the-ultimate-nano-banana-pro-prompting-guide-mastering-gemini-3-pro-image), [Miraflow](https://miraflow.ai/blog/nano-banana-json-prompting-2026) 기반.

### 핵심 필드

```json
{
  "label": "내부 식별자",
  "tags": ["aesthetic 앵커 키워드"],
  "subject": {
    "main": "주 대상",
    "attributes": {
      "age": "...", "expression": "...", "clothing": "..."
    }
  },
  "madeOutOf": "재질·텍스처 (예: brushed steel, soft cotton)",
  "arrangement": "포즈·배치",
  "background": "전반 배경",
  "roomObjects": ["씬 내 구체 사물"],
  "accessories": ["주체-환경 연결 디테일"],
  "lighting": {
    "type": "...", "direction": "...", "intensity": "..."
  },
  "colorRestriction": ["색상 팔레트 제약"],
  "camera": {
    "type": "DSLR", "lens": "85mm",
    "aperture": "f/1.8", "angle": "eye-level"
  },
  "outputStyle": "렌더링 접근법",
  "mood": "감정 톤"
}
```

**주요 필드 의미**:
- `madeOutOf`: 사실감·재질감 향상 (Atlabs가 강조하는 핵심 필드)
- `colorRestriction`: 단순 `colors`보다 통제력 강함 (제외할 색까지 명시)
- `roomObjects`/`accessories`: 씬 요소 분리로 concept bleeding 방지
- `label`/`tags`: 템플릿 관리·재사용

### 점진적 확장 원칙

1단계 (최소):
```json
{ "subject": "고양이", "outputStyle": "watercolor" }
```

2단계 (세부):
```json
{
  "subject": { "main": "고양이", "arrangement": "sitting", "expression": "curious" },
  "outputStyle": "watercolor",
  "lighting": "soft natural light"
}
```

3단계 (고급): 위 핵심 필드 다수 활용.

> **수정 원칙**: 결과가 아쉬우면 **해당 키만** 바꾸고 전체를 다시 쓰지 마세요. JSON의 진짜 가치는 여기에 있습니다.

### 카메라 / 조명 / 스타일 옵션

**카메라 앵글**: `bird's-eye view`, `low-angle`, `eye-level`, `dutch-angle`, `close-up`, `wide-shot`

**조명 타입**: `golden hour`, `studio lighting`, `natural light`, `neon`, `volumetric`, `rim lighting`, `chiaroscuro`, `rembrandt`

**스타일**: `hyperrealistic`, `illustration`, `3d_figurine`, `anime`, `watercolor`, `oil_painting`, `minimalist`, `concept_art`

## 실제 예시

### 인물 사진 (자연어 + JSON 혼합)

자연어로 충분한 경우:
```
Hyperrealistic portrait of a 25-year-old Asian woman, confident smile,
long wavy black hair. 85mm f/1.4 lens, focus on eyes.
Rembrandt lighting with softbox modifier. Neutral gray studio background, blurred.
```

JSON으로 시리즈화:
```json
{
  "label": "portrait_series_v1",
  "subject": {
    "main": "Asian woman, age 25-30",
    "attributes": { "expression": "confident smile", "hair": "long wavy black" }
  },
  "outputStyle": "hyperrealistic photography",
  "lighting": { "type": "rembrandt", "modifier": "softbox" },
  "camera": { "lens": "85mm", "aperture": "f/1.4", "focus": "eyes" },
  "background": "neutral gray studio, blurred"
}
```

### 컨셉 아트
```json
{
  "subject": "alien megacity",
  "outputStyle": "sci-fi concept art, blade runner influence",
  "environment": {
    "atmosphere": "foggy", "time": "twilight",
    "elements": ["floating platforms", "holographic ads", "flying vehicles"]
  },
  "lighting": {
    "primary": "neon glow", "secondary": "volumetric fog"
  },
  "colorRestriction": ["cyan", "magenta", "orange"],
  "camera": { "angle": "low angle epic shot", "lens": "wide angle" }
}
```

## MCP 통합

### 모델 전환

`vendor/mcp/nanobanana`는 환경변수로 모델 전환:

```bash
# 기본 (빠름) — 반드시 지정할 것: 확장 내장 기본값 gemini-3.1-flash-image-preview 는 2026-06-25 종료됨
export NANOBANANA_MODEL=gemini-nano-banana-2.1

# Pro (reasoning, 고품질)
export NANOBANANA_MODEL=gemini-3-pro-image
```

텍스트 렌더링·복잡한 씬·스타일 레퍼런스·일관성이 중요하면 Pro로 전환. 확장(마지막 커밋 2026-03)이 새 ID를 받는지는 **미검증** — 첫 호출이 모델 오류면 이 확장 대신 [`api-patterns.md`](api-patterns.md)의 직접 호출 사용.

### 사용 패턴

1. **자연어 직접 호출**: "사이버펑크 도시를 그려줘" → Claude가 내러티브 공식으로 변환
2. **JSON 직접 제공**: 시리즈 작업·정밀 제어 시
3. **반복 수정**: "방금 이미지에서 조명만 golden hour로" → JSON의 해당 키만 수정

## 옵션 기능

### Search Grounding

실존 장소·실시간 데이터·정확한 사실이 필요할 때:
- 실제 도쿄 신주쿠 거리, 특정 시점 날씨, 정확한 차트 등
- API 호출 시 `tools=[{"type": "google_search"}]` (공식 예시는 NB 2.1. 다른 모델 지원 여부는 문서 확인)

### 다중 레퍼런스 이미지

캐릭터/브랜드 일관성이 핵심일 때:
- 최대 14개 이미지 입력
- 인물 일관성 Pro 5명 / NB 2.1 4명, 스타일 레퍼런스는 Pro만(3장)
- 브랜드 가이드라인·시리즈 작업·스토리보드에 유용

> 단순 이미지 생성에는 과한 기능. 일관성 워크플로우에서만 의미 있음.

## 한계 및 주의사항

1. **JSON ≠ 만능**: 단순 작업은 자연어가 빠르고 결과도 비슷하거나 더 자연스러움
2. **모순 필드 충돌**: 스타일·조명 등이 모순되면 결과 예측 불가
3. **검증되지 않은 기법** (커뮤니티에서 흔히 보이지만 출처 약함):
   - `style_weights`, `element_priority` 같은 가중치 숫자 — 모델이 실제로 가중치로 해석하는지 미검증. noise일 가능성
   - `if_portrait` 같은 조건부 렌더링 — 공식 지원 없음
   - 검증되지 않은 필드는 결과를 보장하지 않음
4. **버전 의존성**: 모델 버전마다 JSON 해석에 미세한 차이 있음

## 커뮤니티 리소스

- [Atlabs Nano Banana Pro Prompting Guide](https://www.atlabs.ai/blog/the-ultimate-nano-banana-pro-prompting-guide-mastering-gemini-3-pro-image)
- [Miraflow JSON Prompting 2026](https://miraflow.ai/blog/nano-banana-json-prompting-2026)
- [Google Cloud 공식 가이드](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)
- [공식 image generation 문서 (프롬프팅 전략 포함)](https://aistudio.google.com/docs/image-generation)
- GitHub 프롬프트 라이브러리: `YouMind-OpenLab/awesome-nano-banana-pro-prompts`, `ZeroLu/awesome-nanobanana-pro`
