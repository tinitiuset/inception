FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache  \
    vsftpd \
    && rm -f /var/cache/apk/*

COPY ./tools/run.sh /scripts/run.sh

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT ["sh", "/scripts/run.sh"]