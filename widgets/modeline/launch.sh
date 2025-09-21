#!/usr/bin/sh

config="$HOME/.config/eww/widgets/modeline"

eww daemon 2>/dev/null

eww --force-wayland open -c "$config" modeline 2>/dev/null
