#!/bin/sh

status=$(acpi -b | grep -oP "(Charging|Discharging|Full)")
percent=$(acpi -b | grep -oP '\d+(?=%)')
time_str=$(acpi -b | grep -oP '\d{2}:\d{2}:\d{2}')
H=$(echo "$time_str" | cut -d: -f1)
M=$(echo "$time_str" | cut -d: -f2)

# echo "${H}h ${M}m"

get_icon() {
  case $status in
    Charging)
      if [ "$percent" -le 10 ]; then
        icon="󰢟"
      elif [ "$percent" -le 20 ]; then
        icon="󰢜"
      elif [ "$percent" -le 30 ]; then
        icon="󰂆"
      elif [ "$percent" -le 40 ]; then
        icon="󰂇"
      elif [ "$percent" -le 50 ]; then
        icon="󰂈"
      elif [ "$percent" -le 60 ]; then
        icon="󰢝"
      elif [ "$percent" -le 70 ]; then
        icon="󰂉"
      elif [ "$percent" -le 80 ]; then
        icon="󰢞"
      elif [ "$percent" -le 90 ]; then
        icon="󰂋"
      else
        icon="󰂅"
      fi
      ;;
    *)
      if [ "$percent" -le 10 ]; then
        icon="󱃍"
      elif [ "$percent" -le 20 ]; then
        icon="󰁺"
      elif [ "$percent" -le 30 ]; then
        icon="󰁻"
      elif [ "$percent" -le 40 ]; then
        icon="󰁼"
      elif [ "$percent" -le 50 ]; then
        icon="󰁽"
      elif [ "$percent" -le 60 ]; then
        icon="󰁾"
      elif [ "$percent" -le 70 ]; then
        icon="󰁿"
      elif [ "$percent" -le 80 ]; then
        icon="󰂀"
      elif [ "$percent" -le 90 ]; then
        icon="󰂁"
      else
        icon="󰁹"
      fi
      ;;
  esac

  echo "$icon"
}


case "$1" in
  time)
    case $status in
      Charging)
        echo "${H}h ${M}m to full"
        ;;
      *)
        echo "${H}h ${M}m to empty"
        ;;
    esac
    ;;
  color)
    if [ "$percent" -le 10 ]; then
      color="#ed8796"  # Catppuccin red
    elif [ "$percent" -le 20 ]; then
      color="#ea909e"  # Смесь red и peach
    elif [ "$percent" -le 30 ]; then
      color="#e799a6"  # Более светлый красный
    elif [ "$percent" -le 40 ]; then
      color="#e3a3af"  # Переход к peach
    elif [ "$percent" -le 50 ]; then
      color="#e0acb8"  # Почти peach
    elif [ "$percent" -le 60 ]; then
      color="#d0b7a2"  # Смесь peach и yellow
    elif [ "$percent" -le 70 ]; then
      color="#c0c28c"  # Переход к yellow
    elif [ "$percent" -le 80 ]; then
      color="#b1cd76"  # Смесь yellow и green
    elif [ "$percent" -le 90 ]; then
      color="#a1d860"  # Ближе к green
    else
      color="#91e34a"  # Catppuccin green (адаптированный)
    fi
    echo $color
    ;;
  *)
    echo "$(get_icon) ${percent}%"
    ;;
esac

