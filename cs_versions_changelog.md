---

copyright:
  years: 2014, 2019
lastupdated: "2019-01-29"

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



# Version changelog
{: #changelog}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} Kubernetes clusters. Changes include updates to Kubernetes and {{site.data.keyword.Bluemix_notm}} Provider components.
{:shortdesc}

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers/cs_versions.html). 
{: tip}

For information about changes since the previous version, see the following changelogs.
-  Version 1.12 [changelog](#112_changelog).
-  Version 1.11 [changelog](#111_changelog).
-  Version 1.10 [changelog](#110_changelog).
-  [Archive](#changelog_archive) of changelogs for deprecated or unsupported versions.

Some changelogs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers/cs_cli_reference.html#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other changelogs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers/cs_cli_reference.html#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers/cs_versions.html#update_types).
{: note}

</br>

## Version 1.12 changelog
{: #112_changelog}

Review the version 1.12 changelog. 
{: shortdesc}

### Changelog for worker node fix pack 1.12.4_1535, released 28 January 2019
{: #1124_1535}

The following table shows the changes that are included in the worker node fix pack 1.12.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1534">
<caption>Changes since version 1.12.4_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.4_1534, released 21 January 2019
{: #1124_1534}

The following table shows the changes that are included in the patch 1.12.3_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1533">
<caption>Changes since version 1.12.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.12.3-91</td>
<td>v1.12.4-118</td>
<td>Updated to support the Kubernetes 1.12.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.3</td>
<td>v1.12.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.4).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.3_1533, released 7 January 2019
{: #1123_1533}

The following table shows the changes that are included in the worker node fix pack 1.12.3_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1532">
<caption>Changes since version 1.12.3_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.3_1532, released 17 December 2018
{: #1123_1532}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1531">
<caption>Changes since version 1.12.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.3_1531, released 5 December 2018
{: #1123_1531}

The following table shows the changes that are included in the patch 1.12.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1530">
<caption>Changes since version 1.12.2_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.12.2-68</td>
<td>v1.12.3-91</td>
<td>Updated to support the Kubernetes 1.12.3 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.2</td>
<td>v1.12.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.3). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.2_1530, released 4 December 2018
{: #1122_1530}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1529">
<caption>Changes since version 1.12.2_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers/cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>



### Changelog for 1.12.2_1529, released 27 November 2018
{: #1122_1529}

The following table shows the changes that are included in patch 1.12.2_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1528">
<caption>Changes since version 1.12.2_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.3/releases/#v331). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that could result in both Kubernetes DNS and CoreDNS pods to run after cluster creation or update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.0</td>
<td>v1.1.5</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Updated containerd to fix a deadlock that can [stop pods from terminating ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.2_1528, released 19 November 2018
{: #1122_1528}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1528. 
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1527">
<caption>Changes since version 1.12.2_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.2_1527, released 7 November 2018
{: #1122_1527}

The following table shows the changes that are included in patch 1.12.2_1527. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-*` pods in the `kube-system` namespace now set CPU and memory resource requests for all containers.</td>
</tr>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes DNS (KubeDNS) remains the default cluster DNS provider. However, you now have the option to [change the cluster DNS provide to CoreDNS](/docs/containers/cs_cluster_update.html#dns).</td>
</tr>
<tr>
<td>Cluster metrics provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes Metrics Server replaces Kubernetes Heapster (deprecated since Kubernetes version 1.8) as the cluster metrics provider. For action items, see [the `metrics-server` preparation action](/docs/containers/cs_versions.html#metrics-server).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.4</td>
<td>1.2.0</td>
<td>See the [containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.0).</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>N/A</td>
<td>1.2.2</td>
<td>See the [CoreDNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coredns/coredns/releases/tag/v1.2.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.12.2</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added three new IBM pod security policies and their associated cluster roles. For more information, see [Understanding default resources for IBM cluster management](/docs/containers/cs_psp.html#ibm_psp).</td>
</tr>
<tr>
<td>Kubernetes Dashboard</td>
<td>v1.8.3</td>
<td>v1.10.0</td>
<td>See the [Kubernetes Dashboard release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.0).<br><br>
If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers/cs_app.html#cli_dashboard). Additionally, you can now scale up the number of Kubernetes Dashboard pods by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the [Kubernetes DNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.13).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>N/A</td>
<td>v0.3.1</td>
<td>See the [Kubernetes Metrics Server release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.3.1).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-118</td>
<td>v1.12.2-68</td>
<td>Updated to support the Kubernetes 1.12 release. Additional changes include the following:
<ul><li>Load balancer pods (`ibm-cloud-provider-ip-*` in `ibm-system` namespace) now set CPU and memory resource requests.</li>
<li>The `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation is added to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlans --zone <zone>`.</li>
<li>A new [load balancer 2.0](/docs/containers/cs_loadbalancer.html#planning_ipvs) is available as a beta.</li></ul></td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>OpenVPN client `vpn-* pod` in the `kube-system` namespace now sets CPU and memory resource requests.</td>
</tr>
</tbody>
</table>

## Version 1.11 changelog
{: #111_changelog}

Review the version 1.11 changelog.

### Changelog for worker node fix pack 1.11.6_1541, released 28 January 2019
{: #1116_1541}

The following table shows the changes that are included in the worker node fix pack 1.11.6_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.11.6_1540">
<caption>Changes since version 1.11.6_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) / [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.6_1540, released 21 January 2019
{: #1116_1540}

The following table shows the changes that are included in the patch 1.11.6_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1539">
<caption>Changes since version 1.11.5_1539</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.5-152</td>
<td>v1.11.6-180</td>
<td>Updated to support the Kubernetes 1.11.6 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.5</td>
<td>v1.11.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.6).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).<br><br>If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers/cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.5_1539, released 7 January 2019
{: #1115_1539}

The following table shows the changes that are included in the worker node fix pack 1.11.5_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1538">
<caption>Changes since version 1.11.5_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.5_1538, released 17 December 2018
{: #1115_1538}

The following table shows the changes that are included in the worker node fix pack 1.11.5_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1537">
<caption>Changes since version 1.11.5_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.5_1537, released 5 December 2018
{: #1115_1537}

The following table shows the changes that are included in the patch 1.11.5_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1536">
<caption>Changes since version 1.11.4_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.4-142</td>
<td>v1.11.5-152</td>
<td>Updated to support the Kubernetes 1.11.5 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.4</td>
<td>v1.11.5</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.5). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.4_1536, released 4 December 2018
{: #1114_1536}

The following table shows the changes that are included in the worker node fix pack 1.11.4_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1535">
<caption>Changes since version 1.11.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers/cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.4_1535, released 27 November 2018
{: #1114_1535}

The following table shows the changes that are included in patch 1.11.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1534">
<caption>Changes since version 1.11.3_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.3/releases/#v331). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.1.4</td>
<td>v1.1.5</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Updated containerd to fix a deadlock that can [stop pods from terminating ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-127</td>
<td>v1.11.4-142</td>
<td>Updated to support the Kubernetes 1.11.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.11.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.4).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1534, released 19 November 2018
{: #1113_1534}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1534. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


### Changelog for 1.11.3_1533, released 7 November 2018
{: #1113_1533}

The following table shows the changes that are included in patch 1.11.3_1533. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1531">
<caption>Changes since version 1.11.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed the update to highly available (HA) masters for clusters that use admission webhooks such as `initializerconfigurations`, `mutatingwebhookconfigurations`, or `validatingwebhookconfigurations`. You might use these webhooks with Helm charts such as for [Container Image Security Enforcement](/docs/services/Registry/registry_security_enforce.html#security_enforce).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-100</td>
<td>v1.11.3-127</td>
<td>Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlans --zone <zone>`.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers/cs_cli_reference.html#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks machine-types --zone` [command](/docs/containers/cs_cli_reference.html#cs_machine_types).</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.11.3_1531, released 1 November 2018
{: #1113_1531_ha-master}

The following table shows the changes that are included in the master fix pack 1.11.3_1531. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1527">
<caption>Changes since version 1.11.3_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. Further, if your cluster is in a multizone-capable zone, the masters are spread across zones.<br>For actions that you must take, see [Updating to highly available cluster masters](/docs/containers/cs_versions.html#ha-masters). These preparation actions apply:<ul>
<li>If you have a firewall or custom Calico network policies.</li>
<li>If you are using host ports `2040` or `2041` on your worker nodes.</li>
<li>If you used the cluster master IP address for in-cluster access to the master.</li>
<li>If you have automation that calls the Calico API or CLI (`calicoctl`), such as to create Calico policies.</li>
<li>If you use Kubernetes or Calico network policies to control pod egress access to the master.</li></ul></td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the [etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coreos/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers/cs_encrypt.html#keyprotect).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1531, released 26 October 2018
{: #1113_1531}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1531. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1525">
<caption>Changes since version 1.11.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.11.3_1527, released 15 October 2018
{: #1113_1527}

The following table shows the changes that are included in the master fix pack 1.11.3_1527. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed `calico-node` container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1525, released 10 October 2018
{: #1113_1525}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1525. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.11.3_1524, released 2 October 2018
{: #1113_1524}

The following table shows the changes that are included in patch 1.11.3_1524. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1521">
<caption>Changes since version 1.11.3_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>See the [containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.4).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to change the default storage class, run `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` and replace `<storageclass>` with the name of the storage class.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.3_1521, released 20 September 2018
{: #1113_1521}

The following table shows the changes that are included in patch 1.11.3_1521. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1516">
<caption>Changes since version 1.11.2_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Updated to support Kubernetes 1.11.3 release.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains `ibmc-file-bronze`. If you want to change the default storage class, run `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` and replace `<storageclass>` with the name of the storage class.</td>
</tr>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes key management service (KMS) provider in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} in your cluster](/docs/containers/cs_encrypt.html#keyprotect), all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.2</td>
<td>v1.11.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker-reload` [command](/docs/containers/cs_cli_reference.html#cs_worker_reload) or the `ibmcloud ks worker-update` [command](/docs/containers/cs_cli_reference.html#cs_worker_update).</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers/cs_cli_reference.html#cs_worker_update) or [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `containerd`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.2_1516, released 4 September 2018
{: #1112_1516}

The following table shows the changes that are included in patch 1.11.2_1516. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1514">
<caption>Changes since version 1.11.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>See the [`containerd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.3).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.2-60</td>
<td>v1.11.2-71</td>
<td>Changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>IBM file storage plug-in configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure (SoftLayer) NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers/cs_storage_file.html#nfs_version_class).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.2_1514, released 23 August 2018
{: #1112_1514}

The following table shows the changes that are included in the worker node fix pack 1.11.2_1514. 
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1513">
<caption>Changes since version 1.11.2_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.2_1513, released 14 August 2018
{: #1112_1513}

The following table shows the changes that are included in patch 1.11.2_1513. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>N/A</td>
<td>1.1.2</td>
<td>`containerd` replaces Docker as the new container runtime for Kubernetes. See the [`containerd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.2). For actions that you must take, see [Updating to `containerd` as the container runtime](/docs/containers/cs_versions.html#containerd).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>`containerd` replaces Docker as the new container runtime for Kubernetes, to enhance performance. For actions that you must take, see [Updating to `containerd` as the container runtime](/docs/containers/cs_versions.html#containerd).</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.14</td>
<td>v3.2.18</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coreos/etcd/releases/v3.2.18).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.11.2-60</td>
<td>Updated to support Kubernetes 1.11 release. In addition, load balancer pods now use the new `ibm-app-cluster-critical` pod priority class.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated `incubator` version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance labels, unless you are using a multizone cluster and need to [add the region the zone labels](/docs/containers/cs_storage_basics.html#multizone).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.11.2</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the OpenID Connect configuration for the cluster's Kubernetes API server to support {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) access groups. Added `Priority` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod priority. For more information, see:
<ul><li>[{{site.data.keyword.Bluemix_notm}} IAM access groups](/docs/containers/cs_users.html#rbac)</li>
<li>[Configuring pod priority](/docs/containers/cs_pod_priority.html#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.2</td>
<td>v.1.5.4</td>
<td>Increased resource limits for the `heapster-nanny` container. See the [Kubernetes Heapster release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/heapster/releases/tag/v1.5.4).</td>
</tr>
<tr>
<td>Logging configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The container log directory is now `/var/log/pods/` instead of the previous `/var/lib/docker/containers/`.</td>
</tr>
</tbody>
</table>

<br />


## Version 1.10 changelog
{: #110_changelog}

Review the version 1.10 changelog.

### Changelog for worker node fix pack 1.10.12_1541, released 28 January 2019
{: #11012_1541}

The following table shows the changes that are included in the worker node fix pack 1.10.12_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1540">
<caption>Changes since version 1.10.12_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.12_1540, released 21 January 2019
{: #11012_1540}

The following table shows the changes that are included in the patch 1.10.12_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1538">
<caption>Changes since version 1.10.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.11-219</td>
<td>v1.10.12-252</td>
<td>Updated to support the Kubernetes 1.10.12 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.11</td>
<td>v1.10.12</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.12).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).<br><br>If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers/cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.11_1538, released 7 January 2019
{: #11011_1538}

The following table shows the changes that are included in the worker node fix pack 1.10.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1537">
<caption>Changes since version 1.10.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.11_1537, released 17 December 2018
{: #11011_1537}

The following table shows the changes that are included in the worker node fix pack 1.10.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1536">
<caption>Changes since version 1.10.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


### Changelog for 1.10.11_1536, released 4 December 2018
{: #11011_1536}

The following table shows the changes that are included in patch 1.10.11_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1532">
<caption>Changes since version 1.10.8_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.3/releases/#v331). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.8-197</td>
<td>v1.10.11-219</td>
<td>Updated to support the Kubernetes 1.10.11 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.8</td>
<td>v1.10.11</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.11). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers/cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1532, released 27 November 2018
{: #1108_1532}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1531">
<caption>Changes since version 1.10.8_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the [Docker release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1531, released 19 November 2018
{: #1108_1531}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1531. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1530">
<caption>Changes since version 1.10.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.8_1530, released 7 November 2018
{: #1108_1530_ha-master}

The following table shows the changes that are included in patch 1.10.8_1530. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1528">
<caption>Changes since version 1.10.8_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. Further, if your cluster is in a multizone-capable zone, the masters are spread across zones.<br>For actions that you must take, see [Updating to highly available cluster masters](/docs/containers/cs_versions.html#ha-masters). These preparation actions apply:<ul>
<li>If you have a firewall or custom Calico network policies.</li>
<li>If you are using host ports `2040` or `2041` on your worker nodes.</li>
<li>If you used the cluster master IP address for in-cluster access to the master.</li>
<li>If you have automation that calls the Calico API or CLI (`calicoctl`), such as to create Calico policies.</li>
<li>If you use Kubernetes or Calico network policies to control pod egress access to the master.</li></ul></td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the [etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coreos/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers/cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.8-172</td>
<td>v1.10.8-197</td>
<td>Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlans --zone <zone>`.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers/cs_cli_reference.html#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks machine-types --zone` [command](/docs/containers/cs_cli_reference.html#cs_machine_types).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1528, released 26 October 2018
{: #1108_1528}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1528. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1527">
<caption>Changes since version 1.10.8_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.10.8_1527, released 15 October 2018
{: #1108_1527}

The following table shows the changes that are included in the master fix pack 1.10.8_1527. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed `calico-node` container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1525, released 10 October 2018
{: #1108_1525}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1525. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.10.8_1524, released 2 October 2018
{: #1108_1524}

The following table shows the changes that are included in patch 1.10.8_1524. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes key management service (KMS) provider in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} in your cluster](/docs/containers/cs_encrypt.html#keyprotect), all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.7</td>
<td>v1.10.8</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the [Kubernetes DNS autoscaler release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Updated to support Kubernetes 1.10.8 release. Also, updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to change the default storage class, run `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` and replace `<storageclass>` with the name of the storage class.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.7_1521, released 20 September 2018
{: #1107_1521}

The following table shows the changes that are included in the worker node fix pack 1.10.7_1521. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker-reload` [command](/docs/containers/cs_cli_reference.html#cs_worker_reload) or the `ibmcloud ks worker-update` [command](/docs/containers/cs_cli_reference.html#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers/cs_cli_reference.html#cs_worker_update) or [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run `docker build . --network host`.</li>
<li>To explicitly create a network to use when you build the container, run `docker network create` and then use this network.</li></ul>
**Note**: Have dependencies on the Docker socket or Docker directly? [Update to `containerd` instead of `docker` as the container runtime](/docs/containers/cs_versions.html#containerd) so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.7_1520, released 4 September 2018
{: #1107_1520}

The following table shows the changes that are included in patch 1.10.7_1520. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1519">
<caption>Changes since version 1.10.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.10.7-146</td>
<td>Updated to support Kubernetes 1.10.7 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br> Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure (SoftLayer) NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers/cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.10.7</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7).</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the `heapster-nanny` container.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.5_1519, released 23 August 2018
{: #1105_1519}

The following table shows the changes that are included in the worker node fix pack 1.10.5_1519. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.10.5_1518, released 13 August 2018
{: #1105_1518}

The following table shows the changes that are included in the worker node fix pack 1.10.5_1518. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1517">
<caption>Changes since version 1.10.5_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.5_1517, released 27 July 2018
{: #1105_1517}

The following table shows the changes that are included in patch 1.10.5_1517. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1514">
<caption>Changes since version 1.10.3_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Updated to support Kubernetes 1.10.5 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure (SoftLayer) account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.3_1514, released 3 July 2018
{: #1103_1514}

The following table shows the changes that are included in the worker node fix pack 1.10.3_1514. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1513">
<caption>Changes since version 1.10.3_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.10.3_1513, released 21 June 2018
{: #1103_1513}

The following table shows the changes that are included in the worker node fix pack 1.10.3_1513. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1512">
<caption>Changes since version 1.10.3_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted machine types, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.3_1512, released 12 June 2018
{: #1103_1512}

The following table shows the changes that are included in patch 1.10.3_1512. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1510">
<caption>Changes since version 1.10.1_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `PodSecurityPolicy` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers/cs_psp.html).</td>
</tr>
<tr>
<td>Kubelet Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `--authentication-token-webhook` option to support API bearer and service account tokens for authenticating to the `kubelet` HTTPS endpoint.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Updated to support Kubernetes 1.10.3 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `livenessProbe` to the OpenVPN client `vpn` deployment that runs in the `kube-system` namespace.</td>
</tr>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Changelog for worker node fix pack 1.10.1_1510, released 18 May 2018
{: #1101_1510}

The following table shows the changes that are included in the worker node fix pack 1.10.1_1510. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1509">
<caption>Changes since version 1.10.1_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.1_1509, released 16 May 2018
{: #1101_1509}

The following table shows the changes that are included in the worker node fix pack 1.10.1_1509. 
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1508">
<caption>Changes since version 1.10.1_1508</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.1_1508, released 01 May 2018
{: #1101_1508}

The following table shows the changes that are included in patch 1.10.1_1508. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>See the Kubernetes Heapster [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>StorageObjectInUseProtection</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>See the Kubernetes DNS [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Updated to support Kubernetes 1.10 release.</td>
</tr>
<tr>
<td>GPU support</td>
<td>N/A</td>
<td>N/A</td>
<td>Support for [graphics processing unit (GPU) container workloads](/docs/containers/cs_app.html#gpu_app) is now available for scheduling and execution. For a list of available GPU machine types, see [Hardware for worker nodes](/docs/containers/cs_clusters_planning.html#shared_dedicated_node). For more information, see the Kubernetes documentation to [Schedule GPUs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

<br />


## Archive
{: #changelog_archive}

Unsupported Kubernetes versions:
*  [Version 1.9](#19_changelog)
*  [Version 1.8](#18_changelog)
*  [Version 1.7](#17_changelog)

### Version 1.9 changelog (unsupported as of 27 December 2018)
{: #19_changelog}

Review the version 1.9 changelog.

### Changelog for worker node fix pack 1.9.11_1539, released 17 December 2018
{: #1911_1539}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1538">
<caption>Changes since version 1.9.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.11_1538, released 4 December 2018
{: #1911_1538}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1537">
<caption>Changes since version 1.9.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers/cs_clusters_planning.html#resource_limit_node).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.11_1537, released 27 November 2018
{: #1911_1537}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1536">
<caption>Changes since version 1.9.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the [Docker release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.11_1536, released 19 November 2018
{: #1911_1536}

The following table shows the changes that are included in patch 1.9.11_1536. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1532">
<caption>Changes since version 1.9.10_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v2.6.12</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/v2.6/releases/#v2612). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.10</td>
<td>v1.9.11</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.11).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.10-219</td>
<td>v1.9.11-249</td>
<td>Updated to support the Kubernetes 1.9.11 release.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r2</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix 1.9.10_1532, released 7 November 2018
{: #1910_1532}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1532. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1531">
<caption>Changes since version 1.9.10_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers/cs_cli_reference.html#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks machine-types --zone` [command](/docs/containers/cs_cli_reference.html#cs_machine_types).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1531, released 26 October 2018
{: #1910_1531}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1531. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1530">
<caption>Changes since version 1.9.10_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.9.10_1530 released 15 October 2018
{: #1910_1530}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1530. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1528, released 10 October 2018
{: #1910_1528}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1528. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.9.10_1527, released 2 October 2018
{: #1910_1527}

The following table shows the changes that are included in patch 1.9.10_1527. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.10-192</td>
<td>v1.9.10-219</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to change the default storage class, run `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` and replace `<storageclass>` with the name of the storage class.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1524, released 20 September 2018
{: #1910_1524}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1524. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker-reload` [command](/docs/containers/cs_cli_reference.html#cs_worker_reload) or the `ibmcloud ks worker-update` [command](/docs/containers/cs_cli_reference.html#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers/cs_cli_reference.html#cs_worker_update) or [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run `docker build . --network host`.</li>
<li>To explicitly create a network to use when you build the container, run `docker network create` and then use this network.</li></ul>
**Note**: Have dependencies on the Docker socket or Docker directly? [Update to `containerd` instead of `docker` as the container runtime](/docs/containers/cs_versions.html#containerd) so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.10_1523, released 4 September 2018
{: #1910_1523}

The following table shows the changes that are included in patch 1.9.10_1523. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1522">
<caption>Changes since version 1.9.9_1522</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.9-167</td>
<td>v1.9.10-192</td>
<td>Updated to support Kubernetes 1.9.10 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure (SoftLayer) NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers/cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.9</td>
<td>v1.9.10</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10).</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the `heapster-nanny` container.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.9_1522, released 23 August 2018
{: #199_1522}

The following table shows the changes that are included in the worker node fix pack 1.9.9_1522. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1521">
<caption>Changes since version 1.9.9_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.9_1521, released 13 August 2018
{: #199_1521}

The following table shows the changes that are included in the worker node fix pack 1.9.9_1521. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1520">
<caption>Changes since version 1.9.9_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.9_1520, released 27 July 2018
{: #199_1520}

The following table shows the changes that are included in patch 1.9.9_1520. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1517">
<caption>Changes since version 1.9.8_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Updated to support Kubernetes 1.9.9 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure (SoftLayer) account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.8_1517, released 3 July 2018
{: #198_1517}

The following table shows the changes that are included in the worker node fix pack 1.9.8_1517. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1516">
<caption>Changes since version 1.9.8_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.8_1516, released 21 June 2018
{: #198_1516}

The following table shows the changes that are included in the worker node fix pack 1.9.8_1516. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1515">
<caption>Changes since version 1.9.8_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted machine types, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.8_1515, released 19 June 2018
{: #198_1515}

The following table shows the changes that are included in patch 1.9.8_1515. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1513">
<caption>Changes since version 1.9.7_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added PodSecurityPolicy to the --admission-control option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers/cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Updated to support Kubernetes 1.9.8 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.7_1513, released 11 June 2018
{: #197_1513}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1513. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1512">
<caption>Changes since version 1.9.7_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.7_1512, released 18 May 2018
{: #197_1512}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1512. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1511">
<caption>Changes since version 1.9.7_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.7_1511, released 16 May 2018
{: #197_1511}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1511. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.7_1510, released 30 April 2018
{: #197_1510}

The following table shows the changes that are included in patch 1.9.7_1510. 
{: shortdesc}

<table summary="Changes that were made since version 1.9.3_1506">
<caption>Changes since version 1.9.3_1506</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p><strong>Note</strong>: Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `admissionregistration.k8s.io/v1alpha1=true` to the `--runtime-config` option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers/cs_loadbalancer.html#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers/cs_edge.html#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.8 changelog (Unsupported)
{: #18_changelog}

Review the following changes.

### Changelog for worker node fix pack 1.8.15_1521, released 20 September 2018
{: #1815_1521}

<table summary="Changes that were made since version 1.8.15_1520">
<caption>Changes since version 1.8.15_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker-reload` [command](/docs/containers/cs_cli_reference.html#cs_worker_reload) or the `ibmcloud ks worker-update` [command](/docs/containers/cs_cli_reference.html#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers/cs_cli_reference.html#cs_worker_update) or [reload](/docs/containers/cs_cli_reference.html#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.15_1520, released 23 August 2018
{: #1815_1520}

<table summary="Changes that were made since version 1.8.15_1519">
<caption>Changes since version 1.8.15_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.15_1519, released 13 August 2018
{: #1815_1519}

<table summary="Changes that were made since version 1.8.15_1518">
<caption>Changes since version 1.8.15_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.8.15_1518, released 27 July 2018
{: #1815_1518}

<table summary="Changes that were made since version 1.8.13_1516">
<caption>Changes since version 1.8.13_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Updated to support Kubernetes 1.8.15 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>IBM file storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure (SoftLayer) account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.13_1516, released 3 July 2018
{: #1813_1516}

<table summary="Changes that were made since version 1.8.13_1515">
<caption>Changes since version 1.8.13_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.13_1515, released 21 June 2018
{: #1813_1515}

<table summary="Changes that were made since version 1.8.13_1514">
<caption>Changes since version 1.8.13_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted machine types, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog 1.8.13_1514, released 19 June 2018
{: #1813_1514}

<table summary="Changes that were made since version 1.8.11_1512">
<caption>Changes since version 1.8.11_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added PodSecurityPolicy to the --admission-control option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers/cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Updated to support Kubernetes 1.8.13 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.11_1512, released 11 June 2018
{: #1811_1512}

<table summary="Changes that were made since version 1.8.11_1511">
<caption>Changes since version 1.8.11_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.11_1511, released 18 May 2018
{: #1811_1511}

<table summary="Changes that were made since version 1.8.11_1510">
<caption>Changes since version 1.8.11_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.11_1510, released 16 May 2018
{: #1811_1510}

<table summary="Changes that were made since version 1.8.11_1509">
<caption>Changes since version 1.8.11_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>


### Changelog for 1.8.11_1509, released 19 April 2018
{: #1811_1509}

<table summary="Changes that were made since version 1.8.8_1507">
<caption>Changes since version 1.8.8_1507</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p>Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Pause container image</td>
<td>3.0</td>
<td>3.1</td>
<td>Removes inherited orphaned zombie processes.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers/cs_loadbalancer.html#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers/cs_edge.html#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.7 changelog (Unsupported)
{: #17_changelog}

Review the following changes.

#### Changelog for worker node fix pack 1.7.16_1514, released 11 June 2018
{: #1716_1514}

<table summary="Changes that were made since version 1.7.16_1513">
<caption>Changes since version 1.7.16_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.7.16_1513, released 18 May 2018
{: #1716_1513}

<table summary="Changes that were made since version 1.7.16_1512">
<caption>Changes since version 1.7.16_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.7.16_1512, released 16 May 2018
{: #1716_1512}

<table summary="Changes that were made since version 1.7.16_1511">
<caption>Changes since version 1.7.16_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.7.16_1511, released 19 April 2018
{: #1716_1511}

<table summary="Changes that were made since version 1.7.4_1509">
<caption>Changes since version 1.7.4_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p>Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers/cs_loadbalancer.html#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers/cs_edge.html#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>
