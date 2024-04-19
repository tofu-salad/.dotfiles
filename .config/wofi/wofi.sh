#/usr/bin/wofi
#!/usr/bin/env bash

flock --nonblock /tmp/.wofi.lock wofi --dmenu --show=drun -I
