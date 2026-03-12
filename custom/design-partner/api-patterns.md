# Nano Banana API 패턴

검증된 Python API 호출 패턴 (MCP 실패 시 대안)

## 기본 호출 패턴

```python
import google.generativeai as genai
import json
import os

def generate_with_nano_banana(prompt_json):
    """
    Nano Banana (Gemini 3.1 Flash Image) API 직접 호출
    MCP 통합 실패 시 이 패턴 사용
    """
    # API 키 설정
    api_key = os.getenv('GEMINI_API_KEY')
    genai.configure(api_key=api_key)

    # 모델 선택 (2026.3 기준)
    model = genai.GenerativeModel('gemini-3.1-flash-image-preview')

    # JSON을 프롬프트로 변환
    if isinstance(prompt_json, dict):
        prompt = json.dumps(prompt_json, indent=2)
    else:
        prompt = prompt_json

    # 생성 요청
    response = model.generate_content(prompt)
    return response.text
```

## JSON 템플릿 재사용 패턴

```python
# 자주 쓰는 베이스 템플릿
TEMPLATES = {
    "portrait": {
        "camera": {"lens": "85mm", "aperture": "f/1.8"},
        "lighting": {"type": "rembrandt"},
        "depth_of_field": "shallow"
    },
    "product": {
        "style": "commercial photography",
        "lighting": {"type": "studio", "setup": "three-point"},
        "background": "gradient"
    },
    "landscape": {
        "camera": {"lens": "24mm", "aperture": "f/8"},
        "depth_of_field": "deep",
        "time": "golden hour"
    }
}

def create_prompt(base_template, customizations):
    """템플릿 기반 프롬프트 생성"""
    prompt = TEMPLATES.get(base_template, {}).copy()
    prompt.update(customizations)
    return prompt
```

## 에러 처리 패턴

```python
def safe_generate(prompt_json, retries=2):
    """재시도 로직 포함 안전한 생성"""
    for attempt in range(retries + 1):
        try:
            return generate_with_nano_banana(prompt_json)
        except Exception as e:
            if attempt == retries:
                print(f"최종 실패: {e}")
                return None
            print(f"시도 {attempt + 1} 실패, 재시도...")
            time.sleep(2 ** attempt)  # 지수 백오프
```

## 스크립트 실행 패턴

```python
# standalone_generate.py 로 저장
if __name__ == "__main__":
    import sys

    # CLI 사용
    if len(sys.argv) > 1:
        json_file = sys.argv[1]
        with open(json_file) as f:
            prompt = json.load(f)
    else:
        # 기본 테스트 프롬프트
        prompt = {
            "subject": "cyberpunk city at night",
            "style": "hyperrealistic",
            "lighting": {"type": "neon"}
        }

    result = safe_generate(prompt)
    if result:
        print(f"생성 완료: {result}")
```

## subprocess 대안 실행

```python
import subprocess
import tempfile

def generate_via_script(prompt_json):
    """Python 스크립트 직접 실행"""
    # 임시 JSON 파일 생성
    with tempfile.NamedTemporaryFile(mode='w', suffix='.json', delete=False) as f:
        json.dump(prompt_json, f)
        temp_path = f.name

    try:
        # 스크립트 실행
        result = subprocess.run(
            ["python", "standalone_generate.py", temp_path],
            capture_output=True,
            text=True
        )
        return result.stdout
    finally:
        os.unlink(temp_path)
```

## 사용 가이드

1. **MCP 통합 시도**: 먼저 MCP 서버로 시도
2. **실패 시 Python**: 위 패턴으로 직접 호출
3. **템플릿 활용**: 반복 작업은 템플릿화
4. **에러 처리 필수**: safe_generate 패턴 사용

## 주의사항

- API 키는 환경변수로 관리
- 토큰 제한 고려 (복잡한 JSON 주의)
- 모델명은 버전에 따라 변경될 수 있음