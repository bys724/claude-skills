# Claude Skills Repository

Personal Claude Code configuration, packaged so any workstation can be set up from this repo.

## Layout

```
claude-skills/
├── .claude-plugin/marketplace.json   # this repo is its own plugin marketplace (ys-skills)
├── plugins/ys-research/              # the plugin
│   ├── skills/          paper-summary · research-presentation · design-partner · code-cleaner
│   ├── agents/          research-advisor · scout
│   ├── output-styles/   discuss (user default) · research-dev (experiment repos)
│   ├── hooks/           english-coach (UserPromptSubmit) — English speaking coach
│   └── evals/           `claude plugin eval` cases — skill triggers, hook modes
├── templates/
│   ├── user/            ~/.claude/CLAUDE.md master · settings.json keys      (per workstation)
│   └── project-dev/     settings.json (style) · STATUS.md · CLAUDE.md snippet  (per experiment repo)
├── scripts/             setup-workstation.sh · apply-project-dev.sh
├── routines/            instructions read by cloud routines (/schedule) — weekly-brief.md
├── docs/                AUTHORING.md (skills/agents/styles) · mcp-servers.md · troubleshooting
└── vendor/mcp/nanobanana   git submodule — MCP server run from this path
```

## Three layers

| Layer | Scope | Carried by | Contains |
|---|---|---|---|
| Plugin | every workstation, every repo | this repo → `git pull` + `claude plugin update` (bump `version` in plugin.json on change) | skills, agents, output styles, hooks |
| User | once per workstation | `scripts/setup-workstation.sh` | `~/.claude/CLAUDE.md` copy, default output style, shared auto-memory dir, MCP servers |
| Project | experiment repos only | that repo's git, via `scripts/apply-project-dev.sh` | `research-dev` style, `docs/STATUS.md` |

English coach (plugin hook, on everywhere): a Korean request gets a short spoken-English model of the request before the work starts; an English request gets a one-line restatement of what was understood plus a natural rewrite. Turn off per machine or repo with `ENGLISH_COACH=off` in settings `env`.

Rationale: the same knowledge and tools everywhere, a different response format per context. Vault and paper repos stay on `discuss`; cluster/experiment repos switch to `research-dev`, which reports state (not events), tags every claim with a confidence level, and asks for one decision at a time with a recommendation.

Weekly brief: a cloud routine (Mondays 09:00 KST) reads [routines/weekly-brief.md](routines/weekly-brief.md), collects last week's arxiv papers matching the interest profile plus robotics/AI industry news, and publishes one artifact page (push notification with the link) with a ready-to-paste reading-list block. The profile is distilled from the vault by a local session (the cloud run cannot see the vault); ask for a routine refresh to update it. Manage the routine at claude.ai/code/routines.

## Setup

See [SETUP_GUIDE.md](SETUP_GUIDE.md). Authoring rules: [docs/AUTHORING.md](docs/AUTHORING.md).
