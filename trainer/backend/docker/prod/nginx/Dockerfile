FROM public.ecr.aws/docker/library/nginx:1.23.1-alpine

ARG APP_ENV=prod

WORKDIR /trainer-backend

RUN apk --no-cache add shadow

COPY ["./","./"]
COPY ["./docker/${APP_ENV}/nginx/config/nginx.conf", "/etc/nginx/nginx.conf"]
COPY ["./docker/${APP_ENV}/nginx/scripts/docker-entrypoint.sh", "/docker-entrypoint.sh"]
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
