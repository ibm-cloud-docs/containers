---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-04"

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

When the Ingress ALB add-on is updated, the `nginx-ingress` and `ingress-auth` containers in all ALB pods are updated to the latest build version. By default, automatic updates to the add-on are enabled, but you can disable automatic updates and manually update the add-on. For more information, see [Updating the Ingress application load balancer](/docs/containers/cs_cluster_update.html#alb).

Refer to the following table for a summary of changes for each build of the Ingress ALB add-on.

<table summary="Overview of build changes for the Ingress application load balancer add-on">
<caption>Changelog for the Ingress application load balancer add-on</caption>
<col width="15%">
<col width="15%">
<col width="35%">
<col width="35%">
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
<td>404 / 300</td>
<td>31 Jan 2019</td>
<td>Updates the Go version to 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>23 Jan 2019</td>
<td><ul>
<li>Updates the NGINX version of ALBs to 1.15.2.</li>
<li>IBM-provided TLS certificates are now automatically renewed 37 days before they expire instead of 7 days.</li>
<li>Adds {{site.data.keyword.appid_full}} logout functionality: If the `/logout` prefix exists in an {{site.data.keyword.appid_full_notm}} path, cookies are removed and the user is sent back to the login page.</li>
<li>Adds a header to {{site.data.keyword.appid_full_notm}} requests for internal tracking purposes.</li>
<li>Updates the {{site.data.keyword.appid_full_notm}} location directive so that the `app-id` annotation can be used in conjunction with the `proxy-buffers`, `proxy-buffer-size`, and `proxy-busy-buffer-size` annotations.</li>
<li>Fixes a bug so that informational logs are not labeled as errors.</li>
</ul></td>
<td>Disables TLS 1.0 and 1.1 by default. If the clients that connect to your apps support TLS 1.2, no action is required. If you still have legacy clients that require TLS 1.0 or 1.1 support, manually enable the required TLS versions by following [these steps](/docs/containers/cs_ingress.html#ssl_protocols_ciphers). For more information about how to see the TLS versions that your clients use to access your apps, see this [{{site.data.keyword.Bluemix_notm}} Blog post](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393 / 291</td>
<td>09 Jan 2019</td>
<td>Adds support for multiple {{site.data.keyword.appid_full_notm}} instances.</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 Nov 2018</td>
<td>Improves performance for {{site.data.keyword.appid_full_notm}}.</td>
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
