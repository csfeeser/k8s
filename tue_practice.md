# Tuesday End-Of-Day Challenge

### Procedure
>The following are questions as they may appear on the CKAD exam! If you're looking for an authentic experience, you may ONLY use https://kubernetes.io/docs/home/ when you must look anything up (this is the only resource you have on the exam). Otherwise, the labs that specify how to complete each step is included. GOOD LUCK!

0. Create a new namespace called *challenge*
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
0. Create a single container pod from a pod manifest. Use your *webby* image.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 08
    </details>
0. Inspect the pod using the `get` and `describe` commands.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Labs 06 & 07
    </details>
0. BONUS: output your pod description into a file named `poddesc.txt`. Save it to `/home/student/static/`.
0. Convert your Pod into a Deployment with 5 replicas.
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
        I: am
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
