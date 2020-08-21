#!/bin/sh

sudo apt install software-properties-common 
sudo add-apt-repository ppa:ondrej/php

sudo apt update

sudo apt install apache2 php7.4 php7.4-mbstring php7.4-xml php-zip php7.4-gd php7.4-mysql php-curl mariadb-server


sudo mysql_secure_installation

sudo mysql SET PASSWORD FOR 'root'@'localhost' = PASSWORD('manager');

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'manager';
