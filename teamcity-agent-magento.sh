#!/bin/bash
# Simple setup.sh for configuring WP on Ubuntu 14.04 LTS EC2 instance
# for headless setup. 

sudo apt-get update
sudo apt-get upgrade

#mysql
sudo apt-get install mysql-server-5.6
sudo apt-get install php5-mysql

#php
sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install php5

#git
sudo apt-get update
sudo apt-get install git

#composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
