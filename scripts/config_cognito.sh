#!/bin/bash
set -e

mkdir /home/ec2-user/python_app -p 
cp -r /tmp/python_app/* /home/ec2-user/python_app
rm -R /tmp/python_app/*
sudo service supervisord stop
sudo service supervisord start
