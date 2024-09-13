# WARMUP: Make a Pod!

<img src="https://miro.medium.com/v2/resize:fit:800/0*0tk3EgSA2cJI3oPg.jpg" alt="Description of the image">

1. Create a pod to the following specs!

  - IMAGE: `registry.gitlab.com/alta3-instructor/tmnt`
  - POD NAME: `day2-warmup`
  - CONTAINER PORT: `5055`
  - CONTAINER NAME: `pizzaparty`
  - [Click here for a manifest you can use!](https://kubernetes.io/docs/concepts/workloads/pods/#using-pods)
  
2. Confirm that your pod is running with a `kubectl get pod day2-warmup` command! It should be in a RUNNING state! (if it is in a `ContainerCreating` state try again in a few seconds)

**WANT TO TRY SOMETHING COOL?**

3. When you've confirmed the pod is running successfully, run this command:

    `student@oss~$` `kubectl port-forward day2-warmup 2224:5055 --address=0.0.0.0`

    > This will use your `kubectl` connection to temporarily open a port-forward between your local machine and your pod!
  
5. Split your screen with TMUX (`ctrl b`, hands off keyboard, `shift 5`).

6. Hop back into `oss`.

    `student@bchd~$` `ssh oss`

7. Try the following `curl` commands. They will only work IF you created your pod correctly AND if your port-forward command is still working!

    `student@oss~$` `curl localhost:2224`
    
    `student@oss~$` `curl localhost:2224/tmnt`
    
    `student@oss~$` `curl localhost:2224/splinter`
