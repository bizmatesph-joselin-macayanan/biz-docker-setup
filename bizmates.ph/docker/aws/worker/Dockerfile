FROM public.ecr.aws/docker/library/php:7.2-fpm

RUN apt-get update && apt-get install --no-install-recommends -y aptitude
RUN aptitude install -y apt-utils

RUN apt-get install --no-install-recommends -y \
    wget \
    vim \
    git \
    unzip \
    locales \
    cron \
    supervisor

RUN apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev libpng-dev libzip-dev libgmp-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install pdo_mysql gd zip pcntl mysqli gmp

RUN sed -i '/en_US.UTF-8 UTF-8/s/^# //' /etc/locale.gen && locale-gen

COPY --from=public.ecr.aws/docker/library/composer:2.2.25 /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install mysqli

ENV APP_HOME=/home/bizmates/bizmates.ph
ENV PROJECT_DIR='/home/bizmates/bizmates.ph'

WORKDIR $PROJECT_DIR
VOLUME ["/home/bizmates/bizmates.ph"]

COPY ["./docker/aws/worker/config/crontab/scheduler", "/etc/cron.d/scheduler"]
COPY ["./docker/aws/worker/config/supervisor/scheduler.conf", "/etc/supervisord.d/scheduler.conf"]
COPY ["./docker/aws/worker/config/supervisor/supervisord.conf", "/etc/supervisord.conf"]
COPY ["./docker/aws/worker/scripts/docker-entrypoint.sh", "/"]
COPY ["./", "./"]
RUN chmod 0644 /etc/cron.d/scheduler
RUN crontab /etc/cron.d/scheduler
RUN chmod +x /docker-entrypoint.sh
RUN touch .env
RUN composer install

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
