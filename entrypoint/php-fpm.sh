#!/bin/bash

# Navigate to the project directory
cd /var/www/poc-mini-fileserver

# Install Composer dependencies
composer install --no-interaction --no-dev --prefer-dist

# Execute the command specified as CMD in Dockerfile, or override command
exec "$@"
