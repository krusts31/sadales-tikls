#!/bin/bash
eval $(minikube docker-env) #chagne the docker context to minikube
#when build images this will use minikubes docker not localdocker

kubectl delete -f srcs/mysql/mysql.yaml

kubectl delete -f srcs/wordpress/wordpress.yaml

kubectl delete -f srcs/nginx/nginx.yaml

kubectl delete -f srcs/sharde-volumes/nginx-var-www-letsncrypt-persistent-vol-claim.yaml
kubectl delete -f srcs/sharde-volumes/wordpress-nginx-persistent-vol-claim.yaml
kubectl delete -f srcs/sharde-volumes/nginx-etc-letsncrypt-persistent-vol-claim.yaml

kubectl delete -f srcs/sharde-volumes/nginx-etc-letsencrypt-vol.yaml
kubectl delete -f srcs/sharde-volumes/nginx-var-www-letsencrypt-vol.yaml
kubectl delete -f srcs/sharde-volumes/wordpress-nginx-persistent-vol.yaml

kubectl delete -f srcs/secrets.yaml

