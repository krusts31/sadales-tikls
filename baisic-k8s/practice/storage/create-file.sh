#!/bin/bash
minikube ssh
sudo sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"
