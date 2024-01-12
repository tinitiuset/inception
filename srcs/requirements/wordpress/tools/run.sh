#!/bin/sh

wp core download --version=6.0 --allow-root
wp config create --dbname="$MYSQL_USER" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb" --allow-root
wp core install --url="$HOST" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL" --skip-email --allow-root

wp option update home "https://$HOST"
wp option update siteurl "https://$HOST"

wp plugin install redis-cache --activate

wp config set WP_REDIS_HOST "redis"
wp config set WP_REDIS_PORT "6379"
wp config set WP_REDIS_DATABASE "1"

wp redis enable

exec php-fpm81 -F -R
