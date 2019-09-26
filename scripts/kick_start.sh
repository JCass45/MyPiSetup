#!/bin/bash

set -e

error() {
    echo "Script failed on line $1"
}

trap 'error $LINENO' ERR

echo "Updating & upgrading packages..."
sudo apt-get update
sudo apt-get -y upgrade

echo "Installing Docker..."
curl -sSL https://get.docker.com | sh

echo "Creating docker group for sudo-less Docker use"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Enable Docker on startup
sudo systemctl enable docker

if [ -x $(command -v python) ]; then
    echo "Installing Python"
    sudo apt-get -y install python python-pip
fi

echo "Installing Docker-Compose"
sudo pip install docker-compose

echo "Building Docker Images"
docker-compose build