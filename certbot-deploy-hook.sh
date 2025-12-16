#!/bin/sh

set -euxo pipefail

cd "${0%/*}"

cp "$RENEWED_LINEAGE/fullchain.pem" ./nginx/includes/ssl.crt
cp "$RENEWED_LINEAGE/privkey.pem" ./nginx/includes/ssl.key

docker-compose exec -T nginx nginx -t
docker-compose exec -T nginx nginx -s reload
