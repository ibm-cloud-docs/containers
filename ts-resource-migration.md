---

copyright: 
  years: 2022, 2024
lastupdated: "2024-06-03"


keywords: kubernetes, tigera, master

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Why do I see the error `Cannot complete cluster master upgrade because there is a migration in progress`?
{: #ts-resource-migration}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc}
[Classic infrastructure]{: tag-classic-inf}

You see the following error message during master upgrade.
{: tsSymptoms}

```sh
Cannot complete cluster master upgrade because there is a migration in progress
```
{: screen}

You are upgrading the cluster master, but some resources were still being migrated from a previous update.
{: tsCauses}

For example, if this was a master update from {{site.data.keyword.containerlong_notm}} version 1.29 to 1.30, the Tigera Operator didn't yet complete its migration from the previous {{site.data.keyword.containerlong_notm}} version 1.28 to 1.29 update.

To resolve the issue, first wait longer. Larger clusters take longer to complete the migration. It takes approximately 100 seconds per node after the master is successfully updated for the migration to complete. The Tigera Operator is required to perform several actions and can involve spinning up and down pods across nodes.
{: tsResolve}

However, it's possible the migration could have gotten stuck. Check if the `calico-typha` and `calico-node` pods were removed from the `kube-system` namespace and created in the `calico-system` namespace. If those resources have not been moved, there might be an issue with one or more worker nodes.

To troubleshoot the migration:

1. Check the status of the worker nodes.
    ```sh
    kubectl get nodes
    ```
    {: pre}

    If you see a worker node that is not in the `Ready` state, such as in the `NotReady` or `SchedulingDisabled` state, the migration might be stuck.

    `NotReady` example:
    ```sh
    NAME            STATUS   ROLES    AGE    VERSION
    10.177.112.32   NotReady <none>   2d2h   v1.30.0+IKS
    10.177.112.50   Ready    <none>   2d2h   v1.30.0+IKS
    10.177.112.52   Ready    <none>   2d2h   v1.30.0+IKS
    ```
    {: screen}

    `SchedulingDisabled` example:
    ```sh
    NAME             STATUS                     ROLES    AGE   VERSION
    10.177.112.32   Ready,SchedulingDisabled   <none>   95m   v1.30.0+IKS
    10.177.112.50   Ready                      <none>   95m   v1.30.0+IKS
    10.177.112.52   Ready                      <none>   95m   v1.30.0+IKS
    ```
    {: screen}

1. For the problem worker nodes, [reboot](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reboot) or [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) them.

Result: 

When the worker nodes are healthy, the `calico-typha` and `calico-node` pods can resume scaling down in the `kube-system` namespace and scaling up in the `calico-system` namespace.

To confirm the migration is complete:

1. Verify that the `calico-typha` deployment no longer exists in the `kube-system` namespace.

    ```sh
    kubectl get deployment calico-typha -n kube-system
    ```
    {: pre}

    Result:
    ```sh
    Error from server (NotFound): deployments.apps "calico-typha" not found
    ```
    {: screen}

1. Verify there aren't any nodes with the `projectcalico.org/operator-node-migration` label.
    ```sh
    kubectl get nodes -l projectcalico.org/operator-node-migration
    ```
    {: pre}

    Result:
    ```sh
    No resources found
    ```
    {: screen}

1. If the migration is still stuck, [replace](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_replace) or [remove](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_rm) the problematic nodes. For more information, see [Debugging worker nodes](/docs/containers?topic=containers-debug_worker_nodes).

When you have confirmed that the migration is complete, proceed with the master update to {{site.data.keyword.containerlong_notm}} version 1.30.


