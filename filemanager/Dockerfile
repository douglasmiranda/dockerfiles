# Multiarch image for hacdias/filemanager
# How to execute:
# - docker-compose.yml
# - https://henriquedias.com/filemanager/installation/#docker
FROM golang:alpine as BUILDER

RUN apk add --no-cache git gcc musl-dev

RUN go get github.com/hacdias/filemanager
WORKDIR /go/src/github.com/hacdias/filemanager
RUN go get ./...

WORKDIR /go/src/github.com/hacdias/filemanager/cmd/filemanager
RUN CGO_ENABLED=0 go build -a

RUN mkdir -p /app/database/ \
    && mkdir /app/data/ \
    && mv filemanager /app/filemanager


FROM alpine:3.6

RUN addgroup -S storage && adduser -S -G storage storage

COPY --from=BUILDER /app/ /app/
WORKDIR /app
COPY config.json config.json
RUN chown -R storage /app/

USER storage
ENTRYPOINT ["./filemanager"]
CMD ["--config", "config.json"]
