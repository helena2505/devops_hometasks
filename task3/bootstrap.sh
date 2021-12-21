#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
apt-get install -y python3
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

sudo a2enmod cgi

sudo rm -rf /etc/apache2/sites-available/000-default.conf
sudo rm -rf /etc/apache2/sites-available/default-ssl.con

sudo apt-get install dos2unix
dos2unix /var/www/cgi-bin/app.py

sudo ufw allow 'Apache Full'

sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod rewrite

sudo a2ensite default

sudo systemctl restart apache2
