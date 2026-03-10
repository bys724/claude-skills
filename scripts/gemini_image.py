#!/usr/bin/env python3
"""
Gemini 이미지 생성 유틸리티
어떤 경로에서든 사용 가능한 범용 스크립트
"""

import os
import sys
import json
import base64
import requests
from datetime import datetime

# API 설정
API_KEY = os.getenv("GEMINI_API_KEY", "YOUR_API_KEY_HERE")
MODEL = "gemini-2.5-flash-image"

def generate_image(prompt, reference_image=None):
    """
    이미지 생성 함수

    Args:
        prompt: 생성할 이미지 설명
        reference_image: 스타일 참조 이미지 경로 (선택사항)

    Returns:
        생성된 이미지 경로 또는 None
    """

    api_url = f"https://generativelanguage.googleapis.com/v1beta/models/{MODEL}:generateContent?key={API_KEY}"

    # 요청 데이터 구성
    parts = []

    # 레퍼런스 이미지가 있으면 추가
    if reference_image and os.path.exists(reference_image):
        with open(reference_image, "rb") as f:
            image_base64 = base64.b64encode(f.read()).decode('utf-8')
        parts.append({
            "inlineData": {
                "mimeType": "image/png",
                "data": image_base64
            }
        })
        parts.append({
            "text": f"Using this image as a style reference, generate: {prompt}"
        })
        print(f"📷 Using reference image: {reference_image}")
    else:
        parts.append({"text": prompt})

    data = {
        "contents": [{"parts": parts}],
        "generationConfig": {
            "temperature": 0.9,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 8192
        }
    }

    print(f"🎨 Generating image...")

    try:
        response = requests.post(api_url, json=data)
        response.raise_for_status()
        result = response.json()

        # 이미지 추출
        if 'candidates' in result and result['candidates']:
            for part in result['candidates'][0].get('content', {}).get('parts', []):
                if 'inlineData' in part:
                    # 이미지 저장
                    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                    output_path = f"generated_{timestamp}.png"

                    image_data = base64.b64decode(part['inlineData']['data'])
                    with open(output_path, 'wb') as f:
                        f.write(image_data)

                    print(f"✅ Image saved: {output_path}")
                    return output_path

        print("❌ No image in response")
        return None

    except Exception as e:
        print(f"❌ Error: {e}")
        return None

# 직접 실행 시
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python gemini_image.py 'prompt' [reference_image_path]")
        sys.exit(1)

    prompt = sys.argv[1]
    reference = sys.argv[2] if len(sys.argv) > 2 else None

    generate_image(prompt, reference)