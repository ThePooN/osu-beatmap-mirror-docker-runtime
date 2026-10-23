FROM php:8.4.27-fpm-alpine3.24

RUN apk add --no-cache zip

RUN mkdir -p /usr/local/log && touch /usr/local/log/www.log.slow && chown 101:101 /usr/local/log/www.log.slow

RUN ln -sf /proc/1/fd/1 /usr/local/log/www.log.slow

COPY zz-www.conf /usr/local/etc/php-fpm.d/zz-www.conf
