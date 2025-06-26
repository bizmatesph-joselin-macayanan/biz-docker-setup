#!/bin/sh

if [[ -f /.dockerenv ]]; then
    chown -R nginx:nginx /trainer-backend
fi

if [[ $# -eq 0 ]]; then
    echo "starting nginx..."
    /usr/sbin/nginx
    echo "Nginx is now running!"
else
    exec "$@"
fi
