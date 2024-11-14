#!/usr/bin/env bash

if [[ -f /etc/os-release ]] && grep -q "ID=nixos" /etc/os-release; then
	$POLKIT_AUTH_AGENT & 
else
	echo "not running NIXOS"
fi

