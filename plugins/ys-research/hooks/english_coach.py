#!/usr/bin/env python3
"""english-coach · UserPromptSubmit hook.

사용자 프롬프트의 언어를 보고 그 턴의 지시문을 주입한다.
  모드 1 (한글 요청)  : 작업 전에 요청 핵심을 구어체 영어로 끊어 보여줌 (학습용 모델 문장)
  모드 2 (영어 시도)  : 이해한 내용 + 개선한 요청문을 보여주고 작업 진행
판정은 결정론적(한글 글자 비율). 끄기: 환경변수 ENGLISH_COACH=off (settings.json "env"에 두면 머신·저장소 단위로 적용).
짧은 확인·슬래시 커맨드·글자가 거의 없는 프롬프트(붙여넣기 등)는 건너뛴다.
"""
import json
import os
import re
import sys

# Windows 콘솔 기본 인코딩(cp949)에서 한글·이모지가 깨지지 않도록 고정
for _s in (sys.stdin, sys.stdout):
    try:
        _s.reconfigure(encoding="utf-8")
    except Exception:
        pass

MODE1 = """[english-coach · 모드 1] 사용자가 한글로 썼다. 응답 맨 앞에 아래 블록을 넣은 뒤 평소처럼 작업한다. 블록은 학습용이고, 작업 해석은 한글 원문을 따른다.

🗣 <요청의 핵심을 구어체 영어로 2~4줄. 한국어 연결 어미(-는데/-고/-서/-니까) 자리마다 문장을 끊고 But / And / So 같은 담화 표지로 다음 문장을 시작한다. 문장당 10단어 안팎, 문장마다 동사 하나, 종속절 중첩 금지>
   · <한글 표현 → 영어 표현. 사용자가 모를 법한 것 하나만. 없으면 이 줄을 쓰지 않는다>

규칙: 원어민이 말할 때 쓰는 구어체로 쓰고 문어체로 다듬지 않는다. 메시지가 길어도 전체를 옮기지 않고 핵심 요청만 옮긴다. 프롬프트가 한 단어 답·사소한 확인이면 블록을 생략한다. 이 형식과 구어체 기준은 이 블록에만 적용한다 — 사용자가 따로 요청한 영어 교정(논문·이메일 등)에는 적용하지 않는다."""

MODE2 = """[english-coach · 모드 2] 사용자가 영어로 썼다 (말하기 연습 중). 응답 맨 앞에 아래 블록을 넣은 뒤, 이해한 대로 작업한다.

🗣 Got it: <이해한 요청을 영어 한 문장으로>
   ✎ <사용자 문장을 원어민이 말하듯 다시 쓴 것. 끊어 말하기: 연결 어미가 들어갈 자리마다 마침표, 문장당 10단어 안팎, 종속절 중첩 금지. 원문이 이미 자연스러우면 "✎ OK" 한 줄만>
   · <고친 이유 중 가장 중요한 하나를 한글 한 줄로. OK면 이 줄 생략>

규칙: 칭찬하지 않는다 — 틀리거나 부자연스러운 것만 짚고 괜찮으면 OK. 해석이 둘 이상 갈리고 작업 비용이 크면(삭제·장시간 작업·외부 전송) 진행하지 말고 한글로 확인 질문만 한다. 사용자가 다음 턴에 한글로 바로잡으면 그 턴은 모드 1로 처리된다. 이 형식과 구어체 기준은 이 블록에만 적용한다 — 사용자가 따로 요청한 영어 교정(논문·이메일 등)에는 적용하지 않는다."""

HANGUL = re.compile(r"[\uac00-\ud7a3]")
LATIN = re.compile(r"[A-Za-z]")


def main() -> None:
    if os.environ.get("ENGLISH_COACH", "").lower() in ("off", "0", "false"):
        return
    try:
        data = json.load(sys.stdin)
    except Exception:
        return
    prompt = (data.get("prompt") or data.get("user_input") or "").strip()
    if not prompt or prompt.startswith("/"):
        return
    # URL·코드 경로 제거 후 글자만 센다 (붙여넣기 위주 프롬프트 제외)
    text = re.sub(r"https?://\S+|`[^`]*`|```.*?```", " ", prompt, flags=re.S)
    hangul = len(HANGUL.findall(text))
    latin = len(LATIN.findall(text))
    if hangul + latin < 12:
        return
    # 한국어 문법 문장은 조사·어미가 여러 어절에 붙는다 → 한글 포함 어절이 3개 이상이면 영어 용어가 많아도 한글 요청.
    # 영어 시도에 모르는 단어만 한글로 섞은 경우("check the 대조군 of ...")는 어절 1~2개라 모드 2.
    hangul_words = sum(1 for w in text.split() if HANGUL.search(w))
    is_korean = hangul_words >= 3 or hangul / (hangul + latin) >= 0.3
    mode = MODE1 if is_korean else MODE2
    print(json.dumps({
        "hookSpecificOutput": {"hookEventName": "UserPromptSubmit", "additionalContext": mode}
    }, ensure_ascii=False))


if __name__ == "__main__":
    main()
