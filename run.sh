#!/bin/bash

set -eu -o pipefail
source .config.env
set -x

docker run --env-file .config.env trustle/wildcerts $EMAIL $DOMAIN $LE_IS_PROD
