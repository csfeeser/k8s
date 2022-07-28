# Volumes and Deployments Challenge!

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
    - ReadWriteOnce permission

0. Create a deployment named `day4challenge` using an `nginx` image. Mount BOTH the PVC `persistentclaimchallenge` AND configmap `nintendo` into the pods of the `day4challenge` deployment. The `mountPath` location is up to you, but the Pod status must be `RUNNING` to complete the challenge :)

#### SOLUTION

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: day4challenge
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.18.0
        ports:
        - containerPort: 80
        volumeMounts:
          - name: snes
            mountPath: /data
          - name: memcard
            mountPath: /storage
      volumes:
      - name: snes
        configMap:
          name: nintendo
      - name: memcard
        persistentVolumeClaim:
          claimName: persistentclaimchallenge
```
