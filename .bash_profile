if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if uwsm check may-start; then
    exec uwsm start sway-uwsm.desktop
fi
