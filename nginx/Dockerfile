FROM nginx:stable-alpine

RUN apk add --no-cache bash logrotate cronie supervisor

COPY logrotate/nginx /etc/logrotate.d/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
