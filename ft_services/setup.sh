#!/bin/bash
eval $(minikube docker-env) #chagne the docker context to minikube
#when build images this will use minikubes docker not localdocker

kubectl apply -f srcs/sharde-volumes/nginx-etc-letsncrypt-persistent-vol-claim.yaml
kubectl apply -f srcs/sharde-volumes/nginx-var-www-letsncrypt-persistent-vol-claim.yaml
kubectl apply -f srcs/sharde-volumes/wordpress-nginx-persistent-vol-claim.yaml

kubectl apply -f srcs/sharde-volumes/nginx-etc-letsencrypt-vol.yaml
kubectl apply -f srcs/sharde-volumes/nginx-var-www-letsencrypt-vol.yaml
kubectl apply -f srcs/sharde-volumes/wordpress-nginx-persistent-vol.yaml

kubectl apply -f srcs/secrets.yaml

docker build -t mysql --target base srcs/mysql
docker build -t wordpress --target base srcs/wordpress
docker build -t nginx --target base srcs/nginx

kubectl apply -f srcs/mysql/mysql.yaml

kubectl apply -f srcs/wordpress/wordpress.yaml

kubectl apply -f srcs/nginx/nginx.yaml
