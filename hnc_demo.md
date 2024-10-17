### **Demo Preview:**

In this demo, we'll walk through the process of setting up **Hierarchical Namespaces** in Kubernetes, organizing namespaces into parent-child relationships, and applying **NetworkPolicies** across those namespaces. You'll learn how to:
1. Install the **Hierarchical Namespace Controller (HNC)**.
2. Create a parent namespace and child namespaces.
3. Apply a **NetworkPolicy** in the parent namespace.
4. Configure HNC to propagate that policy to child namespaces.
5. Verify that the policy was successfully applied to all related namespaces.

### **Step 1: Install Hierarchical Namespace Controller (HNC)**

First, install the **Hierarchical Namespace Controller** to manage parent-child relationships between namespaces:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/hierarchical-namespaces/main/manifests/hnc-manager.yaml
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
kubectl create namespace acme-org
```

#### 3.2 Create Child Namespaces:

```bash
kubectl create namespace team-a
kubectl create namespace service-1
```

### **Step 4: Set Parent-Child Relationships**

#### 4.1 Set `acme-org` as the Parent of `team-a`:

```bash
kubectl hns set team-a --parent acme-org
```

#### 4.2 Set `team-a` as the Parent of `service-1`:

```bash
kubectl hns set service-1 --parent team-a
```

Verify the hierarchy:

```bash
kubectl hns tree acme-org
```

You should see:

```
acme-org
└── team-a
    └── service-1
```

### **Step 5: Apply NetworkPolicy in Parent Namespace**

We will apply a NetworkPolicy in the `acme-org` namespace and propagate it to the child namespaces.

#### 5.1 Create NetworkPolicy in `acme-org`:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-ip-block
  namespace: acme-org
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
kubectl annotate networkpolicy allow-from-ip-block hnc.x-k8s.io/propagate=true -n acme-org
```

### **Step 7: Verify Propagation to Child Namespaces**

Check if the NetworkPolicy has been propagated to `team-a` and `service-1`:

```bash
kubectl get networkpolicies -n team-a
kubectl get networkpolicies -n service-1
```

If successful, the NetworkPolicy should be visible in both namespaces.

---

### **Summary**

In this demo, we:
1. Installed the **Hierarchical Namespace Controller (HNC)**.
2. Created a **parent-child hierarchy** of namespaces.
3. Applied a **NetworkPolicy** in the parent namespace (`acme-org`).
4. Configured HNC to propagate the policy to child namespaces (`team-a` and `service-1`).
5. Verified that the **NetworkPolicy** was successfully propagated to the child namespaces.

This setup helps you apply and manage network and security policies across multiple namespaces more easily.
