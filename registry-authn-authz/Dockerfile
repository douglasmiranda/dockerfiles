# Custom build for https://github.com/cesanta/docker_auth
# I'm just using multistage build to create the Docker image based on
# branch/commit hash.
# For the final base image I'm using alpine, and running as non privileged user.
# This image use htpasswd to manage users.

# They have their own docker image on dockerhub: cesanta/docker_auth
# Their build instructions: https://github.com/cesanta/docker_auth/tree/master/auth_server#building-local-image
FROM golang:1.10-alpine as builder

RUN apk --no-cache add git python3
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN python -m pip install GitPython

# can be a branch, tag, commit...
# docker build --build-arg BRANCH=e10780b62fb04d6dc0f9012a39a5afe46755a308 -t douglasmiranda/rauthz .
ARG BRANCH=master
WORKDIR /go/src/github.com/cesanta/docker_auth
RUN git clone https://github.com/cesanta/docker_auth ./
RUN git checkout ${BRANCH}

WORKDIR /go/src/github.com/cesanta/docker_auth/auth_server

# Dependencies
RUN go get -v -u github.com/kardianos/govendor
RUN govendor sync
RUN go install -v github.com/cesanta/docker_auth/auth_server/vendor/github.com/jteeuwen/go-bindata/go-bindata

RUN go generate \
    github.com/cesanta/docker_auth/auth_server \
    github.com/cesanta/docker_auth/auth_server/authn/... \
    github.com/cesanta/docker_auth/auth_server/authz/... \
    github.com/cesanta/docker_auth/auth_server/mgo_session/... \
    github.com/cesanta/docker_auth/auth_server/server/...

# Build!
ENV CGO_ENABLED=0
RUN go build -v --ldflags=--s


# Final Image
FROM alpine:3.7

# apache2-utils: htpasswd
RUN apk add --no-cache ca-certificates apache2-utils \
    && update-ca-certificates

COPY --chown=nobody --from=builder /go/src/github.com/cesanta/docker_auth/auth_server/auth_server /usr/local/bin/
COPY --chown=nobody auth_server/rauthz /usr/local/bin/
COPY --chown=nobody auth_server/auth_config.yml /etc/docker_auth/
RUN chmod +x /usr/local/bin/rauthz \
    && mkdir /auth_server \
    && chown -R nobody /auth_server /etc/docker_auth/

USER nobody
WORKDIR /auth_server
EXPOSE 5001
CMD ["auth_server", "/etc/docker_auth/auth_config.yml"]
