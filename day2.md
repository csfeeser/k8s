# Kubernetes Essentials Day 2 Challenge

<img src="https://pbs.twimg.com/media/FYhiT-BWAAAA2FB.jpg" width="200"/>

### Procedure

The following are challenges using topics we learned yesterday! Give your best shot to as many of these as you can!

1. Create a new namespace called *challenge*

0. Create a single container pod named `challengepod`. Use `nginx` as the container image.

0. Put your pod in the `challenge` namespace. You can do this by:
    - adding `-n challenge` to the end of your kubectl command when creating the pod
      - OR
    - put `namespace: challenge` indented under `metadata` in the manifest.

2. Confirm your pod was created in the correct namespace (`challenge`) using a `kubectl get` command.

0. Put a resource quota on your new `challenge` namespace! Ensure that there is a hard limit of `1` cpu and `1Gi` of memory on the `challenge` namespace!

0. Confirm that the resource quota has been added by using `kubectl describe`!
