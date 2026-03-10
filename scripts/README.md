# Claude Skills Scripts

## Gemini 이미지 생성 도구

### 사용법

#### 다른 프로젝트에서 사용
```python
# Python 스크립트에서
import sys
sys.path.append('/Users/bys724/Documents/claude-skills/scripts')
from gemini_image import generate_image

# 기본 사용
image_path = generate_image("a cyberpunk city at night")

# 레퍼런스 이미지와 함께
image_path = generate_image("same style but different scene", "reference.png")
```

#### 명령줄에서 직접 실행
```bash
# 기본 사용
python3 /Users/bys724/Documents/claude-skills/scripts/gemini_image.py "your prompt"

# 레퍼런스와 함께
python3 /Users/bys724/Documents/claude-skills/scripts/gemini_image.py "your prompt" reference.png
```

### API 키 설정
```bash
export GEMINI_API_KEY="your_api_key"
```

또는 스크립트에 기본값 설정되어 있음

## 기타 유틸리티

### utils/gemini-test/
- `check_gemini_models.py`: 사용 가능한 Gemini 모델 확인
- 테스트 및 디버깅용 스크립트들