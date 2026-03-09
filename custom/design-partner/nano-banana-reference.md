# Nano Banana Reference (2026)

Google의 Gemini 이미지 생성 모델 시리즈. JSON 프롬프팅으로 정밀 제어 가능.
업데이트 시 공식 문서와 커뮤니티 자료 기준으로 갱신할 것.

## 모델 버전 (2026.3 기준)

| 모델 | 정식명 | 특징 | 출시 |
|------|--------|------|------|
| Nano Banana | Gemini 2.5 Flash Image | 최초 버전, 바이럴 히트 | 2025.8 |
| Nano Banana Pro | Gemini 3 Pro Image | 고품질, 깊은 추론 | 2025.11 |
| Nano Banana 2 | Gemini 3.1 Flash Image | 4K 해상도, Flash 속도 | 2026.2 |

## JSON 프롬프팅 구조

### 기본 구조
```json
{
  "subject": "주제/대상",
  "style": "스타일",
  "environment": "배경/환경",
  "lighting": "조명",
  "camera": {
    "type": "카메라 타입",
    "lens": "렌즈",
    "angle": "앵글",
    "aperture": "조리개"
  },
  "mood": "분위기",
  "colors": "색상 팔레트",
  "quality": "품질 설정"
}
```

### 핵심 필드 설명

#### Subject (필수)
```json
"subject": {
  "main": "주 대상",
  "attributes": {
    "pose": "포즈",
    "expression": "표정",
    "clothing": "의상",
    "accessories": "액세서리"
  }
}
```

#### Style (스타일 제어)
```json
"style": {
  "primary": "hyperrealistic",
  "influences": ["photography", "digital art"],
  "rendering": "photorealistic",
  "texture": "smooth"
}
```

스타일 옵션:
- `hyperrealistic`: 극사실주의
- `illustration`: 일러스트
- `3d_figurine`: 3D 피규어 (바이럴 스타일)
- `anime`: 애니메이션
- `watercolor`: 수채화
- `oil_painting`: 유화
- `minimalist`: 미니멀리즘
- `abstract`: 추상

#### Camera (촬영 설정)
```json
"camera": {
  "type": "DSLR",
  "lens": "85mm",
  "aperture": "f/1.8",
  "angle": "eye-level",
  "focus": "sharp on subject",
  "depth_of_field": "shallow"
}
```

카메라 앵글:
- `bird's-eye view`: 부감
- `low-angle`: 로우앵글
- `eye-level`: 눈높이
- `dutch-angle`: 기울어진
- `close-up`: 클로즈업
- `wide-shot`: 와이드샷

#### Lighting (조명)
```json
"lighting": {
  "type": "golden hour",
  "direction": "backlighting",
  "intensity": "soft",
  "shadows": "long and dramatic"
}
```

조명 타입:
- `golden hour`: 골든아워
- `studio lighting`: 스튜디오
- `natural light`: 자연광
- `neon`: 네온
- `volumetric`: 볼류메트릭
- `rim lighting`: 림라이팅
- `chiaroscuro`: 키아로스쿠로

#### Environment (환경)
```json
"environment": {
  "location": "cyberpunk city",
  "time": "night",
  "weather": "rainy",
  "background": {
    "blur": true,
    "elements": ["neon signs", "reflections"]
  }
}
```

#### Quality Settings
```json
"quality": {
  "resolution": "4K",
  "detail_level": "ultra",
  "model": "NB2"  // or "NBPro"
}
```

## 고급 JSON 기법

### 1. 다층 구조 (Nested Structure)
```json
{
  "composition": {
    "foreground": {
      "subject": "character",
      "blur": false
    },
    "midground": {
      "elements": ["buildings"],
      "blur": "slight"
    },
    "background": {
      "elements": ["sky", "clouds"],
      "blur": true
    }
  }
}
```

### 2. 가중치 시스템
```json
{
  "style_weights": {
    "photorealistic": 0.7,
    "artistic": 0.3
  },
  "element_priority": {
    "subject": 1.0,
    "lighting": 0.8,
    "background": 0.5
  }
}
```

### 3. 조건부 렌더링
```json
{
  "conditional": {
    "if_portrait": {
      "depth_of_field": "shallow",
      "focus": "eyes"
    },
    "if_landscape": {
      "depth_of_field": "deep",
      "focus": "infinity"
    }
  }
}
```

### 4. 스타일 블렌딩
```json
{
  "style_blend": [
    {"style": "anime", "weight": 0.6},
    {"style": "realistic", "weight": 0.4}
  ]
}
```

