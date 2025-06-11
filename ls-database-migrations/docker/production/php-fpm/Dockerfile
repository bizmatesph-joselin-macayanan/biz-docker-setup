FROM public.ecr.aws/docker/library/php:8.3-fpm-alpine

# Install only the minimal system dependencies for Laravel migrations
RUN apk add --no-cache bash curl git libzip-dev oniguruma-dev libxml2-dev icu-dev zlib-dev

# Install PHP extensions required for Laravel migrations
RUN docker-php-ext-install pdo pdo_mysql mbstring zip

# Set the working directory
WORKDIR /var/www/ls-db-migrations

# Install Composer
COPY --from=public.ecr.aws/docker/library/composer:2.7.6 /usr/bin/composer /usr/bin/composer

# Copy application files
COPY . .

# Expose port 9000 for PHP-FPM (optional, not needed for migrations)
EXPOSE 9000

# Default command to run migrations
# CMD ["php", "artisan", "migrate"]

