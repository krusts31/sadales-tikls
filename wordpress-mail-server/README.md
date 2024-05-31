# WordPress with Email Server

Here's the tutorial I'm using to set up a mail server: https://workaround.org/ispmail-bookworm/. Note that the tutorial does not use microservices or Docker, so I've containerized it using the 1 process per container approach.

## How to Make It Work:

### Step 1
In `.env-dev`, change the domain you use:
DOMAIN=your-desired-domain.com

```bash
If you are using NAT:
echo "127.0.0.1 your-desired-domain.com" >> /etc/hosts
If you are using Bridge:
echo "IP.OF.YOUR.VM your-desired-domain.com" >> /etc/hosts
```

Run the following command:
```bash
make up-dev
```

Done! It will run and you will have a custom WordPress installation, plus an email server.

### What Can This Code Do?

You'll have your own WordPress container with an nginx container and a MariaDB container. In theory, you can host unlimited products, as much as your space allows. Encryption is provided by Let's Encrypt, and to get "real certificates," you just have to run:
```
make up-prod
```
This is meant for production builds that are hosted on the cloud.

#### Email Server
The setup includes Postfix, Dovecot for accessing emails, Rspamd for filtering spam, and Redis for caching. Rspamd also uses Redis as a database. Again, you can create as many email mailboxes as you want.

Turns out a lot of hosting providers block port 25, and it is really hard to unblock because it is outside of your control. You have to ask for permission via email. Good luck getting throw to their custumer support!

So, sending emails is done via forwarding to an SMTP service. I'm hosting this server on AWS and using their Simple Mail Service to forward mail from Postfix. But receiving works fine.

