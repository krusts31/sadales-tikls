
first you create a key
```sh
openssl genrsa -out jane.key 2048
```
then you create a csr
```sh
openssl req -new -key jane.key -out jane.csr -subj "/CN=myuser"
```
then you run to get the csr out
```sh
bash cat-csr-with-no-new-line.sh
```
then you take that and putit in to CertificateSigningRequest
```sh
k apply -f csr.yaml
k certificate approve csr-name
```
then you get the signed cert
```sh
bash get-cert.sh
```
then you can add that cert to kube config
```sh
bash set-certificate-in-kube-config.sh
```

When the certificates are defined its time to 
```sh
kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
```

then you have to bind that role to a user 
```
kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser
```

```sh
kubectl config set-context myuser --cluster=kubernetes --user=myuser
```

```sh
kubectl config use-context myuser
```
