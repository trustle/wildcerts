#!/bin/bash

set -eu -o pipefail

source .config.env

DO_PUSH=${1-'false'}
docker build -t trustle/wildcerts .
if [ $DO_PUSH = 'true' ]; then
  docker login --username $DOCKER_HUB_USER --password $DOCKER_HUB_PASSWORD
  docker push trustle/wildcerts:latest
fi
 
