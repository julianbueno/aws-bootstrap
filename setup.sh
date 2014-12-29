#!/bin/bash
# Simple setup.sh for configuring WP on Ubuntu 14.04 LTS EC2 instance
# for headless setup. 

sudo apt-get update
sudo apt-get upgrade
#?sudo a2enmod rewrite

#install LAMP stack
sudo apt-get install apache2
sudo apt-get install mysql-server-5.6
#?mysql_secure_installation
#mysql-client-5.6
#sudo apt-get remove --purge mysql-server mysql-client mysql-common
sudo add-apt-repository ppa:ondrej/php5-5.6
sudo apt-get update
sudo apt-get install python-software-properties
sudo apt-get update
sudo apt-get install php5
#php5 -v
sudo apt-get install php5 libapache2-mod-php5 php5-mysql
sudo /etc/init.d/apache2 restart
#to configure wp db and db user
sudo apt-get install phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html

#Check Apache
#Open a web browser and navigate to http://localhost/. You should see a message saying It works!
#Check PHP
php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'

#Installing WP
cd /var/www
sudo wget http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo chown -R www-data:www-data wordpress

cd /etc/apache2/sites-available

sudo nano wordpress.conf

<VirtualHost *:80>
   ServerName staging2.zipmoney.com.au
   DocumentRoot /var/www/wordpress
   DirectoryIndex index.php
   <Directory /var/www/wordpress/>
 Options Indexes FollowSymLinks MultiViews
               AllowOverride FileInfo
               Order allow,deny
               allow from all
   </Directory>
       ErrorLog ${APACHE_LOG_DIR}/zipmoney-error.log

       LogLevel warn

       CustomLog ${APACHE_LOG_DIR}/zipmoney-access.log combined

</VirtualHost>

sudo a2ensite wordpress
sudo service apache2 restart

cd /var/www
sudo chmod -R 777 wordpress
