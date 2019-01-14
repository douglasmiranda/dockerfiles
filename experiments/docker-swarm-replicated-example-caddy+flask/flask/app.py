from flask import Flask

import os

app = Flask(__name__)


@app.route("/")
def index():
    container = os.environ.get("HOSTNAME")
    return f"Hello, I'm a response from this container => {container}"
