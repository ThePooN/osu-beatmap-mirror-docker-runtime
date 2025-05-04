FROM nginx:1.26.3-alpine

RUN apk add --no-cache bash logrotate cronie supervisor

COPY nginx/logrotate/nginx /etc/logrotate.d/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
