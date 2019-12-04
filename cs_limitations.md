---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-04"

keywords: kubernetes, iks, infrastructure, rbac, policy

subcollection: containers

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated} 
{:download: .download}
{:preview: .preview} 

# Service limitations
{: #limitations}

{{site.data.keyword.containerlong}} and the Kubernetes open source project come with default service settings and limitations to ensure security, convenience, and basic functionality. Some of the limitations you might be able to change where noted.
{: shortdesc}
<br>

If you anticipate reaching any of the following {{site.data.keyword.containerlong_notm}} limitations, contact the IBM team in the [internal ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-argonauts.slack.com/messages/C4S4NUCB1) or [external Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com).
{: tip}

## Service limitations
{: #tech_limits}

{{site.data.keyword.containerlong_notm}} comes with the following service limitations that apply to all clusters, independent of what infrastructure provider you plan to use.
{: shortdesc}

| Category | Description |
| -------- | ----------- |
| API rate limits | 100 requests per 10 seconds to the {{site.data.keyword.containerlong_notm}} API for each unique source IP address. |
| Kubernetes pod logs | To check the logs for individual app pods, you can use the terminal to run `kubectl logs <pod name>`. Do not use the Kubernetes dashboard to stream logs for your pods, which might cause a disruption in your access to the Kubernetes dashboard. |
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
{: summary="This table contains information on general {{site.data.keyword.containerlong_notm}} limitations. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="{{site.data.keyword.containerlong_notm}} limitations"}

<br />


## Classic cluster limitations
{: #classic_limits}

Classic infrastructure clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #classic_compute_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Pod instances | You can run 110 pods per worker node. If you have worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later, and are provisioned with 11 CPU cores or more, you can support 10 pods per core, up to a limit of 250 pods per worker node. The number of pods includes `kube-system` and `ibm-system` pods that run on the worker node. For improved performance, consider limiting the number of pods that you run per compute core so that you do not overuse the worker node. For example, on a worker node with a `b3c.4x16` flavor, you might run 10 pods per core that use no more than 75% of the worker node total capacity. |
| Worker node flavors | Worker nodes are available in [select flavors](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node) of compute resources. |
| Worker node instances | You can have 900 worker nodes per cluster. If you plan to exceed 900 per cluster, contact the {{site.data.keyword.containerlong_notm}} team in the [internal ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-argonauts.slack.com/messages/C4S4NUCB1) or [external Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com) first. If you see an IBM Cloud infrastructure capacity limit on the number of instances per data center or that are ordered each month, contact your IBM Cloud infrastructure representative. |
{: summary="This table contains information on compute limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster compute limitations"}

### Networking
{: #classic_networking_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Ingress ALBs | <ul><li>The Ingress application load balancer (ALB) can process 32,768 connections per second. </li><li>HTTP2 is not supported.</li></ul> |
| Istio managed add-on | <ul><li>You cannot enable the managed Istio add-on in your cluster if you installed the [container image security enforcer admission controller](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in your cluster.</li><li>When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane installation. Only the `IstioControlPlane` resources that are managed by IBM are supported.</li><li>You cannot modify the `istio` configuration map in the `istio-system` namespace. This configuration map determines the Istio control plane settings after the managed add-on is installed.</li><li>The following features are not supported in the managed Istio add-on:<ui><li>[Policy enforcement](https://istio.io/docs/tasks/policy-enforcement/enabling-policy/)</li><li>[Secret discovery service (SDS)](https://istio.io/docs/tasks/security/citadel-config/auth-sds/)</li><li>[Any features by the community that are in alpha or beta release stages](https://istio.io/about/feature-stages/)</li></ul></ul> 
| Service IP addresses | You can have 65,000 IPs per cluster in the 172.21.0.0/16 range that you can assign to Kubernetes services within the cluster. |
{: summary="This table contains information on networking limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster networking limitations"}

### Storage
{: #classic_storage_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Volume instances | You can have a total of 250 IBM Cloud infrastructure file and block storage volumes per account. If you mount more than this amount, you might see an "out of capacity" message when you provision persistent volumes and need to contact your IBM Cloud infrastructure representative. For more FAQs, see the [file](/docs/infrastructure/FileStorage?topic=FileStorage-file-storage-faqs#how-many-volumes-can-i-provision-) and [block](/docs/infrastructure/BlockStorage?topic=BlockStorage-block-storage-faqs#how-many-instances-can-share-the-use-of-a-block-storage-volume-) storage docs. |
{: summary="This table contains information on storage limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster storage limitations"}

<br />


## VPC cluster limitations
{: #vpc_ks_limits}

VPC Generation 1 compute clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #vpc_compute_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Container platforms | VPC clusters are available for only community Kubernetes clusters, not OpenShift clusters. |
| Location | VPC clusters are available in the following [multizone metro locations](/docs/containers?topic=containers-regions-and-zones#zones): Dallas, Frankfurt, London, Sydney, and Tokyo. |
| v2 API | VPC clusters use the [{{site.data.keyword.containerlong_notm}} v2 API](/docs/containers?topic=containers-cs_api_install#api_about). The v2 API is currently under development, with only a limited number of API operations currently available. You can run certain v1 API operations against the VPC cluster, such as `GET /v1/clusters` or `ibmcloud ks cluster ls`, but not all the information that a Classic cluster has is returned or you might experience unexpected results. For supported VPC v2 operations, see the [CLI reference topic for VPC commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cli_classic_vpc_about). |
| Versions | VPC clusters must run Kubernetes version 1.15 or later. |
| Virtual Private Cloud | See [Known limitations](/docs/vpc-on-classic?topic=vpc-on-classic-known-limitations). |
| Worker node instances | You can have up to 100 worker nodes across all VPC clusters per account. |
| Worker node flavors | Only certain flavors are available for worker node [virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). Bare metal machines are not supported. |
| Worker node updates | You cannot update or reload worker nodes. Instead, you can delete the worker node and rebalance the worker pool with the `ibmcloud ks worker replace` command. |
{: summary="This table contains information on compute limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster compute limitations"}

### Networking
{: #vpc_networking_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Istio managed add-on | <ul><li>You cannot enable the managed Istio add-on in your cluster if you installed the [container image security enforcer admission controller](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in your cluster.</li><li>When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane installation. Only the `IstioControlPlane` resources that are managed by IBM are supported.</li><li>You cannot modify the `istio` configuration map in the `istio-system` namespace. This configuration map determines the Istio control plane settings after the managed add-on is installed.</li><li>The following features are not supported in the managed Istio add-on:<ui><li>[Policy enforcement](https://istio.io/docs/tasks/policy-enforcement/enabling-policy/)</li><li>[Secret discovery service (SDS)](https://istio.io/docs/tasks/security/citadel-config/auth-sds/)</li><li>[Any features by the community that are in alpha or beta release stages](https://istio.io/about/feature-stages/)</li></ul></ul> |
| Security groups | You cannot use [VPC security groups](/docs/infrastructure/security-groups?topic=security-groups-about-ibm-security-groups#about-ibm-security-groups) to control traffic for your cluster. VPC security groups are applied to the network interface of a single virtual server to filter traffic at the hypervisor level. However, the worker nodes of your VPC cluster exist in a service account and are not listed in the VPC infrastructure dashboard. You cannot attach a security group to your worker nodes instances. |
| strongSwan VPN service | Only [outbound VPN connections from the cluster](/docs/containers?topic=containers-vpn#strongswan_3) can be established. Additionally, because VPC clusters do not support UDP load balancers, the following <code>config.yaml</code> options are not supported for use in strongSwan Helm charts in VPC clusters: <ul><li><code>enableServiceSourceIP</code></li><li><code>loadBalancerIP</code></li><li><code>zoneLoadBalancer</code></li><li><code>connectUsingLoadBalancerIP</code></li></ul> |
| VPC load balancer | <ul><li>VPC load balancers do not currently support UDP.</li>
<li>Private VPC load balancers do not accept all traffic, only RFC 1918 traffic.</li>
<li>One VPC load balancer is created for each Kubernetes `LoadBalancer` service that you create, and it routes requests to that Kubernetes `LoadBalancer` service only. Across all of your VPC clusters in your VPC, a maximum of 20 VPC load balancers can be created.</li>
<li>The VPC load balancer can route requests to pods that are deployed on a maximum of 50 worker nodes in a cluster. If your cluster has more than 50 worker nodes, create one load balancer per zone. In the YAML file for each load balancer, add the `service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"` annotation. Each load balancer can forward requests to apps on the worker nodes in that zone only.</li>
<li>When you define the configuration YAML file for a Kubernetes `LoadBalancer` service, the following annotations and settings are not supported:<ul><li>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"`</li><li>`service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"`</li><li>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ipvs-scheduler: "<algorithm>"`</li><li>`spec.loadBalancerIP`</li><li>`spec.loadBalancerSourceRanges`</li><li>The `externalTrafficPolicy: Local` setting is supported, but the setting does not preserve the source IP of the request.</li></ul></li>
<li>Source IP preservation for requests is not supported in VPC.</li>
<li>When you delete a VPC cluster, any VPC load balancers that were automatically created by {{site.data.keyword.containerlong_notm}} for the Kubernetes `LoadBalancer` services in that cluster are also automatically deleted. However, any VPC load balancers that you manually created in your VPC are not deleted.</li>
<li>You can register up to 128 subdomains for VPC load balancer hostnames. This limit can be lifted on request by opening a [support case](/docs/get-support?topic=get-support-getting-customer-support).</li></ul> |
{: summary="This table contains information on networking limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster networking limitations"}

### Storage
{: #vpc_storage_limit}

</br>
| Category | Description |
| -------- | ----------- |
| Supported types | You can set up VPC Block Storage and {{site.data.keyword.cos_full_notm}} only.<ul><li>[VPC Block Storage](/docs/containers?topic=containers-vpc-block) is available as a cluster add-on. For more information, see [Storing data on VPC Block Storage. Make sure to [attach a public gateway to all the VPC subnets](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-using-the-ibm-cloud-cli#step-5-attach-a-public-gateway) that the cluster uses so that you can provision VPC Block Storage.</li><li>[{{site.data.keyword.cos_full_notm}}](/docs/openshift?topic=openshift-object_storage) is available as a Helm chart.</li></ul> |
| Unsupported types | File storage and Portworx software-defined storage (SDS) are not available. |
{: summary="This table contains information on storage limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster storage limitations"}


