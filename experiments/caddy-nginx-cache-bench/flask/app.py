from flask import Flask, make_response

app = Flask(__name__)


@app.route("/")
def index():
    response = make_response("hello")
    response.headers["Cache-Control"] = "max-age=300"
    return response
