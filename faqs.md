---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-07"


keywords: kubernetes, compliance, security standards, faq, kubernetes pricing, kubernetes service pricing, kubernetes charges, kubernetes service charges, kubernetes price, kubernetes service price,   kubernetes billing, kubernetes service billing, kubernetes costs, kubernetes service costs, 

subcollection: containers

content-type: faq

---

{{site.data.keyword.attribute-definition-list}}






# FAQ for {{site.data.keyword.containerlong}}
{: #faqs}


Review frequently asked questions (FAQ) for using {{site.data.keyword.containerlong}}.
{: shortdesc}



## What is Kubernetes?
{: #kubernetes}
{: faq}

Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers managements tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention. All containers that make up your microservice are grouped into pods, a logical unit to ensure easy management and discovery. These pods run on compute hosts that are managed in a Kubernetes cluster that is portable, extensible, and self-healing in case of failures.
{: shortdesc}

For more information about Kubernetes, see the [Kubernetes documentation](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational){: external}.

## How do I create an {{site.data.keyword.containerlong_notm}} cluster?
{: #faq-cluster-create}
{: faq}
{: support}

To create an {{site.data.keyword.containerlong_notm}} cluster, first decide if you to want follow a tutorial for a basic cluster setup or design your own cluster environment.

I want to follow a tutorial
:   Begin by reviewing the [Getting started](/docs/containers?topic=containers-getting-started) doc, then [choose one of the available tutorials](/docs/containers?topic=containers-getting-started#getting-started-create).

I want to design my own cluster environment
:   Begin by reviewing the [Getting started](/docs/containers?topic=containers-getting-started)  doc, then [create your cluster environment strategy](/docs/containers?topic=containers-getting-started#getting-started-strategy).


## How does {{site.data.keyword.containerlong_notm}} work?
{: #kubernetes_service}
{: faq}
{: support}

With {{site.data.keyword.containerlong_notm}}, you can create your own Kubernetes cluster to deploy and manage containerized apps on {{site.data.keyword.cloud_notm}}. Your containerized apps are hosted on IBM Cloud infrastructure compute hosts that are called worker nodes. You can choose to provision your compute hosts as virtual machines with shared or dedicated resources, or as bare metal machines that can be optimized for GPU and software-defined storage (SDS) usage. Your worker nodes are controlled by a highly available Kubernetes master that is configured, monitored, and managed by IBM. You can use the {{site.data.keyword.containerlong_notm}} API or CLI to work with your cluster infrastructure resources and the Kubernetes API or CLI to manage your deployments and services.

For more information about how your cluster resources are set up, see the [Service architecture](/docs/containers?topic=containers-service-arch). To find a list of capabilities and benefits, see [Benefits and service offerings](/docs/containers?topic=containers-overview).

## Why should I use {{site.data.keyword.containerlong_notm}}?
{: #faq_benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} is a managed Kubernetes offering that delivers powerful tools, an intuitive user experience, and built-in security for rapid delivery of apps that you can bind to cloud services that are related to {{site.data.keyword.ibmwatson}}, AI, IoT, DevOps, security, and data analytics. As a certified Kubernetes provider, {{site.data.keyword.containerlong_notm}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management. The service also has advanced capabilities around simplified cluster management, container security and isolation policies, the ability to design your own cluster, and integrated operational tools for consistency in deployment.

For a detailed overview of capabilities and benefits, see [Benefits of using the service](/docs/containers?topic=containers-overview#benefits).


## What container platforms are available for my cluster?
{: #container_platforms}
{: faq}
{: support}

With {{site.data.keyword.cloud_notm}}, you can create clusters for your containerized workloads from two different container management platforms: the IBM version of community Kubernetes and {{site.data.keyword.openshiftlong_notm}}. The container platform that you select is installed on your cluster master and worker nodes. Later, you can [update the version](/docs/containers?topic=containers-update#update) but can't roll back to a previous version or switch to a different container platform. If you want to use multiple container platforms, create a separate cluster for each.

For more information, see [Comparison between {{site.data.keyword.redhat_openshift_notm}} and community Kubernetes clusters](/docs/containers?topic=containers-overview#openshift_kubernetes).

Kubernetes
:   [Kubernetes](https://kubernetes.io/){: external} is a production-grade, open source container orchestration platform that you can use to automate, scale, and manage your containerized apps that run on an Ubuntu operating system. With the [{{site.data.keyword.containerlong_notm}} version](/docs/containers?topic=containers-cs_versions#cs_versions), you get access to community Kubernetes API features that are considered **beta** or higher by the community. Kubernetes **alpha** features, which are subject to change, are generally not enabled by default. With Kubernetes, you can combine various resources such as secrets, deployments, and services to securely create and manage highly available, containerized apps.

{{site.data.keyword.redhat_openshift_notm}}
:   {{site.data.keyword.openshiftlong_notm}} is a Kubernetes-based platform that is designed especially to accelerate your containerized app delivery processes that run on a Red Hat Enterprise Linux operating system. You can orchestrate and scale your existing {{site.data.keyword.redhat_openshift_notm}} workloads across on-prem and off-prem clouds for a portable, hybrid solution that works the same in multicloud scenarios. To get started, try out the [{{site.data.keyword.openshiftlong_notm}} tutorial](/docs/openshift?topic=openshift-openshift_tutorial).

## Does the service come with a managed Kubernetes master and worker nodes?
{: #managed_master_worker}
{: faq}

Every cluster in {{site.data.keyword.containerlong_notm}} is controlled by a dedicated Kubernetes master that is managed by IBM in an IBM-owned {{site.data.keyword.cloud_notm}} infrastructure account. The Kubernetes master, including all the master components, compute, networking, and storage resources, is continuously monitored by IBM Site Reliability Engineers (SREs). The SREs apply the latest security standards, detect and remediate malicious activities, and work to ensure reliability and availability of {{site.data.keyword.containerlong_notm}}. Add-ons, such as Fluentd for logging, that are installed automatically when you provision the cluster are automatically updated by IBM. However, you can choose to disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. For more information, see [Updating cluster add-ons](/docs/containers?topic=containers-update#addons-update).

Periodically, Kubernetes releases [major, minor, or patch updates](/docs/containers?topic=containers-cs_versions#update_types). These updates can affect the Kubernetes API server version or other components in your Kubernetes master. IBM automatically updates the patch version, but you must update the master major and minor versions. For more information, see [Updating the master](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons).

Worker nodes in standard clusters are provisioned in to your {{site.data.keyword.cloud_notm}} infrastructure account. The worker nodes are dedicated to your account and you are responsible to request timely updates to the worker nodes to ensure that the worker node OS and {{site.data.keyword.containerlong_notm}} components apply the latest security updates and patches. Security updates and patches are made available by IBM Site Reliability Engineers (SREs) who continuously monitor the Linux image that is installed on your worker nodes to detect vulnerabilities and security compliance issues. For more information, see [Updating worker nodes](/docs/containers?topic=containers-update#worker_node).




## What kinds of workloads can I move to {{site.data.keyword.containerlong_notm}}?
{: #move_to_cloud}

The following table provides some examples of what types of workloads that users typically move to the various types of clouds. You might also choose a hybrid approach where you have clusters that run in both environments.
{: shortdesc}

| Workload | {{site.data.keyword.containershort_notm}} off-prem | on-prem |
| --- | --- | --- |
| DevOps enablement tools | Yes | |
| Developing and testing apps | Yes | |
| Apps have major shifts in demand and need to scale rapidly | Yes | |
| Business apps such as CRM, HCM, ERP, and E-commerce | Yes | |
| Collaboration and social tools such as email | Yes | |
| Linux and x86 workloads | Yes | |
| Bare metal | Yes | Yes |
| GPU compute resources | Yes | Yes |
| PCI and HIPAA-compliant workloads | Yes | Yes |
| Legacy apps with platform and infrastructure constraints and dependencies | | Yes |
| Proprietary apps with strict designs, licensing, or heavy regulations | | Yes |
{: caption="{{site.data.keyword.cloud_notm}} implementations support your workloads" caption-side="bottom"}

Ready to run workloads off-premises in {{site.data.keyword.containerlong_notm}}?
:   Great! You're already in the public cloud documentation. Keep reading for more strategy ideas, or hit the ground running by [creating a cluster now](/docs/containers?topic=containers-getting-started).

Want to run workloads in both on-premises and off-premises clouds?
:   Explore [{{site.data.keyword.satellitelong_notm}}](/docs/satellite?topic=satellite-faqs) to extend the flexibility and scalability of {{site.data.keyword.cloud_notm}} into your on-premises, edge, or other cloud provider environments.

## Can I automate my infrastructure deployments?
{: #infra_packaging}

If you want to run your app in multiple clusters, public and private environments, or even multiple cloud providers, you might wonder how you can make your deployment strategy work across these environments.

You can use the open source [Terraform](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-getting-started#getting-started) tool to automate the provisioning of {{site.data.keyword.cloud_notm}} infrastructure, including Kubernetes clusters. Follow along with this tutorial to [create single and multizone Kubernetes and OpenShift clusters](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-tutorial-tf-clusters). After you create a cluster, you can also set up the [{{site.data.keyword.containerlong_notm}} cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-install-addon) so that your worker pool scales up and down worker nodes in response to your workload's resource requests.

## What kind of apps can I run? Can I move existing apps, or do I need to develop new apps?
{: #app_kinds_dev}

Your containerized app must be able to run on one of the [supported operating systems](/docs/containers?topic=containers-cs_versions) for your cluster version. You also want to consider the statefulness of your app. For more information about the kinds of apps that can run in {{site.data.keyword.containerlong_notm}}, see [Planning app deployments](/docs/containers?topic=containers-plan_deploy#app_types).

If you already have an app, you can [migrate it to {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-plan_deploy#migrate_containerize). If you want to develop a new app, check out the [guidelines for developing stateless, cloud-native apps](/docs/containers?topic=containers-plan_deploy#12factor).

## What about serverless apps?
{: #apps_serverless-strategy}

You can run serverless apps and jobs through the [{{site.data.keyword.codeenginefull_notm}}](/docs/codeengine?topic=codeengine-getting-started) service. {{site.data.keyword.codeengineshort}} can also build your images for you. {{site.data.keyword.codeengineshort}} is designed so that you don't need to interact with the underlying technology it is built upon. However, if you have existing tooling that is based upon Kubernetes or Knative, you can still use it with {{site.data.keyword.codeengineshort}}. For more information, see [Using Kubernetes to interact with your application](/docs/codeengine?topic=codeengine-kubernetes). 
{: shortdesc}

## What skills should I have before I move my apps to a cluster?
{: #knowledge_skills}

Kubernetes is designed to provide capabilities to two main personas, the cluster admin and the app developer. Each persona uses different technical skills to successfully run and deploy apps to a cluster.
{: shortdesc}

What are a cluster admin's main tasks and technical knowledge?
:   As a cluster admin, you are responsible to set up, operate, secure, and manage the {{site.data.keyword.cloud_notm}} infrastructure of your cluster. Typical tasks include:
    - Size the cluster to provide enough capacity for your workloads.
    - Design a cluster to meet the high availability, disaster recovery, and compliance standards of your company.
    - Secure the cluster by setting up user permissions and limiting actions within the cluster to protect your compute resources, your network, and data.
    - Plan and manage network communication between infrastructure components to ensure network security, segmentation, and compliance.
    - Plan persistent storage options to meet data residency and data protection requirements.

The cluster admin persona must have a broad knowledge that includes compute, network, storage, security, and compliance. In a typical company, this knowledge is spread across multiple specialists, such as System Engineers, System Administrators, Network Engineers, Network Architects, IT Managers, or Security and Compliance Specialists. Consider assigning the cluster admin role to multiple people in your company so that you have the required knowledge to successfully operate your cluster.

What are an app developer's main tasks and technical skills?
:   As a developer, you design, create, secure, deploy, test, run, and monitor cloud-native, containerized apps in an Kubernetes cluster. To create and run these apps, you must be familiar with the concept of microservices, the [12-factor app](/docs/containers?topic=containers-plan_deploy#12factor) guidelines, [Docker and containerization principles](https://www.docker.com/){: external}, and available [Kubernetes deployment options](/docs/containers?topic=containers-plan_deploy).

Kubernetes and {{site.data.keyword.containerlong_notm}} provide multiple options for how to [expose an app and keep an app private](/docs/containers?topic=containers-cs_network_planning), [add persistent storage](/docs/containers?topic=containers-storage-plan), [integrate other services](/docs/containers?topic=containers-ibm-3rd-party-integrations), and how you can [secure your workloads and protect sensitive data](/docs/containers?topic=containers-security#container). Before you move your app to a cluster in {{site.data.keyword.containerlong_notm}}, verify that you can run your app as a containerized app on the supported operating system and that Kubernetes and {{site.data.keyword.containerlong_notm}} provide the capabilities that your workload needs.

Do cluster administrators and developers interact with each other?
:   Yes. Cluster administrators and developers must interact frequently so that cluster administrators understand workload requirements to provide this capability in the cluster, and so that developers know about available limitations, integrations, and security principles that they must consider in their app development process.



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

{{site.data.keyword.containerlong_notm}} uses {{site.data.keyword.iamshort}} (IAM) to grant access to cluster resources through IAM platform access roles and Kubernetes role-based access control (RBAC) policies through IAM service access roles. For more information about types of access policies, see [Pick the correct access policy and role for your users](/docs/containers?topic=containers-iam-platform-access-roles).


### What permissions does the user who sets the API key need? How do I give the user these permissions?
{: #what-perms-api-key}

At a minimum, the **Administrators** or **Compliance Management** roles have permissions to create a cluster. However, you might need additional permissions for other services and integrations that you use in your cluster. For more information, see [Permissions to create a cluster](/docs/containers?topic=containers-iam-platform-access-roles).

To check a user's permissions, review the access policies and access groups of the user in the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/iam/users){: external}, or use the `ibmcloud iam user-policies <user>` command.

If the API key is based on one user, how are other cluster users in the region and resource group affected?
{: #apikey-users}

Other users within the region and resource group of the account share the API key for accessing the infrastructure and other services with {{site.data.keyword.containerlong_notm}} clusters. When users log in to the {{site.data.keyword.cloud_notm}} account, an {{site.data.keyword.cloud_notm}} IAM token that is based on the API key is generated for the CLI session and enables infrastructure-related commands to be run in a cluster.



### What happens if the user who set up the API key for a region and resource group leaves the company?
{: #apikey-user-leaves}

If the user is leaving your organization, the {{site.data.keyword.cloud_notm}} account owner can remove that user's permissions. However, before you remove a user's specific access permissions or remove a user from your account completely, you must reset the API key with another user's infrastructure credentials. Otherwise, the other users in the account might lose access to the IBM Cloud infrastructure portal and infrastructure-related commands might fail. For more information, see [Removing user permissions](/docs/containers?topic=containers-removing-user-permissions).



### How can I lock down my cluster if my API key becomes compromised?
{: #apikey-lockdown}

If an API key that is set for a region and resource group in your cluster is compromised, [delete it](/docs/account?topic=account-userapikey&interface=ui#delete_user_key) so that no further calls can be made by using the API key as authentication. For more information about securing access to the Kubernetes API server, see the [Kubernetes API server and etcd](/docs/containers?topic=containers-security#apiserver) security topic.

## How do I rotate the cluster API key if there is a leak?
{: #faq_api_key_leak}
{: faq}
{: support}

For instructions on how to rotate your API key, see [How do I rotate the cluster API key if there is a leak?](/docs/containers?topic=containers-ts-troubleshoot-api-key-leak).


## Where can I find a list of security bulletins that affect my cluster?
{: #faq_security_bulletins}
{: faq}
{: support}

If vulnerabilities are found in Kubernetes, Kubernetes releases CVEs in security bulletins to inform users and to describe the actions that users must take to remediate the vulnerability. Kubernetes security bulletins that affect {{site.data.keyword.containerlong_notm}} users or the {{site.data.keyword.cloud_notm}} platform are published in the [{{site.data.keyword.cloud_notm}} security bulletin](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security).

Some CVEs require the latest patch update for a version that you can install as part of the regular [cluster update process](/docs/containers?topic=containers-update#update) in {{site.data.keyword.containerlong_notm}}. Make sure to apply security patches in time to protect your cluster from malicious attacks. For more information about what is included in a security patch, refer to the [version change log](/docs/containers?topic=containers-cs_versions#cs_versions_available).

## Does the service offer support for bare metal and GPU?
{: #bare_metal_gpu}
{: faq}

Certain VPC worker node flavors offer GPU support. For more information, see the [VPC flavors](/docs/containers?topic=containers-vpc-flavors).
{: tip}

Yes, you can provision your worker node as a single-tenant physical bare metal server. Bare metal servers come with high-performance benefits for workloads such as data, GPU, and AI. Additionally, all the hardware resources are dedicated to your workloads, so you don't have to worry about "noisy neighbors".

For more information about available bare metal flavors and how bare metal is different from virtual machines, see the [planning guidance](/docs/containers?topic=containers-strategy#env_flavors_node).

## What is the smallest size cluster that I can make?
{: #smallest_cluster}
{: faq}

Note that running the smallest possible cluster does not meet the service level agreement (SLA) to receive support. Also, keep in mind that some services, such as Ingress, require highly available worker node setups. You might not be able to run these services or your apps in clusters with only two nodes in a worker pool. For more information, see the [Planning your cluster for high availability](/docs/containers?topic=containers-strategy).
{: important}

Classic or VPC clusters
:   Clusters must always have at least 1 worker node. Note that you can't have a cluster with 0 worker nodes, and you can't power off or suspend billing for your worker nodes.

{{site.data.keyword.satelliteshort}} clusters
:   Clusters can be created using the single-replica topology, which means only 1 worker node. Note that if you create a {{site.data.keyword.satelliteshort}} cluster using single-replica topology, you can't add worker nodes later.


## Which versions does the service support?
{: #supported_kube_versions}
{: faq}
{: support}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a new version (n) is released, versions up to 2 behind (n-2) are supported. Versions more than 2 behind the latest (n-3) are first deprecated and then unsupported. 


For more information about supported versions and update actions that you must take to move from one version to another, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions).

## Which worker node operating systems does the service support?
{: #supported_os_versions}
{: faq}
{: support}

For a list of supported worker node operated systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions).




## Where is the service available?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} is available worldwide. You can create clusters in every supported {{site.data.keyword.containerlong_notm}} region.

For more information about supported regions, see [Locations](/docs/containers?topic=containers-regions-and-zones#regions-and-zones).

## Is the service highly available?
{: #ha_sla}
{: faq}

Yes. By default, {{site.data.keyword.containerlong_notm}} sets up many components such as the cluster master with replicas, anti-affinity, and other options to increase the high availability (HA) of the service. You can increase the redundancy and failure toleration of your cluster worker nodes, storage, networking, and workloads by configuring them in a highly available architecture. For an overview of the default setup and your options to increase HA, see [Creating a highly available cluster strategy](/docs/containers?topic=containers-strategy).

For the latest HA service level agreement terms, refer to the [{{site.data.keyword.cloud_notm}} terms of service](/docs/overview?topic=overview-slas). Generally, the SLA availability terms require that when you configure your infrastructure resources in an HA architecture, you must distribute them evenly across three different availability zones. For example, to receive full HA coverage under the SLA terms, you must set up a multizone cluster with a total of at least 6 worker nodes, two worker nodes per zone that are evenly spread across three zones.



## How do multizone clusters work?
{: #mz-cluster-faq}

### How is my {{site.data.keyword.containerlong_notm}} master set up?
{: #mz-master-setup}

When you create a cluster in a multizone location, a highly available master is automatically deployed and three replicas are spread across the zones of the metro. For example, if the cluster is in `dal10`, `dal12`, or `dal13` zones, the replicas of the master are spread across each zone in the Dallas multizone metro.

### Do I have to do anything so that the master can communicate with the workers across zones?
{: #mz-master-communication}

If you created a VPC multizone cluster, the subnets in each zone are automatically set up with Access Control Lists (ACLs) that allow communication between the master and the worker nodes across zones. In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint&interface=ui) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** infrastructure permission, or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).

### Can I convert my single zone cluster to a multizone cluster?
{: #convert-sz-to-mz}

To convert a single zone cluster to a multizone cluster, your cluster must be set up in a location that has more than one availability zone.
- VPC clusters can be set up only in multizone regions, and as such can always be converted from a single zone cluster to a multizone cluster. For more information, see [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc).
- Classic clusters that are set up in data centers with only one zone can't be converted to a multizone cluster. For more information, see [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic).

## What if I want to set up multiple clusters across regions?
{: #multiple-regions-setup}

You can set up multiple clusters in different regions of one geolocation (such as US South and US East) or across geolocations (such as US South and EU Central). Both setups offer the same level of availability for your app, but also add complexity when it comes to data sharing and data replication. For most cases, staying within the same geolocation is sufficient. But if you have users across the world, it might be better to set up a cluster where your users are so that your users don't experience long waiting times when they send a request to your app.

## What options do I have to load balance workloads across multiple clusters?
{: #multiple-cluster-lb-options}

To load balance workloads across multiple clusters, you must make your apps available on the public network by using [Application Load Balancers (ALBs)](/docs/containers?topic=containers-managed-ingress-about#managed-ingress-albs) or [Network Load Balancers (NLBs)](/docs/containers?topic=containers-loadbalancer-about). The ALBs and NLBs are assigned a public IP address that you can use to access your apps.

To load balance workloads across your apps, add the public IP addresses of your ALBs and NLBs to a CIS global load balancer or your own global load balancer.

## What if I want to load balance workloads on the private network?
{: #glb-private}

{{site.data.keyword.cloud_notm}} does not offer a global load balancer service on the private network. However, you can connect your cluster to a private load balancer that you host in your on-prem network by using one of the [supported VPN options](/docs/containers?topic=containers-vpn). Make sure to expose your apps on the private network by using [Application Load Balancers (ALBs)](/docs/containers?topic=containers-managed-ingress-about#managed-ingress-albs) or [Network Load Balancers (NLBs)](/docs/containers?topic=containers-loadbalancer-about), and use the private IP address in your VPN settings to connect your app to your on-prem network.

## Are the master and worker nodes highly available?
{: #faq_ha}
{: faq}

The {{site.data.keyword.containerlong_notm}} architecture and infrastructure is designed to ensure reliability, low processing latency, and a maximum uptime of the service. By default, every cluster in {{site.data.keyword.containerlong_notm}} is set up with multiple Kubernetes master instances to ensure availability and accessibility of your cluster resources, even if one or more instances of your Kubernetes master are unavailable.

You can make your cluster even more highly available and protect your app from a downtime by spreading your workloads across multiple worker nodes in multiple zones of a region. This setup is called a multizone cluster and ensures that your app is accessible, even if a worker node or an entire zone is not available.

To protect against an entire region failure, create multiple clusters and spread them across {{site.data.keyword.cloud_notm}} regions. By setting up a network load balancer (NLB) for your clusters, you can achieve cross-region load balancing and cross-region networking for your clusters.

If you have data that must be available, even if an outage occurs, make sure to store your data on [persistent storage](/docs/containers?topic=containers-storage-plan).

For more information about how to achieve high availability for your cluster, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-strategy).

## Do my apps automatically spread across zones?
{: #multizone-apps-faq}

It depends on how you set up the app. See [Planning highly available deployments](/docs/containers?topic=containers-plan_deploy#highly_available_apps) and [Planning highly available persistent storage](/docs/containers?topic=containers-storage-plan).

## Are the worker nodes encrypted?
{: #encrypted-flavors}

The secondary disk of the worker node is encrypted. For more information, see [Overview of cluster encryption](/docs/containers?topic=containers-encryption). After you create a worker pool, you might notice that the worker node flavor has `.encrypted` in the name, such as `b3c.4x16.encrypted`.

## What compliance standards does the service meet?
{: #standards}
{: faq}

{{site.data.keyword.cloud_notm}} is built by following many data, finance, health, insurance, privacy, security, technology, and other international compliance standards. For more information, see [{{site.data.keyword.cloud_notm}} compliance](/docs/overview?topic=overview-compliance).

To view detailed system requirements, you can run a [software product compatibility report for {{site.data.keyword.containerlong_notm}}](https://www.ibm.com/software/reports/compatibility/clarity/index.html){: external}. Note that compliance depends on the underlying [infrastructure provider](/docs/containers?topic=containers-overview#what-compute-infra-is-offered) for the cluster worker nodes, networking, and storage resources.

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




## Can I use other IBM Cloud services with my cluster?
{: #faq_integrations}
{: faq}

You can add {{site.data.keyword.cloud_notm}} platform and infrastructure services as well as services from third-party vendors to your {{site.data.keyword.containerlong_notm}} cluster to enable automation, improve security, or enhance your monitoring and logging capabilities in the cluster.

For a list of supported services, see [Integrating services](/docs/containers?topic=containers-supported_integrations#supported_integrations).


## How do I install a Cloud Pak in my cluster?
{: #cloud_pak_manage}

Cloud Paks are integrated with the {{site.data.keyword.cloud_notm}} catalog so that you can quickly configure and install the all the Cloud Pak components into an existing or new {{site.data.keyword.redhat_openshift_notm}} cluster. When you install the Cloud Pak, the Cloud Pak is provisioned with {{site.data.keyword.bpshort}} and a {{site.data.keyword.bpshort}} workspace is created for you. You can use the workspace later to access information about your Cloud Pak installation. You access your Cloud Pak services from the Cloud Pak URL. For more information, consult the [Cloud Pak documentation](https://www.ibm.com/products/cloud-paks){: external}.

## Can I use the {{site.data.keyword.redhat_openshift_notm}} entitlement that comes with my Cloud Pak for my cluster?
{: #cloud_pak_byo_entitlement}

Yes, if your Cloud Pak includes an entitlement to run certain worker node flavors that are installed with OpenShift Container Platform. To view your entitlements, check in [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/index.html){: external}. Note that your {{site.data.keyword.cloud_notm}} ID must match your IBM Passport Advantage ID.

You can create the cluster or the worker pool within an existing cluster with the Cloud Pak entitlement in the console or by using the `--entitlement ocp_entitled` option in the [`ibmcloud ks cluster create classic`](/docs/openshift?topic=openshift-kubernetes-service-cli#cs_cluster_create) or [`ibmcloud ks worker-pool create classic`](/docs/openshift?topic=openshift-kubernetes-service-cli#cs_worker_pool_create) CLI commands. Make sure to specify the correct number and flavor of worker nodes that you are entitled to use.

Do not exceed your entitlement. Keep in mind that your OpenShift Container Platform entitlements can be used with other cloud providers or in other environments. To avoid billing issues later, make sure that you use only what you are entitled to use. For example, you might have an entitlement for the OCP licenses for two worker nodes of 4 CPU and 16 GB memory, and you create this worker pool with two worker nodes of 4 CPU and 16 GB memory. You used your entire entitlement, and you can't use the same entitlement for other worker pools, cloud providers, or environments.
{: important}




## Can I install multiple Cloud Paks in the same {{site.data.keyword.openshiftlong_notm}} cluster?
{: #cloud_pak_multiple}

Yes, but you might need to add more worker nodes so that each Cloud Pak has enough compute resources to run. Additionally, you might install only one instance of the same Cloud Pak per cluster, such as Cloud Pak for Data; or multiple instances to different projects in the same cluster, such as Cloud Pak for Automation. For sizing information, consult the [Cloud Pak documentation](https://www.ibm.com/products/cloud-paks){: external}.




## What is included in a Cloud Pak?
{: #cloud_pak_included}

Cloud Paks are bundled, licensed, containerized software that is optimized to work together for enterprise use cases, including consistent deployment, access control, and billing. You can flexibly use parts of the Cloud Paks when you need them by choosing the correct mix of virtual processor cores of the software to suit your workloads. You can also change the mix of virtual processor cores as your workloads evolve.


Depending on the Cloud Pak, you get licensed IBM and open source software bundled together in a unified management experience with logging, monitoring, security, and access capabilities.
* **IBM products**: Cloud Paks extend licensed IBM software and middleware from [IBM Marketplace](https://www.ibm.com/products){: external}, and integrate these products with your cluster to modernize, optimize, and run hybrid cloud workloads.
* **Open-source software**: Cloud Paks might also include open source components for cloud-native and portable hybrid cloud solutions. Typically, open source software is unmanaged and you are responsible to keep your components up-to-date and secure. However, Cloud Paks help you consistently manage the entire lifecycle of the Cloud Pak components and the workloads that you run with them. Because the open source software is bundled together with the Cloud Pak, you get the benefits of IBM support and integration with select {{site.data.keyword.cloud_notm}} features such as access control and billing.

To see the components of each Cloud Pak, consult the [Cloud Pak documentation](https://www.ibm.com/products/cloud-paks){: external}.

## What else do I need to know to use Cloud Paks?
{: #cloud_paks_other}

When you set up your Cloud Pak, you might need to work with {{site.data.keyword.redhat_openshift_notm}}-specific resources, such as security context constraints. Make sure that you use the [`oc` CLI or `kubectl` version 1.12 CLI](/docs/containers?topic=containers-cli-install) to interact with these resources, such as `oc get scc`. The `kubectl` CLI version 1.11 has a bug that yields an error when you run commands against {{site.data.keyword.redhat_openshift_notm}}-specific resources, such as `kubectl get scc`.


## Does IBM support third-party and open source tools that I use with my cluster?
{: #faq_thirdparty_oss}
{: faq}

See the [IBM Open Source and Third Party policy](https://www.ibm.com/support/pages/node/737271){: external}.

## What am I charged for? Can I estimate and control costs in my cluster?
{: #charges}
{: faq}

See [Managing costs for your clusters](/docs/containers?topic=containers-costs).

## Can I downgrade my cluster to a previous version?
{: #downgrade}
{: faq}

No, you cannot downgrade your cluster to a previous version.


## Can I move my current cluster to a different account?
{: #migrate-cluster-account}
{: faq}

No, you cannot move cluster to a different account from the one it was created in.

## How can I keep my cluster in a supported state?
{: #updating_kube}

- Make sure that your cluster always runs a [supported Kubernetes version](/docs/containers?topic=containers-cs_versions).
- When a new Kubernetes minor version is released, an older version is shortly deprecated after and then becomes unsupported.

For more information, see [Updating the master](/docs/containers?topic=containers-update#master) and [worker nodes](/docs/containers?topic=containers-update#worker_node).

## What operations are blocked if my cluster is running an unsupported operating system?
{: #unsupported_os}

The following operations are blocked when an operating system is unsupported:

- worker reload
- worker replace without update
- worker replace with update
- worker update
- worker pool create (with an unsupported OS)
- worker pool rebalance
- worker pool resize (scale up)
- worker pool zone add
- instance group resize (patch)
- autoscaler remove worker (v2/autoscalerRemoveWorker)
