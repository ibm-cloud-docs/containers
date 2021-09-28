---

copyright: 
  years: 2014, 2021
lastupdated: "2021-09-28"

keywords: kubernetes, iks, containers

subcollection: containers

---




{{site.data.keyword.attribute-definition-list}}


# Benefits and service offerings
{: #cs_ov}

[{{site.data.keyword.containerlong}}](https://www.ibm.com/cloud/kubernetes-service){: external} delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts. For more information about certification, see [Compliance on the {{site.data.keyword.cloud_notm}}](https://www.ibm.com/cloud/compliance){: external}.
{: shortdesc}

Check out the following <a href="https://www.ibm.com/demos/collection/Containers-(Kubernetes)-on-IBM-Cloud/?lc=null">videos</a> to learn more about how you can use {{site.data.keyword.containerlong_notm}} to modernize and run containerized apps.
{: tip}


## Benefits of using the service
{: #benefits}

Clusters are deployed on compute hosts that provide native Kubernetes and {{site.data.keyword.IBM_notm}}-specific capabilities.
{: shortdesc}

Ready to get started? Try out the [creating a Kubernetes cluster tutorial](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial).

|Benefit|Description|
|-------|-----------|
|Choice of container platform provider | <ul><li>Deploy clusters with <strong>{{site.data.keyword.openshiftshort}}</strong> or community <strong>Kubernetes</strong> installed as the container platform orchestrator.</li><li>Choose the developer experience that fits your company, or run workloads across both {{site.data.keyword.openshiftshort}} or community Kubernetes clusters.</li><li>Built-in integrations from the {{site.data.keyword.cloud_notm}} console to the Kubernetes dashboard or {{site.data.keyword.openshiftshort}} web console.</li><li>Single view and management experience of all your {{site.data.keyword.openshiftshort}} or community Kubernetes clusters from {{site.data.keyword.cloud_notm}}.</li><li>For more information, see <a href="#openshift_kubernetes">Comparison between {{site.data.keyword.openshiftshort}} and community Kubernetes clusters</a>.</li></ul>|
|Single-tenant Kubernetes clusters with compute, network, and storage infrastructure isolation|<ul><li>Create your own customized infrastructure that meets the requirements of your organization.</li><li>Choose between <a href="/docs/containers?topic=containers-infrastructure_providers">{{site.data.keyword.cloud_notm}} Classic or VPC infrastructure providers</a>.</li><li>Provision a dedicated and secured Kubernetes master, worker nodes, virtual networks, and storage by using the resources provided by IBM Cloud infrastructure.</li><li>Fully managed Kubernetes master that is continuously monitored and updated by {{site.data.keyword.IBM_notm}} to keep your cluster available.</li><li>Option to provision worker nodes as bare metal servers for compute-intensive workloads such as data, GPU, and AI.</li><li>Store persistent data, share data between Kubernetes pods, and restore data when needed with the integrated and secure volume service.</li><li>Benefit from full support for all native Kubernetes APIs.</li></ul>|
| Multizone clusters to increase high availability | <ul><li>Easily manage worker nodes of the same flavor (CPU, memory, virtual or physical) with worker pools.</li><li>Guard against zone failure by spreading nodes evenly across select multizones and by using anti-affinity pod deployments for your apps.</li><li>Decrease your costs by using multizone clusters instead of duplicating the resources in a separate cluster.</li><li>Benefit from automatic load balancing across apps with the multizone load balancer (MZLB) that is set up automatically for you in each zone of the cluster.</li></ul>|
| Highly available masters | <ul><li>Reduce cluster downtime such as during master updates with highly available masters that are provisioned automatically when you create a cluster.</li><li>Spread your masters across zones in a <a href="/docs/containers?topic=containers-ha_clusters#multizone">multizone cluster</a> to protect your cluster from zonal failures.</li></ul> |
|Image security compliance with Vulnerability Advisor|<ul><li>Set up your own repo in our secured Docker private image registry where images are stored and shared by all users in the organization.</li><li>Benefit from automatic scanning of images in your private {{site.data.keyword.cloud_notm}} registry.</li><li>Review recommendations specific to the operating system used in the image to fix potential vulnerabilities.</li></ul>|
|Continuous monitoring of the cluster health|<ul><li>Use the cluster dashboard to quickly see and manage the health of your cluster, worker nodes, and container deployments.</li><li>Find detailed consumption metrics by using {{site.data.keyword.mon_full}} and quickly expand your cluster to meet work loads.</li><li>Review logging information by using {{site.data.keyword.la_full}} to see detailed cluster activities.</li></ul>|
|Secure exposure of apps to the public|<ul><li>Choose between a public IP address, an {{site.data.keyword.IBM_notm}} provided route, or your own custom domain to access services in your cluster from the internet.</li></ul>|
|{{site.data.keyword.cloud_notm}} service integration|<ul><li>Add extra capabilities to your app through the integration of {{site.data.keyword.cloud_notm}} services, such as {{site.data.keyword.watson}} APIs, Blockchain, data services, or Internet of Things.</li></ul>|
{: caption="Benefits of the {{site.data.keyword.containerlong_notm}}" caption-side="top"}





## Comparison of offerings and their combinations
{: #differentiation}

You can run {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.cloud_notm}} Public, in {{site.data.keyword.cloud_notm}} Private, or in a hybrid setup.
{: shortdesc}


<table summary="The columns are read from left to right. The first column has the type of cloud setup. The second column describes the setup.">
<caption>Differences between {{site.data.keyword.containershort_notm}} setups</caption>
<col width="25%">
    <thead>
    <th>{{site.data.keyword.containershort_notm}} setup</th>
    <th>Description</th>
    </thead>
    <tbody>
    <tr>
    <td>{{site.data.keyword.cloud_notm}} Public, off-premises</td>
    <td>With {{site.data.keyword.cloud_notm}} Public on <a href="/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes">shared or dedicated hardware or on bare metal machines</a>, you can host your apps in clusters on the cloud by using {{site.data.keyword.containerlong_notm}}. You can also create a cluster with worker pools in multiple zones to increase high availability for your apps. {{site.data.keyword.containerlong_notm}} on {{site.data.keyword.cloud_notm}} Public delivers powerful tools by combining Docker containers, the Kubernetes technology, an intuitive user experience, and built-in security and isolation to automate the deployment, operation, scaling, and monitoring of containerized apps in a cluster of compute hosts.<br><br>For more information, see <a href="/docs/containers?topic=containers-service-arch">{{site.data.keyword.containerlong_notm}} technology</a>.
    <p class="tip">You can also create your cluster in a Virtual Private Cloud (VPC), which gives you the security of a private cloud environment with isolated networking features along with the dynamic scalability of the public cloud. For more information, see <a href="/docs/containers?topic=containers-infrastructure_providers">Overview of Classic and VPC infrastructure providers</a>.</p>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.cloud_notm}} Private, on-premises</td>
    <td>{{site.data.keyword.cloud_notm}} Private is an application platform that can be installed locally on your own machines. You might choose to use Kubernetes in {{site.data.keyword.cloud_notm}} Private when you need to develop and manage on-premises, containerized apps in your own controlled environment behind a firewall. <br><br>For more information, see the <a href="https://www.ibm.com/docs/en/cloud-private/3.2.x">{{site.data.keyword.cloud_notm}} Private product documentation</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.
    </td>
    </tr>
    </tbody>
</table>



## Comparison of free and standard clusters
{: #cluster_types}

You can create one free cluster or any number of standard clusters. Try out [free clusters](/docs/containers?topic=containers-getting-started#clusters_gs) to get familiar with a few Kubernetes capabilities, or create standard clusters to use the full capabilities of Kubernetes to deploy apps. Free clusters are automatically deleted after 30 days.
{: shortdesc}

If you have a free cluster and want to upgrade to a standard cluster, you can [create a standard cluster](/docs/containers?topic=containers-clusters#clusters_ui). Then, [copy your deployment configuration files](/docs/containers?topic=containers-update_app#copy_apps_cluster) from your free cluster into the standard cluster.

|Characteristics|Free clusters|Standard clusters|
|---------------|-------------|-----------------|
|[In-cluster networking](/docs/containers?topic=containers-security#network)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public network app access by a NodePort service to a non-stable IP address](/docs/containers?topic=containers-nodeport)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[User access management](/docs/containers?topic=containers-access-overview#access_policies)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[{{site.data.keyword.cloud_notm}} service access from the cluster and apps](/docs/containers?topic=containers-service-binding#bind-services)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Disk space on worker node for non-persistent storage](/docs/containers?topic=containers-storage_planning#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
| [Provision {{site.data.keyword.openshiftshort}} clusters](/docs/openshift?topic=openshift-getting-started) | | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
| [Create clusters in a Virtual Private Cloud (VPC)](/docs/containers?topic=containers-vpc_ks_tutorial) | | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
|[Ability to create cluster in every {{site.data.keyword.containerlong_notm}} region](/docs/containers?topic=containers-regions-and-zones)| | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
|[Multizone clusters to increase app high availability](/docs/containers?topic=containers-ha_clusters#multizone)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Replicated masters for higher availability| | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
|[Scalable number of worker nodes to increase capacity](/docs/containers?topic=containers-ca)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Persistent NFS file-based storage with volumes](/docs/containers?topic=containers-file_storage#file_storage)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public or private network app access by a network load balancer (NLB) service to a stable IP address](/docs/containers?topic=containers-loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Public network app access by an Ingress service to a stable IP address and customizable URL](/docs/containers?topic=containers-ingress-about)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Portable public IP addresses](/docs/containers?topic=containers-subnets#review_ip)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Logging and monitoring](/docs/containers?topic=containers-health#logging)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Option to provision your worker nodes on physical (bare metal) servers](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
{: caption="Characteristics of free and standard clusters" caption-side="top"}





## Comparison between {{site.data.keyword.openshiftshort}} and community Kubernetes clusters
{: #openshift_kubernetes}

Both {{site.data.keyword.openshiftlong_notm}} and {{site.data.keyword.containerlong_notm}} clusters are production-ready container platforms that are tailored for enterprise workloads. The following table compares and contrasts some common characteristics that can help you choose which container platform is right for your use case.
{: shortdesc}

|Characteristics|Community Kubernetes clusters|{{site.data.keyword.openshiftshort}} clusters|
|---------------|-------------|-----------------|
|Complete cluster management experience through the {{site.data.keyword.containerlong_notm}} automation tools (API, CLI, console)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Worldwide availability in single and multizones|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Consistent container orchestration across hybrid cloud providers|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Access to {{site.data.keyword.cloud_notm}} services such as AI|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Software-defined storage Portworx solution available for multizone data use cases|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Create a cluster in an IBM Virtual Private Cloud (VPC)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Ability to create free clusters|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| |
|Latest community Kubernetes distribution|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| |
|Scope {{site.data.keyword.cloud_notm}} IAM access policies to access groups for service access roles that sync to cluster RBAC |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| |
|Classic infrastructure cluster on only the private network|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| |
| GPU bare metal worker nodes | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
|Integrated IBM Cloud Paks and middleware| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Built-in container image streams, builds, and tooling ([read more](https://cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/){: external})| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Integrated CI/CD with Jenkins| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Stricter app security context set up by default| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Simplified Kubernetes developer experience, with an app console that is suited for beginners| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Supported operating system| Ubuntu 18.04 x86_64, 16.04 x86_64 (deprecated) |Red Hat Enterprise Linux 7|
|Preferred external traffic networking| Ingress | Router |
|Secured routes encrypted with {{site.data.keyword.hscrypto}} | | <img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" /> |
{: caption="Characteristics of community Kubernetes and {{site.data.keyword.openshiftshort}} clusters" caption-side="top"}








