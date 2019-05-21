---

copyright:
  years: 2014, 2019
lastupdated: "2019-05-21"

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

# Release notes
{: #iks-release}

Use these release notes to learn about the latest changes to the {{site.data.keyword.containerlong}} documentation that are grouped by month.
{:shortdesc}

## May 2019
{: #may19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>{{site.data.keyword.containerlong_notm}} documentation updates in May 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
  <td>20 May 2019</td>
  <td><ul>
  <li><strong>Version changelogs</strong>: Added [worker node fix pack changelogs](/docs/containers?topic=containers-changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>16 May 2019</td>
  <td><ul>
  <li><strong>CLI reference</strong>: Updated the [CLI reference page](/docs/containers?topic=containers-cli-plugin-cs_cli_reference) to add COS endpoints for `logging-collect` commands and to clarify that `apiserver-refresh` restarts the Kubernetes master components.</li>
  <li><strong>Unsupported: Kubernetes version 1.10</strong>: [Kubernetes version 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) is now unsupported.</li>
  </ul></td>
</tr>
<tr>
  <td>15 May 2019</td>
  <td><ul>
  <li><strong>Default Kubernetes version</strong>: The default Kubernetes version is now 1.13.6.</li>
  <li><strong>Service limits</strong>: Added a [service limitations topic](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits).</li>
  </ul></td>
</tr>
<tr>
  <td>13 May 2019</td>
  <td><ul>
  <li><strong>Version changelogs</strong>: Added that new patch updates are available for [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558), and [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558).</li>
  <li><strong>Worker node flavors</strong>: Removed all [virtual machine worker node flavors](/docs/containers?topic=containers-plan_clusters#vm) that are 48 or more cores per [cloud status ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status). You can still provision [bare metal worker nodes](/docs/containers?topic=containers-plan_clusters#bm) with 48 or more cores.</li></ul></td>
</tr>
<tr>
  <td>08 May 2019</td>
  <td><ul>
  <li><strong>API</strong>: Added a link to the [global API swagger docs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://containers.cloud.ibm.com/global/swagger-global-api/#/).</li>
  <li><strong>Cloud Object Storage</strong>: [Added a troubleshooting guide for Cloud Object Storage](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) in your {{site.data.keyword.containerlong_notm}} clusters.</li>
  <li><strong>Kubernetes strategy</strong>: Added a topic about [What knowledge and technical skills are good to have before I move my apps to {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).</li>
  <li><strong>Kubernetes version 1.14</strong>: Added that the [Kubernetes 1.14 release](/docs/containers?topic=containers-cs_versions#cs_v114) is certified.</li>
  <li><strong>Reference topics</strong>: Updated information for various service binding, `logging`, and `nlb` operations in the [user access](/docs/containers?topic=containers-access_reference) and [CLI](/docs/containers?topic=containers-cli-plugin-cs_cli_reference) reference pages.</li></ul></td>
</tr>
<tr>
  <td>07 May 2019</td>
  <td><ul>
  <li><strong>Cluster DNS provider</strong>: [Explained the benefits of CoreDNS](/docs/containers?topic=containers-cluster_dns) now that clusters that run Kubernetes 1.14 and later support only CoreDNS.</li>
  <li><strong>Edge nodes</strong>: Added private load balancer support for [edge nodes](/docs/containers?topic=containers-edge).</li>
  <li><strong>Free clusters</strong>: Clarified where [free clusters](/docs/containers?topic=containers-regions-and-zones#regions_free) are supported.</li>
  <li><strong>New! Integrations</strong>: Added and restructure information about [{{site.data.keyword.Bluemix_notm}} services and third-party integrations](/docs/containers?topic=containers-ibm-3rd-party-integrations), [popular integrations](/docs/containers?topic=containers-supported_integrations), and [partnerships](/docs/containers?topic=containers-service-partners).</li>
  <li><strong>New! Kubernetes version 1.14</strong>: Create or update your clusters to [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).</li>
  <li><strong>Deprecated Kubernetes version 1.11</strong>: [Update](/docs/containers?topic=containers-update) any clusters that run [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) before they become unsupported.</li>
  <li><strong>Permissions</strong>: Added an FAQ, [What access policies do I give my cluster users?](/docs/containers?topic=containers-faqs#faq_access)</li>
  <li><strong>Worker pools</strong>: Added instructions for how to [apply labels to existing worker pools](/docs/containers?topic=containers-clusters#worker_pool_labels).</li>
  <li><strong>Reference topics</strong>: To support new features such as Kubernetes 1.14, [changelog](/docs/containers?topic=containers-changelog#changelog) reference pages are updated.</li></ul></td>
</tr>
<tr>
  <td>01 May 2019</td>
  <td><strong>Assigning infrastructure access</strong>: Revised the [steps to assign IAM permissions for opening support cases](/docs/containers?topic=containers-users#infra_access).</td>
</tr>
</tbody></table>


