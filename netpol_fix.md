# Network Policy Warmup!

<img src="https://miro.medium.com/v2/resize:fit:1348/0*AcFbvqN537AoQOco.png" alt="image" width="300"/>

Welcome to your **Network Policies Warmup Challenge**! Your mission, should you choose to accept it, is to:

1. Fix a broken `NetworkPolicy` manifest.
2. Confirm the pods and services are correctly set up.
3. Verify that the network policy is functioning as expected.

### Step 1: Run the Setup Command

Run the following command to set up the lab environment:

`student@bchd:~$` `drill network-policies`

This will create the necessary resources, including two deployments (`pit` and `stem`) in the `cherry` namespace. Both are exposed via services.

### Step 2: Verify Pods and Their Labels

To see the running pods and their labels, use the following command:

`student@bchd:~$` `kubectl get pods -n cherry --show-labels`

You should see output similar to this:

```
NAME                   READY   STATUS    RESTARTS   AGE   LABELS
pit-576b957d68-ftt2j   1/1     Running   0          15s   app=pit,pod-template-hash=576b957d68,version=v2
pit-576b957d68-pz978   1/1     Running   0          15s   app=pit,pod-template-hash=576b957d68,version=v2
pit-576b957d68-tvghb   1/1     Running   0          15s   app=pit,pod-template-hash=576b957d68,version=v2
stem-7dfdc97b-d2srz    1/1     Running   0          15s   app=stem,pod-template-hash=7dfdc97b,version=v2
stem-7dfdc97b-px9xz    1/1     Running   0          15s   app=stem,pod-template-hash=7dfdc97b,version=v2
stem-7dfdc97b-twsc9    1/1     Running   0          15s   app=stem,pod-template-hash=7dfdc97b,version=v2
```

You can also check the services with:

`student@bchd:~$` `kubectl get svc -n cherry`

Expected output:

```
NAME           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
pit-service    ClusterIP   172.16.3.83    <none>        8080/TCP   6m47s
stem-service   ClusterIP   172.16.3.247   <none>        8080/TCP   6m47s
```

### Step 3: Fix the Broken Network Policy

Below is a broken NetworkPolicy manifest. The goal of this policy is to prevent outgoing traffic from the `pit` deployment to anything except the `stem` deployment. However, it contains an issue that needs to be fixed.

`student@bchd:~$` `vim cherry-policy.yml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cherry-control
  namespace: cherry
spec:
  podSelector:
    matchLabels:
      app: pit
      version: v2
  policyTypes:
    - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: stem
```

---

### Task: Fix the above manifest and apply it.

After fixing the manifest, apply it with the following command:

`student@bchd:~$` `kubectl apply -f cherry-policy.yml`

### Step 4: Verify Your Fix

Once the manifest is fixed and applied, use the following commands to confirm that traffic from `pit` is only allowed to communicate with `stem` and is blocked from other pods or services.

1. **Verify allowed communication** from `pit` to `stem`:

   ```bash
   kubectl exec -n cherry <pit-pod-name> -- curl -sS stem-service:8080
   ```

   This should work, meaning the `pit` pods can still communicate with the `stem` service.

2. **Verify blocked communication** to any other service or pod:

   ```bash
   kubectl exec -n cherry <pit-pod-name> -- curl -sS pit-service:8080
   ```

   This should **fail**, meaning the `pit` pods are blocked from communicating with anything else besides `stem`.

---

### 👀 Hints (For When You Need a Gentle Nudge)

<details>
  <summary>Need a hint?</summary>

  - The issue is related to the missing `version` label for the `stem` pods. Check that both the `app` and `version` labels are correct in the manifest.

</details>

---

### 🛠️ Solution (Spoilers Ahead!)

<details>
  <summary>Click here for the full solution!</summary>

  ```yaml
  apiVersion: networking.k8s.io/v1
  kind: NetworkPolicy
  metadata:
    name: cherry-control
    namespace: cherry
  spec:
    podSelector:
      matchLabels:
        app: pit
        version: v2  # Correctly specifies version v2 for pit pods
    policyTypes:
      - Egress
    egress:
    - to:
      - podSelector:
          matchLabels:
            app: stem
            version: v2  # The issue was the missing version label for stem pods
  ```

  - **Issue 1**: The `stem` pods were missing the `version: v2` label in the policy.  
  - **Fix**: Add the `version: v2` label to the `stem` pod selector in the `egress` section to allow communication.

</details>

---

### Conclusion

In this warmup, you've fixed a broken `NetworkPolicy` and confirmed its functionality by testing communication between the `pit` and `stem` pods. Understanding how to troubleshoot and validate network policies is a critical skill in Kubernetes!
