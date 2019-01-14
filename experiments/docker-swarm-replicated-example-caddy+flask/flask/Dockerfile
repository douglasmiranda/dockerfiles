FROM python:3.7-alpine as base

RUN pip install flask==1.0.2 gunicorn==19.9.0

WORKDIR /app

CMD [ "gunicorn", "-b", "0.0.0.0", "app:app" ]

COPY ./ /app
