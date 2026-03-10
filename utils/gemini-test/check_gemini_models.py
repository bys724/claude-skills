#!/usr/bin/env python3
"""
Gemini API 사용 가능한 모델 확인
"""

import requests
import json

API_KEY = "AIzaSyBlYPNSlAg-JNon5PtEhfzHsHYRPvQA1jY"
LIST_MODELS_URL = f"https://generativelanguage.googleapis.com/v1beta/models?key={API_KEY}"

def list_models():
    """사용 가능한 Gemini 모델 리스트"""
    try:
        response = requests.get(LIST_MODELS_URL)
        response.raise_for_status()

        result = response.json()

        print("=== Available Gemini Models ===\n")

        if 'models' in result:
            for model in result['models']:
                name = model.get('name', 'Unknown')
                display_name = model.get('displayName', 'Unknown')
                supported_methods = model.get('supportedGenerationMethods', [])

                print(f"📦 Model: {name}")
                print(f"   Display Name: {display_name}")
                print(f"   Supported Methods: {', '.join(supported_methods)}")

                # 이미지 생성 지원 확인
                if 'generateImage' in supported_methods or 'imageGeneration' in supported_methods:
                    print(f"   ✨ Supports Image Generation!")

                print()

        return result

    except requests.exceptions.RequestException as e:
        print(f"❌ Failed to list models: {e}")
        if hasattr(e, 'response') and e.response is not None:
            print(f"Response: {e.response.text}")
        return None

if __name__ == "__main__":
    models = list_models()

    # 결과 저장
    if models:
        with open('/Users/bys724/Documents/claude-skills/gemini_models.json', 'w') as f:
            json.dump(models, f, indent=2)
        print("\nFull response saved to gemini_models.json")