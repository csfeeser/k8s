# (Not Much Of A) Challenge Lab: Kubernetes Node Version

<img src="https://github.com/user-attachments/assets/c08bd167-1e1e-449e-aba1-e11fcdec5df2" alt="Image" width="300px" />

Let's get warmed up! At our current stage, there isn't much we can do with our fledgling cluster. However, the following task IS one that would show up in the CKA exam. It wouldn't be worth that many points, but still!

#### Objective
Your task is to:
1. Determine the version of Kubernetes running on the controller node.
2. Write that version to the file `/tmp/nodeversion.txt`.

<details>
  <summary>Solution</summary>

  You can accomplish this by using two commands:

  - **`kubectl get nodes`**: This command shows the list of nodes along with some basic information like their status, role, and the Kubernetes version they are running.
  - **`kubectl version`**: This command provides details about the Kubernetes version installed on both the client and server.

  And then `echo "1.29.4" > /tmp/nodeversion.txt` and you're done!
  
</details>
