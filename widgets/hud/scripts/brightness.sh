#!/bin/sh

BRIGHTNESS=$(brightnessctl -m | cut -d ',' -f4 | tr -d '%')

case "$1" in
  color)
    if [ "$BRIGHTNESS" -le 10 ]; then
      color="#ed8796"
    elif [ "$BRIGHTNESS" -le 20 ]; then
      color="#ea909e"
    elif [ "$BRIGHTNESS" -le 30 ]; then
      color="#e799a6"
    elif [ "$BRIGHTNESS" -le 40 ]; then
      color="#e3a3af"
    elif [ "$BRIGHTNESS" -le 50 ]; then
      color="#e0acb8"
    elif [ "$BRIGHTNESS" -le 60 ]; then
      color="#d0b7a2"
    elif [ "$BRIGHTNESS" -le 70 ]; then
      color="#c0c28c"
    elif [ "$BRIGHTNESS" -le 80 ]; then
      color="#b1cd76"
    elif [ "$BRIGHTNESS" -le 90 ]; then
      color="#a1d860"
    else
      color="#91e34a"
    fi
    echo $color
    ;;
  icon)
    if [ "$BRIGHTNESS" -le 25 ]; then
      icon="󰃜"
    elif [ "$BRIGHTNESS" -le 50 ]; then
      icon="󰃝"
    elif [ "$BRIGHTNESS" -le 75 ]; then
      icon="󰃞"
    else
      icon="󰃠"
    fi
    echo "$icon"
    ;;
  *)
    echo "$BRIGHTNESS"
    ;;
esac

