#!/bin/bash
# Simple setup.sh for configuring WP on Ubuntu 14.04 LTS EC2 instance
# for headless setup. 

##########################
#INSTALL Magento powered by Bitnami (HVM)
# Linux/Unix, Ubuntu 14.04.1 | 64-bit Amazon Machine Image (AMI) | Updated: 4/23/15 
#########################

sudo apt-get update
sudo apt-get upgrade

#git
#sudo apt-get update
#sudo apt-get install git

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
#!/bin/sh
### BEGIN INIT INFO
# Provides:          TeamCity Build Agent
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start build agent daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO
#Provide the correct user name:
USER="ubuntu"
  
case "$1" in
start)
 su - $USER -c "cd /var/TeamCity/bin ; ./agent.sh start"
;;
stop)
 su - $USER -c "cd /var/TeamCity/bin ; ./agent.sh stop"
;;
*)
  #echo "usage start/stop"
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

#composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


