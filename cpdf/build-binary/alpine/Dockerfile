# See: https://github.com/ocaml/opam-dockerfiles/blob/master/Dockerfile
FROM ocaml/opam:alpine-3.6_ocaml-4.04.2

USER root

RUN apk add --no-cache m4
COPY ./build.sh build.sh
RUN chown opam build.sh && chmod +x build.sh

RUN mkdir -p /done && chown opam /done

USER opam
CMD ["./build.sh"]
