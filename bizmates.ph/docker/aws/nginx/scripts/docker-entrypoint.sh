#!/bin/bash

USER_ID=${USID:-1000}
GROUP_ID=${GID:-1000}

echo "starting with USER_ID: ${USER_ID}, GROUP_ID: ${GROUP_ID}..."

if [[ "${GROUP_ID}" != $(id -g nginx) ]]; then
    groupmod -g ${GROUP_ID} nginx
fi

if [[ "${USER_ID}" != $(id -u nginx) ]]; then
    usermod -u ${USER_ID} -g nginx nginx
fi

if [[ ! -d /var/tmp/nginx ]]; then
    mkdir -p /var/tmp/nginx
fi

chmod -R 777 /home/bizmates/bizmates.ph/ /var/tmp/nginx

if [[ $# -eq 0 ]]; then
    echo "starting nginx..."
    /usr/sbin/nginx
    echo "Nginx is now running!"
else
    exec "$@"
fi
