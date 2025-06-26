FROM public.ecr.aws/docker/library/php:8.1.8-fpm
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ENV PROJECT_DIR='/trainer-backend'
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/composer
ENV APPLICATION_LOG_DIR=/var/log/bizmates/trainer-backend
ARG APP_ENV=prod

WORKDIR $PROJECT_DIR

RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer
RUN apt-get update \
&& apt-get install -y \
git \
zip \
unzip \
vim

RUN apt-get update \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql pcntl

ENV PHP_UID=1000
ENV PHP_GID=1000
ENV DOCKER_USER='www-data'

COPY ["./docker/${APP_ENV}/php/config/php-fpm.conf", "/usr/local/etc/php-fpm.conf"]
COPY ["./docker/${APP_ENV}/php/scripts/docker-entrypoint.sh", "/"]
RUN chmod +x /docker-entrypoint.sh

COPY ["./", "./"]

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
