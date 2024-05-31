FROM alpine:latest AS base

ENV DOCKERIZE_VERSION v0.7.0

RUN apk update &&\
	apk upgrade &&\
	apk add --no-cache\
	mariadb
        
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENTRYPOINT [ "sh", "/tmp/install.sh" ]

FROM base AS dev

RUN apk add --no-cache mariadb-client

COPY create-tables.sql /tmp/create-tables.sql.tmpl

COPY create-users.sql /tmp/create-users.sql.tmpl

COPY inital-setup.sql /tmp/inital-setup.sql.tmpl

COPY install.sh /tmp/install.sh

ENTRYPOINT [ "sh", "/tmp/install.sh" ]

FROM base AS prod

COPY create-tables.sql /tmp/create-tables.sql.tmpl

COPY create-users.sql /tmp/create-users.sql.tmpl

COPY inital-setup.sql /tmp/inital-setup.sql.tmpl

COPY install.sh /tmp/install.sh

COPY health-check.sh /tmp/health-check.sh

ENTRYPOINT [ "sh", "/tmp/install.sh" ]
