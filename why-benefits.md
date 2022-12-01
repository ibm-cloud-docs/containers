---

copyright: 
  years: 2014, 2022
lastupdated: "2022-12-01"

keywords: kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}




# Benefits and service offerings
{: #cs_ov}

[{{site.data.keyword.containerlong}}](https://www.ibm.com/cloud/kubernetes-service){: external} delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts. For more information about certification, see [Compliance on the {{site.data.keyword.cloud_notm}}](https://www.ibm.com/cloud/compliance){: external}.
{: shortdesc}



## Benefits of using the service
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
:  Choose between [{{site.data.keyword.cloud_notm}} Classic or VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers).
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






## Comparison of offerings and their combinations
{: #differentiation}

You can run {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.cloud_notm}} Public, in {{site.data.keyword.cloud_notm}} Private, or in a hybrid setup.
{: shortdesc}


{{site.data.keyword.cloud_notm}} Public, off-premises
:   With {{site.data.keyword.cloud_notm}} Public on [shared or dedicated](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes) hardware or on bare metal machines, you can host your apps in clusters on the cloud by using {{site.data.keyword.containerlong_notm}}. You can also create a cluster with worker pools in multiple zones to increase high availability for your apps. {{site.data.keyword.containerlong_notm}} on {{site.data.keyword.cloud_notm}} Public delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts For more information, see [{{site.data.keyword.containerlong_notm}} technology](/docs/containers?topic=containers-service-arch).

:   You can also create your cluster in a Virtual Private Cloud (VPC), which gives you the security of a private cloud environment with isolated networking features along with the dynamic scalability of the public cloud. For more information, see [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers).

{{site.data.keyword.cloud_notm}} Private, on-premises
:   {{site.data.keyword.cloud_notm}} Private is an application platform that can be installed locally on your own machines. You might choose to use Kubernetes in {{site.data.keyword.cloud_notm}} Private when you need to develop and manage on-premises, containerized apps in your own controlled environment behind a firewall. For more information, see the [{{site.data.keyword.cloud_notm}} Private product documentation](https://www.ibm.com/docs/en/cloud-private/3.2.x){: external}.




## Comparison of free and standard clusters
{: #cluster_types}

You can create one free cluster or any number of standard clusters. Try out [free clusters](/docs/containers?topic=containers-getting-started#clusters_gs) to get familiar with a few Kubernetes capabilities, or create standard clusters to use the full capabilities of Kubernetes to deploy apps. Free clusters are automatically deleted after 30 days.
{: shortdesc}

If you have a free cluster and want to upgrade to a standard cluster, you can [create a standard cluster](/docs/containers?topic=containers-clusters). Then, [copy your deployment configuration files](/docs/containers?topic=containers-update_app#copy_apps_cluster) from your free cluster into the standard cluster.

|Characteristics|Free clusters|Standard clusters|
|---------------|-------------|-----------------|
|[In-cluster networking](/docs/containers?topic=containers-security#network)|Yes|Yes|
|[Public network app access by a NodePort service to a non-stable IP address](/docs/containers?topic=containers-nodeport)|Yes|Yes|
|[User access management](/docs/containers?topic=containers-access-overview#access_policies)|Yes|Yes|
|[{{site.data.keyword.cloud_notm}} service access from the cluster and apps](/docs/containers?topic=containers-service-binding#bind-services)|Yes|Yes|
|[Disk space on worker node for non-persistent storage](/docs/containers?topic=containers-storage_planning#non_persistent_overview)|Yes|Yes|
|[Provision {{site.data.keyword.redhat_openshift_notm}} clusters](/docs/openshift?topic=openshift-getting-started) | | Yes |
|[Create clusters in a Virtual Private Cloud (VPC)](/docs/containers?topic=containers-vpc_ks_tutorial) | | Yes |
|[Ability to create cluster in every {{site.data.keyword.containerlong_notm}} region](/docs/containers?topic=containers-regions-and-zones)| | Yes |
|[Multizone clusters to increase app high availability](/docs/containers?topic=containers-ha_clusters#mz-clusters)| |Yes|
|Replicated masters for higher availability| | Yes |
|[Scalable number of worker nodes to increase capacity](/docs/containers?topic=containers-cluster-scaling-classic-vpc)| |Yes|
|[Persistent NFS file-based storage with volumes](/docs/containers?topic=containers-file_storage#file_storage)| |Yes|
|[Public or private network app access by a network load balancer (NLB) service to a stable IP address](/docs/containers?topic=containers-loadbalancer)| |Yes|
|[Public network app access by an Ingress service to a stable IP address and customizable URL](/docs/containers?topic=containers-ingress-about)| |Yes|
|[Portable public IP addresses](/docs/containers?topic=containers-subnets#review_ip)| |Yes|
|[Logging and monitoring](/docs/containers?topic=containers-health#logging)| |Yes|
|[Option to provision your worker nodes on physical (bare metal) servers](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes)| |Yes|
{: caption="Characteristics of free and standard clusters" caption-side="bottom"}





## Comparison between {{site.data.keyword.redhat_openshift_notm}} and community Kubernetes clusters
{: #openshift_kubernetes}

Both {{site.data.keyword.openshiftlong_notm}} and {{site.data.keyword.containerlong_notm}} clusters are production-ready container platforms that are tailored for enterprise workloads. The following table compares and contrasts some common characteristics that can help you choose which container platform is right for your use case.
{: shortdesc}

|Characteristics|Community Kubernetes clusters|{{site.data.keyword.redhat_openshift_notm}} clusters|
|---------------|-------------|-----------------|
|Complete cluster management experience through the {{site.data.keyword.containerlong_notm}} automation tools (API, CLI, console)|Yes|Yes|
|Worldwide availability in single and multizones|Yes|Yes|
|Consistent container orchestration across hybrid cloud providers|Yes|Yes|
|Access to {{site.data.keyword.cloud_notm}} services such as AI|Yes|Yes|
|Software-defined storage Portworx solution available for multizone data use cases|Yes|Yes|
|Create a cluster in an IBM Virtual Private Cloud (VPC)|Yes|Yes|
|Ability to create free clusters|Yes| |
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


