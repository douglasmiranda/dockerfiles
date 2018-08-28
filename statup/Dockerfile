# https://github.com/hunterlong/statup/releases
ARG RELEASE=v0.51
# docker run -p 80:8080 douglasmiranda/statup
FROM alpine

ARG RELEASE
ADD https://github.com/hunterlong/statup/releases/download/${RELEASE}/statup-linux-alpine.tar.gz /statup.tar.gz

RUN apk add --no-cache ca-certificates \
    && mkdir /statup \
    && chown -R nobody /statup \
    && tar -xzf /statup.tar.gz -C /usr/local/bin/ \
    && rm /statup.tar.gz

USER nobody
WORKDIR /statup
ENTRYPOINT ["statup"]
