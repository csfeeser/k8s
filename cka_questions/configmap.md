## CKA Challenge: Creating and Mounting a ConfigMap with DC Comic Superheroes

<img src="https://miro.medium.com/v2/resize:fit:640/1*1L6WPtVM2paIttHkG7x8CA.png" width="200"/>

Your task involves creating a ConfigMap in Kubernetes from a file containing a list of DC Comic superheroes. You will first create this file using vim, and then create a ConfigMap using this file. Finally, you will deploy a basic Pod that runs Nginx and mounts this ConfigMap to a specific directory within the container.

### Requirements:

1. **Create a File with DC Comic Superheroes**:
   - Open a terminal in your Kubernetes environment.
   - `student@bchd:~$` `vim ~/dc-heroes.txt`
   - Add the following superheroes to the file:
     ```
     Batman
     Superman
     Wonder Woman
     Flash
     Green Lantern
     ```
   - Save and exit vim.

2. **Create a ConfigMap**:
   - Create a ConfigMap named `dc-comic-heroes` from the `dc-heroes.txt` file.

3. **Deploy a Pod**:
   - Deploy a Pod named `nginx-dc-comics`.
   - The Pod should run the `nginx` image.
   - Mount the `dc-comic-heroes` ConfigMap to the `/dc-comics` directory in the container.

Ensure that the Pod is correctly configured to serve the content of the mounted ConfigMap. You can confirm it with the following command:

`student@bchd:~$` `kubectl exec nginx-dc-comics -- cat /dc-comics/dc-heroes.txt`

<details>
<summary>Solution</summary>

1. **Creating the File**:

```bash
vim dc-heroes.txt
```

Inside `vim`, add the superheroes:
```
Batman
Superman
Wonder Woman
Flash
Green Lantern
```

2. **Creating the ConfigMap**:

```yaml
kubectl create configmap dc-comic-heroes --from-file=dc-heroes.txt
```

3. **Pod Manifest**:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-dc-comics
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: dc-comic-volume
      mountPath: "/dc-comics"
  volumes:
  - name: dc-comic-volume
    configMap:
      name: dc-comic-heroes
```

Apply this manifest by saving it to a file, then running `kubectl apply -f <filename>.yaml`.

</details>

---

This challenge should give your students a practical task combining Kubernetes resource management with a bit of DC Comics fun, Chad! Let me know if you have any other requests.
