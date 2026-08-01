# Termux-zsh Modernized Setup

⚡ **An ultra-fast, modular, and feature-rich Zsh environment for Termux featuring Powerlevel10k, curated color schemes, Nerd Fonts, centered touch D-pad layout, and built-in CLI management tools.**

[![Latest Release](https://img.shields.io/github/v/release/00AstroGit00/Termux-zsh?style=for-the-badge&color=00FF66&logo=github)](https://github.com/00AstroGit00/Termux-zsh/releases)
[![Build Status](https://img.shields.io/github/actions/workflow/status/00AstroGit00/Termux-zsh/ci.yml?branch=master&style=for-the-badge&logo=githubactions&color=00E5FF)](https://github.com/00AstroGit00/Termux-zsh/actions)
[![License](https://img.shields.io/github/license/00AstroGit00/Termux-zsh?style=for-the-badge&color=7AA2F7)](LICENSE)
[![API Status](https://img.shields.io/badge/API-FROZEN_v7.0-green?style=for-the-badge&color=00FF66)](#)
[![Android](https://img.shields.io/badge/Android-10--16_Compatible-blue?style=for-the-badge&logo=android&color=3DDC84)](#)

![Termux-zsh-SS](Termux-zsh-SS.png)

---

## ⚡ Quick One-Liner Installation

Copy and paste this single command into Termux:

```bash
pkg update -y && pkg install -y git && rm -rf Termux-zsh && git clone --depth=1 https://github.com/00AstroGit00/Termux-zsh.git && cd Termux-zsh && bash setup.sh
```

---

## ⌨️ Centered Touch Keyboard D-Pad Layout

`Termux-zsh` configures a centered, touch-friendly arrow D-pad on your Termux extra-keys bar (`termux.properties`):

```
┌──────┬──────┬──────┬──────┬──────┬──────┬──────┐
│ ESC  │ CTRL │  /   │  UP  │  |   │ HOME │ PGUP │  Row 1 (Top)
├──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ TAB  │ ALT  │ LEFT │ DOWN │RIGHT │ END  │SHIFT │  Row 2 (Bottom)
└──────┴──────┴──────┴──────┴──────┴──────┴──────┘
```
- **Top Center (Col 4, Row 1)**: `UP` Arrow
- **Bottom Center (Cols 3–5, Row 2)**: `LEFT` – `DOWN` – `RIGHT` Arrows (centered directly below `UP`)

---

## 🛠️ Master CLI Management Tools (`termux`)

Manage your environment effortlessly using the unified `termux` master command:

| Command | Usage | Description |
| :--- | :--- | :--- |
| **`termux`** | `termux <subcommand>` | Master CLI entrypoint wrapper. |
| **`termux doctor`** | `termux doctor [--fix]` | Runs 11 automated diagnostic health checks & auto-repairs. |
| **`termux theme`** | `termux theme [list\|set\|current]` | Switch color schemes (IrBlack, Catppuccin, Tokyo Night, Dracula, Nord). |
| **`termux font`** | `termux font [list\|set\|restore]` | Switch Nerd Fonts (JetBrains Mono, Fira Code, Cascadia, Hack, MesloLGS). |
| **`termux plugin`** | `termux plugin [list\|install\|update]` | Manage custom Zsh plugins. |
| **`termux packages`** | `termux packages [list\|install]` | Install pre-configured developer package profiles. |
| **`termux backup`** | `termux backup [list\|create\|restore]` | Manage atomic timestamped backups in `~/.termux-zsh-backups/`. |

---

## 📦 Developer Package Profiles

Install complete development stacks with one command using `termux packages install <profile>`:

| Profile | Included Packages |
| :--- | :--- |
| **`minimal`** | `curl`, `wget`, `git`, `micro`, `zsh`, `less`, `man` |
| **`dev`** | `build-essential`, `cmake`, `ninja`, `gdb`, `ripgrep`, `fd`, `git-delta` |
| **`python`** | `python`, `python-pip`, `libffi`, `openssl` |
| **`nodejs`** | `nodejs`, `yarn` |
| **`rust`** | `rust` |
| **`go`** | `golang` |
| **`android`** | `android-tools`, `openjdk-17` |
| **`devops`** | `openssh`, `rclone`, `rsync`, `udocker` |
| **`security`** | `nmap`, `netcat`, `tcpdump`, `termux-api` |
| **`aiml`** | `python`, `python-pip`, `clang`, `fftw`, `libxml2` |
| **`student`** | `micro`, `python`, `git`, `man`, `less` |

---

## 📚 Framework Documentation Suite

- [**Architecture Guide**](docs/ARCHITECTURE.md) — Detailed internal architecture and directory design.
- [**CLI Manual**](docs/COMMANDS.md) — Complete usage guide for all `termux-*` commands.
- [**Release Roadmap**](docs/ROADMAP.md) — Milestone roadmap and version history.
- [**Security Policy**](SECURITY.md) — Vulnerability disclosure policy.
- [**Contributing Guidelines**](CONTRIBUTING.md) — Developer onboarding & extension submission guide.

---

## 🤝 License & Governance

Distributed under the **GNU General Public License v3.0 (GPLv3)**. See [`LICENSE`](LICENSE) for details.
