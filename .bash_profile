if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [ -z "$TMUX" ] && [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    if uwsm check may-start; then
	exec uwsm start default
    fi
fi
