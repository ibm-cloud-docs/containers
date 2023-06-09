---

copyright: 
  years: 2014, 2023
lastupdated: "2023-06-09"

keywords: kubernetes, oomkilled, out of memory

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Why does the Kubernetes dashboard terminate with an out of memory error?
{: #ts-kube-dashboord-oom}
{: support}

When listing pods in large clusters, the dashboard interface performs poorly and terminates in a `OOMKilled` error.
{: ts_symptoms}

```sh
Last State:     Terminated
  Reason:       OOMKilled
  Exit Code:    137
```
{: screen}

The Kubernetes dashboard for your cluster requires a large amount of memory.
{: ts_causes}

You can resolve this issue by changing the `resource auto-refresh` time interval to `60` for the Kubernetes dashboard.
{: ts_resolve}


## Changing the resource auto refresh time interval from the Kubernetes dashboard
{: #ts-dashboard-auto-refresh}


1. Select *Settings* in the navigation pane.
1. Set `Resource auto-refresh` time interval to `60`.
1. `Save`

## Changing the resource auto refresh time interval from the command line
{: #ts-dashboard-auto-refresh-cli}


[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
1. Edit your Kubernetes dashboard ConfigMap.
    ```sh
    kubectl -n kube-system edit configmap kubernetes-dashboard-settings
    ```
    {: pre}

1. In the `data._global` field, set the `resourceAutoRefreshTimeInterval` to `60`.
    Example ConfigMap with `resourceAutoRefreshTimeInterval` set to `60`. 
    ```sh
    apiVersion: v1
    data:
    _global: '{"clusterName":"mycluster","itemsPerPage":10,"logsAutoRefreshTimeInterval":5,"resourceAutoRefreshTimeInterval":60}'
    kind: ConfigMap
    metadata:
    creationTimestamp: "2021-06-08T04:23:35Z"
    labels:
        addonmanager.kubernetes.io/mode: EnsureExists
        k8s-app: kubernetes-dashboard
    name: kubernetes-dashboard-settings
    namespace: kube-system
    resourceVersion: "1253"
    uid: c1d39cdb-329e-4cf4-b714-954178984a53
    ```
    {: pre}

1. Exit the editor.
1. Find the pod name for the `kubenertes-dashboard` pod.
    ```sh
    kubectl -n kube-system get pods | grep kubernetes-dashboard
    ```
    {: pre}

    ```sh
    kubernetes-dashboard-549b67cb67-24pft                 1/1     Running   0          40d
    ```
    {: screen}

1. Restart the dashboard by deleting the `kubernetes-dashboard` pod.

    ```sh
    kubectl -n kube-system delete pod kubernetes-dashboard-xxx
    ```
    {: pre}


