# docker run -p 80:8080 douglasmiranda/statup
FROM alpine

RUN apk add --no-cache ca-certificates \
    && mkdir /statup \
    && chown -R nobody /statup

# https://github.com/hunterlong/statup/releases
ARG RELEASE=v0.52
ADD https://github.com/hunterlong/statup/releases/download/${RELEASE}/statup-linux-alpine.tar.gz /statup.tar.gz

RUN tar -xzf /statup.tar.gz -C /usr/local/bin/ \
    && rm /statup.tar.gz

USER nobody
WORKDIR /statup
ENTRYPOINT ["statup"]
