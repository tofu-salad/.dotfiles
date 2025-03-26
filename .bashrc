#!/usr/bin/env bash

# aliases {{{
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

if command -v nvim >/dev/null; then
    alias vim='nvim'
fi

# nixos specific
if [[ -f /etc/os-release ]] && grep -q "ID=nixos" /etc/os-release; then
    alias rebuild-nixos='sudo nixos-rebuild switch --flake $HOME/.config/nixos/#desktop'
    alias update-nixos='nix flake update --flake $HOME/.config/nixos && sudo nixos-rebuild switch  --flake $HOME/.config/nixos/#desktop'
else
    echo "not running NIXOS"
fi

# }}}

# prompt {{{
function parse_git_dirty {
    status=$(git status 2>&1 | tee)
    dirty=$(
        echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
        echo "$?"
    )
    untracked=$(
        echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
        echo "$?"
    )
    ahead=$(
        echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
        echo "$?"
    )
    newfile=$(
        echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
        echo "$?"
    )
    renamed=$(
        echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
        echo "$?"
    )
    deleted=$(
        echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
        echo "$?"
    )
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo "${bits}"
    else
        echo ""
    fi
}

function parse_git_branch() {
    BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ ! "${BRANCH}" == "" ]; then
        STAT=$(parse_git_dirty)
        echo "‹${BRANCH}${STAT}›"
    else
        echo ""
    fi
}

function in_nix_shell() {
    if [ -n "${IN_NIX_SHELL}" ]; then
        echo -n "<nix-shell> "
    else
        echo ""
    fi
}

function is_fhs() {
    if [ "${FHS}" = "1" ]; then
        echo -e "fhs "
    else
        echo ""
    fi
}

PS1='\[\e[34m\]$(in_nix_shell)\[\e[m\]\[\e[31m\]$(is_fhs)\[\e[m\]\[\e[32m\]\w \[\e[m\]\[\e[33m\]$(parse_git_branch)\[\e[m\] \$ '
# }}}

# paths {{{
if [ -d "/usr/local/go/bin" ]; then
    export PATH="${PATH}:/usr/local/go/bin"
fi
if [ -d "${HOME}/go/bin" ]; then
    export PATH="${PATH}:${HOME}/go/bin"
fi

if [ -d "${HOME}/.bun" ]; then
    export BUN_INSTALL="${HOME}/.bun"
    export PATH="${BUN_INSTALL}/bin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${PATH}:${HOME}/.local/bin"
fi
# }}}

export TERM=xterm-256color

if command -v nvim >/dev/null; then
    export VISUAL=nvim
    export EDITOR=nvim
    export GIT_EDITOR=nvim
else
    export VISUAL=vim
    export EDITOR=vim
    export GIT_EDITOR=vim
fi

bind -x '"\C-t": bash $HOME/.config/scripts/tmux-sessionizer'
bind 'set completion-ignore-case on'

# if not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# load dircolors if available
if [ -f "${HOME}/.dir_colors" ]; then
    eval "$(dircolors ~/.dir_colors)"
fi

force_color_prompt=yes

if [ -e "${HOME}/.cargo/env" ]; then
    . "${HOME}/.cargo/env"
fi

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"

if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
fi

# vim:fileencoding=utf-8:foldmethod=marker
