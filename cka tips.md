1. Be a MASTER at using vim! The exam is timed, and it is not forgiving to slow typers!

2. CKA Exam is OPEN BOOK-- you are allowed to use kubernetes.io to look stuff up- so get adept at navigating this site!

3. In Chad's experience, you will NOT have to build a cluster from scratch on the CKA.
You WILL have to:
    - add an additional node
    - upgrade a node from an older version of K8s to a newer one
    - create a snapshot of etcd and restore etcd to a previous snapshot
    - all of these steps are in the kubernetes.io page. Know where these steps are in advance of taking the exam!

4. Never memorize what you can copy/paste :)

5. shortcuts for resource creation (all --tags are OPTIONAL, only set what you need)
    - `kubectl run PODNAME --image=IMAGE_NAME --labels="app=hazelcast,env=prod" --env="DNS_DOMAIN=cluster"`
    - `kubectl create deploy DEPLOYMENTNAME --image=IMAGE_NAME --replicas=NUMBER`
    - type `kubectl create svc --help | less` to see a list of quick commands to create these objects on the fly!

6. Use `kubectl describe` against problematic objects! `kubectl get events` is another way to get an overview of anything that might be wrong

7. ALWAYS copy/paste the name of images! One typo and you will get an error. Expect to see an "nginxxx" on your exam :)

8. The CKA exam WILL ask you "which pod in the cluster is consuming the most resources"-- however, the exam will NOT say "use kubectl top to figure that out". You will be expected to just know to use that tool. The metrics server will ALREADY be installed on your cka exam cluster, so you will be able to use it without any setup!

9. A lot of questions on the CKA will have you write something a specific file. "Put the name of the pod consuming the most resources in the file /tmp/bigolpod.txt"

10. Questions involving readiness/liveness probes will NOT mention "readiness/liveness probes" on the exam. It will say something like "make sure that the container restarts after it fails to respond to a cat command against /tmp/whatever"

11. Need to mount something like a configmap/secret/persistentvolumeclaim to a Pod? Do the following:
    - search kubernetes.io for "configmap" or "secret" or "persistent volume claim" and open that page
    - press "ctrl f" to open a search bar; type in "kind: Pod"
    - this will zoom you to the part of the page where there is a Pod manifest that already has that object written in as a volume!

12. Go to this link and scroll down. The first manifest you find is one you're likely to see on the CKA exam. Study it carefully and be sure you understand what the Pod is doing! Google "emptyDir kubernetes" as well.
    - https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container

13. For Network Policies, you WILL be expected to write a policy that allows specific rules for ingress/egress. Make sure you study the manifest in the documentation. You can edit it to match any policy you'll be expected to write!
    - https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource

14. You actually get TWO attempts at the CKA exam! If you fail the first time, try to figure out what you did wrong and then retake it. HOT TIP: the questions will be the same the second time you take the exam!

## EXAMPLE QUESTIONS

QUESTION 1:
Create a clusterrole that allows for specific verb(s) and resources: create pods, secrets, deployments
Create a ServiceAccount named "bob"
Connect "bob" to the clusterrole (so use a clusterrolebinding)

QUESTION 2:
Use kubeadm to upgrade a master node from 1.24.1 to 1.24.2.
Also upgrade kubectl and kubelet.  it's in the upgrade page
Literally steps from here: https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/#upgrading-control-plane-nodes

QUESTION 3:
Scale a deployment up to 4 replicas

QUESTION 4:
Add an additional container to an existing deployment's pods.
Make the new containerPort 80.
Create a nodePort service exposing that specific container via port 80.

QUESTION 5:
Take an etcd snapshot and save it to a specified place. cacert, cert, and key are provided. See the second command down from this link: https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#snapshot-using-etcdctl-options

Restore an existing snapshot that was already on the machine. You'll still need the cacert, cert, and key flags you used to save the snapshot. The documentation is NOT clear about that.

QUESTION 6:
Make a PV, make a PVC. Specs are provided, be sure you can find a PV manifest that uses "hostPath"
Mount PVC as volume to a Pod.

QUESTION 7:
Just make a single PV, nothing else to it. Be sure you can find a PV manifest that uses "hostPath"

QUESTION 8:
Make a pod with two containers. Easy.

QUESTION 9:
Create a network policy with the following:
  - create on namespace "foo"
  - add rules to the networkpolicy that states:
       ○ all pods in "foo" can only receive traffic from pods in namespace "bar" on port 90210. It was definitely NAMESPACE SPECIFIC, so for podselector make the value "{}" for all pods in that namespace.

QUESTION 10:
Count how many nodes are "ready" and write that number to a file.

QUESTION 11:
Of all pods that have a specific label, which one has the highest CPU consumption? Write the name of that Pod to a file.

QUESTION 12:
Display logs from a specific pod. Write all log lines that contain "file-not-found" to a specific file.

QUESTION 13:
Create an ingress object that exposes an existing service named "hello" at path "/hello" at port 80. They include a command to test if it works.

QUESTION 14:
This question was totally taken from their own docs.
https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container

