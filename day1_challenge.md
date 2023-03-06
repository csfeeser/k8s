# Kubernetes Essentials Day 1 Challenge

<img src="https://pbs.twimg.com/media/FYhiT-BWAAAA2FB.jpg" width="200"/>

### Procedure

The following are challenges using topics we learned yesterday! Give your best shot to as many of these as you can!

1. Create a new namespace called *challenge*

0. Create a single container pod named `challengepod`. Use `nginx` as the container image.

0. Confirm your pod was created in the correct namespace (`challenge`) using a `kubectl get` command.

  > BONUS: save the output from your `kubectl get` command to the file `/tmp/challengeoutput.txt`

0. Put a resource quota on your new `challenge` namespace! Ensure that there is a hard limit of `1` cpu and `1Gi` of memory on the `challenge` namespace!
