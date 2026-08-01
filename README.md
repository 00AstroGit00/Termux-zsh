# Termux-zsh Modernized Setup

⚡ **An ultra-fast, modular, and feature-rich Zsh environment for Termux featuring Powerlevel10k, curated color schemes, Nerd Fonts, centered touch D-pad layout, and built-in CLI management tools.**

![Termux-zsh-SS](Termux-zsh-SS.png)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/598b9e66297c4323a25dada99d377a11)](https://app.codacy.com/gh/Sohil876/Termux-zsh/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

---

## ⚡ Quick One-Liner Installation

Copy and paste this single command into Termux:

```bash
pkg update -y && pkg install -y git && rm -rf Termux-zsh && git clone --depth=1 https://github.com/00AstroGit00/Termux-zsh.git && cd Termux-zsh && bash setup.sh
```

---

## 🚀 Features

- **Automated Zsh & Oh My Zsh Setup**: Installs Zsh and configures Oh My Zsh with recommended plugins (`alias-finder`, `command-not-found`, `git`, `node`, `npm`, `zsh-autosuggestions`, `zsh-syntax-highlighting`).
- **Powerlevel10k & JetBrains Mono Nerd Font**: Includes pre-configured Powerlevel10k prompt theme and font integration.
- **Color & Font Changers**: Built-in interactive terminal themes (`color-changer`) and Nerd Font installer (`font-changer`).
- **Terminal File Manager (`lf`)**: Fast keyboard-driven file navigation bound to <kbd>Ctrl</kbd> + <kbd>O</kbd> preserving working directory on exit.
- **Command Line Editor**: Press <kbd>Ctrl</kbd> + <kbd>E</kbd> to open current line in `micro` text editor.
- **Modern CLI Utility Integrations (Opt-in)**: Auto-detects and enables modern tools with safe fallbacks:
  - `eza` (modern replacement for `ls`)
  - `bat` (syntax-highlighted `cat`)
  - `zoxide` (smart directory navigation)
  - `fzf` (fuzzy search integration)
  - `direnv` (directory environment management)
  - `atuin` (shell history sync)
- **Non-Destructive Atomic Backups**: Automatically backs up pre-existing configs (`.zshrc`, `.p10k.zsh`, `.termux`, `.config/lf`) to `~/.termux-zsh-backups/backup_<timestamp>/`.
- **Restoration & Repair Tool**: Includes [`uninstall.sh`](uninstall.sh) to quickly restore previous configurations or reset shell back to `bash`.
- **Idempotent Installation**: Safe to re-run anytime; updates existing git repositories instead of crashing.

---

## 🛠️ Quick Installation

```bash
# 1. Update Termux package index
pkg update && pkg install -y git

# 2. Clone repository and change directory
git clone https://github.com/Sohil876/Termux-zsh.git && cd Termux-zsh

# 3. Run installation script
bash setup.sh
```

---

## 🧰 Recommended Modern Tool Packages

To enable enhanced terminal tools (`eza`, `bat`, `fzf`, `zoxide`), run:

```bash
pkg install -y eza bat fzf zoxide direnv ripgrep fd
```

`Termux-zsh` will automatically detect these tools and hook them into your interactive shell environment.

---

## 🔄 Updating & Upgrading

- **Oh My Zsh & Plugins**: Run `omz update`
- **Powerlevel10k Theme**: Run `p10k-update`
- **Custom Plugins**: Run `custom-plugins-update`
- **Re-running Installer**: Simply run `bash setup.sh` inside the cloned directory.

---

## ↩️ Rollback & Uninstallation

If you ever need to restore your old configuration or switch back to standard `bash`:

```bash
bash uninstall.sh
```

This interactive tool restores your latest timestamped backup from `~/.termux-zsh-backups/` and allows you to reset your default shell.
