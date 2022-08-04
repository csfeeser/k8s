# Thursday Morning Warmup!

<img src="https://assets.ubuntu.com/v1/64cf3b1b-now-witness-the-power-of-this-fully-operational-kubernetes-cluster.jpeg" width="300"/>

Let's take some of the concepts we learned and apply them in some resources of your own creation!

1. Create the following file:

    `student@bchd:~$` `vim gameinfo.yml`

    ```
    game: Super Mario Bros.
    publisher: Nintendo
    director: Shigeru Miyamoto
    release: September 13, 1985
    ```

0. Put `gameinfo.yml` inside a configmap named `nintendo`.

0. Create a PersistentVolume with the following parameters:

    - 2GB storage
    - name: `persistentchallenge`
    - storage class: manual
    - host path: /mnt/data

0. Create a PersistentVolumeClaim with the following parameters:

    - 1GB storage
    - name: `persistentclaimchallenge`
    - storage class: manual

0. Create a Pod with the following:
- name the Pod `day4challenge`
- give the Pod the label `k8s: isawesome`
- Use a `nginx` image
- Mount BOTH the PVC `persistentclaimchallenge` AND configmap `nintendo`.
> The `mountPath` location is up to you, but the Pod status must be `RUNNING` to complete the challenge :)

<details>
<summary>SOLUTION</summary>

```yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: persistentchallenge
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"    
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: persistentclaimchallenge
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: day4challenge
  labels:
    k8s: isawesome
spec:
  containers:
    - name: warmup
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/"
        name: mypvc
      - mountPath: "/data"
        name: myconfig
  volumes:
    - name: mypvc
      persistentVolumeClaim:
        claimName: persistentclaimchallenge
    - name: myconfig
      configMap:
        name: nintendo
```
</details>
