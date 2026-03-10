# Claude Skills Repository

Personal workspace for managing Claude Code skills and agents.

## 📁 Repository Structure

```
claude-skills/
├── .claude/          # Project-specific Claude configuration
├── agents/           # Agent definitions
│   └── custom/       # Custom agents (research-advisor, scout)
├── custom/           # Custom skills
│   ├── design-partner/
│   ├── paper-summary/
│   └── research-presentation/
├── global/           # Global configuration and guides
├── scripts/          # Management scripts
│   ├── install*.sh   # Installation scripts
│   ├── list*.sh      # Listing scripts
│   └── uninstall*.sh # Uninstallation scripts
└── vendor/           # Third-party skills and MCP servers
    ├── mcp/          # MCP servers
    └── official/     # Official Claude skills
```

## 🎯 Purpose

This repository serves as a centralized location for:
- **Custom Skills**: Domain-specific skills for research, design, and development
- **Agents**: Specialized agents for complex tasks
- **Scripts**: Tools for managing and deploying skills/agents
- **Vendor Code**: Third-party integrations and official skills

## 🚀 Quick Start

### Install Skills
```bash
# Install official skills
./scripts/install-official.sh

# Install custom agents
./scripts/install-agents.sh
```

### List Available Skills
```bash
# List all skills
./scripts/list.sh

# List agents only
./scripts/list-agents.sh
```

## 📚 Current Skills

### Custom Skills
- **paper-summary**: Academic paper reading workflow
- **research-presentation**: Research presentation creation
- **design-partner**: Design assistance with prompting

### Custom Agents
- **research-advisor**: Research direction analysis
- **scout**: Market research and comparison

## 🔧 Management

### Scripts Usage
- `install.sh`: Install skills to Claude Code
- `list.sh`: List available skills
- `uninstall.sh`: Remove installed skills
- `update-official.sh`: Update official skills from upstream

## 📝 Documentation

- See `global/` for global configuration and guides
- Each skill/agent has its own README in its directory
- Check `.claude/CLAUDE.md` for project-specific settings

## 🤝 Contributing

When adding new skills or agents:
1. Place custom skills in `custom/`
2. Place agents in `agents/custom/`
3. Update relevant documentation
4. Test with provided scripts

## 📄 License

This repository contains both original work and third-party code. See individual directories for specific licenses.