up-dev:
	bash ./srcs/requirements/certbot/init-letsencrypt.sh vitokap-dev.ee\
		mail.vitokap-dev.ee rspamd.vitokap-dev.ee
	docker compose -f srcs/docker-compose-dev.yaml\
		--env-file srcs/.env-dev up --build

reup-dev:
	docker compose -f srcs/docker-compose-dev.yaml\
		--env-file srcs/.env-dev up --build

down-dev:
	docker compose -f srcs/docker-compose-dev.yaml\
		--env-file srcs/.env-dev -v down
	docker volume rm srcs_vol_mariadb srcs_vol_wordpress srcs_vol_rspamd srcs_vol_dovecot

down-prod:
	docker compose -f srcs/docker-compose-prod.yaml\
		--env-file srcs/.env-prod -v down
	docker volume rm srcs_vol_mariadb srcs_vol_wordpress srcs_vol_rspamd srcs_vol_rspamd srcs_vol_dovecot

debug-prod:
	bash ./srcs/requirements/certbot/init-letsencrypt.sh vitokap.ee\
		mail.vitokap.ee rspamd.vitokap.ee
	docker compose -f srcs/docker-compose-prod.yaml\
		--env-file srcs/.env-prod up --build

up-prod:
	bash ./srcs/requirements/certbot/init-letsencrypt.sh vitokap.ee\
		mail.vitokap.ee rspamd.vitokap.ee
	docker compose -f srcs/docker-compose-prod.yaml\
		--env-file srcs/.env-prod up --build -d
	bash ./srcs/tools/wait.sh
	bash ./srcs/requirements/certbot/prod-cert-letsncrypt.sh vitokap.ee\
		mail.vitokap.ee rspamd.vitokap.ee
	bash ./srcs/tools/reload_nginx.sh

reup-prod:
	docker compose -f srcs/docker-compose-prod.yaml\
		--env-file srcs/.env-prod up --build -d

stop-prod:
	docker compose -f srcs/docker-compose-prod.yaml\
		--env-file srcs/.env-prod down

delete-certs:
	sudo rm -rf ./srcs/requirements/certbot/conf/live/*vitokap*

delete-vol:
	docker volume rm srcs_vol_mariadb srcs_vol_wordpress srcs_vol_rspamd srcs_vol_dovecot

docker-clean-vol:
	docker volume ls -q | xargs docker volume rm

f-down-prod: down-prod delete-certs delete-vol
	echo "full cleaned"

wordpress_db_backup:
	bash ./srcs/tools/database_backup.sh

mail_db_backup:
	bash ./srcs/tools/mysql_dump.sh MARIADB_HOST_NAME MAILSERVER_DATABASE_NAME MARIADB_ROOT_PASSWORD

import:
	bash ./srcs/tools/import_database.sh  24.05.20-17.48.41.sql

stop:
	docker stop -t 0 $(shell docker ps -q)

dns-txt:
	docker exec rspamd cat /tmp/dns-txt-record.txt .
