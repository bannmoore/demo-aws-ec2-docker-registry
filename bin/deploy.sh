#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

REGISTRY_HOST= # IP Address of ec2 instance running registry
REGISTRY_PORT=5000
IMAGE_NAME=bam/ec2-app:v1

# prerequisite: add REGISTRY_HOST:REGISTRY_PORT to insecure registries list on local machine.
# no active tunnel required

# copy docker-compose
scp docker-compose.server.yml ec2:~/.

# build docker images
docker-compose -f docker-compose.prod.yml build

# send docker images to ec2 registry
docker tag $IMAGE_NAME $REGISTRY_HOST:$REGISTRY_PORT/$IMAGE_NAME
docker push $REGISTRY_HOST:$REGISTRY_PORT/$IMAGE_NAME
docker image remove $REGISTRY_HOST:$REGISTRY_PORT/$IMAGE_NAME

ssh ec2 "docker pull localhost:$REGISTRY_PORT/$IMAGE_NAME; \
  docker tag localhost:$REGISTRY_PORT/$IMAGE_NAME $IMAGE_NAME; \
  docker image remove localhost:$REGISTRY_PORT/$IMAGE_NAME;
  docker-compose -f docker-compose.server.yml up -d;"
