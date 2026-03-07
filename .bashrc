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
alias ll='LC_COLLATE=C ls -ialF --color=auto --group-directories-first'

if command -v dircolors >/dev/null; then
    alias grep='grep --color=auto'
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

# env {{{
if [ -f "${HOME}/.dir_colors" ]; then
    eval "$(dircolors ~/.dir_colors)"
elif command -v dircolors >/dev/null; then
    eval "$(dircolors -b)"
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

# prompt {{{
if command -v starship >/dev/null; then
    eval "$(starship init bash)"
fi
# }}}
# vim: set ft=sh foldmethod=marker foldlevel=0:
