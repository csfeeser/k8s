# Volumes Challenge!

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
- Use a `nginx` image
- Mount BOTH the PVC `persistentclaimchallenge` AND configmap `nintendo` into the `day4challenge` Pod
> The `mountPath` location is up to you, but the Pod status must be `RUNNING` to complete the challenge :)

#### SOLUTION

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: day4challenge2
spec:
  containers:
  - name: dontmatter
    image: nginx
    volumeMounts:
      - name: gamer
        mountPath: /japan
      - name: memcard
        mountPath: /data
  volumes:
  - name: gamer
    configMap:
      name: nintendo
  - name: memcard # doesn't matter any name
    persistentVolumeClaim:
      claimName: persistentclaimchallenge
```
