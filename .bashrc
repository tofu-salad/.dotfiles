# opts {{{
# if not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

bind 'set completion-ignore-case on'
shopt -s histappend
shopt -s globstar
shopt -s checkwinsize

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND='history -a; history -n'
# }}}

# aliases {{{
alias ll='LC_COLLATE=C ls -ialF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

if command -v dircolors >/dev/null; then
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if command -v nvim >/dev/null; then
    alias vim='nvim'
    export VISUAL=nvim
    export EDITOR=nvim
    export GIT_EDITOR=nvim
else
    export VISUAL=vim
    export EDITOR=vim
    export GIT_EDITOR=vim
fi
# }}}

# paths {{{
if [ -d "${HOME}/go/bin" ]; then
    export PATH="${PATH}:${HOME}/go/bin"
fi

if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi
# }}}

# prompt {{{
parse_git_branch() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local BRANCH status bits=""
    BRANCH=$(git branch --show-current)
    status=$(git status --porcelain=2 --branch 2>/dev/null)
    [[ $status == *"branch.ab +[1-9]"* ]] && bits="*${bits}"
    [[ $status == *$'\n? '* ]] && bits="?${bits}"
    [[ $status =~ \ [MAD]. ]] && bits="+${bits}"
    [[ $status =~ \ .[MAD] ]] && bits="*${bits}"
    [[ -n $BRANCH ]] && printf '‹%s%s›' "$BRANCH" "$bits"
}

in_nix_shell() {
    if [ -n "$IN_NIX_SHELL" ]; then
        printf '<nix-shell> '
    fi
}

is_fhs() {
    if [ "$FHS" = "1" ]; then
        printf '(fhs) '
    fi
}

PS1='\[\e[34m\]$(in_nix_shell)\[\e[m\]\[\e[31m\]$(is_fhs)\[\e[m\]\[\e[32m\]\w \[\e[m\]\[\e[33m\]$(parse_git_branch)\[\e[m\] \$ '
# }}}

# env {{{
if [ -f "${HOME}/.dir_colors" ]; then
    eval "$(dircolors ~/.dir_colors)"
fi

if [ -e "${HOME}/.cargo/env" ]; then
    . "${HOME}/.cargo/env"
fi

if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
fi
# }}}

# keybinds {{{
case "$TERM" in
    wezterm*|ghostty*) ;;
    *) bind -x '"\C-t": bash "$HOME/.config/scripts/tmux-sessionizer"' ;;
esac
# }}}
# vim: set ft=sh foldmethod=marker foldlevel=0:
