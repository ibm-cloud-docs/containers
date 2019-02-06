---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:download: .download}
{:faq: data-hd-content-type='faq'}

# FAQs
{: #faqs}

## What is Kubernetes?
{: #kubernetes}
{: faq}

Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers managements tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention. All containers that make up your microservice are grouped into pods, a logical unit to ensure easy management and discovery. These pods run on compute hosts that are managed in a Kubernetes cluster that is portable, extensible, and self-healing in case of failures. 
{: shortdesc}

For more information about Kubernetes, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational). 

## How does IBM Cloud Kubernetes Service work?
{: #kubernetes_service}
{: faq}

With {{site.data.keyword.containerlong_notm}}, you can create your own Kubernetes cluster to deploy and manage containerized apps on {{site.data.keyword.Bluemix_notm}}. Your containerized apps are hosted on IBM Cloud infrastructure (SoftLayer) compute hosts that are called worker nodes. You can choose to provision your compute hosts as [virtual machines](/docs/containers/cs_clusters_planning.html#vm) with shared or dedicated resources, or as [bare metal machines](/docs/containers/cs_clusters_planning.html#bm) that can be optimized for GPU and software-defined storage (SDS) usage. Your worker nodes are controlled by a highly available Kubernetes master that is configured, monitored, and managed by IBM. You can use the {{site.data.keyword.containerlong_notm}} API or CLI to work with your cluster infrastructure resources and the Kubernetes API or CLI to manage your deployments and services. 

For more information on how your cluster resources are set up, see the [Service architecture](/docs/containers/cs_tech.html#architecture). To find a list of capabilities and benefits, see [Why {{site.data.keyword.containerlong_notm}}](/docs/containers/cs_why.html#cs_ov).

## Why should I use IBM Cloud Kubernetes Service?
{: #faq_benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} is a managed Kubernetes offering that delivers powerful tools, an intuitive user experience, and built-in security for rapid delivery of apps that you can bind to cloud services related to IBM Watson®, AI, IoT, DevOps, security, and data analytics. As a certified Kubernetes provider, {{site.data.keyword.containerlong_notm}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management. The service also has advanced capabilities around simplified cluster management, container security and isolation policies, the ability to design your own cluster, and integrated operational tools for consistency in deployment.

For a detailed overview of capabilities and benefits, see [Why {{site.data.keyword.containerlong_notm}}](/docs/containers/cs_why.html#cs_ov). 

## Does the service come with a managed Kubernetes master and worker nodes?
{: #managed_master_worker}
{: faq}

Every Kubernetes cluster in {{site.data.keyword.containerlong_notm}} is controlled by a dedicated Kubernetes master that is managed by IBM in an IBM-owned {{site.data.keyword.Bluemix_notm}} infrastructure account. The Kubernetes master, including all the master components, compute, networking, and storage resources, is continuously monitored by IBM Site Reliability Engineers (SREs). The SREs apply the latest security standards, detect and remediate malicious activities, and work to ensure reliability and availability of {{site.data.keyword.containerlong_notm}}. Add-ons, such as Fluentd for logging, that are installed automatically when you provision the cluster are automatically updated by IBM. However, you can choose to disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. For more information, see [Updating cluster add-ons](/docs/containers/cs_cluster_update.html#addons). 

Periodically, Kubernetes releases [major, minor, or patch updates](/docs/containers/cs_versions.html#version_types). These updates can affect the Kubernetes API server version or other components in your Kubernetes master. IBM automatically updates the patch version, but you must update the master major and minor versions. For more information, see [Updating the Kubernetes master](/docs/containers/cs_cluster_update.html#master). 

Worker nodes in standard clusters are provisioned in to your {{site.data.keyword.Bluemix_notm}} infrastructure account. The worker nodes are dedicated to your account and you are responsible to request timely updates to the worker nodes to ensure that the worker node OS and {{site.data.keyword.containerlong_notm}} components apply the latest security updates and patches. Security updates and patches are made available by IBM Site Reliability Engineers (SREs) who continuously monitor the Linux image that is installed on your worker nodes to detect vulnerabilities and security compliance issues. For more information, see [Updating worker nodes](/docs/containers/cs_cluster_update.html#worker_node). 

## Are the Kubernetes master and worker nodes highly available?
{: #faq_ha}
{: faq}

The {{site.data.keyword.containerlong_notm}} architecture and infrastructure is designed to ensure reliability, low processing latency, and a maximum uptime of the service. By default, every cluster in {{site.data.keyword.containerlong_notm}} that runs the Kubernetes version 1.10 or higher is set up with multiple Kubernetes master instances to ensure availability and accessibility of your cluster resources, even if one or more instances of your Kubernetes master are unavailable. 

You can make your cluster even more highly available and protect your app from a downtime by spreading your workloads across multiple worker nodes in multiple zones of a region. This setup is called a [multizone cluster](/docs/containers/cs_clusters_planning.html#multizone) and ensures that your app is accessible, even if a worker node or an entire zone is not available. 

To protect against an entire region failure, create [multiple clusters and spread them across {{site.data.keyword.containerlong_notm}} regions](/docs/containers/cs_clusters_planning.html#multiple_clusters). By setting up a load balancer for your clusters, you can achieve cross-region load balancing and cross-region networking for your clusters. 

If you have data that must be available, even if an outage occurs, make sure to store your data on [persistent storage](/docs/containers/cs_storage_planning.html#storage_planning). 

For more information about how to achieve high availability for your cluster, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers/cs_ha.html#ha). 

## What options do I have to secure my cluster?
{: #secure_cluster}
{: faq}

You can use built-in security features in {{site.data.keyword.containerlong_notm}} to protect the components in your cluster, your data, and app deployments to ensure security compliance and data integrity. Use these features to secure your Kubernetes API server, etcd data store, worker node, network, storage, images, and deployments against malicious attacks. You can also leverage built-in logging and monitoring tools to detect malicious attacks and suspicious usage patterns. 

For more information about the components of your cluster and how you can secure each component, see [Security for {{site.data.keyword.containerlong_notm}}](/docs/containers/cs_secure.html#security). 

## Where can I find a list of security bulletins that affect my cluster? 
{: #faq_security_bulletins}
{: faq}

If vulnerabilities are found in Kubernetes, Kubernetes releases CVEs in security bulletins to inform users and to describe the actions that users must take to remediate the vulnerability. Kubernetes security bulletins that affect {{site.data.keyword.containerlong_notm}} users or the {{site.data.keyword.Bluemix_notm}} platform are published in the [{{site.data.keyword.Bluemix_notm}} security bulletin](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security). 

Some CVEs require the latest patch update for a Kubernetes version that you can install as part of the regular [cluster update process](/docs/containers/cs_cluster_update.html#update) in {{site.data.keyword.containerlong_notm}}. Make sure to apply security patches in time to protect your cluster from malicious attacks. For information about what is included in a security patch, refer to the [version changelog](/docs/containers/cs_versions_changelog.html#changelog). 

## Does the service offer support for bare metal and GPU? 
{: #bare_metal_gpu}
{: faq}

Yes, you can provision your worker node as a single-tenant physical bare metal server. Bare metal servers come with high performance benefits for workloads such as data, AI, and GPU. Additionally, all the hardware resources are dedicated to your workloads, so you don't have to worry about "noisy neighbors".

For more information about available bare metal flavors and how bare metal is different from virtual machines, see [Physical machines (bare metal)](/docs/containers/cs_clusters_planning.html#bm).

## Which Kubernetes versions does the service support? 
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a latest version (n) is released, versions up to 2 behind (n-2) are supported. Versions more than 2 behind the latest (n-3) are first deprecated and then unsupported. The following versions are currently supported: 

- Latest: 1.13.2
- Default: 1.10.12
- Other: 1.12.5, 1.11.7

For more information about supported versions and update actions that you must take to move from one version to another, see [Version information and update actions](/docs/containers/cs_versions.html#cs_versions).

## Where is the service available?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} is available worldwide. You can create standard clusters in every supported {{site.data.keyword.containerlong_notm}} region. Free clusters are available only in select regions.

For more information about supported regions, see [Regions and zones](/docs/containers/cs_regions.html#regions-and-zones).

## What standards does the service comply to? 
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}} implements controls commensurate with the following standards: 
- Health Insurance Portability and Accountability Act (HIPAA)
- Service Organization Control standards (SOC 1, SOC 2 Type 1)
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization
- International Organization for Standardization (ISO 27001, ISO 27017, ISO 27018)
- Payment Card Industry Data Security Standard (PCI DSS)

## Can I use IBM Cloud and other services with my cluster?
{: #faq_integrations}
{: faq}

You can add {{site.data.keyword.Bluemix_notm}} platform and infrastructure services as well as services from third-party vendors to your {{site.data.keyword.containerlong_notm}} cluster to enable automation, improve security, or enhance your monitoring and logging capabilities in the cluster.

For a list of supported services, see [Integrating services](/docs/containers/cs_integrations.html#integrations).

## Can I connect my cluster in IBM Cloud Public with apps that run in my on-prem data center?
{: #hybrid}
{: faq}

You can connect services in {{site.data.keyword.Bluemix_notm}} Public with your on-prem data center to create your own hybrid cloud setup. Examples for how you can leverage {{site.data.keyword.Bluemix_notm}} Public and Private with apps that run in your on-prem data center include: 
- You create a cluster with {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public or Dedicated, but you want to connect your cluster with an on-prem database.
- You create a Kubernetes cluster in {{site.data.keyword.Bluemix_notm}} Private in your own data center and deploy apps to your cluster. However, your app might use an {{site.data.keyword.ibmwatson_notm}} service, such as Tone Analyzer, in {{site.data.keyword.Bluemix_notm}} Public.

To enable communication between services that run in {{site.data.keyword.Bluemix_notm}} Public or Dedicated and services that run on-prem, you must [set up a VPN connection](/docs/containers/cs_vpn.html#vpn). To connect your {{site.data.keyword.Bluemix_notm}} Public or Dedicated environment with an {{site.data.keyword.Bluemix_notm}} Private environment, see [Using {{site.data.keyword.containerlong_notm}} with {{site.data.keyword.Bluemix_notm}} Private](/docs/containers/cs_hybrid.html#hybrid_iks_icp).

For an overview of supported {{site.data.keyword.containerlong_notm}} offerings, see [Comparison of offerings and their combinations](/docs/containers/cs_why.html#differentiation).

## Can I deploy IBM Cloud Kubernetes Service in my own data center?
{: #private}
{: faq}

If you do not want to move your apps into {{site.data.keyword.Bluemix_notm}} Public or Dedicated, but you still want to leverage the features of {{site.data.keyword.containerlong_notm}}, you can install {{site.data.keyword.Bluemix_notm}} Private. {{site.data.keyword.Bluemix_notm}} Private is an application platform that can be installed locally on your own machines and that you can use for developing and managing on-prem, containerized apps in your own controlled environment behind a firewall. 

For more information, see the [{{site.data.keyword.Bluemix_notm}} Private product documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html). 

## What am I charged for when I use IBM Cloud Kubernetes Service?
{: #charges}
{: faq}

With {{site.data.keyword.containerlong_notm}} clusters, you can use IBM Cloud infrastructure (SoftLayer) compute, networking, and storage resources with platform services such as Watson AI or Compose Database-as-a-Service. Each resource might entail its own charges that can be [fixed, metered, tiered, or reserved](/docs/billing-usage/how_charged.html#charges). 
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
  <li><strong>Longer ordering process</strong>:  After you order or cancel a bare metal server, the process is completed manually in your IBM Cloud infrastructure (SoftLayer) account. Therefore, it can take more than one business day to complete.</li></ul>
  <p>For details on the machine specifications, see [Available hardware for worker nodes](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Public bandwidth</dt>
  <dd><p>Bandwidth refers to the public data transfer of inbound and outbound network traffic, both to and from {{site.data.keyword.Bluemix_notm}} resources in data centers around the globe. Public bandwidth is charged per GB. You can review your current bandwidth summary by logging into the [{{site.data.keyword.Bluemix_notm}} console](https://cloud.ibm.com/), from the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon") selecting **Classic Infrastructure**, and then selecting the **Network > Bandwidth > Summary** page.
  <p>Review the following factors that impact public bandwidth charges:</p>
  <ul><li><strong>Location</strong>: As with worker nodes, charges vary depending on the zone that your resources are deployed in.</li>
  <li><strong>Included bandwidth or Pay-As-You-Go</strong>: Your worker node machines might come with a certain allocation of outbound networking per month, such as 250GB for VMs or 500GB for bare metal. Or, the allocation might be Pay-As-You-Go, based on GB usage.</li>
  <li><strong>Tiered packages</strong>: After you exceed any included bandwidth, you are charged according to a tiered usage scheme that varies by location. If you exceed a tier allotment, you might also be charged a standard data transfer fee.</li></ul>
  <p>For more information, see [Bandwidth packages ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Subnet IP addresses</dt>
  <dd><p>When you create a standard cluster, a portable public subnet with 8 public IP addresses is ordered and charged to your account monthly.</p><p>If you already have available subnets in your infrastructure account, you can use these subnets instead. Create the cluster with the `--no-subnets` [flag](/docs/containers/cs_cli_reference.html#cs_cluster_create), and then [reuse your subnets](/docs/containers/cs_subnets.html#subnets_custom).</p>
  </dd>

<dt id="storage">Storage</dt>
  <dd>When you provision storage, you can choose the storage type and storage class that is right for your use case. Charges vary depending on the type of storage, the location, and the specs of the storage instance. Some storage solutions, such as file and block storage offer hourly and monthly plans that you can choose from. To choose the right storage solution, see [Planning highly available persistent storage](/docs/containers/cs_storage_planning.html#storage_planning). For more information, see:
  <ul><li>[NFS file storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Block storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Object storage plans![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} services</dt>
  <dd>Each service that you integrate with your cluster has its own pricing model. Consult each product documentation and use the {{site.data.keyword.Bluemix_notm}} console to [estimate costs](/docs/billing-usage/estimating_costs.html#cost).</dd>

</dl>

Monthly resources are billed based upon the first of the month for usage in the preceding month. If you order a monthly resource in the middle of the month, you are charged a prorated amount for that month. However, if you cancel a resource in the middle of the month, you are still charged the full amount for the monthly resource.
{: note}

## Are my platform and infrastructure resources consolidated in one bill?
{: #bill}
{: faq}

When you use a billable {{site.data.keyword.Bluemix_notm}} account, platform and infrastructure resources are summarized in one bill.
If you linked your {{site.data.keyword.Bluemix_notm}} and IBM Cloud infrastructure (SoftLayer) accounts, you receive a [consolidated bill](/docs/customer-portal/linking_accounts.html#unifybillaccounts) for your {{site.data.keyword.Bluemix_notm}} platform and infrastructure resources. 

## Can I estimate my costs?
{: #cost_estimate}
{: faq}

Yes, see [Estimating your costs](/docs/billing-usage/estimating_costs.html#cost). Keep in mind that some charges are not reflected in the estimate, such as tiered pricing for increased hourly usage. For more information, see [What am I charged for when I use {{site.data.keyword.containerlong_notm}}?](#charges).

## Can I view my current usage? 
{: #usage}
{: faq}

You can check your current usage and estimated monthly totals for your {{site.data.keyword.Bluemix_notm}} platform and infrastructure resources. For more information, see [Viewing your usage](/docs/billing-usage/viewing_usage.html#viewingusage). To organize your billing, you can group your resources with [resource groups](/docs/resources/bestpractice_rgs.html#bp_resourcegroups). 
