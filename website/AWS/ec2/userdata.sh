#!/bin/bash
sudo apt update -y
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Download your project's files to the instance
sudo apt install -y git
git clone https://github.com/melovagabond/Daevon_Challenge.git
cd Daevon_Challenge/website/docker || return

# Build and run the Docker container
sudo docker build -t webpage .
sudo docker run -d -p 8080:80 --name webpage-container webpage
mkdir /certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/server.key -out /certs/server.crt -subj "/C=US/ST=Pennsylvania/L=Philadelphia/O=Daevonlab/OU=R&D/CN=localhost"
