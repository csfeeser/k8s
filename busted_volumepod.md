# Busted Pod Challenge!

<img src="https://thumbs.dreamstime.com/b/green-pea-pod-broken-half-fresh-four-peas-pure-white-background-genus-pisum-sativum-garden-48834097.jpg" width="200"/>

> It's a "broken pod"... get it?


Below is a familiar looking Pod manifest... you used this when creating a Pod with an `nginx` image and three mounted configmaps yesterday. However, it is now riddled with errors!... the type of errors that are very common and you're likely to encounter :) 


**Copy/paste the entire block of commands below and paste them to your command line.**  

```bash
kubectl delete cm --all
kubectl config use-context kubernetes-the-alta3-way
wget https://static.alta3.com/projects/k8s/nginx.conf.final -O nginx.conf
wget https://static.alta3.com/projects/k8s/index.html2 -O index.html
echo "It was a bright cold day in April, and the clocks were striking thirteen." > nginx.txt
kubectl delete cm --all
kubectl create configmap nginx-txt --from-file=nginx.txt
kubectl create configmap nginx-conf --from-file=nginx.conf
kubectl create configmap index-file --from-file=index.html
```

Do your best to find and fix all the errors before creating this Pod! You cannot claim success until the *STATUS* of the container says *Running*!

```yaml
---
apiVersion:v1
kind: pod
metadata:
  name: nginx-configured
spec:
  containers:
  - name: nginx
    image: nnginx:1.18.0
    ports:
    - containerPort: 80
    volumeMounts: 
    - name: garfield
      mountPath: /etc/nginx/nginx.conf
    - name: odie
      mountPath: /var/www/index.html
      subPath: index.html
    - name: jon
      mountPath: /var/www/static/nginx.txt
      subPath: nginx.txt
  volumes:
  - name: garfield
    configMap:
      name: nermal-conf 
  - name: odie
    configMap:
      name: index-file 
  - name: jon
    configMap:
      name: nginx-txt
```


<details>
<summary>error: error parsing trial.yml: error converting YAML to JSON: yaml: line 2: mapping values are not allowed in this context</summary>
<br>
Put a space before v1.
</details>

<details>
<summary>Error from server (BadRequest): error when creating "trial.yml": pod in version "v1" cannot be handled as a Pod: no kind "pod" is registered for version "v1" in scheme "k8s.io/kubernetes/pkg/api/legacyscheme/scheme.go:30"</summary>
<br>
capitalize "P" in Pod
</details>

<details>
<summary>MountVolume.SetUp failed for volume "garfield" : configmap "nermal-conf" not found</summary>
<br>
line 23 should be nginx-conf not nermal-conf
</details>

<details>
<summary>Failed to pull image "nnginx:1.18.0": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/library/nnginx:1.18.0"</summary>
<br>
Typo in the image name! Should be nginx:1.18.0
</details>

<details>
<summary>Error: failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error mounting "/var/lib/kubelet/pods/ac124c92-65d1-4a5e-a193-7d36b8840ff5/volumes/kubernetes.io~configmap/garfield" to rootfs at "/etc/nginx/nginx.conf"
</summary>
<br>
The garfield volume's mountPath is /etc/nginx/, which overwrites EVERYTHING in that directory! Add a subpath.
</details>


# SOLUTION

```yaml
---
apiVersion: v1 # put a whitespace after :
kind: Pod # capitalize kind!
metadata:
  name: nginx-configured
spec:
  containers:
  - name: nginx
    image: nginx:1.18.0 # typo in image name caused ErrImgPull
    ports:
    - containerPort: 80
    volumeMounts: 
    - name: garfield
      mountPath: /etc/nginx/nginx.conf
      subPath: nginx.conf # needs subpath!
    - name: odie
      mountPath: /var/www/index.html
      subPath: index.html
    - name: jon
      mountPath: /var/www/static/nginx.txt
      subPath: nginx.txt
  volumes:
  - name: garfield
    configMap:
      name: nginx-conf # wrong configmap name!
  - name: odie
    configMap:
      name: index-file 
  - name: jon
    configMap:
      name: nginx-txt
```
-->
