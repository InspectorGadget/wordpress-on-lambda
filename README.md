# Wordpress on AWS Lambda


## Command
```bash
openssl req -nodes -x509 -sha256 -newkey rsa:4096 \
  -keyout key.pem \
  -out cert.pem \
  -days 3650 \
  -subj "/C=US/ST=Washington/L=Seattle/O=Example Co/OU=Engineering/CN=wordpress.raeveen.me" \
  -extensions san \
  -config <( \
  echo '[req]'; \
  echo 'distinguished_name=req'; \
  echo '[san]'; \
  echo 'subjectAltName=DNS:localhost,DNS:wordpress.raeveen.me')
```