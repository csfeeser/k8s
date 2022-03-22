# Kubernetes Essentials Day 1 Challenge

![Image description](https://memegenerator.net/img/instances/72738808.jpg)

### Procedure

The following are challenges using topics we learned yesterday! Give your best shot to as many of these as you can!

1. Create a new namespace called *challenge*

0. Create a context named *challenge-context* that uses the following:

        cluster: kubernetes-the-alta3-way
        namespace: challenge
        user: admin

0. Make *challenge-context* your current context. **ALL OBJECTS SHOULD BE CREATED IN THIS CONTEXT!**

0. Create a single container pod named `challengepod`. Use `nginx` as the container image.

0. Confirm your pod was created in the correct namespace (`challenge`) using a `kubectl get` command.

0. Put a resource quota on your new `challenge` namespace! Ensure that there is a hard limit of `1` cpu and `1Gi` of memory on the `challenge` namespace!

## When you are finished, return to the correct context!

`student@bchd:~$` `kubectl config use-context kubernetes-the-alta3-way`
