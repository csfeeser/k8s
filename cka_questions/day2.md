# Daily CKA Exam Warmup!
Below is a question identical to one you may encounter on the CKA exam! It's quite challenging, so take your time and use the hints if you need them!
- It is TOTALLY legal to use the official [Kubernetes docs](https://kubernetes.io/docs/home/)!

---

### Task 2: Add a Container to a Manifestless Pod

#### SETUP

1. Ensure you are in the correct context.

    `student@bchd~:$` `kubectl config use-context kubernetes-the-alta3-way`

2. On the actual exam this pod will already be running, but go ahead and create it yourself.

    `student@bchd~:$` `kubectl run mystery-pod --image=nginx`

### Example CKA Task Description:

  - There is an existing pod named `mystery-pod` within your cluster.
  - Your task is to modify this pod by adding an additional container according to the specifications below.
  - You do not have access to the original manifest file for the pod
   
3. Details for new container:
    - **Container Name**: `simpleservice-container`
    - **Container Image**: `mhausenblas/simpleservice:0.5.0`
    - **Container Port**: `9876`

<details><summary>Help me Chadly-wan Kenobi- how do I create a manifest from a running K8s resource?</summary>
<br>
Here you go, Padawan-

`student@bchd~:$` `kubectl get pod mystery-pod -o yaml > 3-pod.yaml`

</details>   

### Solution:

<details><summary>Click to reveal the solution!</summary>
  
1. First, we're going to need the manifest of that pod. We can create one with the following command:

    `student@bchd~:$` `kubectl get pod mystery-pod -o yaml > 3-pod.yaml`

    > CHAD CKA TIP-- name your manifests after the number of the task with the "kind" (pod, deployment, service, etc.) It makes it a LOT easier to return to manifests later!
  
3. Open the manifest you've made. Under the `spec.template.spec.containers` section, add a new container definition like so:

    ```yaml
    - name: simpleservice-container
      image: mhausenblas/simpleservice:0.5.0
      ports:
      - containerPort: 9876
    ```

4. There's no way to add/remove containers to a pod that is already running, so let's delete the original pod.

    `student@bchd~:$` `kubectl delete pod mystery-pod`

5. Now re-create the pod with the second container added.

    `student@bchd~:$` `kubectl apply -f 3-pod.yaml`
   
6. Always verify before moving on! Check that the new container has been added and is running.

    `student@bchd~:$` `kubectl get pods mystery-pod`

    ```
    mystery-pod   2/2     Running             0          20s
    ```

</details>
