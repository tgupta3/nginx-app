#!/bin/bash
set -e
wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
unzip -o AmazonCloudWatchAgent.zip -d cwagent/
cd cwagent/ && ./install.sh
mv /tmp/cw_config.json /opt/aws/amazon-cloudwatch-agent/bin/
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/cw_config.json -s
