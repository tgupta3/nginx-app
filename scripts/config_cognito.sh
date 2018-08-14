#!/bin/bash
set -e

mkdir /home/ec2-user/python_app -p 
mv -f /tmp/python_app/* /home/ec2-user/python_app
sudo service supervisord stop
sudo service supervisord start
