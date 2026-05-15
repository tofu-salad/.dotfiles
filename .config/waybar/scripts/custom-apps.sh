#!/usr/bin/env bash

args=(-a top-left --border-radius=0)

if command -v uwsm >/dev/null 2>&1; then
	args+=(--launch-prefix='uwsm-app --')
fi

fuzzel "${args[@]}"
