# Deluge Torrent
# deluged: 1.3.13
# libtorrent: 1.1.1.0
# see core.conf
# ----------------------------------------------------------------------
# Get the password for connecting from your deluge ui
# docker exec -it <CONTAINER_ID> bash
# $ cat /config/auth
# USER:PASS:10
# Or on your host go to the /config volume location and see the 'auth' file.
# Works fine on AARCH64 too xD
FROM buildpack-deps:stretch-curl as GOSU_FETCH

WORKDIR /tmp

ENV GOSU_VERSION 1.10
RUN set -x \
    && wget -O gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }').asc" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify gosu.asc gosu \
    && chmod +x gosu


FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends deluged \
    && rm -rf /var/lib/apt/lists/*

COPY --from=GOSU_FETCH /tmp/gosu /usr/local/bin/gosu

COPY ./core.conf /config/core.conf
COPY ./entrypoint /entrypoint
RUN chmod +x /entrypoint

# deluge daemon
EXPOSE 58846
# incoming torrent data (tcp and udp)
EXPOSE 58946 58946/udp

VOLUME /config /downloads
ENTRYPOINT ["/entrypoint"]
CMD ["deluged", "-c", "/config", "-d", "--loglevel=info"]
