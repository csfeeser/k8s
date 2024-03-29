# 5G Deployment Day 2- Environment Verification

**Objective:** Ensure your lab environments are correctly configured by performing a series of checks!

- [ ] Local registry accessible from BCHD VM.
- [ ] OSS VM accessible via SSH.
- [ ] Kubernetes cluster operational
- [ ] Kubernetes can access images from the local registry.
      
#### **Part 1: Verify Access to BCHD VM and Local Registry**

1. **SSH into your BCHD VM:**
   - Open your terminal.
   - If your command line says `student@oss`, type `exit` to return to `bchd`.
   - You may have to enter `exit` TWICE.

2. **Check Local Registry Accessibility:**
   - Within the BCHD VM, run:

       `student@bchd:~$` `curl oss.registry/v2/_catalog | json_pp`

   - Your output should look like this:

      ```
        % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                       Dload  Upload   Total   Spent    Left  Speed
      100   473  100   473    0     0   7994      0 --:--:-- --:--:-- --:--:--  8155
      {
         "repositories" : [
            "free5gc-compose-k8s_free5gc-amf",
            "free5gc-compose-k8s_free5gc-ausf",
            "free5gc-compose-k8s_free5gc-n3iwf",
            "free5gc-compose-k8s_free5gc-nrf",
            "free5gc-compose-k8s_free5gc-nssf",
            "free5gc-compose-k8s_free5gc-pcf",
            "free5gc-compose-k8s_free5gc-smf",
            "free5gc-compose-k8s_free5gc-udm",
            "free5gc-compose-k8s_free5gc-udr",
            "free5gc-compose-k8s_free5gc-upf-1",
            "free5gc-compose-k8s_free5gc-upf-2",
            "free5gc-compose-k8s_free5gc-upf-b",
            "free5gc-compose-k8s_free5gc-webui"
         ]
      }
      ```
      
   - If you receive an error or cannot access the local registry, OR if the images above don't show, revisit **Labs 6-10** to ensure your registry setup is correct. Let Chad know!

#### **Part 2: Verify Kubernetes Cluster on OSS VM**

1. **SSH into your OSS VM:**
   - Execute: 

        `student@student:~$` `ssh oss`

2. **Check Kubernetes Nodes:**
   - Run:
     
        `student@oss:~$` `kubectl get nodes`

   - You should see the following:
     
      ```
      NAME   STATUS   ROLES           AGE   VERSION
      oss    Ready    control-plane   16h   v1.28.6
      ```
   
   - If you encounter issues or no nodes are listed, you need to complete **Lab 11** to correctly set up Kubernetes. Let Chad know!

#### **Part 3: Verify Image Accessibility via Kubernetes**

1. **Check Image Pull Capability:**
   - Use the following command to test if Kubernetes can access an image from your local registry we made yesterday:
     
       `student@oss:~$` `kubectl run --rm -i --tty test-image --image=oss.registry/free5gc-compose-k8s_free5gc-nrf --restart=Never --command -- sh`

       > It will take a moment! Give it a sec.
       
       > Whew, that's a long command! kubectl commands are not normally this long, by the way.
       
       > This command is making a temporary pod using one of the images you made yesterday to confirm their accessibility by Kubernetes.
       
   - You should see the following:

      ```
      If you don't see a command prompt, try pressing enter.
      /free5gc/nrf #
      ```
      
   - Type `exit` to return to OSS.
   
   - If the above fails, it likely means your `.toml` file configuration from **Lab 11** is incorrect or needs adjustment. Let Chad know!

**Made it this far? Then congrats! You've successfully completed all goals from yesterday!**
