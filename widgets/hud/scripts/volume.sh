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
      color="#8b2252"           # Темный пурпурно-красный
    elif [ "$VALUE" -le 20 ]; then
      color="#a02a62"           # Пурпурно-красный
    elif [ "$VALUE" -le 30 ]; then
      color="#b53272"           # Яркий пурпурный
    elif [ "$VALUE" -le 40 ]; then
      color="#ca3a82"           # Пурпурно-розовый
    elif [ "$VALUE" -le 50 ]; then
      color="#df4292"           # Розово-пурпурный
    elif [ "$VALUE" -le 60 ]; then
      color="#ed5a96"           # Кораллово-розовый
    elif [ "$VALUE" -le 70 ]; then
      color="#f2729a"           # Яркий коралловый
    elif [ "$VALUE" -le 80 ]; then
      color="#f78a9e"           # Светло-коралловый
    elif [ "$VALUE" -le 90 ]; then
      color="#fca2a2"           # Персиково-коралловый
    else
      color="#ffbaa6"           # Светлый персиковый (макс. громкость)
    fi
    echo $color
    ;;
  *)
    echo "$MUTED"
    ;;
esac

