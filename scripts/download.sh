#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

IMAGE_DIR="$ROOT_DIR/images"

: "${R2_ACCOUNT_ID:?Missing R2_ACCOUNT_ID}"
: "${R2_ACCESS_KEY_ID:?Missing R2_ACCESS_KEY_ID}"
: "${R2_SECRET_ACCESS_KEY:?Missing R2_SECRET_ACCESS_KEY}"
: "${R2_BUCKET:?Missing R2_BUCKET}"

export AWS_ACCESS_KEY_ID="$R2_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$R2_SECRET_ACCESS_KEY"

ENDPOINT="https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com"

echo "Downloading missing images from bucket '$R2_BUCKET'..."

aws s3 sync \
    "s3://${R2_BUCKET}/" \
    "$IMAGE_DIR/" \
    --endpoint-url "$ENDPOINT" \
    --size-only \
    --exclude "._*" \
    --exclude "*/._*"

echo
echo "Done."