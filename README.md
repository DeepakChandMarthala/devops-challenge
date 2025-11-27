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

## Part 2 – Infrastructure (Terraform)

Using Terraform, a namespace and memory ResourceQuota are created inside the Kubernetes cluster.

### Resources Created
- Namespace: `devops-challenge`
- ResourceQuota: memory limited to `512Mi`

### 🛠 Terraform Commands
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

## Part 3 – Deployment (Helm)

As per the challenge requirements, we created a Helm chart to deploy the Dockerized application into the `devops-challenge` namespace.

### Helm Chart Includes:
- `Chart.yaml` → Helm metadata
- `values.yaml` → Image tag, replica count, and security context values
- `templates/deployment.yaml` → Kubernetes Deployment manifest
- `templates/service.yaml` → Kubernetes Service manifest

The required `securityContext` configuration (non-root user, read-only root filesystem) is embedded directly inside the `deployment.yaml` under the container spec, and its values are parameterized via `values.yaml`.



