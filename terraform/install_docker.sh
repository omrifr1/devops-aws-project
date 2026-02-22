#!/bin/bash
apt-get update
apt-get install -y docker.io docker-compose
systemctl start docker
systemctl enable docker

mkdir -p /home/ubuntu/app/html
echo "<h1>Build by Terraform - Professional Structure 2026</h1>" > /home/ubuntu/app/html/index.html

cat <<EOT > /home/ubuntu/app/docker-compose.yml
version: '3.8'
services:
  web-server:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - /home/ubuntu/app/html:/usr/share/nginx/html
    restart: always
  portainer:
    image: portainer/portainer-ce:latest
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    restart: always
EOT
sleep 10
cd /home/ubuntu/app
docker-compose up -d