#!/usr/bin/env bash

CHROMECAST_IP=$(avahi-browse -rt _googlecast._tcp | awk '/= .*_googlecast/ {found=1} found && /address =/ {gsub(/[ \[\]]/, "", $3); print $3; exit}')

OUTPUT=rtmp://127.0.0.1/feed/live
# wf-recorder --audio="$(pactl get-default-sink).monitor" --file=$OUTPUT &
cvlc "$OUTPUT" --sout "#chromecast{ip=$CHROMECAST_IP}"
