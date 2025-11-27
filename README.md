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

<img width="981" height="552" alt="image" src="https://github.com/user-attachments/assets/ac803972-7c9e-43ca-b5a5-041877df1b6d" />

<img width="1008" height="567" alt="image" src="https://github.com/user-attachments/assets/fc2ae70b-1f32-4112-ab1c-a8dd5c62de7c" />




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

### Installed kubectl and eksctl on my laptop to communicate with cluster from local itself.
<img width="964" height="542" alt="image" src="https://github.com/user-attachments/assets/836978a4-aec6-410e-8716-9d55b56d6371" />

### creating cluster
<img width="1020" height="574" alt="image" src="https://github.com/user-attachments/assets/fe56a118-0a32-4ea3-b2aa-581ae0bd617a" />

<img width="1027" height="577" alt="image" src="https://github.com/user-attachments/assets/503cac82-e7be-4d7a-9357-bbaf1489063d" />

<img width="1044" height="587" alt="image" src="https://github.com/user-attachments/assets/c708551b-b259-455e-aa78-473a738236d8" />

### creating namespace with Terraform script

<img width="1014" height="570" alt="image" src="https://github.com/user-attachments/assets/a6129d90-1eab-41ff-9446-49d5db347006" />


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

### Pipeline Successful, ran checks, then built and pushed image to docker hub
<img width="1040" height="467" alt="image" src="https://github.com/user-attachments/assets/5e617648-b1ed-4737-ae93-7e2dd208f341" />

<img width="1035" height="582" alt="image" src="https://github.com/user-attachments/assets/5ff226cd-d168-48c7-8bb9-4f919e4b4d63" />


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
<img width="1010" height="568" alt="image" src="https://github.com/user-attachments/assets/d5d50b1f-ffad-41ac-9d2c-9aef6faf0464" />

<img width="1125" height="632" alt="image" src="https://github.com/user-attachments/assets/23c255ba-d16a-4ec0-879b-6a45cd8fa4d0" />

<img width="1125" height="632" alt="image" src="https://github.com/user-attachments/assets/ca425fe6-9746-4031-bf78-7fb7f2915a83" />

<img width="1125" height="632" alt="image" src="https://github.com/user-attachments/assets/ace96c15-fd39-4612-8076-1b2facc3298a" />





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

<img width="1125" height="632" alt="image" src="https://github.com/user-attachments/assets/1d5b588a-55c7-46ec-be26-ad12d2330e7a" />

<img width="1125" height="632" alt="image" src="https://github.com/user-attachments/assets/2699ef28-66e6-474d-bb14-dc93bd62577e" />









