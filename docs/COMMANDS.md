# Termux-Zsh v7.0.0 — Command Reference Manual

All management commands are accessed through the unified `termux` master CLI entrypoint.

## Usage

```bash
termux <subcommand> [args]
```

---

## Command Suite

| Command | Usage | Description |
| :--- | :--- | :--- |
| `termux settings` | `termux settings` | Launch interactive TUI settings dashboard. |
| `termux doctor` | `termux doctor [--fix]` | Run 12 automated diagnostic health checks. Pass `--fix` to auto-repair errors. |
| `termux theme` | `termux theme [list\|set \<name\>\|current]` | Color scheme manager. Includes IrBlack, Catppuccin, Tokyo Night, Dracula, Nord. |
| `termux font` | `termux font [list\|set \<1-12\>\|restore]` | Nerd Font manager. Supports 12 fonts including JetBrains Mono, Fira Code, Hack. |
| `termux plugin` | `termux plugin [list\|install \<url\>\|update\|remove \<name\>]` | Zsh plugin lifecycle manager. |
| `termux package` | `termux package [list\|install \<profile\>]` | Developer package profile installer (11 profiles). |
| `termux backup` | `termux backup [list\|create \<label\>\|restore\|clean]` | Timestamped backup and restore manager. |
| `termux update` | `termux update` | Pull latest framework updates from GitHub. |
| `termux version` | `termux version` | Display framework version string. |

---

## Package Profiles

Install complete dev stacks with `termux package install <profile>`:

| Profile | Packages |
| :--- | :--- |
| `minimal` | `curl wget git micro zsh less man` |
| `dev` | `build-essential cmake ninja gdb ripgrep fd git-delta` |
| `python` | `python python-pip libffi openssl` |
| `nodejs` | `nodejs yarn` |
| `rust` | `rust` |
| `go` | `golang` |
| `android` | `android-tools openjdk-17` |
| `devops` | `openssh rclone rsync udocker` |
| `security` | `nmap netcat tcpdump termux-api` |
| `aiml` | `python python-pip clang fftw libxml2` |
| `student` | `micro python git man less` |
