### (Not Much Of A) Challenge Lab: Determine Kubernetes Version

In this challenge lab, you will be tasked with determining the version of Kubernetes installed on your controller node and writing that version to a specific file.

#### Objective
Your task is to:
1. Determine the version of Kubernetes running on the controller node.
2. Write that version to the file `/tmp/nodeversion.txt`.

<details>
  <summary>Solution</summary>

  You can accomplish this by using two commands:

  - **`kubectl version`**: This command provides details about the Kubernetes version installed on both the client and server. You are specifically interested in the server version. Use the `--short` flag to simplify the output.
  - **`kubectl get nodes`**: This command shows the list of nodes along with some basic information like their status, role, and the Kubernetes version they are running. The output includes the Kubernetes version for each node, which can help confirm the node's version.

</details>
