#/bin/ash

# Run dockerize and template file main.cf.tmpl into main.cf
# then start postfix as child process
dockerize -template /tmp/worker-controller.inc.tmpl:/etc/rspamd/local.d/worker-controller.inc\
	-template /tmp/dkim_signing.conf.tmpl /etc/rspamd/local.d/dkim_signing.conf

mkdir -p /tmp/keys

if [ ! -f /tmp/keys/$DOMAIN.$RSPAMD_SELECTOR.key ]; then
	rspamadm dkim_keygen -d $DOMAIN -s $RSPAMD_SELECTOR -k /tmp/keys/$DOMAIN.$RSPAMD_SELECTOR.key > /tmp/keys/dns-txt-record.txt
fi
cp /tmp/keys/$DOMAIN.$RSPAMD_SELECTOR.key /var/lib/rspamd/dkim/$DOMAIN.$RSPAMD_SELECTOR.key

chown rspamd /var/lib/rspamd/dkim/*
chmod u=r,go= /var/lib/rspamd/dkim/*

exec rspamd -f -u rspamd -g rspamd
