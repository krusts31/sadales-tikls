you m8 need to wait for the pods to become available before running.

```bash
minikube service pg
```

when it work you can connect to the db

```bash
psql --host=ip_given_by_minikube --port=prot_given_by_minikube --user=test\
    --dbname=test
```
