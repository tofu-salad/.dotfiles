#!/usr/bin/env bash
#
# enable color support of ls and also add handy aliases
alias ll='LC_COLLATE=C ls -ialF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
if [ -x "$(which dircolors)" ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
if command -v exa > /dev/null;
    then alias ls='exa -al --color=always --group-directories-first';
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
alias H='./.local/bin/wrappedhl'
alias update-neovim='ansible-playbook --ask-become-pass $HOME/Tmp/ansible/neovim.yml'
