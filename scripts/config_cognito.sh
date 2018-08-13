#!/bin/bash
set -e

mv /tmp/python_app /home/ec2-user/
sudo service supervisord start
