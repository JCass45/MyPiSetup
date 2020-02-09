#!/bin/bash

set -e

error() {
    echo "Script failed on line $1"
}

trap 'error $LINENO' ERR

echo "Updating & upgrading packages..."
sudo apt-get update > /dev/null
sudo apt-get -y upgrade > /dev/null

if [ ! $(command -v docker) ]; then
    echo "Installing Docker..."
    curl -sSL https://get.docker.com | sh

    if [ ! $(getent group docker) ]; then
        echo "Creating docker group for sudo-less Docker use"
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
    fi

    # Enable Docker on startup
    sudo systemctl enable docker
else
    echo "Docker already installed"
fi

if [ ! $(command -v python) ] || [ ! -x $(command -v pip) ]; then
    echo "Installing Python and pip..."
    sudo apt-get -y install python python-pip > /dev/null
else
    echo "Python and pip already installed"
fi

if [ ! $(command -v docker-compose) ]; then
    echo "Installing Docker-Compose..."
    sudo pip install docker-compose==1.23.2 > /dev/null
else
    echo "Docker-Compose already installed"
fi

echo "Restarting pi in..."
for count in 5 4 3 2 1; do
    echo $var
    sleep 1
done

sudo reboot now
