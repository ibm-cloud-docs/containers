---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-03"

keywords: kubernetes, iks, upgrade, version

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}  

# Updating clusters, worker nodes, and cluster components
{: #update}

You can install updates to keep your Kubernetes clusters up-to-date in {{site.data.keyword.containerlong}}.
{:shortdesc}

## Updating the Kubernetes master
{: #master}

Periodically, the Kubernetes project releases [major, minor, or patch updates](/docs/containers?topic=containers-cs_versions#version_types). Updates can affect the Kubernetes API server version or other components in your Kubernetes master. IBM updates the patch version, but you must update the master major and minor versions.
{:shortdesc}

**How do I know when to update the master?**</br>
You are notified in the {{site.data.keyword.cloud_notm}} console and CLI when updates are available, and can also check the [supported versions](/docs/containers?topic=containers-cs_versions) page.

**How many versions behind the latest can the master be?**</br>
IBM generally supports three versions of Kubernetes at a time. You can update the Kubernetes API server no more than two versions ahead of its current version.

For example, if your current Kubernetes API server version is 1.13 and you want to update to 1.16, you must first update to 1.14.

If your cluster runs an unsupported Kubernetes version, follow the [version archive instructions](/docs/containers?topic=containers-cs_versions#k8s_version_archive). To avoid getting in an unsupported state and operational impact, keep your cluster up-to-date.

{[pg-cluster-update.md]}



## Updating from stand-alone worker nodes to worker pools
{: #standalone_to_workerpool}

With the introduction of multizone clusters, worker nodes with the same configuration, such as the machine type, are grouped in worker pools. When you create a new cluster, a worker pool that is named `default` is automatically created for you.
{: shortdesc}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Applies to only classic clusters. VPC clusters always use worker pools.
{: note}

You can use worker pools to spread worker nodes evenly across zones and build a balanced cluster. Balanced clusters are more available and resilient to failures. If a worker node is removed from a zone, you can rebalance the worker pool and automatically provision new worker nodes to that zone. Worker pools are also used to install Kubernetes version updates to all of your worker nodes.  

If you created clusters before multizone clusters became available, your worker nodes are still stand-alone and not automatically grouped into worker pools. You must update these clusters to use worker pools. If not updated, you cannot change your single zone cluster to a multizone cluster.
{: important}

Review the following image to see how your cluster setup changes when you move from stand-alone worker nodes to worker pools.

<img src="images/cs_cluster_migrate.png" alt="Update your cluster from stand-alone worker nodes to worker pools" width="600" style="width:600px; border-style: none"/>

Before you begin:
- Ensure that you have the [**Operator** or **Administrator** {{site.data.keyword.cloud_notm}} IAM platform role](/docs/containers?topic=containers-users#platform) for the cluster.
- {[target]}

To update stand-alone worker nodes to worker pools:

1. List existing stand-alone worker nodes in your cluster and note the **ID**, the **Machine Type**, and **Private IP**.
   ```
   {[icks]} worker ls --cluster <cluster_name_or_ID>
   ```
   {: pre}

2. Create a worker pool and decide on the flavor and the number of worker nodes that you want to add to the pool.
   ```
   {[icks]} worker-pool create classic --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <flavor> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

3. List available zones and decide where you want to provision the worker nodes in your worker pool. To view the zone where your stand-alone worker nodes are provisioned, run `{[icks]} cluster get --cluster <cluster_name_or_ID>`. If you want to spread your worker nodes across multiple zones, choose a [multizone-capable zone](/docs/containers?topic=containers-regions-and-zones#zones).
   ```
   {[icks]} zone ls
   ```
   {: pre}

4. List available VLANs for the zone that you chose in the previous step. If you do not have a VLAN in that zone yet, the VLAN is automatically created for you when you add the zone to the worker pool.
   ```
   {[icks]} vlan ls --zone <zone>
   ```
   {: pre}

5. Add the zone to your worker pool. When you add a zone to a worker pool, the worker nodes that are defined in your worker pool are provisioned in the zone and considered for future workload scheduling. {{site.data.keyword.containerlong}} automatically adds the `failure-domain.beta.kubernetes.io/region` label for the region and the `failure-domain.beta.kubernetes.io/zone` label for the zone to each worker node. The Kubernetes scheduler uses these labels to spread pods across zones within the same region.
   1. **To add a zone to one worker pool**: Replace `<pool_name>` with the name of your worker pool, and fill in the cluster ID, zone, and VLANs with the information you previously retrieved. If you do not have a private and a public VLAN in that zone, do not specify this option. A private and a public VLAN are automatically created for you.

      If you want to use different VLANs for different worker pools, repeat this command for each VLAN and its corresponding worker pools. Any new worker nodes are added to the VLANs that you specify, but the VLANs for any existing worker nodes are not changed.
      ```
      {[icks]} zone add classic --zone <zone> --cluster <cluster_name_or_ID> --worker-pool <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   2. **To add the zone to multiple worker pools**: Add multiple worker pools to the `{[icks]} zone add classic` command. To add multiple worker pools to a zone, you must have an existing private and public VLAN in that zone. If you do not have a public and private VLAN in that zone, consider adding the zone to one worker pool first so that a public and a private VLAN are created for you. Then, you can add the zone to other worker pools. </br></br>It is important that the worker nodes in all your worker pools are provisioned into all the zones to ensure that your cluster is balanced across zones. If you want to use different VLANs for different worker pools, repeat this command with the VLAN that you want to use for your worker pool. {[enable_vlan_spanning]}
      ```
      {[icks]} zone add classic --zone <zone> --cluster <cluster_name_or_ID> -w <pool_name1> -w <pool_name2> -w <pool_name3> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   3. **To add multiple zones to your worker pools**: Repeat the `{[icks]} zone add classic` command with a different zone and specify the worker pools that you want to provision in that zone. By adding more zones to your cluster, you change your cluster from a single zone cluster to a [multizone cluster](/docs/containers?topic=containers-ha_clusters#multizone).

6. Wait for the worker nodes to be deployed in each zone.
   ```
   {[icks]} worker ls --cluster <cluster_name_or_ID>
   ```
   {: pre}
   When the worker node state changes to **Normal** the deployment is finished.

7. Remove your stand-alone worker nodes. If you have multiple stand-alone worker nodes, remove one at a time.
   1. List the worker nodes in your cluster and compare the private IP address from this command with the private IP address that you retrieved in the beginning to find your stand-alone worker nodes.
      ```
      kubectl get nodes
      ```
      {: pre}
   2. Mark the worker node as unschedulable in a process that is known as cordoning. When you cordon a worker node, you make it unavailable for future pod scheduling. Use the `name` that is returned in the `kubectl get nodes` command.
      ```
      kubectl cordon <worker_name>
      ```
      {: pre}
   3. Verify that pod scheduling is disabled for your worker node.
      ```
      kubectl get nodes
      ```
      {: pre}
      Your worker node is disabled for pod scheduling if the status displays **`SchedulingDisabled`**.
   4. Force pods to be removed from your stand-alone worker node and rescheduled onto remaining uncordoned stand-alone worker nodes and worker nodes from your worker pool.
      ```
      kubectl drain <worker_name> --ignore-daemonsets
      ```
      {: pre}
      This process can take a few minutes.

   5. Remove your stand-alone worker node. Use the ID of the worker node that you retrieved with the `{[icks]} worker ls --cluster <cluster_name_or_ID>` command.
      ```
      {[icks]} worker rm --cluster <cluster_name_or_ID> --worker <worker_ID>
      ```
      {: pre}
   6. Repeat these steps until all your stand-alone worker nodes are removed.


**What's next?** </br>
Now that you updated your cluster to use worker pools, you can, improve availability by adding more zones to your cluster. Adding more zones to your cluster changes your cluster from a single zone cluster to a [multizone cluster](/docs/containers?topic=containers-ha_clusters#ha_clusters). When you change your single zone cluster to a multizone cluster, your Ingress domain changes from `<cluster_name>.<region>.containers.mybluemix.net` to `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. The existing Ingress domain is still valid and can be used to send requests to your apps.
