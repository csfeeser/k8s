## Kubectl Warm-Up

<img src="https://github.com/user-attachments/assets/03f68d03-05f6-4792-b6ee-c19d55308a9c" alt="meme" width="300"/>

Welcome to today's Kubernetes warm-up challenge! In this lab, you'll be tasked with writing specific `kubectl` commands to complete each of the following tasks. You'll need to complete them in order. Use the solution drop-down if you're unsure what to do, OR check out the official [Kubernetes.io Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)!

### Task 1: Create a Pod
Your first task is to write a `kubectl run` command that creates a new pod using the `nginx` image. The pod should be named `warmup-pod`.

<details>
<summary>Solution</summary>

```bash
kubectl run warmup-pod --image=nginx
```

</details>

### Task 2: Verify the Pod Exists
Write a `kubectl` command that lists all the pods in your current namespace to confirm that `warmup-pod` exists.

<details>
<summary>Solution</summary>

```bash
kubectl get pods
```

</details>

### Task 3: Delete the Warmup Pod
Write a `kubectl` command to delete the `warmup-pod` you just created.

<details>
<summary>Solution</summary>

```bash
kubectl delete pod warmup-pod
```

</details>

### Task 4: List the Nodes in Your Cluster
Write a `kubectl` command to list all the nodes in your Kubernetes cluster.

<details>
<summary>Solution</summary>

```bash
kubectl get nodes
```

</details>

### Task 5: CKA-Level Challenge: Extract and Save the Controller Node's Version Number
This is a CKA-level challenge, which goes to show that some tasks on the exam are very short. Using the output from the previous task, find the version number of your controller node. Then, write this version number to a file located at `/tmp/controllerversion.txt`.

<details>
<summary>Solution</summary>

If I were completing this task on the exam, this is what I would do:

```bash
kubectl get nodes

echo "1.30.4" > /tmp/controllerversion.txt
```

If I had infinite time to do the exam and had every resource available to me (you won't, of course) I would do this:

```bash
kubectl get nodes -o=jsonpath='{.items[0].status.nodeInfo.kubeletVersion}' > /tmp/controllerversion.txt
```

</details>

---

This format allows students to attempt each task on their own before revealing the correct command.
