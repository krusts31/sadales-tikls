FROM alpine:latest AS base

RUN apk update &&\
	apk upgrade &&\
	apk add --no-cache\
	mariadb-client

CMD mariadb-dump -h $MARAIDB_HOST -u $USER --databases $DATABASE -p$PASSWORD
