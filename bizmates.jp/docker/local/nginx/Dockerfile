FROM nginx:1.23.4

RUN cat /etc/nginx/nginx.conf

COPY ./conf/*.conf /etc/nginx/conf.d/

ENV PHP_UID=1000
ENV PHP_GID=1000
ENV DOCKER_USER='nginx'
ENV PROJECT_DIR='/home/bizmates/bizmates.jp'

COPY bash/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
