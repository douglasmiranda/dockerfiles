# Deluge Web Client for Deluge Server
# deluge-web: 1.3.13
# ----------------------------------------------------------------------
# Get the password for connecting deluge-web
# docker exec -it <CONTAINER_ID> bash
# docker exec -it delugeweb_deluged_1 bash
# $ cat /config/auth
# USER:PASS:10
# Or on your host go to the /config volume location and see the 'auth' file.
# ----------------------------------------------------------------------
# Deluge Web info:
# Go to your browser localhost:8112
# Default password: deluge
# Connect to your container running deluged, if you run using docker compose:
# Host: deluged
# Username: localclient
# Pass: <See above for how to get the password from your deluged container>
FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends deluge-web \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8112
USER nobody
CMD ["deluge-web", "-c", "/config", "--loglevel=info"]
