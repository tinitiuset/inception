FROM alpine:3.18

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
    rm -f /var/cache/apk/*

COPY ./tools/run.sh /scripts/run.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["sh", "/scripts/run.sh"]