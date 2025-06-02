#!/bin/bash

[[ "${DEBUG}" = "true" ]] && set -x
set -e

echo "[!!] Running 'docker-entrypoint.sh'. Project is directory: ${PROJECT_DIR}"

echo '[!!] PHP version information at container startup:'
php --version

chmod -R 777 /home/bizmates/bizmates.ph/

if [[ $# -eq 0 ]]; then
    echo '[!!] Running php-fpm..'
    /usr/local/sbin/php-fpm
    echo '[!!] PHP-FPM is now running!'
else
    exec "$@"
fi
