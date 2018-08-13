from flask import Flask
from flask import request
from flask import render_template
from flask import make_response
import logging
import json, datetime
application = Flask(__name__)

@application.route("/")
def hello():
    headers = request.headers.items()
    return render_template('headers.html', headers=headers)

@application.route("/logout")
def logout():
    response = make_response(render_template('logout.html'))
    expiry_time = datetime.datetime.fromtimestamp(0)
    response.set_cookie('AWSELBAuthSessionCookie-0',value='',expires = expiry_time)
    return response
if __name__ == "__main__":
    application.run(host='0.0.0.0',port=8080,debug=True)


if __name__ != '__main__':
    gunicorn_logger = logging.getLogger('gunicorn.error')
    application.logger.handlers = gunicorn_logger.handlers
    application.logger.setLevel(gunicorn_logger.level)
