---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-07"

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


# Cluster add-ons changelog

Your {{site.data.keyword.containerlong}} cluster comes with add-ons that are updated automatically by IBM. You can also disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. Refer to the tables in the following sections for a summary of changes for each version.
{: shortdesc}

## Ingress ALB add-on changelog
{: #alb_changelog}

View build version changes for the Ingress application load balancer (ALB) add-on in your {{site.data.keyword.containerlong_notm}} clusters.
{:shortdesc}

When the Ingress ALB add-on is updated, the `nginx-ingress` and `ingress-auth` containers in all ALB pods are updated to the latest build version. By default, automatic updates to the add-on are enabled, but you can disable automatic updates and manually update the add-on. For more information, see [Updating the Ingress application load balancer](cs_cluster_update.html#alb).

Refer to the following table for a summary of changes for each build of the Ingress ALB add-on.

<table summary="Overview of build changes for the Ingress application load balancer add-on">
<caption>Changelog for the Ingress application load balancer add-on</caption>
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` build</th>
<th>Release date</th>
<th>Non-disruptive changes</th>
<th>Disruptive changes</th>
</tr>
</thead>
<tbody>
<tr>
<td>-</td>
<td>Expected 14 Jan 2019</td>
<td>-</td>
<td>Disables TLS 1.0 and 1.1 by default. If the clients that connect to your apps support TLS 1.2, no action is required. If you still have legacy clients that require TLS 1.0 or 1.1 support, manually enable the required TLS versions by following [these steps](cs_ingress.html#ssl_protocols_ciphers). For more information about how to see the TLS versions that your clients use to access your apps, see this [{{site.data.keyword.Bluemix_notm}} Blog post](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 Nov 2018</td>
<td>Improves performance for {{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 Nov 2018</td>
<td>Improves logging and logout features for {{site.data.keyword.appid_full_notm}}.</td>
<td>Replaces the self-signed certificate for `*.containers.mybluemix.net` with the LetsEncrypt signed certificate that is automatically generated for and used by the cluster. The `*.containers.mybluemix.net` self-signed certificate is removed.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>05 Nov 2018</td>
<td>Adds support for enabling and disabling automatic updates of the Ingress ALB add-on.</td>
<td>-</td>
</tr>
</tbody>
</table>
