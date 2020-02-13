---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-13"

keywords: kubernetes, iks, infrastructure, rbac, policy

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


# Service limitations
{: #limitations}

{{site.data.keyword.containerlong}} and the Kubernetes open source project come with default service settings and limitations to ensure security, convenience, and basic functionality. Some of the limitations you might be able to change where noted.
{: shortdesc}
<br>

If you anticipate reaching any of the following {{site.data.keyword.containerlong_notm}} limitations, contact the IBM team in the [internal](https://ibm-argonauts.slack.com/messages/C4S4NUCB1){: external} or [external Slack](https://ibm-container-service.slack.com){: external}.
{: tip}

## Service limitations
{: #tech_limits}

{{site.data.keyword.containerlong_notm}} comes with the following service limitations that apply to all clusters, independent of what infrastructure provider you plan to use. Keep in mind that the [classic](#classic_limits) and [VPC](#vpc_ks_limits) cluster limitations also apply.
{: shortdesc}

| Category | Description |
| -------- | ----------- |
| API rate limits | 100 requests per 10 seconds to the {{site.data.keyword.containerlong_notm}} API for each unique source IP address. |
| App deployment | The apps that you deploy to and services that you integrate with your cluster must be able to run on the operating system of the worker nodes. |
| Kubernetes | Make sure to review the [Kubernetes project limitations](https://kubernetes.io/docs/setup/best-practices/cluster-large/){: external}. |
| Kubernetes pod logs | To check the logs for individual app pods, you can use the terminal to run `kubectl logs <pod name>`. Do not use the Kubernetes dashboard to stream logs for your pods, which might cause a disruption in your access to the Kubernetes dashboard. |
{: summary="This table contains information on general {{site.data.keyword.containerlong_notm}} limitations. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="{{site.data.keyword.containerlong_notm}} limitations"}

<br />




## Classic cluster limitations
{: #classic_limits}

Classic infrastructure clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #classic_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Operating system | You cannot create a cluster with worker nodes that run multiple operating systems, such as OpenShift on Red Hat Enterprise Linux and community Kubernetes on Ubuntu. |
| Pod instances | You can run 110 pods per worker node. If you have worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later, and are provisioned with 11 CPU cores or more, you can support 10 pods per core, up to a limit of 250 pods per worker node. The number of pods includes `kube-system` and `ibm-system` pods that run on the worker node. For improved performance, consider limiting the number of pods that you run per compute core so that you do not overuse the worker node. For example, on a worker node with a `b3c.4x16` flavor, you might run 10 pods per core that use no more than 75% of the worker node total capacity. |
| Worker node flavors | Worker nodes are available in [select flavors](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node) of compute resources. |
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
| Worker node instances | You can have 900 worker nodes per cluster. If you plan to exceed 900 per cluster, contact the {{site.data.keyword.containerlong_notm}} team in the [internal](https://ibm-argonauts.slack.com/messages/C4S4NUCB1){: external} or [external Slack](https://ibm-container-service.slack.com){: external} first. If you see an IBM Cloud infrastructure capacity limit on the number of instances per data center or that are ordered each month, contact your IBM Cloud infrastructure representative. |
{: summary="This table contains information on compute limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster compute limitations"}

### Networking
{: #classic_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Ingress ALBs | <ul><li>The Ingress application load balancer (ALB) can process 32,768 connections per second. </li><li>HTTP2 is not supported.</li></ul> |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| Network load balancers (NLB)| <ul><li>You cannot update an existing NLB from version 1.0 to 2.0. You must create a new NLB 2.0.</li><li>You cannot create subdomains for private NLBs.</li><li>You can register up to 128 subdomains. This limit can be lifted on request by opening a [support case](/docs/get-support?topic=get-support-getting-customer-support).</li></ul> |
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
| Volume instances | You can have a total of 250 IBM Cloud infrastructure file and block storage volumes per account. If you mount more than this amount, you might see an "out of capacity" message when you provision persistent volumes and need to contact your IBM Cloud infrastructure representative. For more FAQs, see the [file](/docs/FileStorage?topic=FileStorage-file-storage-faqs#how-many-volumes-can-i-provision-) and [block](/docs/BlockStorage?topic=BlockStorage-block-storage-faqs#how-many-instances-can-share-the-use-of-a-block-storage-volume-) storage docs. |
{: summary="This table contains information on storage limitations for classic clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="Classic cluster storage limitations"}

<br />


## VPC cluster limitations
{: #vpc_ks_limits}

VPC Generation 1 compute clusters in {{site.data.keyword.containerlong_notm}} are released with the following limitations.
{: shortdesc}

### Compute
{: #vpc_compute_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Container platforms | VPC clusters are available for only community Kubernetes clusters, not OpenShift clusters. |
| Location | VPC clusters are available in the following [multizone metro locations](/docs/containers?topic=containers-regions-and-zones#zones): Dallas, Frankfurt, London, Sydney, and Tokyo. |
| v2 API | VPC clusters use the [{{site.data.keyword.containerlong_notm}} v2 API](/docs/containers?topic=containers-cs_api_install#api_about). The v2 API is currently under development, with only a limited number of API operations currently available. You can run certain v1 API operations against the VPC cluster, such as `GET /v1/clusters` or `ibmcloud ks cluster ls`, but not all the information that a Classic cluster has is returned or you might experience unexpected results. For supported VPC v2 operations, see the [CLI reference topic for VPC commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cli_classic_vpc_about). |
| Versions | VPC clusters must run Kubernetes version 1.15 or later. |
| Virtual Private Cloud | See [Known limitations](/docs/vpc-on-classic?topic=vpc-on-classic-known-limitations) and [Quotas](/docs/vpc-on-classic?topic=vpc-on-classic-quotas). |
| Operating system | You cannot create a cluster with worker nodes that run multiple operating systems, such as OpenShift on Red Hat Enterprise Linux and community Kubernetes on Ubuntu. |
| Pod instances | You can run 110 pods per worker node. If you have worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later, and are provisioned with 11 CPU cores or more, you can support 10 pods per core, up to a limit of 250 pods per worker node. The number of pods includes `kube-system` and `ibm-system` pods that run on the worker node. For improved performance, consider limiting the number of pods that you run per compute core so that you do not overuse the worker node. For example, on a worker node with a `b3c.4x16` flavor, you might run 10 pods per core that use no more than 75% of the worker node total capacity. |
| Worker node flavors | Only certain flavors are available for worker node [virtual machines](/docs/containers?topic=containers-planning_worker_nodes#vm). Bare metal machines are not supported. |
| Worker node host access | For security, you cannot SSH into the worker node compute host. |
| Worker node instances | You can have up to 100 worker nodes across all VPC clusters per account. |
| Worker node updates | You cannot update or reload worker nodes. Instead, you can delete the worker node and rebalance the worker pool with the `ibmcloud ks worker replace` command. |
{: summary="This table contains information on compute limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster compute limitations"}

### Networking
{: #vpc_networking_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Istio managed add-on | See [Istio add-on limitations](/docs/containers?topic=containers-istio-about#istio_limitations). |
| NodePort | You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection. To access an app from the internet, you must use a VPC load balancer or Ingress service instead. |
| Security groups | You cannot attach worker nodes to [VPC security groups](/docs/vpc?topic=vpc-using-security-groups) because your worker nodes exist in a service account and are not listed in the VPC infrastructure dashboard. Although you cannot attach a security group to your worker nodes instances, you can create security groups at the level of the VPC. If you use use non-default security groups, you must [allow traffic requests to node ports on your worker nodes](/docs/containers?topic=containers-vpc-firewall#security_groups). |
| strongSwan VPN service | See [strongSwan VPN service considerations](/docs/openshift?topic=openshift-vpn#strongswan_limitations).<ul><li>Only [outbound VPN connections from the cluster](/docs/containers?topic=containers-vpn#strongswan_3) can be established.</li><li>Because VPC clusters do not support UDP load balancers, the following `config.yaml` options are not supported for use in strongSwan Helm charts in VPC clusters: <ul><li>`enableServiceSourceIP`</li><li>`loadBalancerIP`</li><li>`zoneLoadBalancer`</li><li>`connectUsingLoadBalancerIP`</li></ul></li></ul> |
| Subnets | <ul><li>See [VPC networking limitations](/docs/containers?topic=containers-vpc-subnets#vpc_basics_limitations).</li><li>Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.</li></ul> |
| VPC load balancer | See [VPC load balancer limitations](/docs/containers?topic=containers-vpc-lbaas#lbaas_limitations). |
{: summary="This table contains information on networking limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster networking limitations"}

### Storage
{: #vpc_storage_limit}

Keep in mind that the [service](#tech_limits) limitations also apply.

| Category | Description |
| -------- | ----------- |
| Supported types | You can set up VPC Block Storage and {{site.data.keyword.cos_full_notm}} only.<ul><li>[VPC Block Storage](/docs/containers?topic=containers-vpc-block) is available as a cluster add-on. Make sure to [attach a public gateway to all the VPC subnets](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-using-the-ibm-cloud-cli#step-5-attach-a-public-gateway) that the cluster uses so that you can provision VPC Block Storage.</li><li>[{{site.data.keyword.cos_full_notm}}](/docs/openshift?topic=openshift-object_storage) is available as a Helm chart.</li></ul> |
| Unsupported types | File storage and Portworx software-defined storage (SDS) are not available. |
{: summary="This table contains information on storage limitations for VPC clusters. Columns are read from left to right. In the first column is the type of limitation and in the second column is the description of the limitation."}
{: caption="VPC cluster storage limitations"}



