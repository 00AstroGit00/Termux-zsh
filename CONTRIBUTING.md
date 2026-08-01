# Contributing to Termux-zsh

Thank you for considering contributing to `Termux-zsh`!

## Pull Request Checklist

Before submitting a pull request, please ensure:
1. All shell scripts follow POSIX/Bash strict mode guidelines (`set -euo pipefail`).
2. Script changes pass syntax checks (`bash -n` and `zsh -n`).
3. Code changes conform to ShellCheck recommendations.
4. No core identity components (Powerlevel10k, `IrBlack` default theme, JetBrains Mono font, <kbd>Ctrl</kbd>+<kbd>O</kbd>, <kbd>Ctrl</kbd>+<kbd>E</kbd>, touch D-pad keys) are altered without explicit review.

## Submitting Extensions

Custom themes, plugins, and fonts can be submitted to the `community/` directory following the JSON SDK metadata schemas.
