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

#install TC agent
sudo apt-get install openjdk-7-jre-headless
wget http://ec2/update/buildAgent.zip
sudo apt-get install unzip
(cd /var; sudo mkdir TeamCity; cd TeamCity)
sudo unzip ~/buildAgent.zip
(cd bin; sudo chmod +x agent.sh)
(cd ../conf; sudo cp buildAgent.dist.properties buildAgent.properties)

# We need to configure the agent
### Change the serverUrl and name
sudo nano buildAgent.properties
#Add the following
sudo nano /etc/init.d/teamcity
###########################
#! /bin/sh
# /etc/init.d/teamcity 
# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting script teamcity "
    /var/TeamCity/bin/agent.sh start
    ;;
  stop)
    echo "Stopping script teamcity"
    /var/TeamCity/bin/agent.sh stop
    ;;
  *)
    echo "Usage: /etc/init.d/teamcity {start|stop}"
    exit 1
    ;;
esac

exit 0
#############################
sudo chmod +x /etc/init.d/teamcity
sudo update-rc.d teamcity defaults

# You can always start/stop the agent manually
sudo /var/TeamCity/bin/agent.sh stop
sudo /var/TeamCity/bin/agent.sh start

#Install PEAR
sudo apt-get install php-pear
sudo apt-get install php5-cli
sudo apt-get install php5-curl
sudo apt-get install php5-dev

pear channel-update pear.php.net
pear update pear

sudo pear channel-discover pear.phpdoc.org
sudo pear channel-discover bartlett.laurent-laville.org
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony-project.com
sudo pear channel-discover pear.pdepend.org
sudo pear channel-discover pear.phpmd.org

sudo pear install bartlett/PHP_CompatInfo
composer global require "phpunit/phpunit=4.5.*"
sudo pear install --alldeps PHP_Codesniffer
sudo pear install pdepend/PHP_Depend-beta
sudo pear install phpmd/PHP_PMD
sudo pear install phpunit/phpcpd
sudo pear install phpunit/phpdcd-beta
sudo pear install phpdoc/phpDocumentor-alpha

pear channel-discover pear.phing.info
pear install [--alldeps] phing/phing
