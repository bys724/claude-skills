# Claude Skills Repository

Personal workspace for managing Claude Code skills and agents.

## Repository Structure

```
claude-skills/
├── .claude/          # Project-specific Claude configuration
├── agents/custom/    # Custom agents
│   ├── research-advisor/
│   └── scout/
├── custom/           # Custom skills
│   ├── code-cleaner/
│   ├── design-partner/
│   ├── paper-summary/
│   └── research-presentation/
├── docs/             # Troubleshooting and architecture docs
├── global/           # Global configuration and guides
├── scripts/          # Utility scripts
└── vendor/           # Third-party submodules
    ├── mcp/          # MCP servers (claude-mermaid, nanobanana)
    └── official/     # Official Claude skills (anthropics/skills)
```

## Custom Skills

- **paper-summary**: Academic paper reading workflow (arxiv -> discussion -> Zotero enrichment)
- **research-presentation**: Research presentation slide creation
- **design-partner**: AI image generation prompt coaching (Midjourney + Nano Banana)
- **code-cleaner**: Minimalist code cleanup and refactoring

## Custom Agents

- **research-advisor**: Research direction analysis with trend data
- **scout**: Market research and product comparison

## Setup

See [SETUP_GUIDE.md](SETUP_GUIDE.md) for installation and configuration.