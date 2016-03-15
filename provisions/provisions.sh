#!/usr/bin/env bash

# Parse Keys
PARSE_APPLICATION_ID=""
PARSE_MASTER_KEY=""
# This should come from the ip defined in the vagrant file
MONGO_DEV_URL="mongodb://192.168.2.2:27017/dev"

# Update apt sources
echo "Update apt sources"
apt-get update

# ensure that APT works with the https method, and that CA certificates are installed.
echo "ensure that APT works with the https method, and that CA certificates are installed."
apt-get install -y apt-transport-https ca-certificates

# Add the new GPG key.
echo "Add the new GPG key."
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add an entry for your Ubuntu operating system.
echo "Add an entry for your Ubuntu operating system."
touch /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

# Update apt sources
echo "Update apt sources"
apt-get update

# Purge any old repos
echo "Purge any old repos"
apt-get purge lxc-docker

# Verify that APT is pulling from the right repository.
echo "Verify that APT is pulling from the right repository."
apt-cache policy docker-engine

# Update apt sources
echo "Update apt sources"
apt-get update

# Install the recommended package.
echo "Install the recommended package."
apt-get install -y linux-image-extra-$(uname -r)

# Make sure apparmor is installed
echo "Make sure apparmor is installed"
apt-get install -y apparmor

# Install docker
echo "Install docker"
apt-get install -y docker-engine

# Start the docker daemon.
echo "Start the docker daemon."
service docker start

# Create the docker group and add your user.
echo "Create the docker group and add your user."
usermod -aG docker ubuntu

# Setup the mongo container
echo "Setup the mongo container"
docker run -d -p 27017:27017 --name mongo mongo

# Setup the parse server container
# https://hub.docker.com/r/yongjhih/parse-server/
echo "Setup the parse server container"
docker run -d -v /my_cloud:/parse/cloud -e DATABASE_URI=$MONGO_DEV_URL -e APP_ID=$PARSE_APPLICATION_ID -e MASTER_KEY=$PARSE_MASTER_KEY -p 1337:1337 -p 2022:22 --name parse-server yongjhih/parse-server
