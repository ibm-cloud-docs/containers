---

copyright:
  years: 2014, 2020
lastupdated: "2020-05-18"

keywords: kubernetes, iks, compliance, security standards, faq, kubernetes pricing, kubernetes service pricing, ibm cloud kubernetes service pricing, iks pricing, kubernetes charges, kubernetes service charges, ibm cloud kubernetes service charges, iks charges, kubernetes price, kubernetes service price, ibm cloud kubernetes service price, iks price, kubernetes billing, kubernetes service billing, ibm cloud kubernetes service billing, iks billing, kubernetes costs, kubernetes service costs, ibm cloud kubernetes service costs, iks costs

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# FAQs
{: #faqs}

Review frequently asked questions for using {{site.data.keyword.containerlong}}.
{: shortdesc}



## What is Kubernetes?
{: #kubernetes}
{: faq}

Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers managements tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention. All containers that make up your microservice are grouped into pods, a logical unit to ensure easy management and discovery. These pods run on compute hosts that are managed in a Kubernetes cluster that is portable, extensible, and self-healing in case of failures.
{: shortdesc}

For more information about Kubernetes, see the [Kubernetes documentation](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational){: external}.



## How does {{site.data.keyword.containerlong_notm}} work?
{: #kubernetes_service}
{: faq}
{: support}

With {{site.data.keyword.containerlong_notm}}, you can create your own Kubernetes cluster to deploy and manage containerized apps on {{site.data.keyword.cloud_notm}}. Your containerized apps are hosted on IBM Cloud infrastructure compute hosts that are called worker nodes. You can choose to provision your compute hosts as [virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm) with shared or dedicated resources, or as [bare metal machines](/docs/containers?topic=containers-planning_worker_nodes#bm) that can be optimized for GPU and software-defined storage (SDS) usage. Your worker nodes are controlled by a highly available Kubernetes master that is configured, monitored, and managed by IBM. You can use the {{site.data.keyword.containerlong_notm}} API or CLI to work with your cluster infrastructure resources and the Kubernetes API or CLI to manage your deployments and services.

For more information about how your cluster resources are set up, see the [Service architecture](/docs/containers?topic=containers-service-arch). To find a list of capabilities and benefits, see [Benefits and service offerings](/docs/containers?topic=containers-cs_ov).

## Why should I use {{site.data.keyword.containerlong_notm}}?
{: #faq_benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} is a managed Kubernetes offering that delivers powerful tools, an intuitive user experience, and built-in security for rapid delivery of apps that you can bind to cloud services that are related to {{site.data.keyword.ibmwatson}}, AI, IoT, DevOps, security, and data analytics. As a certified Kubernetes provider, {{site.data.keyword.containerlong_notm}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management. The service also has advanced capabilities around simplified cluster management, container security and isolation policies, the ability to design your own cluster, and integrated operational tools for consistency in deployment.

For a detailed overview of capabilities and benefits, see [Benefits of using the service](/docs/containers?topic=containers-cs_ov#benefits).

## Can I get a free cluster?
{: #faq_free}
{: faq}
{: support}

You can have 1 free cluster at a time in {{site.data.keyword.containerlong_notm}}, and each free cluster expires in 30 days. Free clusters have [select capabilities](/docs/containers?topic=containers-cs_ov#cluster_types), minimal 2x4 compute resources, select single zone [locations](/docs/containers?topic=containers-regions-and-zones#regions_free), and support only the Kubernetes container platform and {{site.data.keyword.cloud_notm}} classic infrastructure provider. Free clusters are ideal for testing out Kubernetes deployments and getting familiar with the {{site.data.keyword.containerlong_notm}} API, CLI, and console tools. After you are done playing around with your free cluster, you can [copy your configuration files and redeploy them to a standard cluster](/docs/containers?topic=containers-update_app#copy_apps_cluster).

To create a free cluster, you must have a Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account. Free clusters cannot be created in Lite accounts.
{: note}


## What container platforms are available for my cluster?
{: #container_platforms}
{: faq}
{: support}

With {{site.data.keyword.cloud_notm}}, you can create clusters for your containerized workloads from two different container management platforms: the IBM version of community Kubernetes and Red Hat OpenShift on IBM Cloud. The container platform that you select is installed on your cluster master and worker nodes. Later, you can [update the version](/docs/containers?topic=containers-update#update) but cannot roll back to a previous version or switch to a different container platform. If you want to use multiple container platforms, create a separate cluster for each.

For more information, see [Comparison between OpenShift and community Kubernetes clusters](/docs/containers?topic=containers-cs_ov#openshift_kubernetes).

<dl>
  <dt>Kubernetes</dt>
    <dd>[Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/) is a production-grade, open source container orchestration platform that you can use to automate, scale, and manage your containerized apps that run on an Ubuntu operating system. With the [{{site.data.keyword.containerlong_notm}} version](/docs/containers?topic=containers-cs_versions#cs_versions), you get access to community Kubernetes API features that are considered **beta** or higher by the community. Kubernetes **alpha** features, which are subject to change, are generally not enabled by default. With Kubernetes, you can combine various resources such as secrets, deployments, and services to securely create and manage highly available, containerized apps.<br><br>
    To get started, [create a Kubernetes cluster](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial).</dd>
  <dt>OpenShift</dt>
    <dd>Red Hat OpenShift on IBM Cloud is a Kubernetes-based platform that is designed especially to accelerate your containerized app delivery processes that run on a Red Hat Enterprise Linux 7 operating system. You can orchestrate and scale your existing OpenShift workloads across on-prem and off-prem clouds for a portable, hybrid solution that works the same in multicloud scenarios. <br><br>
    To get started, try out the [Red Hat OpenShift on IBM Cloud tutorial](/docs/openshift?topic=openshift-openshift_tutorial).</dd>
</dl>

## Does the service come with a managed Kubernetes master and worker nodes?
{: #managed_master_worker}
{: faq}

Every cluster in {{site.data.keyword.containerlong_notm}} is controlled by a dedicated Kubernetes master that is managed by IBM in an IBM-owned {{site.data.keyword.cloud_notm}} infrastructure account. The Kubernetes master, including all the master components, compute, networking, and storage resources, is continuously monitored by IBM Site Reliability Engineers (SREs). The SREs apply the latest security standards, detect and remediate malicious activities, and work to ensure reliability and availability of {{site.data.keyword.containerlong_notm}}. Add-ons, such as Fluentd for logging, that are installed automatically when you provision the cluster are automatically updated by IBM. However, you can choose to disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. For more information, see [Updating cluster add-ons](/docs/containers?topic=containers-update#addons).

Periodically, Kubernetes releases [major, minor, or patch updates](/docs/containers?topic=containers-cs_versions#version_types). These updates can affect the Kubernetes API server version or other components in your Kubernetes master. IBM automatically updates the patch version, but you must update the master major and minor versions. For more information, see [Updating the master](/docs/containers?topic=containers-update#master).

Worker nodes in standard clusters are provisioned in to your {{site.data.keyword.cloud_notm}} infrastructure account. The worker nodes are dedicated to your account and you are responsible to request timely updates to the worker nodes to ensure that the worker node OS and {{site.data.keyword.containerlong_notm}} components apply the latest security updates and patches. Security updates and patches are made available by IBM Site Reliability Engineers (SREs) who continuously monitor the Linux image that is installed on your worker nodes to detect vulnerabilities and security compliance issues. For more information, see [Updating worker nodes](/docs/containers?topic=containers-update#worker_node).

## Are the master and worker nodes highly available?
{: #faq_ha}
{: faq}

The {{site.data.keyword.containerlong_notm}} architecture and infrastructure is designed to ensure reliability, low processing latency, and a maximum uptime of the service. By default, every cluster in {{site.data.keyword.containerlong_notm}} is set up with multiple Kubernetes master instances to ensure availability and accessibility of your cluster resources, even if one or more instances of your Kubernetes master are unavailable.

You can make your cluster even more highly available and protect your app from a downtime by spreading your workloads across multiple worker nodes in multiple zones of a region. This setup is called a [multizone cluster](/docs/containers?topic=containers-ha_clusters#multizone) and ensures that your app is accessible, even if a worker node or an entire zone is not available.

To protect against an entire region failure, create [multiple clusters and spread them across {{site.data.keyword.cloud_notm}} regions](/docs/containers?topic=containers-ha_clusters#multiple_clusters). By setting up a network load balancer (NLB) for your clusters, you can achieve cross-region load balancing and cross-region networking for your clusters.

If you have data that must be available, even if an outage occurs, make sure to store your data on [persistent storage](/docs/containers?topic=containers-storage_planning#storage_planning).

For more information about how to achieve high availability for your cluster, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha#ha).

## What options do I have to secure my cluster?
{: #secure_cluster}
{: faq}
{: support}

You can use built-in security features in {{site.data.keyword.containerlong_notm}} to protect the components in your cluster, your data, and app deployments to ensure security compliance and data integrity. Use these features to secure your Kubernetes API server, etcd data store, worker node, network, storage, images, and deployments against malicious attacks. You can also leverage built-in logging and monitoring tools to detect malicious attacks and suspicious usage patterns.

For more information about the components of your cluster and how you can secure each component, see [Security for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-security#security).

## What access policies do I give my cluster users?
{: #faq_access}
{: faq}
{: support}

{{site.data.keyword.containerlong_notm}} uses {{site.data.keyword.iamshort}} (IAM) to grant access to cluster resources through IAM platform roles and Kubernetes role-based access control (RBAC) policies through IAM service roles. For more information about types of access policies, see [Pick the right access policy and role for your users](/docs/containers?topic=containers-users#access_roles).
{: shortdesc}

The access policies that you assign users vary depending on what you want your users to be able to do. You can find more information about what roles authorize which types of actions on the [User access reference page](/docs/containers?topic=containers-access_reference) or in the following table's links. For steps to assign policies, see [Granting users access to your cluster through {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform).

| Use case | Example roles and scope |
| --- | --- |
| App auditor | [Viewer platform role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform), [Reader service role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#service). |
| App developers | [Editor platform role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Writer service role scoped to a namespace](/docs/containers?topic=containers-access_reference#service), [Cloud Foundry developer space role](/docs/containers?topic=containers-access_reference#cloud-foundry). |
| Billing | [Viewer platform role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform). |
| Create a cluster | Account-level permissions set by the API key with Super User infrastructure credentials for classic clusters, or the Administrator platform role to VPC Infrastructure for VPC clusters. Individual user permissions for Administrator platform role to {{site.data.keyword.containerlong_notm}}, and Administrator platform role to {{site.data.keyword.registrylong_notm}}. For more information, see [Preparing to create clusters](/docs/containers?topic=containers-clusters#cluster_prepare).|
| Cluster administrator | [Administrator platform role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Manager service role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-access_reference#service).|
| DevOps operator | [Operator platform role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Writer service role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-access_reference#service), [Cloud Foundry developer space role](/docs/containers?topic=containers-access_reference#cloud-foundry).  |
| Operator or site reliability engineer | [Administrator platform role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform), [Reader service role for a cluster or region](/docs/containers?topic=containers-access_reference#service) or [Manager service role for all cluster namespaces](/docs/containers?topic=containers-access_reference#service) to be able to use `kubectl top nodes,pods` commands. |
{: caption="Types of roles you might assign to meet different use cases." caption-side="top"}

## Where can I find a list of security bulletins that affect my cluster?
{: #faq_security_bulletins}
{: faq}
{: support}

If vulnerabilities are found in Kubernetes, Kubernetes releases CVEs in security bulletins to inform users and to describe the actions that users must take to remediate the vulnerability. Kubernetes security bulletins that affect {{site.data.keyword.containerlong_notm}} users or the {{site.data.keyword.cloud_notm}} platform are published in the [{{site.data.keyword.cloud_notm}} security bulletin](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security).

Some CVEs require the latest patch update for a version that you can install as part of the regular [cluster update process](/docs/containers?topic=containers-update#update) in {{site.data.keyword.containerlong_notm}}. Make sure to apply security patches in time to protect your cluster from malicious attacks. For more information about what is included in a security patch, refer to the [version changelog](/docs/containers?topic=containers-changelog#changelog).

## Does the service offer support for bare metal and GPU?
{: #bare_metal_gpu}
{: faq}

Yes, you can provision your worker node as a single-tenant physical bare metal server. Bare metal servers come with high-performance benefits for workloads such as data, GPU, and AI. Additionally, all the hardware resources are dedicated to your workloads, so you don't have to worry about "noisy neighbors".

For more information about available bare metal flavors and how bare metal is different from virtual machines, see [Physical machines (bare metal)](/docs/containers?topic=containers-planning_worker_nodes#bm).

## Which Kubernetes versions does the service support?
{: #supported_kube_versions}
{: faq}
{: support}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a latest version (n) is released, versions up to 2 behind (n-2) are supported. Versions more than 2 behind the latest (n-3) are first deprecated and then unsupported. The following versions are currently supported:

**Supported Kubernetes versions**:
*   Latest: 1.18.2
*   Default: 1.16.9
*   Other: 1.17.5

For more information about supported versions and update actions that you must take to move from one version to another, see [Version information and update actions](/docs/containers?topic=containers-cs_versions#cs_versions).

Have an [OpenShift cluster](/docs/openshift?topic=openshift-openshift_tutorial)? The supported OpenShift version is 4.3, which includes Kubernetes 1.16.
{: note}


## Where is the service available?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} is available worldwide. You can create standard clusters in every supported {{site.data.keyword.containerlong_notm}} region. Free clusters are available only in select regions.

For more information about supported regions, see [Locations](/docs/containers?topic=containers-regions-and-zones#regions-and-zones).

## Is the service highly available?
{: #ha_sla}
{: faq}

Yes. By default, {{site.data.keyword.containerlong_notm}} sets up many components such as the cluster master with replicas, anti-affinity, and other options to increase the high availability (HA) of the service. You can increase the redundancy and failure toleration of your cluster worker nodes, storage, networking, and workloads by configuring them in a highly available architecture. For an overview of the default setup and your options to increase HA, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha).

For the latest HA service level agreement terms, refer to the [{{site.data.keyword.cloud_notm}} terms of service](/docs/overview/terms-of-use?topic=overview-terms#terms). Generally, the SLA availability terms require that when you configure your infrastructure resources in an HA architecture, you must distribute them evenly across three different availability zones. For example, to receive full HA coverage under the SLA terms, you must [set up a multizone cluster](/docs/containers?topic=containers-ha_clusters#multizone) with a total of at least 9 worker nodes, three worker nodes per zone that are evenly spread across three zones.

## What standards does the service comply to?
{: #standards}
{: faq}

{{site.data.keyword.cloud_notm}} is built by following many data, finance, health, insurance, privacy, security, technology, and other international compliance standards. For more information, see [{{site.data.keyword.cloud_notm}} compliance](/docs/overview?topic=overview-compliance).

To view detailed system requirements, you can run a [software product compatibility report for {{site.data.keyword.containerlong_notm}}](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=4440E450C2C811E6A98AAE81A233E762){: external}. Note that compliance depends on the underlying [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers) for the cluster worker nodes, networking, and storage resources.

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **Classic infrastructure**: {{site.data.keyword.containerlong_notm}} implements controls commensurate with the following standards:
- EU-US Privacy Shield and Swiss-US Privacy Shield Framework
- Health Insurance Portability and Accountability Act (HIPAA)
- Service Organization Control standards (SOC 1 Type 2, SOC 2 Type 2)
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization
- International Organization for Standardization (ISO 27001, ISO 27017, ISO 27018)
- Payment Card Industry Data Security Standard (PCI DSS)

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **VPC infrastructure**: {{site.data.keyword.containerlong_notm}} implements controls commensurate with the following standards:
- EU-US Privacy Shield and Swiss-US Privacy Shield Framework
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization


## Can I use IBM Cloud and other services with my cluster?
{: #faq_integrations}
{: faq}

You can add {{site.data.keyword.cloud_notm}} platform and infrastructure services as well as services from third-party vendors to your {{site.data.keyword.containerlong_notm}} cluster to enable automation, improve security, or enhance your monitoring and logging capabilities in the cluster.

For a list of supported services, see [Integrating services](/docs/containers?topic=containers-supported_integrations#supported_integrations).



## Where can I find more information about {{site.data.keyword.containerlong_notm}} pricing models?
{: #pricing}
{: faq}

To find detailed pricing information for the service, see [{{site.data.keyword.containerlong_notm}}: Pricing](https://www.ibm.com/cloud/container-service/pricing){: external}. You can also review what components you are [charged for when you use {{site.data.keyword.containerlong_notm}}](#charges) or [estimate your costs](#cost_estimate).

## What am I charged for when I use {{site.data.keyword.containerlong_notm}}?
{: #charges}
{: faq}
{: support}

With {{site.data.keyword.containerlong_notm}} clusters, you can use IBM Cloud infrastructure compute, networking, and storage resources with platform services such as Watson AI or Compose Database-as-a-Service. Each resource might entail its own charges that can be [fixed, metered, tiered, or reserved](/docs/billing-usage?topic=billing-usage-charges#charges).
* [Worker nodes](#nodes)
* [Outbound networking](#bandwidth)
* [Subnet IP addresses](#subnet_ips)
* [Multizone load balancer](#mzlb_pricing)
* [Storage](#persistent_storage)
* [{{site.data.keyword.cloud_notm}} services](#services)

<dl>
  <dt id="nodes">Worker nodes</dt>
    <dd><p>Clusters can have two main types of worker nodes: virtual or physical (bare metal) machines. Flavor (machine type) availability and pricing varies by the zone that you deploy your cluster to.</p>
    <p><strong>Virtual machines</strong> feature greater flexibility, quicker provisioning times, and more automatic scalability features than bare metal, at a more cost-effective price than bare-metal. However, VMs have a performance trade-off when compared to bare metal specs, such as networking Gbps, RAM and memory thresholds, and storage options. Keep in mind these factors that impact your VM costs:</p>
    <ul><li><strong>Shared vs. dedicated</strong>: If you share the underlying hardware of the VM, the cost is lower than dedicated hardware, but the physical resources are not dedicated to your VM. VPC clusters are available only as **shared**.</li>
    <li><strong>Hourly billing only</strong>: Hourly offers more flexibility to order and cancel VMs quickly.
    <li><strong>Tiered hours per month</strong>: Hourly billing is tiered. As your VM remains ordered for a tier of hours within a billing month, the hourly rate that you are charged lowers. The tiers of hours are as follows: 0 - 150 hours, 151 - 290 hours, 291 - 540 hours, and 541+ hours.</li></ul>
    <p><strong>Physical machines, or bare metal, (not available for VPC clusters)</strong> yield high-performance benefits for workloads such as data, GPU, and AI. Additionally, all the hardware resources are dedicated to your workloads, so you don't have "noisy neighbors". Keep in mind these factors that impact your bare metal costs:</p>
    <ul><li><strong>Monthly billing only</strong>: All bare metals are charged monthly.</li>
    <li><strong>Longer ordering process</strong>:  After you order or cancel a bare metal server, the process is completed manually in your IBM Cloud infrastructure account. Therefore, it can take more than one business day to complete.</li></ul>
    <p>For more information about the machine specifications, see [Available hardware for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).</p></dd>
  <dt id="bandwidth">Public bandwidth</dt>
    <dd><p>Bandwidth refers to the public data transfer of inbound and outbound network traffic, both to and from {{site.data.keyword.cloud_notm}} resources in data centers around the globe.</p>
    <p>**Classic clusters**: Public bandwidth is charged per GB. You can review your current bandwidth summary by logging into the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/), from the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon") selecting **Classic Infrastructure**, and then selecting the **Network > Bandwidth > Summary** page.</p>
    <p>Review the following factors that impact public bandwidth charges:</p>
    <ul><li><strong>Location</strong>: As with worker nodes, charges vary depending on the zone that your resources are deployed in.</li>
    <li><strong>Pay-As-You-Go for VM</strong>: Because VMs are billed hourly, your VM worker node machines have a Pay-As-You-Go allocation of outbound networking based on GB usage.</li>
    <li><strong>Included bandwidth and tiered packages for BM</strong>: Bare metal worker nodes might come with a certain allocation of outbound networking per month that varies by geography: 20 TB for North America and Europe, or 5 TB for Asia Pacific and South America. After you exceed your included bandwidth, you are charged according to a tiered usage scheme for your geography. If you exceed a tier allotment, you might also be charged a standard data transfer fee. For more information, see [Bandwidth packages ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/bandwidth).</li></ul>
    <p>**VPC clusters**: For more information about how internet data transfer works in your Virtual Private Cloud, see [Pricing for VPC ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/vpc/pricing).</p></dd>
  <dt id="subnet_ips">Subnet IP addresses</dt>
    <dd><p>**Classic clusters**: When you create a standard cluster, a portable public subnet with 8 public IP addresses is ordered and charged to your account monthly. For pricing information, see the [Subnets and IPs](/docs/subnets?topic=subnets-getting-started) documentation or estimate your costs in the [classic subnets console ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/classic/network/subnet/provision)</p><p>If you already have available portable public subnets in your infrastructure account, you can use these subnets instead. Create the cluster with the `--no-subnets` [flag](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create), and then [reuse your subnets](/docs/containers?topic=containers-subnets#subnets_custom).
    <p>**VPC clusters**: For more information about charges for floating IPs and other networking costs, see [Pricing for VPC ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/vpc/pricing).</p></dd>
  <dt id="mzlb_pricing">Multizone load balancer</dt>
    <dd>When you create a multizone cluster or add zones to a single zone cluster, you must have a load balancer to health check Ingress and load balancer IP addresses in each zone, and forward requests to your apps across zones in the region. The type of load balancer that is automatically created varies depending on the type of cluster. For more information, see [Multizone load balancer (MZLB) or Load Balancer for VPC](/docs/containers?topic=containers-ingress-about#mzlb).<ul><li>**Classic clusters**: A Cloudflare MZLB is automatically created for each multizone cluster. You can view the hourly cost in the pricing summary when you create the cluster.</li><li>**VPC clusters**: A Load Balancer for VPC is automatically created in your VPC for your cluster. For cost information, see [Pricing for Load Balancer for VPC](https://www.ibm.com/cloud/vpc/pricing){: external}.</li></ul></dd>
  <dt id="persistent_storage">Storage</dt>
    <dd>When you provision storage, you can choose the storage type and storage class that is right for your use case. Charges vary depending on the type of storage, the location, and the specs of the storage instance. Some storage solutions, such as file and block storage offer hourly and monthly plans that you can choose from. To choose the right storage solution, see [Planning highly available persistent storage](/docs/containers?topic=containers-storage_planning#storage_planning).<p class="note">For VPC, only block storage is available.</p>For more information, see:
    <ul><li>[NFS file storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/file-storage/pricing)</li>
    <li>[Block storage pricing![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</li>
    <li>[Object storage plans![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/object-storage/pricing/#s3api)</li></ul></dd>
  <dt id="services">{{site.data.keyword.cloud_notm}} services</dt>
    <dd>Each service that you integrate with your cluster has its own pricing model. Review each product documentation and use the {{site.data.keyword.cloud_notm}} console to [estimate costs](/docs/billing-usage?topic=billing-usage-cost#cost).</dd>
</dl>
<br><br>

Monthly resources are billed based on the first of the month for usage in the preceding month. If you order a monthly resource in the middle of the month, you are charged a prorated amount for that month. However, if you cancel a resource in the middle of the month, you are still charged the full amount for the monthly resource.
{: note}



## Are my platform and infrastructure resources consolidated in one bill?
{: #bill}
{: faq}

When you use a billable {{site.data.keyword.cloud_notm}} account, platform and infrastructure resources are summarized in one bill.

If you linked your {{site.data.keyword.cloud_notm}} and classic IBM Cloud infrastructure accounts, you receive a [consolidated bill](/docs/customer-portal?topic=customer-portal-unifybillaccounts#unifybillaccounts) for your {{site.data.keyword.cloud_notm}} platform and infrastructure resources.

## Can I estimate my costs?
{: #cost_estimate}
{: faq}

Yes, see [Estimating your costs](/docs/billing-usage?topic=billing-usage-cost#cost). Keep in mind that some charges are not reflected in the estimate, such as tiered pricing for increased hourly usage. For more information, see [What am I charged for when I use {{site.data.keyword.containerlong_notm}}?](#charges).

## Can I view my current usage?
{: #usage}
{: faq}

You can check your current usage and estimated monthly totals for your {{site.data.keyword.cloud_notm}} platform and infrastructure resources. For more information, see [Viewing your usage](/docs/billing-usage?topic=billing-usage-viewingusage#viewingusage). To organize your billing, you can group your resources with [resource groups](/docs/resources?topic=resources-bp_resourcegroups#bp_resourcegroups).

## Can I add tags to my cluster?
{: #faq_tags}
{: faq}

Yes, you can add tags to your cluster to help organize your {{site.data.keyword.cloud_notm}} resources such as for billing purposes. For more information, see [Adding tags to existing clusters](/docs/containers?topic=containers-add_workers#cluster_tags).

