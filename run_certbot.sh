#!/bin/bash

set -uex -o pipefail

EMAIL=$1
DOMAIN=$2
LE_IS_PROD=${3-false}

for v in "HEROKU_API_KEY CLOUDFLARE_TOKEN"; do
  if [ -z $ ]; then
    echo Requires environment $v.
    exit 1
  fi
done

for v in "EMAIL DOMAIN LE_IS_PROD"; do
  if [ -z $v ]; then
    echo "USAGE: $0 <email> <domain> <LE_IS_PROD>"
    exit 1
  fi
done

# Get token from env
printf "dns_cloudflare_api_token = %s\n" $CLOUDFLARE_TOKEN > cf.ini

certbot \
  $( [ ! $LE_IS_PROD = 'true' ] && printf %s '--staging' ) \
  certonly \
  --non-interactive \
  --agree-tos \
  --no-self-upgrade \
  --no-permissions \
  --dns-cloudflare \
  --dns-cloudflare-credentials cf.ini \
  --email $EMAIL \
  -d $(printf "*.%s" $DOMAIN)

cp $(printf "/etc/letsencrypt/live/%s/fullchain.pem" $DOMAIN) ${DOMAIN}.crt
cp $(printf "/etc/letsencrypt/live/%s/privkey.pem" $DOMAIN) ${DOMAIN}.key

heroku certs:update --confirm trustle --app trustle  ${DOMAIN}.crt ${DOMAIN}.key 

