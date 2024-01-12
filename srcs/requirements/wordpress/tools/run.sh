#!/bin/sh

wp core download --version=6.0 --allow-root
wp config create --dbname="$MYSQL_USER" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb" --allow-root
wp core install --url="$HOST" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL" --skip-email --allow-root
wp option update home "https://$HOST"
wp option update siteurl "https://$HOST"

exec php-fpm81 -F