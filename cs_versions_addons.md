---

copyright:
  years: 2014, 2018
lastupdated: "2018-11-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster add-ons changelog

Your {{site.data.keyword.containerlong}} cluster comes with add-ons that are updated automatically by IBM. You can also disable automatic updates for some add-ons and manually update them separately from the master and worker nodes. Refer to the tables in the following sections for a summary of changes for each version.

## Ingress ALB add-on changelog
{: #alb_changelog}

View build version changes for the Ingress application load balancer (ALB) add-on in your {{site.data.keyword.containerlong_notm}} clusters.
{:shortdesc}

When the Ingress ALB add-on is updated, the `nginx-ingress` and `ingress-auth` containers in all ALB pods are updated to the latest build version. By default, automatic updates to the add-on are enabled, but you can disable automatic updates and manually update the add-on. For more information, see [Updating the Ingress application load balancer](cs_cluster_update.html#alb).

Refer to the following table for a summary of changes for each build of the Ingress ALB add-on.

<table summary="Changelog for the Ingress application load balancer add-on">
<caption>Changelog for the Ingress application load balancer add-on</caption>
<thead>
<tr>
<th>`nginx-ingress` build</th>
<th>`ingress-auth` build</th>
<th>Release date</th>
<th>Non-disruptive changes</th>
<th>Disruptive changes</th>
</tr>
</thead>
<tbody>
<tr>
<td>350</td>
<td>192</td>
<td>05 Nov 2018</td>
<td>Adds support for enabling and disabling automatic updates of the Ingress ALB add-on.</td>
<td>-</td>
</tr>
</tbody>
</table>
