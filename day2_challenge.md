# Warmup with RBAC- Add a User!

<img src="https://www.meme-arsenal.com/memes/c62e21f60e1e8d5aa4d78210659a68e8.jpg" width="400"/>

### Objective

Create a new user for your cluster and endow them with the permissions they need! Use the following labs to help you:

- [45. 💻1️⃣ Role Based Access Control](https://live.alta3.com/content/cka/labs/content/kubernetes/RBAC/RBAC-authentication-authorization-lab.html)
- [46. 💻2️⃣ RBAC Distributing Access](https://live.alta3.com/content/cka/labs/content/kubernetes/RBAC/RBAC-Distributing-Access-lab.html)

### Procedure

1. Create a new namespace named `challenge`.

    `kubectl create ns challenge`

0. Create a UserAccount with your name! For now, let's call him `tony`.

0. Give `tony` the following permissions:

    In the namespace "challenge", tony can:

    - [pods] - get, list, watch, create, update, delete
    - [deployments] - get, list, watch, create, update, delete

    In all namespaces, tony can:

    - [pods] - get, list, watch

0. Add your new user to your `kubeconfig`. Test that your permissions are correct with `kubectl auth`!
