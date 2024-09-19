#!/bin/bash

# Create the namespace
kubectl create namespace challenge > /dev/null 2>&1

# Create the ServiceAccount
kubectl create serviceaccount challenge-sa -n challenge > /dev/null 2>&1

# Create the Role with basic permissions
cat <<EOF | kubectl apply -f - > /dev/null 2>&1
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: challenge-role
  namespace: challenge
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
EOF

# Create the RoleBinding
cat <<EOF | kubectl apply -f - > /dev/null 2>&1
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: challenge-rolebinding
  namespace: challenge
subjects:
- kind: ServiceAccount
  name: challenge-sa
  namespace: challenge
roleRef:
  kind: Role
  name: challenge-role
  apiGroup: rbac.authorization.k8s.io
EOF

# Output message after successful completion
echo "Lab preparation complete!"
