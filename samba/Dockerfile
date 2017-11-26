# Samba version: 4.6.8
#
# Enter on the running container and create a user:
# adduser -D -G users -H -g 'Samba User' douglas
# smbpasswd -a douglas
# ----------------------------------------------------------------------
# REMEMBER to clean <storage>/.recycle sometimes (or disable in samba)
# Edit /etc/samba/smb.conf
# [home-storage]
#    path = /mount
#    browsable = yes
#    read only = no
#    writeable = yes
#    guest ok = no
#    veto files = /._*/.apdisk/.AppleDouble/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/
#    delete veto files = yes
# ----------------------------------------------------------------------
# About NMBD:
# If you enable nmbd, you will need to expose port 137 and 138
# EXPOSE 137/udp 138/udp 139 445
# Start NMBD, by editing ./start_samba, add:
# ionice -c 3 nmbd -D
# before
# ----------------------------------------------------------------------
# Some links about tunning Samba
# https://eggplant.pro/blog/faster-samba-smb-cifs-share-performance/
# https://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/speed.html
# https://calomel.org/samba_optimize.html

FROM alpine:3.6
LABEL version="4.6.8-alpine3.6"

# Install samba
# REMEMBER to delete the volume samba_config_data if you make changes on
# /etc/samba/smb.conf
# see: docker-compose.yml
RUN apk --no-cache --no-progress add bash samba shadow && \
    adduser -D -G users -H -g 'Samba User' smbuser && \
    file="/etc/samba/smb.conf" && \
    sed -i 's|^;* *\(log file = \).*|   \1/dev/stdout|' $file && \
    sed -i 's|^;* *\(load printers = \).*|   \1no|' $file && \
    sed -i 's|^;* *\(unix password sync = \).*|   \1no|' $file && \
    sed -i 's|^;* *\(preserve case = \).*|   \1yes|' $file && \
    sed -i 's|^;* *\(short preserve case = \).*|   \1yes|' $file && \
    sed -i 's|^;* *\(default case = \).*|   \1lower|' $file && \
    sed -i '/Share Definitions/,$d' $file && \
    echo '   pam password change = yes' >>$file && \
    echo '   map to guest = bad user' >>$file && \
    echo '   create mask = 0664' >>$file && \
    echo '   force create mode = 0664' >>$file && \
    echo '   directory mask = 0775' >>$file && \
    echo '   force directory mode = 0775' >>$file && \
    echo '   force user = smbuser' >>$file && \
    echo '   force group = users' >>$file && \
    echo '   follow symlinks = yes' >>$file && \
    echo '   load printers = no' >>$file && \
    echo '   printing = bsd' >>$file && \
    echo '   printcap name = /dev/null' >>$file && \
    echo '   disable spoolss = yes' >>$file && \
    echo '   strict allocate = yes' >>$file && \
    echo '   allocation roundup size = 4096' >>$file && \
    echo '   strict locking = no' >>$file && \
    echo '   vfs objects = recycle' >>$file && \
    echo '   recycle:keeptree = yes' >>$file && \
    echo '   recycle:versions = yes' >>$file && \
    echo '   min protocol = SMB2' >>$file && \
    echo '   read raw = yes' >>$file && \
    echo '   write raw = yes' >>$file && \
    echo '   sync always = no' >>$file && \
    echo '   server signing = no' >>$file && \
    echo '   use sendfile = yes' >>$file && \
    echo '   wins support = yes' >>$file && \
    echo '   min receivefile size = 16384' >>$file && \
    echo '   socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072' >>$file && \
    echo '' >>$file

# EXPOSE 137/udp 138/udp 139 445
EXPOSE 139 445

HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L '\\localhost\' -U 'guest%' -m SMB3

COPY ./start_samba /start_samba
RUN chmod +x /start_samba

CMD ["/start_samba"]
