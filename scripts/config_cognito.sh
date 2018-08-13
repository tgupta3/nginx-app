#!/bin/bash
set -e

mkdir /home/ec2-user/python_app
mv /tmp/python_app/* /home/ec2-user/python_app
sudo service supervisord start
