#!/usr/bin/env bash

if pgrep -l .Hyprland-wrapp >/dev/null; then
    hyprctl dispatch exit 0
    sleep 2
    if pgrep -l .Hyprland-wrapp >/dev/null; then
        echo "Hyprland is still running, killing..."
        killall -9 Hyprland
    else
        echo "Hyprland has exited successfully."
    fi
else
    echo "Hyprland is not running."
fi
