#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# execute these commands on the ec2 instance before deploying

sudo yum update -y

# install docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# run local registry
docker run -d -p 5000:5000 --restart=always --name registry registry:2
