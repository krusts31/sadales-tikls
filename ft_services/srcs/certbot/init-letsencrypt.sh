#!/bin/bash
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

domain="ft_services.com"

rsa_key_size=2048
data_path="$DIR"
email="akrusts@olgrounds.dev" # Adding a valid address is strongly recommended

if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p "$data_path/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
fi

path="/etc/letsencrypt/live/$domain"
mkdir -p "$data_path/conf/live/$domain"

openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
	-keyout "./ft_services/privkey.pem"\
	-out "./ft_services/fullchain.pem"\
	-subj "/CN=$domain"
