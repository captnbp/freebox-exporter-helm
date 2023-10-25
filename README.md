<!--- app-name: freebox-exporter -->

# freebox-exporter

freebox-exporter is a simple Prometheus exporter for the Freebox.

[Overview of freebox-exporter](https://github.com/kubernetes/freebox-exporter)

Trademarks: This software listing is packaged. The respective trademarks mentioned in the offering are owned by the respective companies, and use of them does not imply any affiliation or endorsement.

## Introduction

This chart bootstraps [freebox-exporter](https://github.com/trazfr/freebox-exporter) on [Kubernetes](https://kubernetes.io) using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.8.0+
- **IPv6 enabled Kubernetes cluster**

## Installing the Chart

To install the chart with the release name `freebox-exporter`:

1. Install the freebox-exporter localy to retreive the `token.json` file with the API credentials :
    ```console
    go install github.com/trazfr/freebox-exporter@latest
    ```
2. Run the binary create the token.json file :
    ```console
    freebox-exporter -httpDiscovery token.json
    ```
3. Create the Kubernetes secret which will contain the `token.json`
    ```console
    kubectl create namespace freebox-exporter
    kubectl create secret generic -n freebox-exporter freebox-exporter-token --from-file=token.json
    ```
4. Install the chart
    ```console
    helm install -n freebox-exporter freebox-exporter --set configuration.existingSecret=freebox-exporter-token oci://registry-1.docker.io/captnbp/freebox-exporter
    ```

The command deploys freebox-exporter on the Kubernetes cluster in the default configuration. The [configuration](#configuration-and-installation-details) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `freebox-exporter` release:

```console
helm delete -n freebox-exporter freebox-exporter
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |

### Common parameters

| Name                     | Description                                                                                                 | Value          |
| ------------------------ | ----------------------------------------------------------------------------------------------------------- | -------------- |
| `kubeVersion`            | Force target Kubernetes version (using Helm capabilities if not set)                                        | `""`           |
| `nameOverride`           | String to partially override `freebox-exporter.name` template with a string (will prepend the release name) | `""`           |
| `fullnameOverride`       | String to fully override `freebox-exporter.fullname` template with a string                                 | `""`           |
| `namespaceOverride`      | String to fully override common.names.namespace                                                             | `""`           |
| `commonLabels`           | Add labels to all the deployed resources                                                                    | `{}`           |
| `commonAnnotations`      | Add annotations to all the deployed resources                                                               | `{}`           |
| `diagnosticMode.enabled` | Enable diagnostic mode (all probes will be disabled and the command will be overridden)                     | `false`        |
| `diagnosticMode.command` | Command to override all containers in the the deployment(s)/statefulset(s)                                  | `["sleep"]`    |
| `diagnosticMode.args`    | Args to override all containers in the the deployment(s)/statefulset(s)                                     | `["infinity"]` |

### freebox-exporter parameters

| Name                                          | Description                                                                                                         | Value                                                   |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `configuration.existingSecret`                | Secret with token.json configuration file (replaces the configuration.config value)                                 | `""`                                                    |
| `configuration.config`                        | Content of the generated token.json file                                                                            | `""`                                                    |
| `hostAliases`                                 | Add deployment host aliases                                                                                         | `[]`                                                    |
| `serviceAccount.create`                       | Specifies whether a ServiceAccount should be created                                                                | `true`                                                  |
| `serviceAccount.name`                         | Name of the service account to use. If not set and create is true, a name is generated using the fullname template. | `""`                                                    |
| `serviceAccount.automountServiceAccountToken` | Automount service account token for the server service account                                                      | `false`                                                 |
| `serviceAccount.annotations`                  | Annotations for service account. Evaluated as a template. Only used if `create` is `true`.                          | `{}`                                                    |
| `image.registry`                              | freebox-exporter image registry                                                                                     | `docker.io`                                             |
| `image.repository`                            | freebox-exporter image repository                                                                                   | `captnbp/freebox-exporter`                              |
| `image.digest`                                | freebox-exporter image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag    | `""`                                                    |
| `image.pullPolicy`                            | freebox-exporter image pull policy                                                                                  | `IfNotPresent`                                          |
| `image.pullSecrets`                           | Specify docker-registry secret names as an array                                                                    | `[]`                                                    |
| `extraArgs`                                   | Additional command line arguments to pass to freebox-exporter                                                       | `{}`                                                    |
| `command`                                     | Override default container command (useful when using custom images)                                                | `["/app/freebox-exporter"]`                             |
| `args`                                        | Override default container args (useful when using custom images)                                                   | `["-httpDiscovery","/opt/freebox-exporter/token.json"]` |
| `lifecycleHooks`                              | for the freebox-exporter container(s) to automate configuration before or after startup                             | `{}`                                                    |
| `extraEnvVars`                                | Array with extra environment variables to add to freebox-exporter nodes                                             | `[]`                                                    |
| `extraEnvVarsCM`                              | Name of existing ConfigMap containing extra env vars for freebox-exporter pod(s)                                    | `""`                                                    |
| `extraEnvVarsSecret`                          | Name of existing Secret containing extra env vars for freebox-exporter pod(s)                                       | `""`                                                    |
| `extraVolumes`                                | Optionally specify extra list of additional volumes for the freebox-exporter pod(s)                                 | `[]`                                                    |
| `extraVolumeMounts`                           | Optionally specify extra list of additional volumeMounts for the freebox-exporter container(s)                      | `[]`                                                    |
| `sidecars`                                    | Add additional sidecar containers to the freebox-exporter pod(s)                                                    | `[]`                                                    |
| `initContainers`                              | Add additional init containers to the freebox-exporter pod(s)                                                       | `[]`                                                    |
| `podSecurityContext.enabled`                  | Enabled freebox-exporter pods' Security Context                                                                     | `true`                                                  |
| `podSecurityContext.fsGroup`                  | Set freebox-exporter pod's Security Context fsGroup                                                                 | `1001`                                                  |
| `containerSecurityContext.enabled`            | Enabled freebox-exporter containers' Security Context                                                               | `true`                                                  |
| `containerSecurityContext.runAsUser`          | Set freebox-exporter containers' Security Context runAsUser                                                         | `1001`                                                  |
| `containerSecurityContext.runAsNonRoot`       | Set freebox-exporter container's Security Context runAsNonRoot                                                      | `true`                                                  |
| `service.type`                                | Kubernetes service type                                                                                             | `ClusterIP`                                             |
| `service.ports.http`                          | freebox-exporter service port                                                                                       | `9091`                                                  |
| `service.nodePorts.http`                      | Specify the nodePort value for the LoadBalancer and NodePort service types.                                         | `""`                                                    |
| `service.clusterIP`                           | Specific cluster IP when service type is cluster IP. Use `None` for headless service                                | `""`                                                    |
| `service.loadBalancerIP`                      | `loadBalancerIP` if service type is `LoadBalancer`                                                                  | `""`                                                    |
| `service.loadBalancerSourceRanges`            | Address that are allowed when svc is `LoadBalancer`                                                                 | `[]`                                                    |
| `service.externalTrafficPolicy`               | freebox-exporter service external traffic policy                                                                    | `Cluster`                                               |
| `service.extraPorts`                          | Extra ports to expose (normally used with the `sidecar` value)                                                      | `[]`                                                    |
| `service.annotations`                         | Additional annotations for freebox-exporter service                                                                 | `{}`                                                    |
| `service.labels`                              | Additional labels for freebox-exporter service                                                                      | `{}`                                                    |
| `service.sessionAffinity`                     | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                | `None`                                                  |
| `service.sessionAffinityConfig`               | Additional settings for the sessionAffinity                                                                         | `{}`                                                    |
| `service.ipFamilyPolicy`                      | Controller Service ipFamilyPolicy (optional, cloud specific)                                                        | `PreferDualStack`                                       |
| `service.ipFamilies`                          | Controller Service ipFamilies (optional, cloud specific)                                                            | `[]`                                                    |
| `hostNetwork`                                 | Enable hostNetwork mode                                                                                             | `false`                                                 |
| `priorityClassName`                           | Priority class assigned to the Pods                                                                                 | `""`                                                    |
| `schedulerName`                               | Name of the k8s scheduler (other than default)                                                                      | `""`                                                    |
| `terminationGracePeriodSeconds`               | In seconds, time the given to the freebox-exporter pod needs to terminate gracefully                                | `""`                                                    |
| `topologySpreadConstraints`                   | Topology Spread Constraints for pod assignment                                                                      | `[]`                                                    |
| `resources.limits`                            | The resources limits for the container                                                                              | `{}`                                                    |
| `resources.requests`                          | The requested resources for the container                                                                           | `{}`                                                    |
| `replicaCount`                                | Desired number of controller pods                                                                                   | `1`                                                     |
| `podLabels`                                   | Pod labels                                                                                                          | `{}`                                                    |
| `podAnnotations`                              | Pod annotations                                                                                                     | `{}`                                                    |
| `updateStrategy`                              | Allows setting of `RollingUpdate` strategy                                                                          | `{}`                                                    |
| `minReadySeconds`                             | How many seconds a pod needs to be ready before killing the next, during update                                     | `0`                                                     |
| `podAffinityPreset`                           | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `""`                                                    |
| `podAntiAffinityPreset`                       | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                            | `soft`                                                  |
| `nodeAffinityPreset.type`                     | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                           | `""`                                                    |
| `nodeAffinityPreset.key`                      | Node label key to match. Ignored if `affinity` is set.                                                              | `""`                                                    |
| `nodeAffinityPreset.values`                   | Node label values to match. Ignored if `affinity` is set.                                                           | `[]`                                                    |
| `affinity`                                    | Affinity for pod assignment                                                                                         | `{}`                                                    |
| `nodeSelector`                                | Node labels for pod assignment                                                                                      | `{}`                                                    |
| `tolerations`                                 | Tolerations for pod assignment                                                                                      | `[]`                                                    |
| `livenessProbe.enabled`                       | Turn on and off liveness probe                                                                                      | `false`                                                 |
| `livenessProbe.initialDelaySeconds`           | Delay before liveness probe is initiated                                                                            | `120`                                                   |
| `livenessProbe.periodSeconds`                 | How often to perform the probe                                                                                      | `10`                                                    |
| `livenessProbe.timeoutSeconds`                | When the probe times out                                                                                            | `5`                                                     |
| `livenessProbe.failureThreshold`              | Minimum consecutive failures for the probe                                                                          | `6`                                                     |
| `livenessProbe.successThreshold`              | Minimum consecutive successes for the probe                                                                         | `1`                                                     |
| `readinessProbe.enabled`                      | Turn on and off readiness probe                                                                                     | `false`                                                 |
| `readinessProbe.initialDelaySeconds`          | Delay before readiness probe is initiated                                                                           | `30`                                                    |
| `readinessProbe.periodSeconds`                | How often to perform the probe                                                                                      | `10`                                                    |
| `readinessProbe.timeoutSeconds`               | When the probe times out                                                                                            | `5`                                                     |
| `readinessProbe.failureThreshold`             | Minimum consecutive failures for the probe                                                                          | `6`                                                     |
| `readinessProbe.successThreshold`             | Minimum consecutive successes for the probe                                                                         | `1`                                                     |
| `startupProbe.enabled`                        | Turn on and off startup probe                                                                                       | `false`                                                 |
| `startupProbe.initialDelaySeconds`            | Delay before startup probe is initiated                                                                             | `30`                                                    |
| `startupProbe.periodSeconds`                  | How often to perform the probe                                                                                      | `10`                                                    |
| `startupProbe.timeoutSeconds`                 | When the probe times out                                                                                            | `5`                                                     |
| `startupProbe.failureThreshold`               | Minimum consecutive failures for the probe                                                                          | `6`                                                     |
| `startupProbe.successThreshold`               | Minimum consecutive successes for the probe                                                                         | `1`                                                     |
| `customStartupProbe`                          | Custom liveness probe for the Web component                                                                         | `{}`                                                    |
| `customLivenessProbe`                         | Custom liveness probe for the Web component                                                                         | `{}`                                                    |
| `customReadinessProbe`                        | Custom readiness probe for the Web component                                                                        | `{}`                                                    |
| `serviceMonitor.enabled`                      | Creates a ServiceMonitor to monitor freebox-exporter                                                                | `true`                                                  |
| `serviceMonitor.namespace`                    | Namespace in which Prometheus is running                                                                            | `""`                                                    |
| `serviceMonitor.jobLabel`                     | The name of the label on the target service to use as the job name in prometheus.                                   | `""`                                                    |
| `serviceMonitor.interval`                     | Scrape interval (use by default, falling back to Prometheus' default)                                               | `""`                                                    |
| `serviceMonitor.scrapeTimeout`                | Timeout after which the scrape is ended                                                                             | `""`                                                    |
| `serviceMonitor.selector`                     | ServiceMonitor selector labels                                                                                      | `{}`                                                    |
| `serviceMonitor.honorLabels`                  | Honor metrics labels                                                                                                | `false`                                                 |
| `serviceMonitor.relabelings`                  | ServiceMonitor relabelings                                                                                          | `[]`                                                    |
| `serviceMonitor.metricRelabelings`            | ServiceMonitor metricRelabelings                                                                                    | `[]`                                                    |
| `serviceMonitor.labels`                       | Extra labels for the ServiceMonitor                                                                                 | `{}`                                                    |
| `serviceMonitor.extraParameters`              | Any extra parameter to be added to the endpoint configured in the ServiceMonitor                                    | `{}`                                                    |
| `serviceMonitor.sampleLimit`                  | Per-scrape limit on number of scraped samples that will be accepted.                                                | `""`                                                    |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install -n freebox-exporter freebox-exporter -f values.yaml oci://registry-1.docker.io/captnbp/freebox-exporter
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## License

MIT License

Copyright (c) 2023 Benoît Pourre

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.