# Warmup- Add a User!

<img src="https://www.meme-arsenal.com/memes/c62e21f60e1e8d5aa4d78210659a68e8.jpg" width="400"/>

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
