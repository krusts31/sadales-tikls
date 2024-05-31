#!/bin/bash

kubectl apply -f db-secret.yaml
kubectl apply -f pg-deploy.yaml
kubectl apply -f pg-service.yaml
minikube service pg-service
