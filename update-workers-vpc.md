---

copyright:
  years: 2026, 2026
lastupdated: "2026-11-05"


keywords: containers, {{site.data.keyword.containerlong_notm}}, update VPC worker nodes, worker replace, worker reload, bare metal

subcollection: containers

content-type: howto

---

{{site.data.keyword.attribute-definition-list}}


# Updating VPC worker nodes
{: #update-workers-vpc}

VPC worker nodes are updated differently depending on their type. The `ibmcloud ks worker update` command is not supported for any VPC worker node. In all cases, the cluster master must be updated first.
{: shortdesc}

## How VPC worker node updates work
{: #vpc-worker-faq}



- **VPC bare metal workers** and **VPC virtual server instance (VSI) workers**: Replaced using `ibmcloud ks worker replace --update` (to match the master version) or `ibmcloud ks worker replace` (patch refresh only). The old node is deleted and a new one is provisioned.


You can make two types of updates:

* **Patch**: Applies security fixes and updates to the latest patch of the current BOM version. Use `ibmcloud ks worker replace`.
* **Major.minor**: Moves the worker node Kubernetes version up to match the master. Your worker nodes can be at most two versions behind the master (`n-2`). Use `ibmcloud ks worker replace --update`.

What happens to my apps during an update?
:   Apps that run on updated worker nodes are rescheduled onto other worker nodes in the cluster. These worker nodes might be in a different worker pool. To avoid downtime, make sure that you have enough capacity in your cluster to carry the workload before you start the update. For more information, see [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic) or [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc).

What happens to my worker node during an update?
:   The worker node is replaced by removing the old worker node and provisioning a new worker node that runs at the updated patch or `major.minor` version. The replacement worker node is created in the same zone, same worker pool, and with the same flavor as the deleted worker node. However, the replacement worker node is assigned a new private IP address, and loses any custom labels or taints that you applied to the old worker node (worker pool labels and taints are still applied to the replacement worker node).

What if I replace multiple worker nodes at the same time?
:   If you replace multiple worker nodes at the same time, they are deleted and replaced concurrently, not one by one. Make sure that you have enough capacity in your cluster to reschedule your workloads before you replace worker nodes.

What if a replacement worker node is not created?
:   A replacement worker node is not created if the worker pool does not have [automatic rebalancing enabled](/docs/containers?topic=containers-auto-rebalance-off).



## Prerequisites
{: #vpc-worker-prereqs}

Before you update your VPC infrastructure worker nodes, complete the following prerequisite steps.
{: shortdesc}

The worker node is deleted and replaced with a new node. Data that is not [stored on persistent storage](/docs/containers?topic=containers-storage-plan) is permanently deleted. Verify that any data you need to retain is stored outside the worker node before you begin.
{: important}

Also consider the following storage and networking cases before you update.

* If you have Portworx deployed in your cluster, follow the steps to [update VPC worker nodes with Portworx volumes](/docs/containers?topic=containers-storage_portworx_update#portworx_vpc_up) instead of the steps on this page.


1. Complete the steps in [Preparing to update your cluster](/docs/containers?topic=containers-update-prepare).
2. [Update the master](/docs/containers?topic=containers-update-master). The worker node version can't be higher than the API server version that runs in the master.

## Updating VPC worker nodes in the CLI
{: #vpc-worker-cli}
{: cli}

Complete the following steps to update your worker nodes by using the CLI.
{: shortdesc}

1. Complete the [prerequisite steps](#vpc-worker-prereqs).
2. Optional: Add capacity to your cluster by resizing the worker pool. The pods on the worker node can be rescheduled and continue running on the added worker nodes during the update. For more information, see [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic) or [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc).
3. List the worker nodes in your cluster and note the **ID** and **Primary IP** of the worker node that you want to update.
    ```sh
    ibmcloud ks worker ls --cluster CLUSTER
    ```
    {: pre}

4. Update the worker node. When you replace or reload a worker node, the pods that run on it are drained and rescheduled onto the remaining worker nodes, and the node is cordoned.

    Use the `worker replace` command to update either the patch version or the `major.minor` version that matches the master version.

    *  To update the worker node to the same `major.minor` version as the master, such as from 1.35 to 1.36, include the `--update` option.
        ```sh
        ibmcloud ks worker replace --cluster CLUSTER --worker WORKER-NODE-ID --update
        ```
        {: pre}

    *  To update the worker node to the latest patch version at the same `major.minor` version, such as from 1.35.8_1530 to 1.35.9_1533, don't include the `--update` option.
        ```sh
        ibmcloud ks worker replace --cluster CLUSTER --worker WORKER-NODE-ID
        ```
        {: pre}

5. Repeat these steps for each worker node that you must update.
6. Optional: After the replaced worker nodes are in a **Ready** status, resize the worker pool to meet the cluster capacity that you want. For more information, [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc).

If you are running Portworx in your VPC cluster, you must [manually attach your {{site.data.keyword.block_storage_is_short}} volume to your new worker node.](/docs/containers?topic=containers-storage_portworx_update)
{: note}



## Updating VPC worker nodes in the console
{: #vpc-worker-ui}
{: ui}

You can update your VPC worker nodes in the console. Before you begin, consider [adding worker nodes](/docs/containers?topic=containers-add-workers-vpc) to the cluster to help avoid downtime for your apps.
{: shortdesc}

What the **Update** action does depends on the worker node type:

- **All VPC workers**: The worker node is replaced with a new node at the updated version.

1. Complete the [prerequisite steps](#vpc-worker-prereqs).
2. From the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external} menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Containers** > **Clusters**.
3. From the **Clusters** page, click your cluster.
4. From the **Worker Nodes** tab, select the checkbox for each worker node that you want to update. An action bar is displayed over the table header row.
5. From the action bar, click **Update**.

## Next steps
{: #vpc-worker-next-steps}

Repeat the update process with other worker pools. When all worker pools are updated, [update your cluster components and managed add-ons](/docs/containers?topic=containers-update-components).

Notify all developers who work in the cluster to [update their `kubectl` CLI](/docs/containers?topic=containers-cli-install) to match the Kubernetes master version. Running a `kubectl` client that is two or more versions apart from the server version is not supported and can cause unexpected errors.
{: important}

## Related links
{: #vpc-worker-related}

* [Updating clusters, worker nodes, and cluster components](/docs/containers?topic=containers-update)
* [Worker node states](/docs/containers?topic=containers-worker-node-state-reference)
* [Why doesn't replacing a worker node create a worker node?](/docs/containers?topic=containers-auto-rebalance-off)
