# WARMUP: Make a Pod!

<img src="https://miro.medium.com/v2/resize:fit:800/0*0tk3EgSA2cJI3oPg.jpg" alt="Description of the image">

The following are tasks written as they might appear in the CKAD exam! Remember, the CKAD is notorious for being vague in what specific tools are required to achieve these tasks... so if you'd like a hint about what the task is asking you to do, click the dropdown!

### Task 1
Find which pod in your cluster is consuming the most memory. Write the name of that pod to a file named `/tmp/hogpod.txt`

<details>
<summary>HINT</summary>
<br>

Use the `kubectl top pods` command against all namespaces in the cluster and find which has the highest memory usage!
  
</details>

### Task 2

1. Create a pod to the following specs!

  - IMAGE: `registry.gitlab.com/alta3-instructor/tmnt`
  - POD NAME: `warmup-pod`
  - CONTAINER PORT: `5055`
  - CONTAINER NAME: `pizzaparty`

2. Confirm that your pod is running with a `kubectl get pod warmup-pod` command! It should be in a RUNNING state! (if it is in a `ContainerCreating` state try again in a few seconds)

0. When the pod is running, run this command: `kubectl port-forward warmup-pod 2224:5055 --address=0.0.0.0`

0. Then open `aux1`! You can also add `/tmnt` and `/splinter` to the end of the aux1 address bar to see different pages.

<details>
<summary>SOLUTION</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: warmup-pod
spec:
  containers:
    - name: pizzaparty
      image: registry.gitlab.com/alta3-instructor/tmnt
      ports:
        - containerPort: 5055
```

</details>
