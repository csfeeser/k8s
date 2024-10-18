# Hierarchical Namespaces Demo

Let's see what it takes to set up **Hierarchical Namespaces** in Kubernetes, organizing namespaces into parent-child relationships, and applying **NetworkPolicies** across those namespaces. This is what we're going to accomplish in this demo:

1. Install the **Hierarchical Namespace Controller (HNC)**.
2. Create a parent namespace and child namespaces.
3. Apply a **NetworkPolicy** in the parent namespace.
4. Configure HNC to propagate that policy to child namespaces.
5. Verify that the policy was successfully applied to all related namespaces.

### **Step 1: Install Hierarchical Namespace Controller (HNC)**

First, install the **Hierarchical Namespace Controller** to manage parent-child relationships between namespaces:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/hierarchical-namespaces/releases/download/v1.1.0-rc2/default.yaml
```

Verify that HNC is running:

```bash
kubectl get pods -n hnc-system
```

You should see the `hnc-controller-manager` pod running.

### **Step 2: Install `kubectl-hns` Plugin**

You'll need the `kubectl-hns` plugin to use HNC commands. To install it, follow these steps:

#### 2.1 Install Krew (Plugin Manager):

```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

Add krew to your `PATH`:

```bash
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

#### 2.2 Install `kubectl-hns` Plugin:

```bash
kubectl krew install hns
```

Verify that the plugin is installed:

```bash
kubectl hns
```

### **Step 3: Create Parent and Child Namespaces**

#### 3.1 Create Parent Namespace:

```bash
kubectl create namespace grandparent-ns
```

#### 3.2 Create Child Namespaces:

```bash
kubectl create namespace parent-ns
kubectl create namespace child-ns
```

### **Step 4: Set Parent-Child Relationships**

#### 4.1 Set `grandparent-ns` as the Parent of `parent-ns`:

```bash
kubectl hns set parent-ns --parent grandparent-ns
```

#### 4.2 Set `parent-ns` as the Parent of `child-ns`:

```bash
kubectl hns set child-ns --parent parent-ns
```

Verify the hierarchy:

```bash
kubectl hns tree grandparent-ns
```

You should see:

```
grandparent-ns
└── parent-ns
    └── child-ns
```

### **Step 5: Apply NetworkPolicy in Parent Namespace**

We will apply a NetworkPolicy in the `grandparent-ns` namespace and propagate it to the child namespaces.

#### 5.1 Create NetworkPolicy in `grandparent-ns`:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grandparent-netpol
  namespace: grandparent-ns
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.16.0.0/16
```

Save this as `networkpolicy.yaml` and apply it:

```bash
kubectl apply -f networkpolicy.yaml
```

### **Step 6: Propagate NetworkPolicy to Child Namespaces**

By default, HNC does not propagate **NetworkPolicies**. We need to configure it to do so.

#### 6.1 Configure HNC to Propagate NetworkPolicies:

```bash
kubectl hns config set-resource networkpolicies --mode Propagate
```

#### 6.2 Annotate the NetworkPolicy for Propagation:

```bash
kubectl annotate networkpolicy grandparent-netpol hnc.x-k8s.io/propagate=true -n grandparent-ns
```

### **Step 7: Verify Propagation to Child Namespaces**

Check if the NetworkPolicy has been propagated to `parent-ns` and `child-ns`:

```bash
kubectl get networkpolicies -n parent-ns
kubectl get networkpolicies -n child-ns
```

If successful, the NetworkPolicy should be visible in both namespaces!
