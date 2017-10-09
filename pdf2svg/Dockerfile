FROM alpine:3.6 as builder
LABEL version="0.2.3-alpine3.6"

RUN apk add --update-cache make gcc libc-dev cairo-dev poppler-dev git

ENV PDF2SVG_VERSION v0.2.3

RUN git clone https://github.com/dawbarton/pdf2svg pdf2svg

WORKDIR /pdf2svg

RUN git checkout $PDF2SVG_VERSION && ./configure && make

# final image
FROM alpine:3.6

RUN apk add --update-cache --virtual .fetch-deps ca-certificates openssl \
    && update-ca-certificates \
    && apk add --no-cache poppler-glib poppler-utils msttcorefonts-installer \
    && update-ms-fonts \
    && fc-cache -f

RUN apk del .fetch-deps

COPY --from=builder /pdf2svg/pdf2svg /usr/local/bin/pdf2svg
CMD ["pdf2svg"]