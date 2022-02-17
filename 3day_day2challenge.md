# Day Two Challenge!

<img align="right" src="https://pbs.twimg.com/media/EZIiT2bXYAELXL6?format=png&name=small" width="300"/>

Let's take some of the topics we learned yesterday and try to apply them! Attempt as many of the challenges below as you care to- we'll review solutions once everyone's had a crack at it!


#### Challenge 1
Make a pod with the following parameters:  
**POD NAME:** `day2challenge`  
**IMAGE:** `nginx`  

#### Challenge 2
Make the same Pod from challenge 1 again, this time in a different namespace.  
**NAMESPACE:** `kube-public`  

#### Challenge 3
Inside *nginx* containers, in the `/etc/nginx` directory, there is a file named `nginx.conf`. Copy that file to your local machine in the `~/static` directory, renaming the local copy as `nginx.conf.old`.  

#### Challenge 4
Add one more feature to a Pod you made (either one) that has an `nginx` image. Add a feature that will kill the container if it doesn't respond fast enough. Here's a method you can use to check its responsiveness:  

```yaml
      exec:
        command:
          - cat
          - /etc/nginx/nginx.conf
```

## SOLUTION

**Challenge 3 command-** `kubectl cp day2challenge:/etc/nginx/nginx.conf ~/static/nginx.conf.old`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: day2challenge
  namespace: kube-public
spec:
  containers:
  - name: nginx
    image: nginx
    livenessProbe:
      initialDelaySeconds: 2 
      periodSeconds: 5    
      timeoutSeconds: 1  
      failureThreshold: 3 
      exec:
        command:
          - cat
          - /etc/nginx/nginx.conf
```
