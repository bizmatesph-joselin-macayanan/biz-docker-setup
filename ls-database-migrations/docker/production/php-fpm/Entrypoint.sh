#!/bin/sh

USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

echo "Starting with USER_ID: ${USER_ID}, GROUP_ID: ${GROUP_ID}..."

# Ensure group exists
if ! getent group www-data >/dev/null; then
    addgroup -g "${GROUP_ID}" -S www-data
fi

# Ensure user exists
if ! getent passwd www-data >/dev/null; then
    adduser -u "${USER_ID}" -G www-data -S -D --no-create-home www-data
fi

# Update user/group ID if necessary
if [ "$(id -g www-data)" -ne "${GROUP_ID}" ]; then
    groupmod -g "${GROUP_ID}" www-data
fi

if [ "$(id -u www-data)" -ne "${USER_ID}" ]; then
    usermod -u "${USER_ID}" -g www-data www-data
fi

# Ensure correct permissions for storage & database migrations
chown -R www-data:www-data /var/www/ls-db-migrations

# If no command is passed, start Laravel services
if [ "$#" -eq 0 ]; then
    echo "Running Laravel optimizations and migrations..."

    composer dump-autoload --optimize
    php artisan optimize

    # TODO: Enable this line after migrations table is created in the DB.
    #php artisan migrate --force

    echo "Starting PHP-FPM..."
    exec php-fpm
else
    # If arguments are provided, execute them
    exec "$@"
fi
