#/bin/ash
set -ex

# Run dockerize and template file main.cf.tmpl into main.cf
# then start postfix as child process
dockerize -template /tmp/main.cf.tmpl:/etc/postfix/main.cf\
	-template /tmp/mysql-virtual-alias-maps.cf.tmpl:/etc/postfix/mysql-virtual-alias-maps.cf\
	-template /tmp/mysql-virtual-mailbox-maps.cf.tmpl:/etc/postfix/mysql-virtual-mailbox-maps.cf\
	-template /tmp/mysql-email2mail.cf.tmpl:/etc/postfix/mysql-email2mail.cf\
	-template /tmp/sasl_passwd.tmpl:/etc/postfix/sasl_passwd\
	-template /tmp/mysql-virtual-mailbox-domains.cf.tmpl:/etc/postfix/mysql-virtual-mailbox-domains.cf

chgrp postfix /etc/postfix/mysql-*.cf
chmod u=rw,g=r,o= /etc/postfix/mysql-*.cf

postmap /etc/postfix/sasl_passwd

chown postfix:postfix /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd

postalias /etc/postfix/aliases

exec postfix start-fg
