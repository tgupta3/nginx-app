#!/bin/bash

mdkir -p /home/ec2-user/sample_app
cd /home/ec2-user/sample_app
curl -sS https://getcomposer.org/installer | php
php composer.phar require aws/aws-sdk-php
php composer.phar require gilbitron/php-simplecache
rm -rf /home/ec2-user/sample_app/vendor/gilbitron/cache
mkdir -p /home/ec2-user/sample_app/vendor/gilbitron/cache/
touch /home/ec2-user/sample_app/vendor/gilbitron/cache/label.cache
chown -R ec2-user:ec2-user /home/ec2-user/sample_app/vendor/gilbitron/cache/
