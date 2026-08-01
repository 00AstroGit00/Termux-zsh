# Termux-Zsh Custom Aliases & Android Integration

# Android API Convenience Wrappers (macOS / Linux parity)
if command -v termux-clipboard-set &>/dev/null; then
    alias pbcopy='termux-clipboard-set'
    alias cbcopy='termux-clipboard-set'
fi
if command -v termux-clipboard-get &>/dev/null; then
    alias pbpaste='termux-clipboard-get'
    alias cbpaste='termux-clipboard-get'
fi
if command -v termux-open &>/dev/null; then
    alias open='termux-open'
fi
if command -v termux-open-url &>/dev/null; then
    alias openurl='termux-open-url'
fi
if command -v termux-share &>/dev/null; then
    alias share='termux-share'
fi
if command -v termux-wake-lock &>/dev/null; then
    alias wakelock='termux-wake-lock'
    alias wakeunlock='termux-wake-unlock'
fi
if command -v termux-vibrate &>/dev/null; then
    alias vibrate='termux-vibrate -d'
fi
if command -v termux-toast &>/dev/null; then
    alias toast='termux-toast'
fi

# Termux Package Manager Shorthands
alias pki='pkg install'
alias pku='pkg update && pkg upgrade -y'
alias pks='pkg search'
alias pkr='pkg uninstall'
alias pkc='pkg clean && apt autoremove -y'

# PRoot Distro Shorthands
alias pd='proot-distro'
alias pdl='proot-distro login'
alias pds='proot-distro list'

# Android Storage Directory Navigation
alias sdcard='cd /sdcard 2>/dev/null || cd /storage/emulated/0'
alias downloads='cd ~/storage/downloads 2>/dev/null || cd /sdcard/Download'
alias dcim='cd ~/storage/dcim 2>/dev/null || cd /sdcard/DCIM'
alias documents='cd ~/storage/documents 2>/dev/null || cd /sdcard/Documents'

# Git Convenience
alias gc='git commit'

# Termux-Zsh Management Wrappers
alias color-changer='bash "${HOME}"/.termux/colors.sh'
alias font-changer='bash "${HOME}"/.termux/fonts.sh'
alias p10k-update='git -C "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/themes/powerlevel10k pull'
alias custom-plugins-update='termux plugin update'
