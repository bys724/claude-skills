# Nano Banana API 패턴

검증된 Python API 호출 패턴. MCP 가 아닌 코드 통합/배치 작업용.

## SDK

공식 `google-genai` 사용 (구 `google.generativeai` 는 legacy).

```bash
pip install google-genai
```

## 기본 호출 (Interactions API)

2026-11 공식 예시는 `client.models.generate_content`가 아니라 `client.interactions.create`를 쓴다 ([image-generation](https://aistudio.google.com/docs/image-generation)).

```python
import base64
from google import genai

client = genai.Client()  # GEMINI_API_KEY 환경변수

def generate_image(prompt: str, out_path: str = "out.png", aspect_ratio="1:1", image_size="1K"):
    interaction = client.interactions.create(
        model="gemini-nano-banana-2.1",
        input=prompt,
        response_format={"type": "image", "aspect_ratio": aspect_ratio, "image_size": image_size},  # 1K/2K/4K
    )
    if not getattr(interaction, "output_image", None):   # safety filter 등으로 이미지가 없을 수 있음
        return None
    with open(out_path, "wb") as f:
        f.write(base64.b64decode(interaction.output_image.data))  # base64 문자열
    return out_path
```

JSON 프롬프트도 문자열로 직렬화해서 `input` 에 전달. 레퍼런스 이미지·멀티턴 편집·Search grounding(`tools=[{"type": "google_search"}]`)은 공식 문서 예시를 따른다.

## 모델 선택 (2026-11-15, [deprecations](https://aistudio.google.com/docs/deprecations) 기준)

| 목적 | 모델 |
|------|------|
| 기본·빠른 이터레이션 (공식 권장) | `gemini-nano-banana-2.1` (Nano Banana 2.1) |
| 최고 품질·텍스트·일관성·스타일 레퍼런스 | `gemini-3-pro-image` (Nano Banana Pro) |
| 최저 비용·최고속 (멀티 레퍼런스 약함) | `gemini-3.1-flash-lite-image` |
| 영상 생성 | `gemini-omni-1.2-flash` → [`video-workflow.md`](video-workflow.md) |

종료된 ID: `gemini-3.1-flash-image-preview`·`gemini-3-pro-image-preview`(2026-06-25), `veo-3.1-*`(2026-10-22). `gemini-2.5-flash-image`는 2027-03-15 종료 예정. 최신 모델명은 `client.models.list()` 로 확인.

## JSON 템플릿 재사용

```python
TEMPLATES = {
    "portrait": {
        "camera": {"lens": "85mm", "aperture": "f/1.8"},
        "lighting": {"type": "rembrandt"},
    },
    "product": {
        "style": "commercial photography",
        "lighting": {"type": "studio", "setup": "three-point"},
    },
}

def build_prompt(template: str, **overrides) -> dict:
    base = TEMPLATES.get(template, {}).copy()
    base.update(overrides)
    return base
```

## 재시도 패턴

```python
import time, json

def safe_generate(prompt, retries=2):
    if isinstance(prompt, dict):
        prompt = json.dumps(prompt)
    for i in range(retries + 1):
        try:
            return generate_image(prompt)
        except Exception as e:
            if i == retries:
                raise
            time.sleep(2 ** i)
```

## 영상 생성

[`video-workflow.md`](video-workflow.md)의 "기본 호출" 참고 (Omni Flash, 같은 Interactions API).

## 주의

- API 키는 환경변수로만. 코드에 하드코딩 금지
- 용도별 키 분리 권장 (MCP용 / 코드용)
- Tier/rate limit 는 프로젝트 단위 공유 — 키 나눠도 한도 증가 아님
- Safety filter 로 이미지가 비는 응답 발생 가능 → `output_image` 존재 여부 체크
- 영상 생성은 수십 초~수 분 소요 가능
