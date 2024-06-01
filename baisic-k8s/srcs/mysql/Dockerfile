FROM alpine:latest as base

RUN apk update &&\
	apk upgrade &&\
	apk add --no-cache\
	mariadb
        
COPY install.sh /tmp/install.sh

ENTRYPOINT sh /tmp/install.sh

FROM base as debug

RUN apk add --no-cache mariadb-client
