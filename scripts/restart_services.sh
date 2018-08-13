#!/bin/bash
set -e
service nginx stop
service nginx start
service php-fpm stop
service php-fpm start
