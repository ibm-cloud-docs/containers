---

copyright:
  years: 2014, 2020
lastupdated: "2020-10-08"

keywords: kubernetes, iks, infrastructure, rbac, policy, http2, quota

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Service limitations
{: #limitations}

{{site.data.keyword.containerlong}} and the Kubernetes open source project come with default service settings and limitations to ensure security, convenience, and basic functionality. Some of the limitations you might be able to change where noted.
{: shortdesc}
<br>

If you anticipate reaching any of the following {{site.data.keyword.containerlong_notm}} limitations, [contact IBM Support](/docs/get-support?topic=get-support-using-avatar) and provide the cluster ID, the new quota limit, the region, and infrastructure provider in your support ticket.
{: tip}

## Service and quota limitations
{: #tech_limits}

{{site.data.keyword.containerlong_notm}} comes with the following service limitations and quotas that apply to all clusters, independent of what infrastructure provider you plan to use. Keep in mind that the [classic](#classic_limits) and [VPC](#ks_vpc_gen2_limits) cluster limitations also apply.
{: shortdesc}

To view quota limits on cluster-related resources in your {{site.data.keyword.cloud_notm}} account, use the `ibmcloud ks quota ls` command.
{: tip}

| Category | Description |
| -------- | ----------- |
| API rate limits | 200 requests per 10 seconds to the {{site.data.keyword.containerlong_notm}} API from each unique source IP address. |
| App deployment | The apps that you deploy to and services that you integrate with your cluster must be able to run on the operating system of the worker nodes. |
| Cluster quota | You cannot exceed 100 clusters per region and per [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers). If you need more than 100 clusters, [contact IBM Support](/docs/get-support?topic=get-support-using-avatar). In the support case, include the new cluster quota limit for the region and infrastructure provider that you want. |<openshift ag-limit>
| IAM access groups | You cannot scope {{site.data.keyword.cloud_notm}} IAM service access roles to an IAM access group because the roles are not synced to the RBAC roles within the cluster. If you want to scope RBAC roles to a group of users, you must [manually set up groups of users](https://docs.openshift.com/container-platform/4.4/authentication/understanding-authentication.html){: external} in your cluster instead of using IAM access groups. You can still manage individual users and service accounts with IAM service roles. You can also still scope IAM platform roles to IAM access groups to control actions like ordering worker nodes, because platform roles are never synced to RBAC roles. |
| Kubernetes | Make sure to review the [Kubernetes project limitations](https://kubernetes.io/docs/setup/best-practices/cluster-large/){: external}. |
| KMS provider | Customizing the IP addresses that are allowed to connect to your {{site.data.keyword.keymanagementservicefull}} instance is not supported. |
| Kubernetes pod logs | To check the logs for individual app pods, you can use the terminal to run `kubectl logs <pod name>`. Do not use the Kubernetes dashboard to stream logs for your pods, which might cause a disruption in your access to the Kubernetes dashboard. |
| Pod instances | You can run 110 pods per worker node. If you have worker nodes with 11 CPU cores or more, you can support 10 pods per core, up to a limit of 250 pods per worker node. The number of pods includes `kube-system` and `ibm-system` pods that run on the worker node. For improved performance, consider limiting the number of pods that you run per compute core so that you do not overuse the worker node. For example, on a worker node with a `b3c.4x16` flavor, you might run 10 pods per core that use no more than 75% of the worker node total capacity. |
| Worker node quota | You cannot exceed 500 worker nodes across all clusters in a region, per [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers). If you need more than 500 worker nodes in a region, [contact IBM Support](/docs/get-support?topic=get-support-using-avatar). In the support case, include the new worker node quota limit for the region and infrastructure provider that you want.|
| Worker pool size | You must have a minimum of 1 worker node in your worker pool at all times. For more information, see [What is the smallest size cluster that I can make?](/docs/containers?topic=containers-faqs#smallest_cluster). You cannot scale worker pools down to zero. Because of the worker node quota, you are limited in the number of worker pools per cluster and number of worker nodes per worker pool. For example, with the default worker node quota of 500 per region, you might have up to 500 worker pools of 1 worker node each in a region with only 1 cluster. Or, you might have 1 worker pool with up to 500 worker nodes in a region with only 1 cluster. |
{: summary="This table contains information on general {{site.data.keyword.containerlong_notm}} limitations. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="{{site.data.keyword.containerlong_notm}} limitations"}

<br />





## Classic cluster limitations
{: #classic_limits}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic infrastructure clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #classic_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Operating system | You cannot create a cluster with worker nodes that run multiple operating systems, such as {{site.data.keyword.openshiftshort}} on Red Hat Enterprise Linux and community Kubernetes on Ubuntu. |
| Reserved instances | [Reserved capacity and reserved instances](/docs/virtual-servers?topic=virtual-servers-provisioning-reserved-capacity-and-instances) are not supported. |
| Worker node flavors | Worker nodes are available in [select flavors](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node) of compute resources. |
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
{: summary="This table contains information on compute limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster compute limitations"}

### Networking
{: #classic_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Ingress ALBs | <ul><li>The Ingress application load balancer (ALB) can process 32,768 connections per second. If your Ingress traffic exceeds this number, [scale up the number of ALB replicas](/docs/containers?topic=containers-ingress#scale_albs) in your cluster to handle the increased workload.</li><li>ALBs that run the [{{site.data.keyword.containerlong_notm}} custom Ingress image](/docs/containers?topic=containers-ingress-types) only: HTTP/2 is not supported.</li><li>ALBs that run the [{{site.data.keyword.containerlong_notm}} custom Ingress image](/docs/containers?topic=containers-ingress-types) only: The names of the `ClusterIP` services that expose your apps must be unique across all namespaces in your cluster.</li></ul> |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| Network load balancers (NLB)| <ul><li>You cannot update an existing NLB from version 1.0 to 2.0. You must create a new NLB 2.0.</li><li>You cannot create subdomains for private NLBs.</li><li>You can register up to 128 subdomains. This limit can be lifted on request by opening a [support case](/docs/get-support?topic=get-support-using-avatar).</li></ul> |
| strongSwan VPN service | See [strongSwan VPN service considerations](/docs/openshift?topic=openshift-vpn#strongswan_limitations). |
| Service IP addresses | You can have 65,000 IPs per cluster in the 172.21.0.0/16 range that you can assign to Kubernetes services within the cluster. |
| Subnets per VLAN | Each VLAN has a limit of 40 subnets. |
{: summary="This table contains information on networking limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster networking limitations"}

### Storage
{: #classic_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Volume instances | You can have a total of 250 IBM Cloud infrastructure file and block storage volumes per account. If you mount more than this amount, you might see an "out of capacity" message when you provision persistent volumes. For more FAQs, see the [file](/docs/FileStorage?topic=FileStorage-file-storage-faqs#provision) and [block](/docs/BlockStorage?topic=BlockStorage-block-storage-faqs#authlimit) storage docs. If you want to mount more volumes, [contact IBM Support](/docs/get-support?topic=get-support-using-avatar). In your support ticket, include your account ID and the new file or block storage volume quota that you want.  |
| Portworx | Review the [Portworx limitations](/docs/containers?topic=containers-portworx#portworx_limitations). |
{: summary="This table contains information on storage limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster storage limitations"}

<br />


## VPC Gen 2 compute cluster limitations
{: #ks_vpc_gen2_limits}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> <img src="images/icon-vpc-gen2.png" alt="VPC Generation 2 compute icon" width="30" style="width:30px; border-style: none"/> VPC Generation 2 compute clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations. Additionally, all the underlying [VPC quotas, VPC limits](/docs/vpc?topic=vpc-quotas), [VPC service limitations](/docs/vpc?topic=vpc-limitations), and [regular service limitations](#tech_limits) apply.
{: shortdesc}

### Compute
{: #vpc_gen2_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Encryption | The secondary disks of your worker nodes are encrypted at rest by default by the [underlying VPC infrastructure provider](/docs/vpc?topic=vpc-block-storage-about#vpc-storage-encryption). However, you cannot [bring your own encryption to the underlying virtual server instances](/docs/vpc?topic=vpc-creating-instances-byok).|
| Location | VPC Gen 2 clusters are available only in [select multizone metro locations](/docs/containers?topic=containers-regions-and-zones#zones-vpc-gen2). |
| Operating system | You cannot create a cluster with worker nodes that run multiple operating systems, such as {{site.data.keyword.openshiftshort}} on Red Hat Enterprise Linux and community Kubernetes on Ubuntu. |
| Versions | VPC Gen 2 clusters must run Kubernetes version 1.17 or later. |
| Virtual Private Cloud | See [Known limitations](/docs/vpc-on-classic?topic=vpc-on-classic-known-limitations) and [Quotas](/docs/vpc-on-classic?topic=vpc-on-classic-quotas). |
| v2 API | VPC clusters use the [{{site.data.keyword.containerlong_notm}} v2 API](/docs/containers?topic=containers-cs_api_install#api_about). The v2 API is currently under development, with only a limited number of API operations currently available. You can run certain v1 API operations against the VPC cluster, such as `GET /v1/clusters` or `ibmcloud ks cluster ls`, but not all the information that a Classic cluster has is returned or you might experience unexpected results. For supported VPC v2 operations, see the [CLI reference topic for VPC commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cli_classic_vpc_about). |
| Worker node flavors | Only certain flavors are available for worker node [virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). Bare metal machines are not supported.|
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
| Worker node updates | You cannot update or reload worker nodes. Instead, you can delete the worker node and rebalance the worker pool with the `ibmcloud ks worker replace` command. If you replace multiple worker nodes at the same time, they are deleted and replaced concurrently, not one by one. Make sure that you have enough capacity in your cluster to reschedule your workloads before you replace worker nodes. |
{: summary="This table contains information on compute limitations for VPC Gen 2 clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC Gen 2 cluster compute limitations"}


### Networking
{: #vpc_gen2_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| Network speeds | [VPC Gen 2 compute profile network speeds](/docs/vpc?topic=vpc-profiles) refer to the speeds of the worker node interfaces. The maximum speed available to your worker nodes is `16Gbps`. Because IP in IP encapsulation is required for traffic between pods that are on different VPC Gen 2 worker nodes, data transfer speeds between pods on different worker nodes might be slower, about half the compute profile network speed. Overall network speeds for apps that you deploy to your cluster depend on the worker node size and application's architecture. |
| NodePort | You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection. To access an app from the internet, you must use a VPC load balancer or Ingress service instead. |
| Pod network | VPC access control lists (ACLs) filter incoming and outgoing traffic for your cluster at the subnet level, such as traffic through the VPC load balancer. To control traffic within the cluster at the pod-to-pod level, you cannot use VPC security groups or ACLs. Instead, use [Calico](/docs/containers?topic=containers-network_policies) and [Kubernetes network policies](/docs/containers?topic=containers-vpc-network-policy#kubernetes_policies), which can control the pod-level network traffic that uses IP in IP encapsulation. |
| strongSwan VPN service | The strongSwan service is not supported. To connect your cluster to resources in an on-premises network or another VPC, see [Using VPN with your VPC](/docs/vpc?topic=vpc-vpn-onprem-example). |
| Subnets | <ul><li>See [VPC networking limitations](/docs/containers?topic=containers-vpc-subnets#vpc_basics_limitations).</li><li>Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.</li></ul> |
| VPC load balancer | See [VPC load balancer limitations](/docs/containers?topic=containers-vpc-lbaas#lbaas_limitations). |
| VPC security groups | You must [allow inbound traffic requests to node ports on your worker nodes](/docs/containers?topic=containers-vpc-network-policy#security_groups). |
{: summary="This table contains information on networking limitations for VPC Gen 2 clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC Gen 2 cluster networking limitations"}

### Storage
{: #vpc_gen2_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Storage class for profile sizes | The [available volume profiles](/docs/vpc?topic=vpc-block-storage-profiles) are limited to 2TB in size and 20,000 IOPS in capacity. |
| Supported types | You can set up {{site.data.keyword.block_storage_is_short}}, {{site.data.keyword.cos_full_notm}} and {{site.data.keyword.databases-for}} only.<ul><li>[{{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block) is available as a cluster add-on. Make sure to [attach a public gateway to all the VPC subnets](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-using-the-ibm-cloud-cli#step-5-attach-a-public-gateway) that the cluster uses so that you can provision {{site.data.keyword.block_storage_is_short}}.</li><li>[{{site.data.keyword.cos_full_notm}}](/docs/openshift?topic=openshift-object_storage) is available as a Helm chart.</li></ul> |
| Unsupported types | NFS File Storage is not supported. |
| Volume attachments | See [Volume attachment limits](/docs/vpc?topic=vpc-attaching-block-storage#vol-attach-limits).|
| Portworx | Review the [Portworx limitations](/docs/containers?topic=containers-portworx#portworx_limitations). |
{: summary="This table contains information on storage limitations for VPC Gen 2 clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC Gen 2 cluster storage limitations"}



## VPC Gen 1 compute cluster limitations
{: #vpc_ks_limits}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> <img src="images/icon-vpc-gen1.png" alt="VPC Generation 1 compute icon" width="30" style="width:30px; border-style: none"/> VPC Generation 1 compute clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #vpc_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Container platforms | VPC Gen 1 clusters are available for only community Kubernetes clusters, not {{site.data.keyword.openshiftshort}} clusters. |
| Encryption | The secondary disks of your worker nodes are encrypted at rest by default by the [underlying VPC infrastructure provider](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-about#about-provider-managed-encryption-gen1). However, you cannot [bring your own encryption to the underlying virtual server instances](/docs/vpc?topic=vpc-creating-instances-byok).|
| Location | VPC clusters are available only in [multizone metro locations](/docs/containers?topic=containers-regions-and-zones#zones). |
| v2 API | VPC clusters use the [{{site.data.keyword.containerlong_notm}} v2 API](/docs/containers?topic=containers-cs_api_install#api_about). The v2 API is currently under development, with only a limited number of API operations currently available. You can run certain v1 API operations against the VPC cluster, such as `GET /v1/clusters` or `ibmcloud ks cluster ls`, but not all the information that a Classic cluster has is returned or you might experience unexpected results. For supported VPC v2 operations, see the [CLI reference topic for VPC commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cli_classic_vpc_about). |
| Virtual Private Cloud | See [Known limitations](/docs/vpc-on-classic?topic=vpc-on-classic-known-limitations) and [Quotas](/docs/vpc-on-classic?topic=vpc-on-classic-quotas). |
| Operating system | You cannot create a cluster with worker nodes that run multiple operating systems, such as {{site.data.keyword.openshiftshort}} on Red Hat Enterprise Linux and community Kubernetes on Ubuntu. |
| Worker node flavors | Only certain flavors are available for worker node [virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). Bare metal machines are not supported. |
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
| Worker node updates | You cannot update or reload worker nodes. Instead, you can delete the worker node and rebalance the worker pool with the `ibmcloud ks worker replace` command. If you replace multiple worker nodes at the same time, they are deleted and replaced concurrently, not one by one. Make sure that you have enough capacity in your cluster to reschedule your workloads before you replace worker nodes. |
{: summary="This table contains information on compute limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster compute limitations"}

### Networking
{: #vpc_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| NodePort | You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection. To access an app from the internet, you must use a VPC load balancer or Ingress service instead. |
| Security groups | The default [VPC security group](/docs/vpc?topic=vpc-using-security-groups) that is created for you is automatically applied to your worker nodes. You can make changes to the default security group, such as to [allow traffic requests to node ports on your worker nodes](/docs/containers?topic=containers-vpc-network-policy#security_groups). However, you cannot create other security groups to apply to your worker nodes. |
| strongSwan VPN service | <ul><li>Only [outbound VPN connections from the cluster](/docs/containers?topic=containers-vpn#strongswan_3) can be established.</li><li>Because VPC clusters do not support UDP load balancers, the following `config.yaml` options are not supported for use in strongSwan Helm charts in VPC clusters: <ul><li>`enableServiceSourceIP`</li><li>`loadBalancerIP`</li><li>`zoneLoadBalancer`</li><li>`connectUsingLoadBalancerIP`</li></ul></li></ul> |
| Subnets | <ul><li>See [VPC networking limitations](/docs/containers?topic=containers-vpc-subnets#vpc_basics_limitations).</li><li>Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.</li></ul> |
| VPC load balancer | See [VPC load balancer limitations](/docs/containers?topic=containers-vpc-lbaas#lbaas_limitations). |
{: summary="This table contains information on networking limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster networking limitations"}

### Storage
{: #vpc_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Storage class for profile sizes | The [available volume profiles](/docs/vpc?topic=vpc-block-storage-profiles) are limited to 2TB in size and 20,000 IOPS in capacity. |
| Supported types | You can set up VPC Block Storage and {{site.data.keyword.cos_full_notm}} only.<ul><li>[VPC Block Storage](/docs/containers?topic=containers-vpc-block) is available as a cluster add-on. Make sure to [attach a public gateway to all the VPC subnets](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-using-the-ibm-cloud-cli#step-5-attach-a-public-gateway) that the cluster uses so that you can provision VPC Block Storage.</li><li>[{{site.data.keyword.cos_full_notm}}](/docs/openshift?topic=openshift-object_storage) is available as a Helm chart.</li></ul> |
| Unsupported types | File storage is not available. |
{: summary="This table contains information on storage limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster storage limitations"}






