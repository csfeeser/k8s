# InitContainers, Jobs, and Troubleshooting, OH MY!

<img src="https://miro.medium.com/v2/resize:fit:1080/0*w-Uh9CUGWb6dKfpA.jpg" alt="image" width="300"/>

Welcome to your **Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Create a Kubernetes Job manifest.
2. Apply the manifest.
3. Diagnose why the `main-container` is failing to launch in this Job.

### Step 1: Create the Job Manifest

Make the following job manifest.

`student@bchd~$` `vim day7warmup.yml`

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: init-container-failure-job
spec:
  parallelism: 2  # Run 2 pods in parallel
  completions: 4  # Complete 4 pods in total
  template:
    spec:
      initContainers:
      - name: init-fail # initContainers always run FIRST!
        image: busybox
        command: ["sh", "-c", "echo Init container setting up; cp /tmp/file /etc/config"]
      containers:
      - name: main-container
        image: busybox
        command: ["sh", "-c", "echo Main container running; cat /etc/config"]
      restartPolicy: Never
```

Once you’ve written this, go ahead and apply the manifest with:

`student@bchd~$` `kubectl apply -f day7warmup.yml`

Check and see what's running:

`student@bchd~$` `kubectl get pods,jobs`

### Step 2: Troubleshoot Why the `main-container` Is Failing to Launch

Oh no! The job is failing and the `main-container` isn’t launching. 😱 

Use your Kubernetes skills to diagnose the issue and figure out why the `main-container` never starts!

## You don't need to fix the problem, just diagnose what is wrong!

---

### 👀 Hints (For When You Need a Gentle Nudge)

<details>
  <summary>Need a few hints? Click here to reveal!</summary>

  - Try using the `kubectl logs` command.

  <details>
  <summary>Need another hint? Click here to reveal!</summary>
    
  - Remember you need to look at the logs of the correct container! `-c` lets you specify which container.

  <details>
  <summary>Need another hint? Click here to reveal!</summary>
    
  - The `init-fail` container might be trying to perform an operation that’s not possible. What is it trying to do before the main container starts?

</details>
</details>
</details>

---

### 🛠️ Solution (Spoilers Ahead!)

<details>
  <summary>Click here if you want the full solution!</summary>

  - The issue is with the init container. It is trying to copy a file from `/tmp/file` to `/etc/config`, but `/tmp/file` doesn’t exist.
  - Since the init container fails, the `main-container` never gets a chance to run. You can confirm this by checking the logs of the init container:

    ```bash
    kubectl logs job/init-container-failure-job -c init-fail
    ```

    You should see an error related to the `cp` command failing.

</details>
