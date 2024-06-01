FROM alpine:latest as base

RUN apk update &&\
	apk upgrade &&\
	apk add --no-cache\
	nginx

RUN mkdir -p /run/nginx

RUN rm /etc/nginx/http.d/default.conf

COPY --chown=nginx:nginx healthcheck.sh /tmp/healthcheck.sh

COPY --chown=nginx:nginx ft_services.conf /etc/nginx/ft_services.conf

COPY --chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf

COPY --chown=nginx:nginx ft_services.conf /etc/nginx/ft_services.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
