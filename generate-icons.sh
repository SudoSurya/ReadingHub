#!/bin/bash
set -euo pipefail
# generate-icons.sh
# Generates PWA icons (`icon-192.png`, `icon-512.png`) from `image.png` if available.
# Falls back to a simple generated design if `image.png` is missing.

SRC="image.png"

if command -v convert >/dev/null 2>&1; then
  echo "ImageMagick found."
else
  echo "Error: ImageMagick 'convert' not found. Install ImageMagick to generate icons." >&2
  exit 1
fi

if [ -f "$SRC" ]; then
  echo "Generating icons from $SRC..."
  # Normalize orientation, create square canvas, then resize for required sizes.
  # Use a large temporary size to preserve quality, then downscale.
  convert "$SRC" -auto-orient -resize 1024x1024^ -gravity center -background none -extent 1024x1024 \
    -strip -quality 90 PNG32:icon-512.png

  convert "$SRC" -auto-orient -resize 512x512^ -gravity center -background none -extent 512x512 \
    -strip -quality 90 PNG32:icon-192.png

  echo "✅ Icons generated from $SRC: icon-192.png, icon-512.png"
else
  echo "image.png not found — falling back to generated design"

  # Create 192x192 icon - simplified design
  convert -size 192x192 xc:'#1f6feb' \
    -fill '#0d1117' -draw 'roundrectangle 20,20 172,172 15,15' \
    -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 2 \
    -draw 'line 60,60 150,60' \
    -draw 'line 60,90 150,90' \
    -draw 'line 60,120 150,120' \
    -draw 'line 60,150 150,150' \
    PNG32:icon-192.png

  # Create 512x512 icon - simplified design
  convert -size 512x512 xc:'#1f6feb' \
    -fill '#0d1117' -draw 'roundrectangle 50,50 462,462 40,40' \
    -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 4 \
    -draw 'line 150,140 400,140' \
    -draw 'line 150,220 400,220' \
    -draw 'line 150,300 400,300' \
    -draw 'line 150,380 400,380' \
    PNG32:icon-512.png

  echo "✅ Generated fallback icons: icon-192.png, icon-512.png"
fi

exit 0
