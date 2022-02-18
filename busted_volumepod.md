# Busted Pod Challenge!

<img src="https://thumbs.dreamstime.com/b/green-pea-pod-broken-half-fresh-four-peas-pure-white-background-genus-pisum-sativum-garden-48834097.jpg" width="200"/>

> It's a "broken pod"... get it?


Below is a familiar looking Pod manifest... you used this when creating a Pod with an `nginx` image and three mounted configmaps yesterday. However, it is now riddled with errors!... the type of errors that are very common and you're likely to encounter :) 


**Are you unsure if you have the correct configmaps from yesterday?**  
Just create the following bash script and then execute it.  

`student@bchd:~$` `vim cmsetup.sh`  

```bash
kubectl delete cm --all

wget https://static.alta3.com/projects/k8s/nginx.conf.final -O ~/nginx.conf
wget https://static.alta3.com/projects/k8s/index.html2 -O ~/index.html
echo "It was a bright cold day in April, and the clocks were striking thirteen." > nginx.txt

kubectl create configmap nginx-txt --from-file=nginx.txt
kubectl create configmap nginx-conf --from-file=nginx.conf
kubectl create configmap index-file --from-file=index.html
```

Save and quit.

`student@bchd:~$` `bash cmsetup.sh`  

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
    image: nginxx:1.18.0
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
