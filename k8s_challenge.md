# Mini-CKAD Challenge

### Procedure
>The following are questions that involve topics on the CKAD exam! If you're looking for an authentic experience, you may ONLY use https://kubernetes.io/docs/home/ when you must look anything up (this is the only resource you have on the exam). Otherwise, the labs that specify how to complete each step is included. GOOD LUCK!

1. Create a new namespace called *challenge*
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 03
    </details>
0. Create a context named *challenge-context* that uses the following:

        cluster: kubernetes-the-alta3-way
        namespace: challenge
        user: admin

    <details><summary>Lab that contains the answer</summary>
    See Lab 05
    </details>
0. Make *challenge-context* your current context.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 05
    </details>   

0. Create a single container pod from a pod manifest. Use an nginx image, version 1.7.9.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 08
    </details>
0. Inspect the pod using the `get` and `describe` commands.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Labs 06 & 07
    </details>
0. Output your pod description into a file named `poddesc.txt`. Save it to `/home/student/static/`.
0. Convert your the manifest you used to create your Pod in step 4 into a Deployment manifest with 5 replicas. Create the deployment!
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 16
    </details>
0. Label your Deployment as *challenge: met*.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 12
    </details>
0. Annotate your Deployment with the following:

        kubernetes: is
        super: easy
        i: am
        so: awesome

    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 13
    </details>
0. Scale your Deployment down to 2 replicas.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 18
    </details>
