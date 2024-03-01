## Role/ClusterRole Verbs

Kubernetes is not great at providing a central location in their documentation for what each verb does in a role/clusterrole and what kubectl commands it affects. Use the following as a guide for most verbs you may encounter!

| Verb        | Description                                                                 | Example `kubectl` Commands                                  |
|-------------|-----------------------------------------------------------------------------|-------------------------------------------------------------|
| `get`       | Allows fetching details of specific instances of a resource.                | `kubectl get <resource> <name>`                             |
| `list`      | Allows listing all instances of a resource in a namespace or cluster.       | `kubectl get <resource>`                                    |
| `watch`     | Allows watching for real-time updates to resource instances.                | `kubectl get <resource> -w`                            |
| `create`    | Allows creating new instances of a resource.                                | `kubectl create -f <file.yaml>`, `kubectl run <name> ...`    |
| `delete`    | Allows deleting instances of a resource.                                    | `kubectl delete <resource> <name>`, `kubectl delete -f <file.yaml>` |
| `update`    | Allows updating most fields of a resource. Often represented as `edit`.     | `kubectl edit <resource> <name>`                            |
| `patch`     | Allows making changes to specific fields of a resource instance.            | `kubectl patch <resource> <name> -p '<json_patch>'`         |
| `scale`     | Allows scaling a scalable resource (e.g., replicas in a Deployment).       | `kubectl scale <resource> <name> --replicas=<count>`        |
