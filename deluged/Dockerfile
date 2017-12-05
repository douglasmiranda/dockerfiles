# Deluge Torrent
# deluged: 1.3.13
# libtorrent: 1.1.1.0
# see entrypoint/core.conf
# ----------------------------------------------------------------------
# Get the password for connecting from your deluge ui
# docker exec -it <CONTAINER_ID> bash
# $ cat /config/auth
# USER:PASS:10
# Or on your host go to the /config volume location and see the 'auth' file.
# Works fine on AARCH64 too xD
FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends deluged \
    && rm -rf /var/lib/apt/lists/*

COPY ./core.conf /config/core.conf
RUN chown -R nobody /config

# deluge daemon
EXPOSE 58846
# incoming torrent data (tcp and udp)
EXPOSE 58946 58946/udp

VOLUME /config /downloads
USER nobody
CMD ["deluged", "-c", "/config", "-d", "--loglevel=info", "-l", "/dev/stdout"]
