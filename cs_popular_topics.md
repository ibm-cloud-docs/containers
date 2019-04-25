---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-25"

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



# Popular topics for {{site.data.keyword.containerlong_notm}}
{: #cs_popular_topics}

Keep up with what's going on in {{site.data.keyword.containerlong}}. Learn about new features to explore, a trick to try out, or some popular topics that other developers are finding useful in the now.
{:shortdesc}



## Popular topics in April 2019
{: #apr19}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in April 2019</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>15 Apr 2019</td>
<td>[Registering a network load balancer (NLB) host name](/docs/containers?topic=containers-loadbalancer#loadbalancer_hostname)</td>
<td>After you set up public network load balancers (NLBs) to expose your apps to the internet, you can now create DNS entries for the NLB IPs by creating host names. {{site.data.keyword.Bluemix_notm}} takes care of generating and maintaining the wildcard SSL certificate for the host name for you. You can also set up TCP/HTTP(S) monitors to health check the NLB IP addresses behind each host name.</td>
</tr>
<tr>
<td>8 Apr 2019</td>
<td>[Kubernetes Terminal in your web browser (beta)](/docs/containers?topic=containers-cs_cli_install#cli_web)</td>
<td>If you use the cluster dashboard in the {{site.data.keyword.Bluemix_notm}} console to manage your clusters but want to quickly make more advanced configuration changes, you can now run CLI commands directly from your web browser in the Kubernetes Terminal. On the detail page for a cluster, launch the Kubernetes Terminal by clicking the **Terminal** button. Note that the Kubernetes Terminal is released as a beta add-on and is not intended for use in production clusters.</td>
</tr>
<tr>
<td>4 Apr 2019</td>
<td>[Highly available masters now in Sydney](/docs/containers?topic=containers-regions-and-zones#zones)</td>
<td>When you [create a cluster](/docs/containers?topic=containers-clusters#clusters_ui) in a multizone metro location, now including Sydney, the Kubernetes master replicas are spread across zones for high availability.</td>
</tr>
</tbody></table>

## Popular topics in March 2019
{: #mar19}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in March 2019</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>21 Mar 2019</td>
<td>Introducing private service endpoints for your Kubernetes cluster master</td>
<td>By default, {{site.data.keyword.containerlong_notm}} sets up your cluster with access on a public and private VLAN. Previously, if you wanted a [private VLAN-only cluster](/docs/containers?topic=containers-plan_clusters#private_clusters), you needed to set up a gateway device to connect the cluster's worker nodes with the master. Now, you can use the private service endpoint. With the private service endpoint enabled, all traffic between the worker nodes and the master is on the private network, without the need for a gateway device device. In addition to this increased security, inbound and outbound traffic on the private network is [unlimited and not charged ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/bandwidth). You can still keep a public service endpoint for secure access to your Kubernetes master over the internet, for example to run `kubectl` commands without being on the private network.<br><br>
To use private service endpoints, you must enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) and [service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started) for your IBM Cloud infrastructure (SoftLayer) account. Your cluster must run Kubernetes version 1.11 or later. If your cluster runs an earlier Kubernetes version, [update to at least 1.11](/docs/containers?topic=containers-update#update). For more information, check out the following links:<ul>
<li>[Service endpoints for worker-to-master and user-to-master communication](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)</li>
<li>[Setting up the private service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se)</li>
<li>[Switching from public to private service endpoints](/docs/containers?topic=containers-cs_network_cluster#migrate-to-private-se)</li>
<li>If you have a firewall on the private network, [adding the private IP addresses for {{site.data.keyword.containerlong_notm}}, {{site.data.keyword.registrylong_notm}}, and other {{site.data.keyword.Bluemix_notm}} services](/docs/containers?topic=containers-firewall#firewall_outbound)</li>
</ul>
<p class="important">If you switch to a private-only service endpoint cluster, make sure that your cluster can still communicate with other {{site.data.keyword.Bluemix_notm}} services that you use. [Portworx software-defined storage (SDS)](/docs/containers?topic=containers-portworx#portworx) and [cluster autoscaler](/docs/containers?topic=containers-ca#ca) do not support private-only service endpoint. Use a cluster with both public and private service endpoints instead. [NFS-based file storage](/docs/containers?topic=containers-file_storage#file_storage) is supported if your cluster runs Kubernetes version 1.13.4_1513, 1.12.6_1544, 1.11.8_1550, 1.10.13_1551, or later.</p>
</td>
</tr>
<tr>
<td>07 Mar 2019</td>
<td>[Cluster autoscaler moves from beta to GA](/docs/containers?topic=containers-ca#ca)</td>
<td>The cluster autoscaler is now generally available. Install the Helm plug-in and begin to scale the worker pools in your cluster automatically to increase or decrease the number of worker nodes based on the sizing needs of your scheduled workloads.<br><br>
Need help or have feedback on the cluster autoscaler? If you are an external user, [register for the public Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://bxcs-slack-invite.mybluemix.net/) and post in the [#cluster-autoscaler ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com/messages/CF6APMLBB) channel. If you are an IBMer, post in the [internal Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-argonauts.slack.com/messages/C90D3KZUL) channel.</td>
</tr>
</tbody></table>




## Popular topics in February 2019
{: #feb19}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in February 2019</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>25 February</td>
<td>More granular control over pulling images from {{site.data.keyword.registrylong_notm}}</td>
<td>When you deploy your workloads in {{site.data.keyword.containerlong_notm}} clusters, your containers can now pull images from the [new `icr.io` domain names for {{site.data.keyword.registrylong_notm}}](/docs/services/Registry?topic=registry-registry_overview#registry_regions). In addition, you can use fine-grained access policies in {{site.data.keyword.Bluemix_notm}} IAM to control access to your images. For more information, see [Understanding how your cluster is authorized to pull images](/docs/containers?topic=containers-images#cluster_registry_auth).</td>
</tr>
<tr>
<td>21 February</td>
<td>[Zone available in Mexico](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)</td>
<td>Welcome Mexico (`mex01`) as a new zone for clusters in the US South region. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall_outbound) for this zone and the other zones within the region that your cluster is in.</td>
</tr>
<tr><td>06 Feb 2019</td>
<td>[Istio on {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-istio)</td>
<td>Istio on {{site.data.keyword.containerlong_notm}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools. With one click, you can get all Istio core components, additional tracing, monitoring, and visualization, and the BookInfo sample app up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on, so {{site.data.keyword.Bluemix_notm}} automatically keeps all your Istio components up to date.</td>
</tr>
<tr>
<td>06 Feb 2019</td>
<td>[Knative on {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-knative_tutorial)</td>
<td>Knative is an open source platform that extends the capabilities of Kubernetes to help you create modern, source-centric containerized and serverless apps on top of your Kubernetes cluster. Managed Knative on {{site.data.keyword.containerlong_notm}} is a managed add-on that integrates Knative and Istio directly with your Kubernetes cluster. The Knative and Istio version in the add-on are tested by IBM and supported for the use in {{site.data.keyword.containerlong_notm}}.</td>
</tr>
</tbody></table>


## Popular topics in January 2019
{: #jan19}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in January 2019</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>30 January</td>
<td>{{site.data.keyword.Bluemix_notm}} IAM service access roles and Kubernetes namespaces</td>
<td>{{site.data.keyword.containerlong_notm}} now supports {{site.data.keyword.Bluemix_notm}} IAM [service access roles](/docs/containers?topic=containers-access_reference#service). These service access roles align with [Kubernetes RBAC](/docs/containers?topic=containers-users#role-binding) to authorize users to perform `kubectl` actions within the cluster to manage Kubernetes resources such as pods or deployments. Further, you can [limit user access to a specific Kubernetes namespace](/docs/containers?topic=containers-users#platform) within the cluster by using {{site.data.keyword.Bluemix_notm}} IAM service access roles. [Platform access roles](/docs/containers?topic=containers-access_reference#iam_platform) are now used to authorize users to perform `ibmcloud ks` actions to manage your cluster infrastructure, such as worker nodes.<br><br>{{site.data.keyword.Bluemix_notm}} IAM service access roles are automatically added to existing {{site.data.keyword.containerlong_notm}} accounts and clusters based on the permissions that your users previously had with IAM platform access roles. Going forward, you can use IAM to create access groups, add users to access groups, and assign the groups platform or service access roles. For more information, check out the blog, [Introducing service roles and namespaces in IAM for more granular control of cluster access ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2019/02/introducing-service-roles-and-namespaces-in-iam-for-more-granular-control-of-cluster-access/).</td>
</tr>
<tr>
<td>8 January</td>
<td>[Cluster autoscaler preview beta](/docs/containers?topic=containers-ca#ca)</td>
<td>Scale the worker pools in your cluster automatically to increase or decrease the number of worker nodes in the worker pool based on the sizing needs of your scheduled workloads. To test out this beta, you must request access to the whitelist.</td>
</tr>
<tr>
<td>8 January</td>
<td>[{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility)</td>
<td>Do you sometimes find it hard to get all the YAML files and other information that you need to help troubleshoot an issue? Try out the {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool for a graphical user interface that helps you gather cluster, deployment, and network information.</td>
</tr>
</tbody></table>

## Popular topics in December 2018
{: #dec18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in December 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>11 December</td>
<td>SDS support with Portworx</td>
<td>Manage persistent storage for your containerized databases and other stateful apps, or share data between pods across multiple zones with Portworx. [Portworx ![External link icon](../icons/launch-glyph.svg "External link icon")](https://portworx.com/products/introduction/) is a highly available software-defined storage solution (SDS) that manages the local block storage of your worker nodes to create a unified persistent storage layer for your apps. By using volume replication of each container-level volume across multiple worker nodes, Portworx ensures data persistence and data accessibility across zones. For more information, see [Storing data on software-defined storage (SDS) with Portworx](/docs/containers?topic=containers-portworx#portworx).    </td>
</tr>
<tr>
<td>6 December</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Gain operational visibility into the performance and health of your apps by deploying Sysdig as a third-party service to your worker nodes to forward metrics to {{site.data.keyword.monitoringlong}}. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster). **Note**: If you use {{site.data.keyword.mon_full_notm}} with clusters that run Kubernetes version 1.11 or later, not all container metrics are collected because Sysdig does not currently support `containerd`.</td>
</tr>
<tr>
<td>4 December</td>
<td>[Worker node resource reserves](/docs/containers?topic=containers-plan_clusters#resource_limit_node)</td>
<td>Are you deploying so many apps that you’re worried about exceeding your cluster capacity? Worker node resource reserves and Kubernetes evictions protect your cluster’s compute capacity so that your cluster has enough resources to keep running. Just add a few more worker nodes, and your pods start rescheduling to them automatically. Worker node resource reserves are updated in the latest [version patch changes](/docs/containers?topic=containers-changelog#changelog).</td>
</tr>
</tbody></table>

## Popular topics in November 2018
{: #nov18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in November 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>29 November</td>
<td>[Zone available in Chennai](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Welcome Chennai, India as a new zone for clusters in the AP North region. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the other zones within the region that your cluster is in.</td>
</tr>
<tr>
<td>27 November</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>Add log management capabilities to your cluster by deploying LogDNA as a third-party service to your worker nodes to manage logs from your pod containers. For more information, see [Managing Kubernetes cluster logs with {{site.data.keyword.loganalysisfull_notm}} with LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).</td>
</tr>
<tr>
<td>7 November</td>
<td>Network load balancer 2.0 (beta)</td>
<td>You now can choose between [NLB 1.0 or 2.0](/docs/containers?topic=containers-loadbalancer#planning_ipvs) to securely expose your cluster apps to the public.</td>
</tr>
<tr>
<td>7 November</td>
<td>Kubernetes version 1.12 available</td>
<td>Now, you can update or create clusters that run [Kubernetes version 1.12](/docs/containers?topic=containers-cs_versions#cs_v112)! 1.12 clusters come with highly available Kubernetes masters by default.</td>
</tr>
<tr>
<td>7 November</td>
<td>Highly available masters</td>
<td>Highly available masters are available for clusters that run Kubernetes version 1.10! All the benefits described in the earlier entry for 1.11 clusters apply to 1.10 clusters, as well as the [preparation steps](/docs/containers?topic=containers-cs_versions#110_ha-masters) that you must take.</td>
</tr>
<tr>
<td>1 November</td>
<td>Highly available masters in clusters that run Kubernetes version 1.11</td>
<td>In a single zone, your master is highly available and includes replicas on separate physical hosts for your Kubernetes API server, etcd, scheduler, and controller manager to protect against an outage such as during a cluster update. If your cluster is in a multizone-capable zone, your highly available master is also spread across zones to help protect against a zonal failure.<br>For actions that you must take, see [Updating to highly available cluster masters](/docs/containers?topic=containers-cs_versions#ha-masters). These preparation actions apply:<ul>
<li>If you have a firewall or custom Calico network policies.</li>
<li>If you are using host ports `2040` or `2041` on your worker nodes.</li>
<li>If you used the cluster master IP address for in-cluster access to the master.</li>
<li>If you have automation that calls the Calico API or CLI (`calicoctl`), such as to create Calico policies.</li>
<li>If you use Kubernetes or Calico network policies to control pod egress access to the master.</li></ul></td>
</tr>
</tbody></table>

## Popular topics in October 2018
{: #oct18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in October 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>25 October</td>
<td>[Zone available in Milan](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Welcome Milan, Italy as a new zone for paid clusters in the EU Central region. Previously, Milan was available only for free clusters. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the other zones within the region that your cluster is in.</td>
</tr>
<tr>
<td>22 October</td>
<td>[New London multizone location, `lon05`](/docs/containers?topic=containers-regions-and-zones#zones)</td>
<td>The London multizone metro location replaces `lon02` zone with the new `lon05` zone, a zone with more infrastructure resources than `lon02`. Create new multizone clusters with `lon05`. Existing clusters with `lon02` are supported, but new multizone clusters must use `lon05` instead.</td>
</tr>
<tr>
<td>05 October</td>
<td>Integration with {{site.data.keyword.keymanagementservicefull}} (beta)</td>
<td>You can encrypt the Kubernetes secrets in your cluster by [enabling {{site.data.keyword.keymanagementserviceshort}} (beta)](/docs/containers?topic=containers-encryption#keyprotect).</td>
</tr>
<tr>
<td>04 October</td>
<td>[{{site.data.keyword.registrylong}} is now integrated with {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM)](/docs/services/Registry?topic=registry-iam#iam)</td>
<td>You can use {{site.data.keyword.Bluemix_notm}} IAM to control access to your registry resources, such as pulling, pushing, and building images. When you create a cluster, you also create a registry token so that the cluster can work with your registry. Therefore, you need the account-level registry **Administrator** platform management role to create a cluster. To enable {{site.data.keyword.Bluemix_notm}} IAM for your registry account, see [Enabling policy enforcement for existing users](/docs/services/Registry?topic=registry-user#existing_users).</td>
</tr>
<tr>
<td>01 October</td>
<td>[Resource groups](/docs/containers?topic=containers-users#resource_groups)</td>
<td>You can use resource groups to separate your {{site.data.keyword.Bluemix_notm}} resources into pipelines, departments, or other groupings to help assign access and meter usage. Now, {{site.data.keyword.containerlong_notm}} supports creating clusters in the `default` group or any other resource group that you create!</td>
</tr>
</tbody></table>

## Popular topics in September 2018
{: #sept18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in September 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>25 September</td>
<td>[New zones available](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Now you have even more options of where to deploy your apps!
<ul><li>Welcome to San Jose as two new zones in the US South region, `sjc03` and `sjc04`. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the others within the region that your cluster is in.</li>
<li>With two new `tok04` and `tok05` zones, you can now [create multizone clusters](/docs/containers?topic=containers-plan_clusters#multizone) in Tokyo in the AP North region.</li></ul></td>
</tr>
<tr>
<td>05 September</td>
<td>[Zone available in Oslo](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Welcome Oslo, Norway as a new zone in the EU Central region. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the others within the region that your cluster is in.</td>
</tr>
</tbody></table>

## Popular topics in August 2018
{: #aug18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in August 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>31 August</td>
<td>{{site.data.keyword.cos_full_notm}} is now integrated with {{site.data.keyword.containerlong}}</td>
<td>Use Kubernetes-native persistent volume claims (PVC) to provision {{site.data.keyword.cos_full_notm}} to your cluster. {{site.data.keyword.cos_full_notm}} is best used for read-intensive workloads and if you want to store data across multiple zones in a multizone cluster. Start by [creating an {{site.data.keyword.cos_full_notm}} service instance](/docs/containers?topic=containers-object_storage#create_cos_service) and [installing the {{site.data.keyword.cos_full_notm}} plug-in](/docs/containers?topic=containers-object_storage#install_cos) on your cluster. </br></br>Not sure what storage solution might be the right one for you? Start [here](/docs/containers?topic=containers-storage_planning#choose_storage_solution) to analyze your data and choose the appropriate storage solution for your data. </td>
</tr>
<tr>
<td>14 August</td>
<td>Update your clusters to Kubernetes versions 1.11 to assign pod priority</td>
<td>After you update your cluster to [Kubernetes version 1.11](/docs/containers?topic=containers-cs_versions#cs_v111), you can take advantage of new capabilities, such as increased container runtime performance with `containerd` or [assigning pod priority](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
</tbody></table>

## Popular topics in July 2018
{: #july18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in July 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>30 July</td>
<td>[Bring your own Ingress controller](/docs/containers?topic=containers-ingress#user_managed)</td>
<td>Do you have very specific security or other custom requirements for your cluster's Ingress controller? If so, you might want to run your own Ingress controller instead of the default.</td>
</tr>
<tr>
<td>10 July</td>
<td>Introducing multizone clusters</td>
<td>Want to improve cluster availability? Now you can span your cluster across multiple zones in select metro areas. For more information, see [Creating multizone clusters in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-plan_clusters#multizone).</td>
</tr>
</tbody></table>

## Popular topics in June 2018
{: #june18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in June 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>13 June</td>
<td>The `bx` CLI command name is changing to `ic` CLI</td>
<td>When you download the latest version of the {{site.data.keyword.Bluemix_notm}} CLI, you now run commands by using the `ic` prefix instead of `bx`. For example, list your clusters by running `ibmcloud ks clusters`.</td>
</tr>
<tr>
<td>12 June</td>
<td>[Pod security policies](/docs/containers?topic=containers-psp)</td>
<td>For clusters that run Kubernetes 1.10.3 or later, you can
configure pod security policies to authorize who can create and update pods in {{site.data.keyword.containerlong_notm}}.</td>
</tr>
<tr>
<td>06 June</td>
<td>[TLS support for the IBM-provided Ingress wildcard subdomain](/docs/containers?topic=containers-ingress#wildcard_tls)</td>
<td>For clusters created on or after 6 June 2018, the IBM-provided Ingress subdomain TLS certificate is now a wildcard certificate and can be used for the registered wildcard subdomain. For clusters created before 6 June 2018, TLS certificate will be updated to a wildcard certificate when the current TLS certificate is renewed.</td>
</tr>
</tbody></table>

## Popular topics in May 2018
{: #may18}


<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in May 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>24 May</td>
<td>[New Ingress subdomain format](/docs/containers?topic=containers-ingress)</td>
<td>Clusters created after 24 May are assigned an Ingress subdomain in a new format: <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>. When you use Ingress to expose your apps, you can use the new subdomain to access your apps from the internet.</td>
</tr>
<tr>
<td>14 May</td>
<td>[Update: Deploy workloads on GPU bare metal worldwide](/docs/containers?topic=containers-app#gpu_app)</td>
<td>If you have a [bare metal graphics processing unit (GPU) machine type](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node) in your cluster, you can schedule mathematically intensive apps. The GPU worker node can process your app's workload across both the CPU and GPU to increase performance.</td>
</tr>
<tr>
<td>03 May</td>
<td>[Container Image Security Enforcement (beta)](/docs/services/Registry?topic=registry-security_enforce#security_enforce)</td>
<td>Does your team need a little extra help to know which image to pull in your app containers? Try out the Container Image Security Enforcement beta to verify container images before you deploy them. Available for clusters that run Kubernetes 1.9 or later.</td>
</tr>
<tr>
<td>01 May</td>
<td>[Deploy the Kubernetes dashboard from the console](/docs/containers?topic=containers-app#cli_dashboard)</td>
<td>Did you ever want to access the Kubernetes dashboard with one click? Check out the **Kubernetes Dashboard** button in the {{site.data.keyword.Bluemix_notm}} console.</td>
</tr>
</tbody></table>




## Popular topics in April 2018
{: #apr18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in April 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>17 April</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>Install the {{site.data.keyword.Bluemix_notm}} Block Storage [plug-in](/docs/containers?topic=containers-block_storage#install_block) to save persistent data in block storage. Then, you can [create new](/docs/containers?topic=containers-block_storage#add_block) or [use existing](/docs/containers?topic=containers-block_storage#existing_block) block storage for your cluster.</td>
</tr>
<tr>
<td>13 April</td>
<td>[New tutorial to migrate Cloud Foundry apps to clusters](/docs/containers?topic=containers-cf_tutorial#cf_tutorial)</td>
<td>Do you have a Cloud Foundry app? Learn how to deploy the same code from that app to a container that runs in a Kubernetes cluster.</td>
</tr>
<tr>
<td>05 April</td>
<td>[Filtering logs](/docs/containers?topic=containers-health#filter-logs)</td>
<td>Filter out specific logs from being forwarded. Logs can be filtered out for a specific namespace, container name, log level, and message string.</td>
</tr>
</tbody></table>

## Popular topics in March 2018
{: #mar18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in March 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>16 March</td>
<td>[Provision a bare metal cluster with Trusted Compute](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)</td>
<td>Create a bare metal cluster that runs [Kubernetes version 1.9](/docs/containers?topic=containers-cs_versions#cs_v19) or later, and enable Trusted Compute to verify your worker nodes against tampering.</td>
</tr>
<tr>
<td>14 March</td>
<td>[Secure sign-in with {{site.data.keyword.appid_full}}](/docs/containers?topic=containers-supported_integrations#appid)</td>
<td>Enhance your apps that are running in {{site.data.keyword.containerlong_notm}} by requiring users to sign in.</td>
</tr>
<tr>
<td>13 March</td>
<td>[Zone available in São Paulo](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Welcome São Paulo, Brazil as a new zone in the US South region. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the others within the region that your cluster is in.</td>
</tr>
</tbody></table>

## Popular topics in February 2018
{: #feb18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in February 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>27 February</td>
<td>Hardware virtual machine (HVM) images for worker nodes</td>
<td>Increase the I/O performance of your workloads with HVM images. Activate on each existing worker node by using the `ibmcloud ks worker-reload` [command](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) or the `ibmcloud ks worker-update` [command](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update).</td>
</tr>
<tr>
<td>26 February</td>
<td>[KubeDNS autoscaling](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS now scales with your cluster as it grows. You can adjust the scaling rations by using the following command: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 February</td>
<td>View the web console for [logging](/docs/containers?topic=containers-health#view_logs) and [metrics](/docs/containers?topic=containers-health#view_metrics)</td>
<td>Easily view log and metric data on your cluster and its components with an improved web UI. See your cluster detail page for access.</td>
</tr>
<tr>
<td>20 February</td>
<td>Encrypted images and [signed, trusted content](/docs/services/Registry?topic=registry-registry_trustedcontent#registry_trustedcontent)</td>
<td>In {{site.data.keyword.registryshort_notm}}, you can sign and encrypt images to ensure their integrity when you store the images in your registry namespace. Run your container instances by using only trusted content.</td>
</tr>
<tr>
<td>19 February</td>
<td>[Set up the strongSwan IPSec VPN](/docs/containers?topic=containers-vpn#vpn-setup)</td>
<td>Quickly deploy the strongSwan IPSec VPN Helm chart to connect your {{site.data.keyword.containerlong_notm}} cluster securely to your on-premises data center without a Virtual Router Appliance.</td>
</tr>
<tr>
<td>14 February</td>
<td>[Zone available in Seoul](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Just in time for the Olympics, deploy a Kubernetes cluster to Seoul in the AP North region. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for this zone and the others within the region that your cluster is in.</td>
</tr>
<tr>
<td>08 February</td>
<td>[Update Kubernetes 1.9](/docs/containers?topic=containers-cs_versions#cs_v19)</td>
<td>Review the changes to make to your clusters before you update to Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Popular topics in January 2018
{: #jan18}

<table summary="The table shows popular topics. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Popular topics for containers and Kubernetes clusters in January 2018</caption>
<thead>
<th>Date</th>
<th>Title</th>
<th>Description</th>
</thead>
<tbody>
<td>25 January</td>
<td>[Global registry available](/docs/services/Registry?topic=registry-registry_overview#registry_regions)</td>
<td>With the {{site.data.keyword.registryshort_notm}}, you can use the global `registry.bluemix.net` to pull IBM-provided public images.</td>
</tr>
<tr>
<td>23 January</td>
<td>[Zones available in Singapore and Montreal, CA](/docs/containers?topic=containers-regions-and-zones)</td>
<td>Singapore and Montreal are zones available in the {{site.data.keyword.containerlong_notm}} AP North and US East regions. If you have a firewall, be sure to [open the firewall ports](/docs/containers?topic=containers-firewall#firewall) for these zones and the others within the region that your cluster is in.</td>
</tr>
<tr>
<td>08 January</td>
<td>[Enhanced flavors available](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)</td>
<td>Series 2 virtual machine types include local SSD storage and disk encryption. [Move your workloads](/docs/containers?topic=containers-update#machine_type) to these flavors for improved performance and stability.</td>
</tr>
</tbody></table>

## Chat with like-minded developers on Slack
{: #slack}

You can see what others are talking about and ask your own questions in the [{{site.data.keyword.containerlong_notm}} Slack. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com)
{:shortdesc}

If you are not using an IBM ID for your {{site.data.keyword.Bluemix_notm}} account, [request an invitation](https://bxcs-slack-invite.mybluemix.net/) to this Slack.
{: tip}
