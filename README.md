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
<img width="987" height="555" alt="image" src="https://github.com/user-attachments/assets/2272d419-532c-4d85-b20e-6dda8d4be128" />


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

## Part 4 – Automation (CI/CD)

  a) A GitHub Actions workflow (`.github/workflows/ci.yml`) is configured to automate validation and packaging steps on every push.

### CI Pipeline Tasks:
- Checkout source code
- Python linting using `flake8`
- Helm chart linting
- Terraform syntax validation
- Docker image build
- Docker image push to Docker Hub (optional)

This pipeline ensures that every commit is validated and packaged consistently.

  b) Local Deployment Automation (`setup.sh`)

A local automation script (`setup.sh`) is provided to streamline the full deployment process from a developer machine.

### Script Workflow:
- Build Docker image
- Apply Terraform (namespace + ResourceQuota)
- Deploy Helm chart into EKS cluster with setup.sh

This script ensures reproducibility and simplifies manual deployment steps into a single command.

### Run Locally
```bash
chmod +x setup.sh
./setup.sh
```

## Part 5 – Validation Script (`system-checks.sh`)

A validation script is provided to verify key runtime properties of the deployed application inside the Kubernetes pod.

### Checks Performed:
1. Verify container is running as a non-root user (`UID: 1000`)
2. Confirm which port the application is listening on (from pod spec)
3. Use `curl` via port-forwarding to validate the API response

This script ensures that the container meets security requirements and that the application is reachable and functioning correctly.

### Run Locally
```bash
chmod +x system-checks.sh
./system-checks.sh
```






