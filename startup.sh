#!/usr/bin/env bash

sudo apt-get --yes update 
sudo apt-get install --yes ruby-full ruby-bundler build-essential
ruby -v 
bundle -v
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt-get --yes update
sudo apt-get install --yes mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
