import os
from flask import Flask, request, jsonify, redirect, url_for

app = Flask(__name__)
POD_NAME = os.getenv("HOSTNAME", "unknown-pod")


@app.route("/", methods=["GET"])
def home():
    return """
        <form action="/greeting" method="get">
            <label for="name">Hi, what is your name?</label><br><br>
            <input type="text" id="name" name="name" required>
            <input type="submit" value="Submit">
        </form>
    """

@app.route("/greeting", methods=["GET"])
def greeting():
    name = request.args.get(
        "name", "there"
    )  # Default to 'there' if no name is provided
    message = f"Hi {name}, I'm Bazit. This was served from container {POD_NAME}."

    # content negtiation logic
    if "application/json" in request.headers.get("Accept", ""):
        return jsonify({"message": message})
    else:
        return f"<h1>{message}</h1>"



@app.route("/healthz", methods=["GET"])
def healthz():
    # health check endpoint
    return jsonify({"status": "ok", "pod": POD_NAME})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
