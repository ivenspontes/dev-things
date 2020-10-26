#!/bin/bash

echo "you need sudo to run this script, if you are unsure to run this script, press CTRL+C to cancel and check the source code. ENTER to continue."
read sudocheck

echo "Installing curl" ; sudo apt -yqq install curl &> /dev/null

echo "Installing software-properties-common" ; sudo apt -yqq install software-properties-common &> /dev/null

echo "Installing ppa:ondrej/php" ; sudo add-apt-repository ppa:ondrej/php -y &> /dev/null

echo "Installing PHP environment" ; sudo apt -yqq install apache2 php7.4 php7.4-mbstring php7.4-xml php-zip php7.4-gd php7.4-mysql php-curl &> /dev/null

echo "Installing composer" ; curl --silent -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer > /dev/null

read -r -p "Want install database server? [y,n] " input
 
case $input in
    [yY][eE][sS]|[yY])

    echo "[1] Mysql"
    echo "[2] MariaDB"
    echo "[3] Postgres"
    echo "PRESS ENTER TO NOT INSTALL"

    read -r -p "Choose database server: " database_server

    case $database_server in
    1) echo "Installing mysql-server"; sudo apt -yqq install mysql-server &> /dev/null;;
    2) echo "Installing mariadb-server"; sudo apt -yqq install neofetch  &> /dev/null;;
    3) echo "Installing postgresql"; sudo apt -yqq install postgresql &> /dev/null;;
    *) echo "Will not install database server";;
    esac

    # # fix password
    # # create database


 ;;
    [nN][oO]|[nN])
 echo "Will not install database server"
       ;;
    *)
 echo "Will not install database server"
 ;;

 
esac



echo "Fixing composer permissions" ; sudo chown -R $USER:$USER /home/$USER/.composer > /dev/null

echo "Fixing apache 'www' folder permission" ;
    sudo adduser $USER www-data
    sudo chown -R www-data:www-data /var/www
    sudo chmod -R g+rwX /var/www
> /dev/null

# install vhost conf file
# disable default
# enable vhost conf file


echo "Done"


# Ask the user for their name
# echo "What database server you need? [1: mysql | 2: postgres]"
# read database

# echo "running update" ; sudo apt update -yqq 2> /dev/null

# echo It\'s nice to meet you $database
