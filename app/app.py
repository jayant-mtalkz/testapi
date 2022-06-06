from flask import Flask, jsonify, request
import time
import datetime
date = datetime.datetime.now()
unix_time = datetime.datetime.timestamp(date)*1000
print(unix_time)

app = Flask(__name__)


@app.route('/', methods=['GET'])
def helloworld():
    return jsonify({"data": "Hello World", "request_id": unix_time}), 200


if __name__ == '__main__':
    app.run(debug=True)
