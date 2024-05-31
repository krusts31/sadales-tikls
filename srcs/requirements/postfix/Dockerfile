FROM alpine:3 as base

ENV DOCKERIZE_VERSION v0.7.0

RUN apk add --no-cache --update postfix postfix-mysql

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY main.cf /tmp/main.cf.tmpl

COPY master.cf /etc/postfix/master.cf

COPY mysql-virtual-mailbox-domains.cf /tmp/mysql-virtual-mailbox-domains.cf.tmpl

COPY mysql-virtual-mailbox-maps.cf /tmp/mysql-virtual-mailbox-maps.cf.tmpl

COPY mysql-virtual-alias-maps.cf /tmp/mysql-virtual-alias-maps.cf.tmpl

COPY mysql-email2mail.cf /tmp/mysql-email2mail.cf.tmpl

COPY sasl_passwd /tmp/sasl_passwd.tmpl

COPY health-check.sh /tmp/health-check.sh

COPY post-init.sh /tmp/post-init.sh

COPY docker-entrypoint.sh /tmp

EXPOSE 25

STOPSIGNAL SIGKILL

FROM base as dev

RUN apk add vim --no-cache

CMD /tmp/docker-entrypoint.sh

FROM base as prod

CMD /tmp/docker-entrypoint.sh
