#!/bin/sh

if [ -d "/run/mysqld" ]; then
	echo "mysqld exists, skipping creation"
	chown -R mysql:mysql /run/mysqld
else
	echo "mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "A mariadb database already exists, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "A mariadb database does not exist, creating..."
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

	cat << EOF >> "/tmp/users.sql"
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
fi

if [ "$MYSQL_USER" != "" ]; then
  cat << EOF >> "/tmp/users.sql"
CREATE DATABASE IF NOT EXISTS \`$MYSQL_USER\` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON \`$MYSQL_USER\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF
fi

mysqld --user=mysql --bootstrap --verbose=0 < /tmp/users.sql

rm -rf /tmp/users.sql

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 "$@"