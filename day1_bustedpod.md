# WARMUP: Make a Pod!

<img src="https://miro.medium.com/v2/resize:fit:800/0*0tk3EgSA2cJI3oPg.jpg" alt="Description of the image">

1. Create a pod!

    `student@bchd~$` `vim bustedpodwarmup.yml`

    ```yaml
    apiVersion:v1
    kind: pod
    metadata:
      name: warmup-pod
    spec:
      containers:
        - name: nginx-container
          image: nnnginx
          ports:
            - name: http-port
              containerPort: 80
                protocol: TCP
    ```

#### The manifest for the above Pod is **BUSTED**- it will fail if you try to create it! Your task is to attempt to fix the manifest and create a functional pod!

2. When you're ready to try your manifest, create it like so:

    `student@bchd~$` `kubectl apply -f bustedpodwarmup.yml`

3. Confirm that your pod is working. The status must say `RUNNING` for you to declare victory! (if it is in a `ContainerCreating` state try again in a few seconds)

    `student@bchd~$` `kubectl get pod warmup-up`

<details>
<summary>Click here for hints!</summary>

- you always need a whitespace after every `:`
- incorrect capitalization can cause errors!
- the most common reason to get the `ErrImgPull` status is due to a misspelling
- indentation must remain consistent in YAML

</details>

<details>
<summary>Click here to see the solution!</summary>

```yaml
apiVersion: v1           # Must have a whitespace after the ":"
kind: Pod                # "kind" values must be capitalized correctly
metadata:
  name: warmup-pod
spec:
  containers:
    - name: nginx-container
      image: nginx       # TYPO! nginx, not nnnginx
      ports:
        - name: http-port
          containerPort: 80
          protocol: TCP  # indentation error! "protocol" needs bumped to the left
```

</details>
