#!/bin/bash

echo 'Welcome to DevShop'

docker-entrypoint.sh 'echo "Aegir setup complete!"'

echo 'We want to do a few more things:'

echo '  1. Generating SSH key: '
echo '     ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa '
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

echo "  SSH Key Generated!  This server's public key is"
cat ~/.ssh/id_rsa.pub

echo "  2. Save that key to the front-end."

echo " Running hosting-queued... "

# Run whatever is the Docker CMD, usually drush @hostmaster hosting-queued
`$@`