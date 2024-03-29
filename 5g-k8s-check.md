### 5G Deployment Day 2- Environment Verification

**Objective:** Ensure your lab environments are correctly configured by performing a series of checks!

#### **Part 1: Verify Access to BCHD VM and Local Registry**

1. **SSH into your BCHD VM:**
   - Open your terminal.
   - If your command line says `student@oss`, type `exit` to return to `bchd`.

2. **Check Local Registry Accessibility:**
   - Within the BCHD VM, run:
    `student@bchd:$` `curl oss.registry`
   - If you receive an error or cannot access the local registry, revisit **Labs 4-6** to ensure your registry setup is correct. Let Chad know!

#### **Part 2: Verify Kubernetes Cluster on OSS VM**

1. **SSH into your OSS VM:**
   - Execute: 
    `student@bchd$:` `ssh oss`

2. **Check Kubernetes Nodes:**
   - Run: 
    `student@oss$:` `kubectl get nodes`
   - You should see the following:
    ```
    nodez
    ```
   - If you encounter issues or no nodes are listed, you need to complete **Lab 11** to correctly set up Kubernetes.

#### **Part 3: Verify Image Accessibility via Kubernetes**

1. **Check Image Pull Capability:**
   - Use the following command to test if Kubernetes can access an image from your local registry we made yesterday:
     - `student@oss:$` `crictl pull <your-image-name>`
   - Your output should look like this:
    ```
    outputz
    ```
   - If the pull fails, it likely means your `.toml` file configuration from **Lab 11** is incorrect or needs adjustment. Let Chad know!

### **Completion Checklist:**

- [ ] BCHD VM accessible via SSH.
- [ ] Local registry accessible from BCHD VM.
- [ ] OSS VM accessible via SSH.
- [ ] Kubernetes cluster operational
- [ ] Kubernetes can access images from the local registry.