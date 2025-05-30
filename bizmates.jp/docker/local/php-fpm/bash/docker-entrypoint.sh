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

if [[ ! -d "${ALLPICATION_LOG_DIR}" ]]; then
    echo "[!!] Application log directory does not exist yet, creating.."
    mkdir -p "${ALLPICATION_LOG_DIR}" \
        && echo "[!!] Application log directory created: ${ALLPICATION_LOG_DIR}" \
        || { echo "[!!] *** FAILED TO CREATE APPLICATION LOG DIRECTORY: ${ALLPICATION_LOG_DIR} ***"; exit 2; }
else
    echo "[!!] Application log directory found: ${ALLPICATION_LOG_DIR}"
    ls -la ${ALLPICATION_LOG_DIR}
fi

export $(grep CONFIG_LOG_PATH .env | xargs)
FUELPHP_LOGS_SYMLINK=${CONFIG_LOG_PATH%/}
FUELPHP_LOGS_PARENT=$(dirname ${FUELPHP_LOGS_SYMLINK})

[[ -d "${FUELPHP_LOGS_PARENT}" ]] || mkdir -p ${FUELPHP_LOGS_PARENT}

# ln -s ${ALLPICATION_LOG_DIR} ${FUELPHP_LOGS_SYMLINK} \
#     && echo "[!!] Created symlink: ${ALLPICATION_LOG_DIR} --> ${FUELPHP_LOGS_SYMLINK}" \
#     || { echo "[!!] *** FAILED TO CREATE SYMLINK: ${ALLPICATION_LOG_DIR} --> ${FUELPHP_LOGS_SYMLINK} ***"; exit 3; }

chown -R www-data:www-data /var/www /var/log

# Running bash script `./docker-perms.sh` to set correct directory permissions on the project root directory
# `/home/bizmates/bizmates.jp` and its subdirectories. Note that for local development environment the project root directory
# is bind-mounted from host, so the chmod/chown commands will also affect directory permissions visible from the
# host machine.
(cd ${PROJECT_DIR} && chmod ug+x ./docker-perms.sh && ./docker-perms.sh)

echo '[!!] PHP version information at container startup:'
php --version

echo '[!!] Composer version information at container startup:'
su www-data -s /bin/sh -c 'composer --version'

echo '[!!] Running Composer install..' # only after the correct directory permissions have been set
su www-data -s /bin/sh -c 'composer install' \
    && echo '[!!] Composer install completed successfully.' \
    || echo '[!!] Composer install failed.' \

exec "$@"
