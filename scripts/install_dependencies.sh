#!/bin/bash

yum install -y nginx
yum install -y php php-fpm php-mysql
easy_install pip==9.0.3
pip install flask
pip install supervisor
pip install gunicorn
