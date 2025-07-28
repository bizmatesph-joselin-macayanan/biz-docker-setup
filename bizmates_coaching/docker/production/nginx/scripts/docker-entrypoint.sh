#!/bin/sh

USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

echo "starting with USER_ID: ${USER_ID}, GROUP_ID: ${GROUP_ID}..."

getent passwd nginx || {
    addgroup --gid ${GROUP_ID} -S nginx
    adduser  --uid ${USER_ID} -g nginx -S -D --no-create-home nginx
}

if [[ "${GROUP_ID}" != $(id -g nginx) ]]; then
    groupmod -g ${GROUP_ID} nginx
fi

if [[ "${USER_ID}" != $(id -u nginx) ]]; then
    usermod -u ${USER_ID} -g nginx nginx
fi

if [[ ! -d /var/tmp/nginx ]]; then
    mkdir -p /var/tmp/nginx
fi

chown -R nginx:nginx /var/www/html/bizmates_co /var/tmp/nginx

if [[ $# -eq 0 ]]; then
    echo "[!!] Running nginx.."
    /usr/sbin/nginx
else
    echo "[!!] Running $@.."
    exec "$@"
fi
