#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install docker
sudo apt install curl
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose
