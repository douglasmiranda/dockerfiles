# This is an image for simple testing with the latest Jasmine and JSDOM
# - Using always the latest version
# - Mostly for simple frontend stuff
# docker run --rm -v "$PWD/example:/example" douglasmiranda/jasmine-jsdom jasmine example/test.js
FROM node:12-alpine

ENV NODE_PATH=/usr/local/lib/node_modules

RUN npm install -g jasmine jsdom
