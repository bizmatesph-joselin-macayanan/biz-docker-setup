FROM node:12.22.5-alpine

RUN npm config set unsafe-perm true
RUN npm install -g npm@6.14.17

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
