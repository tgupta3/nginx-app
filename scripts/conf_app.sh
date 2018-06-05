#!/bin/bash

rm -rf /etc/php.ini
rm -rf /etc/php-fpm.d/www.conf
mkdir /home/ec2-user/nginx_server
chown -R ec2-user:ec2-user /home/ec2-user/nginx_server
