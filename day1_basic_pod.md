# WARMUP: Make a Pod!

<img src="https://miro.medium.com/v2/resize:fit:800/0*0tk3EgSA2cJI3oPg.jpg" alt="Description of the image">

1. Create a pod to the following specs!

  - IMAGE: `registry.gitlab.com/alta3-instructor/tmnt`
  - POD NAME: `wednesday-warmup`
  - CONTAINER PORT: `5055`
  - CONTAINER NAME: `pizzaparty`

2. Confirm that your pod is running with a `kubectl get pod wednesday-warmup` command! It should be in a RUNNING state! (if it is in a `ContainerCreating` state try again in a few seconds)

0. When the pod is running, run this command: `kubectl port-forward wednesday-warmup 2224:5055 --address=0.0.0.0`

0. Then open `aux1`! You can also add `/tmnt` and `/splinter` to the end of the aux1 address bar to see different pages.
