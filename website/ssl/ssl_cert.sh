#!/bin/bash

mkdir -p certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./certs/nginx-selfsigned.key \
  -out ./certs/nginx-selfsigned.crt \
  -subj "/C=US/ST=California/L=San Francisco/O=YourCompany/OU=IT Department/CN=example.com"
