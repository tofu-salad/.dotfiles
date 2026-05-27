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

if [ -d "${HOME}/go/bin" ]; then
    export PATH="${PATH}:${HOME}/go/bin"
fi

if [ -e "${HOME}/.cargo/env" ]; then
    . "${HOME}/.cargo/env"
fi

if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
fi
