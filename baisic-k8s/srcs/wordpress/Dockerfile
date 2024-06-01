FROM alpine:edge as base

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories &&\
	apk update && apk upgrade && apk add --no-cache\
	php83\
	php83-simplexml\
	php83-tokenizer\
	php83-xmlwriter\
	php83-ctype\
	php83-phar\
	php83-openssl\
	php83-curl\
	php83-dom\
	php83-exif\
	php83-fileinfo\
	php83-sodium\
	php83-mbstring\
	php83-mysqli\
	php83-xml\
	php83-zip\
	php83-cgi\
	php83-pecl-imagick\
	php83-fpm\
	php83-session\
	php83-gd\
	php83-iconv\
	php83-intl\
	mariadb-client\
	tini

RUN ln -s /usr/bin/php83 /usr/local/bin/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN adduser -S nginx &&\
	addgroup -S nginx

RUN chmod +x wp-cli.phar &&\
	mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/wordpress

COPY --chown=nginx:nginx ./www.conf /etc/php83/php-fpm.d/www.conf
COPY --chown=nginx:nginx ./php.ini /etc/php83/php.ini

COPY --chown=nginx:nginx ./blog-wordpress-install.sh /tmp/blog-wordpress-install.sh
COPY --chown=nginx:nginx ./healthcheck.sh /tmp/healthcheck.sh

ENTRYPOINT ["tini", "--"]

CMD sh /tmp/blog-wordpress-install.sh
