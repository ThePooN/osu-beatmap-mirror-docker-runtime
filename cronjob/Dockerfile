FROM debian:11-slim

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends bash bc ca-certificates curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e

RUN curl -fsSLO "$SUPERCRONIC_URL" && \
    echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - && \
    chmod +x "$SUPERCRONIC" && \
    mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" && \
    ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

COPY crontab beatmapcache_check.sh /

CMD ["/usr/local/bin/supercronic", "/crontab"]
