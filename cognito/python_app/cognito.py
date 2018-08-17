from flask import Flask
from flask import request
from flask import render_template
from flask import make_response
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
import psutil
import time
import requests
import logging
import json, datetime
application = Flask(__name__)

#datetime.datetime.now()

def requests_retry_session(
    retries=4,
    backoff_factor=0.3,
    status_forcelist=(500, 502, 504),
    session=None,
):
    session = session or requests.Session()
    retry = Retry(
        total=retries,
        read=retries,
        connect=retries,
        backoff_factor=backoff_factor,
        status_forcelist=status_forcelist,
    )
    adapter = HTTPAdapter(max_retries=retry)
    session.mount('http://', adapter)
    session.mount('https://', adapter)
    return session

response = requests_retry_session().get('http://169.254.169.254/latest/meta-data/instance-id/')
instanceid = response.text
boot_time = psutil.boot_time()
time_elapsed = time.time() - boot_time
time_delta = (datetime.datetime.now() - datetime.timedelta(seconds=time_elapsed)).strftime("%Y-%m-%d %H:%M")

@application.route("/")
def hello():
    headers = request.headers.items()
    return render_template('headers.html', headers=headers, instanceid=instanceid, time_running=time_delta)

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
    #application.logger.info("Hello")
