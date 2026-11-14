# 주간 브리프 — 논문 + 로봇·AI 업계 소식 (클라우드 루틴 지시문)

> 클라우드 루틴(매주 월요일 09:00 KST)이 이 파일을 읽고 따른다. 루틴 프롬프트는 "이 파일을 따르라"뿐이라, 내용을 바꾸려면 **이 파일만 고쳐 push**하면 다음 실행부터 반영된다.
> 관심사 프로필과 "이미 아는 논문"은 로컬 세션이 Vault를 읽어 요약한 것이다 (갱신: 2026-11-15). 클라우드 세션은 Vault를 볼 수 없으므로 이 파일이 유일한 근거다.
> 이 저장소는 공개다 — 이 파일에는 공개 문헌의 주제·논문 이름만 적는다.

## 독자

로봇 파운데이션 모델 연구원 한 명. 월요일 아침에 15분 안에 읽고 "이번 주에 무엇을 읽을지, 업계에서 무슨 일이 있었는지"를 파악하는 용도. 한국어로 쓰고 논문 제목·용어·회사명은 원문 그대로. 질문에서 출발해 필요한 것을 찾아 읽는 사람이므로, 논문마다 "어떤 질문에 답하는 논문인가"를 먼저 말한다.

## 관심사 프로필

아래 축에 **새 방법·새 결과·새 반례**를 직접 내는 논문이 대상이다. 위쪽 축일수록 우선한다.

1. **행동 라벨 없는 로봇 표현 학습** — 영상만으로 배우는 시각 표현, 사람 영상(egocentric) 사전학습, embodiment에 묶이지 않는 표현. 조작용 시각 표현 비교·probing 연구 (R3M·VC-1·DINOv2·SigLIP·Theia·Voltron 계열)
2. **변화·모션을 따로 다루는 표현** — two-stream / appearance–motion 분리, masked video modeling(VideoMAE·SiamMAE·MotionMAE·V-JEPA 계열), 프레임 차분·optical flow를 입력이나 타깃으로 쓰는 방법
3. **영상에서 진행도·가치·보상 추정** — progress estimation, value-from-video, 시간 거리 학습 (VIP·LIV·GVL·TCN·SARM·PROGRESSOR 계열), VLM 기반 zero-shot reward, 데모 품질 평가
4. **잠재 액션·역동역학** — latent action model (LAPA·LAPO·Genie·AdaWorld 계열), 프레임 쌍에서 액션을 뽑는 방법, 잠재 액션의 합성·구조에 대한 분석
5. **Goal-conditioned / offline RL** — quasimetric·contrastive RL, hindsight 재라벨, 계층 GCRL(HIQL 계열), VLA를 RL·advantage로 개선하는 방법
6. **예측–실측 잔차를 쓰는 제어** — 세계 모델·액션 조건 예측과 실제 관측의 차이를 실패 탐지·교정·재계획에 쓰는 방법, 자기 움직임과 외부 변화의 분리, active inference의 로봇 적용
7. **VLA·범용 정책** — 새 VLA 아키텍처(dual-system 포함), 대규모 데이터·cross-embodiment 학습, 범용 정책의 평가 방법론과 벤치마크의 맹점
8. **센서·뷰 결손에 강한 표현** — 손목 카메라 등 뷰가 빠질 때의 강건성, multi-view 표현, 가림(occlusion)
9. **휴머노이드 학습** — whole-body 제어 + 조작의 학습 방식, 데이터 수집(텔레오퍼레이션·모션 리타게팅·사람 영상)

덜 중요: 순수 LLM·NLP, 자율주행 전용, 의료 영상, 하드웨어 설계만 다루는 논문, 시뮬레이터 릴리스 노트.

## 이미 아는 논문 (보고서에서 제외)

노트가 있는 것: ALOHA · ASGR · BridgeData V2 · C-Learning · CLIP · CLIP-RT · CURL · Causal Confusion · DINO · DINOtxt · DeFM · Diffusion Policy · EgoDex · GNM · GVL · LAPA · LIV · MotionMAE · MultiMAE · Octo · OpenHelix · OpenVLA · Pi0 · π0.7 · R2VLM · R3M · RT-2 · RT-X · SARM · SOF · SiamMAE · SlowFast · TCN · Talk2DINO · TraceGen · TwinBrainVLA · Two-Stream ConvNets · UMI-on-Air · V-JEPA 2 · VIP · ViNT · ViVa · VideoMAE · Voltron · X-Diffusion · X-VLA · iBOT · mHC

