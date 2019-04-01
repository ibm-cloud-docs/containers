---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-01"

keywords: kubernetes, iks

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



# Your responsibilities by using {{site.data.keyword.containerlong_notm}}
{: #responsibilities_iks}

Learn about cluster management responsibilities and terms and conditions that you have when you use {{site.data.keyword.containerlong}}.
{:shortdesc}


## Cluster management responsibilities
{: #responsibilities}

Review the responsibilities that you share with IBM to manage your clusters.
{:shortdesc}


**IBM is responsible for:**

- Deploying the master, worker nodes, and management components within the cluster, such as Ingress application load balancer, at cluster creation time
- Providing the security updates, monitoring, isolation, and recovery of the Kubernetes master for the cluster
- Making version updates and security patches available for you to apply to your cluster worker nodes
- Monitoring the health of the worker nodes and providing automation for the update and recovery of those worker nodes
- Performing automation tasks against your infrastructure account, including adding worker nodes, removing worker nodes, and creating a default subnet
- Managing, updating, and recovering operational components within the cluster, such as the Ingress application load balancer and the storage plug-in
- Provisioning of storage volumes when requested by persistent volume claims
- Providing security settings on all worker nodes

</br>

**You are responsible for:**

- [Configuring the {{site.data.keyword.containerlong_notm}} API key with the appropriate permissions to access the IBM Cloud infrastructure (SoftLayer) portfolio and other {{site.data.keyword.Bluemix_notm}} services](/docs/containers?topic=containers-users#api_key)
- [Deploying and managing Kubernetes resources, such as pods, services, and deployments, within the cluster](/docs/containers?topic=containers-app#app_cli)
- [Leveraging the capabilities of the service and Kubernetes to ensure high availability of apps](/docs/containers?topic=containers-app#highly_available_apps)
- [Adding or removing cluster capacity by resizing your worker pools](/docs/containers?topic=containers-clusters#add_workers)
- [Enabling VLAN spanning and keeping your multizone worker pools balanced across zones](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Creating public and private VLANs in IBM Cloud infrastructure (SoftLayer) for network isolation of your cluster](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Ensuring that all worker nodes have network connectivity to the Kubernetes service endpoint URLs](/docs/containers?topic=containers-firewall#firewall) <p class="note">If a worker node has both public and private VLANs, then network connectivity is configured. If worker nodes are set up with a private VLAN only, you must allow worker nodes and the cluster master to communicate by [enabling the private service endpoint](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) or [configuring a gateway device](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). If you set up a firewall, you must manage and configure its settings to allow access for {{site.data.keyword.containerlong_notm}} and other {{site.data.keyword.Bluemix_notm}} services that you use with the cluster.</p>
- [Updating the master kube-apiserver when Kubernetes version updates are available](/docs/containers?topic=containers-update#master)
- [Keeping the worker nodes up-to-date on major, minor, and patch versions](/docs/containers?topic=containers-update#worker_node) <p class="note">You cannot change the operating system of your worker node or log into the worker node. Worker node updates are provided by IBM as a full worker node image that includes the latest security patches. To apply the updates, the worker node must be reimaged and reloaded with the new image. Keys for the root user are automatically rotated when the worker node is reloaded. </p>
- [Monitoring the health of your cluster by setting up log forwarding for your cluster components](/docs/containers?topic=containers-health#health).   
- [Recovering troubled worker nodes by running `kubectl` commands, such as `cordon` or `drain`, and by running `ibmcloud ks` commands, such as `reboot`, `reload`, or `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [Adding or removing subnets in IBM Cloud infrastructure (SoftLayer) as needed](/docs/containers?topic=containers-subnets#subnets)
- [Backing up and restoring data in persistent storage in IBM Cloud infrastructure (SoftLayer) ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Setting up [logging](/docs/containers?topic=containers-health#logging) and [monitoring](/docs/containers?topic=containers-health#view_metrics) services to support your cluster's health and performance
- [Configuring health monitoring for worker nodes with Autorecovery](/docs/containers?topic=containers-health#autorecovery)
- Auditing events that change resources in your cluster, such as by using [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) to view user-initiated activities that change the state of your {{site.data.keyword.containerlong_notm}} instance





<br />


## Abuse of {{site.data.keyword.containerlong_notm}}
{: #terms}

Clients cannot misuse {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Misuse includes:

*   Any illegal activity
*   Distribution or execution of malware
*   Harming {{site.data.keyword.containerlong_notm}} or interfering with anyone's use of {{site.data.keyword.containerlong_notm}}
*   Harming or interfering with anyone's use of any other service or system
*   Unauthorized access to any service or system
*   Unauthorized modification of any service or system
*   Violation of the rights of others

See [Cloud Services terms](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms) for overall terms of use.
