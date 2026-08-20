---

copyright:
  years: 2014, 2026
lastupdated: "2026-08-20"


keywords: kubernetes, clusters

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Accessing clusters
{: #access_cluster}
{: help}
{: support}

After your {{site.data.keyword.containerlong}} cluster is created, you can begin working with your cluster by accessing the cluster.
{: shortdesc}

## Prerequisites
{: #prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and Kubernetes CLI (`kubectl`). For quick access to test features in your cluster, you can also use the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cli-install).
2. [Create your {{site.data.keyword.containerlong_notm}} cluster](/docs/containers?topic=containers-clusters).
3. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall#corporate) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
4. Check that your cluster is in a healthy state by running `ibmcloud ks cluster get -c <cluster_name_or_ID>`. If your cluster is not in a healthy state, review the [Debugging clusters](/docs/containers?topic=containers-debug_clusters) guide for help.
5. In the output of the cluster details from the previous step, check the **Public** or **Private Service Endpoint** URL of the cluster.
    *  **Public Service Endpoint URL only**: Continue with [Accessing clusters through the public cloud service endpoint](/docs/containers?topic=containers-cluster-access-public).
    *  **Private Service Endpoint URL only (Classic)**: Continue with [Accessing Classic clusters through the private cloud service endpoint](/docs/containers?topic=containers-access-private-classic).
    *  **Private Service Endpoint URL only (VPC)**: Continue with [Accessing VPC clusters through the private cloud service endpoint](/docs/containers?topic=containers-cluster-access-private-vpc).
    *  **Both service endpoint URLs**: You can access your cluster through the [public](/docs/containers?topic=containers-cluster-access-public) or private ([Classic](/docs/containers?topic=containers-access-private-classic) or [VPC](/docs/containers?topic=containers-cluster-access-private-vpc)) service endpoint.
6. You can also access your VPC cluster through the [Virtual Private Endpoint gateway](/docs/containers?topic=containers-cluster-access-vpe).
