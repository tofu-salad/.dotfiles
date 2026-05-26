#!/usr/bin/env bash

mkdir -p ~/Pictures/Screenshots
FILE=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
grim -g "$(slurp)" "$FILE" && notify-send "Selected Screenshot Saved." "$FILE" -i "$FILE"
