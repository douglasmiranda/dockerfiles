# Netatalk 3.1.10 AFP File Server
# Tested on aarch64
# Users:
# Enter on the running container and create a user:
# adduser -D -G users -H -g 'APF User' douglas
# passwd douglas
# OR, since this image has a user called 'storage', you could use it
# just set a password for 'storage'
# passwd storage
# PS: afppasswd it's not working
# ----------------------------------------------------------------------
# Permissions:
# Enter on the running container and change the directory's owner:
# chown -R storage:users /media
# Add read-write access to the users group
# chmod -R g+rwx /media
# ----------------------------------------------------------------------
# Links:
# http://netatalk.sourceforge.net/3.1/htmldocs/installation.html
# http://netatalk.sourceforge.net/3.1/htmldocs/afp.conf.5.html

FROM alpine:3.6
LABEL version="3.1.10-alpine3.6"

ENV NETATALK 3.1.10

RUN apk add --no-cache --virtual .build-deps acl-dev build-base \
        cracklib-dev db-dev krb5-dev libevent-dev tdb-dev libressl-dev \
        openldap-dev libgcrypt-dev linux-pam-dev avahi-dev \
    && wget -O- http://ufpr.dl.sourceforge.net/project/netatalk/netatalk/$NETATALK/netatalk-$NETATALK.tar.gz | tar -zx \
    && cd netatalk-$NETATALK \
    && ./configure --enable-krbV-uam --with-cracklib --enable-quota --with-tdb --with-pam-confdir=/etc/pam.d \
    && make \
    && make install \
    && cd .. \
    && rm -rf netatalk-$NETATALK \
    && apk del .build-deps \
    && apk add --no-cache acl cracklib db krb5 libevent tdb openssl \
           openldap libgcrypt linux-pam avahi

RUN sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

RUN adduser -D -H -G users -g 'AFP user' storage

COPY afp.conf /usr/local/etc/afp.conf
COPY afpd.service /etc/avahi/services/afpd.service

EXPOSE 548
EXPOSE 5353/udp

VOLUME /media

COPY start /start
RUN chmod +x /start
CMD ["/start"]
