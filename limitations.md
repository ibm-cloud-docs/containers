---

copyright: 
  years: 2014, 2025
lastupdated: "2025-03-31"


keywords: kubernetes, infrastructure, rbac, policy, http2, quota, app protocol, application protocol

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}




# Service limitations
{: #limitations}

{{site.data.keyword.containerlong}} and the Kubernetes open source project come with default service settings and limitations to ensure security, convenience, and basic functionality. Some limitations you might be able to change where noted.
{: shortdesc}


If you anticipate reaching any of the following {{site.data.keyword.containerlong_notm}} limitations, [contact IBM Support](/docs/account?topic=account-using-avatar) and provide the cluster ID, the new quota limit, the region, and infrastructure provider in your support ticket.
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
| Calico network plug-in | Changing the Calico plug-in, components, or default Calico settings is not supported. For example, don't deploy a new Calico plug-in version, or modify the daemon sets or deployments for the Calico components, default `IPPool` resources, or Calico nodes. Instead, you can follow the documentation to [create a Calico `NetworkPolicy` or `GlobalNetworkPolicy`](/docs/containers?topic=containers-network_policies), to [change the Calico MTU](/docs/containers?topic=containers-kernel#calico-mtu), or to [disable the port map plug-in for the Calico CNI](/docs/containers?topic=containers-kernel#calico-portmap). |
| Cluster quota | You can't exceed 100 clusters per region and per [infrastructure provider](/docs/containers?topic=containers-overview#what-compute-infra-is-offered). However, as of 01 January 2024, quotas are increased incrementally before reaching 100. If you need more of the resource, [contact IBM Support](/docs/account?topic=account-using-avatar). In the support case, include the new quota limit for the region and infrastructure provider that you want.. To list quotas, run `ibmcloud quota ls`. |
| Kubernetes | Make sure to review the [Kubernetes project limitations](https://kubernetes.io/docs/setup/best-practices/cluster-large/){: external}. |
| KMS provider | Customizing the IP addresses that are allowed to connect to your {{site.data.keyword.keymanagementservicefull}} instance is not supported.|
| Kubernetes pod logs | To check the logs for individual app pods, you can use the command line to run `kubectl logs <pod name>`. Do not use the Kubernetes dashboard to stream logs for your pods, which might cause a disruption in your access to the Kubernetes dashboard. |
| Load balancers | Although the Kubernetes [SCTP protocol](https://kubernetes.io/docs/concepts/services-networking/service/#sctp){: external} is generally available in the Kubernetes community release, creating load balancers that use this protocol is not supported in {{site.data.keyword.containerlong_notm}} clusters. |
| Operating system | Worker nodes must run one of the supported operating systems. You can't create a cluster with worker nodes that run different types of operating systems. For more information, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). |
| Pod instances | You can run 110 pods per worker node. If you have worker nodes with 11 CPU cores or more, you can support 10 pods per core, up to a limit of 250 pods per worker node. The number of pods includes `kube-system` and `ibm-system` pods that run on the worker node. For improved performance, consider limiting the number of pods that you run per compute core so that you don't overuse the worker node. For example, on a worker node with a `b3c.4x16` flavor, you might run 10 pods per core that use no more than 75% of the worker node total capacity. |
| Worker node quota | A maximum 500 worker nodes for any accounts created before 01 January 2024. For accounts created on or after that date, the maximum quota is 200 after a period of lower quotas. Quotas apply per cluster [infrastructure provider](/docs/containers?topic=containers-overview#what-compute-infra-is-offered). If you need more of the resource, [contact IBM Support](/docs/account?topic=account-using-avatar). In the support case, include the new quota limit for the region and infrastructure provider that you want.. To list quotas run, `ibmcloud ks quota ls`. |
| Worker pool size | You must always have a minimum of 1 node in your cluster. Because of the worker node quota, you are limited in the number of worker pools per cluster and number of worker nodes per worker pool. For example, with the default worker node quota of 500 per region, you might have up to 500 worker pools of 1 worker node each in a region with only 1 cluster. Or, you might have 1 worker pool with up to 500 worker nodes in a region with only 1 cluster. |
| Red Hat Enterprise Linux CoreOS worker nodes | The maximum amount of zones added to a cluster is 15. For example, 4 RHCOS worker pools with 3 zones each will account for 12/15 of the quota for that cluster. |
| Number of worker nodes | Clusters can have a maximum of 500 worker nodes. |
| Red Hat Enterprise Linux CoreOS worker nodes | The maximum amount of zones added to a cluster is 15. For example, 4 RHCOS worker pools with 3 zones each will account for 12/15 of the quota for that cluster. |
| Cluster naming | To ensure that the Ingress subdomain and certificate are correctly registered, the first 24 characters of the clusters' names must be different. If you create and delete clusters with the same name or names that have the same first 24 characters 5 times or more within 7 days, such as for automation or testing purposes, you might reach the [Let's Encrypt Duplicate Certificate rate limit](/docs/containers?topic=containers-cs_rate_limit). |
| Resource groups | A cluster can be created in only one resource group that you can't change afterward. If you create a cluster in the wrong resource group, you must delete the cluster and re-create it in the correct resource group. Furthermore, if you need to use the `ibmcloud ks cluster service bind` command to [integrate with an {{site.data.keyword.cloud_notm}} service](/docs/containers?topic=containers-service-binding#bind-services), that service must be in the same resource group as the cluster. Services that don't use resource groups like {{site.data.keyword.registrylong_notm}} or that don't need service binding like {{site.data.keyword.logs_full_notm}} work even if the cluster is in a different resource group. |
{: caption="{{site.data.keyword.containerlong_notm}} limitations"}






## Classic cluster limitations
{: #classic_limits}

Classic infrastructure clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #classic_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Reserved instances | [Reserved capacity and reserved instances](/docs/virtual-servers?topic=virtual-servers-provisioning-reserved-capacity-and-instances) are not supported. |
| Worker node flavors | Worker nodes are available in select flavors of compute resources. |
| Worker node host access | For security, you can't SSH into the worker node compute host. |
{: caption="Classic cluster compute limitations"}

### Networking
{: #classic_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Ingress ALBs |  \n - The Ingress application load balancer (ALB) can process 32,768 connections per second. If your Ingress traffic exceeds this number,  [scale up the number of ALB replicas](/docs/containers?topic=containers-comm-ingress-annotations) in your cluster to handle the increased workload. \n - ALBs that run the [{{site.data.keyword.containerlong_notm}} custom Ingress image](/docs/containers?topic=containers-managed-ingress-about) only: HTTP/2 is not supported. \n - ALBs that run the [{{site.data.keyword.containerlong_notm}} custom Ingress image] (/docs/containers?topic=containers-managed-ingress-about) only: The names of the `ClusterIP` services that expose your apps must be unique across all namespaces in your cluster.  |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| Network load balancers (NLB)| - You can't update an existing NLB from version 1.0 to 2.0. You must create a new NLB 2.0. \n - You can't create subdomains for private NLBs. \n - You can register up to 128 subdomains. This limit can be lifted on request by opening a [support case](/docs/account?topic=account-using-avatar).  |
| strongSwan VPN service | See [strongSwan VPN service considerations](/docs/containers?topic=containers-vpn#strongswan_limitations). |
| Service IP addresses | You can have 65,000 IP addresses per cluster in the 172.21.0.0/16 range that you can assign to Kubernetes services within the cluster. |
| Subnets per VLAN | Each VLAN has a limit of 40 subnets. |
{: caption="Classic cluster networking limitations"}

### Storage
{: #classic_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Volume instances | You can have a total of 250 IBM Cloud infrastructure file and block storage volumes per account. If you mount more than this amount, you might see an `out of capacity` message when you provision persistent volumes. For more FAQ, see the [file](/docs/FileStorage?topic=FileStorage-file-storage-faqs#provision) and [block](/docs/BlockStorage?topic=BlockStorage-block-storage-faqs#authlimit) storage docs. If you want to mount more volumes, [contact IBM Support](/docs/account?topic=account-using-avatar). In your support ticket, include your account ID and the new file or block storage volume quota that you want.  |
| Portworx | Review the [Portworx limitations](/docs/containers?topic=containers-storage_portworx_plan#portworx_limitations). |
{: caption="Classic cluster storage limitations"}

## User access
{: #classic_access_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| IP address access | Restricting access for specific users by enabling IP address access is not supported by {{site.data.keyword.containerlong_notm}}. If you want to restrict user access or restrict which services and VPCs a user can access, consider [context-based restriction](/docs/containers?topic=containers-cbr-tutorial).  |
{: caption="Classic cluster user access limitations"}



## VPC cluster limitations
{: #ks_vpc_gen2_limits}

VPC clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations. Additionally, all the underlying [VPC quotas, VPC limits](/docs/vpc?topic=vpc-quotas), [VPC service limitations](/docs/vpc?topic=vpc-limitations), and [regular service limitations](#tech_limits) apply.
{: shortdesc}

### Compute
{: #vpc_gen2_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Encryption | The secondary disks of your worker nodes are encrypted at rest by default by the [underlying VPC infrastructure provider](/docs/vpc?topic=vpc-block-storage-about#vpc-storage-encryption). However, you can't [bring your own encryption to the underlying virtual server instances](/docs/vpc?topic=vpc-file-storage-byok-encryption&interface=ui). |
| Location | VPC clusters are available only in [select multizone regions](/docs/containers?topic=containers-regions-and-zones#zones-vpc). |
| Virtual Private Cloud | See [Limitations](/docs/vpc?topic=vpc-limitations) and [Quotas](/docs/vpc?topic=vpc-quotas). |
| Worker node flavors | Only certain flavors are available for worker node virtual machines. Bare metal machines are not supported.|
| Worker node host access | For security, you can't SSH into the worker node compute host. |
| Worker node updates | You can't update or reload VPC worker nodes. Instead, you can delete the worker node and rebalance the worker pool with the `ibmcloud ks worker replace` command. If you replace multiple worker nodes at the same time, they are deleted and replaced concurrently, not one by one. Make sure that you have enough capacity in your cluster to reschedule your workloads before you replace worker nodes. |
{: caption="VPC cluster compute limitations"}


### Networking
{: #vpc_gen2_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| App URL length | DNS resolution is managed by the cluster's [virtual private endpoint (VPE)](/docs/containers?topic=containers-vpc-subnets#vpc_basics_vpe), which can resolve URLs up to 130 characters. If you expose apps in your cluster with URLs, such as the Ingress subdomain, ensure that the URLs are 130 characters or fewer. |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| Network speeds | [VPC profile network speeds](/docs/vpc?topic=vpc-profiles) refer to the speeds of the worker node interfaces. The maximum speed available to your worker nodes is `25Gbps`. Because IP in IP encapsulation is required for traffic between pods that are on different subnets, data transfer speeds between pods on different subnets might be slower, about half the compute profile network speed. Overall network speeds for apps that you deploy to your cluster depend on the worker node size and application's architecture. |
| NodePort | You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection. To access an app from the internet, you must use a VPC load balancer or Ingress service instead. |
| Pod network | VPC access control lists (ACLs) filter incoming and outgoing traffic for your cluster at the subnet level, and security groups filter incoming and outgoing traffic for your cluster at the worker nodes level. To control traffic within the cluster at the pod-to-pod level, you can't use VPC security groups or ACLs. Instead, use [Calico](/docs/containers?topic=containers-network_policies) and [Kubernetes network policies](/docs/containers?topic=containers-vpc-kube-policies), which can control the pod-level network traffic that uses IP in IP encapsulation. |
| strongSwan VPN service | The strongSwan service is not supported. To connect your cluster to resources in an on-premises network or another VPC, see [Using VPN with your VPC](/docs/vpc?topic=vpc-vpn-onprem-example). |
| Subnets |  \n - See [VPC networking limitations](/docs/containers?topic=containers-vpc-subnets#vpc_basics_limitations). \n - Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.  |
| VPC load balancer | See [VPC load balancer limitations](/docs/containers?topic=containers-vpclb-about#vpclb_limit). |
{: caption="VPC cluster networking limitations"}

### Storage
{: #vpc_gen2_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| {{site.data.keyword.block_storage_is_short}} cluster add-on | The {{site.data.keyword.block_storage_is_short}} cluster add-on is enabled by default on VPC clusters. However, the add-on is not currently supported for clusters with `UBUNTU_18_S390X` worker nodes. When you create a VPC cluster with `UBUNTU_18_S390X` worker nodes, the add-on pods will remain in a `Pending` state. You can disable the add-on by running the `ibmcloud ks cluster addon disable` command. | 
| Storage class for profile sizes | For more information, see [available volume profiles](/docs/vpc?topic=vpc-block-storage-profiles). |
| Supported types | You can set up {{site.data.keyword.block_storage_is_short}}, {{site.data.keyword.cos_full_notm}} and {{site.data.keyword.databases-for}} only. \n - [{{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block) is available as a cluster add-on. Make sure to [attach a public gateway to all the VPC subnets](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#attach-public-gateway-cli) that the cluster uses so that you can provision {{site.data.keyword.block_storage_is_short}}. \n - [{{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-storage_cos_install) is available as a Helm chart.  |
| Volume attachments | See [Volume attachment limits](/docs/vpc?topic=vpc-attaching-block-storage#vol-attach-limits).|
| Portworx | Review the [Portworx limitations](/docs/containers?topic=containers-storage_portworx_plan#portworx_limitations). |
| {{site.data.keyword.block_storage_is_short}} | The default storage class in VPC clusters cannot be changed. However, you can [create your own storage class](/docs/containers?topic=containers-vpc-block#vpc-customize-storage-class). |
{: caption="VPC cluster storage limitations"}

## User access
{: #vpc_access_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| IP address access | Restricting access for specific users by enabling IP address access is not supported by {{site.data.keyword.containerlong_notm}}. If you want to restrict user access or restrict which services and VPCs a user can access, consider [context-based restriction](/docs/containers?topic=containers-cbr-tutorial).  |
{: caption="VPC cluster user access limitations"}
