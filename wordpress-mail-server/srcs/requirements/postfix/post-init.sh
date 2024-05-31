#/bin/ash

postmap -q vitokap-dev.ee mysql:/etc/postfix/mysql-virtual-mailbox-domains.cf
postmap -q pood@vitokap-dev.ee mysql:/etc/postfix/mysql-virtual-mailbox-maps.cf
