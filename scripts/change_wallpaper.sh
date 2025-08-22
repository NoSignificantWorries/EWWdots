#!/bin/sh

WALLPAPER_LINK="$HOME/.wallpaper"

path=$(cat "/tmp/wallpaper")

echo "\"$path\""

ln -sf "$path" "${WALLPAPER_LINK}"
hyprctl hyprpaper reload ,"${WALLPAPER_LINK}"
