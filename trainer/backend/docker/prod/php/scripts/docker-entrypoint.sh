#!/bin/bash

# NB: DEBUG, PROJECT_DIR, DOCKER_USER, PHP_UID and PHP_GID env vars must be set via either `Dockerfile` ENV commands,
# or `docker-compose.yaml`

[[ "${DEBUG}" = "true" ]] && set -x
set -e

echo "[!!] Running 'docker-entrypoint.sh'. Project is directory: ${PROJECT_DIR}"

# Detecting uid and gid of the '${DOCKER_USER}' user inside Docker container
PHP_UID_DEFAULT=$(id -u ${DOCKER_USER})
PHP_GID_DEFAULT=$(id -g ${DOCKER_USER})

echo "[!!] Checking UID and GID. Docker host user is ${PHP_UID}:${PHP_GID}, '${DOCKER_USER}' is ${PHP_UID_DEFAULT}:${PHP_GID_DEFAULT}."

if [[ "${PHP_UID}" != "0" ]] && [[ "${PHP_UID}" != "${PHP_UID_DEFAULT}" ]]; then
    echo "[!!] Need to change UID and GID for '${DOCKER_USER}'."
    usermod  -u ${PHP_UID} ${DOCKER_USER} \
        && groupmod -g ${PHP_GID} ${DOCKER_USER} \
        && echo "[!!] UID and GID changed. '${DOCKER_USER}' is now $(id -u ${DOCKER_USER}):$(id -g ${DOCKER_USER})." \
        || { echo "[!!] *** FAILED SETTING UID AND GID FOR '${DOCKER_USER}'! ***"; exit 1; }
else
    echo "[!!] UID and GID are OK!"
fi

echo '[!!] PHP version information at container startup:'
php --version

echo "[!!] Change ownership to ${DOCKER_USER}:"
chown -R ${DOCKER_USER}:${DOCKER_USER} /trainer-backend

echo '[!!] Composer version information at container startup:'
su ${DOCKER_USER} -s /bin/sh -c 'composer --version'

if [[ $# -eq 0 ]]; then
    echo '[!!] Running Composer dump-autoload..'
    composer dump-autoload
    echo '[!!] Clear Graphql Schema Cache'
    php artisan lighthouse:clear-cache
    echo '[!!] Cache Laravel config'
    php artisan cache:clear
    php artisan config:cache

    echo '[!!] Running php-fpm..'
    /usr/local/sbin/php-fpm
else
    exec "$@"
fi
