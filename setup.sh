#!/bin/bash
set -e  # stop on any error


LOCAL_IMAGE="devops-challenge:local"   # for challenge requirement only
REMOTE_IMAGE="deepakchandmarthala/devops-challenge:latest"
NAMESPACE="devops-challenge"
RELEASE_NAME="devops-app"
CHART_PATH="helm/devops-app"

echo "🔧 Step 1: Build the Docker image locally (challenge requirement)"
docker build -t "$LOCAL_IMAGE" .

echo "Step 2: Initialize and apply Terraform"
cd terraform
terraform init -backend=false
terraform apply -auto-approve
cd ..

echo "Step 3: Updating Helm chart with Docker Hub image"
# This ensures Helm uses Docker Hub image for EKS deployment
helm upgrade --install "$RELEASE_NAME" "$CHART_PATH" \
  -n "$NAMESPACE" \
  --set image.repository="deepakchandmarthala/devops-challenge" \
  --set image.tag="latest"

echo "Application deployed to EKS!"
echo "Check resources with:"
echo "kubectl get pods -n $NAMESPACE"
echo "kubectl get svc -n $NAMESPACE"
