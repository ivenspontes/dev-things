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
        1) 
            echo "Installing mysql-server"; sudo apt -yqq install mysql-server &> /dev/null

            read -r -p "Password to Mysql 'root' user: " mysqlroot

            echo "Running mysql_secure_installation"; sudo mysql_secure_installation --use-default

            echo "Fixing Mysql login"; sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlroot';" &> /dev/null

        ;;

        2) 
            echo "Installing mariadb-server"; sudo apt -yqq install mariadb-server &> /dev/null

            read -r -p "Password to Mysql 'root' user: " mysqlroot

            echo "Running mysql_secure_installation"; sudo mysql_secure_installation --use-default

            echo "Fixing Mysql login"; sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlroot';" &> /dev/null

        ;;
        3)
        echo "Installing postgresql"; sudo apt -yqq install postgresql &> /dev/null

            read -r -p "Password to Postgresql 'postgres 'user: " pgpass

            echo "Fixing Postgresql login"; sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pgpass'" -d template1
        ;;
        *) echo "Will not install database server";;
        esac
    ;;

    [nN][oO]|[nN]) echo "Will not install database server";;
    *) echo "Will not install database server"    ;;
esac

echo "Fixing composer permissions" ; sudo chown -R $USER:$USER /home/$USER/.composer > /dev/null

echo "Fixing apache 'www' folder permission" ;
    sudo adduser $USER www-data
    sudo chown -R www-data:www-data /var/www
    sudo chmod -R g+rwX /var/www
> /dev/null

echo "Configuring vhost" ;

wget -O - https://raw.githubusercontent.com/ivenspontes/dev-things/master/laravel.conf > laravel.conf &> /dev/null

sudo mv laravel.conf /etc/apache2/sites-available/laravel.conf &> /dev/null

sudo a2dissite 000-default.conf &> /dev/null
sudo a2ensite laravel.conf &> /dev/null
sudo a2enmod rewrite &> /dev/null
sudo service apache2 restart &> /dev/null

echo "Removing this script file" ; rm laravel.sh &> /dev/null

echo "Done"