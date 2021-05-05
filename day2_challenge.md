# Day 2 Challenge

### Procedure
> In your lab environment, create the following! When you are finished, you can ask Chad to "grade" it for you!

1. Create a new namespace called *challenge*
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 11
    </details>
    
0. Ensure that this namespace does not consume more than 2GB of memory and 1 core of CPU.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 11
    </details>
    
0. Create a context named *challenge-context* that uses the following:

        cluster: kubernetes-the-alta3-way
        namespace: challenge
        user: admin

    <details><summary>Lab that contains the answer</summary>
    See Lab 12
    </details>
    
0. Make *challenge-context* your current context. **ALL OBJECTS SHOULD BE CREATED IN THIS CONTEXT!**
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 12
    </details>   

0. Create a single container pod named *challengepod*. Use an nginx image, version 1.19.6.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 16
    </details>
    
0. Go back to the pod that you made and make sure of the following:
   - The nginx container is GUARANTEED 64Mi of memory and 249m of CPU.
   - The nginx container WILL NOT consume more than 251Mi of memory and 333m of CPU.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Lab 17
    </details>   
            
0. Inspect the pod using the `get` and `describe` commands.
    <br>
    <details><summary>Lab that contains the answer</summary>
    See Labs 14 and 15
    </details>
    
0. Output your pod description into a file named `poddesc.txt`. Save it to `~/static/`.
    <br>
    <details><summary>How to do this</summary>
    
    `kubectl describe pod challengepod > ~/static/poddesc.txt`
    
    </details>

0. Create a user named 'tony', who is a developer, with the following permissions:

    In the namespace "challenge", tony can:

    - [pods, secrets, configmaps] - get, list, watch, create, apply, describe
    - [deployments] - get, list, watch, create, apply, describe

    In all namespaces, tony can:

    - [pods] - get, list, watch, describe

## When you are finished, return to the correct context!

`student@k8s-000-bchd:~$` `kubectl config use-context kubernetes-the-alta3-way`
