FROM php:7.2.20-fpm
COPY conf.d/xdebug.ini.sample conf.d/xdebug.ini* /usr/local/etc/php/conf.d/
COPY ["./php.ini", "$PHP_INI_DIR/php.ini"]
COPY ["./php.ini", "$PHP_INI_DIR/php.ini-production"]
RUN echo "security.limit_extensions = .php .html" > /usr/local/etc/php/conf.d/security.ini

RUN sed -i 's/^path-exclude \/usr\/share\/man\/\*/# path-exclude \/usr\/share\/man\/\*/' /etc/dpkg/dpkg.cfg.d/docker

RUN apt-get update && apt-get install --no-install-recommends -y aptitude
RUN aptitude install -y apt-utils

RUN apt-get install --no-install-recommends -y \
    wget \
    vim \
    git \
    unzip \
    locales

RUN apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev libpng-dev libzip-dev libgmp-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install pdo_mysql gd zip pcntl mysqli gmp

RUN sed -i '/ja_JP.UTF-8 UTF-8/s/^# //' /etc/locale.gen && locale-gen

ARG INSTALL_XDEBUG=false
ARG XDEBUG_CLIENT_PORT=9001
ARG XDEBUG_CLIENT_HOST=host.docker.internal
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.client_port=${XDEBUG_CLIENT_PORT}" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_host=${XDEBUG_CLIENT_HOST}" >> /usr/local/etc/php/conf.d/xdebug.ini \
;fi

##### Install Composer #####
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PHP_UID=1000
ENV PHP_GID=1000
ENV DOCKER_USER='www-data'

ENV PROJECT_DIR='/home/bizmates/bizmates.jp'
ENV ALLPICATION_LOG_DIR=/home/bizmates/bizmates.jp/fuel/app/logs/
ENV FUEL_ENV='development'

RUN mkdir -p /var/www/.composer
RUN chown -R www-data:www-data /var/www

WORKDIR $PROJECT_DIR
VOLUME  $PROJECT_DIR

COPY bash/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
