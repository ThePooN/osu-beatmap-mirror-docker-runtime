# osu! beatmap mirror runtime

Docker-based runtime for osu! beatmap mirrors

## Set up

- Install Docker and Docker Compose
- Clone this repository
- Drop required PHP files in `www` and configure them as expected
- If necessary, mount the dedicated cache volume to `www/beatmapCache`
- Set owner on entrypoint file and cache folder: `chown 101:101 ./www/d.php ./www/beatmapCache ./logs`
- Drop SSL `ssl.crt` and `ssl.key` in `./etc/nginx/includes`; uncomment and adjust settings in `./etc/nginx/includes/ssl.conf` as necessary
- Adjust cache-cleaning cron job settings in `docker-compose.yml` as needed
- Spin it up: `docker-compose up -d`

## Certbot set-up

```
certbot \
  certonly \
  --agree-tos \
  --email <email> \
  --no-eff-email \
  -d <domain> \
  --webroot \
  --webroot-path /path/to/osu-beatmap-mirror-docker-runtime/www/ \
  --fullchain-path /path/to/osu-beatmap-mirror-docker-runtime/nginx/includes/ssl.crt \
  --key-path /path/to/osu-beatmap-mirror-docker-runtime/nginx/includes/ssl.key \
  --deploy-hook /path/to/osu-beatmap-mirror-docker-runtime/certbot-deploy-hook.sh
```
