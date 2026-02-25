\# AWS Infrastructure \& Automated Monitoring



\## 🎯 Project Overview

Automated deployment of a web server on AWS using Terraform, featuring a self-healing Python monitor.



\## 🛠️ Tech Stack

\- \*\*IaC:\*\* Terraform

\- \*\*Cloud:\*\* AWS (VPC, EC2, IGW, Security Groups)

\- \*\*Containerization:\*\* Docker (Nginx)

\- \*\*Automation:\*\* Python \& Crontab



\## 🏗️ Architecture

1\. \*\*VPC:\*\* Custom 10.0.0.0/16 network.

2\. \*\*Compute:\*\* EC2 (t3.micro) running Ubuntu 22.04.

3\. \*\*Provisioning:\*\* UserData script installs Docker, runs Nginx, and injects a Python health checker.

4\. \*\*Monitoring:\*\* A Cron job triggers `monitor.py` every minute, logging health status to `/home/ubuntu/monitor.log`.



\## 🚀 Quick Start

```powershell

terraform init

terraform apply -auto-approve



