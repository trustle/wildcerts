# Auto manage heroku wildcard certificates with letsencrypt and cloudflare

Syntax:

```
docker run \
  --env HEROKU_API_KEY=xxxx \
  --env CLOUDFLARE_TOKEN=hxxxx \
  trustle/certmaster:latest EMAIL DOMAIN LE_IS_PROD
```

  - Email - letsencrypt account contact
  - Domain - the wildcard domain without leading star ("*"). ex: `example.com`
  - LE_IS_PROD to true to use the letsencrypt production server, otherwise use the staging server.


Example to create and install wild card certs for \*.example.com:

```
docker run \
  --env HEROKU_API_KEY=xxxx \
  --env CLOUDFLARE_TOKEN=hxxxx \
  trustle/certmaster:latest webmaster@example.com example.com true
```

# Using configuration file

Copy config.sample to .config.env, and set your secrets there. Then you can run the image with run.sh as follows:

```
./run.sh
```

# Build it

  - `docker-build-push.sh` -- will build the image only.
  - `docker-build-push.sh true` -- will build and push the image to dockerhub. You must be logged in.

# Info

We use the official letsencrypt certbot, the cloudflare plugin, and the official heroku SDK on the nodejs official debian image.

The cloudflare token needs zone/zone/list and zone/dns/edit scopes.
