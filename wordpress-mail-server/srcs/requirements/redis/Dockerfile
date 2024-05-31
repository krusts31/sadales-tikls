FROM alpine:3 as base

RUN apk update && apk upgrade &&\
	apk add --no-cache redis

COPY redis.conf /etc/redis.conf

FROM base as dev

RUN apk add vim --no-cache

CMD redis-server

FROM base as prod

CMD redis-server
