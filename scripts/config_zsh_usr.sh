#!/bin/bash
set -e

if [ -d "/home/ec2-user/.oh-my-zsh" ]; then
  rm -rf /home/ec2-user/.oh-my-zsh
fi

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh 
git clone https://github.com/bhilburn/powerlevel9k.git /home/ec2-user/.oh-my-zsh/custom/themes/powerlevel9k
rm -rf .zshrc
curl -Lks https://raw.githubusercontent.com/tgupta3/cfgs/master/.bin/install.sh | /bin/zsh
