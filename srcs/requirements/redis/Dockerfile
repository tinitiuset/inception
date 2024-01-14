FROM alpine:3.18 as REDIS
RUN apk add --update redis
CMD [ "redis-server", "--protected-mode no" ]