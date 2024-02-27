# Daily CKA Exam Warmup!
Below are two questions identical to ones you may encounter on the CKA exam! Let us assume the following:
- You completed up to lab 16 yesterday and have multiple nodes in your cluster
- Your cluster was successfully built and allows Pods to be created.
- You kept the default name of the cluster, which is `kubernetes` (use `kubectl config view` to confirm)
- It is TOTALLY legal to use the official [Kubernetes docs](https://kubernetes.io/docs/home/)!

---

### Question 1: Create a Pod with Two Containers

Create a Pod on the cluster `kubernetes` with the following specifications:

- **Pod Name:** `multi-container-pod`
- **Namespace:** `default`
- **Containers:**
  - **Container 1:**
    - Name: `web-container`
    - Image: `nginx:1.23.4`
    - Ports: Expose port `80`
  - **Container 2:**
    - Name: `sidecar-container`
    - Image: `alpine`
    - Command: `["/bin/sh"]`
    - Args: `["-c", "while true; do sleep 3600; done"]`

Ensure that both containers are running within the same Pod. Verify the Pod and both containers are successfully deployed and running.

---

### Question 2: Find Nodes Using a Specific Kubernetes Version and Write to a File

On the cluster named `kubernetes`, perform the following tasks:

1. Identify all nodes running Kubernetes version `1.28.6`.
2. Write the names of the node(s) to a file located at `/tmp/oldnodes.txt` on the machine where you are performing the tasks.

---

**Click the dropdown below for solutions as well as means to check your work!**

<details>
<summary><strong>Solutions</strong></summary>

### Solution to Question 1: Create a Pod with Two Containers

To create the required pod, you can use the following YAML definition. Save this to a file named `multi-container-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
  namespace: default
spec:
  containers:
  - name: web-container
    image: nginx:latest
    ports:
    - containerPort: 80
  - name: sidecar-container
    image: alpine
    command: ["/bin/sh"]
    args: ["-c", "while true; do sleep 3600; done"]
```

Then, apply this configuration to your cluster named `kubernetes` using the following command:

```bash
kubectl apply -f multi-container-pod.yaml
```

Verify the pod and its containers are up and running:

```bash
kubectl get pods multi-container-pod
```

### Solution to Question 2: Find Nodes Using a Specific Kubernetes Version and Write to a File

To find the nodes running Kubernetes version `1.28.6` and write their names to a file, you can use the following commands:

1. First, list all nodes:

`kubectl get nodes`

```
NAME         STATUS   ROLES           AGE   VERSION
controller   Ready    control-plane   23h   v1.28.6
node-1       Ready    <none>          23h   v1.29.2
```

2. No matter how many nodes you created yesterday, the only one with version `1.28.6` is the `controller` node. Write that to the file specified!

`echo "controller" > /tmp/oldnodes.txt`

If you want to get REALLY fancy, we can return the output as JSON and use the `jq` (JSON query) tool and filter them:

```bash
kubectl get nodes -o json | jq '.items[] | select(.status.nodeInfo.kubeletVersion == "v1.28.6") | .metadata.name' > /tmp/oldnodes.txt
```

3. Verify the contents of `/tmp/oldnodes.txt` to ensure it contains the names of the nodes you identified:

```bash
cat /tmp/oldnodes.txt
```

</details>
