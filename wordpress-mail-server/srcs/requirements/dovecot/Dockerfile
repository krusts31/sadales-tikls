FROM alpine:3 as base

ENV DOCKERIZE_VERSION v0.7.0

RUN apk update &&\
	apk upgrade &&\
    apk add --no-cache dovecot\
		dovecot-sql\
		dovecot-mysql\
		dovecot-lmtpd\
		dovecot-pigeonhole-plugin\
		tini

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY 10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY 10-logging.conf /etc/dovecot/conf.d/10-logging.conf
COPY 10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY 10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY 10-ssl.conf /tmp/10-ssl.conf.tmpl

COPY 15-mailboxes.conf /etc/dovecot/conf.d/15-mailboxes.conf

COPY 20-lmtp.conf /etc/dovecot/conf.d/20-lmtp.conf
COPY 20-imap.conf /etc/dovecot/conf.d/20-imap.conf

COPY 90-quota.conf /etc/dovecot/conf.d/90-quota.conf
COPY 90-sieve.conf /etc/dovecot/conf.d/90-sieve.conf

COPY dovecot-sql.conf.ext /tmp/dovecot-sql.conf.ext.tmpl

COPY quota-warning.sh /tmp/quota-warning.sh.tmpl
COPY docker-entrypoint.sh /tmp


COPY spam-to-folder.sieve /etc/dovecot/sieve-after/spam-to-folder.sieve

COPY learn-ham.sieve /etc/dovecot/sieve/learn-ham.sieve
COPY learn-spam.sieve /etc/dovecot/sieve/learn-spam.sieve

COPY rspamd-learn-ham.sh /etc/dovecot/sieve/rspamd-learn-ham.sh
COPY rspamd-learn-spam.sh /etc/dovecot/sieve/rspamd-learn-spam.sh


RUN mkdir -p /etc/dovecot/sieve-after
RUN mkdir -p /etc/dovecot/sieve

RUN sievec /etc/dovecot/sieve-after/spam-to-folder.sieve &&\
	sievec /etc/dovecot/sieve/learn-spam.sieve &&\
	sievec /etc/dovecot/sieve/learn-ham.sieve

RUN addgroup -g 5000 vmail &&\
	adduser -G vmail -u 5000 -h /var/vmail vmail -D &&\
	chown -R vmail:vmail /var/vmail &&\
	chown root:root /etc/dovecot/dovecot-sql.conf.ext &&\
	chmod go= /etc/dovecot/dovecot-sql.conf.ext
#	chmod u=rw,go= /etc/dovecot/sieve/learn-{spam,ham}.{sieve,svbin} &&\
#	chown vmail:vmail /etc/dovecot/sieve/learn-{spam,ham}. &&\
#	chmod u=rwx,go= /etc/dovecot/sieve/rspamd-learn-{spam,ham}.sh &&\
#	chown vmail:vmail /etc/dovecot/sieve/rspamd-learn-{spam,ham}.sh

EXPOSE 24/tcp
EXPOSE 143/tcp
EXPOSE 993/tcp

ENTRYPOINT ["tini", "--"]

FROM base as dev

RUN apk add vim --no-cache

CMD /tmp/docker-entrypoint.sh

FROM base as prod

CMD /tmp/docker-entrypoint.sh
