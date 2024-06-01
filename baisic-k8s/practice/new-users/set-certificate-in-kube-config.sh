#!/bin/bash
kubectl config set-credentials user-dev --client-certificate=user.crt --client-key=admin.key --embed-certs=true
