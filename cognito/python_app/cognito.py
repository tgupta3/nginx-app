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
import json, datetime, jwt, base64
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

def decode_jwt(jwt_token):
	decoded_jwt_headers = base64.b64decode((jwt_token.split('.')[0]))
	decoded_json = json.loads(decoded_jwt_headers)
	kid = decoded_json['kid']
	region = "us-east-1"
	url = 'https://public-keys.auth.elb.' + region + '.amazonaws.com/' + kid
	req = requests.get(url)
	pub_key = req.text
	payload = jwt.decode(jwt_token, pub_key,algorithms=[decoded_json['alg']])
	return payload

response = requests_retry_session().get('http://169.254.169.254/latest/meta-data/instance-id/')
instanceid = response.text
boot_time = psutil.boot_time()
time_elapsed = time.time() - boot_time
time_delta = (datetime.datetime.now() - datetime.timedelta(seconds=time_elapsed)).strftime("%Y-%m-%d %H:%M")

@application.route("/")
def hello():
    headers = request.headers.items()
    if('X-Amzn-Oidc-Data' in request.headers):
	try:
		decoded_jwt = decode_jwt(request.headers['X-Amzn-Oidc-Data'])
    		application.logger.info(decoded_jwt)
	except:
		decoded_jwt = ''
    else:
	decoded_jwt = ''
        application.logger.info("Hello")
    return render_template('headers.html', headers=headers, instanceid=instanceid, time_running=time_delta, user_data = decoded_jwt)

@application.route("/health")
def health_check():
    return "Hello"

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
    application.logger.info("test")
