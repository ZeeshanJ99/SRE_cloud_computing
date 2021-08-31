!#/bin/bash

# provisioning script
sudo apt-get update -y
sudo apt-get upgrade -y

# Add MongoDB Repo
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update

# install and verify
sudo apt-get install -y mongodb-org

# sudo rm /etc/mongod.conf
# sudo ln -s /home/ubuntu/mongod/mongo_db_settings.conf /etc/mongod.conf

# start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongodb
