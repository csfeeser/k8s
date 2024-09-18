# Warmup: Fundamental `kubectl` Commands!

<img src="https://github.com/user-attachments/assets/f389643a-5ccc-4bf1-8181-3338e96898ad" alt="FYhiT-BWAAAA2FB" height="300"/>

Welcome back! This warmup is designed to help you review some **essential** `kubectl` commands. Some experienced Kubernetes folks might find this elementary, but if you're new to Kubernetes, these are **critical** skills worth practicing!

Your goal is to understand and get hands-on practice with the following commands:
- `kubectl apply`
- `kubectl get`
- `kubectl describe`
- `kubectl delete`

**Let's get to it!** 🧑‍💻

---

### Step 1: Verify the Pod Manifest

Our environment already has a pod manifest available. Before we start, let's review what the manifest looks like:

`student@bchd~$` `batcat ~/mycode/yaml/my_first_pod.yaml`

You'll see something like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myfirstpod
spec:
  containers:
  - name: webster
    image: registry.gitlab.com/alta3/webby:latest
```

This manifest defines a pod named **myfirstpod** that runs a container using the image `webby:latest`.

---

### Step 2: Apply the Pod Manifest

First, let's create (or update) the pod using the **apply** command. This will create the pod based on the manifest.

`student@bchd~$` `kubectl apply -f ~/mycode/yaml/my_first_pod.yaml`

#### What if the pod is already running?
- If you’ve already applied this manifest before, you might see something like this:

  ```
  pod/myfirstpod unchanged
  ```

  That’s okay! This means the pod is already running, and the manifest hasn’t changed.

---

### Step 3: Get Basic Info About the Pod

Next, let's check the status of your pod using the **get** command. This will give you a quick overview of your pod's state.

`student@bchd~$` `kubectl get pods`

You should see something like this:

```bash
NAME         READY   STATUS    RESTARTS   AGE
myfirstpod   1/1     Running   0          1m
```

- **STATUS**: This tells you whether the pod is running, pending, or failed.
- **RESTARTS**: Number of times the pod has restarted (due to failures, etc.).

---

### Step 4: Describe the Pod in Detail

To see a detailed breakdown of what's happening with your pod, use the **describe** command.

`student@bchd~$` `kubectl describe pod myfirstpod`

This will give you loads of info, including:
- Pod events
- Container statuses
- Resource usage

Look for the **Events** section to see how Kubernetes is managing your pod.

---

### Step 5: Get Pod Logs

To view the logs produced by the container inside your pod, use the **logs** command:

`student@bchd~$` `kubectl logs myfirstpod`

This will display any output the container has generated. Super handy for debugging!

---

### Step 6: Delete the Pod

Let’s clean up our environment by deleting the pod using the **delete** command:

`student@bchd~$` `kubectl delete pod myfirstpod`

You should see something like:

```bash
pod "myfirstpod" deleted
```

This removes the pod, but don't worry—you can always reapply the manifest if you need to bring it back!

---

### Bonus Commands!

Here are a couple of other useful commands you should practice:

#### Get All Resources in a Namespace:

`student@bchd~$` `kubectl get all`

This shows all resources (pods, services, deployments, etc.) running in the current namespace.

#### Explain a Kubernetes Resource:
If you ever need a quick refresher on what a resource does, use **explain**!

`student@bchd~$` `kubectl explain pod`

This will give you a summary of what a pod is and what fields you can define in its manifest.

---

### Conclusion

Boom! 💥 You've just gone through the basics of working with `kubectl`. Whether you're applying, getting, describing, or deleting, mastering these commands is **key** to managing Kubernetes like a pro!
