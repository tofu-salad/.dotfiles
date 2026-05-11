#!/usr/bin/env bash

if command -v ghostty >/dev/null 2>&1; then
	ghostty +new-window --title=ghostty.nmtui --command=nmtui
fi
