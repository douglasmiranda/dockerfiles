# Boinc 7.6.33 on Debian Stretch aarch64 with armhf libs
# At the moment there aren't many projects able to run on aarch64, but
# some of them run on armhf.
# This is a setup for boinc running on aarch64 / arm64, but I'm enabling
# armhf as an alternative architecture.
# See: start_boinc_client
FROM debian:stretch
LABEL version="7.6.33-debian-stretch-aarch64"

RUN dpkg --add-architecture armhf \
    && apt-get update \
    && apt-get install -y --no-install-suggests boinc-client \
    binutils:armhf libstdc++6:armhf
    && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME /boinc-data
EXPOSE 31416

ADD start_boinc_client /start_boinc_client
RUN chmod +x start_boinc_client
CMD ["/start_boinc_client"]
