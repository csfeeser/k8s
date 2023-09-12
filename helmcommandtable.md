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