읽기 목록에 이미 있는 것: HER · GCSL · QRL · MRN · VICReg · Contrastive RL · XIRL · DVD · LAPO · Genie · PROGRESSOR · AC-LAM · ALAM · AdaWorld · LAOM · Dream2Reward · VC-1 · MAE · DINOv2 · SigLIP · VideoMAE V2 · V-JEPA · MaskFeat · Data2Vec · Theia · BeT · ACT · MVP · CAST · MGMAE · MAM² · LIBERO-Occ · Cosmos · Sapiens · Helix · ROVER · SARM2 · SPIRAL · RISE · HABC · HIQL · Act2Goal · Seer · PIDM · CORE · Quasimetric GCRL · ProQ · Chunk-Guided Q-Learning · OpenGVL · DemInf · ProcVLM · DataMIL · TOPReward · TimeRewarder · GCR · PATCH · CheckVLA · TacPAC · HiTac-WAM · Foresight · ContactGuard · FoMo-FD

이 목록의 논문은 다시 추천하지 않는다. 단 **후속작**(예: "X의 저자들이 낸 X2")은 "○○ 후속"이라고 밝히고 포함한다.

## 1부. 논문 (지난 7일)

오늘 날짜는 `date -u`로 확인한다. "지난 7일"은 그 기준 제출일이다.

### 수집

arxiv API (Atom XML)를 Bash로 조회한다 — 반드시 `https`와 `-L`을 쓴다 (`http`는 리다이렉트되어 빈 응답이 온다, 2026-11-15 실측): `curl -sL -G "https://export.arxiv.org/api/query" --data-urlencode 'search_query=<쿼리>' -d "sortBy=submittedDate&sortOrder=descending&max_results=60"`. 요청 사이 3초 간격 (arxiv 이용 규칙). 결과에서 `<published>`가 7일 이내인 것만 남긴다. 여러 쿼리에 걸린 논문은 하나로 합친다.

| 축 | `search_query` |
|---|---|
| 1·2 | `(cat:cs.RO OR cat:cs.CV) AND (abs:"visual representation" OR abs:"pretrained representation" OR abs:"masked video" OR abs:"video pretraining" OR abs:"two-stream") AND (abs:robot OR abs:manipulation)` |
| 1 | `(abs:"cross-embodiment" OR abs:"embodiment-agnostic" OR abs:"action-free" OR abs:"without action labels" OR abs:"egocentric video") AND (abs:robot OR abs:manipulation)` |
| 3 | `(abs:"progress estimation" OR abs:"value function" OR abs:"reward model" OR abs:"temporal distance") AND (abs:video OR abs:demonstration) AND (cat:cs.RO OR cat:cs.LG)` |
| 4 | `abs:"latent action" OR abs:"inverse dynamics model"` |
| 5 | `(abs:"goal-conditioned" OR abs:"offline reinforcement learning" OR abs:quasimetric) AND (abs:robot OR abs:manipulation)` |
| 6 | `(abs:"world model" OR abs:"prediction error" OR abs:"failure detection" OR abs:"active inference") AND (abs:robot OR abs:manipulation OR abs:policy) AND cat:cs.RO` |
| 7 | `cat:cs.RO AND (abs:"vision-language-action" OR abs:"VLA" OR abs:"generalist policy" OR abs:"foundation model")` |
| 8·9 | `cat:cs.RO AND (abs:"wrist camera" OR abs:"multi-view" OR abs:occlusion OR abs:humanoid) AND (abs:learning OR abs:policy)` |

`curl`이 실패하면(클라우드 환경 프록시가 arxiv를 막는 경우가 있다 — 2026-11-15 시험 실행에서 HTTP 000) 한 번만 확인하고 바로 다음으로 넘어간다:

1. **WebFetch**로 같은 `https://export.arxiv.org/api/query?...` URL을 가져온다 (쿼리는 URL 인코딩). 안 되면 축별로 `https://arxiv.org/list/cs.RO/recent` · `https://arxiv.org/list/cs.CV/recent` · `https://arxiv.org/list/cs.LG/recent` 목록을 가져와 제목으로 거른 뒤, 후보의 `https://arxiv.org/abs/<번호>`에서 초록을 확인한다
2. 그것도 안 되면 **WebSearch**로 축별 주제어를 `arxiv <주제어> <이번 달 연도>`로 찾는다

API 외 경로를 썼으면 보고서 "수집 통계"에 어떤 경로였는지와 "누락 가능"을 적는다. **수집 경로가 막혀도 보고서는 반드시 만든다** — 논문이 적게 잡히면 적은 대로 쓰고, 2부는 그대로 진행한다.

### 선별

전부 나열하지 않는다.

- **꼭 읽을 것 (최대 5편)**: 프로필 축 1–6에 직접 닿는 새 방법·결과. 대규모 실로봇 실험, 새 벤치마크, 기존 통념의 반례는 가점
- **훑어볼 것 (최대 10편)**: 관련은 있으나 점진적 개선·응용, 또는 축 7–9의 주목할 만한 것
- 근거는 초록에서 확인된 것만 쓴다. 초록에 없는 성능·주장·소속을 지어내지 않는다. 해당 주에 꼽을 것이 적으면 적은 대로 둔다

