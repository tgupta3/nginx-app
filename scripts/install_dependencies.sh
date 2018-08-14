#!/bin/bash

set -e
#yum install -y nginx
#yum install -y php php-fpm php-mysql
easy_install pip==9.0.3
yum install -y python-pip
pip install flask
pip install supervisor
pip install gunicorn
pip install requests
pip install urllib3
