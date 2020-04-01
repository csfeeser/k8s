# Wednesday End-Of-Day Challenge

### Procedure
>The following are questions as they may appear on the CKAD exam! If you're looking for an authentic experience, you may ONLY use https://kubernetes.io/docs/home/ when you must look anything up (this is the only resource you have on the exam). Otherwise, the labs that specify how to complete each step is included. GOOD LUCK!

0. Create a new namespace called *challenge*
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 03
    </details>
0. Create a context named *challenge-context* that uses the following: *challenge* namespace.
    <details><summary>Lab that contains the answer</summary>
    See Lab 04
    </details>
0. Create a single container pod from a pod manifest. Use your *webby* image.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 07
    </details>
0. Inspect the pod using the `get` and `describe` commands.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Labs 05 & 06
    </details>
0. Convert your Pod into a Deployment with 5 replicas.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 16
    </details>
0. Label your Deployment as *challenge: met*.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 19
    </details>
0. Annotate your Deployment with the following:

        kubernetes: is
        super: easy
        I: am
        so: awesome

    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 20
    </details>
0. Scale your Deployment down to 2 replicas.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 18
    </details>
