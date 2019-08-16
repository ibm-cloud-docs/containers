---

copyright:
  years: 2017, 2019
lastupdated: "2019-08-16"

keywords: kubernetes, iks, audit

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

# {{site.data.keyword.at_full_notm}} events
{: #at_events}

You can view, manage, and audit user-initiated activities in your {{site.data.keyword.containerlong}} community Kubernetes or OpenShift cluster by using the {{site.data.keyword.at_full}} service.
{: shortdesc}

{{site.data.keyword.containershort_notm}} automatically generates cluster management events and forwards these event logs to {{site.data.keyword.at_full_notm}}. To access these logs, you must [provision an instance of {{site.data.keyword.at_full_notm}}](/docs/services/Activity-Tracker-with-LogDNA?topic=logdnaat-getting-started).

Previously, you could collect and forward audit logs to {{site.data.keyword.cloudaccesstrailfull_notm}} with LogAnalysis. As of 30 April 2019, you cannot provision new {{site.data.keyword.loganalysisshort_notm}} instances, and all Lite plan instances are deleted. Existing premium plan instances are supported until 30 September 2019. To continue collecting audit logs for your cluster, you must set up {{site.data.keyword.at_full_notm}}.
{: deprecated}

## Tracking cluster management events
{: #cluster-events}

The following list of the cluster management events are sent to {{site.data.keyword.at_full_notm}}.
{: shortdesc}

<table>
<tr>
<th>Action</th>
<th>Description</th></tr><tr>
<td><code>containers-kubernetes.account-credentials.set</code></td>
<td>Infrastructure credentials in a region for a resource group are set.</td></tr><tr>
<td><code>containers-kubernetes.account-credentials.unset</code></td>
<td>Infrastructure credentials in a region for a resource group are unset.</td></tr><tr>
<td><code>containers-kubernetes.alb.create</code></td>
<td>An Ingress ALB is created.</td></tr><tr>
<td><code>containers-kubernetes.alb.delete</code></td>
<td>An Ingress ALB is deleted.</td></tr><tr>
<td><code>containers-kubernetes.alb.get</code></td>
<td>Ingress ALB information is viewed.</td></tr><tr>
<td><code>containers-kubernetes.apikey.reset</code></td>
<td>An API key is reset for a region and resource group.</td></tr><tr>
<td><code>containers-kubernetes.cluster.create</code></td>
<td>A cluster is created.</td></tr><tr>
<td><code>containers-kubernetes.cluster.delete</code></td>
<td>A cluster is deleted.</td></tr><tr>
<td><code>containers-kubernetes.cluster-feature.enable</code></td>
<td>A feature, such as the public or private service endpoint, is enabled on a cluster.</td></tr><tr>
<td><code>containers-kubernetes.cluster.get</code></td>
<td>Cluster information is viewed.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.create</code></td>
<td>A log forwarding configuration is created.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.delete</code></td>
<td>A log forwarding configuration is deleted.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.get</code></td>
<td>Information for a log forwarding configuration is viewed.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.update</code></td>
<td>A log forwarding configuration is updated.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.refresh</code></td>
<td>A log forwarding configuration is refreshed.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.create</code></td>
<td>A logging filter is created.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.delete</code></td>
<td>A logging filter is deleted.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.get</code></td>
<td>Information for a logging filter is viewed.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.update</code></td>
<td>A logging filter is updated.</td></tr><tr>
<td><code>containers-kubernetes.logging-autoupdate.changed</code></td>
<td>The logging add-on auto updater is enabled or disabled.</td></tr><tr>
<td><code>containers-kubernetes.mzlb.create</code></td>
<td>A multizone load balancer is created.</td></tr><tr>
<td><code>containers-kubernetes.mzlb.delete</code></td>
<td>A multizone load balancer is deleted.</td></tr><tr>
<td><code>containers-kubernetes.service.bind</code></td>
<td>A service is bound to a cluster.</td></tr><tr>
<td><code>containers-kubernetes.service.unbind</code></td>
<td>A service is unbound from a cluster.</td></tr><tr>
<td><code>containers-kubernetes.subnet.add</code></td>
<td>An existing IBM Cloud infrastructure subnet is added to a cluster.</td></tr><tr>
<td><code>containers-kubernetes.subnet.create</code></td>
<td>A subnet is created.</td></tr><tr>
<td><code>containers-kubernetes.usersubnet.add</code></td>
<td>A user-managed subnet is added to a cluster.</td></tr><tr>
<td><code>containers-kubernetes.usersubnet.delete</code></td>
<td>A user-managed subnet is removed from a cluster.</td></tr><tr>
<td><code>containers-kubernetes.version.update</code></td>
<td>The Kubernetes version of a cluster master node is updated.</td></tr><tr>
<td><code>containers-kubernetes.worker.create</code></td>
<td>A worker node is created.</td></tr><tr>
<td><code>containers-kubernetes.worker.delete</code></td>
<td>A worker node is deleted.</td></tr><tr>
<td><code>containers-kubernetes.worker.get</code></td>
<td>Information for a worker node is viewed.</td></tr><tr>
<td><code>containers-kubernetes.worker.reboot</code></td>
<td>A worker node is rebooted.</td></tr><tr>
<td><code>containers-kubernetes.worker.reload</code></td>
<td>A worker node is reloaded.</td></tr><tr>
<td><code>containers-kubernetes.worker.update</code></td>
<td>A worker node is updated.</td></tr>
</table>
