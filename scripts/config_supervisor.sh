#!/bin/bash

curl -O https://raw.githubusercontent.com/Supervisor/initscripts/master/redhat-init-mingalevme
sed -e "s/^PREFIX=\/usr$/PREFIX=\/usr\/local/" redhat-init-mingalevme > supervisord
chmod 755 supervisord
sudo chown root.root supervisord
mv supervisord /etc/init.d
mv /tmp/supervisord.conf /etc
