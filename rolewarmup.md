# Warmup: Roles and RoleBindings!

<img src="https://www.m00nie.com/content/images/2020/04/rbac.jpg" alt="image" width="300"/>

Welcome to your **Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Run the setup script to create the namespace, service account, role, and rolebinding.
2. Use the `kubectl auth can-i` command to test permissions.
3. Update the Role to enable specific actions for the service account.

### Step 1: Run the Setup Script

To get started, run the following command to set up the environment with the necessary resources (namespace, service account, role, and rolebinding):

`student@bchd~$` `cd && wget https://raw.githubusercontent.com/csfeeser/k8s/master/resources/rolewarmupprep.sh -O - | bash`

This script creates a namespace called `challenge`, a service account named `challenge-sa`, a Role called `challenge-role`, and a RoleBinding. The role currently only allows basic access (listing and viewing pods). Confirm all those resources were created.

`student@bchd:~$` `kubectl get roles,rolebindings,serviceaccounts -n challenge`

```
NAME                                            CREATED AT
role.rbac.authorization.k8s.io/challenge-role   2024-09-19T12:30:21Z

NAME                                                          ROLE                  AGE
rolebinding.rbac.authorization.k8s.io/challenge-rolebinding   Role/challenge-role   48s

NAME                          SECRETS   AGE
serviceaccount/challenge-sa   0         48s
serviceaccount/default        0         48s
```

Now, it’s time to check the permissions granted to the service account.

### Step 2: Test Permissions with `kubectl auth can-i`

Run the following commands to see what this service account can currently do:

`student@bchd~$` `kubectl auth can-i list pods --as=system:serviceaccount:challenge:challenge-sa -n challenge`

> The **first** command should return `yes`, since the service account is allowed to list pods.

`student@bchd~$` `kubectl auth can-i create pod --as=system:serviceaccount:challenge:challenge-sa -n challenge`

> The **second** command should return `no`, since the current role does not grant permission to create pods.

### Step 3: Update the Role

Your task is to update the role to grant the service account the permissions necessary for managing pods. This includes creating, deleting, and describing pods in the `challenge` namespace.

Create a manifest for the Role as it currently exists:

`student@bchd~$` `vim challengerole.yml`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: challenge-role
  namespace: challenge
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

#### The Challenge

You need to add more functionality to the role! Specifically, ensure that the service account can perform the following actions on pods:

- **Get/List** pods (already allowed)
- **Create** pods
- **Delete** pods

### Step 4: Test Your Changes

Once you've updated the Role, apply the new manifest and test it by running the following `kubectl auth can-i` commands:

`student@bchd~$` `kubectl auth can-i list pods --as=system:serviceaccount:challenge:challenge-sa -n challenge`

`student@bchd~$` `kubectl auth can-i create pod --as=system:serviceaccount:challenge:challenge-sa -n challenge`

`student@bchd~$` `kubectl auth can-i delete pod --as=system:serviceaccount:challenge:challenge-sa -n challenge`

All of these commands should return `yes` if you've updated the role correctly.

---

### 👀 Hints (For When You Need a Gentle Nudge)

<details>
  <summary>Need a few hints? Click here to reveal!</summary>

  - The Role only has permissions to get and list pods right now. What verbs could you add to grant more actions on pods?
  - Fortunately, the verbs we need to enable the permissions described above are the same! `create`, `delete`, etc.

</details>

---

### 🛠️ Solution (Spoilers Ahead!)

<details>
  <summary>Click here if you want the full solution!</summary>

  - To grant the service account the ability to create, delete, and describe pods, you need to update the Role to include the `create` and `delete` verbs.
  - The final Role should look something like this:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: challenge-role
      namespace: challenge
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list", "create", "delete"]
    ```

    Once this is applied, the service account will have the necessary permissions to manage pods in the `challenge` namespace.
</details>
