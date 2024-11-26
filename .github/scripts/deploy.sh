#!/bin/bash
set -e

cd dist/apps/catalog

# Sync bundles (JavaScript y CSS) con caché fuerte
aws s3 sync ./ s3://$S3_ORIGIN_BUCKET --exclude "index.html" --exclude "assets/*" --metadata-directive 'REPLACE' --cache-control max-age=31536000,public,immutable --delete

# Sync assets (imágenes, fuentes) con caché fuerte
aws s3 sync ./assets s3://$S3_ORIGIN_BUCKET/assets --metadata-directive 'REPLACE' --cache-control max-age=31536000,public,immutable --delete

# Sync HTML con no caché
aws s3 sync ./ s3://$S3_ORIGIN_BUCKET --include "index.html" --metadata-directive 'REPLACE' --cache-control no-cache,no-store,must-revalidate --delete

