# LimitRange Syntax

Here's a simple table that outlines the types of controls you can set with `LimitRange` for different object types and what each control does:

| Object Type        | Control                  | Description                                                                                              |
|--------------------|--------------------------|----------------------------------------------------------------------------------------------------------|
| Container          | `min`                    | Sets the minimum allowed resource request (CPU, memory, etc.) for a container.                            |
| Container          | `max`                    | Sets the maximum allowed resource limit (CPU, memory, etc.) for a container.                              |
| Container          | `default`                | Sets the default resource limits if not specified by the user.                                            |
| Container          | `defaultRequest`         | Sets the default resource requests if not specified by the user.                                          |
| Container          | `maxLimitRequestRatio`   | Sets the maximum ratio between resource limit and resource request.                                       |
| Pod                | `min`                    | Sets the minimum sum of resource requests for all containers in a pod.                                    |
| Pod                | `max`                    | Sets the maximum sum of resource limits for all containers in a pod.                                      |
| PersistentVolumeClaim | `min`                | Sets the minimum allowed storage request for a PVC.                                                       |
| PersistentVolumeClaim | `max`                | Sets the maximum allowed storage request for a PVC.                                                       |
| PersistentVolumeClaim | `default`            | Sets the default storage request if not specified by the user.                                            |

Here is a massive `LimitRange` (far bigger than you're likely to make in production) that includes all the options above:

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: all-types-limit-range
spec:
  limits:
    # Controls for Container
  - type: Container
    min:
      cpu: 100m
      memory: 50Mi
    max:
      cpu: 2
      memory: 1Gi
    default:
      cpu: 500m
      memory: 200Mi
    defaultRequest:
      cpu: 200m
      memory: 100Mi
    maxLimitRequestRatio:
      cpu: "4"

    # Controls for Pod
  - type: Pod
    min:
      cpu: 200m
      memory: 100Mi
    max:
      cpu: 4
      memory: 2Gi

    # Controls for PersistentVolumeClaim
  - type: PersistentVolumeClaim
    min:
      storage: 1Gi
    max:
      storage: 10Gi
    default:
      storage: 5Gi
```
