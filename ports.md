### Three Pods, each with two containers (webby and nginx)
- first pod has CORRECT containerPorts listed
- second pod has NO containerPorts listed
- third pod has INCORRECT containerPorts listed

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: correctports 
spec:
  containers:
  - name: webby
    image: bchd.registry/alta3-webby
    ports:
    - name: web
      containerPort: 8888
      protocol: TCP
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    - containerPort: 443

---
apiVersion: v1
kind: Pod
metadata:
  name: noports 
spec:
  containers:
  - name: webby
    image: bchd.registry/alta3-webby
    # if you include a ports: section, you MUST specify containerport
  - name: nginx
    image: nginx
    
---
apiVersion: v1
kind: Pod
metadata:
  name: wrongports 
spec:
  containers:
  - name: webby
    image: bchd.registry/alta3-webby
    ports:
    - name: web
      containerPort: 6666
      protocol: TCP
  - name: nginx
    image: nginx
    ports:
    - containerPort: 66
    - containerPort: 666
```


### Pod with two containers with identical images

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: twonginx 
spec:
  containers:
  - name: nginx1
    image: nginx
  - name: nginx2
    image: nginx
```
