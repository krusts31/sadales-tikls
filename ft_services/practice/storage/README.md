This is just a a quick way to see how mounts work on single node setup
first create a pv
then pvc
ssh in to minikube

run this

```bash
sudo sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"
```

then run this

```bash
apt update
apt install curl
curl http://localhost/
```
