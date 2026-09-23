# Claude Skills Repository

Personal Claude Code configuration, packaged so any workstation can be set up from this repo.

## Layout

```
claude-skills/
├── .claude-plugin/marketplace.json   # this repo is its own plugin marketplace (ys-skills)
├── plugins/ys-research/              # the plugin
│   ├── skills/          paper-summary · research-presentation · design-partner · code-cleaner
│   ├── agents/          research-advisor · scout
│   └── output-styles/   discuss (user default) · research-dev (experiment repos)
├── templates/
│   ├── user/            ~/.claude/CLAUDE.md master · settings.json keys      (per workstation)
│   └── project-dev/     settings.json (style + report-gate hook) · STATUS.md · CLAUDE.md snippet  (per experiment repo)
├── scripts/             setup-workstation.sh · apply-project-dev.sh
├── docs/                AUTHORING.md (skills/agents/styles) · mcp-servers.md · troubleshooting
└── vendor/mcp/nanobanana   git submodule — MCP server run from this path
```

## Three layers

| Layer | Scope | Carried by | Contains |
|---|---|---|---|
| Plugin | every workstation, every repo | this repo → `git pull` + `claude plugin update` (bump `version` in plugin.json on change) | skills, agents, output styles |
| User | once per workstation | `scripts/setup-workstation.sh` | `~/.claude/CLAUDE.md` copy, default output style, shared auto-memory dir, MCP servers |
| Project | experiment repos only | that repo's git, via `scripts/apply-project-dev.sh` | `research-dev` style, Stop hook that gates reports, `docs/STATUS.md` |

Rationale: the same knowledge and tools everywhere, a different response format per context. Vault and paper repos stay on `discuss`; cluster/experiment repos switch to `research-dev`, which reports state (not events), tags every claim with a confidence level, and asks for one decision at a time with a recommendation.

## Setup

See [SETUP_GUIDE.md](SETUP_GUIDE.md). Authoring rules: [docs/AUTHORING.md](docs/AUTHORING.md).
