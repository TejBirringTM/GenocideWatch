#!/bin/bash
set -e

# load credentials from local env file
set -o allexport
source .env.local 
set +o allexport

# load local ssh identity (make share to share with droplet!)
ssh-add

# copy credentials folder, env file, and script to droplet
scp -r .credentials root@${DROPLET_IP}:~/.credentials
scp .env.server root@${DROPLET_IP}:~/.env.server
scp setup-edgedb-server.sh root@${DROPLET_IP}:~/setup-server.sh

# give execution permission to the setup script
ssh root@${DROPLET_IP} 'chmod a+x ./setup-server.sh'

# run the setup script
ssh root@${DROPLET_IP} './setup-server.sh'
