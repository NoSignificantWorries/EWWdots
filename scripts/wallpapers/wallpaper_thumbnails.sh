#!/usr/bin/sh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_LINK="$HOME/.wallpaper"
THUMB_DIR="/tmp/eww-wallpaper-thumbnails"

mkdir -p "$THUMB_DIR"

for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
    if [ -f "$img" ]; then
        thumb_name="$THUMB_DIR/$(basename "$img")"
        if [ ! -f "$thumb_name" ]; then
            magick convert "$img" -thumbnail 200x200^ -gravity center -extent 200x200 "$thumb_name" 2>/dev/null
        fi
    fi
done

echo "(box :class \"wallpaper-grid\""
for thumb in "$THUMB_DIR"/*.{jpg,jpeg,png}; do
    if [ -f "$thumb" ]; then
        original_img="$WALLPAPER_DIR/$(basename "$thumb")"
        echo "    (button :onclick \"echo $original_img > /tmp/wallpaper\"
                  (image :path \"$thumb\" :class \"wallpaper-thumb\"))"
    fi
done
echo ")"
