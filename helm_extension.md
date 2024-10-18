### **1. Create a Custom Helm Chart**

We will create a Helm chart named `myapp` that deploys a simple Nginx web server.

#### Step 1: Install Helm (if not installed)

`student@node:~$` `curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash`

#### Step 2: Create a new Helm chart

`student@node:~$` `helm create myapp`

This command will generate the basic directory structure for a Helm chart.

```
myapp/
├── charts/
├── templates/
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── NOTES.txt
│   ├── service.yaml
│   └── tests/
│       └── test-connection.yaml
├── Chart.yaml
└── values.yaml
```

#### Step 3: Modify `values.yaml`

Edit `values.yaml` to define the values that will be used in the templates. Here's a simple configuration for deploying Nginx:

```yaml
replicaCount: 2

image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "1.21.1"

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false

resources: {}

nodeSelector: {}

tolerations: []

affinity: {}
```

#### Step 4: Customize `deployment.yaml`

Now, let's edit the `templates/deployment.yaml` file to customize the Nginx deployment. Replace its content with:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "myapp.fullname" . }}
  labels:
    app: {{ include "myapp.name" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "myapp.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "myapp.name" . }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 80
```

This file uses the variables defined in `values.yaml`, such as the image and replica count.

#### Step 5: Customize `service.yaml`

Next, modify `templates/service.yaml` to configure the Nginx service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "myapp.fullname" . }}
  labels:
    app: {{ include "myapp.name" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 80
  selector:
    app: {{ include "myapp.name" . }}
```

This will create a `ClusterIP` service, exposing Nginx on port 80.

#### Step 6: Install the custom chart

Now, install the `myapp` chart in the Kubernetes cluster.


`student@node:~$` `helm install myapp ./myapp`


This will deploy Nginx using the values specified in the `values.yaml` file.

#### Step 7: Verify the installation

`student@node:~$` `helm list`

You should see the `myapp` release in the list.

```
NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     1           2024-10-17 12:00:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.21.1
```

### **2. Rolling Back to a Previous Helm Release**

Now, let’s modify the chart and perform a rollback to demonstrate how to roll back to a previous release.

#### Step 1: Modify the `values.yaml`

Let’s assume we want to update the image tag to a different version (e.g., `nginx:1.19.0`).

```yaml
image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "1.19.0"
```

#### Step 2: Upgrade the Helm release

After modifying `values.yaml`, run the following command to upgrade the release:

`student@node:~$` `helm upgrade myapp ./myapp`

Helm will update the deployment to use `nginx:1.19.0`.

#### Step 3: Verify the upgrade

`student@node:~$` `helm list`

You should see that the `REVISION` has incremented.

NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     2           2024-10-17 12:05:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.19.0

#### Step 4: Roll back to the previous release

Suppose the new version caused issues, and you need to roll back to the previous working release (version 1).

`student@node:~$` `helm rollback myapp 1`

This command rolls back the release to revision 1.

#### Step 5: Verify the rollback

`student@node:~$` `helm list

You should see that the `REVISION` has incremented again, but the `APP VERSION` should reflect the previous image tag (`nginx:1.21.1`).

```
NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     3           2024-10-17 12:10:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.21.1
```

#### Step 6: Confirm rollback was successful

`student@node:~$` `kubectl get pods`

You should see the pods running the correct version of the image (`nginx:1.21.1`).

### **Summary of Files**

- **values.yaml**: Defines the configuration for the chart (e.g., image, replica count).
- **deployment.yaml**: Defines the Deployment resource template.
- **service.yaml**: Defines the Service resource template.

### **Final Thoughts**

This demonstration shows how to create a custom Helm chart, install it, perform an upgrade, and roll back to a previous release. Helm makes Kubernetes application management easier by using these automated tools.
