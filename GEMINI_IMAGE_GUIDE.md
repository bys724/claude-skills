# Gemini 이미지 생성 도구

## 빠른 시작
```bash
python3 /Users/bys724/Documents/claude-skills/scripts/gemini_image.py "프롬프트"
```

## 사용 시나리오

### 1. 새 프로젝트에서 이미지 생성이 필요할 때
```python
# Python에서
import sys
sys.path.append('/Users/bys724/Documents/claude-skills/scripts')
from gemini_image import generate_image

result = generate_image("your prompt here")
```

### 2. 스타일 일관성이 필요할 때
```python
# 레퍼런스 이미지와 함께
result = generate_image("같은 스타일로 새 장면", "reference.png")
```

### 3. 명령줄에서 빠르게
```bash
cd 작업디렉토리
python3 /Users/bys724/Documents/claude-skills/scripts/gemini_image.py "프롬프트"
# → generated_TIMESTAMP.png 생성됨
```

## 기술 정보
- 모델: Gemini 2.5 Flash Image
- API: Google Gemini
- 출력: PNG 형식, 현재 디렉토리에 저장

## 관련 문서
- 상세 사용법: `scripts/README.md`
- MCP 서버 상태: `mcp-servers/nano-banana-mcp/TROUBLESHOOTING.md`