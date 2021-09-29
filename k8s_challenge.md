# Mini-CKAD Challenge

### Procedure
>The following are questions that involve topics on the CKAD exam! If you're looking for an authentic experience, you may ONLY use https://kubernetes.io/docs/home/ when you must look anything up (this is the only resource you have on the exam). Otherwise, the labs that specify how to complete each step is included. GOOD LUCK!

1. Create a new namespace called *challenge*

0. Create a context named *challenge-context* that uses the following:

        cluster: kubernetes-the-alta3-way
        namespace: challenge
        user: admin

0. Make *challenge-context* your current context. **ALL OBJECTS SHOULD BE CREATED IN THIS CONTEXT!**

0. Create a single container pod named *challengepod*. Use an nginx image, version 1.7.9.

0. Inspect the pod using the `get` and `describe` commands.

0. Output your pod description into a file named `poddesc.txt`. Save it to `/home/student/static/`.

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
          
0. Expose your deployment with a ClusterIP service.
    
## When you are finished, return to the correct context!

`student@bchd:~$` `kubectl config use-context kubernetes-the-alta3-way`
