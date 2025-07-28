#!/bin/sh

USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

echo "starting with USER_ID: ${USER_ID}, GROUP_ID: ${GROUP_ID}..."

getent passwd www-data || {
    addgroup --gid ${GROUP_ID} -S www-data
    adduser  --uid ${USER_ID} -g www-data -S -D --no-create-home www-data
}

if [[ "${GROUP_ID}" != $(id -g www-data) ]]; then
    groupmod -g ${GROUP_ID} www-data
fi

if [[ "${USER_ID}" != $(id -u www-data) ]]; then
    usermod -u ${USER_ID} -g www-data www-data
fi

chown -R www-data:www-data /var/www/html/bizmates_co

echo '[!!] PHP version information at container startup:'
php --version

echo '[!!] Composer version information at container startup:'
composer --version

if [[ $# -eq 0 ]]; then

    echo '[!!] Running Composer dump-autoload..'
    composer dump-autoload

    echo '[!!] Cache Laravel config'
    php artisan migrate --force
    php artisan config:cache

    echo '[!!] Running php-fpm'
    /usr/local/sbin/php-fpm

else
    exec "$@"
fi