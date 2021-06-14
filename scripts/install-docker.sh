#!/bin/bash

#Install docker
if ! command -v docker &> /dev/null; then
    wget get.docker.io -O /tmp/docker-install.sh
    chmod +x /tmp/docker-install.sh
    /tmp/docker-install.sh
    sudo usermod -aG docker $USER
else
    echo "docker already exists"
fi


#Install docker-compose
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "docker-compose already exists"
fi

