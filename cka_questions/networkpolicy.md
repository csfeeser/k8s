# Network Policies

## Objectives
In this task you'll be creating a **NetworkPolicy** to create **ingress** and/or **egress** rules for **Deployments**. This is one of the trickier tasks on the **CKA** exam, and is a common stumbling block. Permitted reference material you can use while taking the **CKA** exam can be found [here from kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/) -- Good luck!

### Lab Setup

1. Run the following command to setup the lab.

    `student@bchd:~$` `drill network-policies`
    
### Summary

In namespace `cherry` you'll find two deployments named `pit` and `stem`. Both deployments are exposed via a service. Make a NetworkPolicy named `cherry-control` that prevents outgoing traffic from deployment `pit` except to that of deployment `stem`.

   > You may be presented with an existing network policy and determine how it might be modified to accomodate ingress or egress from a given pod. Or you may be told to leave the network policy alone and adapt the pod to match the network policy as is.

**Weight:** 12%

### Tasks

1. Create the Network Policy described in the Summary selecting the appropriate target.

0. Create the Network Policy described in the Summary setting the correct Policy.

0. Verify the Network Policy had the desired effect.

### Hints

1. Create the Network Policy described in the Summary selecting the appropriate target.

    <details><summary>Click</summary>
    
    What is the target of your Network Policy? Which resource are you trying to control? You will need an appropriate selector to target this resource.
    
    </details>

0. Create the Network Policy described in the Summary setting the correct Policy.

    <details><summary>Click</summary>
    
    There are two Network Policy types we can interact with using a **Network Policy**: **Ingress** which enforces rules regarding whom our target can receive ingress from; and **Egress** which enforces rules regarding whom our target can send egress to. Which policy is required here?
    
    </details>
    
0. Verify the Network Policy had the desired effect

    <details><summary>Click</summary>
    
    There is a handy, frequently used, **kubectl** command which will be helpful here. You'll need a description of the Network Policy to confirm everything is as it should be.
    
    </details>

### Answers

1. Create a Network Policy as described in the Summary.
    
    <details><summary>Click</summary>
    
    1. Create a Network Policy Manifest.
    
        `student@bchd:~$` `vim cherry-control.yaml`
    
        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: NetworkPolicy
        metadata:
          name: cherry-control
          namespace: cherry
        spec:
          podSelector:
            matchLabels:
              app: pit
              version: v2
          policyTypes:
            - Egress
          egress:
          - to:
            - podSelector:
                matchLabels:
                  app: stem
                  version: v2
        ```

       > Network Policies are tough. The **.spec.podSelector** key is where we identify the target of the Network Policy. Then, we write the **egress** policies, which indicate which connections we're allowing our target to egress to.
        > Press **ESC** to exit **Insert Mode** and type `wq!` to write and quit out of vim.
    
    0. Push the manifest to your Kubernetes Cluster.
    
        `student@bchd:~$` `kubectl apply -f cherry-control.yaml`
    
        ```
        networkpolicy.networking.k8s.io/cherry-control created
        ```
    
    </details>

0. Verify the Network Policy was created appropriately.

    <details><summary>Click</summary>
    
    1. Describe the Network Policy to double-check the **PodSelector** and **Egress** rules.
    
        `student@bchd:~$` `kubectl describe networkpolicies -n cherry cherry-control`
    
        ```
        Name:         cherry-control
        Namespace:    cherry
        Created on:   2023-03-29 14:41:47 +0000 UTC
        Labels:       <none>
        Annotations:  <none>
        Spec:
          PodSelector:     app=pit,version=v2
          Not affecting ingress traffic
          Allowing egress traffic:
            To Port: <any> (traffic allowed to all ports)
            To:
              PodSelector: app=stem,version=v2
          Policy Types: Egress
        ```
      
    </details>

### Lab Teardown

1. Want to run the lab again? Run the following script to teardown your work.

    `student@bchd:~$` `teardown network-policies`
