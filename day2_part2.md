# MID-DAY MINI CHALLENGE:

![Image description](https://media.slid.es/uploads/730082/images/5298631/k8s-meme.jpg)

### Part 1
Find which pod in your cluster is consuming the most resources. Output the results of kubectl describe to a file named hogpod.txt

EX:
`kubectl describe PODNAME -n NAMESPACE > ~/hogpod.txt`

### Part 2
Create a pod which possesses the following:

- has TWO containers: one with `nginx` and one with `registry.gitlab.com/alta3research/webby` as the images
- `nginx` is only allowed to consume `300m` cpu and `512Mi` memory.
- `webby` should be guaranteed `300m` cpu.
- Guarantee that `nginx` runs all processes as user `1000`.

<!--
### Solution (thanks to Jared)

```
  1 apiVersion: v1
  2 kind: Pod
  3 metadata:
  4   name: midday-oops
  5 spec:
  6   securityContext:
  7     runAsUser: 1000
  8   containers:
  9   - name: nginx
 10     image: nginx
 11     resources:
 12       limits:
 13         cpu: "300m"
 14         memory: "512Mi"
 15   - name: webby
 16     image: bchd.registry/alta3-webby
 17     resources:
 18       requests:
 19         cpu: "300m"
```
