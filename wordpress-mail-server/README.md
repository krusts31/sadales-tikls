# Wordpress with email server



Here is a source code that I use for my wordpress clients

To run in dev mode run 
```bash
make up-dev
```

not that production build only works when you have a exposed machine to the internet since lets encrypt need to do a request to the machine.

##### Step 1
Set up .env-dev
there are default values there 
##### Step 2
add your host name to /etc/hosts
since we are using https localy then you need to add a host name to you hosts file 
```bash
#if you are using NAT
echo "127.0.0.1     your-domain.what-ever" >> /etc/hosts
#if you are using Bridge 
echo "IP.OF.YOUR.VM     your-domain.what-ever" >> /etc/hosts
```
