#!/bin/sh
set -x
set -e

git clone https://github.com/dawbarton/pdf2svg \
    && cd pdf2svg/ \
    && git checkout $GIT_BRANCH_OR_TAG

./configure
make
ls

cp pdf2svg /$BUILD_RESULT_DIR_NAME/pdf2svg

ls /$BUILD_RESULT_DIR_NAME
