FROM node:18.20.4-alpine

ENV NUXT_HOST=0.0.0.0
ENV HOST=0.0.0.0
ENV NUXT_PORT=3000

RUN apk update && \
    apk add --no-cache && \
    apk add alpine-sdk && \
    apk add git && \
    npm install -g npm@9.3.1

WORKDIR /bizmates-trainer-frontend

EXPOSE 3000
EXPOSE 24678

CMD ["tail", "-f", "/dev/null"]
