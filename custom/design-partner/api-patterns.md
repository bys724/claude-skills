# Nano Banana API 패턴

검증된 Python API 호출 패턴. MCP 가 아닌 코드 통합/배치 작업용.

## SDK

공식 `google-genai` 사용 (구 `google.generativeai` 는 legacy).

```bash
pip install google-genai
```

## 기본 호출

```python
import os, base64
from google import genai

client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])

def generate_image(prompt: str, out_path: str = "out.jpg"):
    resp = client.models.generate_content(
        model="gemini-3.1-flash-image-preview",  # Nano Banana 2
        contents=prompt,
    )
    for part in resp.candidates[0].content.parts:
        if getattr(part, "inline_data", None):
            with open(out_path, "wb") as f:
                f.write(part.inline_data.data)  # bytes
            return out_path
    return None
```

JSON 프롬프트도 문자열로 직렬화해서 `contents` 에 전달.

## 모델 선택 (2026.5 기준)

| 목적 | 모델 |
|------|------|
| 빠른 이터레이션 | `gemini-3.1-flash-image-preview` (Nano Banana 2) |
| 최고 품질·텍스트·일관성 | `gemini-3-pro-image-preview` (Nano Banana Pro) |
| 영상 생성 | `veo-3.1-generate-preview` (Veo 3.1) |

최신 모델명은 `client.models.list()` 로 확인.

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

## Veo 영상 생성 (image-to-video)

```python
import time
from google import genai

client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])

def generate_video(prompt: str, image, out_path: str = "out.mp4"):
    operation = client.models.generate_videos(
        model="veo-3.1-generate-preview",
        prompt=prompt,
        image=image,  # PIL.Image 또는 SDK 이미지 객체
    )
    while not operation.done:
        time.sleep(10)
        operation = client.operations.get(operation)

    video = operation.response.generated_videos[0].video
    with open(out_path, "wb") as f:
        f.write(video.video_bytes)
    return out_path
```

기본 출력: 8초, 720p, 네이티브 오디오 포함.
영상 길이가 길수록 비용 증가 — Standard $0.40/초 (~₩591/초).

## 주의

- API 키는 환경변수로만. 코드에 하드코딩 금지
- 용도별 키 분리 권장 (MCP용 / 코드용)
- Tier/rate limit 는 프로젝트 단위 공유 — 키 나눠도 한도 증가 아님
- Safety filter 로 이미지가 비는 응답 발생 가능 → `part.inline_data` 존재 여부 체크
- Veo 호출은 비동기 — 폴링 필요. 8초 영상도 생성에 30초~수 분 소요 가능
