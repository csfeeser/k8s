### CKA Task: Persistent Storage with `hostPath`

<img src="https://miro.medium.com/v2/resize:fit:860/0*ebBbV6um7xCfbEod" width="200"/>



#### Objective

You are required to manually provision persistent storage for a future application deployment. Create a PersistentVolume (PV) using a `hostPath` and a PersistentVolumeClaim (PVC) that claims this volume.

#### Specifications

- **PersistentVolume (PV) Specifications:**
  - Name: `example-pv`
  - Size: `1Gi`
  - Access modes: `ReadWriteOnce`
  - `hostPath` path: `/mnt/data`
  - StorageClass: `manual`

- **PersistentVolumeClaim (PVC) Specifications:**
  - Name: `example-pvc`
  - Size: `1Gi`
  - Access modes: `ReadWriteOnce`
  - StorageClass: `manual`

#### Instructions

1. **Create a PersistentVolume:**
   - Use the provided specifications to create a PV that utilizes `hostPath` for storage.

2. **Create a PersistentVolumeClaim:**
   - Ensure the PVC you create requests storage from the PV you've just defined, matching the size and access modes.

3. **Validate your work:**
   - Verify that your PVC successfully binds to your PV.

#### CHAD TIP:

Storage questions on the CKA and CKAD will be exactly like this one. The secret to success is knowing where EXACTLY on `kubernetes.io` you can find the manifests. That's tricky, because there are several pages on PV/PVCs but only one has the correct manifest.

<details>
<summary>Click here for the correct link!</summary>
<br>
  
[https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

> Search `persistent volume pod` in the Kubernetes docs to get this on the first search result.

</details>

<details>
<summary>Solution</summary>

1. **PersistentVolume YAML (`example-pv.yaml`):**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data
```

2. **PersistentVolumeClaim YAML (`example-pvc.yaml`):**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
```

To apply these configurations, use the `kubectl apply -f <filename>.yaml` command for each YAML file.

</details>
