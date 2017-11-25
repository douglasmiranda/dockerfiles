# See: https://github.com/ocaml/opam-dockerfiles/blob/master/Dockerfile
FROM ocaml/opam:debian

USER root

COPY ./build.sh build.sh
RUN chown opam build.sh && chmod +x build.sh

RUN mkdir -p /done && chown opam /done

USER opam
CMD ["./build.sh"]
