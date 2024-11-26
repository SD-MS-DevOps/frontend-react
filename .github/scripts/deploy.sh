#!/bin/bash
set -e

# Cambiar al directorio de salida
cd out

# Sincronizar favicons con fuerte caché
aws s3 sync ./common/favicons s3://$S3_ORIGIN_BUCKET/common/favicons \
  --exclude "site.webmanifest" \
  --metadata-directive 'REPLACE' \
  --cache-control max-age=31536000,public,must-revalidate \
  --delete

# Sincronizar assets con fuerte caché
aws s3 sync ./common/assets s3://$S3_ORIGIN_BUCKET/common/assets \
  --metadata-directive 'REPLACE' \
  --cache-control max-age=31536000,public,must-revalidate \
  --delete

# Sincronizar otros archivos generados por NX
aws s3 sync ./ s3://$S3_ORIGIN_BUCKET \
  --exclude "common/favicons/*" \
  --exclude "common/assets/*" \
  --metadata-directive 'REPLACE' \
  --cache-control no-cache,no-store,must-revalidate \
  --delete