## CKA Challenge: Create a ServiceAccount, Role, and RoleBinding

Your task will use concepts we learned about RBAC in Kubernetes!

### Requirements:

- **ServiceAccount**: Create a ServiceAccount named `custom-service-account` in the namespace `default`.
- **Role**: Create a Role named `custom-role` in the namespace `default`. This Role should have permissions to:
  - **get**, **list**, and **watch** Pods within the `default` namespace.
- **RoleBinding**: Create a RoleBinding named `custom-role-binding` in the namespace `default`. This RoleBinding should bind the `custom-role` to the `custom-service-account`.
    - A VERY NON-CKA WARNING: serviceaccounts can be bound to roles just as users can, but with one sifference:

```yaml
subjects:
- kind: ServiceAccount ## THIS IS DIFFERENT
```

When you think you are done, double check your work! 

This should return **yes**:

`kubectl auth can-i list pods --as=system:serviceaccount:default:custom-service-account -n default
`

This should return **no**:

`kubectl auth can-i delete pods --as=system:serviceaccount:default:custom-service-account -n default
`

<details>
<summary>Solution</summary>

```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: custom-service-account
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: custom-role
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: custom-role-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: custom-service-account
  namespace: default
roleRef:
  kind: Role
  name: custom-role
  apiGroup: rbac.authorization.k8s.io
```

</details>