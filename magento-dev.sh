#git
sudo apt-get update
sudo apt-get install git

bash < <(wget -q --no-check-certificate -O - https://raw.github.com/colinmollenhour/modman/master/modman-installer)
export PATH=$PATH:/home/bitnami/bin/

cd home/bitnami/apps/magento/htdocs

modman init
git config --global user.name "julianbueno"
git config --global user.email "julian.bueno@gmail.com"
modman clone https://username:pwd@github.com/zipMoney/magento-gateway.git --branch feature/modman
