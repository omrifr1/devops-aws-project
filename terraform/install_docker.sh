#!/bin/bash
apt-get update
apt-get install -y docker.io docker-compose python3
systemctl start docker
systemctl enable docker

# יצירת תיקיית האפליקציה
mkdir -p /home/ubuntu/app/html
echo "<h1>DevOps Monitoring Node - Active</h1>" > /home/ubuntu/app/html/index.html

# יצירת קובץ ה-Docker Compose
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

# הפעלת הקונטיינרים
cd /home/ubuntu/app
docker-compose up -d

# יצירת סקריפט הניטור ב-Python
cat <<EOT > /home/ubuntu/monitor.py
import os
import requests
import time

URL = "http://localhost:80"
LOG_FILE = "/home/ubuntu/monitor.log"

def check_health():
    try:
        response = requests.get(URL, timeout=5)
        status = f"{time.ctime()}: Status {response.status_code} - OK\n"
    except:
        status = f"{time.ctime()}: Server DOWN! Restarting...\n"
        os.system("cd /home/ubuntu/app && docker-compose restart web-server")
    
    with open(LOG_FILE, "a") as f:
        f.write(status)

if __name__ == "__main__":
    check_health()
EOT

# הגדרת Cron Job שיריץ את הבדיקה כל דקה
(crontab -l 2>/dev/null; echo "* * * * * /usr/bin/python3 /home/ubuntu/monitor.py") | crontab -