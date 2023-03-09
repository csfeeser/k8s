### NetworkPolicy CKAD Examples

Implement a NetworkPolicy for pods with the label "internal: nginx" to only allow egress to pods with the label "internal: api" on TCP port 3333.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example1
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels: # pods affected by this rule
      internal: nginx
  egress:
   - to:
         - podSelector:
            matchLabels:
              internal: api     
     ports:
      - port: 3333
```

Create a second NetworkPolicy for pods with the label "internal: api" to only allow ingress on port 3333 from pods with the label "internal: nginx".

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example2
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels: # pods affected by this rule
      internal: api
  ingress:
   - from:
         - podSelector:
            matchLabels:
              internal: nginx     
     ports:
      - port: 3333
```
