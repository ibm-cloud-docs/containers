---

copyright:
  years: 2014, 2026
lastupdated: "2026-08-25"


keywords: kubernetes, clusters

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Accessing clusters
{: #access_cluster}
{: help}
{: support}

After your {{site.data.keyword.containerlong}} cluster is created, you can connect to it using several methods depending on your cluster type, network configuration, and use case. If you're not sure which method applies to you, start by identifying your cluster's infrastructure type and whether it has a public service endpoint (see [Choosing an access method](#access-method-choose) below).
{: shortdesc}

## Before you begin
{: #access-prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and Kubernetes CLI (`kubectl`). For quick access to test features in your cluster, you can also use [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cli-install).
1. If you haven't created a cluster yet, [create one now](/docs/containers?topic=containers-clusters). Otherwise, proceed to the next step.
1. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall#corporate) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
1. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-debug_clusters) guide for help.

## Choosing an access method
{: #access-method-choose}

The right access method depends on your cluster infrastructure type, whether your cluster has a public or private service endpoint, and your network connectivity.

Not sure which type you have? In the IBM Cloud console, go to **Kubernetes → Clusters**, click your cluster, and check the **Infrastructure** field on the Overview tab — it shows **VPC**, **Classic**, or **Satellite**. To check whether your cluster has a public or private service endpoint, look at the **Public Service Endpoint URL** and **Private Service Endpoint URL** fields on the same page, or run `ibmcloud ks cluster get -c <cluster_name_or_ID>` and check those fields in the output.
{: tip}

| Access method | Cluster type | Use when |
| --- | --- | --- |
| [Public cloud service endpoint](/docs/containers?topic=containers-cluster-access-public) | Classic, VPC | Your cluster has a public endpoint and you are connecting from outside the IBM Cloud network |
| [Private cloud service endpoint — VPC](/docs/containers?topic=containers-cluster-access-private-vpc) | VPC | Your cluster is private-only and you are connected to the VPC network through a VPN or Direct Link connection |
| [Private cloud service endpoint — Classic](/docs/containers?topic=containers-access-private-classic) | Classic | Your cluster is private-only and you are connected to the classic private network |
| [Virtual Private Endpoint (VPE) gateway](/docs/containers?topic=containers-cluster-access-vpe) | VPC | Your VPC cluster uses VPE for private master connectivity |
| [API key or service ID](/docs/containers?topic=containers-cluster-access-automation) | All | Automated pipelines and non-interactive scripts |
| [Accessing private clusters by using the WireGuard VPN](/docs/containers?topic=containers-cluster-access-wireguard) | Classic, VPC | You want to access a private-only cluster from outside IBM Cloud using a WireGuard VPN |
| [Admission controller webhooks](/docs/containers?topic=containers-access_webhooks) | All | You need to allow cluster access for admission controller webhooks |
{: caption="Cluster access methods" caption-side="bottom"}
