FROM debian:latest

MAINTAINER 01gr0nd5

RUN apt-get update &&\
	apt-get install -y\
	genisoimage\
	isolinux\
	pwgen\
	vim\
	cpio\
	xorriso\
	genisoimage\
	gzip

COPY cook-book/ /tmp/cook-book/
COPY debian-12.5.0-amd64-netinst.iso /tmp/debian-12.5.0-amd64-netinst.iso

WORKDIR /tmp/cook-book/gui

CMD ["bash", "preseed.sh"]
