# Mini-CKAD Challenge SOLUTIOJN

### Procedure
>Use this page to check your work from your Mini-CKAD challenge! Also available are the answers to each task.

1. Create a new namespace called *challenge*

   **Correctness Check:**
   
    `student@bchd:~$` `kubectl get ns | grep challenge`
   
    ```
    challenge         Active   13m
    ```
    
    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `kubectl create ns challenge` 
    
    </details>
    
0. Create a context named *challenge-context* that uses the following:

        cluster: kubernetes-the-alta3-way
        namespace: challenge
        user: admin

   **Correctness Check:**
   
    `student@bchd:~$` `kubectl config view | grep "name: challenge-context" -B 3`
   
    ```
     cluster: kubernetes-the-alta3-way
     namespace: challenge
     user: admin
    name: challenge-context
    ```
    
    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `kubectl config set-context challenge-context --user=admin --namespace=challenge --cluster=kubernetes-the-alta3-way`
    
    </details>

0. Make *challenge-context* your current context. **ALL OBJECTS SHOULD BE CREATED IN THIS CONTEXT!**

   **Correctness Check:**
   
    *All Pods/Deployments/Services/etc. below are in the challenge namespace.*
    
    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `kubectl config use-context challenge-context`
    
    </details>
    
0. Create a single container pod named *challengepod*. Use an nginx image, version 1.18.0.


    **Correctness Check:**
   
    `student@bchd:~$` `kubectl describe pod challengepod | grep Image:`
    
    ```
        Image:          nginx:1.18.0
    ```
    
    <details>
    <summary>SOLUTION</summary>
   
    `student@bchd:~$` `kubectl run challengepod --image=nginx:1.18.0`
    
    </details>

0. Inspect the pod using the `get` and `describe` commands.

    <details>
    <summary>SOLUTION</summary>

    `student@bchd:~$` `kubectl get pod challengepod`
    
    `student@bchd:~$` `kubectl describe pod challengepod`
    
    </details>
    
0. Output your pod description into a file named `poddesc.txt`. Save it to `/home/student/static/`.

    **Correctness Check:**
    
    `student@bchd:~$` `cat /home/student/static/poddesc.txt`
    
    ```
    [...]
    QoS Class:       BestEffort
    Node-Selectors:  <none>
    Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                     node.kubernetes.io/unreachable:NoExecute for 300s
    Events:
      Type    Reason     Age   From               Message
      ----    ------     ----  ----               -------
      Normal  Scheduled  25m   default-scheduler  Successfully assigned challenge/challengepod to node-1
      Normal  Pulled     25m   kubelet, node-1    Container image "nginx:1.18.0" already present on machine
      Normal  Created    25m   kubelet, node-1    Created container challengepod
      Normal  Started    25m   kubelet, node-1    Started container challengepod
    ```
    
    <details>
    <summary>SOLUTION</summary>

    `student@bchd:~$` `kubectl describe pod challengepod > /home/student/static/poddesc.txt`
    
    </details>
 
0. Convert your the manifest you used to create your Pod in step 4 into a Deployment manifest, then create it. Your deployment must:
    - Be named *challengedeploy*
    - Create 4 replicas.
    - Always be created with the latest version of *nginx*.
    - All pods created by this manifest should be scheduled on node-3.
    - Label the **deployment** with the label *challenge: met*.
    - Annotate the **deployment** with the following:
    
          kubernetes: is
          super: easy
          i: am
          so: awesome

    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `vim deploychallenge.yml`
    
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: challengedeploy
      labels:
        challenge: met
      annotations:
        kubernetes: is
        super: easy
        i: am
        so: awesome
    spec:
      replicas: 4
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          nodeName: node-3
          containers:
          - name: nginx
            image: nginx:1.14.2
            ports:
            - containerPort: 80
    ```

    `student@bchd:~$` `kubectl apply -f deploychallenge.yml`
    
    </details>
    
0. Expose your deployment with a ClusterIP service.

    **Correctness Check:**
    
    `student@bchd:~$` `kubectl get ep challengedeploy`
    
    ```
    YOUR OUTPUT WILL BE DIFFERENT
    NAME              ENDPOINTS                                                           AGE
    challengedeploy   192.168.139.81:80,192.168.139.82:80,192.168.139.83:80 + 1 more...   3s
    ```
    
    - Copy the first /<IP/>:80 in that output.
    
    `student@bchd:~$` `ssh node-1`
    
    `student@node-1:~$` `curl <IP>:80`
    
    ```
    <!DOCTYPE html>                                                                                                              
    <html>                                                                                                                       
    <head>                                                                                                                       
    <title>Welcome to nginx!</title> 
    [...]
    ```
        
    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `kubectl expose deploy challengedeploy`
    
    </details>
     
0. Create a PersistentVolume with the following parameters:
   - 2GB storage
   - name: persistentchallenge
   - storage class: challenge
   - host path: /mnt/data

    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `vim PVchallenge.yml`
   
    ```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: persistentchallenge
      labels:
        type: local
    spec:
      storageClassName: challenge
      capacity:
        storage: 2Gi
      accessModes:
        - ReadWriteOnce
      hostPath:
        path: "/mnt/data"
    ```

    `student@bchd:~$` `kubectl apply -f PVchallenge.yml`
    
    </details>
    
    
   Create a PersistentVolumeClaim with the following parameters:
   - 1GB storage
   - name: persistentclaimchallenge
   - ReadWriteOnce permission

    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `vim PVCchallenge.yml`

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: persistentclaimchallenge
    spec:
      storageClassName: challenge
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi
    ```

    `student@bchd:~$` `kubectl apply -f PVCchallenge.yml`
    
    </details>
    
    Mount this PersistentVolumeClaim into a pod named `storagepodlet` using the image `nginx`.

    <details>
    <summary>SOLUTION</summary>

    
    `student@bchd:~$` `vim storagepodlet.yml`

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: storagepodlet
    spec:
      containers:
        - name: myfrontend
          image: nginx
          volumeMounts:
          - mountPath: "/var/www/html"
            name: mypd
      volumes:
        - name: mypd
          persistentVolumeClaim:
            claimName: persistentclaimchallenge
    ```

    `student@bchd:~$` `kubectl apply -f storagepodlet.yml`
    
    </details>
    
## When you are finished, return to the correct context!

`student@bchd:~$` `kubectl config use-context kubernetes-the-alta3-way`