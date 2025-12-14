#!/bin/sh

MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c 'MUTED')
VALUE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' | tr -d '%')

get_icon() {
  if [ "$MUTED" -eq 1 ]; then
    icon=" "
  elif [ "$VALUE" -le 33 ]; then
    icon=" "
  elif [ "$VALUE" -le 66 ]; then
    icon=" "
  else
    icon=" "
  fi

  echo "$icon"
}

case "$1" in
  value)
    echo "$VALUE"
    ;;
  icon)
    echo $(get_icon)
    ;;
  color)
    if [ "$MUTED" -eq 1 ]; then
      color="#6c7086"
    elif [ "$VALUE" -le 10 ]; then
      color="#ed8796"
    elif [ "$VALUE" -le 20 ]; then
      color="#ea909e"
    elif [ "$VALUE" -le 30 ]; then
      color="#e799a6"
    elif [ "$VALUE" -le 40 ]; then
      color="#e3a3af"
    elif [ "$VALUE" -le 50 ]; then
      color="#e0acb8"
    elif [ "$VALUE" -le 60 ]; then
      color="#d0b7a2"
    elif [ "$VALUE" -le 70 ]; then
      color="#c0c28c"
    elif [ "$VALUE" -le 80 ]; then
      color="#b1cd76"
    elif [ "$VALUE" -le 90 ]; then
      color="#a1d860"
    else
      color="#91e34a"
    fi
    echo $color
    ;;
  *)
    echo "$MUTED"
    ;;
esac

