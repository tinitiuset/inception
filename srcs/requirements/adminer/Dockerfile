FROM alpine:3.18 as ADMINER

RUN apk update && apk upgrade && apk add --no-cache  \
    php \
    php-session \
    php-mysqli \
    wget \
    && rm -f /var/cache/apk/*

RUN mkdir -p /var/www/html

RUN wget "https://www.adminer.org/latest.php" -O /var/www/html/index.php

ENTRYPOINT ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]