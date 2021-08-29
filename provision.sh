!#/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

# install and setup npm and nodejs
sudo apt-get install npm -y
sudo apt-get install python-software-properties -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# change directory to app
cd /home/ubuntu/app/app
sudo npm install pm2 -get
npm install

export DB_HOST=192.168.10.150:27017/posts
echo "export DB_HOST=192.168.10.150:27017/posts" >> ~/.bashrc
source ~/.bashrc

sudo nginx -t
sudo systemctl restart nginx
