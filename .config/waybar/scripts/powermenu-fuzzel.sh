#!/usr/bin/env bash

options="⏻ Shutdown
↻ Reboot
⍇ Logout"

choice=$(printf "%s\n" "$options" | \
fuzzel --dmenu \
  --font "Adwaita Mono:size=16" \
  --hide-prompt \
  --anchor top-right \
  --minimal-lines \
  --width 15 \
  --keyboard-focus=on-demand \
  --use-bold \
  --border-radius 0)

case "$choice" in
  "⏻ Shutdown") systemctl poweroff ;;
  "↻ Reboot") systemctl reboot ;;
  "⍇ Logout") loginctl terminate-user "$USER" ;;
esac
