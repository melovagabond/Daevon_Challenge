#!/bin/bash
sudo su
apt update -y
apt install -y docker.io git
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
usermod -aG docker root

# Download your project's files to the instance
cd /home/ubuntu || return
git clone https://github.com/melovagabond/Daevon_Challenge.git
git pull
cd Daevon_Challenge/website/docker || return
mkdir certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/server.key -out ./certs/server.crt -subj "/C=US/ST=Pennsylvania/L=Philadelphia/O=Daevonlab/OU=R&D/CN=localhost"
chmod -R 777 ./certs/*

# Build and run the Docker container
sudo docker build -t webpage .
sudo docker run -d -p 443:443 --name webpage-container webpage
