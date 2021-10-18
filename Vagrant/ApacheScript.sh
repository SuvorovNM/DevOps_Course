#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
apt-get install -y python
apt-get install -y libapache2-mod-php
apt-get install -y php-mbstring
apt-get install -y apache2 openssl


if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant/sites /var/www
fi

if ! [ -L /etc/apache2 ]; then
  rm -rf /etc/apache2/sites-available 
  ln -fs /vagrant/apache2-new/sites-available /etc/apache2/sites-available
  cat /vagrant/apache2-new/apache2_for_append.conf >> /etc/apache2/apache2.conf
fi

mkdir /etc/ssl/localcerts
openssl req -new -x509 -days 365 -nodes -out /etc/ssl/localcerts/apache.pem -keyout /etc/ssl/localcerts/apache.key -subj "/C=RU/ST=Perm Region/L=Perm/O=HSE/OU=FCS/CN=localhost"
cd /etc/apache2/sites-available
a2dissite "000-default.conf"
a2ensite "firsthost.local.conf"
a2ensite "secondhost.local.conf"
a2enmod ssl
sudo systemctl restart apache2
echo "Configuration is done!"
