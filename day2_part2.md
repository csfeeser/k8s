# Morning Warmup!
<img src="https://media.slid.es/uploads/730082/images/5298631/k8s-meme.jpg" width="300"/>

The following are tasks written as they might appear in the CKAD exam! Remember, the CKAD is notorious for being vague in what specific tools are required to achieve these tasks... so if you'd like a hint about what the task is asking you to do, click the dropdown!

### Task 1
Find which pod in your cluster is consuming the most memory. Write the name of that pod to a file named `/tmp/hogpod.txt`

<details>
<summary>HINT</summary>
<br>

Use the `kubectl top pods` command against all namespaces in the cluster and find which has the highest memory usage!
  
</details>

### Task 2

Create a pod named `ckaddemo` which has two containers- each container should do the following:
- first container:
    - uses the `nginx` image
    - container is only allowed to consume `300m` cpu and `512Mi` memory.
- second container: 
    - uses the `busybox:1.35.0` image
    - container must be guaranteed `300m` cpu.
    - guarantee that this container runs as user `1000`
        > test this with a `kubectl exec -it ckaddemo -- sh` and run a `whoami` command.

<details>
<summary>HINT</summary>
<br>

- container is only allowed to consume `300m` cpu and `512Mi` memory **<-- add a LIMIT**                                                                       
- container must be guaranteed `300m` cpu. **<-- add a REQUEST**
- guarantee that this container runs as user `1000` **<-- add a SECURITY CONTEXT**                                                                           
  
</details>

<!--

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: midday-challenge
spec:
  containers:
  - name: bizzeebox
    image: busybox:1.35.0
    command: [ "sh", "-c", "sleep 1h" ]
    resources:
      requests:
        cpu: 300m
    securityContext:
      runAsUser: 1000
  - name: engine-x
    image: nginx
    resources:
      limits:
        cpu: 300m
        memory: 512Mi
```
-->
