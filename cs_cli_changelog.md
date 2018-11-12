---

copyright:
  years: 2014, 2018
lastupdated: "2018-11-12"

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

To install the CLI plug-in, see [Installing the CLI](cs_cli_install.html#cs_cli_install_steps).

Refer to the following table for a summary of changes for each CLI plug-in version.

<table summary="Changelog for the {{site.data.keyword.containerlong_notm}} CLI plug-in">
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
<td>0.1.635</td>
<td>06 Nov 2018</td>
<td>Adds the [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable),  [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback), and [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) commands for managing automatic updates of the Ingress ALB cluster add-on.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 Oct 2018</td>
<td><ul>
<li>Adds the [<code>ibmcloud ks credential-get</code> command](cs_cli_reference.html#cs_credential_get).</li>
<li>Adds support for the <code>storage</code> log source to all cluster logging commands. For more information, see <a href="cs_health.html#logging">Understanding cluster and app log forwarding</a>.</li>
<li>Adds the `--network` flag to the [<code>ibmcloud ks cluster-config</code> command](cs_cli_reference.html#cs_cluster_config), which downloads the Calico configuration file to run all Calico commands.</li>
<li>Minor bug fixes and refactoring</li>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 Oct 2018</td>
<td><ul><li>Adds the resource group ID to the output of <code>ibmcloud ks cluster-get</code>.</li>
<li>When [{{site.data.keyword.keymanagementserviceshort}} is enabled](cs_encrypt.html#keyprotect) as a key management service (KMS) provider in your cluster, adds the KMS enabled field in the output of <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02 Oct 2018</td>
<td>Adds support for [resource groups](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01 Oct 2018</td>
<td><ul>
<li>Adds the [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) and [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) commands for collecting API server logs in your cluster.</li>
<li>Adds the [<code>ibmcloud ks key-protect-enable</code> command](cs_cli_reference.html#cs_key_protect) to enable {{site.data.keyword.keymanagementserviceshort}} as a key management service (KMS) provider in your cluster.</li>
<li>Adds the <code>--skip-master-health</code> flag to the [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) and [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) commands to skip the master health check before initiating the reboot or reload.</li>
<li>Renames <code>Owner Email</code> to <code>Owner</code> in the output of <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
