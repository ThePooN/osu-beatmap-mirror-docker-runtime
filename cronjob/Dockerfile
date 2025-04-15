FROM alpine:3.21.3

RUN apk add --no-cache bash bc curl ca-certificates supercronic

COPY crontab beatmapcache_check.sh /

CMD ["/usr/bin/supercronic", "/crontab"]
