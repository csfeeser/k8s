1. Be a MASTER at using vim! The exam is timed, and it is not forgiving to slow typers!

2. CKA Exam is OPEN BOOK-- you are allowed to use kubernetes.io to look stuff up- so get adept at navigating this site!

3. In Chad's experience, you will NOT have to build a cluster from scratch on the CKA.
You WILL have to:
  • add an additional node
  • upgrade a node from an older version of K8s to a newer one
  • create a snapshot of etcd and restore etcd to a previous snapshot
  • all of these steps are in the kubernetes.io page. Know where these steps are in advance of taking the exam!

4. Never memorize what you can copy/paste :)

5. shortcuts for resource creation (all --tags are OPTIONAL, only set what you need)
    • kubectl run PODNAME --image=IMAGE_NAME --labels="app=hazelcast,env=prod" --env="DNS_DOMAIN=cluster"
    • kubectl create deploy DEPLOYMENTNAME --image=IMAGE_NAME --replicas=NUMBER
    • type "kubectl create svc --help | less" to see a list of quick commands to create these objects on the fly!

6. Use kubectl describe against problematic objects! "kubectl get events" is another way to get an overview of anything that might be wrong

7. ALWAYS copy/paste the name of images! One typo and you will get an error. Expect to see an "nginxxx" on your exam :)

8. The CKA exam WILL ask you "which pod in the cluster is consuming the most resources"-- however, the exam will NOT say "use kubectl top to figure that out". You will be expected to just know to use that tool. The metrics server will ALREADY be installed on your cka exam cluster, so you will be able to use it without any setup!

9. A lot of questions on the CKA will have you write something a specific file. "Put the name of the pod consuming the most resources in the file /tmp/bigolpod.txt"

10. questions involving readiness/liveness probes will NOT mention "readiness/liveness probes" on the exam. It will say something like "make sure that the container restarts after it fails to respond to a cat command against /tmp/whatever"

11. Need to mount something like a configmap/secret/persistentvolumeclaim to a Pod? Do the following:
  • search kubernetes.io for "configmap" or "secret" or "persistent volume claim" and open that page
  • press "ctrl f" to open a search bar; type in "kind: Pod"
  • this will zoom you to the part of the page where there is a Pod manifest that already has that object written in as a volume!

12. Go to this link and scroll down. The first manifest you find is one you're likely to see on the CKA exam. Study it carefully and be sure you understand what the Pod is doing! Google "emptyDir kubernetes" as well. https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container

13. For Network Policies, you WILL be expected to write a policy that allows specific rules for ingress/egress. Make sure you study the manifest in the documentation. You can edit it to match any policy you'll be expected to write!
https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource






