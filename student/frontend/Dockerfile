FROM public.ecr.aws/docker/library/node:15.14.0-alpine

WORKDIR /bizmates

RUN apk update && \
    apk add git nodejs autoconf automake file g++ libtool make nasm libpng-dev --no-cache

CMD ["tail", "-f", "/dev/null"]
