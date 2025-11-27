# DevOps Challenge – End-to-End Implementation

This repository contains the complete implementation of the DevOps Challenge, including:

✔ Dockerization  
✔ Kubernetes Namespace & ResourceQuota (Terraform)  
✔ Helm Deployment  
✔ GitHub Actions CI Pipeline  
✔ Local Setup Automation Script  
✔ Deployment Validation Script  

Each requirement from the challenge document is implemented exactly and cleanly.

## Part 1 – Containerization (Docker)

A simple Python application is containerized using a Dockerfile.

### Build Docker Image Locally
```bash
docker build -t devops-challenge:latest .
```
## Run Application Locally

```bash
docker run -p 8080:80 devops-challenge:latest
```

