#!/bin/sh

sudo adduser $USER www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rwX /var/www