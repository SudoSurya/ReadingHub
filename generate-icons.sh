#!/bin/bash
# Generate PWA icons using ImageMagick

# Create 192x192 icon - simplified design
convert -size 192x192 xc:'#1f6feb' \
  -fill '#0d1117' -draw 'roundrectangle 20,20 172,172 15,15' \
  -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 2 \
  -draw 'line 60,60 150,60' \
  -draw 'line 60,90 150,90' \
  -draw 'line 60,120 150,120' \
  -draw 'line 60,150 150,150' \
  icon-192.png

# Create 512x512 icon - simplified design
convert -size 512x512 xc:'#1f6feb' \
  -fill '#0d1117' -draw 'roundrectangle 50,50 462,462 40,40' \
  -fill '#c9d1d9' -stroke '#c9d1d9' -strokewidth 4 \
  -draw 'line 150,140 400,140' \
  -draw 'line 150,220 400,220' \
  -draw 'line 150,300 400,300' \
  -draw 'line 150,380 400,380' \
  icon-512.png

echo "✅ Icons generated successfully!"
