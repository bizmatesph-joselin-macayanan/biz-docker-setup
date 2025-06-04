FROM node:12.22.5-alpine

RUN npm config set unsafe-perm true

RUN apk update && \
    apk add --no-cache && \
    apk add alpine-sdk && \
    apk add git && \
    npm install -g npm@6.14.17 && \
    npm install -g @vue/cli

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
