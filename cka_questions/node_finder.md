# Daily CKA Exam Warmup!
Below is a question identical to ones you may encounter on the CKA exam! Let us assume the following:
- You completed up to lab 20 yesterday and have multiple `Ready` nodes in your cluster.
---

### Task 1: Find Nodes Using a Specific Kubernetes Version and Write to a File

Perform the following tasks:

1. Execute the following command: `kubectl config use-context kubernetes-admin@kubernetes`
    - You don't know why we're doing this yet, but ALWAYS DO THIS WITH EVERY CKA QUESTION! 
0. Identify all nodes running Kubernetes version `1.29.3`.
0. Write the names of the node(s) to a file located at `/tmp/oldnodes.txt` on the machine where you are performing the tasks.

---

**Click the dropdown below for solutions as well as means to check your work!**

<details>
<summary><strong>Solutions</strong></summary>
To find the nodes running Kubernetes version `1.29.3` and write their names to a file, you can use the following commands:

1. First, list all nodes:

`kubectl get nodes`

```
NAME         STATUS   ROLES           AGE   VERSION
controller   Ready    control-plane   23h   v1.29.3
node-1       Ready    <none>          23h   v1.29.3
node-2       Ready    <none>          23h   v1.29.3
```

2. If you didn't upgrade the controller node yesterday, it should still be 1.28.6. Anyway, write the names of all three nodes to the file specifed!

`vim /tmp/oldnodes.txt`

```
controller
node-1
node-2
```

3. Verify the contents of `/tmp/oldnodes.txt` to ensure it contains the names of the nodes you identified:

`cat /tmp/oldnodes.txt`

</details>
