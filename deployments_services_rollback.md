# Warmup: Deployments, History, and Services!

<img src="https://preview.redd.it/yet-another-kubernetes-meme-yakm-v0-hohjszejni4b1.jpg?auto=webp&s=3e49dbf75bbfe8ce3ee6bc4d6162f37c7ceaa6e5" alt="image" width="300"/>

Welcome to your **Kubernetes Rollout & Scaling Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Interact with a deployment named **mufasa** in the namespace `king-of-lions`.
2. Use `kubectl` to accomplish tasks related to rollbacks, scaling, and exposing the deployment.

### TASK 1

Run this command to create a deployment called **mufasa** in the namespace `king-of-lions`:

`student@bchd~$:` `drill deploy-rollbacks`

Apparently, the current version is broken. Check the deployment history and rollback to a version that actually works.

---

<details>
  <summary>Hint for Task 1</summary>

  The `kubectl rollout history` and `kubectl rollout undo` commands are what you need here!
  
  </details>

<details>
  <summary>Click here for the solution to Task 1!</summary>

```bash
kubectl rollout history -n king-of-lions deployment mufasa
kubectl rollout undo -n king-of-lions deployment mufasa
```

</details>

---

### TASK 2

Increase the number of pods in the deployment **mufasa** in the namespace `king-of-lions` to 5.

---

<details>
  <summary>Hint for Task 2</summary>

  You can use either `kubectl scale` or `kubectl edit` to get a quick win on this task!
  
  </details>

<details>
  <summary>Click here for the solution to Task 2!</summary>

```bash
kubectl scale -n king-of-lions deployment mufasa --replicas=5
```

OR

```bash
kubectl edit -n king-of-lions deployment mufasa
```
Then find the line:
```yaml
replicas: 2
```
Change `2` to `5`, and save the changes.

</details>

---

### TASK 3

Expose the deployment **mufasa** in the namespace `king-of-lions` with a service! You do not have to write a manifest to accomplish this.

---

<details>
  <summary>Hint for Task 3</summary>
  
  Use the `kubectl expose` command to create a service for the deployment.
  
  </details>

<details>
  <summary>Click here for the solution to Task 3!</summary>

```bash
kubectl expose -n king-of-lions deployment mufasa
```

</details>

---

### Teardown

Remove what you've built!

`student@bchd~$:` `teardown deploy-rollbacks`
