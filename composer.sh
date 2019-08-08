#!/bin/sh

sudo apt install curl

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

sudo chown -R $USER:$USER /home/$USER/.composer