## Kubectl Get Challenges!

#### Cheat Sheet

| Command / Option            | Description                                                                                         |
|-----------------------------|-----------------------------------------------------------------------------------------------------|
| `kubectl get pods`          | Lists all pods in the namespace.                                                                    |
| `-n <namespace>`            | Specifies the namespace to look in.                                                                 |
| `--all-namespaces`          | Lists resources in all namespaces.                                                                  |
| `-l <label>=<value>`        | Filters resources by label.                                                                         |
| `-o wide`                   | Outputs in wide format, including additional information like node name and IP addresses.           |
| `-o yaml`                   | Outputs the resource information in YAML format, useful for seeing configurations including labels.|
| `--show-labels`             | Shows all labels of listed resources.                                                               |
| `kubectl get daemonset`     | Lists all daemonsets in the namespace.                                                              |
| `kubectl get deployment`    | Lists all deployments in the namespace.                                                             |
| `kubectl get rs`            | Lists all ReplicaSets in the namespace.                                                             |

### Challenge 1: List all pods in the `default` namespace that are running.

<details>
<summary>Solution</summary>

```bash
kubectl get pods -n default --field-selector=status.phase=Running
```

</details>

### Challenge 2: Find the pod in the `kube-system` namespace that is associated with `kube-dns`.

<details>
<summary>Solution</summary>

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns
```

</details>

### Challenge 3: Display all Calico-related pods across all namespaces and include their IP addresses.

<details>
<summary>Solution</summary>

```bash
kubectl get pods --all-namespaces -o wide -l k8s-app=calico-node
```

</details>

### Challenge 4: Identify all resources (pods, services, daemonsets, deployments, replicasets) in the `kube-system` namespace associated with Calico.

<details>
<summary>Solution</summary>

```bash
kubectl get pods,svc,daemonset,deployment,rs -n kube-system -l k8s-app=calico-node
```

</details>

### Challenge 5: Show the `kube-dns` service details, including its labels.

<details>
<summary>Solution</summary>

```bash
kubectl get service kube-dns -n kube-system -o yaml
```

</details>
