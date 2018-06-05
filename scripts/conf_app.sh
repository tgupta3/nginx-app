#!/bin/bash

rm -rf /etc/php.ini
rm -rf /etc/php-fpm.d/www.conf
mv  /tmp/php.ini /etc/
mv /tmp/www.conf /etc/php-fpm.d/ 
mkdir /home/ec2-user/nginx_server
mv /tmp/nginx_server/* /home/ec2-user/nginx_server/ 
chown -R ec2-user:ec2-user /home/ec2-user/nginx_server
