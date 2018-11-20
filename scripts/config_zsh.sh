#!/bin/bash
set -e

yum install -y tcpdump
yum install -y git
yum install -y zsh

#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh 
chsh -s /bin/zsh ec2-user
#git clone https://github.com/bhilburn/powerlevel9k.git /home/ec2-user/.oh-my-zsh/custom/themes/powerlevel9k
#chown -R ec2-user:ec2-user /home/ec2-user/.oh-my-zsh/ 

