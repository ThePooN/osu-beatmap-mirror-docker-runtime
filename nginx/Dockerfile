FROM nginx:1.26.3-alpine

RUN apk add --no-cache bash logrotate cronie supervisor

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
