---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-26"

keywords: kubernetes, iks

scope: containers

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



# CLI changelog
{: #cs_cli_changelog}

In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all the available commands and flags.
{:shortdesc}

To install the {{site.data.keyword.containerlong}} CLI plug-in, see [Installing the CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).

Refer to the following table for a summary of changes for each {{site.data.keyword.containerlong_notm}} CLI plug-in version.

<table summary="Overview of version changes for the {{site.data.keyword.containerlong_notm}} CLI plug-in">
<caption>Changelog for the {{site.data.keyword.containerlong_notm}} CLI plug-in</caption>
<thead>
<tr>
<th>Version</th>
<th>Release date</th>
<th>Changes</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.2.61</td>
<td>26 Feb 2019</td>
<td><ul>
<li>Adds the `cluster-pull-secret-apply` command, which creates an IAM service ID for the cluster, policies, API key, and image pull secrets so that containers that run in the `default` Kubernetes namespace can pull images from IBM Cloud Container Registry. For new clusters, image pull secrets that use IAM credentials are created by default. Use this command to update existing clusters or if your cluster has an image pull secret error during creation. For more information, see [the doc](https://test.cloud.ibm.com/docs/containers?topic=containers-images#cluster_registry_auth).</li>
<li>Fixes a bug where `ibmcloud ks init` failures caused help output to be printed.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>19 Feb 2019</td>
<td><ul><li>Fixes a bug where the region was ignored for `ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set`, and `ibmcloud ks vlan-spanning-get`.</li>
<li>Improves performance for `ibmcloud ks worker-update`.</li>
<li>Adds the version of the add-on in `ibmcloud ks cluster-addon-enable` prompts.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>08 Feb 2019</td>
<td><ul>
<li>Adds `--skip-rbac` option to the `ibmcloud ks cluster-config` command to skip adding user Kubernetes RBAC roles based on the {{site.data.keyword.Bluemix_notm}} IAM service access roles to the cluster configuration. Include this option only if you [manage your own Kubernetes RBAC roles](/docs/containers?topic=containers-users#rbac). If you use [{{site.data.keyword.Bluemix_notm}} IAM service access roles](/docs/containers?topic=containers-access_reference#service) to manage all your RBAC users, do not include this option.</li>
<li>Updates the Go version to 1.11.5.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>06 Feb 2019</td>
<td><ul>
<li>Adds the [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable), and [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable) commands for working with managed cluster add-ons such as the [Istio](/docs/containers?topic=containers-istio) and [Knative](/docs/containers?topic=containers-knative_tutorial) managed add-ons for {{site.data.keyword.containerlong_notm}}.</li>
<li>Improves help text for {{site.data.keyword.Bluemix_dedicated_notm}} users of the <code>ibmcloud ks vlans</code> command.</li></td>
</tr>
<tr>
<td>0.2.30</td>
<td>31 Jan 2019</td>
<td>Increases the default timeout value for `ibmcloud ks cluster-config` to `500s`.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>16 Jan 2019</td>
<td><ul><li>Adds the `IKS_BETA_VERSION` environment variable to enable the redesigned beta version of the {{site.data.keyword.containerlong_notm}} plug-in CLI. To try out the redesigned version, see [Using the beta command structure](/docs/containers?topic=containers-cs_cli_reference#cs_beta).</li>
<li>Increases the default timeout value for `ibmcloud ks subnets` to `60s`.</li>
<li>Minor bug and translation fixes.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>18 Dec 2018</td>
<td><ul><li>Changes the default API endpoint from <code>https://containers.bluemix.net</code> to <code>https://containers.cloud.ibm.com</code>.</li>
<li>Fixes bug so that translations are displaying properly for command help and error messages.</li>
<li>Displays command help faster.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>05 Dec 2018</td>
<td>Updates documentation and translation.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 Nov 2018</td>
<td>
<ul><li>Adds the [<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh) command.</li>
<li>Adds the resource group name to the output of <code>ibmcloud ks cluster-get</code> and <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>06 Nov 2018</td>
<td>Adds commands for managing automatic updates of the Ingress ALB cluster add-on:<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 Oct 2018</td>
<td><ul>
<li>Adds the [<code>ibmcloud ks credential-get</code> command](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get).</li>
<li>Adds support for the <code>storage</code> log source to all cluster logging commands. For more information, see <a href="/docs/containers?topic=containers-health#logging">Understanding cluster and app log forwarding</a>.</li>
<li>Adds the `--network` flag to the [<code>ibmcloud ks cluster-config</code> command](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config), which downloads the Calico configuration file to run all Calico commands.</li>
<li>Minor bug fixes and refactoring</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 Oct 2018</td>
<td><ul><li>Adds the resource group ID to the output of <code>ibmcloud ks cluster-get</code>.</li>
<li>When [{{site.data.keyword.keymanagementserviceshort}} is enabled](/docs/containers?topic=containers-encryption#keyprotect) as a key management service (KMS) provider in your cluster, adds the KMS enabled field in the output of <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02 Oct 2018</td>
<td>Adds support for [resource groups](/docs/containers?topic=containers-clusters#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01 Oct 2018</td>
<td><ul>
<li>Adds the [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect) and [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status) commands for collecting API server logs in your cluster.</li>
<li>Adds the [<code>ibmcloud ks key-protect-enable</code> command](/docs/containers?topic=containers-cs_cli_reference#cs_key_protect) to enable {{site.data.keyword.keymanagementserviceshort}} as a key management service (KMS) provider in your cluster.</li>
<li>Adds the <code>--skip-master-health</code> flag to the [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) and [ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) commands to skip the master health check before initiating the reboot or reload.</li>
<li>Renames <code>Owner Email</code> to <code>Owner</code> in the output of <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
