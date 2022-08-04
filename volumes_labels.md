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
- Use a `busybox:1.35.0` image
- Mount BOTH the PVC `persistentclaimchallenge` AND configmap `nintendo`.
> The `mountPath` location is up to you, but the Pod status must be `RUNNING` to complete the challenge :)
