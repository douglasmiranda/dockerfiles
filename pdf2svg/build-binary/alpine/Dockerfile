FROM alpine:3.6

RUN apk add --update-cache make gcc libc-dev cairo-dev poppler-dev git

# ENV PDF2SVG_VERSION 0.2.3

RUN mkdir /pdf2svg-build && mkdir /done
WORKDIR /pdf2svg-build

COPY build.sh build.sh
RUN chmod +x build.sh

CMD ["/pdf2svg-build/build.sh"]