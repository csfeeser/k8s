# MID-DAY MINI CHALLENGE:

![Image description](https://media.slid.es/uploads/730082/images/5298631/k8s-meme.jpg)

### Part 1
Find which pod in your cluster is consuming the most resources. Output the results of kubectl describe to a file named hogpod.txt

EX:
`kubectl describe PODNAME -n NAMESPACE > ~/hogpod.txt`

### Part 2
Create a pod which possesses the following:

- has TWO containers: one with `nginx` and one with `bchd.registry/alta3-webby` as the images
- `nginx` is only allowed to consume `300m` cpu and `512Mi` memory.
- `webby` should be guaranteed `300m` cpu.
- Guarantee that `nginx` runs all processes as user `1000`.
