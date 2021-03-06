#!/bin/sh

if [ -z "$SSL_CERT" ]; then
    echo "\nCopying nginx.conf without SSL support..\n"
    cp /root/nginx.conf /etc/nginx/nginx.conf
else
    echo "\nCopying nginx.conf with SSL support..\n"
    sed -i "s#-x-replace-cert-x-#$SSL_CERT#" /root/nginx_ssl.conf
    sed -i "s#-x-replace-key-x-#$SSL_KEY#" /root/nginx_ssl.conf
    cp /root/nginx_ssl.conf /etc/nginx/nginx.conf
fi
chown -R www-data:www-data /var/www/owncloud/config
chown -R www-data:www-data /var/www/owncloud/data
echo "Starting server..\n"
/etc/init.d/php5-fpm start
/etc/init.d/nginx start
