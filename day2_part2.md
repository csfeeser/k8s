# MID-DAY MINI CHALLENGE:

![Image description](https://media.slid.es/uploads/730082/images/5298631/k8s-meme.jpg)

### Part 1
Find which pod in your cluster is consuming the most resources. Output the results of kubectl describe to a file named hogpod.txt

EX:
`kubectl describe PODNAME -n NAMESPACE > ~/hogpod.txt`

### Part 2
Create a pod which possesses the following:

- has both containers:
  ```yaml
    - name: bizzeebox
      image: busybox:1.35.0
      command: [ "sh", "-c", "sleep 1h" ]
    - name: engine-x
      image: nginx
  ```
- `engine-x` is only allowed to consume `300m` cpu and `512Mi` memory.
- `bizzeebox` should be guaranteed `300m` cpu.
- Guarantee that `bizzeebox` runs all processes as user `1000`.

<details>
<summary>Solution:</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: midday-oops
spec:
  containers:
  - name: nginx   # first container
    image: nginx
    resources:
      limits: # nginx is only allowed to consume 300m cpu and 512Mi memory.
        cpu: "300m"
        memory: "512Mi"
    securityContext: # Guarantee that nginx runs all processes as user 0 (root).
      runAsUser: 0
  - name: webby   # second container
    image: registry.gitlab.com/alta3research/webby
    resources:
      requests: # webby should be guaranteed 300m cpu.
        cpu: "300m"
```
</details>
