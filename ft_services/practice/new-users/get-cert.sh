kubectl get csr myuser -o jsonpath='{.status.certificate}'| base64 -d > myuser.crt
