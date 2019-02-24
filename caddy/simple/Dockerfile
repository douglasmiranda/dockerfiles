# Defining version of Caddy as an ARG, so you can try other versions even without
# changing the Dockerfile.
# I'm defining before the FROM instruction so I can use in multiple stages
# https://docs.docker.com/compose/compose-file/#args
# https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg
# https://docs.docker.com/engine/reference/builder/#arg
# Build: docker build --target=production -t douglasmiranda/caddy .
# Run: docker run --rm -p "80:80" douglasmiranda/caddy
ARG CADDY_VERSION=0.11.4
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
FROM alpine:3.8 as production

ARG CADDY_VERSION
LABEL \
  org.opencontainers.image.title="Caddy Web Server" \
  org.opencontainers.image.authors="Douglas Miranda <douglascoding@gmail.com>" \
  org.opencontainers.image.version="${CADDY_VERSION}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.url="https://hub.docker.com/r/douglasmiranda/caddy/" \
  org.opencontainers.image.documentation="https://github.com/douglasmiranda/dockerfiles/tree/master/caddy/simple" \
  org.opencontainers.image.source="https://github.com/douglasmiranda/dockerfiles/blob/master/caddy/simple/Dockerfile"

COPY --from=builder /go/src/github.com/mholt/caddy/caddy/caddy /usr/bin/caddy
ADD https://raw.githubusercontent.com/douglasmiranda/lab/master/docker-secrets-as-env/docker-secrets-to-env-var.sh /home/caddy/docker-secrets-to-env-var.sh
ADD https://raw.githubusercontent.com/douglasmiranda/lab/master/docker-secrets-as-env/entrypoint.sh /home/caddy/entrypoint.sh
COPY Caddyfile /etc/caddy/Caddyfile

# /var/www: will store our "hello world" file
# /home/caddy/.caddy: Caddy will use this dir, storing certificates and other stuff
RUN apk add --no-cache ca-certificates openssh-client libcap \
    && addgroup caddy && adduser -D -G caddy caddy \
    && mkdir -p /var/www /home/caddy/.caddy \
    && echo "Hello, Caddy is running. Serving this file: /var/www/index.html" > /var/www/index.html \
    && chown -R caddy:caddy /home/caddy /var/www \
    && chmod +x /home/caddy/entrypoint.sh \
    # allowing unprivileged user to listen to ports below 1024
    && setcap 'cap_net_bind_service=+ep' /usr/bin/caddy

USER caddy
VOLUME ["/home/caddy/.caddy", "/etc/caddy", "/var/www"]
EXPOSE 80 443 2015
WORKDIR /home/caddy
ENTRYPOINT ["/home/caddy/entrypoint.sh"]
CMD ["caddy", "--conf", "/etc/caddy/Caddyfile", "--log", "stdout", "--agree=true"]
