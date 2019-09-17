FROM python:3.7-alpine as base

RUN apk add --no-cache --virtual .build-dependencies \
    libuv-dev gcc musl-dev make

RUN pip install starlette uvicorn && apk del .build-dependencies

WORKDIR /app
VOLUME [ "/app/" ]

CMD [ "uvicorn", "--host", "0.0.0.0", "app:app" ]

COPY ./ /app
