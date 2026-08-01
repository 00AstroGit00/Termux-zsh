# Termux-Zsh vNext Modular Architecture

This document details the internal architecture, module dependencies, and engine flow of the `Termux-zsh` framework.

---

## Directory Design

- `bin/`: CLI management commands (`termux-settings`, `termux-doctor`, `termux-theme`, `termux-font`, `termux-plugin`, `termux-packages`, `termux-backup`).
- `core/`: Environment detection (`env.sh`), UI formatting (`ui.sh`), backup engine (`backup_engine.sh`), module loader (`module_loader.sh`).
- `modules/`: Feature capability modules.
- `motd/`: Dynamic welcome banner modules (`00_header.sh`, `10_shortcuts.sh`).
- `Termux/`: Assets for color properties, fonts, extra-keys settings, and MOTD.
- `OhMyZsh/`: Zsh templates and Powerlevel10k configurations.
- `docs/`: Complete documentation specifications.
