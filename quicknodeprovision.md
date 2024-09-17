# Worker Node Provisioning (E-Z MODE)

<img src="https://github.com/user-attachments/assets/2964771b-0053-4f2c-9185-816c043b1ff5" alt="Picture3" width="300"/>

1. Head to your first worker node.

   `student@XYZ~$` `ssh node-1`

2. Download the bash script.

    `student@node-1~$` `wget https://raw.githubusercontent.com/csfeeser/k8s/master/steps1to26.sh`

3. Run that bad boy. Hit `Enter` during any pink screens that pop up, answer `yes` to any yes/no questions, and when prompted for a password it is `alta3`.

    `student@node-1~$` `bash steps1to26`

4. Do steps 27 onward normally inside [Lab 17. 💻 Join Node to Cluster](https://live.alta3.com/content/cka/labs/content/kubernetes/kubeadm/kubeadm-join-node-lab.html)
