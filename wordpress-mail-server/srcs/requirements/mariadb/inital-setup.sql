USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '{{ .Env.MARIADB_ROOT_PASSWORD }}';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '{{ .Env.MARIADB_ROOT_PASSWORD }}' WITH GRANT OPTION;

CREATE DATABASE {{ .Env.MAILSERVER_DATABASE_NAME }} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE {{ .Env.WORDPRESS_DATABASE_NAME }} CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER '{{ .Env.MARIADB_MAIL_ADMIN }}'@'%' IDENTIFIED by '{{ .Env.MARIADB_MAIL_ADMIN_PASSWORD }}';
CREATE USER '{{ .Env.MARIADB_MAIL_SERVER }}'@'%' IDENTIFIED by '{{ .Env.MARIADB_MAIL_SERVER_PASSWORD }}';

GRANT ALL ON {{ .Env.MAILSERVER_DATABASE_NAME }}.* TO '{{ .Env.MARIADB_MAIL_ADMIN }}'@'%' IDENTIFIED BY '{{ .Env.MARIADB_MAIL_ADMIN_PASSWORD }}';
GRANT SELECT ON {{ .Env.MAILSERVER_DATABASE_NAME }}.* TO '{{ .Env.MARIADB_MAIL_SERVER }}'@'%' IDENTIFIED BY '{{ .Env.MARIADB_MAIL_SERVER_PASSWORD }}';

CREATE USER '{{ .Env.MARIADB_USER }}'@'%' IDENTIFIED by '{{ .Env.MARIADB_USER_PASSWORD }}';
GRANT ALL PRIVILEGES ON {{ .Env.WORDPRESS_DATABASE_NAME }}.* TO '{{ .Env.MARIADB_USER }}'@'%';

FLUSH PRIVILEGES;