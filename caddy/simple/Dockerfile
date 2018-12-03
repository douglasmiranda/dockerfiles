# Defining version of Caddy as an ARG, so you can try other versions even without
# changing the Dockerfile.
# I'm defining before the FROM instruction so I can use in multiple stages
# https://docs.docker.com/compose/compose-file/#args
# https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg
# https://docs.docker.com/engine/reference/builder/#arg
ARG CADDY_VERSION=0.11.1
FROM golang:1.11-alpine as builder

RUN apk add --no-cache git gcc musl-dev

ARG CADDY_VERSION
# caddy
RUN git clone https://github.com/mholt/caddy -b "v$CADDY_VERSION" --single-branch --depth 1 /go/src/github.com/mholt/caddy

# builder dependency
RUN git clone https://github.com/caddyserver/builds /go/src/github.com/caddyserver/builds

# build
WORKDIR /go/src/github.com/mholt/caddy/caddy
RUN go run build.go -goos=$(go env GOOS) -goarch=$(go env GOARCH) -goarm=$(go env GOARM)


# Final stage
# Caddy running with unprivileged user
FROM alpine:3.8

ARG CADDY_VERSION
LABEL caddy_version="$CADDY_VERSION"

RUN apk add --no-cache ca-certificates openssh-client libcap \
    && addgroup caddy && adduser -D -G caddy caddy

COPY --from=builder /go/src/github.com/mholt/caddy/caddy/caddy /usr/bin/caddy

RUN mkdir -p /var/www \
    && chown -R caddy:caddy /var/www \
    && setcap 'cap_net_bind_service=+ep' /usr/bin/caddy \
    && echo "Hello, Caddy is running. Serving this file: /var/www/index.html" > /var/www/index.html \
    && mkdir -p /home/caddy/.caddy \
    && chown -R caddy:caddy /home/caddy/.caddy

COPY Caddyfile /etc/caddy/Caddyfile

VOLUME ["/home/caddy/.caddy", "/etc/caddy", "/var/www"]
EXPOSE 80 443 2015

USER caddy
WORKDIR /home/caddy
ENTRYPOINT ["caddy"]
CMD ["--conf", "/etc/caddy/Caddyfile", "--log", "stdout", "--agree=true"]
