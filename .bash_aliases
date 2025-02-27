#!/usr/bin/env bash

# enable color support of ls and also add handy aliases
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias ll='LC_COLLATE=C ls -ialF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

if [ -x "$(which dircolors)" ]; then
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if command -v exa >/dev/null; then
    alias ll='exa -al --color=always --group-directories-first'
    alias la='exa -al --color=always'
    alias l='exa'
fi

# add an "alert" alias for long running commands.  use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles='git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME/.dotfiles'

if command -v nvim >/dev/null; then
    alias vim='nvim'
fi
alias H='./.local/bin/wrappedhl'
alias update-neovim='ansible-playbook --ask-become-pass $HOME/Tmp/ansible/neovim.yml'

# nixos specific
if [[ -f /etc/os-release ]] && grep -q "ID=nixos" /etc/os-release; then
    alias rebuild-nixos='sudo nixos-rebuild switch --flake $HOME/.config/nixos/#desktop'
    alias update-nixos='nix flake update --flake $HOME/.config/nixos && sudo nixos-rebuild switch  --flake $HOME/.config/nixos/#desktop'
else
    echo "not running NIXOS"
fi
