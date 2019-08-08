#!/bin/sh

sudo apt install software-properties-common 
sudo add-apt-repository ppa:ondrej/php

sudo apt update

sudo apt install apache2 php7.3 php7.3-mbstring php7.3-xml php-zip php7.3-gd php7.3-mysql