## 2부. 로봇·AI 업계 소식 (지난 7일)

WebSearch로 조사한다. 대상:

- **새 로봇·데모 공개**: 휴머노이드·매니퓰레이터 신제품, 주목받은 시연 영상 — 특히 중국 기업(Unitree · AgiBot · UBTECH · Fourier · Galbot · XPeng · Xiaomi 등)과 Figure · 1X · Tesla Optimus · Boston Dynamics · Apptronik · Agility
- **로봇 파운데이션 모델 기업**: Physical Intelligence · Skild AI · NVIDIA(GR00T·Cosmos) · Google DeepMind · Meta · TRI · Generalist 등의 모델·데이터셋 공개
- **스타트업·투자·인수**: 로봇 AI 분야 투자 유치, 인수합병, 주요 인력 이동
- **한국**: 현대차·보스턴다이내믹스, 삼성·레인보우로보틱스, LG, 네이버랩스 등의 발표
- **실제 배치**: 공장·물류·가정 배치 사례, 데이터 수집 방식의 변화

검색 예: `humanoid robot <이번 달 연도>`, `robotics startup funding this week`, `Unitree new robot`, `physical AI announcement`, `robot foundation model release` — The Robot Report, IEEE Spectrum, TechCrunch, Reuters, 기업 공식 블로그·뉴스룸을 우선한다.

쓰는 규칙:

- **5–8건**, 중요한 순서. 건마다: 무슨 일인가 한 문장 · 왜 주목할 만한가 한 문장 · 출처 링크(영상이 있으면 영상 링크도)
- **데모 영상은 검증 수준을 밝힌다**: 자율인지 원격조종인지, 편집·배속 여부가 기사에 명시됐는지. 확인되지 않으면 "자율 여부 미확인"이라고 쓴다. 회사 발표를 그대로 사실로 옮기지 않는다
- 날짜가 7일을 벗어난 기사는 넣지 않는다. 출처가 하나뿐이고 공식 발표가 아니면 "단일 출처"라고 표시한다

## 보고서 → 아티팩트 페이지

**Artifact 도구로 HTML 페이지 하나를 게시한다** (Claude Docs 커넥터는 쓰지 않는다 — 클라우드 루틴 세션에 붙지 않았다, 2026-11-15 실측). 절차: `artifact-design` 스킬을 로드하고 → 스크래치패드에 `weekly-brief.html`을 쓰고 → Artifact로 게시. 페이지 `<title>`은 `주간 브리프 YYYY-MM-DD` (실행일). 휴대폰에서 읽으므로 한 단 레이아웃, 표는 좁은 화면에서 가로 스크롤 없이 읽히게 카드나 2열로. 장식보다 읽기 쉬움이 우선이다.

게시가 끝나면 **PushNotification**으로 "주간 브리프 YYYY-MM-DD — 꼭 읽을 논문 N편, 업계 소식 M건" 한 줄과 페이지 링크를 보낸다. Artifact 게시가 실패하면 보고서 전문을 마지막 메시지에 마크다운으로 쓰고, 푸시로 실패 사실을 알린다 — 조사한 내용을 버리지 않는다.

문서 구조:

1. **이번 주 한 줄** — 논문 쪽 흐름 한 문장 + 업계 쪽 흐름 한 문장. 없으면 "뚜렷한 흐름 없음"
2. **꼭 읽을 논문** — 표: 제목(arxiv 링크) · 답하려는 질문 · 핵심 아이디어 한 문장 · 관심사 축(번호와 이름) · 왜 중요한가 한 문장
3. **훑어볼 논문** — 한 줄씩: 제목(링크) — 한 구절
4. **업계 소식** — 2부 규칙대로
5. **Reading List 추가 후보** — 아래 형식의 마크다운을 `<pre>` 블록 하나에 담는다(복사하기 쉽게). 독자가 Vault의 읽기 목록에 그대로 붙여 넣는다. "꼭 읽을 논문"만 넣고, 우선순위는 축 1–4에 직접 닿으면 🔥, 그 외 📖, 판단이 어려우면 💡

   ```markdown
   ## 주간 브리프 YYYY-MM-DD
   - 🔥 **짧은 이름** (YYYY-MM, [arxiv번호](https://arxiv.org/abs/번호)) — 한 줄 이유
   - 📖 **짧은 이름** (YYYY-MM, [arxiv번호](https://arxiv.org/abs/번호)) — 한 줄 이유
   ```
6. **수집 통계** — 축별 조회 건수 · 7일 이내 건수 · 선별 건수 · 실패한 쿼리

페이지와 푸시 알림 외에 다른 곳(저장소 커밋·PR·이메일)에는 아무것도 쓰지 않는다. 세션 마지막 메시지는 페이지 링크 한 줄.
