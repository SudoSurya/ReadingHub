#!/bin/bash
# Generate PWA icons using ImageMagick
# If a user-provided `image.png` exists, derive icons from it.
# Otherwise fall back to the built-in procedural generator.

set -e

SRC_IMG="image.png"
OUT_192="icon-192.png"
OUT_512="icon-512.png"

if [ -f "$SRC_IMG" ]; then
  echo "🔧 Found ${SRC_IMG} — generating icons from it..."
  # Ensure ImageMagick converts to square icons and preserves aspect ratio.
  # Use ^ to fill and -gravity center -extent to crop if needed.
  convert "$SRC_IMG" -resize 192x192^ -gravity center -extent 192x192 -background none "$OUT_192"
  convert "$SRC_IMG" -resize 512x512^ -gravity center -extent 512x512 -background none "$OUT_512"
  echo "✅ Generated ${OUT_192} and ${OUT_512} from ${SRC_IMG}"
else
  echo "ℹ️ ${SRC_IMG} not found — using procedural icon generator"

  # Create 192x192 icon - simplified design
  convert -size 192x192 xc:'#1f6feb' \
    -fill '#0d1117' -draw 'roundrectangle 20,20 172,172 15,15' \
    -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 2 \
    -draw 'line 60,60 150,60' \
    -draw 'line 60,90 150,90' \
    -draw 'line 60,120 150,120' \
    -draw 'line 60,150 150,150' \
    "$OUT_192"

  # Create 512x512 icon - simplified design
  convert -size 512x512 xc:'#1f6feb' \
    -fill '#0d1117' -draw 'roundrectangle 50,50 462,462 40,40' \
    -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 4 \
    -draw 'line 150,140 400,140' \
    -draw 'line 150,220 400,220' \
    -draw 'line 150,300 400,300' \
    -draw 'line 150,380 400,380' \
    "$OUT_512"

  echo "✅ Procedural icons generated: ${OUT_192}, ${OUT_512}"
fi

echo "Done. Update your manifest (manifest.json) if you want to point to different icon filenames."
