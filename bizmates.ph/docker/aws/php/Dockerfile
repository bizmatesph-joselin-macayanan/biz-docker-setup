FROM public.ecr.aws/docker/library/php:7.2-fpm

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && \
    apt-get install --no-install-recommends -y aptitude && \
    aptitude install -y apt-utils

RUN apt-get install --no-install-recommends -y \
    wget \
    vim \
    git \
    unzip \
    locales

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

COPY ["./docker/aws/php/scripts/docker-entrypoint.sh", "/"]
COPY ["./", "./"]
RUN chmod +x /docker-entrypoint.sh
RUN touch .env

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
