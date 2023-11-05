#!/bin/bash
set -e

# fetch docker image
docker pull edgedb/edgedb

# start container
docker run \
  --name edgedb-server \
  --restart always \
  --detach \
  --volume ${HOME}/edgedb/data:/var/lib/edgedb/data \
  --volume ${HOME}/.credentials:/etc/server-credentials \
  --env-file ${HOME}/.env.server \
  --publish 5656:5656 \
  edgedb/edgedb
