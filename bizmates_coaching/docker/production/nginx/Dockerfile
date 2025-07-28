FROM public.ecr.aws/docker/library/nginx:1.25-alpine3.18

ARG BUILD_ENV=production

WORKDIR /var/www/html/bizmates_co

RUN set -eux && \
    apk add --update-cache --no-cache --virtual=.build-dependencies tzdata && \
    apk add shadow && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del .build-dependencies

COPY ["./docker/${BUILD_ENV}/nginx/config/nginx.conf", "/etc/nginx/"]
COPY ["./docker/${BUILD_ENV}/nginx/scripts/docker-entrypoint.sh", "/"]
RUN chmod +x /docker-entrypoint.sh
COPY ["./","./"]

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]