#!/bin/bash

# Define the namespace name
NAMESPACE="warmup"

# Step 1: Create the Kubernetes namespace silently
kubectl create namespace $NAMESPACE >/dev/null 2>&1

# Step 2: Define the ResourceQuota YAML with CPU and Memory limits/requests
cat <<EOF > resourcequota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: cpu-memory-quota
  namespace: $NAMESPACE
spec:
  hard:
    requests.cpu: "2"       # Set CPU request limit to 2 cores
    limits.cpu: "4"         # Set CPU usage limit to 4 cores
    requests.memory: "2Gi"  # Set memory request limit to 2 GiB
    limits.memory: "4Gi"    # Set memory usage limit to 4 GiB
EOF

# Step 3: Apply the ResourceQuota to the namespace silently
kubectl apply -f resourcequota.yaml >/dev/null 2>&1

# Step 4: Clean up the YAML file
rm resourcequota.yaml

# Final output message
echo "Setup successful! Begin your warmup challenge!"
