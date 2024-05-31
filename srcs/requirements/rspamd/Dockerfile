FROM alpine:3 as base

ENV DOCKERIZE_VERSION v0.7.0

RUN apk update && apk upgrade &&\
	apk add --no-cache rspamd

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY logging.inc /etc/rspamd/local.d/logging.inc

COPY milter_headers.conf /etc/rspamd/override.d/milter_headers.conf

COPY dkim_signing.conf /tmp/dkim_signing.conf.tmpl

COPY worker-normal.inc /etc/rspamd/local.d/worker-normal.inc
COPY worker-controller.inc /tmp/worker-controller.inc.tmpl
COPY worker-proxy.inc /etc/rspamd/local.d/worker-proxy.inc

COPY docker-entrypoint.sh /tmp

RUN mkdir -p /var/lib/rspamd/dkim
RUN chown rspamd:rspamd /var/lib/rspamd/dkim

FROM base as dev

RUN apk add vim --no-cache

CMD /tmp/docker-entrypoint.sh

FROM base as prod

CMD /tmp/docker-entrypoint.sh
