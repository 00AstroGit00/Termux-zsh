# Termux-Zsh v12.0.0 — Command Reference Manual

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
| `termux doctor` | `termux doctor [--fix]` | Run 14 automated diagnostic health checks & Android 14–16 advisories. Pass `--fix` to auto-repair. |
| `termux theme` | `termux theme [list\|set \<name\>\|preview \<name\>\|current]` | Color scheme manager with 16-color ANSI previewer. |
| `termux font` | `termux font [list\|set \<1-12\>\|restore]` | Nerd Font manager. Supports 12 fonts including JetBrains Mono, Fira Code, Hack. |
| `termux plugin` | `termux plugin [list\|install \<url\>\|update\|remove \<name\>]` | Zsh plugin lifecycle manager. |
| `termux package` | `termux package [list\|install \<profile\>]` | Developer package profile installer (11 profiles). |
| `termux backup` | `termux backup [list\|create\|restore\|export\|import\|clean]` | Backup manager & portable snapshot archive export/import (.tar.gz). |
| `termux benchmark` | `termux benchmark` | Measure real Zsh startup latency in milliseconds. |
| `termux reset` | `termux reset` | Baseline factory reset with automatic snapshot backup creation. |
| `termux failsafe` | `termux failsafe [check\|repair\|reset-shell]` | Emergency configuration recovery & syntax validation tool. |
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
