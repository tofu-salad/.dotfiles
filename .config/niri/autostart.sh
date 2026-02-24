#!/usr/bin/env bash

if command -v wl-clip-persist &>/dev/null; then
    wl-clip-persist --clipboard regular --reconnect-tries 0 &
fi

if command -v xclip &>/dev/null; then
    while true; do
        xclip -selection clipboard -o | wl-copy --type text/plain
        sleep 0.5
    done &
fi
