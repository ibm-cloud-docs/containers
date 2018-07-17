.html#single_zone). The available zone was pre-defined when the {{site.data.keyword.Bluemix_dedicated_notm}} environment was set up. By default, a single zone cluster is set up with a worker pool that is named `default`. The worker pool groups worker nodes with the same configuration, such as the machine type, that you defined during cluster creation. You can add more worker nodes to your cluster by [resizing an existing worker pool](cs_clusters.html#resize_pool) or by [adding a new worker pool](cs_clusters.html#add_pool). When you add a worker pool, you must add the available zone to the worker pool so that workers can deploy into the zone. However, you cannot add other zones to your worker pools.</dd>
</dl>

### I'm ready to make a multizone cluster. How can I get started?
{: #mz_gs}

Start today in the [{{site.data.keyword.containershort_notm}} console](https://console.bluemix.net/containers-kubernetes/clusters) by clicking **Create Cluster**.

You can create a cluster in one of the [multizone cities](cs_regions.html#zones):
* Dallas in US South region: dal10, dal12, dal13
* Washington DC in US East region: wdc04, wdc06, wdc07
* Frankfurt in EU Central region: fra02, fra04, fra05
* London in UK South region: lon02, lon04, lon06

**Can I update my current stand-alone cluster to a multizone cluster?**</br>
If the cluster is in one of the supported multizone locations, yes. See [Updating from stand-alone worker nodes to worker pools](cs_cluster_update.html#standalone_to_workerpool).

**I created my multizone cluster. Why is there still only one zone? How do I add zones to my cluster?**</br>
If you [create your multizone cluster with the CLI](#clusters_cli), the cluster is created, but you must add zones to the worker pool to complete the process. To span across multiple zones, your cluster must be in a [multizone metro city](cs_regions.html#zones). To add a zone to your cluster and spread worker nodes across zones, see [Adding a zone to your cluster](#add_zone).

### Going forward, what are some changes from how I currently manage my clusters?
{: #mz_new_ways}

With the introduction of worker pools, you can use a new set of APIs and commands to manage your cluster. You can see these new commands in the [CLI documentation page](cs_cli_reference.html#cs_cli_reference), or in your terminal by running `ibmcloud cs help`.

The following table compares the old and new methods for a few common cluster management actions.
<table summary="The table shows the description of the new way to perform multizone commands. Rows are to be read from the left to right, with the description in column one, the old way in column two, and the new multizone way in column three.">
<caption>New methods for multizone worker pool commands.</caption>
  <thead>
  <th>Description</th>
  <th>Old stand-alone worker nodes</th>
  <th>New multizone worker pools</th>
  </thead>
  <tbody>
    <tr>
    <td>Add worker nodes to the cluster.</td>
    <td><strong>Deprecated</strong>: <code>ibmcloud cs worker-add</code> to add stand-alone worker nodes.</td>
    <td><ul><li>To add different machine types than your existing pool, create a new worker pool: <code>ibmcloud cs worker-pool-create</code> [command](cs_cli_reference.html#cs_worker_pool_create).</li>
    <li>To add worker nodes to an existing pool, resize the number of nodes per zone in the pool: <code>ibmcloud cs worker-pool-resize</code> [command](cs_cli_reference.html#cs_worker_pool_resize).</li></ul></td>
    </tr>
    <tr>
    <td>Remove worker nodes from the cluster.</td>
    <td><code>ibmcloud cs worker-rm</code>, which you can still use to delete a troublesome worker node from your cluster.</td>
    <td><ul><li>If your worker pool is unbalanced, for example after removing a worker node), rebalance it: <code>ibmcloud cs worker-pool-rebalance</code> [command](cs_cli_reference.html#cs_rebalance).</li>
    <li>To reduce the number of worker nodes in a pool, resize the number per zone (minimum value of 1): <code>ibmcloud cs worker-pool-resize</code> [command](cs_cli_reference.html#cs_worker_pool_resize).</li></ul></td>
    </tr>
    <tr>
    <td>Use a new VLAN for worker nodes.</td>
    <td><strong>Deprecated</strong>: Add a new worker node that uses the new private or public VLAN: <code>ibmcloud cs worker-add</code>.</td>
    <td>Set the worker pool to use a different public or private VLAN than what it previously used: <code>ibmcloud cs zone-network-set</code> [command](cs_cli_reference.html#cs_zone_network_set).</td>
    </tr>
  </tbody>
  </table>

### How can I learn more about multizone clusters?
{: #learn_more}

The entire documentation was updated for multizone. In particular, you might be interested in the following topics that changed quite a bit with the introduction of multizone clusters:
* [Setting up highly available clusters](#ha_clusters)
* [Planning highly available app deployments](cs_app.html#highly_available_apps)
* [Exposing apps with LoadBalancers for multizone clusters](cs_loadbalancer.html#multi_zone_config)
* [Exposing apps with Ingress](cs_ingress.html#ingress)
* For highly available persistent storage, use a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

## Multiple clusters connected with a global load balancer
{: #multiple_clusters}

To protect your app from a Kubernetes master failure and for regions where multizone clusters are not available, you can create multiple clusters in different zones within a region and connect them with a global load balancer.
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="High availability for multiple clusters" width="700" style="width:700px; border-style: none"/>

To balance your workload across multiple clusters, you must set up a global load balancer and add the IP addresses of your application load balancers (ALBs) or load balancer services to your domain. By adding these IP addresses, you can route incoming traffic between your clusters. For the global load balancer to detect if one of your clusters is unavailable, consider adding a ping-based health check to every IP address. When you set up this check, your DNS provider regularly pings the IP addresses that you added to your domain. If one IP address becomes unavailable, then traffic is not sent to this IP address anymore. However, Kubernetes does not automatically restart pods from the unavailable cluster on worker nodes in available clusters. If you want Kubernetes to automatically restart pods in available clusters, consider setting up a [multizone cluster](#multi_zone).

**Why do I need 3 clusters in 3 zones?** </br>
Similar to using [3 zones in a multizone clusters](#multi_zone), you can provide more availability to your app by setting up 3 clusters across zones. You can also reduce costs by purchasing smaller machines to handle your workload.

**What if I want to set up multiple clusters across regions?** </br>
You can set up multiple clusters in different regions of one geolocation (such as US South and US East) or across geolocations (such as US South and EU Central). Both setups offer the same level of availability for your app, but also add complexity when it comes to data sharing and data replication. For most cases, staying within the same geolocation is sufficient. But if you have users across the world, it might be better to set up a cluster where your users are, so that your users do not experience long waiting times when they send a request to your app.

**To set up a global load balancer for multiple clusters:**

1. [Create clusters](cs_clusters.html#clusters) in multiple zones or regions.
2. Enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](cs_users.html#infra_access), or you can request the account owner to enable it. As an alternative to VLAN spanning, you can use a Virtual Router Function (VRF) if it is enabled in your IBM Cloud infrastructure (SoftLayer) account.
3. In each cluster, expose your app by using an [application load balancer (ALB)](cs_ingress.html#ingress_expose_public) or [load balancer service](cs_loadbalancer.html#config).
4. For each cluster, list the public IP addresses for your ALBs or load balancer services.
   - To list the IP address of all public enabled ALBs in your cluster:
     ```
     ibmcloud cs albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - To list the IP address for your load balancer service:
     ```
     kubectl describe service <myservice>
     ```
     {: pre}

     The **Load Balancer Ingress** IP address is the portable IP address that was assigned to your load balancer service.

4.  Set up a global load balancer by using {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) or set up your own global load balancer.
    
    **To use a CIS global load balancer**:
    1.  Set up the service by following steps 1 - 4 in [Getting Started with {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-).
        *  Steps 1 - 3 walk you through provisioning the service instance, adding your app domain, and configuring your name servers.
        * Step 4 walks you through creating DNS records. Create a DNS record for each ALB or load balancer IP address that you collected. These DNS records map your app domain to all of your cluster ALBs or load balancers, and ensure that requests to your app domain are forwarded to your clusters in a round-robin cycle.
    2. [Add health checks](/docs/infrastructure/cis/glb-setup.html#add-a-health-check) for the ALBs or load balancers. You can use the same health check for the ALBs or load balancers in all of your clusters, or create specific health checks to use for specific clusters.
    3. [Add an origin pool](/docs/infrastructure/cis/glb-setup.html#add-a-pool) for each cluster by adding the cluster's ALB or load balancer IPs. For example, if you have 3 clusters that each have 2 ALBs, create 3 origin pools that each have 2 ALB IP addresses. Add a health check to each origin pool that you create.
    4. [Add a global load balancer](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers).
    
    **To use your own global load balancer**:
    1. Configure your domain to route incoming traffic to your ALB or load balancer services by adding the IP addresses of all public enabled ALBs and load balancer services to your domain.
    2. For each IP address, enable a ping-based health check so that your DNS provider can detect unhealthy IP addresses. If an unhealthy IP address is detected, traffic is not routed to this IP address anymore.

## Private clusters
{: #private_clusters}

By default, {{site.data.keyword.containershort_notm}} sets up your cluster with access to public and private VLAN. Before you can create a private-only cluster without connection to a public VLAN, you must configure an alternative solution for network connectivity.
{:shortdesc}

If you want to create a cluster that only has access on a private VLAN: 

1.  Review [Planning private external networking for a private VLAN setup only](cs_network_planning.html#private_vlan).
2.  Configure your gateway appliance for network connectivity. Note that you must [open the required ports and IP addresses](cs_firewall.html#firewall_outbound) in your firewall and [enable VLAN spanning](cs_subnets.html#subnet_routing) for the subnets.
3.  If you [create a cluster by using the CLI](cs_clusters.html#create_cli), you must include the `--private-only` flag.
4.  If you configure a NodePort, LoadBalancer, or Ingress service to expose an app, the service is accessible on only the private IP address. You must configure the ports in your firewall to use the private IP address.


## Overview of worker pools and worker nodes
{: #planning_worker_nodes}

A Kubernetes cluster consists of worker nodes that are grouped in worker node pools and is centrally monitored and managed by the Kubernetes master. Cluster admins decide how to set up the cluster of worker nodes to ensure that cluster users have all the resources to deploy and run apps in the cluster.
{:shortdesc}

When you create a standard cluster, worker nodes of the same memory, CPU, and size specifications (flavor) are ordered in IBM Cloud infrastructure (SoftLayer) on your behalf and added to the default worker node pool in your cluster. Every worker node is assigned a unique worker node ID and domain name that must not be changed after the cluster is created. To add different flavors to your cluster, [create another worker pool](cs_cli_reference.html#cs_worker_pool_add). If you have worker nodes in different zones, enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account. This procedure ensures that your worker nodes can communicate with each other on the private network. 

You can choose between virtual or physical (bare metal) servers. Depending on the level of hardware isolation that you choose, virtual worker nodes can be set up as shared or dedicated nodes. You can also choose whether you want worker nodes to connect to a public VLAN and private VLAN, or only to a private VLAN. Every worker node is provisioned with a specific machine type that determines the number of vCPUs, memory, and disk space that are available to the containers that are deployed to the worker node. Kubernetes limits the maximum number of worker nodes that you can have in a cluster. Review [worker node and pod quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/setup/cluster-large/) for more information.


Want to be sure that you always have enough worker nodes to cover your workload? Try out [the iccs-cluster-autoscaler (alpha)](#scaling_clusters).
{: tip}

## Available hardware for worker nodes
{: #shared_dedicated_node}

When you create a standard cluster in {{site.data.keyword.Bluemix_notm}}, you choose whether your worker pools consists of worker nodes that are either physical machines (bare metal) or virtual machines that run on physical hardware. You also select the worker node flavor, or combination of memory, CPU, and other machine specifications. If you want more than one flavor of worker node, you must create a worker pool for each flavor. When you create a free cluster, your worker node is automatically provisioned as a virtual, shared node in the IBM Cloud infrastructure (SoftLayer) account.
{:shortdesc}

![Hardware options for worker nodes in a standard cluster](images/cs_clusters_hardware.png)

Review the following information to decide what type of worker pools you want. As you plan, consider the [worker node limit minimum threshold](#resource_limit_node) of 10% of total memory capacity.

<dl>
<dt>Why would I use physical machines (bare metal)?</dt>
<dd><p><strong>More compute resources</strong>: You can provision your worker node as a single-tenant physical server, also referred to as bare metal. Bare metal gives you direct access to the physical resources on the machine, such as the memory or CPU. This setup eliminates the virtual machine hypervisor that allocates physical resources to virtual machines that run on the host. Instead, all of a bare metal machine's resources are dedicated exclusively to the worker, so you don't need to worry about "noisy neighbors" sharing resources or slowing down performance. Physical machine types have more local storage than virtual, and some have RAID to back up local data.</p>
<p><strong>Monthly billing</strong>: Bare metal servers are more expensive than virtual servers, and are best suited for high-performance apps that need more resources and host control. Bare metal servers are billed monthly. If you cancel a bare metal server before the end of the month, you are charged through the end of that month. Ordering and canceling bare metal servers is a manual process through your IBM Cloud infrastructure (SoftLayer) account. It can take more than one business day to complete.</p>
<p><strong>Option to enable Trusted Compute</strong>: Enable Trusted Compute to verify your worker nodes against tampering. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud cs feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later. You can make a new cluster without trust. For more information about how trust works during the node startup process, see [{{site.data.keyword.containershort_notm}} with Trusted Compute](cs_secure.html#trusted_compute). Trusted Compute is available on clusters that run Kubernetes version 1.9 or later and have certain bare metal machine types. When you run the `ibmcloud cs machine-types <zone>` [command](cs_cli_reference.html#cs_machine_types), you can see which machines support trust by reviewing the **Trustable** field. For example, `mgXc` GPU flavors do not support Trusted Compute.</p></dd>
<dt>Why would I use virtual machines?</dt>
<dd><p>With VMs, you get greater flexibility, quicker provisioning times, and more automatic scalability features than bare metal, at a more cost-effective price. You can use VMs for most general purpose use cases such as testing and development environments, staging and prod environments, microservices, and business apps. However, there is a trade-off in performance. If you need high performance computing for RAM-, data-, or GPU-intensive workloads, use bare metal.</p>
<p><strong>Decide between single or multiple tenancy</strong>: When you create a standard virtual cluster, you must choose whether you want the underlying hardware to be shared by multiple {{site.data.keyword.IBM_notm}} customers (multi tenancy) or to be dedicated to you only (single tenancy).</p>
<p>In a multi-tenant set up, physical resources, such as CPU and memory, are shared across all virtual machines that are deployed to the same physical hardware. To ensure that every virtual machine can run independently, a virtual machine monitor, also referred to as the hypervisor, segments the physical resources into isolated entities and allocates them as dedicated resources to a virtual machine (hypervisor isolation).</p>
<p>In a single-tenant set up, all physical resources are dedicated to you only. You can deploy multiple worker nodes as virtual machines on the same physical host. Similar to the multi-tenant set up, the hypervisor assures that every worker node gets its share of the available physical resources.</p>
<p>Shared nodes are usually less costly than dedicated nodes because the costs for the underlying hardware are shared among multiple customers. However, when you decide between shared and dedicated nodes, you might want to check with your legal department to discuss the level of infrastructure isolation and compliance that your app environment requires.</p>
<p><strong>Virtual `u2c` or `b2c` machine flavors</strong>: These machines use local disk instead of storage area networking (SAN) for reliability. Reliability benefits include higher throughput when serializing bytes to the local disk and reduced file system degradation due to network failures. These machine types contain 25GB primary local disk storage for the OS file system, and 100GB secondary local disk storage for data such as container runtime and the kubelet.</p>
<p><strong>What if I have deprecated `u1c` or `b1c` machine types?</strong> To start using `u2c` and `b2c` machine types, [update the machine types by adding worker nodes](cs_cluster_update.html#machine_type).</p></dd>
<dt>What virtual and physical machine flavors can I choose from?</dt>
<dd><p>Many! Select the type of machine that is best for your use case. Remember that a worker pool consists of machines that are the same flavor. If you want a mix of machine types in your cluster, create separate worker pools for each flavor.</p>
<p>Machine types vary by zone. To see the machine types available in your zone, run `ibmcloud cs machine-types <zone_name>`.</p>
<p><table>
<caption>Available physical (bare metal) and virtual machine types in {{site.data.keyword.containershort_notm}}.</caption>
<thead>
<th>Name and use case</th>
<th>Cores / Memory</th>
<th>Primary / Secondary disk</th>
<th>Network speed</th>
</thead>
<tbody>
<tr>
<td><strong>Virtual, u2c.2x4</strong>: Use this smallest size VM for quick testing, proofs of concept, and other light workloads.</td>
<td>2 / 4GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.4x16</strong>: Select this balanced VM for testing and development, and other light workloads.</td>
<td>4 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.16x64</strong>: Select this balanced VM for mid-sized workloads.</td></td>
<td>16 / 64GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.32x128</strong>: Select this balanced VM for mid to large workloads, such as a database and a dynamic website with many concurrent users.</td></td>
<td>32 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.56x242</strong>: Select this balanced VM for large workloads, such as a database and multiple apps with many concurrent users.</td></td>
<td>56 / 242GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>RAM-intensive bare metal, mr1c.28x512</strong>: Maximize the RAM available to your worker nodes.</td>
<td>28 / 512GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>GPU bare metal, mg1c.16x128</strong>: Choose this type for mathematically-intensive workloads such as high performance computing, machine learning, or 3D applications. This flavor has 1 Tesla K80 physical card that has 2 graphics processing units (GPUs) per card for a total of 2 GPUs.</td>
<td>16 / 128GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>GPU bare metal, mg1c.28x256</strong>: Choose this type for mathematically-intensive workloads such as high performance computing, machine learning, or 3D applications. This flavor has 2 Tesla K80 physical cards that have 2 GPUs per card for a total of 4 GPUs.</td>
<td>28 / 256GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Data-intensive bare metal, md1c.16x64.4x4tb</strong>: For a significant amount of local disk storage, including RAID to back up data that is stored locally on the machine. Use for cases such as distributed file systems, large databases, and big data analytics workloads.</td>
<td>16 / 64GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Data-intensive bare metal, md1c.28x512.4x4tb</strong>: For a significant amount of local disk storage, including RAID to back up data that is stored locally on the machine. Use for cases such as distributed file systems, large databases, and big data analytics workloads.</td>
<td>28 / 512 GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Balanced bare metal, mb1c.4x32</strong>: Use for balanced workloads that require more compute resources than virtual machines offer.</td>
<td>4 / 32GB</td>
<td>2TB SATA / 2TB SATA</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Balanced bare metal, mb1c.16x64</strong>: Use for balanced workloads that require more compute resources than virtual machines offer.</td>
<td>16 / 64GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
</tbody>
</table>
</p>
</dd>
</dl>


You can deploy clusters by using the [console UI](cs_clusters.html#clusters_ui) or the [CLI](cs_clusters.html#clusters_cli).

## Worker node memory limits
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} sets a memory limit on each worker node. When pods that are running on the worker node exceed this memory limit, the pods are removed. In Kubernetes, this limit is called a [hard eviction threshold ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

If your pods are removed frequently, add more worker nodes to your cluster or set [resource limits ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) on your pods.

**Each machine has a minimum threshold that equals 10% of its total memory capacity**. When there is less memory available on the worker node than the minimum threshold that is allowed, Kubernetes immediately removes the pod. The pod reschedules onto another worker node if a worker node is available. For example, if you have a `b2c.4x16` virtual machine, its total memory capacity is 16GB. If less than 1600MB (10%) of memory is available, new pods cannot schedule onto this worker node but instead are scheduled onto another worker node. If no other worker node is available, the new pods remain unscheduled.

To review how much memory is used on your worker node, run [kubectl top node ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/#top).

## Autorecovery for your worker nodes
{: #autorecovery}

`Docker`, `kubelet`, `kube-proxy`, and `calico` are critical components that must be functional to have a healthy Kubernetes worker node. Over time these components can break and may leave your worker node in a nonfunctional state. Nonfunctional worker nodes decrease total capacity of the cluster and can result in downtime for your app.
{:shortdesc}

You can [configure health checks for your worker node and enable Autorecovery](cs_health.html#autorecovery). If Autorecovery detects an unhealthy worker node based on the configured checks, Autorecovery triggers a corrective action like an OS reload on the worker node. For more information about how Autorecovery works, see the [Autorecovery blog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />


</staging>
