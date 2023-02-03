## CKAD TIPS:

1. TMUX is installed on the CKAD environment! Use it to your advantage!
0. vim/vi is installed on the CKAD environment; you MUST be FAST with this tool! You may fail the exam due to being a slow typist instead of not knowing Kubernetes!
0. You may use all of kubernetes.io on the exam! You MUST be FAST at finding what you need out of this website! Don't spend a lot of time looking stuff up.
0. The CKAD exam environment is in a remote desktop; the browser can only open kubernetes.io, so no other outside web resources allowed :(
0. ALWAYS run the `kubectl config use-context` command FIRST before you even READ the task question!
0. Never memorize what you can copy/paste :)
0. shortcuts for resource creation (all --tags are OPTIONAL, only set what you need)
    - `kubectl run PODNAME --image=IMAGE_NAME --labels="app=hazelcast,env=prod" --env="DNS_DOMAIN=cluster"`
    - `kubectl create deploy DEPLOYMENTNAME --image=IMAGE_NAME --replicas=NUMBER`
    - type `kubectl create svc --help | less` to see a list of quick commands to create these objects on the fly!
0. Use `kubectl describe` against problematic objects! `kubectl get events` is another way to get an overview of anything that might be wrong
0. Name your manifest files something you'll be able to easily find when you return to a task. If task 3 asks you to create a deployment, write your manifest in a file something like `3-deploy.yml`.
0. ALWAYS copy/paste the name of images! One typo and you will get an error. Expect to see an "nginxxx" on your exam :)
0. The CKAD exam WILL ask you "which pod in the cluster is consuming the most resources"-- however, the exam will NOT say "use kubectl top to figure that out". You will be expected to just know to use that tool. The metrics server will ALREADY be installed on your ckad exam cluster, so you will be able to use it without any setup!
0. A lot of questions on the CKAD will have you write something a specific file. "Put the name of the pod consuming the most resources in the file /tmp/bigolpod.txt"
0. Questions involving readiness/liveness probes will NOT mention "readiness/liveness probes" on the exam. It will say something like "make sure that the container restarts after it fails to respond to a cat command against /tmp/whatever"
0. Need to mount something like a configmap/secret/persistentvolumeclaim to a Pod? Do the following:
    - search kubernetes.io for "configmap" or "secret" or "persistent volume claim" and open that page
    - press "ctrl f" to open a search bar; type in "kind: Pod"
    - this will zoom you to the part of the page where there is a Pod manifest that already has that object written in as a volume!
0. Go to this link and scroll down. The first manifest you find is one you're likely to see on the CKAD exam. Study it carefully and be sure you understand what the Pod is doing! Google "emptyDir kubernetes" as well.
    - https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container
0. For Network Policies, you WILL be expected to write a policy that allows specific rules for ingress/egress. Make sure you study the manifest in the documentation. You can edit it to match any policy you'll be expected to write!
    - https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource
0. You actually get TWO attempts at the CKAD exam! If you fail the first time, try to figure out what you did wrong and then retake it. HOT TIP: the questions will be the same the second time you take the exam!

## EXAMPLE QUESTIONS

QUESTION 1:
Scale a deployment up to 4 replicas

QUESTION 2:
Add an additional container to an existing deployment's pods.
Make the new containerPort 80.
Create a nodePort service exposing that specific container via port 80.

QUESTION 3:
Make a PV, make a PVC. Specs are provided, be sure you can find a PV manifest that uses "hostPath"
Mount PVC as volume to a Pod.

QUESTION 4:
Just make a single PV, nothing else to it. Be sure you can find a PV manifest that uses "hostPath"

QUESTION 5:
Make a pod with two containers. Easy.

QUESTION 6:
Create a network policy with the following:
  - create on namespace "foo"
  - add rules to the networkpolicy that states:
       ○ all pods in "foo" can only receive traffic from pods in namespace "bar" on port 90210. It was definitely NAMESPACE SPECIFIC, so for podselector make the value "{}" for all pods in that namespace.

QUESTION 7:
Of all pods that have a specific label, which one has the highest CPU consumption? Write the name of that Pod to a file.

QUESTION 8:
Display logs from a specific pod. Write all log lines that contain "file-not-found" to a specific file.

QUESTION 9:
Create an ingress object that exposes an existing service named "hello" at path "/hello" at port 80. They include a command to test if it works.

QUESTION 10:
This question was totally taken from their own docs.
https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container

