---

copyright: 
  years: 2014, 2023
lastupdated: "2023-02-16"

keywords: kubernetes, compliance, security standards, faq, kubernetes pricing, kubernetes service pricing, kubernetes charges, kubernetes service charges, kubernetes price, kubernetes service price,   kubernetes billing, kubernetes service billing, kubernetes costs, kubernetes service costs, 

subcollection: containers

content-type: faq

---

{{site.data.keyword.attribute-definition-list}}






# FAQs
{: #faqs}


Review frequently asked questions (FAQs) for using {{site.data.keyword.containerlong}}.
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

To create a free cluster, you must have a Pay-As-You-Go or Subscription {{site.data.keyword.cloud_notm}} account. Free clusters can't be created in Lite accounts.
{: note}



## What container platforms are available for my cluster?
{: #container_platforms}
{: faq}
{: support}

With {{site.data.keyword.cloud_notm}}, you can create clusters for your containerized workloads from two different container management platforms: the IBM version of community Kubernetes and {{site.data.keyword.openshiftlong_notm}}. The container platform that you select is installed on your cluster master and worker nodes. Later, you can [update the version](/docs/containers?topic=containers-update#update) but can't roll back to a previous version or switch to a different container platform. If you want to use multiple container platforms, create a separate cluster for each.

For more information, see [Comparison between {{site.data.keyword.redhat_openshift_notm}} and community Kubernetes clusters](/docs/containers?topic=containers-cs_ov#openshift_kubernetes).

Kubernetes
:   [Kubernetes](https://kubernetes.io/){: external} is a production-grade, open source container orchestration platform that you can use to automate, scale, and manage your containerized apps that run on an Ubuntu operating system. With the [{{site.data.keyword.containerlong_notm}} version](/docs/containers?topic=containers-cs_versions#cs_versions), you get access to community Kubernetes API features that are considered **beta** or higher by the community. Kubernetes **alpha** features, which are subject to change, are generally not enabled by default. With Kubernetes, you can combine various resources such as secrets, deployments, and services to securely create and manage highly available, containerized apps.

{{site.data.keyword.redhat_openshift_notm}}
:   {{site.data.keyword.openshiftlong_notm}} is a Kubernetes-based platform that is designed especially to accelerate your containerized app delivery processes that run on a Red Hat Enterprise Linux 7 operating system. You can orchestrate and scale your existing {{site.data.keyword.redhat_openshift_notm}} workloads across on-prem and off-prem clouds for a portable, hybrid solution that works the same in multicloud scenarios. To get started, try out the [{{site.data.keyword.openshiftlong_notm}} tutorial](/docs/openshift?topic=openshift-openshift_tutorial).

## Does the service come with a managed Kubernetes master and worker nodes?
{: #managed_master_worker}
{: faq}

Every cluster in {{site.data.keyword.containerlong_notm}} is controlled by a dedicated Kubernetes master that is managed by IBM in an IBM-owned {{site.data.keyword.cloud_notm}} infrastructure account. The Kubernetes master, including all the master components, compute, networking, and storage resources, is continuously monitored by IBM Site Reliability Engineers (SREs). The SREs apply the latest security standards, detect and remediate malicious activities, and work to ensure reliability and availability of {{site.data.keyword.containerlong_notm}}. Add-ons, such as Fluentd for logging, that are installed automatically when you provision the cluster are automatically updated by IBM. However, you can choose to disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. For more information, see [Updating cluster add-ons](/docs/containers?topic=containers-update#addons).

Periodically, Kubernetes releases [major, minor, or patch updates](/docs/containers?topic=containers-cs_versions#update_types). These updates can affect the Kubernetes API server version or other components in your Kubernetes master. IBM automatically updates the patch version, but you must update the master major and minor versions. For more information, see [Updating the master](/docs/containers?topic=containers-update#master).

Worker nodes in standard clusters are provisioned in to your {{site.data.keyword.cloud_notm}} infrastructure account. The worker nodes are dedicated to your account and you are responsible to request timely updates to the worker nodes to ensure that the worker node OS and {{site.data.keyword.containerlong_notm}} components apply the latest security updates and patches. Security updates and patches are made available by IBM Site Reliability Engineers (SREs) who continuously monitor the Linux image that is installed on your worker nodes to detect vulnerabilities and security compliance issues. For more information, see [Updating worker nodes](/docs/containers?topic=containers-update#worker_node).

## Are the master and worker nodes highly available?
{: #faq_ha}
{: faq}

The {{site.data.keyword.containerlong_notm}} architecture and infrastructure is designed to ensure reliability, low processing latency, and a maximum uptime of the service. By default, every cluster in {{site.data.keyword.containerlong_notm}} is set up with multiple Kubernetes master instances to ensure availability and accessibility of your cluster resources, even if one or more instances of your Kubernetes master are unavailable.

You can make your cluster even more highly available and protect your app from a downtime by spreading your workloads across multiple worker nodes in multiple zones of a region. This setup is called a [multizone cluster](/docs/containers?topic=containers-ha_clusters#mz-clusters) and ensures that your app is accessible, even if a worker node or an entire zone is not available.

To protect against an entire region failure, create [multiple clusters and spread them across {{site.data.keyword.cloud_notm}} regions](/docs/containers?topic=containers-ha_clusters#multiple-clusters-glb). By setting up a network load balancer (NLB) for your clusters, you can achieve cross-region load balancing and cross-region networking for your clusters.

If you have data that must be available, even if an outage occurs, make sure to store your data on [persistent storage](/docs/containers?topic=containers-storage_planning#storage_planning).

For more information about how to achieve high availability for your cluster, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha#ha).

## What options do I have to secure my cluster?
{: #secure_cluster}
{: faq}
{: support}

You can use built-in security features in {{site.data.keyword.containerlong_notm}} to protect the components in your cluster, your data, and app deployments to ensure security compliance and data integrity. Use these features to secure your Kubernetes API server, etcd data store, worker node, network, storage, images, and deployments against malicious attacks. You can also leverage built-in logging and monitoring tools to detect malicious attacks and suspicious usage patterns.

For more information about the components of your cluster and how you can meet security standards for each component, see [Security for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-security#security).

## What access policies do I give my cluster users?
{: #faq_access}
{: faq}
{: support}

{{site.data.keyword.containerlong_notm}} uses {{site.data.keyword.iamshort}} (IAM) to grant access to cluster resources through IAM platform access roles and Kubernetes role-based access control (RBAC) policies through IAM service access roles. For more information about types of access policies, see [Pick the correct access policy and role for your users](/docs/containers?topic=containers-access-overview#access_roles).
{: shortdesc}

The access policies that you assign users vary depending on what you want your users to be able to do. You can find more information about what roles authorize which types of actions on the [User access reference page](/docs/containers?topic=containers-access_reference) or in the following table's links. For steps to assign policies, see [Granting users access to your cluster through {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#checking-perms).

| Use case | Example roles and scope |
| --- | --- |
| App auditor | [Viewer platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-iam-platform-access-roles#viewer-iam-platform-role), [Reader service access role for a cluster, region, or resource group](/docs/containers?topic=containers-iam-service-access-roles). |
| App developers | [Editor platform access role for a cluster](/docs/containers?topic=containers-iam-platform-access-roles#editor-iam-platform-role), [Writer service access role scoped to a namespace](/docs/containers?topic=containers-iam-service-access-roles), [Cloud Foundry developer space role](/docs/containers?topic=containers-cloud-foundry-roles). |
| Billing | [Viewer platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-iam-platform-access-roles#viewer-iam-platform-role). |
| Create a cluster | See [Permissions to create a cluster](/docs/containers?topic=containers-access_reference#cluster_create_permissions).|
| Cluster administrator | [Administrator platform access role for a cluster](/docs/containers?topic=containers-iam-platform-access-roles#admin-iam-platform-role), [Manager service access role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-iam-service-access-roles).|
| DevOps operator | [Operator platform access role for a cluster](/docs/containers?topic=containers-iam-platform-access-roles#operator-iam-platform-role), [Writer service access role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-iam-service-access-roles), [Cloud Foundry developer space role](/docs/containers?topic=containers-cloud-foundry-roles).  |
| Operator or site reliability engineer | [Administrator platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-iam-platform-access-roles#admin-iam-platform-role), [Reader service access role for a cluster or region](/docs/containers?topic=containers-iam-service-access-roles) or [Manager service access role for all cluster namespaces](/docs/containers?topic=containers-iam-service-access-roles) to be able to use `kubectl top nodes,pods` commands. |
{: caption="Types of roles you might assign to meet different use cases." caption-side="bottom"}

## Where can I find a list of security bulletins that affect my cluster?
{: #faq_security_bulletins}
{: faq}
{: support}

If vulnerabilities are found in Kubernetes, Kubernetes releases CVEs in security bulletins to inform users and to describe the actions that users must take to remediate the vulnerability. Kubernetes security bulletins that affect {{site.data.keyword.containerlong_notm}} users or the {{site.data.keyword.cloud_notm}} platform are published in the [{{site.data.keyword.cloud_notm}} security bulletin](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security).

Some CVEs require the latest patch update for a version that you can install as part of the regular [cluster update process](/docs/containers?topic=containers-update#update) in {{site.data.keyword.containerlong_notm}}. Make sure to apply security patches in time to protect your cluster from malicious attacks. For more information about what is included in a security patch, refer to the [version changelog](/docs/containers?topic=containers-cs_versions#cs_versions_available).

## Does the service offer support for bare metal and GPU?
{: #bare_metal_gpu}
{: faq}

Certain VPC worker node flavors offer GPU support. For more information, see the [VPC flavors](/docs/containers?topic=containers-vpc-flavors).
{: tip}

Yes, you can provision your worker node as a single-tenant physical bare metal server. Bare metal servers come with high-performance benefits for workloads such as data, GPU, and AI. Additionally, all the hardware resources are dedicated to your workloads, so you don't have to worry about "noisy neighbors".

For more information about available bare metal flavors and how bare metal is different from virtual machines, see [Physical machines (bare metal)](/docs/containers?topic=containers-planning_worker_nodes#bm).

## What is the smallest size cluster that I can make?
{: #smallest_cluster}
{: faq}

Your cluster must have at least 1 worker node to run default Kubernetes components. You can't have a cluster with 0 worker nodes, and you can't power off or suspend billing for your worker nodes. Additionally, the type of cluster and the number of worker pools that you have can impact the size of your cluster.

* **Single zone clusters**: [Create a cluster](/docs/containers?topic=containers-clusters) with 1 worker node in the default worker pool.
* **Multizone clusters**: You must [create a cluster](/docs/containers?topic=containers-clusters) with 1 worker node per zone in the worker pool. Later, you can [remove zones](/docs/containers?topic=containers-kubernetes-service-cli#cs_zone_rm) from the worker pool or [remove individual worker nodes](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_rm) so that your cluster size reduces to the minimum size of 1.
* **Free clusters**: Free clusters have only 1 worker node.
* **Worker pools**: For any type of cluster, each worker pool must always have at least 1 worker node. For the smallest size cluster possible, you can have only 1 worker pool.

Keep in mind that some services such as Ingress might require multiple worker nodes for high availability, and you might not be able to run these services or your apps in the smallest size cluster possible.
{: important}



## Which Kubernetes versions does the service support?
{: #supported_kube_versions}
{: faq}
{: support}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a new version (n) is released, versions up to 2 behind (n-2) are supported. Versions more than 2 behind the latest (n-3) are first deprecated and then unsupported. 


For more information about supported versions and update actions that you must take to move from one version to another, see [Kubernetes version information](/docs/containers?topic=containers-cs_versions)

## Which worker node operating systems does the service support?
{: #supported_os_versions}
{: faq}
{: support}

For a list of supported worker node operated systems by cluster version, see [Kubernetes version information](/docs/containers?topic=containers-cs_versions).




## Where is the service available?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} is available worldwide. You can create standard clusters in every supported {{site.data.keyword.containerlong_notm}} region. Free clusters are available only in select regions.

For more information about supported regions, see [Locations](/docs/containers?topic=containers-regions-and-zones#regions-and-zones).

## Is the service highly available?
{: #ha_sla}
{: faq}

Yes. By default, {{site.data.keyword.containerlong_notm}} sets up many components such as the cluster master with replicas, anti-affinity, and other options to increase the high availability (HA) of the service. You can increase the redundancy and failure toleration of your cluster worker nodes, storage, networking, and workloads by configuring them in a highly available architecture. For an overview of the default setup and your options to increase HA, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha).

For the latest HA service level agreement terms, refer to the [{{site.data.keyword.cloud_notm}} terms of service](/docs/overview?topic=overview-slas). Generally, the SLA availability terms require that when you configure your infrastructure resources in an HA architecture, you must distribute them evenly across three different availability zones. For example, to receive full HA coverage under the SLA terms, you must [set up a multizone cluster](/docs/containers?topic=containers-ha_clusters#mz-clusters) with a total of at least 6 worker nodes, two worker nodes per zone that are evenly spread across three zones.

## What compliance standards does the service meet?
{: #standards}
{: faq}

{{site.data.keyword.cloud_notm}} is built by following many data, finance, health, insurance, privacy, security, technology, and other international compliance standards. For more information, see [{{site.data.keyword.cloud_notm}} compliance](/docs/overview?topic=overview-compliance).

To view detailed system requirements, you can run a [software product compatibility report for {{site.data.keyword.containerlong_notm}}](https://www.ibm.com/software/reports/compatibility/clarity/softwareReqsForProduct.html){: external}. Note that compliance depends on the underlying [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers) for the cluster worker nodes, networking, and storage resources.

**Classic infrastructure**: {{site.data.keyword.containerlong_notm}} implements controls commensurate with the following security standards:
- EU-US Privacy Shield and Swiss-US Privacy Shield Framework
- Health Insurance Portability and Accountability Act (HIPAA)
- Service Organization Control standards (SOC 1 Type 2, SOC 2 Type 2)
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization
- International Organization for Standardization (ISO 27001, ISO 27017, ISO 27018)
- Payment Card Industry Data Security Standard (PCI DSS)

**VPC infrastructure**: {{site.data.keyword.containerlong_notm}} implements controls commensurate with the following security standards:
- EU-US Privacy Shield and Swiss-US Privacy Shield Framework
- Health Insurance Portability and Accountability Act (HIPAA)
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization




## Can I use IBM Cloud and other services with my cluster?
{: #faq_integrations}
{: faq}

You can add {{site.data.keyword.cloud_notm}} platform and infrastructure services as well as services from third-party vendors to your {{site.data.keyword.containerlong_notm}} cluster to enable automation, improve security, or enhance your monitoring and logging capabilities in the cluster.

For a list of supported services, see [Integrating services](/docs/containers?topic=containers-supported_integrations#supported_integrations).


## Does IBM support third-party and open source tools that I use with my cluster?
{: #faq_thirdparty_oss}
{: faq}

See the [IBM Open Source and Third Party policy](https://www.ibm.com/support/pages/node/737271){: external}.

## What am I charged for? Can I estimate and control costs in my cluster?
{: #charges}
{: faq}

See [Managing costs for your clusters](/docs/containers?topic=containers-costs).


