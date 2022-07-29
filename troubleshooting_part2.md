# Troubleshooting Challenge, Part 2!

<img src="https://www.jeffgeerling.com/sites/default/files/images/kubectl-meme-image.jpg" width="300"/>

Knowing how to troubleshoot is a skill that is essential to becoming a proficient Kubernetes Developer or Administrator.

The objective of this challenge is to fix broken stuff. To simulate this, you'll run bash scripts to run that will cause things to break!

### SETUP

1. The first thing we'll do is create some havoc in our cluster. 

    `student@bchd` `cd && wget https://static.alta3.com/projects/k8s/havoc01.sh && bash havoc01.sh`
    
0. The office slacker has done it again. They created a Deployment that is expecting to have three Pods available inside of a namespace called **fail01**. Take a look at your deployment that is currently running.

    `student@bchd:~$` `kubectl get deploy -n fail01`
    
        NAME          READY   UP-TO-DATE   AVAILABLE   AGE
        failingpods   2/3     2            2           1m
    
0. You have a Pod where one of the containers is failing. Fix it :)
