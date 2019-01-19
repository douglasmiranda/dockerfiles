from flask import Flask, make_response

from datetime import datetime

app = Flask(__name__)


@app.route("/")
def index():
    time = str(datetime.now().time())
    response = make_response(f"Hello, this response was generated at => {time}")
    return response


@app.route("/5-minutes")
def five_minutes():
    time = str(datetime.now().time())
    response = make_response(f"Hello, this response was generated at => {time}")
    response.headers["Cache-Control"] = "max-age=300"
    return response
