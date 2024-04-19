#!/usr/bin/env bash

# Get the valiue of the XDG_CURRENT_DESKTOP variable
current_desktop="$XDG_CURRENT_DESKTOP"

if [[ "$current_desktop" = "Hyprland" ]]; then
    echo "Using Waybar config for Hyprland"
    waybar_config="$HOME/.config/waybar/hyprland/hyprland.conf"
else
    echo "Using Waybar config for Sway"
    waybar_config="$HOME/.config/waybar/sway/sway.conf"
fi

waybar -c "$waybar_config"
