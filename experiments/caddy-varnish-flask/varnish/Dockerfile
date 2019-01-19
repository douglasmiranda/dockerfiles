FROM alpine:3.8

RUN apk add --no-cache varnish

EXPOSE 80

# VOLUME ["/var/lib/varnish", "/etc/varnish"]

COPY ./default.vcl /etc/varnish/default.vcl
