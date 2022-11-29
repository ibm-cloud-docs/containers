---

copyright: 
  years: 2014, 2022
lastupdated: "2022-11-29"

keywords: kubernetes

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}




# Understanding costs for your clusters
{: #costs}

With {{site.data.keyword.cloud}}, you can plan for, estimate, review, and modify your cluster environment to control costs. Just by using a managed service like {{site.data.keyword.containerlong}}, you are saving many expenses that are associated with managing, updating, and maintaining an infrastructure environment.
{: shortdesc}

## Understanding costs by component
{: #costs-for-clusters}

With {{site.data.keyword.containerlong_notm}} clusters, you can use IBM Cloud infrastructure compute, networking, and storage resources with platform services such as {{site.data.keyword.watson}} AI or Compose Database-as-a-Service. Each resource might entail its own charges that can be [fixed, metered, tiered, or reserved](/docs/billing-usage?topic=billing-usage-charges#charges) and billed by various incremental rates such as monthly or hourly.
{: shortdesc}

Monthly resources are billed based on the first of the month for usage in the preceding month. If you order a monthly resource in the middle of the month, you are charged a prorated amount for that month. However, if you cancel a resource in the middle of the month, you are still charged the full amount for the monthly resource.
{: note}

### Worker nodes
{: #nodes}

Clusters can have two main types of worker nodes: virtual or physical (bare metal) machines. Flavor (machine type) availability and pricing varies by the zone that you deploy your cluster to.
{: shortdesc}

When do worker nodes begin to incur charges?**
:   Worker nodes begin to incur charges after they complete the `provisioning` state and continue until you delete the worker nodes and they complete the `deleting` state. For more information, see [Worker node states](/docs/containers?topic=containers-health-monitor#states).

### What is the difference between virtual and physical machines?
{: #physical-vs-virtual}

**Virtual machines** feature greater flexibility, quicker provisioning times, and more automatic scalability features than bare metal, at a more cost-effective price than bare-metal. However, VMs have a performance tradeoff when compared to bare metal specs, such as networking Gbps, RAM and memory thresholds, and storage options. Keep in mind these factors that impact your VM costs.
* **Sharedversus dedicated**: If you share the underlying hardware of the VM, the cost is lower than dedicated hardware, but the physical resources are not dedicated to your VM.
* **Hourly billing only**: Hourly billing offers more flexibility to order and cancel VMs quickly. You are charged an hourly rate that is metered for only the time that that the worker node is provisioned. The time is not rounded up or down to the nearest hour, but is metered in minutes and charged at the hourly rate. For example, if your worker node is provisioned for 90 minutes, you are charged the hourly rate for 1.5 hours, not 2 hours.
* **Tiered hours per month**: The [pricing](https://cloud.ibm.com/kubernetes/catalog/about#pricing){: external} is billed hourly in [graduated tiered](/docs/billing-usage?topic=billing-usage-charges#graduated_tier). As your VM remains ordered for a tier of hours within a billing month, the hourly rate that you are charged lowers. The tiers of hours are as follows:
    * 0 - 150 hours
    * 151 - 290 hours
    * 291 - 540 hours
    * 541+ hours

**Physical machines, or bare metal, (not available for VPC clusters)** yield high-performance benefits for workloads such as data, GPU, and AI. Additionally, all the hardware resources are dedicated to your workloads, so you don't have "noisy neighbors". Keep in mind these factors that impact your bare metal costs.
* **Monthly billing only**: All bare metals are charged monthly.
* **Longer ordering process**: After you order or cancel a bare metal server, the process is completed manually in your IBM Cloud infrastructure account. Therefore, it can take more than one business day to complete.

    **VPC Generation 2 only**: Prices vary by region where the underlying worker node infrastructure resides, and you can get sustained usage discounts. For more information, see [What are the regional uplift charges and sustained usage discounts for VPC worker nodes?](#charges_vpc_gen2).
    {: note}

For more information about worker node specifications, see [Available hardware for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).



### Public bandwidth
{: #bandwidth}

Bandwidth refers to the public data transfer of inbound and outbound network traffic, both to and from {{site.data.keyword.cloud_notm}} resources in data centers around the globe.
{: shortdesc}

**Classic clusters**: Public bandwidth is charged per GB. You can review your current bandwidth summary by logging into the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/), from the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon") selecting **Classic Infrastructure**, and then selecting the **Network > Bandwidth > Summary** page.

Review the following factors that impact public bandwidth charges:
* **Location**: As with worker nodes, charges vary depending on the zone that your resources are deployed in.
* **Pay-As-You-Go for VM**: Because VMs are billed at an hourly rate, your VM worker node machines have a Pay-As-You-Go allocation of outbound networking based on GB usage.
* **Included bandwidth and tiered packages for BM**: Bare metal worker nodes might come with a certain allocation of outbound networking per month that varies by geography: 20 TB for North America and Europe, or 5 TB for Asia Pacific and South America. After you exceed your included bandwidth, you are charged according to a tiered usage scheme for your geography. If you exceed a tier allotment, you might also be charged a standard data transfer fee. For more information, see [Bandwidth packages](https://www.ibm.com/cloud/bandwidth){: external}.

**VPC clusters**: For more information about how internet data transfer works in your Virtual Private Cloud, see [Pricing for VPC](https://www.ibm.com/cloud/virtual-servers/pricing/){: external}.

### Subnet IP addresses
{: #subnet_ips}

Subnets for {{site.data.keyword.containerlong_notm}} clusters vary by infrastructure provider.
{: shortdesc}

**Classic clusters**: When you create a standard cluster, a portable public subnet with 8 public IP addresses is ordered and charged to your account monthly. For pricing information, see the [Subnets and IPs](/docs/subnets) documentation or estimate your costs in the [classic subnets console)](https://cloud.ibm.com/classic/network/subnet/provision){: external}.  If you already have available portable public subnets in your infrastructure account, you can use these subnets instead. Create the cluster with the `--no-subnets` [flag](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_create), and then [reuse your subnets](/docs/containers?topic=containers-subnets#subnets_custom).

**VPC clusters**: For more information about charges for floating IPs and other networking costs, see [Pricing for VPC](https://www.ibm.com/cloud/virtual-servers/pricing/){: external}.

### Multizone load balancer
{: #mzlb_pricing}

When you create a multizone cluster or add zones to a single zone cluster, you must have a load balancer to health check Ingress and load balancer IP addresses in each zone, and forward requests to your apps across zones in the region.
{: shortdesc}

The type of load balancer that is automatically created varies depending on the type of cluster. For more information, see [Multizone load balancer (MZLB) or Load Balancer for VPC](/docs/containers?topic=containers-ingress-about#mzlb).
* **Classic clusters**: An Akamai MZLB is automatically created for each multizone cluster. You can view the hourly rate in the pricing summary when you create the cluster.
* **VPC clusters**: A Load Balancer for VPC is automatically created in your VPC for your cluster. For cost information, see [Pricing for Load Balancer for VPC](https://www.ibm.com/cloud/virtual-servers/pricing/){: external}.



### Storage
{: #persistent_storage}

When you provision storage, you can choose the storage type and storage class that is right for your use case. Charges vary depending on the type of storage, the location, and the specs of the storage instance. Some storage solutions, such as file and block storage offer hourly and monthly rates that you can choose from.
{: shortdesc}

To choose the right storage solution, see [Planning highly available persistent storage](/docs/containers?topic=containers-storage_planning#storage_planning). For more information, see:
* [NFS file storage pricing](https://www.ibm.com/cloud/file-storage/pricing){: external}
* [Block storage pricing](https://www.ibm.com/cloud/block-storage/pricing){: external}
* [Object storage plans](https://cloud.ibm.com/objectstorage/create#pricing){: external}
* [Portworx Enterprise pricing](https://cloud.ibm.com/catalog/services/portworx-enterprise){: external}

### {{site.data.keyword.cloud_notm}} services
{: #services}

Each service that you integrate with your cluster has its own pricing model. Review each product documentation and use the {{site.data.keyword.cloud_notm}} console to [estimate costs](/docs/billing-usage?topic=billing-usage-cost#cost).
{: shortdesc}

### Operators and other third-party integrations
{: #operators_pricing}

Operators and other [third-party integrations](/docs/containers?topic=containers-supported_integrations) are a convenient way to add services to your cluster from community, third-party, your own, or other providers. Keep in mind that you are responsible for additional charges and how these services operate in your cluster, from deployment and maintenance to integration with your apps. If you have issues with an operator or third-party integration, work with the appropriate provider to troubleshoot the issue.
{: shortdesc}

### VPC worker nodes
{: #charges_vpc_gen2}

Pricing for VPC infrastructure varies based on regional location and sustained usage.
{: shortdesc}

This information applies to VPC worker nodes only.
{: note}

Regional uplift charges
:    When you create a cluster on VPC infrastructure, the worker nodes might incur an uplift charge that varies by the [multizone location](/docs/containers?topic=containers-regions-and-zones#zones-vpc) that you create the cluster in. The uplift charge is a percentage (`%`) of the hourly rate (`r`), and is added to the hourly rate of the worker node. The total hourly rate cost for a worker node can be calculated as `r + (r × %)`. In the [Kubernetes cluster creation console](https://cloud.ibm.com/kubernetes/catalog/create){: external}, this uplift is reflected in the pricing calculator as you configure your cluster details. The following table describes the pricing uplift by region.

:    For a table that describes the pricing uplift by region, see [Regional pricing for VPC](https://www.ibm.com/cloud/virtual-servers/pricing/){: external}.

Sustained usage discounts
:    For virtual server instances that are billed at an hourly rate, discounted prices depend on how long the instance runs during the billing month. For more information, expand the **Sustained usage discounts on {{site.data.keyword.cloud_notm}} {{site.data.keyword.vsi_is_short}}** section on the [Pricing for VPC](https://www.ibm.com/cloud/virtual-servers/pricing/){: external} page.

## Estimating costs
{: #costs-estimate}

See [Estimating your costs](/docs/billing-usage?topic=billing-usage-cost#cost).

Keep in mind that some charges are not reflected in the estimate, such as tiered pricing for increased hourly usage. For more information, see [Understanding costs for your clusters](#costs-for-clusters).

## Managing costs
{: #costs-manage}

The following steps present a general process to manage costs for your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

1. Decide on a cloud platform strategy to manage your resources.
    * See [Best practices for billing and usage](/docs/billing-usage?topic=billing-usage-best-practices).
    * Organize your billing with [resource groups](/docs/account?topic=account-rgs).
    * [Add tags to your clusters](/docs/containers?topic=containers-add_workers#cluster_tags) according to your organizational strategy.
2. Plan the type of cluster that you need.
    * [Size your cluster to support your workloads](/docs/containers?topic=containers-strategy#sizing), including the network bandwidth that your workloads need.
    * [Decide the cluster environment that you want](/docs/containers?topic=containers-strategy#kube_env).
    * [Consider the availability that you want for your cluster](/docs/containers?topic=containers-ha_clusters). For example, a basic high availability setup is one multizone cluster with two worker nodes in each of three zones, for a minimum total of 6 worker nodes.
3. Check out other {{site.data.keyword.cloud_notm}} services, add-ons, operators, and other third-party software that you might use that can increase your cost. To get an idea of what other costs clusters typically incur, review [Understanding costs for your clusters](#costs-for-clusters).
4. [Estimate your costs](/docs/billing-usage?topic=billing-usage-cost#cost) and review detailed pricing information for the service, see [{{site.data.keyword.containerlong_notm}}: Pricing](https://www.ibm.com/cloud/kubernetes-service/pricing){: external}.
5. Manage the lifecycle of your cluster to control costs.
    * Consider [enabling the cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) to automatically add or remove worker nodes in response to your cluster workload resource requests.
    * Manually [resize your worker pool](/docs/containers?topic=containers-add_workers) to remove worker nodes that you don't need. Keep in mind that you can't scale a worker pool down to zero worker nodes.
    * Use Kubernetes features such as [horizontal pod autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/){: external}, [pod priority](/docs/containers?topic=containers-pod_priority), and [resource requests and limits](/docs/containers?topic=containers-app#resourcereq) to control how resources are used within your cluster.
    * Consider setting up a [monitoring tool](/docs/containers?topic=containers-health-monitor#view_metrics) such as {{site.data.keyword.mon_full_notm}} and creating alerts for your workloads when they need more resources.
6. [View your usage](/docs/billing-usage?topic=billing-usage-viewingusage#viewingusage) to continuously refine how you consume {{site.data.keyword.cloud_notm}} services.
7. [Set spending notifications](/docs/billing-usage?topic=billing-usage-spending).




