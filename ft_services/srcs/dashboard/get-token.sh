#!/bin/bash
echo "short lived:"
kubectl -n kubernetes-dashboard create token  kubernetes-dashboard
echo "longe lived:"
kubectl get secret kubernetes-dashboard -n kubernetes-dashboard -o jsonpath={'.data.token'} | base64 -d
