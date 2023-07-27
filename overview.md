---

copyright: 
  years: 2014, 2023
lastupdated: "2023-07-27"

keywords: containers, kubernetes, infrastructure, rbac, policy, providers, benefits

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Understanding {{site.data.keyword.containerlong_notm}}
{: #overview}

Learn more about [{{site.data.keyword.containerlong}}](https://www.ibm.com/cloud/kubernetes-service){: external}, its capabilities, and the options that are available to you to customize the cluster to your needs.
{: shortdesc}


Review frequently asked questions and key technologies that {{site.data.keyword.containerlong_notm}} uses.


## What is {{site.data.keyword.containerlong_notm}} and how does it work?
{: #what-is-overview}

{{site.data.keyword.containerlong_notm}} is a managed offering to create your own Kubernetes cluster of compute hosts to deploy and manage containerized apps on {{site.data.keyword.cloud_notm}}. As a certified Kubernetes provider, {{site.data.keyword.containerlong_notm}} provides intelligent scheduling, self-healing, horizontal scaling, service discovery and load balancing, automated rollouts and rollbacks, and secret and configuration management for your apps. Combined with an intuitive user experience, built-in security and isolation, and advanced tools to secure, manage, and monitor your cluster workloads, you can rapidly deliver highly available and secure containerized apps in the public cloud.

## What is Kubernetes?
{: #what-is-kube-overview}

Kubernetes is an open source platform for managing containerized workloads and services across multiple hosts, and offers management tools for deploying, automating, monitoring, and scaling containerized apps with minimal to no manual intervention.

![Kubernetes certification badge](images/certified-kubernetes-color.svg "Deployment setup"){: caption="Figure 1. This badge indicates Kubernetes certification for IBM Cloud Container Service." caption-side="bottom"}

The open source project, Kubernetes, combines running a containerized infrastructure with production workloads, open source contributions, and Docker container management tools. The Kubernetes infrastructure provides an isolated and secure app platform for managing containers that is portable, extensible, and self-healing in case of a failover. For more information, see [What is Kubernetes?](https://www.ibm.com/topics/kubernetes){: external}.

Learn more about the key concepts of Kubernetes as illustrated in the following image.


![Example deployment and namespaces](images/k8-namespace.svg "Deployment setup"){: caption="Figure 2. A description of key concepts for Kubernetes" caption-side="bottom"}


Account
:   Your account refers to your {{site.data.keyword.cloud_notm}} account.

Cluster, worker pool, and worker node
:   A Kubernetes cluster consists of a master and one or more compute hosts that are called worker nodes. Worker nodes are organized into worker pools of the same flavor, or profile of CPU, memory, operating system, attached disks, and other properties. The worker nodes correspond to the Kubernetes `Node` resource, and are managed by a Kubernetes master that centrally controls and monitors all Kubernetes resources in the cluster. So when you deploy the resources for a containerized app, the Kubernetes master decides which worker node to deploy those resources on, accounting for the deployment requirements and available capacity in the cluster. Kubernetes resources include services, deployments, and pods. For more information, see [Service architecture](/docs/containers?topic=containers-service-arch).

Namespace
:   Kubernetes namespaces are a way to divide your cluster resources into separate areas that you can deploy apps and restrict access to, such as if you want to share the cluster with multiple teams. For example, system resources that are configured for you are kept in separate namespaces like `kube-system` or `ibm-system`. If you don't designate a namespace when you create a Kubernetes resource, the resource is automatically created in the `default` namespace. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){: external}.

Service
:   A service is a Kubernetes resource that groups a set of pods and provides network connectivity to these pods without exposing the actual private IP address of each pod. You can use a service to make your app available within your cluster or to the public internet. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/service/){: external}.

Deployment
:   A deployment is a Kubernetes resource where you might specify information about other resources or capabilities that are required to run your app, such as services, persistent storage, or annotations. You document a deployment in a configuration YAML file, and then apply it to the cluster. The Kubernetes master configures the resources and deploys containers into pods on the worker nodes with available capacity.

:   Define update strategies for your app, including the number of pods that you want to add during a rolling update and the number of pods that can be unavailable at a time. When you perform a rolling update, the deployment checks whether the update is working and stops the rollout when failures are detected.

:   A deployment is just one type of workload controller that you can use to manage pods. For help choosing among your options, see [What type of Kubernetes objects can I make for my app?](/docs/containers?topic=containers-plan_deploy#object). For more information about deployments, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/){: external}.
  
Pod
:   Every containerized app that is deployed into a cluster is deployed, run, and managed by a Kubernetes resource called a pod. Pods represent small deployable units in a Kubernetes cluster and are used to group the containers that must be treated as a single unit. Usually, each container is deployed in its own pod. However, an app might require a container and other helper containers to be deployed into one pod so that those containers can be addressed by using the same private IP address. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/workloads/pods/){: external}.

App
:   An app might refer to a complete app or a component of an app. You might deploy components of an app in separate pods or separate worker nodes. For more information, see [Planning app deployments](/docs/containers?topic=containers-plan_deploy) and [Developing Kubernetes-native apps](/docs/containers?topic=containers-app).

To dive deeper into Kubernetes, see the [Kubernetes documentation](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational){: external}.

## What are containers?
{: #what-are-containers-overview}

Containers provide a standard way to package your application's code, configurations, and dependencies into a single unit that can run as a resource-isolated process on a compute server. To run your app in Kubernetes on {{site.data.keyword.containerlong_notm}}, you must first containerize your app by creating a container image that you store in a container registry.

## What compute host infrastructure does the service offer?
{: #what-compute-infra-is-offered}


With {{site.data.keyword.containerlong}}, you can create a cluster by using infrastructure from the following providers. All the worker nodes in a cluster must be from the same provider.

[{{site.data.keyword.vpc_full}}]{: tag-vpc}
:   Create clusters on virtual servers in your own Virtual Private Cloud (VPC).




[Classic infrastructure]{: tag-classic-inf} 
:   Create clusters in a classic compute, networking, and storage environment in IBM Cloud infrastructure.


| Component | Description | 
| --- | --- | 
| Compute and worker node resources | Worker nodes are created as virtual machines by using either shared infrastructure or dedicated hosts. Unlike classic clusters, VPC cluster worker nodes on shared hardware don't appear in your infrastructure portal or a separate infrastructure bill. Instead, you manage all maintenance and billing activity for the worker nodes through {{site.data.keyword.containerlong_notm}}. Your worker node instances are connected to certain VPC instances that do reside in your infrastructure account, such as the VPC subnet or storage volumes. For dedicated hosts, the dedicated host price covers the vCPU, memory, and any instance storage to be used by any workers placed on the host. For dedicated hosts, the dedicated host price covers the vCPU, memory, and any [instance storage](/docs/vpc?topic=vpc-instance-storage) to be used by any workers placed on the host. Note that all Intel® x86-64 servers have Hyper-Threading enabled by default. For more information, see [Intel Hyper-Threading Technology](/docs/vpc?topic=vpc-profiles#vpc-intel-hyper-threading). |
| Security | Clusters on shared hardware run in an isolated environment in the public cloud. Clusters on dedicated hosts do not run in a shared environment, instead only your clusters are present on your hosts. Network access control lists protect the subnets that provide the floating IPs for your worker nodes. For more information, see the [VPC documentation](/docs/vpc?topic=vpc-about-vpc).|
| High availability | The master includes three replicas for high availability. Further, if you create your cluster in a multizone metro, the master replicas are spread across zones and you can also spread your worker pools across zones. For more information, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha). |
| Reservations | Reservations aren't available for VPC. |
| Cluster administration | VPC clusters can't be reloaded or updated. Instead, use the [`worker replace --update` CLI](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_replace) or [API operation](https://containers.cloud.ibm.com/global/swagger-global-api/#/beta/replaceWorker){: external} to replace worker nodes that are outdated or in a troubled state. |
| Cluster networking | Unlike classic infrastructure, the worker nodes of your VPC cluster are attached to VPC subnets and assigned private IP addresses. The worker nodes are not connected to the public network, which instead is accessed through a public gateway, floating IP, or VPN gateway. For more information, see [Overview of VPC networking in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-vpc-subnets#vpc_basics).|
| Apps and container platform | You can choose to create [community Kubernetes or {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/containers?topic=containers-faqs#container_platforms) to manage your containerized apps. Your app build processes don't differ because of the infrastructure provider, but how you expose the app does. For more information, see [Choosing an app exposure service](/docs/containers?topic=containers-cs_network_planning). |
| App networking | All pods that are deployed to a worker node are assigned a private IP address in the 172.30.0.0/16 range and are routed between worker nodes on the worker node private IP address of the private VPC subnet. To expose the app on the public network, you can create a Kubernetes `LoadBalancer` service, which provisions a VPC load balancer and public hostname address for your worker nodes. For more information, see [Exposing apps with VPC load balancers](/docs/containers?topic=containers-vpc-lbaas). |
| Storage | For persistent storage, use [block](/docs/containers?topic=containers-vpc-block). For the number of volumes that can be attached per worker node, see [Volume attachment limits](/docs/vpc?topic=vpc-attaching-block-storage#vol-attach-limits). The storage class limits the volume size to 20TB and IOPS capacity to 20,000. For non-persistent storage, secondary storage on the local worker node is not available. |
| User access | You can use [{{site.data.keyword.cloud_notm}} IAM access policies](/docs/vpc?topic=vpc-iam-getting-started) to authorize users to create infrastructure, manage your cluster, and access cluster resources. The cluster can be in a different resource group than the VPC. |
| Integrations | VPC supports a select list of supported {{site.data.keyword.cloud_notm}} services, add-ons, and third-party integrations. For a list, see [Supported {{site.data.keyword.cloud_notm}} and third-party integrations](/docs/containers?topic=containers-supported_integrations). |
| Locations and versions | VPC clusters are available worldwide in the [multizone location](/docs/containers?topic=containers-regions-and-zones#zones-vpc).
| Service interface | VPC clusters are supported by the [next version (`v2`) of the {{site.data.keyword.containerlong_notm}} API](/docs/containers?topic=containers-cs_api_install), and you can manage your VPC clusters through the same CLI and console as classic clusters.| 
| Service compliance | See the VPC section in [What standards does the service comply to?](/docs/containers?topic=containers-faqs#standards).
| Service limitations | See [Service limitations](/docs/containers?topic=containers-limitations#tech_limits). For VPC-specific limitations in {{site.data.keyword.containerlong_notm}}, see [VPC cluster limitations](/docs/containers?topic=containers-limitations#ks_vpc_gen2_limits). For general VPC infrastructure provider limitations, see [Limitations](/docs/vpc?topic=vpc-limitations).  |
{: class="simple-tab-table"}
{: caption="Table 1. Infrastructure overview" caption-side="bottom"}
{: #infra-1}
{: tab-title="VPC"}
{: tab-group="infra-table"}




| Component | Description | 
| --- | --- | 
| Compute and worker node resources | [Virtual](/docs/containers?topic=containers-planning_worker_nodes#vm), [bare metal](/docs/containers?topic=containers-planning_worker_nodes#bm), and [software-defined storage](/docs/containers?topic=containers-planning_worker_nodes#sds) machines are available for your worker nodes. Your worker node instances reside in your IBM Cloud infrastructure account, but you can manage them through {{site.data.keyword.containerlong_notm}}. You own the worker node instances.|
| Security | Built-in security features that help you protect your cluster infrastructure, isolate resources, and ensure security compliance. For more information, see the [classic Network Infrastructure documentation](/docs/cloud-infrastructure?topic=cloud-infrastructure-compare-infrastructure). |
| High availability | For both classic and VPC clusters, the master includes three replicas for high availability. Further, if you create your cluster in a multizone metro, the master replicas are spread across zones and you can also spread your worker pools across zones. For more information, see [High availability for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha). |
| Reservations | [Create a reservation](/docs/containers?topic=containers-reservations) with contracts for 1 or 3 year terms for classic worker nodes to lock in a reduced cost for the life of the contract. Typical savings range between 30-50% compared to regular worker node costs. | 
| Cluster administration | Classic clusters support the entire set of `v1` API operations, such as resizing worker pools, reloading worker nodes, and updating masters and worker nodes across major, minor, and patch versions. When you delete a cluster, you can choose to remove any attached subnet or storage instances. | 
| Cluster networking | Your worker nodes are provisioned on private VLANs that provide private IP addresses to communicate on the private IBM Cloud infrastructure network. For communication on the public network, you can also provision the worker nodes on a public VLAN. Communication to the cluster master can be on the public or private cloud service endpoint. For more information, see [Understanding cluster network basics](/docs/containers?topic=containers-plan_clusters). |
| Apps and container platform | You can choose to create [community Kubernetes or {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/containers?topic=containers-faqs#container_platforms) to manage your containerized apps. Your app build processes don't differ because of the infrastructure provider, but how you expose the app does. For more information, see [Choosing an app exposure service](/docs/containers?topic=containers-cs_network_planning). |
| App networking | All pods that are deployed to a worker node are assigned a private IP address in the 172.30.0.0/16 range and are routed between worker nodes on the worker node private IP address of the private VLAN. To expose the app on the public network, your cluster must have worker nodes on the public VLAN. Then, you can create a NodePort, LoadBalancer (NLB), or Ingress (ALB) service. For more information, see [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning).
| Storage | You can choose from non-persistent and persistent storage solutions such as file, block, object, and software-defined storage. For more information, see [Planning highly available persistent storage](/docs/containers?topic=containers-storage-plan). |
| User access | To create classic infrastructure clusters, you must set up [infrastructure credentials](/docs/containers?topic=containers-access-creds) for each region and resource group. To let users manage the cluster, use [{{site.data.keyword.cloud_notm}} IAM platform access roles](/docs/containers?topic=containers-iam-platform-access-roles). To grant users access to cluster resources, use [{{site.data.keyword.cloud_notm}} IAM service access roles](/docs/containers?topic=containers-iam-service-access-roles), which correspond with Kubernetes RBAC roles. |
| Integrations | You can extend your cluster and app capabilities with a variety of {{site.data.keyword.cloud_notm}} services, add-ons, and third-party integrations. For a list, see [Supported {{site.data.keyword.cloud_notm}} and third-party integrations](/docs/containers?topic=containers-supported_integrations). |
| Locations and versions | Classic clusters are available in multizone and single zone locations [worldwide](/docs/containers?topic=containers-regions-and-zones#locations). |
| Service interface | Classic clusters are fully supported in the {{site.data.keyword.containershort_notm}} [`v1` API](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}, [CLI](/docs/containers?topic=containers-kubernetes-service-cli), and [console](https://cloud.ibm.com/kubernetes/clusters).|
| Service compliance | See the classic section in [What standards does the service comply to?](/docs/containers?topic=containers-faqs#standards). |
| Service limitations | See [Service limitations](/docs/containers?topic=containers-limitations#tech_limits). Feature-specific limitations are documented by section. |
{: class="simple-tab-table"}
{: caption="Table 1. Infrastructure overview" caption-side="bottom"}
{: #infra-3}
{: tab-title="Classic"}
{: tab-group="infra-table"}



## What are the benefits of using the service?
{: #benefits}




Clusters are deployed on compute hosts that provide native Kubernetes and {{site.data.keyword.IBM_notm}}-specific capabilities.
{: shortdesc}





Choice of container platform provider
:   Deploy clusters with **{{site.data.keyword.redhat_openshift_notm}}** or community **Kubernetes** installed as the container platform orchestrator.
:   Choose the developer experience that fits your company, or run workloads across both {{site.data.keyword.redhat_openshift_notm}} or community Kubernetes clusters.
:   Built-in integrations from the {{site.data.keyword.cloud_notm}} console to the Kubernetes dashboard or {{site.data.keyword.redhat_openshift_notm}} web console.
:   Single view and management experience of all your {{site.data.keyword.redhat_openshift_notm}} or community Kubernetes clusters from {{site.data.keyword.cloud_notm}}. For more information, see Comparison between [{{site.data.keyword.redhat_openshift_notm}}](#openshift_kubernetes) and community Kubernetes clusters.


Single-tenant Kubernetes clusters with compute, network, and storage infrastructure isolation
:  Create your own customized infrastructure that meets the requirements of your organization.
:  Choose between [infrastructure providers](/docs/containers?topic=containers-overview#what-compute-infra-is-offered).
:   Provision a dedicated and secured Kubernetes master, worker nodes, virtual networks, and storage by using the resources provided by IBM Cloud infrastructure.
:   Fully managed Kubernetes master that is continuously monitored and updated by {{site.data.keyword.IBM_notm}} to keep your cluster available.
:   Option to provision worker nodes as bare metal servers for compute-intensive workloads such as data, GPU, and AI.
:   Store persistent data, share data between Kubernetes pods, and restore data when needed with the integrated and secure volume service.
:   Benefit from full support for all native Kubernetes APIs.

Multizone clusters to increase high availability
:   Easily manage worker nodes of the same flavor (CPU, memory, virtual or physical) with worker pools.
:   Guard against zone failure by spreading nodes evenly across select multizones and by using anti-affinity pod deployments for your apps.
:   Decrease your costs by using multizone clusters instead of duplicating the resources in a separate cluster.
:   Benefit from automatic load balancing across apps with the multizone load balancer (MZLB) that is set up automatically for you in each zone of the cluster.


Highly available masters
:   Reduce cluster downtime such as during master updates with highly available masters that are provisioned automatically when you create a cluster.
:   Spread your masters across zones in a [multizone cluster](/docs/containers?topic=containers-ha_clusters#mz-clusters) to protect your cluster from zonal failures.

Image security compliance with Vulnerability Advisor
:   Set up your own repo in our secured Docker private image registry where images are stored and shared by all users in the organization.
:   Benefit from automatic scanning of images in your private {{site.data.keyword.cloud_notm}} registry.
:   Review recommendations specific to the operating system used in the image to fix potential vulnerabilities.

Continuous monitoring of the cluster health
:   Use the cluster dashboard to quickly see and manage the health of your cluster, worker nodes, and container deployments.
:   Find detailed consumption metrics by using {{site.data.keyword.mon_full}} and quickly expand your cluster to meet work loads.
:   Review logging information by using {{site.data.keyword.la_full}} to see detailed cluster activities.

Secure exposure of apps to the public
:   Choose between a public IP address, an {{site.data.keyword.IBM_notm}} provided route, or your own custom domain to access services in your cluster from the internet.

{{site.data.keyword.cloud_notm}} service integration
:   Add extra capabilities to your app through the integration of {{site.data.keyword.cloud_notm}} services, such as {{site.data.keyword.watson}} APIs, Blockchain, data services, or Internet of Things.


## Comparison between {{site.data.keyword.redhat_openshift_notm}} and community Kubernetes clusters
{: #openshift_kubernetes}

Both {{site.data.keyword.openshiftlong_notm}} and {{site.data.keyword.containerlong_notm}} clusters are production-ready container platforms that are tailored for enterprise workloads. The following table compares and contrasts some common characteristics that can help you choose which container platform is best for your use case.
{: shortdesc}

|Characteristics|Community Kubernetes clusters|{{site.data.keyword.redhat_openshift_notm}} clusters|
|---------------|-------------|-----------------|
|Complete cluster management experience through the {{site.data.keyword.containerlong_notm}} automation tools (API, CLI, console)|Yes|Yes|
|Worldwide availability in single and multizones|Yes|Yes|
|Consistent container orchestration across hybrid cloud providers|Yes|Yes|
|Access to {{site.data.keyword.cloud_notm}} services such as AI|Yes|Yes|
|Software-defined storage Portworx solution available for multizone data use cases|Yes|Yes|
|Create a cluster in an IBM Virtual Private Cloud (VPC)|Yes|Yes|
|Latest community Kubernetes distribution|Yes| |
|Scope {{site.data.keyword.cloud_notm}} IAM access policies to access groups for service access roles that sync to cluster RBAC |Yes| |
|Classic infrastructure cluster on only the private network|Yes| |
| GPU bare metal worker nodes | Yes | Yes |
|Integrated IBM Cloud Paks and middleware| |Yes|
|Built-in container image streams, builds, and tooling ([read more](https://blog.cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/){: external})| |Yes|
|Integrated CI/CD with Jenkins| |Yes|
|Stricter app security context set up by default| |Yes|
|Simplified Kubernetes developer experience, with an app console that is suited for beginners| |Yes|
|Supported operating system| Ubuntu 18.04 x86_64, 16.04 x86_64 (deprecated) | Red Hat Enterprise Linux 7  |
|Preferred external traffic networking| Ingress | Router |
|Secured routes encrypted with {{site.data.keyword.hscrypto}} | | Yes |
{: caption="Characteristics of community Kubernetes and {{site.data.keyword.redhat_openshift_notm}} clusters" caption-side="bottom"}




## Related resources
{: #kubernetes-resources}

Review how you can learn about Kubernetes concepts and the terminology.
{: shortdesc}


* Learn how Kubernetes and {{site.data.keyword.containerlong_notm}} work together by completing this [course](https://cognitiveclass.ai/courses/kubernetes-course){: external}.


