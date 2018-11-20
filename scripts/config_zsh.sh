#!/bin/bash
set -e

yum install -y tcpdump
yum install -y git
yum install -y zsh

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh 
chsh -s /bin/zsh ec2-user
