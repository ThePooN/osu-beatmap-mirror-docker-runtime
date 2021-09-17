FROM php:7.4.23-fpm-bullseye

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends zip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY zz-www.conf /usr/local/etc/php-fpm.d/zz-www.conf
