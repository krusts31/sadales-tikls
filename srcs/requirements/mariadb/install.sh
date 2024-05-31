#!/bin/sh

dockerize -template /tmp/inital-setup.sql.tmpl:/tmp/inital-setup.sql\
	-template /tmp/create-tables.sql.tmpl:/tmp/create-tables.sql\
	-template /tmp/create-users.sql.tmpl:/tmp/create-users.sql

if [ ! -d /run/mysqld ]
then
	echo "setting up maraidb"

	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

	/usr/bin/mariadbd --user=mysql --bootstrap < /tmp/inital-setup.sql
	/usr/bin/mariadbd --user=mysql --bootstrap < /tmp/create-tables.sql
	/usr/bin/mariadbd --user=mysql --bootstrap < /tmp/create-users.sql

	sed 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/' -i /etc/my.cnf.d/mariadb-server.cnf
	sed 's/skip-networking//' -i /etc/my.cnf.d/mariadb-server.cnf
fi

echo "mariadb started"

touch /tmp/healthy

exec /usr/bin/mariadbd --user=mysql --console
