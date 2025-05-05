FROM alpine:latest

RUN apk add --no-cache bash bc curl ca-certificates supercronic

COPY crontab beatmapcache_check.sh /

CMD ["/usr/bin/supercronic", "/crontab"]
