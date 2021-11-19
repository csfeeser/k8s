# Mini-CKAD Challenge SOLUTION

### Procedure
>Use this page to check your work from your Mini-CKAD challenge! Also available are the answers to each task.

1. Create a new namespace called *challenge*

   **Correctness Check:**
   
    `student@bchd:~$` `kubectl get ns | grep challenge`
   
    ```
    challenge         Active   13m
    ```
    
    <details>
    <summary><b>SOLUTION</b></summary>

    
    `student@bchd:~$` `kubectl create ns challenge` 
    
    </details>
    
   --------------------------------------- 
   
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
    <summary><b>SOLUTION</b></summary>

    
    `student@bchd:~$` `kubectl config set-context challenge-context --user=admin --namespace=challenge --cluster=kubernetes-the-alta3-way`
    
    </details>

   ---------------------------------------
   
0. Make *challenge-context* your current context. **ALL OBJECTS SHOULD BE CREATED IN THIS CONTEXT!**

   **Correctness Check:**
   
    *All Pods/Deployments/Services/etc. below are in the challenge namespace.*
    
    <details>
    <summary><b>SOLUTION</b></summary>

    
    `student@bchd:~$` `kubectl config use-context challenge-context`
    
    </details>
    
   ---------------------------------------
   
0. Create a single container pod named *challengepod*. Use an nginx image, version 1.18.0.


    **Correctness Check:**
   
    `student@bchd:~$` `kubectl describe pod challengepod -n challenge | grep Image:`
    
    ```
        Image:          nginx:1.18.0
    ```
    
    <details>
    <summary><b>SOLUTION</b></summary>
   
    `student@bchd:~$` `kubectl run challengepod --image=nginx:1.18.0`
    
    </details>
    
    ---------------------------------------

0. Inspect the pod using the `get` and `describe` commands.

    <details>
    <summary><b>SOLUTION</b></summary>

    `student@bchd:~$` `kubectl get pod challengepod -n challenge`
    
    `student@bchd:~$` `kubectl describe pod challengepod -n challenge`
    
    </details>
    
    ---------------------------------------
    
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
    <summary><b>SOLUTION</b></summary>

    `student@bchd:~$` `kubectl describe pod challengepod -n challenge > /home/student/static/poddesc.txt`
    
    </details>
    
    ---------------------------------------
 
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

    **Correctness Check:**

    `student@bchd:~$` `kubectl get pods -o wide -n challenge | grep challengedeploy`
    
    ```
    challengedeploy-79cd84ccf8-2474t   1/1     Running   0          45m   192.168.139.81   node-3   <none>           <none>
    challengedeploy-79cd84ccf8-hrfx9   1/1     Running   0          45m   192.168.139.82   node-3   <none>           <none>
    challengedeploy-79cd84ccf8-kgmm9   1/1     Running   0          45m   192.168.139.84   node-3   <none>           <none>
    challengedeploy-79cd84ccf8-kksm9   1/1     Running   0          45m   192.168.139.83   node-3   <none>           <none>
    ```
    
    `student@bchd:~$` `kubectl describe deploy challengedeploy -n challenge | grep Image:`
    
    ```
        Image:        nginx
    ```
    
    `student@bchd:~$` `kubectl describe deploy challengedeploy -n challenge | grep Annotations: -A 4`
    
    ```
    Annotations:            deployment.kubernetes.io/revision: 1
                        i: am
                        kubernetes: is
                        so: awesome
                        super: easy
    ```
    
    `student@bchd:~$` `kubectl describe deploy challengedeploy -n challenge | grep Labels:`
    
    ```
    Labels:                 challenge=met
    ```
    
    
    <details>
    <summary><b>SOLUTION</b></summary>

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
            image: nginx
            ports:
            - containerPort: 80
    ```

    `student@bchd:~$` `kubectl apply -f deploychallenge.yml`
    
    </details>
    
    ---------------------------------------
    
0. Expose your deployment with a ClusterIP service.

    **Correctness Check:**
    
    `student@bchd:~$` `kubectl get svc challengedeploy -n challenge`
    
    ```
    YOUR OUTPUT WILL BE DIFFERENT
    NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
    challengedeploy   ClusterIP   172.16.3.243   <none>        80/TCP    2s
    ```
    
    - Copy the `CLUSTER-IP` address in that output.
    
    `student@bchd:~$` `ssh node-1`
    
    `student@node-1:~$` `curl USE_YOUR_IP_ADDRESS:80`
    
    ```
    <!DOCTYPE html>                                                                                                              
    <html>                                                                                                                       
    <head>                                                                                                                       
    <title>Welcome to nginx!</title> 
    [...]
    ```
        
    <details>
    <summary><b>SOLUTION</b></summary>
    
    `student@bchd:~$` `kubectl expose deploy challengedeploy`
    
    </details>
    
    ---------------------------------------
     
0. Create a PersistentVolume with the following parameters:
   - 2GB storage
   - name: persistentchallenge
   - storage class: challenge
   - host path: /mnt/data

    **Correctness Check:**
    
    `student@bchd:~$` `kubectl get pv -n challenge`
    
    ```
    NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                STORAGECLASS   REASON   AGE
    persistentchallenge   2Gi        RWO            Retain           Bound    challenge/persistentclaimchallenge   challenge               33m
    ```
    
    <details>
    <summary><b>SOLUTION</b></summary>

    
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

    **Correctness Check:**
    
    `student@bchd:~$` `kubectl get pvc -n challenge`
    
    ```
    NAME                       STATUS   VOLUME                CAPACITY   ACCESS MODES   STORAGECLASS   AGE
    persistentclaimchallenge   Bound    persistentchallenge   2Gi        RWO            challenge      32m
    ```
    
    <details>
    <summary><b>SOLUTION</b></summary>

    
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

    **Correctness Check:**
    
    `student@bchd:~$` `kubectl get pod storagepodlet -n challenge`
    
    ```
    NAME            READY   STATUS    RESTARTS   AGE
    storagepodlet   1/1     Running   0          34m
    ```
    
    <details>
    <summary><b>SOLUTION</b></summary>

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
