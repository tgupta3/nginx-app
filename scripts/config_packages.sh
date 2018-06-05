#!/bin/bash

mdkir -p /home/ec2-user/sample_app
curl -sS https://getcomposer.org/installer -o /home/ec2-user/sample_app/composersetup.php 
php /home/ec2-user/sample_app/composersetup.php --install-dir=/home/ec2-user/sample_app/
php /home/ec2-user/sample_app/composer.phar require aws/aws-sdk-php  --working-dir=/home/ec2-user/sample_app/
php /home/ec2-user/sample_app/composer.phar require gilbitron/php-simplecache --working-dir=/home/ec2-user/sample_app/
rm -rf /home/ec2-user/sample_app/vendor/gilbitron/cache
mkdir -p /home/ec2-user/sample_app/vendor/gilbitron/cache/
touch /home/ec2-user/sample_app/vendor/gilbitron/cache/label.cache
chown -R ec2-user:ec2-user /home/ec2-user/sample_app
