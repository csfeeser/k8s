### Namespace Alternate Activity Goals

1. **Create a Namespace**:
   - Goal: Create a namespace named `team-resources`.

2. **Define a ResourceQuota**:
   - Goal: Create a ResourceQuota named `team-quota` with the following specifications:
     - CPU limit of 4 cores in total for the namespace.
     - Memory limit of 2Gi (gigabytes) in total for the namespace.
     - Maximum 2 Pods can be created in the namespace.

3. **Apply the ResourceQuota to the Namespace**:
   - Goal: Apply the `team-quota` ResourceQuota to the `team-resources` namespace.

4. **Test the ResourceQuota**:
   - Try to deploy 3 pods in the `team-resources` namespace using any image (e.g., `nginx`). Verify that the 3rd pod fails to deploy due to the ResourceQuota.

5. **Modify the ResourceQuota** (Optional Challenge):
   - Adjust the `team-quota` to allow 3 Pods.
  
