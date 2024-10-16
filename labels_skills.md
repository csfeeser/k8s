# Warmup: Labels!

<img src="https://i.redd.it/o38mvxc9mkf71.png" alt="image" width="300"/>

Welcome to your **Animal Pods Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Download and execute a script that creates pods with animal-related labels.
2. Use `kubectl` to filter the pods based on their labels.

Run the following command to download the script that will create the animal-named pods with various labels, and execute it immediately:

`student@bchd~$` `wget https://raw.githubusercontent.com/csfeeser/k8s/refs/heads/master/resources/animallabelpods.sh -O animallabelpods.sh && bash animallabelpods.sh`

This script will create 20 pods named after different animals, each with a mix of labels such as `species`, `habitat`, and `diet`. They will be created in the namespace `critters`. Confirm you're good to go:

`student@bchd~$` `kubectl get pods -n critters --show-labels`

---

<img src="https://labs.alta3.com/courses/kubernetes/slides/labels/Slide5.PNG" alt="image" width="700"/>

### Task 1: Find All Pods with `species=mammal`

Run the appropriate `kubectl` command to find all pods with the label `species: mammal` in the `critters` namespace.

<details>
  <summary>Click here for the full solution!</summary>

```bash
kubectl get pods -n critters --selector="species=mammal"
```

OR

```bash
kubectl get pods -n critters -l species=mammal
```

</details>

---

### Task 2: Find All Pods with Both `species=mammal` and `habitat=land`

Now, filter the pods down even further. Find the pods that have **both** `species: mammal` and `habitat: land` in the `critters` namespace.

<details>
  <summary>Click here for the full solution!</summary>

```bash
kubectl get pods -n critters --selector="species=mammal,habitat=land"
```

OR

```bash
kubectl get pods -n critters -l species=mammal,habitat=land
```

</details>

---

### Task 3: Find All Pods with `diet=herbivore` or `diet=carnivore`

Your final task is to find the pods that have **either** `diet: herbivore` or `diet: carnivore` in the `critters` namespace.

<details>
  <summary>Click here for the full solution!</summary>

```bash
kubectl get pods -n critters --selector="diet in (herbivore,carnivore)"
```

OR

```bash
kubectl get pods -n critters -l 'diet in (herbivore,carnivore)'
```

</details>

## Finished?

We don't need that namespace or the pods anymore. Wipe 'em out!

`student@bchd:~$` `kubectl delete ns critters`

> You can press `ctrl c` if it hangs, it'll continue deleting even if you do so.
