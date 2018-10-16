---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Why {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts. For certification information, see [Compliance on the {{site.data.keyword.Bluemix_notm}} [External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/compliance).
{:shortdesc}


## Benefits of using the service
{: #benefits}

Clusters are deployed on compute hosts that provide native Kubernetes and {{site.data.keyword.IBM_notm}}-specific capabilities.
{:shortdesc}

|Benefit|Description|
|-------|-----------|
|Single-tenant Kubernetes clusters with compute, network, and storage infrastructure isolation|<ul><li>Create your own customized infrastructure that meets the requirements of your organization.</li><li>Provision a dedicated and secured Kubernetes master, worker nodes, virtual networks, and storage by using the resources provided by IBM Cloud infrastructure (SoftLayer).</li><li>Fully managed Kubernetes master that is continuously monitored and updated by {{site.data.keyword.IBM_notm}} to keep your cluster available.</li><li>Option to provision worker nodes as bare metal servers with Trusted Compute.</li><li>Store persistent data, share data between Kubernetes pods, and restore data when needed with the integrated and secure volume service.</li><li>Benefit from full support for all native Kubernetes APIs.</li></ul>|
| Multizone clusters to increase high availability | <ul><li>Easily manage worker nodes of the same machine type (CPU, memory, virtual or physical) with worker pools.</li><li>Guard against zone failure by spreading nodes evenly across select multizones and using anti-affinity pod deployments for your apps.</li><li>Decrease your costs by using multizone clusters instead of duplicating the resources in a separate cluster.</li><li>Benefit from automatic load balancing across apps with the multizone load balancer (MZLB) that is set up automatically for you in each zone of the cluster.</li></ul>|
|Image security compliance with Vulnerability Advisor|<ul><li>Set up your own repo in our secured Docker private image registry where images are stored and shared by all users in the organization.</li><li>Benefit from automatic scanning of images in your private {{site.data.keyword.Bluemix_notm}} registry.</li><li>Review recommendations specific to the operating system used in the image to fix potential vulnerabilities.</li></ul>|
|Continuous monitoring of the cluster health|<ul><li>Use the cluster dashboard to quickly see and manage the health of your cluster, worker nodes, and container deployments.</li><li>Find detailed consumption metrics by using {{site.data.keyword.monitoringlong}} and quickly expand your cluster to meet work loads.</li><li>Review logging information by using {{site.data.keyword.loganalysislong}} to see detailed cluster activities.</li></ul>|
|Secure exposure of apps to the public|<ul><li>Choose between a public IP address, an {{site.data.keyword.IBM_notm}} provided route, or your own custom domain to access services in your cluster from the internet.</li></ul>|
|{{site.data.keyword.Bluemix_notm}} service integration|<ul><li>Add extra capabilities to your app through the integration of {{site.data.keyword.Bluemix_notm}} services, such as Watson APIs, Blockchain, data services, or Internet of Things.</li></ul>|
{: caption="Benefits of the {{site.data.keyword.containerlong_notm}}" caption-side="top"}

Ready to get started? Try out the [creating a Kubernetes cluster tutorial](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Comparison of offerings and their combinations
{: #differentiation}

You can run {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public or Dedicated, in {{site.data.keyword.Bluemix_notm}} Private, or in a hybrid setup.
{:shortdesc}


<table>
<caption>Differences between {{site.data.keyword.containerlong_notm}} setups</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}} setup</th>
 <th>Description</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>With {{site.data.keyword.Bluemix_notm}} Public on [shared or dedicated hardware or on bare metal machines](cs_clusters_planning.html#shared_dedicated_node), you can host your apps in clusters on the cloud by using {{site.data.keyword.containerlong_notm}}. You can also create a cluster with worker pools in multiple zones to increase high availability for your apps. {{site.data.keyword.containerlong_notm}} on {{site.data.keyword.Bluemix_notm}} Public delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts.<br><br>For more information, see [{{site.data.keyword.containerlong_notm}} technology](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated offers the same {{site.data.keyword.containerlong_notm}} capabilities on the cloud as {{site.data.keyword.Bluemix_notm}} Public. However, with an {{site.data.keyword.Bluemix_notm}} Dedicated account, available [physical resources are dedicated to your cluster only](cs_clusters_planning.html#shared_dedicated_node) and are not shared with clusters from other {{site.data.keyword.IBM_notm}} customers. You might choose to set up an {{site.data.keyword.Bluemix_notm}} Dedicated environment when you require isolation for your cluster and the other {{site.data.keyword.Bluemix_notm}} services that you use.<br><br>For more information, see [Getting started with clusters in {{site.data.keyword.Bluemix_notm}} Dedicated](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private is an application platform that can be installed locally on your own machines. You might choose to use {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Private when you need to develop and manage on-prem, containerized apps in your own controlled environment behind a firewall. <br><br>For more information, see the [{{site.data.keyword.Bluemix_notm}} Private product documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Hybrid setup
 </td>
 <td>Hybrid is the combined use of services that run in {{site.data.keyword.Bluemix_notm}} Public or Dedicated and other services that run on-prem, such as an app in {{site.data.keyword.Bluemix_notm}} Private. Examples for a hybrid setup: <ul><li>Provisioning a cluster with {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public but connecting that cluster to an on-prem database.</li><li>Provisioning a cluster with {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Private and deploying an app into that cluster. However, this app might use an {{site.data.keyword.ibmwatson}} service, such as {{site.data.keyword.toneanalyzershort}}, in {{site.data.keyword.Bluemix_notm}} Public.</li></ul><br>To enable communication between services that are running in {{site.data.keyword.Bluemix_notm}} Public or Dedicated and services that are running on-prem, you must [set up a VPN connection](cs_vpn.html). For more information, see [Using {{site.data.keyword.containerlong_notm}} with {{site.data.keyword.Bluemix_notm}} Private](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Comparison of free and standard clusters
{: #cluster_types}

You can create one free cluster or any number of standard clusters. Try out free clusters to get familiar with a few Kubernetes capabilities, or create standard clusters to use the full capabilities of Kubernetes to deploy apps. Free clusters are automatically deleted after 30 days.
{:shortdesc}

If you have a free cluster and want to upgrade to a standard cluster, you can [create a standard cluster](cs_clusters.html#clusters_ui). Then, deploy any YAMLs for the Kubernetes resources that you made with your free cluster into the standard cluster.

|Characteristics|Free clusters|Standard clusters|
|---------------|-------------|-----------------|
|[In-cluster networking](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public network app access by a NodePort service to a non-stable IP address](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[User access management](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_notm}} service access from the cluster and apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Disk space on worker node for non-persistent storage](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
| [Ability to create cluster in every {{site.data.keyword.containerlong_notm}} region](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
|[Multizone clusters to increase app high availability](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Persistent NFS file-based storage with volumes](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public or private network app access by a load balancer service to a stable IP address](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public network app access by an Ingress service to a stable IP address and customizable URL](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Portable public IP addresses](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Logging and monitoring](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Option to provision your worker nodes on physical (bare metal) servers](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Option to provision bare metal workers with Trusted Compute](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Available in {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
{: caption="Characteristics of free and standard clusters" caption-side="top"}

<br />


## Pricing and billing
{: #pricing}

Review some frequently asked questions about {{site.data.keyword.containerlong_notm}} pricing and billing. For account-level questions, check out the [Managing billing and usage docs](/docs/billing-usage/how_charged.html#charges). For details about your account agreements, consult the appropriate [{{site.data.keyword.Bluemix_notm}} Terms and Notices](/docs/overview/terms-of-use/notices.html#terms).
{: shortdesc}

### How can I view and organize my usage?
{: #usage}

**How can I check my billing and usage?**<br>
To check your usage and estimated totals, see [Viewing your usage](/docs/billing-usage/viewing_usage.html#viewingusage).

If you link your {{site.data.keyword.Bluemix_notm}} and IBM Cloud infrastructure (SoftLayer) accounts, you receive a consolidated bill. For more information, see [Consolidated billing for linked accounts](/docs/billing-usage/linking_accounts.html#unifybillaccounts).

**Can I group my cloud resources by teams or departments for billing purposes?**<br>
You can [use resource groups](/docs/resources/bestpractice_rgs.html#bp_resourcegroups) to organize your {{site.data.keyword.Bluemix_notm}} resources, including clusters, into groups to organize your billing.

### How am I charged? Are charges hourly or monthly?
{: #monthly-charges}

Your charges depend on the type of resource that you use, and might be fixed, metered, tiered, or reserved. For more information, view [How you are charged](/docs/billing-usage/how_charged.html#charges).

IBM Cloud infrastructure (SoftLayer) resources can be billed hourly or monthly in {{site.data.keyword.containerlong_notm}}.
* Virtual machine (VM) worker nodes are billed hourly.
* Physical (bare metal) worker nodes are billed monthly resources in {{site.data.keyword.containerlong_notm}}.
* For other infrastructure resources, such as file or block storage, you might be able to choose between hourly or monthly billing when you create the resource.

Monthly resources are billed based upon the first of the month for usage in the preceding month. If you order a monthly resource in the middle of the month, you are charged a prorated amount for that month. However, if you cancel a resource in the middle of the month, you are still charged the full amount for the monthly resource.

### Can I estimate my costs?
{: #estimate}

Yes, see [Estimating your costs](/docs/billing-usage/estimating_costs.html#cost) and the [cost estimator ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/pricing/) tool. Continue reading for information about costs that are not included in the cost estimator, such as outbound networking.

### What am I charged for when I use {{site.data.keyword.containerlong_notm}}?
{: #cluster-charges}

With {{site.data.keyword.containerlong_notm}} clusters, you can use IBM Cloud infrastructure (SoftLayer) compute, networking, and storage resources with platform services such as Watson AI or Compose Database-as-a-Service. Each resource might entail its own charges.
* [Worker nodes](#nodes)
* [Outbound networking](#bandwidth)
* [Subnet IP addresses](#subnets)
* [Storage](#storage)
* [{{site.data.keyword.Bluemix_notm}} services](#services)

<dl>
<dt id="nodes">Worker nodes</dt>
  <dd><p>Clusters can have two main types of worker nodes: virtual or physical (bare metal) machines. Machine type availability and pricing varies by the zone that you deploy your cluster to.</p>
  <p><strong>Virtual machines</strong> feature greater flexibility, quicker provisioning times, and more automatic scalability features than bare metal, at a more cost-effective price than bare-metal. However, VMs have a performance trade-off when compared to bare metal specs, such as networking Gbps, RAM and memory thresholds, and storage options. Keep in mind these factors that impact your VM costs:</p>
  <ul><li><strong>Shared vs. dedicated</strong>: If you share the underlying hardware of the VM, the cost is lower than dedicated hardware, but the physical resources are not dedicated to your VM.</li>
  <li><strong>Hourly billing only</strong>: Hourly offers more flexibility to order and cancel VMs quickly. 
  <li><strong>Tiered hours per month</strong>: Hourly billing is tiered. As your VM remains ordered for a tier of hours within a billing month, the hourly rate that you are charged lowers. The tiers of hours are as follows: 0 - 150 hours, 151 - 290 hours, 291 - 540 hours, and 541+ hours.</li></ul>
  <p><strong>Physical machines (bare metal)</strong> yield high performance benefits for workloads such as data, AI, and GPU. Additionally, all the hardware resources are dedicated to your workloads, so you don't have "noisy neighbors". Keep in mind these factors that impact your bare metal costs:</p>
  <ul><li><strong>Monthly billing only</strong>: All bare metals are charged monthly.</li>
  <li><strong>Longer ordering process</strong>:  Because ordering and canceling bare metal servers is a manual process through your IBM Cloud infrastructure (SoftLayer) account, it can take more than one business day to complete.</li></ul>
  <p>For details on the machine specifications, see [Available hardware for worker nodes](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Public bandwidth</dt>
  <dd><p>Bandwidth refers to the public data transfer of inbound and outbound network traffic, both to and from {{site.data.keyword.Bluemix_notm}} resources in data centers around the globe. Public bandwidth is charged per GB. You can review your current bandwidth summary by logging into the [{{site.data.keyword.Bluemix_notm}} console](https://console.bluemix.net/), from the menu selecting **Infrastructure**, and then selecting the **Network > Bandwidth > Summary** page.
  <p>Review the following factors that impact public bandwidth charges:</p>
  <ul><li><strong>Location</strong>: As with worker nodes, charges vary depending on the zone that your resources are deployed in.</li>
  <li><strong>Included bandwidth or Pay-As-You-Go</strong>: Your worker node machines might come with a certain allocation of outbound networking per month, such as 250GB for VMs or 500GB for bare metal. Or, the allocation might be Pay-As-You-Go, based on GB usage.</li>
  <li><strong>Tiered packages</strong>: After you exceed any included bandwidth, you are charged according to a tiered usage scheme that varies by location. If you exceed a tier allotment, you might also be charged a standard data transfer fee.</li></ul>
  <p>For more information, see [Bandwidth packages![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Subnet IP addresses</dt>
  <dd><p>When you create a standard cluster, a portable public subnet with 8 public IP addresses is ordered and charged to your account monthly.</p><p>If you already have available subnets in your infrastructure account, you can use these subnets instead. Create the cluster with the `--no-subnets` [flag](cs_cli_reference.html#cs_cluster_create), and then [reuse your subnets](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Storage</dt>
  <dd>When you provision storage, you can choose the storage type and storage class that is right for your use case. Charges vary depending on the type of storage, the location, and the specs of the storage instance. To choose the right storage solution, see [Planning highly available persistent storage](cs_storage_planning.html#storage_planning). For more information, see:
  <ul><li>[NFS file storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Block storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Object storage plans![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} services</dt>
  <dd>Each service that you integrate with your cluster has its own pricing model. Consult each product documentation and the [cost estimator ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/pricing/) for more information.</dd>

</dl>
