FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache  \
    php \
    php-mysqli \
    php-fpm \
    php-bcmath \
    php-curl \
    php-intl \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    php-phar \
    php-tokenizer \
    mariadb-client \
    && rm -f /var/cache/apk/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/bin/wp && \
    chmod +x /usr/bin/wp

COPY ./tools/run.sh /scripts/run.sh

COPY ./conf/php-fpm.conf /etc/php81/php-fpm.conf
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

WORKDIR /var/www/html

ENTRYPOINT ["sh", "/scripts/run.sh"]