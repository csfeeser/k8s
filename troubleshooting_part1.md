# Troubleshooting Challenge

<img src="https://kubernetes.io/images/blog/2018-09-06-2018-steering-committee-election-cycle-kicks-off/sc-elections.png" width="300"/>

Knowing how to troubleshoot is a skill that is essential to becoming a proficient Kubernetes Developer or Administrator.

The objective of this challenge is to fix broken stuff. To simulate this, you'll run bash scripts to run that will cause things to break!

### SETUP

1. Create some havoc in your cluster! 

    `student@bchd` `cd && wget https://static.alta3.com/projects/k8s/havoc02.sh && bash havoc02.sh`
    
### SCENARIO

You're competently working on your own projects when the office slacker pings you. "Hey, uh, there's something, uh, wrong inside the `fail02` namespace. Can you, like, help?" You sigh, knowing you're not going to get anything else useful out of them and turn to your CLI.

**Find what's wrong in the `fail02` namespace and fix it!**

Recommended commands:

- `kubectl get`
- `kubectl describe`
- `kubectl edit`
- **NEW RESOURCE OBJECT** `kubectl get events`

<details>
<summary>Hint #1</summary>
<br>
kubectl get pods -n fail02  
</details>

<details>
<summary>Hint #2</summary>
<br>
kubectl get events -n fail02  
</details>

<details>
<summary>Hint #3</summary>
<br>
There is a typo in the image name!
</details>

<details>
<summary>Solution</summary>
<br>
kubectl edit pod failingpod02 -n fail02  
<br>
Change line 18.  
</details>
