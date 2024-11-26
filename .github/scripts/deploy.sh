#!/bin/bash
set -e

# Cambiar al directorio de salida
cd out

# Sincronizar favicon.ico con fuerte caché
if [ -f "./apps/catalog/src/favicon.ico" ]; then
  aws s3 cp ./apps/catalog/src/favicon.ico s3://$S3_ORIGIN_BUCKET/common/favicons/favicon.ico \
    --metadata-directive 'REPLACE' \
    --cache-control max-age=31536000,public,must-revalidate
else
  echo "El archivo favicon.ico no se encontró. Omitiendo sincronización."
fi

# Sincronizar assets con fuerte caché
if [ -d "./apps/catalog/src/assets" ]; then
  aws s3 sync ./apps/catalog/src/assets s3://$S3_ORIGIN_BUCKET/common/assets \
    --metadata-directive 'REPLACE' \
    --cache-control max-age=31536000,public,must-revalidate \
    --delete
else
  echo "La carpeta ./apps/catalog/src/assets no se encontró. Omitiendo sincronización."
fi

# Sincronizar otros archivos generados por NX
aws s3 sync ./ s3://$S3_ORIGIN_BUCKET \
  --exclude "apps/catalog/src/assets/*" \
  --exclude "apps/catalog/src/favicon.ico" \
  --metadata-directive 'REPLACE' \
  --cache-control no-cache,no-store,must-revalidate \
  --delete
