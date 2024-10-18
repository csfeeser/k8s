# Creating, Updating, and Version Controlling Charts with Helm!

<img src="https://media.makeameme.org/created/take-this-helmchart.jpg" alt="image" width="300"/>

### **1. Create a Custom Helm Chart**

We will create a Helm chart named `myapp` that deploys a simple Nginx web server.

#### Step 1: Install Helm (if not installed)

`student@bchd:~$` `sudo snap install helm --classic`

#### Step 2: Create a new Helm chart

`student@bchd:~$` `helm create myapp`

This command will generate the basic directory structure for a Helm chart.

`student@bchd:~$` `sudo apt install tree -y`

`student@bchd:~$` `tree myapp`

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

`student@bchd:~$` `vim myapp/values.yaml`

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

`student@bchd:~$` `vim myapp/templates/deployment.yaml`

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

`student@bchd:~$` `vim myapp/templates/service.yaml`

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

We don't need the other templates, so let's delete them. (Alternatively, we could tell Helm to ignore them in the `myapp/.helmignore` file)

`student@bchd:~$` `rm ~/myapp/templates/hpa.yaml && rm ~/myapp/templates/ingress.yaml && rm ~/myapp/templates/serviceaccount.yaml`

Now install the `myapp` chart in the Kubernetes cluster.

`student@bchd:~$` `helm install myapp ./myapp`

This will deploy Nginx using the values specified in the `values.yaml` file.

#### Step 7: Verify the installation

`student@bchd:~$` `helm list`

You should see the `myapp` release in the list.

```
NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     1           2024-10-17 12:00:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.21.1
```

### **2. Rolling Back to a Previous Helm Release**

Now, let’s modify the chart and perform a rollback to demonstrate how to roll back to a previous release.

#### Step 1: Modify the `values.yaml`

Let’s assume we want to update the image tag to a different version (e.g., `nginx:1.19.0`). Open `values.yaml` and make this change.

`student@bchd:~$` `vim myapp/values.yaml`

```yaml
image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "1.19.0"
```

#### Step 2: Upgrade the Helm release

After modifying `values.yaml`, run the following command to upgrade the release:

`student@bchd:~$` `helm upgrade myapp ./myapp`

Helm will update the deployment to use `nginx:1.19.0`.

`student@bchd:~$` `kubectl describe pods | grep nginx:1.19.0`

You should see the pods running the correct version of the image (`nginx:1.19.0`).

#### Step 3: Verify the upgrade

`student@bchd:~$` `helm list`

You should see that the `REVISION` has incremented.

```
NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     2           2024-10-17 12:05:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.19.0
```

#### Step 4: Roll back to the previous release

Suppose the new version caused issues, and you need to roll back to the previous working release (version 1).

`student@bchd:~$` `helm rollback myapp 1`

This command rolls back the release to revision 1.

#### Step 5: Verify the rollback

`student@bchd:~$` `helm list`

You should see that the `REVISION` has incremented again, but the `APP VERSION` should reflect the previous image tag (`nginx:1.21.1`).

```
NAME    NAMESPACE   REVISION    UPDATED                                 STATUS      CHART        APP VERSION
myapp   default     3           2024-10-17 12:10:00.000000000 +0000 UTC deployed    myapp-0.1.0  1.21.1
```

#### Step 6: Confirm rollback was successful

`student@bchd:~$` `kubectl describe pods | grep nginx:1.21.1`

You should see the pods running the correct version of the image (`nginx:1.21.1`).

We're done, so you can have Helm tear everything down!

`student@bchd:~$` `helm uninstall myapp`
