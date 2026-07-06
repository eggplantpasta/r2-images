#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

INPUT_DIR="$ROOT_DIR/image-originals"
OUTPUT_DIR="$ROOT_DIR/images"

MAX_SIZE=1600
QUALITY=82

find "$INPUT_DIR" -type f \
    \( -iname "*.jpg" -o \
       -iname "*.jpeg" -o \
       -iname "*.png" -o \
       -iname "*.heic" -o \
       -iname "*.heif" \) \
| while read -r infile
do
    rel="${infile#$INPUT_DIR/}"
    outfile="$OUTPUT_DIR/${rel%.*}.webp"

    mkdir -p "$(dirname "$outfile")"

    if [[ -f "$outfile" && "$outfile" -nt "$infile" ]]; then
        echo "Skipping $rel"
        continue
    fi

    echo "Processing $rel"

    magick "$infile" \
        -auto-orient \
        -resize "${MAX_SIZE}x${MAX_SIZE}>" \
        -strip \
        -quality "$QUALITY" \
        "$outfile"
done