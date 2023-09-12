# Working with Helm

| Command Syntax                           | Description                                                                                                                 |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `helm repo add [repo-name] [repo-url]`    | Adds a new Helm chart repository.                                                                                           |
| `helm search repo [chart-name]`          | Searches for Helm charts in the added repositories based on the chart name.                                                 |
| `helm repo list`                          | Lists all added Helm chart repositories.                                                                                    |
| `helm repo remove [repo-name]`           | Removes a Helm chart repository.                                                                                            |
| `helm repo update`                        | Updates the local cache of Helm chart repositories.                                                                         |
| `helm install [release-name] [chart]`     | Installs a Helm chart and creates a new release with the given name.                                                        |
| `helm uninstall [release-name]`           | Uninstalls a Helm release by its name.                                                                                      |
| `helm status [release-name]`              | Shows the status of a specific Helm release.                                                                                |
| `helm show values [chart]`                | Displays the default values that come with the chart itself. These values are in the chart's `values.yaml` file.             |
| `helm get values [release-name]`          | Retrieves the custom values that were set during the installation or last upgrade of a specific release.                     |
| `helm upgrade [release-name] [chart]`     | Upgrades a Helm release to a new version of a chart or updates its configuration using a new chart.                         |

## Helm Practice Challenge:
## OPTION 1: Go to any previous lab, task, or challenge we completed in class where you already have written manifests. Place those manifests in a chart, then convert them to templates populated by a `values.yaml` file.
## OPTION 2: Take the demo we did in class and add more features to it! Code is included below.

Here is the breakdown of the demo we did in class:

```
.
├── Chart.yaml
├── charts
├── templates
│   ├── configmap.yaml
│   └── deploy.yml
└── values.yaml
```

## /\<chartname\>/values.yaml

You may name your variables in `values.yaml` as whatever you like, as long as it matches what is in your templates!

```yaml
# labels
demlabelstho:
  datkey: foxtrot
  datvalue: golf

# replica count
howmanyyouwant: 3

# values in the configmap (names of heroes)
herodata: |
  Wolverine
  Jean Grey
  Storm
  Professor X

# container image info
myimage:
  imagename: nginx
  imagetag: 1.19.6
```

### /\<chartname\>/templates/configmap.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hero
data:
  dchero.txt: |
    {{- .Values.herodata | nindent 4 }}
```

### /\<chartname\>/templates/deploy.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    {{ .Values.demlabelstho.datkey }}: {{ .Values.demlabelstho.datvalue }}
spec:
  replicas: {{ .Values.howmanyyouwant }}
  selector:
    matchLabels:
      {{ .Values.demlabelstho.datkey }}: {{ .Values.demlabelstho.datvalue }}
  template:
    metadata:
      labels:
        {{ .Values.demlabelstho.datkey }}: {{ .Values.demlabelstho.datvalue }}
    spec:
      volumes:
        - name: foobar
          configMap:
            name: hero
      containers:
      - name: {{ .Values.myimage.imagename }}
        image: {{ .Values.myimage.imagename }}:{{ .Values.myimage.imagetag }}
        volumeMounts:
          - name: foobar
            mountPath: /data
        ports:
        - containerPort: 80
```
