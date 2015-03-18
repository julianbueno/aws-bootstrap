#git
sudo apt-get update
sudo apt-get install git

bash < <(wget -q --no-check-certificate -O - https://raw.github.com/colinmollenhour/modman/master/modman-installer)
export PATH=$PATH:/home/bitnami/bin/

cd home/bitnami/apps/magento/htdocs

modman init

modman clone git@github.com:zipMoney/magento-gateway.git --branch feature/modman
