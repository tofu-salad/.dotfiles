#!/usr/bin/env bash

if command -v uwsm-app &>/dev/null; then
    exec uwsm-app -- "$@"
else
    exec "$@"
fi
