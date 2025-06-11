FROM public.ecr.aws/docker/library/php:8.3-fpm-alpine

ARG BUILD_ENV
ENV BUILD_ENV ${BUILD_ENV}

# Install system dependencies
RUN apk add --no-cache \
    bash \
    zip \
    unzip \
    curl \
    git \
    nginx \
    supervisor \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    icu-dev \
    libzip-dev \
    zlib-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd intl zip

# Set the working directory
WORKDIR /var/www/ls-db-migrations

# install composer
COPY --from=public.ecr.aws/docker/library/composer:2.7.6 /usr/bin/composer /usr/bin/composer

# Copy application files
COPY . .

# Copy entry-point script and make it executable
# TODO: Make $BUILD_ENV dynamic in Terraform
# COPY ["./Entrypoint.sh", "/usr/local/bin/Entrypoint.sh"]
RUN chmod +x /usr/local/bin/Entrypoint.sh

# Install dependencies
# RUN composer install --no-dev --optimize-autoloader

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the entry point to use the Entrypoint.sh script
# ENTRYPOINT ["/usr/local/bin/Entrypoint.sh"]

