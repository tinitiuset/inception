#!/bin/sh

echo "root:$FTP_PAWSSWORD" | /usr/sbin/chpasswd

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf