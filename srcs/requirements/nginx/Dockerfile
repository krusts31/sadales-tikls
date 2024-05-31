FROM alpine:latest as base

RUN apk update &&\
	apk upgrade &&\
	apk add --no-cache\
	nginx

RUN mkdir -p /run/nginx

RUN rm /etc/nginx/http.d/default.conf

COPY --chown=nginx:nginx healthcheck.sh /tmp/healthcheck.sh

COPY --chown=nginx:nginx conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]

FROM base as dev

RUN apk add vim --no-cache

COPY --chown=nginx:nginx conf/store-dev.conf /etc/nginx/http.d/store-dev.conf

FROM base as prod 

COPY --chown=nginx:nginx conf/store-prod.conf /etc/nginx/http.d/store-prod.conf

