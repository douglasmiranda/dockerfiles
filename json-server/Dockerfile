FROM node:8-alpine

RUN npm install --production -g json-server

VOLUME /data

EXPOSE 3000
CMD ["json-server", "--host", "0.0.0.0", "--watch", "/data/db.json"]
