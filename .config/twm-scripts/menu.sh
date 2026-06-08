#!/usr/bin/env bash

if command -v uwsm-app &>/dev/null; then
    exec fuzzel --launch-prefix="uwsm-app --"
else
    exec fuzzel
fi
