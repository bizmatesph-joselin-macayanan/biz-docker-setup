#!/bin/bash

[[ "${DEBUG}" = "true" ]] && set -x
set -e

echo "[!!] Running 'docker-entrypoint.sh'. Project is directory: ${PROJECT_DIR}"

echo '[!!] PHP version information at container startup:'
php --version

chmod -R 777 /home/bizmates/bizmates.ph/

if [[ $# -eq 0 ]]; then
    echo '[!!] ENV Generating..'
    env | sed "s/=\(.*\)/='\1'/; s/^/export /" > /home/bizmates/bizmates.ph/.env.cron
    echo '[!!] ENV Generated!'
    echo '[!!] Running Supervisord..'
    supervisord -c /etc/supervisord.conf
    echo '[!!] Supervisord is now running!'
    echo '[!!] Running php-fpm..'
    /usr/local/sbin/php-fpm
    echo '[!!] PHP-FPM is now running!'
else
    exec "$@"
fi
