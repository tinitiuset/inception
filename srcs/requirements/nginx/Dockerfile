FROM debian:buster AS NGINX

RUN apt-get update && apt-get install -y --no-install-recommends \
    && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -nodes \
  	-out /etc/nginx/ssl/key.crt	-keyout /etc/nginx/ssl/key.key \
  	-subj "/C=ES/SR=Bizkaia/L=Bilbao/O=42Urduliz/OU=/CN=Inception"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]