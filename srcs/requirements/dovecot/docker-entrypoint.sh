dockerize -template /tmp/10-ssl.conf.tmpl:/etc/dovecot/conf.d/10-ssl.conf\
	-template /tmp/dovecot-sql.conf.ext.tmpl:/etc/dovecot/dovecot-sql.conf.ext\
	-template /tmp/quota-warning.sh.tmpl:/usr/local/bin/quota-warning.sh

exec dovecot -F
