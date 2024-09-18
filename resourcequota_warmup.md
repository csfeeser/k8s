# Warmup!

<img src="https://github.com/user-attachments/assets/961814d0-49d7-402d-9c16-04dc6c29bb38" alt="image" width="300"/>

Welcome to your **Day 3 Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Download and execute a script that sets up everything you need for this lab.
2. Create the Pod manifest below...
3. Figure out why your pod isn’t being created in the `warmup` namespace!

### Step 1: Grab that Setup Script
Run the following single command to download and execute the setup script:

`student@bchd~$` `cd && wget https://raw.githubusercontent.com/csfeeser/k8s/master/resources/rqwarmupsetup.sh -O - | bash`

### Step 2: Create Your Pod Manifest

Make the following pod.

`student@bchd~$` `vim day3warmup.yml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: warmup-pod
  namespace: warmup
spec:
  containers:
  - name: warmup-container
    image: nginx
    resources:
      requests:
        cpu: "500m"  # Requesting 0.5 cores
      limits:
        cpu: "1"     # Limiting to 1 core
```

Once you’ve written this, go ahead and apply the manifest with:

`student@bchd~$` `kubectl apply -f day3warmup.yml`

### Step 3: Troubleshoot Why the Pod Isn’t Being Created

Oh no! The pod isn’t being created. 😱 

But wait—don’t panic! This is your time to shine and troubleshoot like a Kubernetes guru. There's a reason the pod isn’t being allowed to run. What could it be?

Read the error message you received! Use the power of `kubectl describe ns warmup` to figure out what’s happening. You got this!

---

### 👀 Hints (For When You Need a Gentle Nudge)

<details>
  <summary>Need a few hints? Click here to reveal!</summary>

  - Could it be that the namespace has specific resource constraints you need to meet?
  - Did you set ALL the requests and limits you need in your pod manifest?

</details>

---

### 🛠️ Solution (Spoilers Ahead!)

<details>
  <summary>Click here if you want the full solution!</summary>

  - The issue is likely caused by the `ResourceQuota` set on the `warmup` namespace. The quota enforces both CPU **and memory** limits, but your pod manifest only has CPU requests and limits.
  - Since no memory requests/limits are specified in your pod manifest, it conflicts with the resource quota. To fix this, update your pod manifest to include memory requests and limits:

    ```yaml
    resources:
      requests:
        cpu: "500m"
        memory: "256Mi"
      limits:
        cpu: "1"
        memory: "512Mi"
    ```

    Once you’ve updated the pod manifest, run `kubectl apply -f day3warmup.yml` again, and the pod should be created successfully.
</details>
