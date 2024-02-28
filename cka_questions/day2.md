# Daily CKA Exam Warmup!
Below is a question identical to one you may encounter on the CKA exam! Let us assume the following:
- You completed lab 24 yesterday on your new VM and have a functioning cluster (if that isn't done please do it now)
- It is TOTALLY legal to use the official [Kubernetes docs](https://kubernetes.io/docs/home/)!

---

### Task 3: Add a Container to a Manifestless Pod

1. You'll execute a command to create a pod without using a manifest. The initial container in this deployment will run an Nginx server.

    `student@bchd~:$` `kubectl run mystery-pod --image=nginx`
   
3. **Example CKA Task Description**: 
    - There is an existing pod named `mystery-pod` within your cluster.
    - Your task is to modify this pod by adding an additional container. This new container should serve a simple HTTP service on `containerPort 80`.
    - You do not have access to the original manifest file for the pod.
   
### Details for New Container:
- **Container Name**: `simpleservice-container`
- **Container Image**: `mhausenblas/simpleservice:0.5.0`
- **Container Port**: `9876`
  
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
