#!/usr/bin/env bash
set -euo pipefail

LAYOUT="$(mmsg -k | grep -oP 'kb_layout \K\S+')"
printf '{"text": "%s", "class": "%s"}\n' "$LAYOUT" "${LAYOUT,,}"

mmsg -w -k | while IFS= read -r line; do
    LAYOUT="$(echo "$line" | grep -oP 'kb_layout \K\S+')"
    [[ -n "$LAYOUT" ]] && printf '{"text": "%s", "class": "%s"}\n' "$LAYOUT" "${LAYOUT,,}"
done
