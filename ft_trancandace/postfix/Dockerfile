FROM alpine:latest as base

RUN apk update &&\
	apk upgrade &&\
	apk add postfix --no-cache

COPY main.cnf /etc/postfix/main.cnf

CMD ["postfix", "start-fg"]
