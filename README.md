# osu! beatmap mirror runtime

Docker-based runtime for osu! beatmap mirrors

## Set up

- Install Docker and Docker Compose
- Clone this repository
- Drop required PHP files in `www` and configure them as expected
- If necessary, mount the dedicated cache volume to `www/beatmapCache`
- Set owner on entrypoint file and cache folder: `chown 101:101 ./www/d.php ./www/beatmapCache`
- Drop SSL `ssl.crt` and `ssl.key` in `./etc/nginx/includes`; uncomment and adjust settings in `./etc/nginx/includes/ssl.conf` as necessary
- Adjust cache-cleaning cron job settings in `docker-compose.yml` as needed
- Spin it up: `docker-compose up -d`