## JSON vs 텍스트 프롬프트 비교

| 측면 | 텍스트 | JSON |
|------|--------|------|
| 정확도 | 해석 여지 있음 | 명확한 지시 |
| 일관성 | 변동 가능 | 높은 재현성 |
| 복잡도 | 간단 | 세밀한 제어 |
| 토큰 수 | 적음 | 많음 (2000+) |
| 학습곡선 | 낮음 | 높음 |

## 실제 사용 예시

### 인물 사진
```json
{
  "subject": {
    "type": "portrait",
    "person": {
      "age": "25-30",
      "gender": "female",
      "ethnicity": "asian",
      "expression": "confident smile",
      "hair": {
        "color": "black",
        "style": "long wavy"
      }
    }
  },
  "style": "hyperrealistic photography",
  "camera": {
    "lens": "85mm",
    "aperture": "f/1.4",
    "focus": "eyes"
  },
  "lighting": {
    "type": "rembrandt",
    "modifier": "softbox"
  },
  "background": {
    "type": "studio",
    "color": "neutral gray",
    "blur": true
  }
}
```

### 제품 사진
```json
{
  "subject": "luxury watch",
  "style": "commercial photography",
  "lighting": {
    "type": "studio",
    "setup": "three-point",
    "highlights": "metallic gleam"
  },
  "background": "gradient black to gray",
  "composition": {
    "angle": "45-degree",
    "focus": "watch face"
  },
  "post_processing": {
    "reflections": true,
    "shadows": "soft drop shadow"
  }
}
```

### 컨셉 아트
```json
{
  "subject": "alien megacity",
  "style": {
    "primary": "sci-fi concept art",
    "influences": ["blade runner", "cyberpunk"]
  },
  "environment": {
    "atmosphere": "foggy",
    "time": "twilight",
    "elements": [
      "floating platforms",
      "holographic ads",
      "flying vehicles"
    ]
  },
  "lighting": {
    "primary": "neon glow",
    "secondary": "volumetric fog",
    "color_palette": ["cyan", "magenta", "orange"]
  },
  "camera": {
    "angle": "low angle epic shot",
    "lens": "wide angle"
  }
}
```

## MCP 통합 사용

Claude Code에서 Nano Banana MCP 서버 연동 시:

### 1. 단순 생성
```
"사이버펑크 도시를 그려줘"
→ Claude가 자동으로 JSON 구성
```

### 2. JSON 직접 제공
```
"이 JSON으로 이미지 생성해줘: {json 내용}"
→ 정밀 제어
```

### 3. 반복 수정
```
"방금 이미지에서 조명만 golden hour로 바꿔줘"
→ Claude가 JSON 수정하여 재생성
```

## 성능 최적화 팁

1. **토큰 효율**: 불필요한 세부사항 제거, 핵심만 JSON화
2. **모델 선택**:
   - 빠른 반복: NB2 (Flash)
   - 최고 품질: NBPro
3. **캐싱 활용**: 반복되는 스타일은 JSON 템플릿화
4. **점진적 구축**: 간단한 JSON → 결과 확인 → 세부 추가

## 한계 및 주의사항

1. **토큰 제한**: 너무 복잡한 JSON은 토큰 한계 도달
2. **과적합 위험**: 지나치게 세밀한 지정은 창의성 저하
3. **스타일 충돌**: 모순되는 스타일 지정 시 예측 불가
4. **버전 의존성**: 모델 버전마다 JSON 해석 차이

## 커뮤니티 리소스

- GitHub 프롬프트 라이브러리:
  - `YouMind-OpenLab/awesome-nano-banana-pro-prompts` (10,000+ 프롬프트)
  - `JimmyLv/awesome-nano-banana`
  - `ZeroLu/awesome-nanobanana-pro`

- 프롬프트 갤러리:
  - https://youmind.com (웹 갤러리)
  - 카테고리별 필터, 원클릭 생성 지원

## vs Midjourney 비교

| 측면 | Nano Banana | Midjourney |
|------|-------------|------------|
| 프롬프트 방식 | JSON 구조화 | 텍스트 기반 |
| 제어 정밀도 | 매우 높음 | 중간 |
| 스타일 일관성 | JSON 재사용으로 완벽 | sref 필요 |
| 학습 곡선 | 높음 (JSON) | 낮음 |
| 커뮤니티 | 성장 중 | 성숙 |
| 비용 | 무료 티어 있음 | 유료만 |
| 통합 | MCP로 Claude 직접 연동 | Discord 기반 |