FROM public.ecr.aws/docker/library/nginx:1.27.5

WORKDIR /home/bizmates/bizmates.ph

COPY ["./docker/aws/nginx/config/nginx.conf", "/etc/nginx/nginx.conf"]
COPY ["./docker/aws/nginx/scripts/docker-entrypoint.sh", "/docker-entrypoint.sh"]
RUN chmod +x /docker-entrypoint.sh
COPY ["./","./"]

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]