#!/usr/bin/env bash

# Update apt sources
echo "Update apt sources"
apt-get update

# Install utilities
apt-get install -y wget
apt-get install -y curl
apt-get install -y build-essential

# Install Node
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs

# Install Monogdb
npm install -g mongodb-runner

# Install Mocha
npm install -g mocha

# Install the Heroku Toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
