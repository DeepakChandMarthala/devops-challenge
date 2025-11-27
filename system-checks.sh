#!/bin/bash
set -e

NAMESPACE="devops-challenge"
POD=$(kubectl get pod -n $NAMESPACE -o jsonpath="{.items[0].metadata.name}")

# 1. Print UID of the user inside the container
UID=$(kubectl exec -n $NAMESPACE $POD -- id -u)
echo "UID: $UID"

# 2. Show which port the application process is bound to (from pod spec)
PORT=$(kubectl get pod -n $NAMESPACE $POD -o jsonpath="{.spec.containers[*].ports[*].containerPort}")
echo "Port: $PORT"

# 3. Curl request to validate JSON response
kubectl port-forward -n $NAMESPACE $POD 9090:80 >/dev/null 2>&1 &
PF_PID=$!
sleep 2
RESPONSE=$(curl -s http://localhost:9090)
kill $PF_PID >/dev/null 2>&1
echo "Response: $RESPONSE"
