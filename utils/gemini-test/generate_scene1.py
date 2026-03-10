#!/usr/bin/env python3
"""
Scene 1 키프레임 생성 스크립트
Gemini 2.5 Flash Image API 사용
"""

import os
import json
import base64
import requests
from datetime import datetime

# Gemini API 설정
API_KEY = "AIzaSyBlYPNSlAg-JNon5PtEhfzHsHYRPvQA1jY"
API_URL = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key={API_KEY}"

# Scene 1: Walking Scene 프롬프트
scene1_prompt = """
Confident anime girl walking through destroyed city street,
side profile view, short white hair flowing, red eyes,
wearing torn white crop top and black tactical shorts,
knee-high boots, massive cannon strapped to back,
dramatic rim lighting, dust particles in air,
cyberpunk aesthetic, cinematic composition,
highly detailed, 8k resolution, unreal engine 5, octane render,
16:9 aspect ratio, volumetric lighting
"""

def generate_image(prompt, output_path):
    """Gemini API로 이미지 생성"""

    headers = {
        "Content-Type": "application/json"
    }

    data = {
        "contents": [{
            "parts": [{
                "text": f"Generate an image: {prompt}"
            }]
        }],
        "generationConfig": {
            "temperature": 0.7,
            "topK": 32,
            "topP": 1,
            "maxOutputTokens": 4096,
        }
    }

    print(f"Sending request to Gemini API...")
    print(f"Prompt: {prompt[:100]}...")

    try:
        response = requests.post(API_URL, headers=headers, json=data)
        response.raise_for_status()

        result = response.json()

        # 응답 저장 (디버깅용)
        debug_file = output_path.replace('.png', '_response.json')
        with open(debug_file, 'w') as f:
            json.dump(result, f, indent=2)

        print(f"Response saved to: {debug_file}")

        # 이미지 데이터 추출 시도
        if 'candidates' in result and len(result['candidates']) > 0:
            candidate = result['candidates'][0]
            if 'content' in candidate and 'parts' in candidate['content']:
                for part in candidate['content']['parts']:
                    if 'inlineData' in part:
                        # base64 이미지 데이터 추출
                        image_data = part['inlineData']['data']
                        mime_type = part['inlineData'].get('mimeType', 'image/png')

                        # 이미지 저장
                        image_bytes = base64.b64decode(image_data)
                        with open(output_path, 'wb') as f:
                            f.write(image_bytes)

                        print(f"✅ Image saved to: {output_path}")
                        return True
                    elif 'text' in part:
                        print(f"Text response: {part['text']}")

        print("⚠️ No image data found in response")
        print("Note: Gemini 2.5 Flash may not support image generation directly")
        return False

    except requests.exceptions.RequestException as e:
        print(f"❌ API request failed: {e}")
        if hasattr(e, 'response') and e.response is not None:
            print(f"Response: {e.response.text}")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    # 출력 디렉토리 생성
    output_dir = "/Users/bys724/Documents/Obsidian Vault/Projects/AI Video - Cannon Girl/generated"
    os.makedirs(output_dir, exist_ok=True)

    # 타임스탬프 추가
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = os.path.join(output_dir, f"scene1_walking_{timestamp}.png")

    print("=" * 50)
    print("Scene 1: Walking Scene 키프레임 생성")
    print("=" * 50)

    success = generate_image(scene1_prompt, output_path)

    if success:
        print("\n🎉 이미지 생성 완료!")
    else:
        print("\n⚠️ 이미지 생성 실패")
        print("\n대안: Gemini API는 현재 이미지 생성을 직접 지원하지 않을 수 있습니다.")
        print("다른 방법을 시도해보세요:")
        print("1. DALL-E API 사용")
        print("2. Stable Diffusion WebUI 사용")
        print("3. Midjourney Discord 봇 사용")

if __name__ == "__main__":
    main()