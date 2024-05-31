#!/bin/ash

#if healthy then 1
mailbox_domain=$(postmap -q $DOMAIN mysql:/etc/postfix/mysql-virtual-mailbox-domains.cf)
#if healthy then 1
mailbox_maps=$(postmap -q $EMAIL_USER@$DOMAIN mysql:/etc/postfix/mysql-virtual-mailbox-maps.cf)
#if healthy then $EMAIL_USER@DOMAIN
alias_maps=$(postmap -q $EMAIL_USER@$DOMAIN mysql:/etc/postfix/mysql-virtual-alias-maps.cf)

if [ "$mailbox_domain" != "1" ]; then
    echo "Health check failed: mailbox_domain is not 1."
    exit 1
fi

# Check mailbox_maps
if [ "$mailbox_maps" != "1" ]; then
    echo "Health check failed: mailbox_maps is not 1."
    exit 1
fi

# Check for $EMAIL_USER@$DOMAIN in alias_maps
if ! echo "$alias_maps" | grep -q "$EMAIL_USER@$DOMAIN"; then
    echo "Health check failed: $EMAIL_USER@$DOMAIN not found in alias_maps."
    exit 1
fi

echo $mailbox_domain $mailbox_maps $alias_maps

echo "Health check passed."
exit 0
