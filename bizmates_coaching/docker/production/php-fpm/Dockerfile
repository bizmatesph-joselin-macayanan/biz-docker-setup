FROM public.ecr.aws/docker/library/node:20-alpine3.17 as node-env
RUN npm install -g npm@10.2.3

FROM public.ecr.aws/docker/library/php:8.3-fpm-alpine3.18

ARG BUILD_ENV=production
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

WORKDIR /var/www/html/bizmates_co

VOLUME ["/var/www/html/bizmates_co"]

RUN set -eux && \
    apk update && \
    apk add --update-cache --no-cache --virtual=.build-dependencies tzdata $PHPIZE_DEPS && \
    apk add shadow zip zlib-dev libzip-dev libpng-dev jpeg-dev autoconf supervisor libc-dev gcc make libwebp-dev && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del .build-dependencies && \
    docker-php-ext-configure gd --with-jpeg --with-webp && \
    docker-php-ext-install -j$(nproc) pdo_mysql && \
    docker-php-ext-enable opcache && \
    cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    rm -rf /tmp/* /var/cache/apk/*

COPY --from=public.ecr.aws/docker/library/composer:2.3.5 /usr/bin/composer /usr/bin/composer
COPY --from=node-env /usr/local/bin/node /usr/bin/node
COPY --from=node-env /usr/local/lib/node_modules /usr/lib/node_modules
RUN ln -s /usr/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm

COPY ["./docker/${BUILD_ENV}/php-fpm/config/z-opcache.ini", "${PHP_INI_DIR}/conf.d/"]
COPY ["./docker/${BUILD_ENV}/php-fpm/config/z-php.ini", "${PHP_INI_DIR}/conf.d/"]
COPY ["./docker/${BUILD_ENV}/php-fpm/config/php-fpm.conf", "/usr/local/etc/"]
COPY ["./docker/${BUILD_ENV}/php-fpm/scripts/docker-entrypoint.sh", "/"]
COPY ["./", "./"]
RUN  echo "INSTALLING GD EXTENSION"; \
    apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j "$(nproc)" gd; \
    \
    echo "INSTALLING ZIP EXTENSION"; \
    apk add --no-cache libzip-dev zlib-dev zip; \
    docker-php-ext-configure zip; \
    docker-php-ext-install -j "$(nproc)" zip;
RUN chmod +x /docker-entrypoint.sh

# RUN composer install && \
#     npm install && \
#     npm run build --host

EXPOSE 9000

# ENTRYPOINT ["/docker-entrypoint.sh"]
