# Termux-Zsh Version History & Roadmap

## v7.0.0 — Public Release (Current)
- **Tagged release** on GitHub with full CI validation
- ShellCheck + `bash -n` syntax audits across all scripts
- GitHub community files: Issue templates, PR template, CODEOWNERS, SECURITY.md
- Comprehensive bug-fix pass: fixed all CLI usage strings, replaced invalid `docker-cli` with `udocker`, corrected version strings, added `termux update` subcommand
- Uptime metric added to MOTD system metrics card

## v6.0 — API Freeze & Sustainability
- API surface frozen in `core/api.sh` (config key-value engine, dependency validation, logging)
- Added SECURITY.md vulnerability disclosure policy
- Added CONTRIBUTING.md developer onboarding guide

## v5.0 — Production Release & Modular MOTD
- Converted monolithic welcome banner into modular `motd/` engine
  - `00_header.sh`: ASCII art banner with Termux version/arch
  - `10_shortcuts.sh`: Keyboard shortcuts and customization commands card
  - `20_system.sh`: Real-time RAM, storage, and uptime metrics
- Added Zsh tab-completion for `termux` CLI (`OhMyZsh/plugins/termux/_termux`)

## v4.0 — Enterprise Framework & Master CLI
- Built unified `termux` master CLI dispatcher (`bin/termux`)
- Implemented full management suite:
  - `termux doctor` — 12-point diagnostic health checker with `--fix` auto-repair
  - `termux theme` — Color scheme manager (IrBlack, Catppuccin, Tokyo Night, Dracula, Nord)
  - `termux font` — Nerd Font manager (12 fonts)
  - `termux plugin` — Zsh plugin lifecycle manager
  - `termux package` — 11 developer package profiles
  - `termux backup` — Atomic timestamped backup/restore engine
  - `termux settings` — Interactive TUI settings dashboard
- Developer API core (`core/api.sh`, `core/env.sh`, `core/ui.sh`, `core/backup_engine.sh`)

## v3.0 — Core Framework Architecture
- Built `core/` modular framework: `env.sh`, `ui.sh`, `backup_engine.sh`, `module_loader.sh`
- Introduced centered touch D-pad extra-keys layout in `Termux/termux.properties`
- Optional modern CLI tools integration: `eza`, `bat`, `fzf`, `zoxide`, `ripgrep`, `fd`, `delta`
- Multi-language support (`Termux/lang/`)
- `lf` file manager with `Ctrl+O` keybinding

## v2.0 — Modernization
- Migrated from basic `.zshrc` to Oh My Zsh framework
- Added Powerlevel10k instant prompt for <15ms cold-start
- Integrated IrBlack color theme + JetBrains Mono Nerd Font

## v1.0 — Initial Release
- Basic Zsh + Oh My Zsh + Powerlevel10k installer for Termux

---

## Roadmap: Future Directions

- **Shell completion polish** — extend `_termux` completion to cover all subcommand args
- **Community themes** — accept user-contributed `.properties` color schemes via PR
- **Notification hooks** — `termux-notification` integration for long-running task alerts (Termux:API)
