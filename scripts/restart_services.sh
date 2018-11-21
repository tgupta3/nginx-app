#!/bin/bash
#set -e
service nginx stop
service nginx start
service php-fpm stop
service php-fpm start
service supervisord stop
/usr/local/bin/supervisord -c /etc/supervisord.conf
service collectd start
