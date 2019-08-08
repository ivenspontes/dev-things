#!/bin/sh

sudo cp laravel.conf /etc/apache2/sites-available/laravel.conf

sudo a2dissite 000-default.conf
sudo a2ensite laravel.conf
sudo a2enmod rewrite
sudo service apache2 restart