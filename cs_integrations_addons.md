---

copyright:
  years: 2014, 2019
lastupdated: "2019-11-26"

keywords: kubernetes, iks, helm

subcollection: containers

---

{:new_window: target="_blank"}
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

# Adding services by using managed add-ons
{: #managed-addons}

Quickly add extra capabilities and open-source technologies to your cluster with managed add-ons.
{: shortdesc}

**What are managed add-ons?** </br>
Managed {{site.data.keyword.containerlong_notm}} add-ons are an easy way to enhance your cluster with extra capabilities and open-source capabilities, such as Istio, Knative, Kubernetes Terminal, or {{site.data.keyword.block_storage_is_short}}. The version of the driver, plug-in, or open-source tool that you add to your cluster is tested by IBM and approved to be used in {{site.data.keyword.containerlong_notm}}.

The managed add-ons that you can install in your cluster depend on the type of cluster, the container platform, and the infrastructure provider that you choose. 
{: note}

**How does the billing and support work for managed add-ons?** </br>
Managed add-ons are fully integrated into the {{site.data.keyword.cloud_notm}} support organization. If you have a question or an issue with using the managed add-ons, you can use one of the {{site.data.keyword.containerlong_notm}} support channels. For more information, see [Getting help and support](/docs/containers?topic=containers-cs_troubleshoot_clusters#clusters_getting_help).

If the tool that you add to your cluster incurs costs, these costs are automatically integrated and listed as part of your {{site.data.keyword.containerlong_notm}} billing. The billing cycle is determined by {{site.data.keyword.cloud_notm}} depending on when you enabled the add-on in your cluster.

**What limitations do I need to account for?** </br>
If you installed the [container image security enforcer admission controller](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in your cluster, you cannot enable managed add-ons in your cluster.

## Adding managed add-ons
{: #adding-managed-add-ons}

To enable a managed add-on in your cluster, you use the [`ibmcloud ks cluster addon enable` command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_enable). When you enable the managed add-on, a supported version of the tool, including all Kubernetes resources are automatically installed in your cluster. Refer to the documentation of each managed add-on to find the prerequisites that your cluster must meet to install the managed add-on.

For more information about the prerequisites for each add-on, see:

- [Istio](/docs/containers?topic=containers-istio#istio)
- [Knative](/docs/containers?topic=containers-serverless-apps-knative)
- [Kubernetes Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web)
- [{{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block)

## Updating managed add-ons
{: #updating-managed-add-ons}

The versions of each managed add-on are tested by {{site.data.keyword.cloud_notm}} and approved for use in {{site.data.keyword.containerlong_notm}}. To update the components of an add-on to the most recent version supported by {{site.data.keyword.containerlong_notm}}, use the following steps.
{: shortdesc}

1. Check for update instructions that are specific to your managed add-on, such as [Knative](/docs/containers?topic=containers-serverless-apps-knative#update-knative-addon) or [Istio](/docs/containers?topic=containers-istio#istio_update). If you do not find update instructions, continue with the next step. 
2. If your add-on does not have specific update instructions, select the cluster where you installed managed add-ons from your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters). 
3. Select the **Add-ons** tab. 
4. From the actions menu, select **Update** to start updating the managed add-on. When the update is installed, the latest version of the managed add-on is listed on the cluster add-on page. 
