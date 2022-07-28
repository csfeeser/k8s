# Volumes Challenge!

<img src="https://assets.ubuntu.com/v1/64cf3b1b-now-witness-the-power-of-this-fully-operational-kubernetes-cluster.jpeg" width="300"/>

Let's take some of the concepts we learned yesterday and apply them in some resources of your own creation!

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
    - ReadWriteOnce permission

0. Create a pod named `day4challenge` using an `nginx` image. Mount BOTH the PVC `persistentclaimchallenge` AND configmap `nintendo` into the pod/container. The `mountpath` is up to you, but the Pod status must be `RUNNING` to complete the challenge :)

#### BONUS

Guarantee that this Pod will be scheduled on the same node every time!

<!--
#### SOLUTION

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: day4challenge
spec:
  containers:
  - name: nginx-game
    image: nginx
    volumeMounts:
    - name: game-storage
      mountPath: "/storage"
    - name: game-config
      mountPath: "/data"
  volumes:
  - name: game-storage
    persistentVolumeClaim:
      claimName: persistentclaimchallenge
  - name: game-config
    configMap:
      name: nintendo
```
