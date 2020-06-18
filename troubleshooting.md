# Troubleshooting

Knowing how to troubleshoot is a skill that is essential to becoming a proficient Kubernetes Developer or Administrator.

The objective of this lab is to fix broken stuff. In this lab you will be given bash scripts to run that will cause things to break. **Please attempt to fix the issues using k8s techniques**.

### Lab Objectives

- Troubleshoot application failure

### Procedure

#### Havoc, Part 1

0. Make sure you're in your home directory.

    `student@k8s-000-bchd:~$` `cd ~`

0. The first thing we'll do is create some havoc in our cluster. 

    `student@k8s-000-bchd` `wget https://static.alta3.com/projects/k8s/havoc01.sh && bash havoc01.sh`
    
0. In order for you to troubleshoot, you have to know what your end goal is. You have used misguided judgement and created a Deployment that is expecting to have three Pods available inside of a namespace called **fail01**. Take a look at your deployment that is currently running.

    `student@k8s-000-bchd:~$` `kubectl get deploy -n fail01`
    
        NAME          READY   UP-TO-DATE   AVAILABLE   AGE
        failingpods   2/3     2            2           1m
    
0. You have a Pod where one of the containers is failing. Fix it :)

   
  #### Havoc, Part 2
  
  In this section, you simply have to find what is failing about your pod and fix it.
  
0. Now let's have some fun. Run the following command to send more trouble your way.

    `student@k8s-000-bchd:~$` `wget https://static.alta3.com/projects/k8s/havoc02.sh && bash havoc02.sh`

0. Let's see what your Pod is up to.

    `student@k8s-000-bchd:~$` `kubectl get pods -n fail02`

        NAME           READY   STATUS         RESTARTS   AGE
        failingpod02   0/1     ErrImagePull   0          12s
    
    
0. Something about the **image** is not right. Fix it :)

#### The solutions to these errors can be found in Lab 43: Troubleshooting
