# Deployment Challenge

Below is a malfunctioning deployment manifest! Do your best to get it working!

```yaml
apiVersion: v1
kind: deployment
metadata:
  name: challenge
  labels:
    app=nginx
spec:
selector:
    matchLabels:
      app: nginx
replicas: 3
template:
    metadata:
    spec:
      containers:
      - name: nginx
      image: nginxx:1.18.0
      ports:
      - containerPort: 80
```
