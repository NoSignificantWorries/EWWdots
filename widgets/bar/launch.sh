#!/usr/bin/sh

config="$HOME/.config/eww/widgets/bar"

eww daemon 2>/dev/null

eww --force-wayland open -c "$config" bar 2>/dev/null
