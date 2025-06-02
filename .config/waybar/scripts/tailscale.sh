#!/usr/bin/env bash

if [[ "$1" == "--toggle" ]]; then
  if ! command -v tailscale &> /dev/null; then
    exit 1
  fi

  status=$(tailscale status --json 2>/dev/null)
  if echo "$status" | jq -e '.Self.Online == true' >/dev/null 2>&1; then
    pkexec tailscale down
  else
    pkexec tailscale up
    sleep 2
  fi

  pid=$(pgrep -n .waybar-wrapped)
  kill -RTMIN+9 $pid
  exit
fi

if ! command -v tailscale &> /dev/null; then
  echo '{"text": "Tailscale", "tooltip": "tailscale not installed", "class": "unavailable"}'
  exit 0
fi

status=$(tailscale status --json 2>/dev/null)
online=$(echo "$status" | jq -r '.Self.Online')

if [[ "$online" == "true" ]]; then
  class="connected"
  icon="󰖂 "
else
  class="disconnected"
  icon="󰖂 "
fi

tooltip=$(echo "$status" | jq -r '
  (.Peer + {(.Self.ID): .Self} | to_entries) as $entries
  | ($entries | map(.value.TailscaleIPs[0] | length) | max) as $max_ip_len
  | ($entries | map(.value.HostName | length) | max) as $max_host_len
  | ($entries | map(.value.OS | length) | max) as $max_os_len
  | $entries
  | map(
      (.value.TailscaleIPs[0] + (" " * ($max_ip_len - (.value.TailscaleIPs[0] | length) + 2))) +
      (.value.HostName + (" " * ($max_host_len - (.value.HostName | length) + 2))) +
      (.value.OS + (" " * ($max_os_len - (.value.OS | length) + 2))) +
      (if .value.Online then "online" else "-" end)
    )
  | join("\n")
')

jq -nc --arg text "$icon" --arg tooltip "<tt><small>$tooltip</small></tt>" --arg class "$class" \
  '{text: $text, tooltip: $tooltip, class: $class}'
