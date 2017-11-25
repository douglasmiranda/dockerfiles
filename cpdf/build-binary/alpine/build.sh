#!/usr/bin/env bash
set -x
set -e

opam update && opam install camlpdf

git clone https://github.com/johnwhitington/cpdf-source \
    && cd cpdf-source/ \
    && git checkout $GIT_BRANCH_OR_TAG

make
ls
./cpdf -version

cp cpdf /$BUILD_RESULT_DIR_NAME/cpdf