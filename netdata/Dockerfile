# Just run, and on your host: localhost:19999
# Some flags and volume sharing needed: docker run -it --rm --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 19999:19999 douglasmiranda/netdata
# check docker-compose.yml file
FROM alpine:3.8

RUN apk add --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ netdata

CMD ["netdata", "-D", "-i", "0.0.0.0"]
