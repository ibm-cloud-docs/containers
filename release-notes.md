---

copyright: 
  years: 2014, 2021
lastupdated: "2021-10-11"

keywords: kubernetes, iks, release notes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Release notes
{: #iks-release}

Use the release notes to learn about the latest changes to the {{site.data.keyword.containerlong}} documentation that are grouped by month.
{: shortdesc}


This page has moved. For the latest release note information, see [Release notes](/docs/containers?topic=containers-rel-notes).
{: important}

Looking for {{site.data.keyword.cloud_notm}} status, platform announcements, security bulletins, or maintenance notifications? See [{{site.data.keyword.cloud_notm}} status](https://cloud.ibm.com/status?selected=status){: external}.
{: note}

## August 2021
{: #aug21}

| Date | Description |
| ---- | ----------- |
| 26 August 2021 | **Cluster autoscaler add-on**: [Version 1.0.3_360](/docs/containers?topic=containers-ca_changelog) is available. |
| 25 August 2021 | <ul><li>**New! Create a cluster with a template**: No longer do you have to manually specify the networking and worker node details to create a cluster, or enable security integrations such as logging and monitoring after creation. Instead, you can try out the **technical preview** to create a multizone cluster with nine worker nodes and encryption, logging, and monitoring already enabled. For more information, see [Creating a cluster by using an {{site.data.keyword.bpfull_notm}} template](/docs/openshift?topic=openshift-templates&interface=ui).</li><li>**{{site.data.keyword.cos_full_notm}} plug-in**: Version `2.1.3` is [released](/docs/containers?topic=containers-cos_plugin_changelog).</li><li>Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1214_1528">1.21.4_ 1528</a>, <a href="/docs/containers?topic=containers-changelog#12010_1550">1.20.10_1550</a>, <a href="/docs/containers?topic=containers-changelog#11914_1557">1.19.14_1557</a>, and <a href="/docs/containers?topic=containers-changelog#11820_1562">1.18.20_1562</a>.</li><</ul> |
| 23 August 2021 | <ul><li>Registry tokens are no longer accepted for authentication in {{site.data.keyword.registrylong_notm}}. Update your clusters to use {{site.data.keyword.cloud_notm}} IAM authentication. For more information, see <a href="/docs/Registry?topic=Registry-registry_access#registry_access_serviceid_apikey">Automating access to {{site.data.keyword.registrylong_notm}}</a>. For more information about Registry token deprecation, see <a href="https://www.ibm.com/cloud/blog/announcements/ibm-cloud-container-registry-deprecates-registry-tokens-for-authentication">IBM Cloud Container Registry Deprecates Registry Tokens for Authentication</a>.</li><li> <strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for versions <code>0.48.1_1541_iks</code>, <code>0.47.0_1540_iks</code>, and <code>0.43.0_1539_iks</code>. Version <code>0.45.0_1482_iks</code> is removed.</li><li> <strong>ALB OAuth Proxy</strong>: Updated the version changelog for the <a href="/docs/containers?topic=containers-alb-oauth-proxy-changelog">ALB OAuth Proxy add-on</a>.</li></ul> |
| 16 August 2021 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes. For more information, see [Version changelog](/docs/containers?topic=containers-changelog). | 
| 12 August 2021 | **Istio add-on changelog**: [Version 1.9.7](/docs/containers?topic=containers-istio-changelog#196) of the Istio managed add-on is released. |
| 10 August 2021 | **Ingress changelogs**: Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1465_iks`, `0.47.0_1480_iks`, and `0.45.0_1482_iks`. **ALB OAuth Proxy**: Updated the version changelog for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).  |
| 09 August 2021 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.312](/docs/containers?topic=containers-cs_cli_changelog). |
| 02 August 2021 | <ul><li><strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for versions <code>0.47.0_1434_iks</code> and <code>0.45.0_1435_iks</code>. Version <code>0.35.0</code> is now unsupported.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1213_1526">1.21.3_1526</a>, <a href="/docs/containers?topic=containers-changelog#1209_1548">1.20.9_1548</a>, <a href="/docs/containers?topic=containers-changelog#11913_1555">1.19.13_1555</a>, and <a href="/docs/containers?topic=containers-changelog#11820_1560">1.18.20_1560</a>.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in August 2021"}

## July 2021
{: #jul21} 

| Date | Description |
| ---- | ----------- |
| 27 July 2021 | <ul><li><strong>New! IAM trusted profile support</strong>: Link your cluster to a trusted profile in IAM so that the pods in your cluster can authenticate with IAM to use other {{site.data.keyword.cloud_notm}} services.</li><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1213_1525">1.21.3_1525</a>, <a href="/docs/containers?topic=containers-changelog#1209_1547">1.20.9_1547</a>, <a href="/docs/containers?topic=containers-changelog#11913_1554">1.19.13_1554</a>, and <a href="/docs/containers?topic=containers-changelog#11820_1559">1.18.20_1559</a>. |
| 26 July 2021 | <ul><li>For centralized management of all your secrets across clusters and injection at application runtime, try <a href="/docs/secrets-manager?topic=secrets-manager-tutorial-kubernetes-secrets">{{site.data.keyword.secrets-manager_full_notm}}</a>.</li><li><strong>{{site.data.keyword.block_storage_is_short}} add-on</strong>: <a href="/docs/containers?topic=containers-vpc_bs_changelog">Version <code>3.0.1</code></a> of the {{site.data.keyword.block_storage_is_short}} add-on is available.</li></ul> |
| 22 July 2021 | **Istio add-on changelog**: [Version 1.9.6](/docs/containers?topic=containers-istio-changelog#196) of the Istio managed add-on is released. |
| 19 July 2021 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.21.2_1524](/docs/containers?topic=containers-changelog#1212_1524), [1.20.8_1546](/docs/containers?topic=containers-changelog#1208_1546), [1.19.12_1553](/docs/containers?topic=containers-changelog#11912_1553), [1.18.20_1558](/docs/containers?topic=containers-changelog#11820_1558), and [1.17.17_1568](/docs/containers?topic=containers-changelog_archive#1171_1568).
| 15 July 2021 | <ul><li><strong>Istio add-on changelog</strong>: <a href="/docs/containers?topic=containers-istio-changelog#v110">Version 1.10.2</a> of the Istio managed add-on is released.</li><li> |
| 12 July 2021|  <strong>Snapshots</strong>: Before updating to Kubernetes version <code>1.20</code> or <code>1.21</code>, snapshot CRDs must be changed to version <code>v1beta1</code>. For more information, see the <a href="/docs/containers?topic=containers-cs_versions#121_before">Kubernetes version information and update actions</a>.  |
| 06 July 2021 |<ul><li> <strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for versions <code>0.47.0_1376_iks</code>, <code>0.45.0_1375_iks</code>, and <code>0.35.0_1374_iks</code>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1212_1523">1.21.2_1523</a>, <a href="/docs/containers?topic=containers-changelog#1208_1545">1.20.8_1545</a>, <a href="/docs/containers?topic=containers-changelog#11912_1552">1.19.12_1552</a>, <a href="/docs/containers?topic=containers-changelog#11820_1557">1.18.20_1557</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1567_worker">1.17.17_1567</a>.</li></ul> |
| 02 July 2021 | **Unsupported Kubernetes version 1.17**: To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately. |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in July 2021"}

## June 2021
{: #jun21}

| Date | Description |
| ---- | ----------- |
| 28 June 2021 | **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.21.2_1522](/docs/containers?topic=containers-changelog#1212_1522), [1.20.8_1544](/docs/containers?topic=containers-changelog#1208_1544), [1.19.12_1551](/docs/containers?topic=containers-changelog#11912_1551), [1.18.20_1556](/docs/containers?topic=containers-changelog#11820_1556), and [1.17.17_1567](/docs/containers?topic=containers-changelog#1117_1567). |
| 24 June 2021 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.295](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 23 June 2021 | **Cluster autoscaler add-on**: [Version `1.0.3`](/docs/containers?topic=containers-ca_changelog) of the cluster autoscaler add-on is available. |
| 22 June 2021 | <ul><li><strong>{{site.data.keyword.cos_full_notm}} plug-in</strong>: Version <code>2.1.2</code> of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the <a href="/docs/containers?topic=containers-cos_plugin_changelog">{{site.data.keyword.cos_full_notm}} plug-in changelog</a></li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1211_1521">1.21.1_1521</a>, <a href="/docs/containers?topic=containers-changelog#1207_1543">1.20.7_1543</a>, <a href="/docs/containers?topic=containers-changelog#11911_1550">1.19.11_1550</a>, <a href="/docs/containers?topic=containers-changelog#11819_1555">1.18.19_1555</a> and <a href="/docs/containers?topic=containers-changelog_archive#11717_1566">1.17.17_1566</a></li></ul>.|
| 21 June 2021 | <ul><li><strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for the release of version 0.47.0 of the Kubernetes Ingress image.</li><li><strong>New! The <code>addon options</code> command is now available</strong>: For more information, see <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_options">addon options</a></li></ul> |
| 17 June 2021 | <ul><li>From 07 to 31 July 2021, the DNS provider is changed from Cloudflare to Akamai for all `containers.appdomain.cloud`, `containers.mybluemix.net`, and `containers.cloud.ibm.com` domains for all clusters in {{site.data.keyword.containerlong_notm}}. Review the following actions that you must make to your Ingress setup.<ul><li>If you currently allow inbound traffic to your classic cluster from the Cloudflare source IP addresses, you must also allow inbound traffic from the [Akamai source IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/akamai/gtm-liveness-test){: external} before 07 July. After the migration completes on 31 July, you can remove the Cloudflare IP address rules.</li><li>The Akamai health check does not support verification of the body of the health check response. Update any custom health check rules that you configured for Cloudflare that use verification of the body of the health check responses.</li><li>Cluster subdomains that were health checked in Cloudflare are now registered in the Akamai DNS as CNAME records. These CNAME records point to an Akamai Global Traffic Management domain that health checks the subdomains. When a client runs a DNS query for a health checked subdomain, a CNAME record is returned to the client, as opposed to Cloudflare, in which an A record was returned. If your client expects an A record for a subdomain that was health checked in Cloudflare, update your logic to accept a CNAME record.</li><li>During the migration, an Akamai Global Traffic Management (GTM) health check was automatically created for any subdomains that had a Cloudflare health check. If you previously created a Cloudflare health check for a subdomain, and you create an Akamai health check for the subdomain after the migration, the two Akamai health checks might conflict. Note that Akamai GTM configurations do not support nested subdomains. In these cases, you can use the `ibmcloud ks nlb-dns monitor disable` command to disable the Akamai health check that the migration automatically configured for your subdomain.</li></ul>.</li><li><strong>ALB OAuth Proxy</strong>: Updated the version changelog for the <a href="/docs/containers?topic=containers-alb-oauth-proxy-changelog">ALB OAuth Proxy add-on</a> add-on.</li></ul> |
| 15 June 2021 | **New! Private VPC NLB**: You can now create [private Network Load Balancers for VPC](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_nlb_priv) to expose apps in clusters that run Kubernetes version 1.19 and later. |
| 10 June 2021 | **Ingress changelogs**: Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions 0.45.0, 0.35.0, and 0.34.1 of the Kubernetes Ingress image. |
| 09 June 2021 | <ul><li><strong>New! Kubernetes 1.21</strong>: You can create or <a href="/docs/containers?topic=containers-cs_versions#cs_v121">update</a> your cluster to Kubernetes version 1.21. With Kubernetes 1.21, you get the latest stable enhancements from the community, such as stable <code>CronJob</code>, <code>EndpointSlice</code>, and <code>PodDisruptionBudget</code> resources. You also get enhancements to the {{site.data.keyword.cloud_notm}} product, such as a refreshed user interface experience. For more information, see the <a href="https://www.ibm.com/cloud/blog/announcements/kubernetes-version-121-now-available-in-ibm-cloud-kubernetes-service">blog announcement</a>{: external}.</li><li><strong>Deprecated Kubernetes 1.18</strong>: With the release of Kubernetes 1.21, clusters that run version 1.18 are deprecated, with a tentative unsupported date of 10 October 2021. Update your cluster to at least <a href="/docs/containers?topic=containers-cs_versions#cs_v119">version 1.19</a> as soon as possible.</li><li><strong>Expanded Troubleshooting</strong>: You can now find troubleshooting steps for {{site.data.keyword.cloud_notm}} persistent storage in the following pages: <ul><li><a href="/docs/openshift?topic=openshift-debug_storage_file">{{site.data.keyword.filestorage_short}}</a></li><li><a href="/docs/openshift?topic=openshift-debug_storage_block">{{site.data.keyword.blockstorageshort}}</a></li><li><a href="/docs/openshift?topic=openshift-debug_storage_cos">{{site.data.keyword.cos_short}}</a></li><li><a href="/docs/openshift?topic=openshift-debug_storage_px">Portworx</a></li></ul></ul>|
| 07 June 2021 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.20.7_1542](/docs/containers?topic=containers-changelog#1207_1542), [1.19.11_1549](/docs/containers?topic=containers-changelog#11911_1549), [1.18.19_1554](/docs/containers?topic=containers-changelog#11819_1554), and [1.17.17_1565](/docs/containers?topic=containers-changelog_archive#11717_1565).|
| 03 June 2021 | **{{site.data.keyword.cos_full_notm}} plug-in**: Version `2.0.8` of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in changelog](/docs/containers?topic=containers-cos_plugin_changelog). |
| 02 June 2021 | **End of support for custom IBM Ingress image:** The custom {{site.data.keyword.containerlong_notm}} Ingress image is unsupported. In clusters that were created before 01 December 2020, [migrate any ALBs that continue to run the custom IBM Ingress image to the Kubernetes Ingress image](/docs/containers?topic=containers-ingress-types). Not ready to switch your ALBs to the Kubernetes Ingress image yet? The custom {{site.data.keyword.containerlong_notm}} Ingress image is available as an [open source project](https://github.com/IBM-Cloud/iks-ingress-controller/){: external}. However, this project is not officially supported by {{site.data.keyword.cloud_notm}}, and you are responsible for deploying, managing, and maintaining the Ingress controllers in your cluster.|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in June 2021"}

## May 2021
{: #may21}

| Date | Description |
| ---- | ----------- |
| 27 May 2021 | **Istio add-on changelog**: [Version 1.9.5](/docs/containers?topic=containers-istio-changelog#v19) and version [1.8.6](/docs/containers?topic=containers-istio-changelog#v18) of the Istio managed add-on are released.|
| 26 May 2021 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.275</a>.</li><li><strong>Version 0.45.0 of the Kubernetes Ingress image</strong>: Due to a <a href="https://github.com/kubernetes/ingress-nginx/issues/6931">regression in the community Kubernetes Ingress NGINX code</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, trailing slashes (<code>/</code>) are removed from subdomains during TLS redirects.</li></ul> |
| 24 May 2021 | <ul><li><strong>DNS provider migration to Akamai</strong>: From 07 to 31 July 2021, the DNS provider is changed from Cloudflare to Akamai for all `containers.appdomain.cloud`, `containers.mybluemix.net`, and `containers.cloud.ibm.com` domains for all clusters in {{site.data.keyword.containerlong_notm}}. Review the following actions that you must make to your Ingress setup.<ul><li>If you currently allow inbound traffic to your classic cluster from the Cloudflare source IP addresses, you must also allow inbound traffic from the [Akamai source IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/akamai/gtm-liveness-test){: external} before 07 July. After the migration completes on 31 July, you can remove the Cloudflare IP address rules.</li><li>The Akamai health check does not support verification of the body of the health check response. Update any custom health check rules that you configured for Cloudflare that use verification of the body of the health check responses.</li><li>Cluster subdomains that were health checked in Cloudflare are now registered in the Akamai DNS as CNAME records. These CNAME records point to an Akamai Global Traffic Management domain that health checks the subdomains. When a client runs a DNS query for a health checked subdomain, a CNAME record is returned to the client, as opposed to Cloudflare, in which an A record was returned. If your client expects an A record for a subdomain that was health checked in Cloudflare, update your logic to accept a CNAME record.</li><li>During the migration, an Akamai Global Traffic Management (GTM) health check was automatically created for any subdomains that had a Cloudflare health check. If you previously created a Cloudflare health check for a subdomain, and you create an Akamai health check for the subdomain after the migration, the two Akamai health checks might conflict. Note that Akamai GTM configurations do not support nested subdomains. In these cases, you can use the `ibmcloud ks nlb-dns monitor disable` command to disable the Akamai health check that the migration automatically configured for your subdomain.</li></ul>.</li><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1207_1540">1.20.7_1540</a>, <a href="/docs/containers?topic=containers-changelog#11911_1547">1.19.11_1547</a>, <a href="/docs/containers?topic=containers-changelog#11819_1552">1.18.19_1552</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1563">1.17.17_1563</a>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1207_1541">1.20.7_1541</a>, <a href="/docs/containers?topic=containers-changelog#11911_1548">1.19.11_1548</a>, <a href="/docs/containers?topic=containers-changelog#11819_1553">1.18.19_1553</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1564">1.17.17_1564</a>.</li></ul> |
| 17 May 2021 | <ul><li><strong>Deprecated: Kubernetes web terminal.</strong> The Kubernetes web terminal add-on is deprecated and becomes unsupported 1 July 2021. Instead, use the <a href="/docs/containers?topic=containers-cs_cli_install#cloud-shell">{{site.data.keyword.cloud-shell_notm}}</a>.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#v19">Version 1.9.4 of the Istio managed add-on</a> is released.</li><li><strong>Deprecated Ubuntu 16 end of support date</strong>: The Ubuntu 16 worker node flavors were deprecated 1 December 2020, with an initial unsupported date of April 2021. To give customers more time to migrate to a newer Ubuntu version, the end of support date is extended to 31 December 2021. Before 31 December 2021, <a href="/docs/containers?topic=containers-update#machine_type">update the worker pools in your cluster to run Ubuntu 18</a>. For more information, see the <a href="https://www.ibm.com/cloud/blog/announcements/new-bare-metal-servers-available-for-kubernetes-and-openshift-clusters">{{site.data.keyword.cloud_notm}} blog</a>{: external}.</li></ul> |
| 11 May 2021 | <ul><li><strong>ALB healthchecks in VPC clusters</strong>: If you set up <a href="/docs/openshift?topic=openshift-vpc-network-policy#security_groups">VPC security groups</a> or [VPC access control lists (ACLs)](/docs/openshift?topic=openshift-vpc-network-policy#acls) to secure your cluster network, you can now create the rules to allow the necessary traffic from the Kubernetes control plane IP addresses and Akamai IPv4 IP addresses to health check your ALBs. Previously, a quota on the number of rules per security group or ACL prevented the ability to create all necessary rules for health checks.</li></ul>|
| 10 May 2021 | <ul><li><strong>New! PX-Backup is now available</strong>: For more information, see <a href="/docs/containers?topic=containers-portworx">Backing up and restoring apps and data with PX-Backup</a>.</li><li><strong>Calico KDD update in 1.19</strong>: Added a step to check for Calico <code>NetworkPolicy</code> resources that are scoped to non-existent namespaces before <a href="/docs/containers?topic=containers-cs_versions#119_before">updating your cluster to Kubernetes version 1.19</a>.</li><li><strong>Cluster autoscaler add-on</strong>: <a href="/docs/containers?topic=containers-ca_changelog">Patch update <code>1.0.2_267</code></a> of the cluster autoscaler add-on is available.</li><li><strong>{{site.data.keyword.cos_full_notm}} plug-in</strong>: <a href="/docs/containers?topic=containers-cos_plugin_changelog">Version <code>2.0.9</code></a> of the {{site.data.keyword.cos_full_notm}} plug-in is available.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1206_1539">1.20.6_1539</a>, <a href="/docs/containers?topic=containers-changelog#11910_1546">1.19.10_1546</a>, <a href="/docs/containers?topic=containers-changelog#11818_1551">1.18.18_1551</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1562">1.17.17_1562</a>.</li></ul> |
| 4 May 2021 |  **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.20.5_1538](/docs/containers?topic=containers-changelog#1206_1538) and [1.19.10_1545](/docs/containers?topic=containers-changelog#11910_1545).|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in May 2021"}

## April 2021
{: #apr21}

| Date | Description |
| ---- | ----------- |
| 29 April 2021 | <ul><li><strong>Custom IOPs for Istio</strong>: Added a page for <a href="/docs/containers?topic=containers-istio-custom-gateway">using an <code>IstioOperator</code> to create custom Istio ingress and egress gateways</a> for the managed Istio add-on.</li><li><strong>Istio add-on changelog</strong>: <a href="/docs/containers?topic=containers-istio-changelog#v19">Version 1.9.3</a> and version <a href="/docs/containers?topic=containers-istio-changelog#v18">1.8.5</a> of the Istio managed add-on are released.</li></ul>|
| 28 April 2021 | <strong>Default version</strong>: The default version for new clusters is now Kubernetes 1.20.|
| 27 April 2021 | **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.20.6_1536](/docs/containers?topic=containers-changelog#1206_1536), [1.19.10_1543](/docs/containers?topic=containers-changelog#11910_1543), [1.18.18_1549](/docs/containers?topic=containers-changelog#11818_1549), and [1.17.17_1560](/docs/containers?topic=containers-changelog_archive#11717_1560)|
| 26 April 2021 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.258</a>.</li><li><strong>VPC NLB</strong>: Adds steps for <a href="/docs/containers?topic=containers-vpc-lbaas#vpc_nlb_dns">registering a VPC network load balancer with a DNS record and TLS certificate</a>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1206_1537">1.20.6_1537</a>, <a href="/docs/containers?topic=containers-changelog#11910_1544">1.19.10_1544</a>, <a href="/docs/containers?topic=containers-changelog#11818_1550">1.18.18_1550</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1561">1.17.17_1561</a>.</li></ul> |
| 23 April 2021 | **Ingress changelogs**: Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the release of version 0.45.0 of the Kubernetes Ingress image. Version 0.33.0 is now unsupported. |
| 20 April 2021 | **New! Toronto multizone region for VPC**: You can now create clusters on VPC infrastructure in the Toronto, Canada (`ca-tor`) [location](/docs/containers?topic=containers-regions-and-zones).|
| 19 April 2021 | <ul><li><strong>Add-on changelogs</strong>: Updated version changelogs for the <a href="/docs/containers?topic=containers-alb-oauth-proxy-changelog">ALB OAuth Proxy add-on</a>.</li><li><strong>Cluster autoscaler add-on</strong>: <a href="/docs/containers?topic=containers-ca_changelog">Patch update <code>1.0.2_256</code></a> of the cluster autoscaler add-on is available.</li><li><strong>{{site.data.keyword.cos_full_notm}} plug-in</strong>: Version <code>2.0.8</code> of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the <a href="/docs/containers?topic=containers-cos_plugin_changelog">{{site.data.keyword.cos_full_notm}} plug-in changelog</a>.</li><li><strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images.</li></ul> |
| 16 April 2021 | **New fields and events for {{site.data.keyword.at_short}}**: To align with event auditing standards across {{site.data.keyword.cloud_notm}}, the [previously deprecated cluster fields and events](#deprecated-at-events) are now replaced by new fields and events. For an updated list of events, see [{{site.data.keyword.at_full_notm}} events](/docs/containers?topic=containers-at_events).|
| 15 April 2021 | <strong>Accessing VPC clusters</strong>: Updated the steps for <a href="/docs/containers?topic=containers-access_cluster#vpc_private_se">accessing VPC clusters through the private cloud service endpoint</a> by configuring the VPC VPN gateway to access the <code>166.8.0.0/14</code> subnet. |
| 12 April 2021 | <ul><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1205_1535">1.20.5_1535</a>, <a href="/docs/containers?topic=containers-changelog#1199_1542">1.19.9_1542</a>, <a href="/docs/containers?topic=containers-changelog#11817_1548">1.18.17_1548</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1559">1.17.17_1559</a>.</li><li><strong>Ingress changelogs</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Ingress ALB changelog</a> for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images.</li></ul>|
| 05 April 2021 | **Deprecated data centers for classic clusters**: Houston (`hou02`) and Oslo (`osl01`) are deprecated and become unsupported later this year. To prevent any interruption of service, [redeploy all of your cluster workloads](/docs/containers?topic=containers-update_app#copy_apps_cluster) to a [supported data center](/docs/containers?topic=containers-regions-and-zones#zones-mz) and remove your `osl01` or `hou02` clusters by **1 August 2021**. Before the unsupported date, you are blocked from adding new worker nodes and clusters starting on **1 July 2021**. For more information, see [Data center closures in 2021](/docs/get-support?topic=get-support-dc-closure). |
| 02 April 2021 | **Istio add-on**: [Version 1.9.2 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v19) is released. |
| 01 April 2021 | <ul><li><strong>Cluster autoscaler add-on</strong>: <a href="/docs/containers?topic=containers-ca_changelog">Patch update <code>1.0.2_249</code></a> of the cluster autoscaler add-on is available.</li><li><strong>{{site.data.keyword.block_storage_is_short}} add-on</strong>: <a href="/docs/containers?topic=containers-vpc_bs_changelog">Patch update <code>3.0.0_521</code></a> of the {{site.data.keyword.block_storage_is_short}} add-on is available.</li><li><strong>{{site.data.keyword.block_storage_is_short}} driver</strong>: Added steps to install the <code>vpc-block-csi-driver</code> on unmanaged clusters. For more information, see <a href="/docs/containers?topic=containers-vpc-block-storage-driver-unmanaged">Storing data on {{site.data.keyword.block_storage_is_short}} for unmanaged clusters</a>.</li><li><strong>New! image security add-on</strong>: In clusters that run Kubernetes version 1.18 or later, you can <a href="/docs/containers?topic=containers-images#portieris-image-sec">install the container image security enforcement add-on</a> to set up the <a href="https://github.com/IBM/portieris">Portieris</a>{: external} project in your cluster.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in April 2021"}

## March 2021
{: #mar21}

| Date | Description |
| ---- | ----------- |
| 30 March 2021 | <ul><li><strong>Add-on changelogs</strong>: Added version changelogs for the <a href="/docs/containers?topic=containers-alb-oauth-proxy-changelog">ALB OAuth Proxy add-on</a>.</li><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1205_1533">1.20.5_1533</a>, <a href="/docs/containers?topic=containers-changelog#1199_1540">1.19.9_1540</a>, <a href="/docs/containers?topic=containers-changelog#11817_1546">1.18.17_1546</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1557">1.17.17_1557</a>.</li></ul>|
| 29 March 2021 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.20.5_1534](/docs/containers?topic=containers-changelog#1205_1534), [1.19.9_1541](/docs/containers?topic=containers-changelog#1199_1541), [1.18.17_1547](/docs/containers?topic=containers-changelog#11817_1547), and [1.17.17_1558](/docs/containers?topic=containers-changelog_archive#11717_1558). |
| 25 March 2021 | <ul><li><strong>{{site.data.keyword.cloudcerts_short}} instances</strong>: The default {{site.data.keyword.cloudcerts_short}} instance for your cluster is now named in the format <code>kube-crtmgr-&lt;cluster_ID&gt;</code>.</li></ul> |
| 23 March 2021 | **Istio add-on**: [Version 1.8.4 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#184) is released. |
| 22 March 2021 | **Ingress ALB changelog**: Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images. |
| 17 March 2021 | <p id="deprecated-at-events">**Deprecated events to be replaced for {{site.data.keyword.at_short}}**: To align with event auditing standards across {{site.data.keyword.cloud_notm}}, the following cluster events are deprecated and are replaced in 30 days on 16 April 2021 by new events.</p><ul><li><code>containers-kubernetes.account.create</code></li><li><code>containers-kubernetes.account.delete</code></li><li><code>containers-kubernetes.account.get</code></li><li><code>containers-kubernetes.account.update</code></li><li><code>containers-kubernetes.cluster.config</code></li><li><code>containers-kubernetes.cluster.create</code></li><li><code>containers-kubernetes.cluster.delete</code></li><li><code>containers-kubernetes.cluster.update</code></li><li><code>containers-kubernetes.credentials.ready-to-use</code></li><li><code>containers-kubernetes.logging-config.create</code></li><li><code>containers-kubernetes.logging-config.delete</code></li><li><code>containers-kubernetes.logging-config.refresh</code></li><li><code>containers-kubernetes.logging-filter.create</code></li><li><code>containers-kubernetes.logging-filter.delete</code></li><li><code>containers-kubernetes.logging-filter.update</code></li><li><code>containers-kubernetes.logging-autoupdate.changed</code></li><li><code>containers-kubernetes.masterlog-retrieve</code></li><li><code>containers-kubernetes.masterlog-status</code></li><li><code>containers-kubnertes.cluster.rbac.update</code></li><li><code>containers-kubernetes.service.create</code></li><li><code>containers-kubernetes.service.delete</code></li><li><code>containers-kubernetes.subnet.add</code></li><li><code>containers-kubernetes.subnet.create</code></li><li><code>containers-kubernetes.subnet.update</code></li><li><code>containers-kubernetes.vlan.create</code></li><li><code>containers-kubernetes.vlan.delete</code></li><li><code>containers-kubernetes.worker.create</code></li><li><code>containers-kubernetes.worker.delete</code></li><li><code>containers-kubernetes.worker.update</code></li><li><code>containers-kubernetes.workerpool.create</code></li><li><code>containers-kubernetes.workerpool.delete</code></li><li><code>containers-kubernetes.workerpool.update</code></li><li><code>containers-kubernetes.zone.delete</code></li><li><code>containers-kubernetes.zone.update</code></li></ul><br><br>**Deprecated fields across events**: The following fields are deprecated and replaced by or updated with new values across events.<ul><li>The <code>correlationID</code> is replaced by <code>correlationId</code> to align with field casing standards.</li><li>The <code>resourceGroupID</code> field is no longer used. Instead, the resource group ID can be found in the <code>target.resourceGroupId</code> field.</li><li>The <code>reason.reasonCode</code> field is now formatted as an integer (<code>int</code>) instead of string (<code>string</code>).</li><li>The <code>requestData</code> field is now formatted as a JSON object instead of stringified JSON.</li><li>The <code>responseData</code> field is now formatted as a JSON object instead of stringified JSON.</li><li>The <code>target.typeURI</code> values are updated for consistency. All values now have a prefix of <code>containers-kubernetes/</code> instead of <code>container/</code>. For example, <code>container/cluster</code> is now <code>containers-kubernetes/cluster</code> and <code>container/worker</code> is now <code>containers-kubernetes/worker</code>.</li></ul> |
| 16 March 2021 | **Ingress ALB changelog**: Updated the [`nginx-ingress` build to 2458](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image. |
| 12 March 2021 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.20.4_1532](/docs/containers?topic=containers-changelog#1204_1532), [1.19.8_1539](/docs/containers?topic=containers-changelog#1198_1539), [1.18.16_1545](/docs/containers?topic=containers-changelog#11816_1545), and [1.17.17_1556](/docs/containers?topic=containers-changelog_archive#11717_1556).|
| 10 March 2021 | **Istio add-on**: [Version 1.7.8 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#178) is released. |
| 09 March 2021 | **Cluster autoscaler add-on**: Version 1.0.2 of the cluster autoscaler add-on is released. For more information, see the [cluster autoscaler add-on changelog](/docs/containers?topic=containers-ca_changelog). |
| 05 March 2021 | **Trusted images**: You can now [set up trusted content for container images](/docs/containers?topic=containers-images#trusted_images) that are signed and stored in {{site.data.keyword.registrylong_notm}}. |
| 01 March 2021 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.233</a>.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#183">Version 1.8.3 of the Istio managed add-on</a> is released.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1204_1531">1.20.4_1531</a>, <a href="/docs/containers?topic=containers-changelog#1198_1538">1.19.8_1538</a>, <a href="/docs/containers?topic=containers-changelog#11816_1544">1.18.16_1544</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1555_worker">1.17.17_1555</a>.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in March 2021"}

## February 2021
{: #feb21}

| Date | Description |
| ---- | ----------- |
| 27 February 2021 | **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.20.4_1531](/docs/containers?topic=containers-changelog#1204_1531_master), [1.19.8_1538](/docs/containers?topic=containers-changelog#1198_1538_master), and [1.18.16_1544](/docs/containers?topic=containers-changelog#11816_1544_master). |
| 26 February 2021 | <ul><li><strong>End of service of VPC Gen 1</strong>: Removed steps for using VPC Gen 1 compute. You can now <a href="/docs/containers?topic=containers-clusters#clusters_vpcg2">create new VPC clusters on Generation 2 compute only</a>. Move any remaining workloads from VPC Gen 1 clusters to VPC Gen 2 clusters before 01 March 2021, when any remaining VPC Gen 1 worker nodes are automatically deleted.</li><li><strong>{{site.data.keyword.block_storage_is_short}} add-on</strong>: Version <code>3.0.0</code> of the {{site.data.keyword.block_storage_is_short}} add-on is released. Update your clusters to use the latest version. For more information, see the <a href="/docs/containers?topic=containers-vpc_bs_changelog">{{site.data.keyword.block_storage_is_short}} add-on changelog</a>.</li></ul> |
| 25 February 2021 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.231](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 24 February 2021 | **Default version**: Kubernetes 1.19 is now the default cluster version. |
| 23 February 2021 | **VPE**: In VPC clusters that run Kubernetes version 1.20 or later, worker node communication to the Kubernetes master is now established over the [VPC virtual private endpoint (VPE)](/docs/containers?topic=containers-vpc-subnets#vpc_basics_vpe). |
| 22 February 2021 | **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.20.4_1530](/docs/containers?topic=containers-changelog#1204_1530), [1.19.8_1537](/docs/containers?topic=containers-changelog#1198_1537), [1.18.16_1543](/docs/containers?topic=containers-changelog#11816_1543), and [1.17.17_1555](/docs/containers?topic=containers-changelog_archive#11717_1555). |
| 20 February 2021 | **Certified Kubernetes**: The Kubernetes version [1.20](/docs/containers?topic=containers-cs_versions#cs_v120) release is now certified. |
| 17 February 2021 | <ul><li><strong>New! Kubernetes 1.20</strong>: You can create or <a href="/docs/containers?topic=containers-cs_versions#cs_v120">update</a> your cluster to Kubernetes version 1.20. With Kubernetes 1.20, you get the latest stable enhancements from the community, as well as beta access to features such as <a href="/docs/containers?topic=containers-kubeapi-priority">API server priority</a>. For more information, see the <a href="http://www.ibm.com/cloud/blog/announcements/kubernetes-version-120-now-available-in-ibm-cloud-kubernetes-service">blog announcement</a>{: external}.</li><li><strong>Deprecated Kubernetes 1.17</strong>: With the release of Kubernetes 1.20, clusters that run version 1.17 are deprecated, with a tentative unsupported date of 2 July 2021. Update your cluster to at least <a href="/docs/containers?topic=containers-cs_versions#cs_v118">version 1.18</a> as soon as possible.</li></ul> |
| 15 February 2021 | <ul><li><strong>New! Osaka multizone region</strong>: You can now create classic or VPC clusters in the Osaka, Japan (<code>jp-osa</code>) <a href="/docs/containers?topic=containers-regions-and-zones">location</a>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1197_1535">1.19.7_1535</a>, <a href="/docs/containers?topic=containers-changelog#11815_1541">1.18.15_1541</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1553">1.17.17_1553</a>.</li></ul> |
| 12 February 2021 | **Gateway firewalls and Calico policies**: For classic clusters in Frankfurt, updated the required IP addresses and ports that you must open in a [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private) or [Calico private network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation/calico-v3/eu-de){: external}.
| 10 February 2021 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> build to 2452</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li><li><strong>Gateway firewalls and Calico policies</strong>: For classic clusters in Dallas, Washington D.C., and Frankfurt, updated the required IP addresses and ports that you must open in a <a href="/docs/containers?topic=containers-firewall#firewall_outbound">public gateway firewall device</a>, <a href="/docs/containers?topic=containers-firewall#firewall_private">private gateway device firewall</a>, or <a href="https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies">Calico network isolation policies</a>{: external}.</li></ul> |
| 08 February 2021 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.223</a>.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#177">Version 1.7.7 of the Istio managed add-on</a> is released.</li></ul> |
| 04 February 2021 | **Worker node modifications**: Summarized the modifications that you can make to the [default worker node settings](/docs/containers?topic=containers-kernel#worker-default).|
| 03 February 2021 | **Worker node versions**: A worker node fix pack for internal documentation updates is available for Kubernetes version [1.19.7_1534](/docs/containers?topic=containers-changelog#1197_1534), and [1.18.15_1540](/docs/containers?topic=containers-changelog#11815_1540).|
| 01 February 2021 | <ul><li><strong>Unsupported: Kubernetes version 1.16</strong>: Clusters that run Kubernetes version 1.16 are unsupported as of 31 January 2021. To continue receiving important security updates and support, you must <a href="/docs/containers?topic=containers-cs_versions#prep-up">update the cluster to a supported version</a> immediately.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1197_1533">1.19.7_1533</a>, <a href="/docs/containers?topic=containers-changelog#11815_1539">1.18.15_1539</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11717_1552">1.17.17_1552</a>.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in February 2021"}

## January 2021
{: #jan21}

| Date | Description |
| ---- | ----------- |
| 27 January 2021 | <ul><li><strong>Reminder: VPC Gen 1 deprecation</strong>: You can continue to use VPC Gen 1 resources only until 26 February 2021, when all service for VPC Gen 1 ends. On 01 March 2021, any remaining VPC Gen 1 worker nodes are automatically deleted. To ensure continued support, <a href="/docs/containers?topic=containers-clusters#clusters_vpcg2">create new VPC clusters on Generation 2 compute only</a>, and move your workloads from existing VPC Gen 1 clusters to VPC Gen 2 clusters.</li><li><strong>Block Storage for VPC add-on</strong>: Block Storage for VPC add-on patch update <code>2.0.3_471</code> is released. For more information, see the <a href="/docs/containers?topic=containers-vpc_bs_changelog">Block Storage for VPC add-on changelog</a>.</li></ul> |
| 25 January 2021 | <ul><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#182">Version 1.8.2 of the Istio managed add-on</a> is released.</li><li><strong>New! {{site.data.keyword.openshiftshort}} Do (<code>odo</code>) CLI tutorial</strong>: Looking to develop apps without using <code>kubectl</code> system admin commands or YAML configuration files? Check out the <a href="/docs/containers?topic=containers-odo-tutorial">Developing on clusters with the {{site.data.keyword.openshiftshort}} Do CLI</a> tutorial for a quick guide on using <code>odo</code> to package and push your apps to your cluster. You no longer need an {{site.data.keyword.openshiftshort}} cluster to use <code>odo</code>, but can use <code>odo</code> with any Kubernetes cluster.</li><li><strong>New! Private service endpoint allowlists</strong>: You can now control access to your private cloud service endpoint by <a href="/docs/containers?topic=containers-access_cluster#private-se-allowlist">creating a subnet allowlist</a>. Only authorized requests to your cluster master that originate from subnets in the allowlist are permitted through the cluster's private cloud service endpoint.</li><li><strong>Private Kubernetes Ingress</strong>: Added steps for <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create-private">privately exposing apps with ALBs that run the Kubernetes Ingress image</a>.</li></ul> |
| 19 January 2021 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> build to 2424</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1197_1532_master">1.19.7_1532</a>, <a href="/docs/containers?topic=containers-changelog#11815_1538_master">1.18.15_1538</a>, <a href="/docs/containers?topic=containers-changelog_archive#11717_1551_master">1.17.17_1551</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1557_master">1.16.15_1557</a>.</li></ul> |
| 18 January 2021 | <ul><li><strong>Knative add-on is unsupported</strong>: The Knative add-on is automatically removed from your cluster. Instead, use the <a href="https://knative.dev/docs/install/">Knative open source project</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> or <a href="/docs/codeengine?topic=codeengine-getting-started">{{site.data.keyword.codeenginefull}}</a>, which includes Knative's open-source capabilities.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1197_1532">1.19.7_1532</a>, <a href="/docs/containers?topic=containers-changelog#11815_1538">1.18.15_1538</a>, <a href="/docs/containers?topic=containers-changelog_archive#11717_1551">1.17.17_1551</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1557">1.16.15_1557</a>.</li></ul> |
| 14 January 2021 | **Cluster autoscaler**: Cluster autoscaler add-on patch update `1.0.1_210` is released. For more information, see the [Cluster autoscaler add-on changelog](/docs/containers?topic=containers-ca_changelog) |
| 12 January 2021 | <ul><li><strong>Ingress resources</strong>: Added example Ingress resource definitions that are compatible with Kubernetes version 1.19. See the example YAML file in the documentation for the <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create">community Kubernetes Ingress setup</a> or for the <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create">deprecated custom {{site.data.keyword.containerlong_notm}} Ingress setup</a>.</li><li><strong>Kubernetes benchmarks</strong>: Added how to <a href="/docs/containers?topic=containers-cis-benchmark#cis-worker-test">run the CIS Kubernetes benchmark tests on your own worker nodes</a>.</li><li><strong>Removal of data center support</strong>: Updated the documentation to reflect that Melbourne (<code>mel01</code>) is no longer available as an option to create {{site.data.keyword.cloud_notm}} resources in.</li></ul>|
| 07 January 2021 | **Ingress ALB changelog**: Updated the latest [Kubernetes Ingress image build to `0.35.0_869_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0).|
| 06 January 2021 | **Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.19.6_1531](/docs/containers?topic=containers-changelog#1196_1531), [1.18.14_1537](/docs/containers?topic=containers-changelog#11814_1537), [1.17.16_1550](/docs/containers?topic=containers-changelog#11716_1550), and [1.16.15_1556](/docs/containers?topic=containers-changelog_archive#11615_1556).|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in January 2021"}

## December 2020
{: #dec20}

| Date | Description |
| ---- | ----------- |
| 21 December 2020 | <ul><li><strong>Gateway firewalls and Calico policies</strong>: For classic clusters in Tokyo, updated the {{site.data.keyword.containerlong_notm}} IP addresses that you must open in a <a href="/docs/containers?topic=containers-firewall#firewall_outbound">public gateway firewall device</a> or <a href="https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/public-network-isolation">Calico network isolation policies</a>{: external}.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1195_1530">1.19.5_1530</a>, <a href="/docs/containers?topic=containers-changelog#11813_1536">1.18.13_1536</a>, <a href="/docs/containers?topic=containers-changelog#11715_1549">1.17.15_1549</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1555">1.16.15_1555</a>.</li></ul> |
| 18 December 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.208</a>.</li><li><strong>Object Storage plug-in</strong>: Version <code>2.0.6</code> of the Object Storage plug-in is released. For more information, see the <a href="/docs/containers?topic=containers-cos_plugin_changelog">Object Storage plug-in changelog</a>.</li></ul> |
| 17 December 2020 | <ul><li><strong>Audit documentation</strong>: Reorganized information about the configuration and forwarding of Kubernetes API server <a href="/docs/containers?topic=containers-health-audit">audit logs</a>.</li><li><strong>Back up and restore</strong>: Version <code>1.0.5</code> of the <code>ibmcloud-backup-restore</code> Helm chart is released. For more information, see the <a href="/docs/containers?topic=containers-backup_restore_changelog">Back up and restore Helm chart changelog</a>.</li><li><strong>Ingress ALB changelog</strong>: Updated the latest <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0">Kubernetes Ingress image build to <code>0.35.0_826_iks</code></a>. Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>ingress-auth</code> build to 954</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li></ul> |
| 16 December 2020 | **Istio add-on**: Versions [1.8.1](/docs/containers?topic=containers-istio-changelog#181) and [1.7.6](/docs/containers?topic=containers-istio-changelog#176) of the Istio managed add-on are released. Version 1.6 is unsupported. |
| 15 December 2020 | **Cluster autoscaler**: Cluster autoscaler add-on patch update `1.0.1_205` is released. For more information, see the [Cluster autoscaler add-on changelog](/docs/containers?topic=containers-ca_changelog). |
| 14 December 2020 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the latest <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0">Kubernetes Ingress image build to <code>0.35.0_767_iks</code></a>. Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> build to 2410 and the <code>ingress-auth</code> build to 947</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1195_1529">1.19.5_1529</a>, <a href="/docs/containers?topic=containers-changelog#11813_1535">1.18.13_1535</a>, <a href="/docs/containers?topic=containers-changelog#11715_1548">1.17.15_1548</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1554_master">1.16.15_1554</a>.</li></ul> |
| 11 December 2020 | <ul><li><strong>Storage add-ons</strong>: Cluster autoscaler add-on patch update <code>1.0.1_195</code> is released. For more information, see the <a href="/docs/containers?topic=containers-ca_changelog">Cluster autoscaler add-on changelog</a>. {{site.data.keyword.block_storage_is_short}} add-on patch update <code>2.0.3_464</code> is released. For more information, see the <a href="/docs/containers?topic=containers-vpc_bs_changelog">{{site.data.keyword.block_storage_is_short}} add-on changelog</a>.</li><li><strong>strongSwan versions</strong> Added information about which <a href="/docs/containers?topic=containers-vpn#vpn_upgrade">strongSwan Helm chart versions</a> are supported.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1194_1529">1.19.4_1529</a>, <a href="/docs/containers?topic=containers-changelog#11812_1535">1.18.12_1535</a>, <a href="/docs/containers?topic=containers-changelog#11714_1548">1.17.14_1548</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1554">1.16.15_1554</a>.</li></ul> |
| 09 December 2020 | <ul><li><strong>Accessing clusters</strong>: Updated the steps for <a href="/docs/containers?topic=containers-access_cluster#access_private_se">accessing clusters through the private cloud service endpoint</a> to use the <code>--endpoint private</code> flag in the <code>ibmcloud ks cluster config</code> command.</li><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.206</a>.</li><li><strong>Proxy protocol for Ingress:</strong> In VPC clusters, you can now <a href="/docs/containers?topic=containers-comm-ingress-annotations#preserve_source_ip_vpc">enable the PROXY protocol</a> for all load balancers that expose Ingress ALBs in your cluster. The PROXY protocol enables load balancers to pass client connection information that is contained in headers on the client request, including the client IP address, the proxy server IP address, and both port numbers, to ALBs.</li></ul> |
| 09 December 2020 | <ul><li><strong>Helm version 2 unsupported</strong>: Removed all steps for using Helm v2, which is unsupported. <a href="https://helm.sh/docs/topics/v2_v3_migration/">Migrate to Helm v3</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> today for several advantages over Helm v2, such as the removal of the Helm server, Tiller.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#v18">Version 1.8 of the Istio managed add-on</a> is released.</li></ul> |
| 07 December 2020 | **{{site.data.keyword.keymanagementserviceshort}} enhancements**: For clusters that run `1.18.8_1525` or later, your cluster now [integrates more features from {{site.data.keyword.keymanagementserviceshort}}](/docs/containers?topic=containers-encryption#kms-keyprotect-features) when you enable {{site.data.keyword.keymanagementserviceshort}} as the KMS provider for the cluster. When you enable this integration, a **Reader** [service-to-service authorization policy](/docs/account?topic=account-serviceauth) between {{site.data.keyword.containerlong_notm}} and {{site.data.keyword.keymanagementserviceshort}} is automatically created for your cluster, if the policy does not already exist. If you have a cluster that runs an earlier version, [update your cluster](/docs/containers?topic=containers-update) and then [reenable KMS encryption](/docs/containers?topic=containers-encryption#keyprotect) to register your cluster with {{site.data.keyword.keymanagementserviceshort}} again.<br><br>**Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.19.4_1528](/docs/containers?topic=containers-changelog#1194_1528), [1.18.12_1534](/docs/containers?topic=containers-changelog#11812_1534), [1.17.14_1546](/docs/containers?topic=containers-changelog#11714_1546), and [1.16.15_1553](/docs/containers?topic=containers-changelog_archive#11615_1553). |
| 03 December 2020 | <ul><li><strong>Istio add-on</strong>: Versions <a href="/docs/containers?topic=containers-istio-changelog#1614">1.6.14</a> and <a href="/docs/containers?topic=containers-istio-changelog#175">1.7.5</a> of the Istio managed add-on are released.</li><li><strong>Cluster autoscaler add-on</strong>: Patch update <code>1.0.1_146</code> is released. For more information, see the <a href="/docs/openshift?topic=openshift-ca_changelog">Cluster autoscaler add-on changelog</a>.</li></ul> |
| 01 December 2020 | **Default Kubernetes Ingress image**: In all new {{site.data.keyword.containerlong_notm}} clusters, default application load balancers (ALBs) now run the Kubernetes Ingress image. In existing clusters, ALBs continue to run the previously supported {{site.data.keyword.containerlong_notm}} Ingress image, which is now deprecated. For more information and migration actions, see [Setting up Kubernetes Ingress](/docs/containers?topic=containers-ingress-types). |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in December 2020"}

## November 2020
{: #nov20}

| Date | Description |
| ---- | ----------- |
| 24 November 2020 | ![Classic infrastructure provider icon.](images/icon-classic-2.svg) **New! Reservations to reduce classic worker node costs**: Create a reservation with contracts for 1 or 3 year terms for classic worker nodes to lock in a reduced cost for the life of the contract. Typical savings range between 30-50% compared to on-demand worker node costs. Reservations can be created in the {{site.data.keyword.cloud_notm}} console for classic infrastructure only. For more information, see [Reserving instances to reduce classic worker node costs](/docs/containers?topic=containers-reservations). |
| 23 November 2020 | **Worker node versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.19.4_1527](/docs/containers?topic=containers-changelog#1194_1527_worker), [1.18.12_1533](/docs/containers?topic=containers-changelog#11812_1533_worker), [1.17.14_1545](/docs/containers?topic=containers-changelog#11714_1545_worker), and [1.16.15_1552](/docs/containers?topic=containers-changelog_archive#11615_1552_worker). |
| 20 November 2020 | **New! Portieris for image security enforcement**: With the [open source Portieris project](https://github.com/IBM/portieris){: external}, you can set up a Kubernetes admission controller to enforce image security policies by namespace or cluster. Use [Portieris](/docs/Registry?topic=Registry-security_enforce_portieris) instead of the deprecated Container Image Security Enforcement Helm chart. |
| 19 November 2020 | **Ingress ALB changelog**: Updated the [`nginx-ingress` build to 653 and the `ingress-auth` build to 425](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image. |
| 18 November 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.197</a>.</li><li><strong>Knative add-on deprecation</strong>: As of 18 November 2020 the Knative managed add-on is deprecated. On 18 December 2020 the add-on becomes unsupported and can no longer be installed, and on 18 January 2021 the add-on is automatically uninstalled from all clusters. If you use the Knative add-on, consider migrating to the <a href="https://knative.dev/docs/install/">Knative open source project</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> or to <a href="/docs/codeengine?topic=codeengine-getting-started">{{site.data.keyword.codeenginefull}}</a>, which includes the open source capabilities of Knative.</li><li><strong>New! {{site.data.keyword.block_storage_is_short}} changelog</strong>: Added a <a href="/docs/containers?topic=containers-vpc_bs_changelog">changelog</a> for the {{site.data.keyword.block_storage_is_short}} add-on.</li></ul>|
| 16 November 2020 | **GPU worker nodes**: Added a reference to the [NVIDIA GPU operator installation guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#operator-install-guide){: external} in the [deploying a sample GPU workload](/docs/containers?topic=containers-deploy_app#gpu_app) topic.<br><br>**Master versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.19.4_1527](/docs/containers?topic=containers-changelog#1194_1527), [1.18.12_1533](/docs/containers?topic=containers-changelog#11812_1533), [1.17.14_1545](/docs/containers?topic=containers-changelog#11714_1545), and [1.16.15_1552](/docs/containers?topic=containers-changelog_archive#11615_1552).. |
| 13 November 2020 | **{{site.data.keyword.at_full_notm}} and IAM events**: Added [IAM actions and {{site.data.keyword.cloudaccesstrailshort}} events](/docs/containers?topic=containers-api-at-iam#ks-ingress) for the Ingress secret, Ingress ALB, and NLB DNS APIs. |
| 09 November 2020 | <strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1193_1526">1.19.3_1526</a>, <a href="/docs/containers?topic=containers-changelog#11810_1532">1.18.10_1532</a>, <a href="/docs/containers?topic=containers-changelog#11713_1544">1.17.13_1544</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1551">1.16.15_1551</a>.|
| 05 November 2020 | <ul><li><strong>{{site.data.keyword.block_storage_is_short}}</strong>: Added topics for <a href="/docs/containers?topic=containers-vpc-block#vpc-block-fs-verify">verifying your {{site.data.keyword.block_storage_is_short}} file system</a>, <a href="/docs/containers?topic=containers-vpc-block#customize-with-secret">enabling every user to customize the default PVC settings</a>, and <a href="/docs/containers?topic=containers-vpc-block#static-secret">enforcing base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key CRN</a>.</li><li><strong>Classic-enabled VPCs</strong>: Added steps in <a href="/docs/containers?topic=containers-vpc-subnets#ca_subnet_cli">Creating VPC subnets for classic access</a> for creating a classic-enabled VPC and VPC subnets without the automatic default address prefixes.</li><li><strong>Gateway firewalls and Calico policies</strong>: For classic clusters in Dallas and Frankfurt, updated the required IP addresses and ports that you must open in a <a href="/docs/containers?topic=containers-firewall#firewall_outbound">public gateway firewall device</a>, <a href="/docs/containers?topic=containers-firewall#firewall_private">private gateway device firewall</a>, or <a href="https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies">Calico network isolation policies</a>{: external}.</li><li><strong>Istio add-on</strong>: Versions <a href="/docs/containers?topic=containers-istio-changelog#1613">1.6.13</a> and <a href="/docs/containers?topic=containers-istio-changelog#174">1.7.4</a> of the Istio managed add-on are released.</li></ul> |
| 02 November 2020 | <ul><li><strong>General availability of Kubernetes Ingress support:</strong> The Kubernetes Ingress image, which is built on the community Kubernetes project's implementation of the NGINX Ingress controller, is now generally available for the Ingress ALBs in your cluster. To get started, see <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create">Creating ALBs that run the Kubernetes Ingress image</a> or <a href="/docs/containers?topic=containers-ingress-types#alb-type-migration">Changing existing ALBs to run Kubernetes Ingress</a>.</li><li><strong>Persistent storage</strong>: Added the following topics:<ul><li><a href="/docs/containers?topic=containers-object_storage#service_credentials">Creating {{site.data.keyword.cos_full_notm}} service credentials</a></li><li><a href="/docs/containers?topic=containers-object_storage#storage_class_custom">Adding your {{site.data.keyword.cos_full_notm}} credentials to the default storage classes</a></li><li><a href="/docs/containers?topic=containers-storage_br">Backing up and restoring storage data</a></li></ul></li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in November 2020"}

## October 2020
{: #oct20}

| Date | Description |
| ---- | ----------- |
| 26 October 2020 | <ul><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1193_1525">1.19.3_1525</a>, <a href="/docs/containers?topic=containers-changelog#11810_1531">1.18.10_1531</a>, <a href="/docs/containers?topic=containers-changelog#11713_1543">1.17.13_1543</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1550">1.16.15_1550</a>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1193_1525_worker">1.19.3_1525</a>, <a href="/docs/containers?topic=containers-changelog#11810_1531_worker">1.18.10_1531</a>, <a href="/docs/containers?topic=containers-changelog#11713_1543_worker">1.17.13_1543</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11615_1550_worker">1.16.15_1550</a>.</li></ul>|
| 22 October 2020 | <ul><li><strong>API key</strong>: Added more information about <a href="/docs/containers?topic=containers-access-creds#api_key_about">how the {{site.data.keyword.containerlong_notm}} API key is used</a>.</li><li><strong>Benchmark for Kubernetes 1.19</strong>: Review the <a href="/docs/containers?topic=containers-cis-benchmark#cis-benchmark-15">1.5 CIS Kubernetes benchmark results</a> for clusters that run Kubernetes version 1.19.</li><li><strong>Huge pages</strong>: In clusters that run Kubernetes 1.19 or later, you can <a href="/docs/containers?topic=containers-kernel#huge-pages">enable Kubernetes <code>HugePages</code> scheduling on your worker nodes</a>.</li><li><strong>Istio add-on</strong>: Version <a href="/docs/containers?topic=containers-istio-changelog#1612">1.6.12</a> of the Istio managed add-on is released.</li></ul> |
| 16 October 2020 | <ul><li><strong>Gateway firewalls and Calico policies</strong>: For classic clusters in Dallas, updated the required IP addresses and ports that you must open in a <a href="/docs/containers?topic=containers-firewall#firewall_outbound">public gateway firewall device</a>, <a href="/docs/containers?topic=containers-firewall#firewall_private">private gateway device firewall</a>, or <a href="https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies">Calico network isolation policies</a>{: external}.</li><li><strong>Ingress classes</strong>: Added information about <a href="/docs/containers?topic=containers-ingress-types#ingress-class">specifying Ingress classes</a> to apply Ingress resources to specific ALBs.</li><li><strong>{{site.data.keyword.cos_short}}</strong>: Added steps to help you <a href="/docs/containers?topic=containers-object_storage#configure_cos">decide on the object storage configuration</a>, and added troubleshooting steps for when <a href="/docs/containers?topic=containers-cos_operation_not_permitted">app pods fail because of an <code>Operation not permitted</code> error</a>].</li></ul> |
| 13 October 2020 | <ul><li><strong>New! Certified Kubernetes version 1.19</strong>: You can now create clusters that run Kubernetes version 1.19. To update an existing cluster, see the <a href="/docs/containers?topic=containers-cs_versions#cs_v119">Version 1.19 preparation actions</a>. The Kubernetes 1.19 release is also certified.</li><li><strong>Deprecated: Kubernetes version 1.16</strong>: With the release of version 1.19, clusters that run version 1.16 are deprecated. Update your clusters to at least <a href="/docs/containers?topic=containers-cs_versions#cs_v117">version 1.17</a> today.</li><li><strong>New! Network load balancer for VPC</strong>: In VPC Gen 2 clusters that run Kubernetes version 1.19, you can now create a layer 4 Network Load Balancer for VPC. VPC network load balancers offer source IP preservation and increased performance through direct server return (DSR). For more information, see <a href="/docs/containers?topic=containers-vpc-lbaas#lbaas_about">About VPC load balancing in {{site.data.keyword.containerlong_notm}}</a>.</li><li><strong>Version changelogs</strong>: Changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1192_1524">1.19.2_1524</a>.</li><li><strong>VPC load balancer</strong>: Added support for setting the <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-node-selector</code> and <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-subnet</code> annotations when you create new VPC load balancers in clusters that run Kubernetes version 1.19.</li><li><strong>VPC security groups</strong>: Expanded the list of required rules based on the cluster version for default VPC security groups.</li><li><strong>{{site.data.keyword.cos_short}} in VPC Gen 2</strong>: Added support for authorized IP addresses in {{site.data.keyword.cos_full_notm}} for VPC Gen 2. For more information, see <a href="/docs/containers?topic=containers-object_storage#cos_auth_ip">Allowing IP addresses for {{site.data.keyword.cos_full_notm}}</a>.</li></ul> |
| 12 October 2020 | **Versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.18.9_1530](/docs/containers?topic=containers-changelog#1189_1530), [1.17.12_1542](/docs/containers?topic=containers-changelog#11712_1542), and [1.16.15_1549](/docs/containers?topic=containers-changelog_archive#11615_1549). |
| 08 October 2020 | **Ingress ALB changelog**: Updated the [Kubernetes Ingress image build to `0.35.0_474_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0). |
| 06 October 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.178</a>.</li><li><strong>Ingress secret expiration synchronization</strong>: Added a troubleshooting topic for when <a href="/docs/containers?topic=containers-sync_cert_dates">Ingress secret expiration dates are out of sync or are not updated</a>.</li><li><strong>Istio add-on</strong>: Versions <a href="/docs/containers?topic=containers-istio-changelog#173">1.7.3</a> and <a href="/docs/containers?topic=containers-istio-changelog#1611">1.6.11</a> of the Istio managed add-on are released.</li></ul> |
| 01 October 2020 | <ul><li><strong>Default version</strong>: The default version for clusters is now Kubernetes 1.18.</li><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> build to 652 and the <code>ingress-auth</code> build to 424</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in October 2020"}

## September 2020
{: #sep20}

| Date | Description |
| ---- | ----------- |
| 29 September 2020 | **Gateway firewalls and Calico policies**: For classic clusters in London or Dallas, updated the required IP addresses and ports that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound), [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private), or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies){: external}. |
| 28 September 2020 | **Versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.18.9_1529](/docs/containers?topic=containers-changelog#1189_1529), [1.17.12_1541](/docs/containers?topic=containers-changelog#11712_1541), and [1.16.15_1548](/docs/containers?topic=containers-changelog_archive#11615_1548). |
| 24 September 2020 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.171](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 23 September 2020 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> build to 651 and the <code>ingress-auth</code> build to 423</a> for the {{site.data.keyword.containerlong_notm}} Ingress image.</li><li><strong>Istio add-on</strong>: Version <a href="/docs/containers?topic=containers-istio-changelog#172">1.7.2</a> of the Istio managed add-on is released.</li></ul> |
| 22 September 2020 | **Unsupported: Kubernetes version 1.15**: Clusters that run version 1.15 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.|
| 21 September 2020 | **Versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.18.9_1528](/docs/containers?topic=containers-changelog#1189_1528), [1.17.12_1540](/docs/containers?topic=containers-changelog#11712_1540), and [1.16.15_1547](/docs/containers?topic=containers-changelog_archive#11615_1547). |
| 14 September 2020 | <ul><li><strong>Versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1188_1527">1.18.8_1527</a>, <a href="/docs/containers?topic=containers-changelog#11711_1539">1.17.11_1539</a>, <a href="/docs/containers?topic=containers-changelog_archive#11614_1546">1.16.14_1546</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1552">1.15.12_1552</a>.</li><li><strong>Istio add-on</strong>: Versions <a href="/docs/containers?topic=containers-istio-changelog#171">1.7.1</a> and <a href="/docs/containers?topic=containers-istio-changelog#169">1.6.9</a> of the Istio managed add-on are released.</li><li><strong>VPC load balancer</strong>: In version 1.18 and later VPC clusters, added the <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "proxy-protocol"</code> annotation to preserve the source IP address of requests to apps in your cluster.</li></ul> |
| 04 September 2020 | **New! CIS Kubernetes Benchmark**: Added information about {{site.data.keyword.containerlong_notm}} compliance with the [Center for Internet Security (CIS) Kubernetes Benchmark](/docs/containers?topic=containers-cis-benchmark) 1.5 for clusters that run Kubernetes version 1.18. |
| 03 September 2020 | **CA certificate rotation**: Added steps to [revoke existing certificate authority (CA) certificates in your cluster and issue new CA certificates](/docs/containers?topic=containers-security#cert-rotate).|
| 02 September 2020 | **Istio add-on**: [Version 1.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v17) is released. |
| 01 September 2020 | <ul><li><strong>Deprecation of VPC Gen 1 compute</strong>: VPC Generation 1 is deprecated. If you did not create any VPC Gen 1 resources before 01 September 2020, you can no longer provision any VPC Gen 1 resources. If you created any VPC Gen 1 resources before 01 September 2020, you can continue to provision and use VPC Gen 1 resources until 26 February 2021, when all service for VPC Gen 1 ends and all remaining VPC Gen 1 resources are deleted. To ensure continued support, create new VPC clusters on Generation 2 compute only, and move your workloads from existing VPC Gen 1 clusters to VPC Gen 2 clusters.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#1510">Version 1.5.10 of the Istio managed add-on</a> is released.</li></ul>|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in September 2020"}


## August 2020
{: #aug20}

| Date | Description |
| ---- | ----------- |
| 31 August 2020 | **Versions**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.18.8_1526](/docs/containers?topic=containers-changelog#1188_1526), [1.17.11_1538](/docs/containers?topic=containers-changelog#11711_1538), [1.16.14_1545](/docs/containers?topic=containers-changelog_archive#11614_1545), and [1.15.12_1551](/docs/containers?topic=containers-changelog_archive#11512_1551). |
| 27 August 2020 | <ul><li><strong>Observability CLI plug-in</strong>: Added the following commands to manage your {{site.data.keyword.la_full_notm}} and {{site.data.keyword.mon_full_notm}} configurations: <a href="/docs/containers?topic=containers-observability_cli#logging_agent_discover"><code>ibmcloud ob logging agent discover</code></a>, <a href="/docs/containers?topic=containers-observability_cli#logging_config_enable"><code>ibmcloud ob logging config enable public-endpoint</code> or <code>private-endpoint</code></a>, <a href="/docs/containers?topic=containers-observability_cli#logging_config_show"><code>ibmcloud ob logging config show</code></a>, <a href="/docs/containers?topic=containers-observability_cli#monitoring_agent_discover"><code>ibmcloud ob monitoring agent discover</code></a>, and <a href="/docs/containers?topic=containers-observability_cli#monitoring_config_enable"><code>ibmcloud ob monitoring config enable public-endpoint</code> or <code>private-endpoint</code></a>.</li><li><strong>New! Worker node flavors</strong>: You can create worker nodes with new <a href="/docs/containers?topic=containers-planning_worker_nodes#bm-table">bare metal</a> and <a href="/docs/containers?topic=containers-planning_worker_nodes#sds-table">bare metal SDS</a> flavors in the <code>me4c</code> and <code>mb4c</code> flavors. These flavors include 2nd Generation Intel® Xeon® Scalable Processors chip sets for better performance for workloads such as machine learning, AI, and IoT.</li></ul>
| 24 August 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.157</a>.</li><li><strong>Cluster autoscaler</strong>: The <a href="/docs/containers?topic=containers-ca">cluster autoscaler</a> is available as a managed add-on. The cluster autoscaler Helm chart is deprecated. Migrate your autoscaled worker pools to use the add-on.</li><li><strong>New! Community Kubernetes Ingress support:</strong> The Ingress ALBs in your cluster can now run the Kubernetes Ingress image, which is built on the community Kubernetes project's implementation of the NGINX Ingress controller. To use the Kubernetes Ingress image, you create your Ingress resources and configmaps according to the Kubernetes Ingress format, including community Kubernetes Ingress annotations instead of custom {{site.data.keyword.containerlong_notm}} annotations. For more information about the differences between the {{site.data.keyword.containerlong_notm}} Ingress image and the Kubernetes Ingress image, see the <a href="/docs/containers?topic=containers-ingress-types#about-alb-images">Comparison of the ALB image types</a>. To get started, see <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create">Creating ALBs that run the Kubernetes Ingress image</a> or <a href="/docs/containers?topic=containers-ingress-types#alb-type-migration">Changing existing ALBs to run Kubernetes Ingress</a>.</li><li><strong>New! Default {{site.data.keyword.cloudcerts_long}} instances</strong>: A {{site.data.keyword.cloudcerts_long_notm}} service instance is now created by default for all new and existing standard clusters. The {{site.data.keyword.cloudcerts_short}} service instance, which is named in the format <code>kube-crtmgr-&lt;cluster_ID&gt;</code>, stores the TLS certificate for your cluster's default Ingress subdomain. You can also upload your own TLS certificates for custom Ingress domains to this {{site.data.keyword.cloudcerts_short}} instance and use the new <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_create"><code>ibmcloud ks ingress secret</code> commands</a> to create secrets for these certificates in your cluster. To ensure that a {{site.data.keyword.cloudcerts_short}} instance is automatically created for your new or existing cluster, <a href="/docs/containers?topic=containers-ingress-types#manage_certs">verify that the API key for the region and resource group that the cluster is created in has the correct {{site.data.keyword.cloudcerts_short}} permissions</a>.</li></ul> | 
| 18 August 2020 | **Versions**: Master fix pack update changelog documentation is available for Kubernetes version [1.18.8_1525](/docs/containers?topic=containers-changelog#1188_1525_master), [1.17.11_1537](/docs/containers?topic=containers-changelog#11711_1537_master), [1.16.14_1544](/docs/containers?topic=containers-changelog_archive#11614_1544_master), and [1.15.12_1550](/docs/containers?topic=containers-changelog_archive#11512_1550_master). |
| 17 August 2020 | <ul><li><strong>Locations</strong>: You can create <a href="/docs/containers?topic=containers-regions-and-zones#zones-vpc">clusters on VPC infrastructure</a> in the Tokyo multizone region.</li><li><strong>Versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1188_1525">1.18.8_1525</a>, <a href="/docs/containers?topic=containers-changelog#11711_1537">1.17.11_1537</a>, <a href="/docs/containers?topic=containers-changelog_archive#11614_1544">1.16.14_1544</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1550">1.15.12_1550</a>.</li><li><strong>VPC Gen 2</strong>: Added a tutorial for migrating VPC Gen 1 cluster resources to VPC Gen 2.</li></ul>|
| 12 August 2020 | **Istio add-on**: [Version 1.6.8](/docs/containers?topic=containers-istio-changelog#168) and [version 1.5.9](/docs/containers?topic=containers-istio-changelog#159) of the Istio managed add-on are released. |
| 06 August 2020 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.143](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 05 August 2020 | **Ingress ALB changelog**: Updated the [`nginx-ingress` image build to 647 and the `ingress-auth` image build to 421](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog). |
| 04 August 2020 | **Istio add-on**: [Version 1.6.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#167) is released. |
| 03 August 2020 | <ul><li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_private">required IP addresses and ports</a> that you must open in a private gateway device firewall.</li><li><strong>Versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1186_1523">1.18.6_1523</a>, <a href="/docs/containers?topic=containers-changelog#1179_1535">1.17.9_1535</a>, <a href="/docs/containers?topic=containers-changelog_archive#11613_1542">1.16.13_1542</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1549">1.15.12_1549</a>.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in August 2020"}

## July 2020
{: #july20}

| Date | Description |
| ---- | ----------- |
| 31 July 2020 | **{{site.data.keyword.openshiftshort}} version 4.4**: The [{{site.data.keyword.openshiftshort}} version 4.4 release](/docs/containers?topic=containers-cs_versions#cs_v118) is certified for Kubernetes version 1.17. |
| 28 July 2020 | <ul><li><strong>Ingress ALB versions</strong>: Added the <code>ibmcloud ks ingress alb versions</code> CLI command to show the available versions for the ALBs in your cluster and the <code>ibmcloud ks ingress alb update</code> CLI command to update or rollback ALBs to a specific version.</li><li><strong>UI for creating clusters</strong>: Updated getting started and task topics for the updated process for the [Kubernetes cluster creation console](https://cloud.ibm.com/kubernetes/catalog/create){: external}.</li></ul> |
| 24 July 2020 | <ul><li><strong>Minimum cluster size</strong>: Added an FAQ about <a href="/docs/containers?topic=containers-faqs#smallest_cluster">the smallest size cluster that you can make</a>.</li><li><strong>Versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1186_1522">1.18.6_1522</a>, <a href="/docs/containers?topic=containers-changelog#1179_1534">1.17.9_1534</a>, <a href="/docs/containers?topic=containers-changelog_archive#11613_1541">1.16.13_1541</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1548">1.15.12_1548</a>.</li><li><strong>Worker node replacement</strong>: Added a troubleshooting topic for when <a href="/docs/containers?topic=containers-auto-rebalance-off">replacing a worker node does not create a worker node</a>.</li></ul>|
| 20 July 2020 | <ul><li><strong>Master versions</strong>: Master fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1186_1521">1.18.6_1521</a>, <a href="/docs/containers?topic=containers-changelog#1179_1533">1.17.9_1533</a>, <a href="/docs/containers?topic=containers-changelog_archive#11613_1540">1.16.13_1540</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1547">1.15.12_1547</a>.</li><li><strong>Worker node versions</strong>: Worker node fix pack update changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1186_1520">1.18.6_1520</a>, <a href="/docs/containers?topic=containers-changelog#1179_1532">1.17.9_1532</a>, <a href="/docs/containers?topic=containers-changelog_archive#11613_1539">1.16.13_1539</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11512_1546">1.15.12_1546</a>.</li></ul> |
| 17 July 2020 | **Istio add-on**: [Version 1.6.5 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#165) is released. |
| 16 July 2020 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image build to 645 and the <code>ingress-auth</code> image build to 420</a>.</li><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#158">Version 1.5.8 of the Istio managed add-on</a> is released.</li><li><strong>Istio ports</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_outbound">required IP addresses and ports</a> that you must open in a public gateway device to use the managed Istio add-on.</li><li><strong>Pod and service subnets</strong>: Added information about bringing your own pod and service subnets in <a href="/docs/containers?topic=containers-subnets#basics_subnets">classic</a> or <a href="/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets">VPC clusters</a>.</li></ul> |
| 08 July 2020 | <ul><li><strong>Istio add-on</strong>: <a href="/docs/containers?topic=containers-istio-changelog#16">Version 1.6 of the Istio managed add-on</a> is released.</li><li><strong>Knative add-on</strong>: Version 0.15.1 of the Knative managed add-on is released. If you installed the Knative add-on before, you must uninstall and reinstall the add-on to apply these changes in your cluster.</li></ul> |
| 07 July 2020 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.118](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 06 July 2020 | **Version changelogs**: Worker node fix pack update changelog documentation is available for Kubernetes version [1.18.4_1518](/docs/containers?topic=containers-changelog#1184_1518), [1.17.7_1530](/docs/containers?topic=containers-changelog#1177_1530), [1.16.11_1537](/docs/containers?topic=containers-changelog_archive#11611_1537), and [1.15.12_1544](/docs/containers?topic=containers-changelog_archive#11512_1544). |
| 02 July 2020 | <strong>VPC load balancer</strong>: Added support for specifying the <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone</code> annotation in the <a href="/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb">configuration file for VPC load balancers</a>. |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in July 2020"}

## June 2020
{: #june20}

| Date | Description |
| ---- | ----------- |
| 24 June 2020 | <ul><li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_outbound">required IP addresses and ports</a> that you must open in a public gateway device.</li><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>ingress-auth</code> image build to 413</a>.</li></ul> |
| 23 June 2020 | **Istio add-on**: [Version 1.5.6 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#15) is released.|
| 22 June 2020 | **Version changelogs**: Changelog documentation is available for Kubernetes version [1.18.4_1517](/docs/containers?topic=containers-changelog#1184_1517), [1.17.7_1529](/docs/containers?topic=containers-changelog#1177_1529), [1.16.11_1536](/docs/containers?topic=containers-changelog_archive#11611_1536), and [1.15.12_1543](/docs/containers?topic=containers-changelog_archive#11512_1543).
| 18 June 2020 | **Ingress ALB changelog**: Updated the [`ingress-auth` image build to 413](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).|
| 16 June 2020 | <strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.99</a>.|
| 09 June 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.94</a>.</li><li><strong>Permissions</strong>: Added a <a href="/docs/containers?topic=containers-access_reference#cluster_create_permissions">Permissions to create a cluster</a> reference topic, and restructured cluster creation and user access topics to refer to this reference topic.</li><li><strong>New! Static routes add-on</strong>: Added information about creating static routes on your worker nodes by enabling the <a href="/docs/containers?topic=containers-static-routes">static routes cluster add-on</a>.</li></ul> |
| 08 June 2020 | **Version changelogs**: Worker node changelog documentation is available for Kubernetes [1.18.3_1515](/docs/containers?topic=containers-changelog#1183_1515), [1.17.6_1527](/docs/containers?topic=containers-changelog#1176_1527), [1.16.10_1534](/docs/containers?topic=containers-changelog_archive#11610_1534), and [1.15.12_1541](/docs/containers?topic=containers-changelog_archive#11512_1541). |
| 04 June 2020 | <ul><li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_outbound">required IP addresses and ports</a> that you must open in a public gateway device firewall.</li><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image build to 637</a>.</li><li><strong>Istio mTLS</strong>: Changed the sample <a href="/docs/containers?topic=containers-istio-mesh#mtls">mTLS policy</a> to use <code>kind: "PeerAuthentication"</code>.</li><li><strong>VPC network security</strong>: Expanded information about your options for using access control lists (ACLs), security groups, and other network policies to <a href="/docs/containers?topic=containers-vpc-network-policy">control traffic to and from your VPC cluster</a>.</li></ul>|
| 01 June 2020 | <ul><li><strong>Kubernetes 1.17</strong>: <a href="/docs/containers?topic=containers-cs_versions#version_types">Kubernetes 1.17</a> is now the default version.</li><li><strong>VPC ACLs</strong>: Added required rules for using VPC load balancers to steps for [Creating access control lists (ACLs) to control traffic to and from your VPC cluster](/docs/containers?topic=containers-vpc-network-policy#acls).</li></ul>|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in June 2020"}

## May 2020
{: #may20}

| Date | Description |
| ---- | ----------- |
| 31 May 2020 | **Unsupported: Kubernetes version 1.14**: With the release of version 1.18, clusters that run version 1.14 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately. |
| 26 May 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.84</a>.</li><li><strong>Image pull secrets</strong>: Now, the <code>default-icr-io</code> and <code>default-&lt;region&gt;-icr-io</code> image pull secrets in the <code>default</code> project are replaced by a single <code>all-icr-io</code> image pull secret that has credentials to all the public and private regional registry domains. Clusters that run Kubernetes 1.15 - 1.17 still have the previous <code>default-&lt;region&gt;-icr-io</code> image pull secrets for backwards compatibility.</li><li><strong>Ingress status</strong>: Added information about <a href="/docs/containers?topic=containers-ingress-status">health reporting for your Ingress components</a>.</li><li><strong>NodeLocal DNS cache</strong>: Added how to customize the <a href="/docs/containers?topic=containers-cluster_dns#dns_nodelocal_customize">NodeLocal DNS cache</a>.<li><strong>Version changelogs</strong>: Master and worker node changelog documentation is available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1183_1514">1.18.3_1514</a>, <a href="/docs/containers?topic=containers-changelog#1176_1526">1.17.6_1526</a>, <a href="/docs/containers?topic=containers-changelog_archive#11610_1533">1.16.10_1533</a>, <a href="/docs/containers?topic=containers-changelog_archive#11512_1540">1.15.12_1540</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1555">1.14.10_1555</a>.</li></ul> |
| 20 May 2020 | **New! Virtual Private Cloud Generation 2**: You can now create standard Kubernetes clusters in your [Gen 2 Virtual Private Cloud (VPC)](/docs/vpc?topic=vpc-getting-started). VPC gives you the security of a private cloud environment with the dynamic scalability of a public cloud. VPC Gen 2 clusters are available for only standard, Kubernetes clusters and are not supported in free clusters.<br><br> For more information, check out the following links:<ul><li><a href="/docs/containers?topic=containers-infrastructure_providers">Overview of Classic and VPC infrastructure providers</a></li><li><a href="/docs/containers?topic=containers-planning_worker_nodes#vm">Supported virtual machine flavors for VPC Gen 2 worker nodes</a></li><li><a href="/docs/containers?topic=containers-kubernetes-service-cli">New VPC Gen 2 commands for the CLI</a></li><li><a href="/docs/containers?topic=containers-limitations#ks_vpc_gen2_limits">VPC cluster limitations</a></li></ul>Ready to get started? Try out the [Creating a cluster in your VPC on generation 2 compute tutorial](/docs/containers?topic=containers-vpc_ks_tutorial).|
| 19 May 2020 | **Istio add-on**: [Version 1.5 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#15) is released.|
| 18 May 2020 | **Ingress ALB changelog**: Updated the [`nginx-ingress` image build to 628](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).|
| 14 May 2020 | **Kubernetes version 1.18**: [Kubernetes 1.18 release](/docs/containers?topic=containers-cs_versions#cs_v118) is certified.|
| 11 May 2020 | <ul><li><strong>New! Kubernetes version 1.18</strong>: You can now create clusters that run Kubernetes version 1.18. To update an existing cluster, see the <a href="/docs/containers?topic=containers-cs_versions#cs_v118">Version 1.18 preparation actions</a>.</li><li><strong>Deprecated: Kubernetes version 1.15</strong>: With the release of version 1.18, clusters that run version 1.15 are deprecated. Consider <a href="/docs/containers?topic=containers-cs_versions#cs_v116">updating to at least version 1.16</a> today.</li><li><strong>NodeLocal DNS cache</strong>: <a href="/docs/containers?topic=containers-cluster_dns#dns_cache">NodeLocal DNS cache</a> is generally available for clusters that run Kubernetes 1.18, but still not enabled by default.</li><li><strong>Zone-aware DNS beta</strong>: For multizone clusters that run Kubernetes 1.18, you can set up <a href="/docs/containers?topic=containers-cluster_dns#dns_zone_aware">zone-aware DNS</a> to improve DNS performance and availability.</li><li><strong>Version changelogs</strong>: Changelog documentation is available for Kubernetes version <a href="/docs/containers?topic=containers-changelog#1182_1512">1.18.2_1512</a>. Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1175_1524">1.17.5_1524</a>, <a href="/docs/containers?topic=containers-changelog_archive#1169_1531">1.16.9_1531</a>, <a href="/docs/containers?topic=containers-changelog_archive#11511_1538">1.15.11_1538</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1554">1.14.10_1554</a>.</li></ul> |
| 08 May 2020 | **CLI changelog**: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.57](/docs/containers?topic=containers-cs_cli_changelog#10). |
| 06 May 2020 | **New! {{site.data.keyword.containerlong_notm}} observability plug-in**: You can now use the {{site.data.keyword.containerlong_notm}} observability plug-in to create a logging or monitoring configuration for your cluster so that you can forward cluster logs and metrics to an {{site.data.keyword.la_full_notm}} and {{site.data.keyword.mon_full_notm}} service instance. For more information, see [Forwarding cluster and app logs to {{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health#logging) and [Viewing cluster and app metrics with {{site.data.keyword.mon_full_notm}}](/docs/containers?topic=containers-health-monitor). You can also use the command line to create the logging and monitoring configuration. For more information, see the [Observability plug-in CLI](/docs/containers?topic=containers-observability_cli) reference. |
| 04 May 2020 | <ul><li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_outbound">required IP addresses and ports</a> that you must open in a public gateway device firewall.</li><li><strong>Ingress troubleshooting</strong>:Added a <a href="/docs/containers?topic=containers-alb-pod-affinity">troubleshooting topic</a> for when ALB pods do not deploy correctly to worker nodes.</li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in May 2020"}

## April 2020
{: #apr20}

| Date | Description |
| ---- | ----------- |
| 30 April 2020 | **Cluster and worker node quotas**: Now, each region in your {{site.data.keyword.cloud_notm}} account has quotas for {{site.data.keyword.containershort}} clusters and workers. You can have **100 clusters** and **500 worker nodes** across clusters per region and per [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers). With quotas in place, your account is better protected from accidental requests or billing surprises. Need more clusters? No problem, just [contact IBM Support](/docs/get-support?topic=get-support-using-avatar). In the support case, include the new cluster or worker node quota limit for the region and infrastructure provider that you want. For more information, see the [Service limitations](/docs/containers?topic=containers-limitations). |
| 29 April 2020 | <ul><li><strong>ALB pod scaling</strong>: Added steps for scaling up your ALB processing capabilities by <a href="/docs/containers?topic=containers-ingress-types#alb_replicas">increasing the number of ALB pods replicas</a>.</li><li><strong>VPC cluster architecture</strong>: Refreshed <a href="/docs/containers?topic=containers-service-arch#architecture_vpc">networking diagrams for VPC scenarios</a>.</li><li><strong>VPC cluster master access</strong>: Updated <a href="/docs/containers?topic=containers-access_cluster#vpc_private_se">accessing the master via a private cloud service endpoint</a> for VPC clusters. </li></ul> |
| 27 April 2020 | <ul><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>ingress-auth</code> image build to 401</a>.</li><li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1175_1523">1.17.5_1523</a>, <a href="/docs/containers?topic=containers-changelog_archive#1169_1530">1.16.9_1530</a>, <a href="/docs/containers?topic=containers-changelog_archive#11511_1537">1.15.11_1537</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1553">1.14.10_1553</a>.</li></ul> |
| 23 April 2020 | **Version changelogs**: Master patch updates are available for Kubernetes [1.17.5_1522](/docs/containers?topic=containers-changelog#1175_1522), [1.16.9_1529](/docs/containers?topic=containers-changelog_archive#1169_1529), [1.15.11_1536](/docs/containers?topic=containers-changelog_archive#11511_1536), and [1.14.10_1552](/docs/containers?topic=containers-changelog_archive#11410_1552). |
| 22 April 2020 | <ul><li><strong>Private network connection to registry</strong>: For accounts that have VRF and service endpoints enabled, image push and pull traffic to {{site.data.keyword.registrylong_notm}} is now on <a href="/docs/containers?topic=containers-registry#cluster_registry_auth_private">the private network</a>.</li></ul>|
| 17 April 2020 | **Version changelog**: Master patch updates are available for Kubernetes [1.17.4_1521](/docs/containers?topic=containers-changelog#1174_1521_master). |
| 16 April 2020 | **Ingress ALB changelog**: Updated the [`ingress-auth` image build to 394](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).|
| 13 April 2020 | <ul><li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#firewall_private">required IP addresses and ports</a> that you must open in a private gateway device firewall for {{site.data.keyword.registrylong_notm}}.</li><li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1174_1521">1.17.4_1521</a>, <a href="/docs/containers?topic=containers-changelog_archive#1168_1528">1.16.7_1528</a>, <a href="/docs/containers?topic=containers-changelog_archive#11511_1535">1.15.10_1535</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1551">1.14.10_1551</a>.</li></ul>
| 06 April 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.28</a>.</li><li><strong>Kubernetes cluster context</strong>: Added topics for <a href="/docs/containers?topic=containers-cs_cli_install#cli_config_multiple">Setting the Kubernetes context for multiple clusters</a> and <a href="/docs/containers?topic=containers-cs_cli_install#cli_temp_kubeconfig">Creating a temporary <code>kubeconfig</code> file</a>.</li></ul> |
| 01 April 2020 | **Istio add-on**: [Version 1.4.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#147) is released.|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in April 2020"}

## March 2020
{: #mar20}

| Date | Description |
| ---- | ----------- |
| 30 March 2020 | <ul><li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1174_1520">1.17.3_1520</a>, <a href="/docs/containers?topic=containers-changelog_archive#1168_1527">1.16.7_1527</a>, <a href="/docs/containers?topic=containers-changelog_archive#11511_1534">1.15.10_1534</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1550">1.14.10_1550</a>.</li><li><strong><code>gid</code> file storage classes</strong>: Added <code>gid</code> file storage classes to specify a supplemental group ID that you can assign to a non-root user ID so that the non-root user can read and write to the file storage instance. For more information, see the <a href="/docs/containers?topic=containers-file_storage#file_storageclass_reference">storage class reference</a>. </li></ul> |
| 27 March 2020 | **Tech overview**: Added an [Overview of personal and sensitive data storage and removal options](/docs/containers?topic=containers-service-arch#ibm-data). |
| 25 March 2020 | <strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image build to 627</a>. |
| 24 March 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.15</a>.</li><li><strong>Service dependencies</strong>: Added information about <a href="/docs/containers?topic=containers-service-arch#dependencies-ibmcloud">dependencies on other {{site.data.keyword.cloud_notm}} and 3rd party services</a>.</li></ul> |
| 18 March 2020 | <ul><li><strong>IAM issuer details</strong>: Added a <a href="/docs/containers?topic=containers-access_reference#iam_issuer_users">reference topic</a> for the IAM issuer details of RBAC users.</li></ul> |
| 16 March 2020 | <ul><li><strong>New! CLI 1.0</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#10">release of version 1.0.0</a>. This version contains permanent syntax and behavior changes that are not compatible with earlier versions, so before you update be sure to follow the guidance in <a href="/docs/containers?topic=containers-cs_cli_changelog#changelog_beta">Using version 1.0 of the plug-in</a>.</li><li><strong>Installing SGX drivers</strong>: Added a topic for <a href="/docs/containers?topic=containers-add_workers#install-sgx">installing SGX drivers and platform software on SGX-capable worker nodes</a>.</li><li><strong>Sizing workloads</strong>: Enhanced the topic with a <a href="/docs/containers?topic=containers-strategy#sizing_manage">How do I monitor resource usage and capacity in my cluster?</a> FAQ.</li><li><strong><code>sticky-cookie-services</code> annotation</strong>: Added the <code>secure</code> and <code>httponly</code> parameters to the <a href="/docs/containers?topic=containers-comm-ingress-annotations#session-affinity-cookies"><code>sticky-cookie-services</code> annotation</a>.</li><li><strong>Version changelogs</strong>: Master and worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1174_1519">1.17.4_1519</a>, <a href="/docs/containers?topic=containers-changelog_archive#1168_1526">1.16.8_1526</a>, <a href="/docs/containers?topic=containers-changelog_archive#11511_1533">1.15.11_1533</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11410_1549">1.14.10_1549</a></li></ul> |
| 12 March 2020 | **Version update policy**: Now, you can update your cluster master version only to the next version (`n+1`). For example, if your cluster runs Kubernetes version 1.15 and you want to update to the latest version, 1.17, you must first update to 1.16.|
| 10 March 2020 | **Istio add-on**: [Version 1.4.6 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#146) is released.|
| 09 March 2020 | <ul><li><strong>Add-on troubleshooting</strong>: Added a troubleshooting page for managed add-ons, including a topic for <a href="/docs/containers?topic=containers-debug_addons">reviewing add-on state and statuses</a>.</li><li><strong>Managing Ingress ALBs</strong>: Added a page for <a href="/docs/containers?topic=containers-ingress-types">managing the lifecycle of your ALBs</a>, including information about creating, updating, and moving ALBs.</li><li><strong>Kubernetes 1.16</strong>: <a href="/docs/containers?topic=containers-cs_versions#version_types">Kubernetes 1.16</a> is now the default version.</li><li><strong>Updating the {{site.data.keyword.block_storage_is_short}} add-on</strong>: Added steps to update the {{site.data.keyword.block_storage_is_short}} add-on.</li></ul> |
| 04 March 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog#04">release of version 0.4.102</a>.</li><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>ingress-auth</code> image build to 390</a>.</li></ul> |
| 02 March 2020 | **Version changelogs**: Worker node patch updates are available for Kubernetes [1.17.3_1518](/docs/containers?topic=containers-changelog#1173_1518), [1.16.7_1525](/docs/containers?topic=containers-changelog_archive#1167_1525), [1.15.10_1532](/docs/containers?topic=containers-changelog_archive#11510_1532), and [1.14.10_1548](/docs/containers?topic=containers-changelog_archive#11410_1548). |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in March 2020"}

## February 2020
{: #feb20}

| Date | Description |
| ---- | ----------- |
| 28 February 2020 | **VPC clusters**: You can create VPC generation 1 compute clusters in the [**Washington DC** location (`us-east` region)](/docs/containers?topic=containers-regions-and-zones#zones-vpc). |
| 22 February 2020 | **Unsupported: Kubernetes version 1.13**: With the release of version 1.17, clusters that run version 1.13 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately. |
| 19 February 2020 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.90</a>.</li><li><strong>Developing and deploying apps</strong>: You can now find expanded information on how to develop and deploy an app to your Kubernetes cluster in the following pages:<ul><li><a href="/docs/containers?topic=containers-plan_deploy">Planning app deployments</a></li><li><a href="/docs/containers?topic=containers-images">Building containers from images</a></li><li><a href="/docs/containers?topic=containers-app">Developing Kubernetes-native apps</a></li><li><a href="/docs/containers?topic=containers-deploy_app">Deploying Kubernetes-native apps in clusters</a></li><li><a href="/docs/containers?topic=containers-update_app">Managing the app lifecycle</a></li></ul></li><li><strong>Learning paths</strong>: Curated learning paths for <a href="/docs/containers?topic=containers-learning-path-admin">administrators</a> and <a href="/docs/containers?topic=containers-learning-path-dev">developers</a> are now available to help guide you through your {{site.data.keyword.containerlong_notm}} experience.</li><li><strong>Setting up image build pipelines</strong>: You can now find expanded information on how to set up an image registry and build pipelines in the following pages:<ul><li><a href="/docs/containers?topic=containers-registry">Setting up an image registry</a></li><li><a href="/docs/containers?topic=containers-cicd">Setting up continuous integration and delivery</a></li></ul></li><li><strong>Firewall subnets</strong>: Removed outdated <a href="/docs/containers?topic=containers-firewall#vyatta_firewall">subnet IP addresses for {{site.data.keyword.registrylong_notm}}</a>.</li></ul> |
| 17 February 2020 | <ul><li><strong>Kubernetes version 1.17</strong>: <a href="/docs/containers?topic=containers-cs_versions#cs_v117">Kubernetes 1.17 release</a> is certified.</li><li><strong>Version changelogs</strong>: Master and worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog#1173_1516">1.17.3_1516</a>, <a href="/docs/containers?topic=containers-changelog_archive#1167_1524">1.16.7_1524</a>, <a href="/docs/containers?topic=containers-changelog_archive#11510_1531">1.15.10_1531</a>, <a href="/docs/containers?topic=containers-changelog_archive#11410_1547">1.14.10_1547</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1550">1.13.12_1550</a></li></ul>|
| 14 February 2020 | **Istio add-on**: [Version 1.4.4 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#144) is released. |
| 10 February 2020 | <ul><li><strong>New! Kubernetes version 1.17</strong>: You can now create clusters that run Kubernetes version 1.17. To update an existing cluster, see the <a href="/docs/containers?topic=containers-cs_versions#cs_v117">Version 1.17 preparation actions</a>.</li><li><strong>Deprecated: Kubernetes version 1.14</strong>: With the release of version 1.17, clusters that run version 1.14 are deprecated. Consider <a href="/docs/containers?topic=containers-cs_versions#cs_v115">updating to at least version 1.15</a> today.</li><li><strong>VPC cluster creation troubleshooting</strong>: Added <a href="/docs/containers?topic=containers-ts_no_vpc">troubleshooting steps</a> for when no VPCs are listed when you try to create a VPC cluster in the console.</li><li><strong>Knative changelogs:</strong> Check out the changes that are included in version 0.12.1 of the managed Knative add-on. If you installed the Knative add-on before, you must uninstall and reinstall the add-on to apply these changes in your cluster.</li> </ul> |
| 06 February 2020 | <ul><li><strong>Cluster autoscaler</strong>: Added a <a href="/docs/containers?topic=containers-debug_cluster_autoscaler">debugging guide for the cluster autoscaler</a>.</li><li><strong>Tags</strong>: Added how to <a href="/docs/containers?topic=containers-add_workers#cluster_tags">add {{site.data.keyword.cloud_notm}} tags to existing clusters</a>.</li><li><strong>VPC security groups</strong>: <a href="/docs/containers?topic=containers-vpc-network-policy#security_groups">Modify the security group rules</a> for VPC Gen 2 clusters to allow traffic requests that are routed to node ports on your worker nodes.</li></ul> |
| 03 February 2020 | <ul><li><strong>Version changelog</strong>: Updates are available for Kubernetes worker node fix packs <a href="/docs/containers?topic=containers-changelog_archive#1165_1523">1.16.5_1523</a>, <a href="/docs/containers?topic=containers-changelog_archive#1158_1530">1.15.8_1530</a>, <a href="/docs/containers?topic=containers-changelog_archive#11410_1546">1.14.10_1546</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1549">1.13.12_1549</a>.</li><li><strong>Expanded troubleshooting</strong>: You can now find troubleshooting steps for {{site.data.keyword.containerlong_notm}} clusters in the following pages:<ul><li><a href="/docs/containers?topic=containers-debug_clusters">Clusters and masters</a></li><li><a href="/docs/containers?topic=containers-debug_worker_nodes">Worker nodes</a></li><li><a href="/docs/containers?topic=containers-coredns_lameduck">Cluster networking</a></li><li><a href="/docs/containers?topic=containers-debug_apps">Apps and integrations</a></li><li><a href="/docs/containers?topic=containers-cs_loadbalancer_fails">Load balancers</a></li><li><a href="/docs/containers?topic=containers-debug_worker_nodes">Ingress</a></li><li>Persistent storage</li></ul></li></ul> |
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in February 2020"}

## January 2020
{: #jan20}

| Date | Description |
| ---- | ----------- |
| 30 January 2020 | **Ingress ALB changelog**: Updated the [`nginx-ingress` image build to 625](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog). |
| 27 January 2020 | <ul><li><strong>Istio changelog</strong>: Added an <a href="/docs/containers?topic=containers-istio-changelog">Istio add-on version changelog</a>.</li><li><strong>Back up and restore File and Block storage</strong>: Added steps for deploying the <a href="/docs/containers?topic=containers-utilities#ibmcloud-backup-restore"><code>ibmcloud-backup-restore</code> Helm chart</a>.</li></ul> |
| 22 January 2020 | **Kubernetes 1.15**: [Kubernetes 1.15](/docs/containers?topic=containers-cs_versions#version_types) is now the default version. |
| 21 January 2020 | **Default {{site.data.keyword.containerlong_notm}} settings**: Review the [default settings](/docs/containers?topic=containers-service-settings) for Kubernetes components, such as the `kube-apiserver`, `kubelet`, or `kube-proxy`. |
| 20 January 2020 | <ul><li><strong>Helm version 3</strong>: Updated <a href="/docs/containers?topic=containers-helm">Adding services by using Helm charts</a> to include steps for installing Helm v3 in your cluster. Migrate to Helm v3 today for several advantages over Helm v2, such as the removal of the Helm server, Tiller.</li><li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image build to 621</a>.</li><li><strong>Version changelog</strong>: Patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1165_1522">1.16.5_1522</a>, <a href="/docs/containers?topic=containers-changelog_archive#1158_1529">1.15.8_1529</a>, <a href="/docs/containers?topic=containers-changelog_archive#11410_1545">1.14.10_1545</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1548">1.13.12_1548</a>.</li></ul> |
| 13 January 2020 | **{{site.data.keyword.blockstorageshort}}**: Added steps for [adding raw {{site.data.keyword.blockstorageshort}} to VPC worker nodes](/docs/containers?topic=containers-utilities#vpc_api_attach). |
| 06 January 2020 | **Ingress ALB changelog**: Updated the [`ingress-auth` image to build 373](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).|
| 03 January 2020 | **Version changelog**: Worker node patch updates are available for Kubernetes [1.16.3_1521](/docs/containers?topic=containers-changelog_archive#1163_1521), [1.15.6_1528](/docs/containers?topic=containers-changelog_archive#1156_1528), [1.14.9_1544](/docs/containers?topic=containers-changelog_archive#1149_1544), and [1.13.12_1547](/docs/containers?topic=containers-changelog_archive#11312_1547).|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in January 2020"}

## December 2019
{: #dec19}

| Date | Description |
| ---- | ----------- |
| 18 December 2019 | **Ingress ALB changelog**: Updated the [`nginx-ingress` image build to 615 and the `ingress-auth` image to build 372](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog). |
| 17 December 2019 | <ul><li><strong>Version changelog</strong>: Master patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1163_1520">1.16.3_1520</a>, <a href="/docs/containers?topic=containers-changelog_archive#1156_1527">1.15.6_1527</a>, <a href="/docs/containers?topic=containers-changelog_archive#1149_1543">1.14.9_1543</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1546">1.13.12_1546</a>.</li><li><strong>Adding classic infrastructure servers to gateway-enabled clusters</strong>: <a href="/docs/containers?topic=containers-add_workers#gateway_vsi">Adding classic IBM Cloud infrastructure server instances to your cluster network</a> is now generally available for classic gateway-enabled clusters.</li><li><strong>Assigning access</strong>: Updated the steps to <a href="/docs/containers?topic=containers-users#add_users">assign access to your clusters through the {{site.data.keyword.cloud_notm}} IAM console</a>.</li></ul>|
| 12 December 2019 | **Setting up a service mesh with Istio**: Includes the following new pages:<ul><li><a href="/docs/containers?topic=containers-istio-about">About the managed Istio add-on</a></li><li><a href="/docs/containers?topic=containers-istio">Setting up Istio</a></li><li><a href="/docs/containers?topic=containers-istio-mesh">Managing apps in the service mesh</a></li><li><a href="/docs/containers?topic=containers-istio-health">Observing Istio traffic</a></li></ul>|
| 11 December 2019 | <ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.64</a>.</li><li><strong>Configuring VPC subnets</strong>: <a href="/docs/containers?topic=containers-vpc-subnets">Added information</a> about configuring VPC subnets, public gateways, and network segmentation for your VPC clusters.</li><li><strong>Kubernetes version lifecycles</strong>: Added information about <a href="/docs/containers?topic=containers-cs_versions#release_lifecycle">the release lifecycle of supported Kubernetes versions</a>.</li><li><strong>Managed Knative add-on</strong>: Added information about Istio version support.</li></ul>|
| 09 December 2019 | **Version changelog**: Worker node patch updates are available for Kubernetes [1.16.3_1519](/docs/containers?topic=containers-changelog_archive#1163_1519_worker), [1.15.6_1526](/docs/containers?topic=containers-changelog_archive#1156_1526_worker), [1.14.9_1542](/docs/containers?topic=containers-changelog_archive#1149_1542_worker), and [1.13.12_1545](/docs/containers?topic=containers-changelog_archive#11312_1545_worker). |
| 04 December 2019 | <ul><li><strong>Exposing apps with load balancers or Ingress ALBs</strong>: Added quick start pages to help you get up and running with <a href="/docs/containers?topic=containers-loadbalancer-qs">load balancers</a> and <a href="/docs/containers?topic=containers-ingress-types">Ingress ALBs</a>.</li><li><strong>Kubernetes web terminal for VPC clusters</strong>: To use the Kubernetes web terminal for VPC clusters, make sure to <a href="/docs/containers?topic=containers-cs_cli_install#cli_web">configure access to external endpoints</a>.</li><li><strong>Monitoring Istio</strong>: Added <a href="/docs/containers?topic=containers-istio-health#istio_inspect">steps</a> to launch the ControlZ component inspection and Envoy sidecar dashboards for the Istio managed add-on.</li><li><strong>Tuning network performance</strong>: Added <a href="/docs/containers?topic=containers-kernel#calico-portmap">steps</a> for disabling the <code>portmap</code> plug-in for for the Calico container network interface (CNI).</li><li><strong>Use the internal KVDB in Portworx</strong>: Automatically set up a key-value database (KVDB) during the Portworx installation to store your Portworx metadata. For more information, see <a href="/docs/containers?topic=containers-portworx#portworx-kvdb">Using the Portworx KVDB</a>.</li></ul>|
{: summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three."}
{: caption="Documentation updates in December 2019"}

## November 2019
{: #nov19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Documentation updates in November 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
    <td>26 November 2019</td>
    <td><ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.61</a>.</li>
    <li><strong>Cluster autoscaling for VPC clusters</strong>: You can <a href="/docs/containers?topic=containers-ca#ca_helm">set up the cluster autoscaler</a> on clusters that run on the first generation of compute for Virtual Private Cloud (VPC).</li>
    <li><strong>New! Reservations and limits for PIDs</strong>: Worker nodes that run Kubernetes version 1.14 or later set [process ID (PID) reservations and limits that vary by flavor](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node), to help prevent malicious or runaway apps from consuming all available PIDs.</li>
    <li><strong>Version changelog</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1163_1518_worker">1.16.3_1518</a>, <a href="/docs/containers?topic=containers-changelog_archive#1156_1525_worker">1.15.6_1525</a>, <a href="/docs/containers?topic=containers-changelog_archive#1149_1541_worker">1.14.9_1541</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1544_worker">1.13.12_1544</a>.</li></ul></td>
</tr>
<tr>
<td>22 November 2019</td>
<td><ul>
<li><strong>Bring your own DNS for load balancers</strong>: Added steps for bringing your own custom domain for <a href="/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_dns">NLBs</a> in classic clusters and <a href="/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns">VPC load balancers</a> in VPC clusters.</li>
<li><strong>Gateway appliance firewalls</strong>: Updated the <a href="/docs/containers?topic=containers-firewall#vyatta_firewall">required IP addresses and ports</a> that you must open in a public gateway device firewall.</li>
<li><strong>Ingress ALB subdomain format</strong>: <a href="/docs/containers?topic=containers-ingress-about#ingress-resource">Changes are made to the Ingress subdomain</a>. New clusters are assigned an Ingress subdomain in the format <code>&lt;cluster_name&gt;.&lt;globally_unique_account_HASH&gt;-0000.&lt;region&gt;.containers.appdomain.cloud</code> and an Ingress secret in the format <code><&lt;cluster_name&gt;.<globally_unique_account_HASH>-0000</code>. Any existing clusters that use the <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code> subdomain are assigned a CNAME record that maps to a <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code> subdomain.</li>
</ul></td>
</tr>
<tr>
<td>21 November 2019</td>
<td><ul>
<li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>nginx-ingress</code> image to 597 and the <code>ingress-auth</code> image to build 353</a>.</li>
<li><strong>Version changelog</strong>: Master patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1163_1518">1.16.3_1518</a>, <a href="/docs/containers?topic=containers-changelog_archive#1156_1525">1.15.6_1525</a>, <a href="/docs/containers?topic=containers-changelog_archive#1149_1541">1.14.9_1541</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1544">1.13.12_1544</a>.</li>
</ul></td>
</tr>
<tr>
<td>19 November 2019</td>
<td><ul>
<li><strong>Istio managed add-on GA</strong>: The Istio managed add-on is generally available for Kubernetes version 1.16 clusters. In Kubernetes version 1.16 clusters, you can install the Istio add-on or <a href="/docs/containers?topic=containers-istio#istio_update">update your existing beta add-on to the latest version</a>.</li>
<li><strong>Fluentd component changes</strong>: The Fluentd component is created for your cluster only if you <a href="/docs/containers?topic=containers-health#configuring">create a logging configuration to forward logs to a syslog server</a>. If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you do not forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, <a href="/docs/containers?topic=containers-update#logging-up">automatic updates to Fluentd must be enabled</a>.</li>
<li><strong>Bringing your own Ingress controller in VPC clusters</strong>: Added <a href="/docs/containers?topic=containers-ingress-user_managed#user_managed_vpc">steps</a> for exposing your Ingress controller by creating a VPC load balancer and subdomain.</li>
</ul></td>
</tr>
<tr>
<td>14 November 2019</td>
<td><strong>New! Diagnostics and Debug Tool add-on</strong>: The <a href="/docs/containers?topic=containers-debug-tool">{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool</a> is now available as a cluster add-on.</td>
</tr>
<tr>
<td>11 November 2019</td>
<td><ul>
<li><strong>Accessing your cluster</strong>: Added an <a href="/docs/containers?topic=containers-access_cluster">Accessing Kubernetes clusters page</a>.</li>
<li><strong>Exposing apps that are external to your cluster by using Ingress</strong>: Added information for how to use the <code>proxy-external-service</code> Ingress annotation to include an app that is external to your cluster in Ingress application load balancing.</li>
<li><strong>Version changelog</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1162_1515_worker">1.16.2_1515</a>, <a href="/docs/containers?topic=containers-changelog_archive#1155_1522_worker">1.15.5_1522</a>, <a href="/docs/containers?topic=containers-changelog_archive#1148_1538_worker">1.14.8_1538</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11312_1541_worker">1.13.12_1541</a>.</li>
</ul></td>
</tr>
<tr>
<td>07 November 2019</td>
<td><ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.51</a>.</li>
<li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>ingress-auth</code> image to build 345</a>.</li></ul></td>
</tr>
<tr>
<td>05 November 2019</td>
<td><strong>New! Adding classic infrastructure servers to gateway-enabled classic clusters (Beta)</strong>: If you have non-containerized workloads on a classic IBM Cloud infrastructure virtual server or bare metal server, you can connect those workloads to the workloads in your gateway-enabled classic cluster by <a href="/docs/containers?topic=containers-add_workers#gateway_vsi">adding the server instance to your cluster network</a>.</td>
</tr>
<tr>
<td>04 November 2019</td>
<td><ul><li><strong>New! Kubernetes version 1.16</strong>: You can now create clusters that run Kubernetes version 1.16. To update an existing cluster, see the <a href="/docs/containers?topic=containers-cs_versions#cs_v116">Version 1.16 preparation actions</a>.</li>
<li><strong>Deprecated: Kubernetes version 1.13</strong>: With the release of version 1.16, clusters that run version 1.13 are deprecated. Consider <a href="/docs/containers?topic=containers-cs_versions#cs_v114">updating to 1.14</a> today.</li>
<li><strong>Unsupported: Kubernetes version 1.12</strong>: With the release of version 1.16, clusters that run version 1.12 are unsupported. To continue receiving important security updates and support, you must <a href="/docs/containers?topic=containers-cs_versions#prep-up">update the cluster to a supported version</a> immediately.</li></ul></td>
</tr>
<tr>
<td>01 November 2019</td>
<td><strong>New! Keep your own key (KYOK) support (beta)</strong>: You can now [enable several key management service (KMS) providers](/docs/containers?topic=containers-encryption#kms), so that you can use your own root key to encrypt the secrets in your cluster.</td>
</tr>
</tbody>
</table>

## October 2019
{: #oct19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Documentation updates in October 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>28 October 2019</td>
<td><ul>
<li><strong>New! Resource groups for VPC clusters</strong>: You can now <a href="/docs/containers?topic=containers-vpc_ks_tutorial">create Kubernetes clusters</a> in different resource groups than the resource group of the Virtual Private Cloud (VPC).</li>
<li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1155_1521">1.15.5_1521</a>, <a href="/docs/containers?topic=containers-changelog_archive#1148_1537">1.14.8_1537</a>, <a href="/docs/containers?topic=containers-changelog_archive#11312_1540">1.13.12_1540</a>, <a href="/docs/containers?topic=containers-changelog_archive#11210_1570">1.12.10_1570</a>, and {{site.data.keyword.openshiftshort}} <a href="/docs/openshift?topic=openshift-openshift_changelog#311153_1529">3.11.153_1529_openshift</a>.</li></ul></td>
</tr><tr>
<td>24 October 2019</td>
    <td><ul>
        <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.42</a>.</li>
    <li><strong>Scaling down file storage</strong>: Added steps for <a href="/docs/containers?topic=containers-file_storage#file_scaledown_plugin">scaling down the default file storage plug-in</a> in classic clusters.</li>
    <li><strong>Ingress subdomain troubleshooting</strong>: Added troubleshooting steps for when <a href="/docs/containers?topic=containers-ingress_subdomain">no Ingress subdomain exists after cluster creation</a></li>
    </ul></td>
</tr>
<tr>
<td>23 October 2019</td>
    <td><ul>
        <li><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 584 and <code>ingress-auth</code> image build to 344</a>.</li>
    <li><strong>Ingress annotations</strong>: Added the <a href="/docs/containers?topic=containers-comm-ingress-annotations#ssl-services-support"><code>proxy-ssl-verify-depth</code> and <code>proxy-ssl-name</code> optional parameters to the <code>ssl-services</code> annotation</a>.</li></ul></td>
</tr>
<tr>
    <td>22 October 2019</td>
    <td><strong>Version changelogs</strong>: Master patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1155_1520">1.15.5_1520</a>, <a href="/docs/containers?topic=containers-changelog_archive#1148_1536">1.14.8_1536</a>, <a href="/docs/containers?topic=containers-changelog_archive#11312_1539">1.13.12_1539</a>, and {{site.data.keyword.openshiftshort}} <a href="/docs/openshift?topic=openshift-openshift_changelog#311146_1528">3.11.146_1528_openshift</a>.</td>
</tr>
<tr>
    <td>17 October 2019</td>
    <td><ul><li><strong>New! Cluster autoscaler</strong>: The cluster autoscaler is available for private network-only clusters. To get started, update to the latest Helm chart version.</li>
    <li><strong>New DevOps tutorial</strong>: Learn how to set up your own DevOps toolchain and configure continuous delivery pipeline stages to deploy your containerized app that is stored in GitHub to a cluster in {{site.data.keyword.containerlong_notm}}.</li></ul></td>
</tr>
<tr>
    <td>14 October 2019</td>
    <td><ul>
    <li><strong>Calico MTU</strong>: Added <a href="/docs/containers?topic=containers-kernel#calico-mtu">steps</a> for changing the Calico plug-in maximum transmission unit (MTU) to meet the network throughput requirements of your environment.</li>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.38</a>.</li>
    </li>
    <li><strong>Creating DNS subdomains for VPC load balancers and private Ingress ALBs</strong>: Added steps for <a href="/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns">registering a VPC load balancer hostname with a DNS subdomain</a> and for <a href="/docs/containers?topic=containers-ingress-types#alb-comm-create-private">exposing apps to a private network</a> in VPC clusters.</li>
    <li><strong>Let's Encrypt rate limits for Ingress</strong>: Added <a href="/docs/containers?topic=containers-changelog_archive#1154_1519_worker">troubleshooting steps] for when no subdomain or secret is generated for the Ingress ALB when you create or delete clusters of the same name.</li>
    <li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes [1.15.4_1519</a>, <a href="/docs/containers?topic=containers-changelog_archive#1147_1535_worker">1.14.7_1535</a>, <a href="/docs/containers?topic=containers-changelog_archive#11311_1538_worker">1.13.11_1538</a>, <a href="/docs/containers?topic=containers-changelog_archive#11210_1569_worker">1.12.10_1569</a>, and {{site.data.keyword.openshiftshort}} <a href="/docs/openshift?topic=openshift-openshift_changelog#311146_1527">3.11.146_1527_openshift</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>03 October 2019</td>
    <td><ul>
    <li><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 579 and <code>ingress-auth</code> image build to 341</a>.</li>
    <li><strong>DevOps toolchain</strong>: You can now use the <strong>DevOps</strong> tab on the cluster details page to configure your DevOps toolchain. For more information, see <a href="/docs/containers?topic=containers-cicd#continuous-delivery-pipeline">Setting up a continuous delivery pipeline for a cluster</a>.</li>
    <li><strong>Security for VPC clusters</strong>: Added information for how to achieve <a href="/docs/containers?topic=containers-security#network_segmentation_vpc">network segmentation and privacy in VPC clusters</a>.</li>
    </ul>
    </td>
</tr>
<tr>
    <td>01 October 2019</td>
    <td><ul>
        <li><strong>End of service of {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}}</strong>: Removed steps for using {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}} to work with cluster logs and metrics. You can collect logs and metrics for your cluster by setting up <a href="/docs/containers?topic=containers-health#logging">{{site.data.keyword.la_full_notm}}</a> and <a href="/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster">{{site.data.keyword.mon_full_notm}}</a> instead.</li>
    <li><strong>New! Gateway-enabled classic clusters</strong>: Keep your compute workloads private and allow limited public connectivity to your classic cluster by enabling a gateway. You can enable a gateway only on standard, Kubernetes clusters during cluster creation.<br><br>
    When you enable a gateway on a classic cluster, the cluster is created with a <code>compute</code> worker pool of compute worker nodes that are connected to a private VLAN only, and a <code>gateway</code> worker pool of gateway worker nodes that are connected to public and private VLANs. Traffic into or out of the cluster is routed through the gateway worker nodes, which provide your cluster with limited public access. For more information, check out the following links:<ul>
        <li><a href="/docs/containers?topic=containers-plan_clusters#gateway">Using a gateway-enabled cluster</a></li>
        <li><a href="/docs/containers?topic=containers-edge#edge_gateway">Isolating networking workloads to edge nodes in classic gateway-enabled clusters</a></li>
        <li>Flow of traffic to apps when using an <a href="/docs/containers?topic=containers-loadbalancer-about#v1_gateway">NLB 1.0</a>, an <a href="/docs/containers?topic=containers-loadbalancer-about#v2_gateway">NLB 2.0</a>, or <a href="/docs/containers?topic=containers-ingress-about#classic-gateway">Ingress ALBs</a></li></ul>
    Ready to get started? <a href="/docs/containers?topic=containers-clusters#gateway_cluster_cli">Create a standard classic cluster with a gateway in the CLI.</a></li>
    <li><strong>Version changelogs</strong>: Patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1154_1518">1.15.4_1518</a>, <a href="/docs/containers?topic=containers-changelog_archive#1147_1534">1.14.7_1534</a>, <a href="/docs/containers?topic=containers-changelog_archive#11311_1537">1.13.11_1537</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1568_worker">1.12.10_1568</a>.</li>
    </ul>
    </td>
</tr>
</tbody></table>



## September 2019
{: #sept19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Documentation updates in September 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
    <td>27 September 2019</td>
    <td><strong>{{site.data.keyword.cos_full_notm}} supported in VPC clusters</strong>: You can now provision {{site.data.keyword.cos_full_notm}} for your apps that run in a VPC cluster. For more information, see <a href="/docs/containers?topic=containers-object_storage">Storing data on {{site.data.keyword.cos_full_notm}}</a>.</td>
</tr>
<tr>
    <td>24 September 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.31</a>.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 566</a>.</li>
    <li><strong>Managing cluster network traffic for VPC clusters</strong>: Includes the following new content:<ul>
        <li><a href="/docs/containers?topic=containers-vpc-firewall">Opening required ports and IP addresses in your firewall for VPC clusters</a></li>
    <li><a href="/docs/containers?topic=containers-vpc-network-policy">Controlling traffic with VPC ACLs and network policies</a></li>
    <li><a href="/docs/containers?topic=containers-vpc-vpnaas">Setting up VPC VPN connectivity</a></li></ul></li>
    <li><strong>Customizing PVC settings for VPC Block Storage</strong>: You can create a customized storage class or use a Kubernetes secret to create VPC Block Storage with the configuration that you want. For more information, see <a href="/docs/containers?topic=containers-vpc-block#vpc-customize-default">Customizing the default settings</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>19 September 2019</td>
    <td><strong>Sending custom Ingress certificates to legacy clients</strong>: Added <a href="/docs/containers?topic=containers-comm-ingress-annotations">steps</a> for ensuring that your custom certificate, instead of the default IBM-provided certificate, is sent by the Ingress ALB to legacy clients that do not support SNI.</td>
</tr>
<tr>
    <td>16 September 2019</td>
    <td><ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.23</a>.</li>
    <li><strong>{{site.data.keyword.at_full_notm}} events</strong>: Added information about <a href="/docs/containers?topic=containers-at_events#at-ui">which {{site.data.keyword.at_short}} location your events are sent to</a> based on the {{site.data.keyword.containerlong_notm}} location where the cluster is located.</li>
    <li><strong>Version changelogs</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1153_1517_worker">1.15.3_1517</a>, <a href="/docs/containers?topic=containers-changelog_archive#1146_1533_worker">1.14.6_1533</a>, <a href="/docs/containers?topic=containers-changelog_archive#11310_1536_worker">1.13.10_1536</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1567_worker">1.12.10_1567</a>.</li></ul>
    </td>
</tr>
<tr>
    <td>13 September 2019</td>
    <td><ul>
        <li><strong>Entitled software</strong>: If you have licensed products from your <a href="https://myibm.ibm.com">MyIBM.com</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> container software library, you can <a href="/docs/containers?topic=containers-registry#secret_entitled_software">set up your cluster to pull images from the entitled registry</a>.</li>
    <li><strong><code>script update</code> command</strong>: Added <a href="/docs/containers?topic=containers-kubernetes-service-cli#script_update">steps for using the <code>script update</code> command</a> to prepare your automation scripts for the release of version 1.0 of the {{site.data.keyword.containerlong_notm}} plug-in.</li>
    </ul></td>
</tr>
<tr>
    <td>12 September 2019</td>
    <td><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 552</a>.</td>
</tr>
<tr>
    <td>05 September 2019</td>
    <td><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>ingress-auth</code> image to build 340</a>.</td>
</tr>
<tr>
    <td>04 September 2019</td>
    <td><ul><li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.3</a>.</li>
    <li><strong>IAM allowlists</strong>: If you use an IAM allowlist, you must <a href="/docs/containers?topic=containers-firewall#iam_allowlist">allow the CIDRs of the {{site.data.keyword.containerlong_notm}} control plane</a> for the zones in the region where your cluster is located so that {{site.data.keyword.containerlong_notm}} can create Ingress ALBs and <code>LoadBalancers</code> in your cluster.</li></ul></td>
</tr>
<tr>
    <td>03 September 2019</td>
    <td><ul><li><strong>New! {{site.data.keyword.containerlong_notm}} plug-in version <code>0.4</code></strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for multiple changes in the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.4.1</a>.</li>
    <li><strong>Version changelog</strong>: Worker node patch updates are available for Kubernetes <a href="/docs/containers?topic=containers-changelog_archive#1153_1516_worker">1.15.3_1516</a>, <a href="/docs/containers?topic=containers-changelog_archive#1146_1532_worker">1.14.6_1532</a>, <a href="/docs/containers?topic=containers-changelog_archive#11310_1535_worker">1.13.10_1535</a>, <a href="/docs/containers?topic=containers-changelog_archive#11210_1566_worker">1.12.10_1566</a>, and {{site.data.keyword.openshiftshort}} <a href="/docs/openshift?topic=openshift-openshift_changelog#311135_1523_worker">3.11.135_1523</a>.</li></ul></td>
</tr>
</tbody></table>



## August 2019
{: #aug19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>Documentation updates in August 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
    <td>29 August 2019</td>
    <td><strong>Forwarding Kubernetes API audit logs to {{site.data.keyword.la_full_notm}}</strong>: Added steps to <a href="/docs/containers?topic=containers-health-audit">create an audit webhook in your cluster</a> to collect Kubernetes API audit logs from your cluster and forward them to {{site.data.keyword.la_full_notm}}.</td>
</tr>
<tr>
    <td>28 August 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.112</a>.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1153_1515">1.15.3_1515</a>, <a href="/docs/containers?topic=containers-changelog_archive#1146_1531">1.14.6_1531</a>, <a href="/docs/containers?topic=containers-changelog_archive#11310_1534">1.13.10_1534</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1565">1.12.10_1565</a> master fix pack updates.</li>
    </ul></td>
</tr>
<tr>
    <td>26 August 2019</td>
    <td><ul>
    <li><strong>Cluster autoscaler</strong>: With the latest version of the cluster autoscaler, you can <a href="/docs/containers?topic=containers-ca#ca_helm">enable autoscaling for worker pools during the Helm chart installation</a> instead of modifying the config map after installation.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 524 and <code>ingress-auth</code> image to build 337</a>.</li></ul></td>
</tr>
<tr>
    <td>23 August 2019</td>
    <td><ul>
    <li><strong>App networking in VPC</strong>: Updated the <a href="/docs/containers?topic=containers-cs_network_planning">Planning in-cluster and external networking for apps</a> topic with information for planning app networking in a VPC cluster.</li>
    <li><strong>Istio in VPC</strong>: Updated the <a href="/docs/containers?topic=containers-istio">managed Istio add-on</a> topic with information for using Istio in a VPC cluster.</li>
    <li><strong>Remove bound services from cluster</strong>: Added instructions for how to remove an {{site.data.keyword.cloud_notm}} service that you added to a cluster by using service binding. For more information, see <a href="/docs/containers?topic=containers-service-binding#unbind-service">Removing a service from a cluster</a>.</li></ul></td>
</tr>
<tr>
    <td>20 August 2019</td>
    <td><strong>Ingress ALB changelog</strong>: Updated the ALB <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>nginx-ingress</code> image to build 519</a> for a <code>custom-ports</code> bug fix.</td>
</tr>
<tr>
    <td>19 August 2019</td>
    <td><ul>
    <li><strong>New! Virtual Private Cloud</strong>: You can create standard Kubernetes clusters on classic infrastructure in the next generation of the {{site.data.keyword.cloud_notm}} platform, in your Virtual Private Cloud. VPC gives you the security of a private cloud environment with the dynamic scalability of a public cloud. Classic on VPC clusters are available for only standard, Kubernetes clusters and are not supported in free or {{site.data.keyword.openshiftshort}} clusters.<br><br>
    With classic clusters in VPC, {{site.data.keyword.containerlong_notm}} introduces version 2 of the API, which supports multiple infrastructure providers for your clusters. Your cluster network setup also changes, from worker nodes that use public and private VLANs and the public cloud service endpoint to worker nodes that are on a private subnet only and have the private cloud service endpoint enabled. For more information, check out the following links:<ul>
        <li><a href="/docs/containers?topic=containers-infrastructure_providers">Overview of Classic and VPC infrastructure providers</a></li>
    <li><a href="/docs/containers?topic=containers-cs_api_install#api_about">About the v2 API</a></li>
    <li><a href="/docs/containers?topic=containers-plan_clusters#plan_vpc_basics">Understanding network basics of VPC clusters</a></li></ul>
    Ready to get started? Try out the <a href="/docs/containers?topic=containers-vpc_ks_tutorial">Creating a classic cluster in your VPC tutorial</a>.</li>
    <li><strong>Kubernetes 1.14</strong>: <a href="/docs/containers?topic=containers-cs_versions#version_types">Kubernetes 1.14</a> is now the default version.</li>
    </ul>
    </td>
</tr>
<tr>
    <td>17 August 2019</td>
    <td><ul>
    <li><strong>{{site.data.keyword.at_full}}</strong>: The <a href="/docs/containers?topic=containers-at_events">{{site.data.keyword.at_full_notm}} service</a> is now supported for you to view, manage, and audit user-initiated activities in your clusters.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1152_1514">1.15.2_1514</a>, <a href="/docs/containers?topic=containers-changelog_archive#1145_1530">1.14.5_1530</a>, <a href="/docs/containers?topic=containers-changelog_archive#1139_1533">1.13.9_1533</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1564">1.12.10_1564</a> master fix pack updates.</li></ul></td>
</tr>
<tr>
    <td>15 August 2019</td>
    <td><ul>
    <li><strong>App deployments</strong>: Added steps for <a href="/docs/containers?topic=containers-update_app#copy_apps_cluster">copying deployments from one cluster to another</a>.</li>
    <li><strong>FAQs</strong>: Added an FAQ about <a href="/docs/containers?topic=containers-faqs#faq_free">free clusters</a>.</li>
    <li><strong>Istio</strong>: Added steps for <a href="/docs/containers?topic=containers-istio-mesh#tls">exposing Istio-managed apps with TLS termination</a>, <a href="/docs/containers?topic=containers-istio-mesh#mtls">securing in-cluster traffic by enabling mTLS</a>, and <a href="/docs/containers?topic=containers-istio#istio_update">Updating the Istio add-ons</a>.</li>
    <li><strong>Knative</strong>: Added instructions for how to use volumes to access secrets and config maps, pull images from a private registry, scale apps based on CPU usage, <a href="/docs/containers?topic=containers-changelog_archive#1152_1513">change the default container port, and change the <code>scale-to-zero-grace-period</code>.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for [1.15.2_1513</a>, <a href="/docs/containers?topic=containers-changelog_archive#1145_1529">1.14.5_1529</a>, <a href="/docs/containers?topic=containers-changelog_archive#1139_1532">1.13.9_1532</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1563">1.12.10_1563</a> master fix pack updates.</li></ul></td>
</tr>
<tr>
    <td>12 August 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.103</a>.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the ALB <code>ingress-auth</code> image to build 335 for <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog"><code>musl libc</code> vulnerabilities</a>.</li></ul></td>
</tr>
<tr>
    <td>05 August 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.99</a>.</li>
    <li><strong>New! <code>NodeLocal</code> DNS caching (beta)</strong>: For clusters that run Kubernetes 1.15 or later, you can set up improved cluster DNS performance with <a href="/docs/containers?topic=containers-cluster_dns#dns_cache"><code>NodeLocal</code> DNS caching</a>.</li>
    <li><strong>New! Version 1.15</strong>: You can create community Kubernetes clusters that run version 1.15. To update from a previous version, review the <a href="/docs/containers?topic=containers-cs_versions#cs_v115">1.15 changes</a>.</li>
    <li><strong>Deprecated: Version 1.12</strong>: Kubernetes version 1.12 is deprecated. Review the <a href="/docs/containers?topic=containers-cs_versions">changes across versions</a>, and update to a more recent version.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1144_1527_worker">1.14.4_1527</a>, <a href="/docs/containers?topic=containers-changelog_archive#1138_1530_worker">1.13.8_1530</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1561_worker">1.12.10_1561</a> worker node patch updates.</li></ul></td>
</tr>
</tbody></table>

## July 2019
{: #jul19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>{{site.data.keyword.containerlong_notm}} documentation updates in July 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
    <td>30 July 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.95</a>.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the ALB <code>nginx-ingress</code> image to build 515 for the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB pod readiness check</a>.</li>
    <li><strong>Removing subnets from a cluster</strong>: Added steps for removing subnets <a href="/docs/containers?topic=containers-subnets#remove-subnets">in an IBM Cloud infrastructure account</a> from a cluster. </li>
    </ul></td>
</tr>
<tr>
    <td>23 July 2019</td>
    <td><strong>Fluentd changelog</strong>: Fixes <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog">Alpine vulnerabilities</a>.</td>
</tr>
<tr>
    <td>22 July 2019</td>
    <td><ul>
        <li><strong>Version policy</strong>: Increased the <a href="/docs/containers?topic=containers-cs_versions#version_types">version deprecation</a> period from 30 to 45 days.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1144_1526_worker">1.14.4_1526</a>, <a href="/docs/containers?topic=containers-changelog_archive#1138_1529_worker">1.13.8_1529</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1560_worker">1.12.10_1560</a> worker node patch updates.</li>
    <li><strong>Version changelog</strong>: <a href="/docs/containers?topic=containers-changelog_archive#111_changelog">Version 1.11</a> is unsupported.</li></ul>
    </td>
</tr>
<tr>
    <td>17 July 2019</td>
    <td><strong>Ingress ALB changelog</strong>: <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">Fixes <code>rbash</code> vulnerabilities</a>.
    </td>
</tr>
<tr>
    <td>15 July 2019</td>
    <td><ul>
    <li><strong>Cluster and worker node ID</strong>: The ID format for clusters and worker nodes is changed. Existing clusters and worker nodes keep their existing IDs. If you have automation that relies on the previous format, update it for new clusters.<ul>
    <li><strong>Cluster ID</strong>: In the regex format <code>{a-v0-9}7]{a-z0-9}[2]{a-v0-9}[11]</code></a>.</li>
    <li><strong>Worker node ID</strong>: In the format <code>kube-&lt;cluster_ID&gt;-&lt;cluster_name_truncated&gt;-&lt;resource_group_truncated&gt;-&lt;worker_ID&gt;</code></li></ul></li>
    <li><strong>Ingress ALB changelog</strong>: Updated the [ALB <code>nginx-ingress</code> image to build 497</a>.</li>
    <li><strong>Troubleshooting clusters</strong>: Added <a href="/docs/containers?topic=containers-worker_infra_errors#cs_totp">troubleshooting steps</a> for when you cannot manage clusters and worker nodes because the time-based one-time passcode (TOTP) option is enabled for your account.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1144_1526">1.14.4_1526</a>, <a href="/docs/containers?topic=containers-changelog_archive#1138_1529">1.13.8_1529</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11210_1560">1.12.10_1560</a> master fix pack updates.</li></ul>
    </td>
</tr>
<tr>
    <td>08 July 2019</td>
    <td><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1143_1525">1.14.3_1525</a>, <a href="/docs/containers?topic=containers-changelog_archive#1137_1528">1.13.7_1528</a>, <a href="/docs/containers?topic=containers-changelog_archive#1129_1559">1.12.9_1559</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11110_1564">1.11.10_1564</a> worker node patch updates.</td>
</tr>
<tr>
    <td>02 July 2019</td>
    <td><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.58</a>.</td>
</tr>
<tr>
    <td>01 July 2019</td>
    <td><ul>
    <li><strong>Infrastructure permissions</strong>: Updated the <a href="/docs/containers?topic=containers-access_reference#infra">classic infrastructure roles</a> required for common use cases.</li>
    <li><strong>strongSwan VPN service</strong>: If you install strongSwan in a multizone cluster and use the <code>enableSingleSourceIP=true</code> setting, you can now <a href="/docs/containers?topic=containers-vpn#strongswan_4">set <code>local.subnet</code> to the <code>%zoneSubnet</code> variable and use the <code>local.zoneSubnet</code> to specify an IP address as a /32 subnet for each zone of the cluster</a>.</li>
    </ul></td>
</tr>
</tbody></table>


## June 2019
{: #jun19}

<table summary="The table shows release notes. Rows are to be read from the left to right, with the date in column one, the title of the feature in column two and a description in column three.">
<caption>{{site.data.keyword.containerlong_notm}} documentation updates in June 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
    <td>24 June 2019</td>
    <td><ul>
    <li><strong>Calico network policies</strong>: Added a set of <a href="/docs/containers?topic=containers-network_policies#isolate_workers_public">public Calico policies</a> and expanded the set of <a href="/docs/containers?topic=containers-network_policies#isolate_workers">private Calico policies</a> to protect your cluster on public and private networks.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>nginx-ingress</code> image to build 477</a>.</li>
    <li><strong>Service limitations</strong>: Updated the <a href="/docs/containers?topic=containers-limitations#tech_limits">maximum number of pods per worker node limitation</a>. For worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later and that have more than 11 CPU cores, the worker nodes can support 10 pods per core, up to a limit of 250 pods per worker node.</li>
    <li><strong>Version changelogs</strong>: Added changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1143_1524">1.14.3_1524</a>, <a href="/docs/containers?topic=containers-changelog_archive#1137_1527">1.13.7_1527</a>, <a href="/docs/containers?topic=containers-changelog_archive#1129_1558">1.12.9_1558</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11110_1563">1.11.10_1563</a> worker node patch updates.</li>
    </ul></td>
</tr>
<tr>
    <td>21 June 2019</td>
    <td>
    <strong>Accessing the Kubernetes master through the private cloud service endpoint</strong>: Added steps for <a href="/docs/containers?topic=containers-access_cluster#access_private_se">editing the local Kubernetes configuration file</a> when both the public and private cloud service endpoints are enabled, but you want to access the Kubernetes master through the private cloud service endpoint only.
    </td>
</tr>
<tr>
    <td>18 June 2019</td>
    <td><ul>
    <li><strong>CLI changelog</strong>: Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of versions 0.3.47 and 0.3.49</a>.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>nginx-ingress</code> image to build 473 and <code>ingress-auth</code> image to build 331</a>.</li>
    <li><strong>Managed add-on versions</strong>: Updated the version of the Istio managed add-on to 1.1.7 and the Knative managed add-on to 0.6.0.</li>
    <li><strong>Removing persistent storage</strong>: Updated the information for how you are billed when you delete persistent storage.</li>
    <li><strong>Service bindings with private endpoint</strong>: <a href="/docs/containers?topic=containers-service-binding">Added steps</a> for how to manually create service credentials with the private cloud service endpoint when you bind the service to your cluster.</li>
    <li><strong>Version changelogs</strong>: Updated the changelogs for <a href="/docs/containers?topic=containers-changelog_archive#1143_1523">1.14.3_1523</a>, <a href="/docs/containers?topic=containers-changelog_archive#1137_1526">1.13.7_1526</a>, <a href="/docs/containers?topic=containers-changelog_archive#1129_1557">1.12.9_1557</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11110_1562">1.11.10_1562</a> patch updates.</li>
    </ul></td>
</tr>
<tr>
    <td>14 June 2019</td>
    <td><ul>
    <li><strong><code>kubectl</code> troubleshooting</strong>: Added a <a href="/docs/containers?topic=containers-ts_clis#kubectl_fails">troubleshooting topic</a> for when you have a <code>kubectl</code> client version that is 2 or more versions apart from the server version or the {{site.data.keyword.openshiftshort}} version of <code>kubectl</code>, which does not work with community Kubernetes clusters.</li>
    <li><strong>Tutorials landing page</strong>: Replaced the related links page with a new tutorials landing page for all tutorials that are specific to {{site.data.keyword.containershort_notm}}.</li>
    <li><strong>Tutorial to create a cluster and deploy an app</strong>: Combined the tutorials for creating clusters and deploying apps into one comprehensive <a href="/docs/containers?topic=containers-cs_cluster_tutorial">tutorial</a>.</li>
    <li><strong>Using existing subnets to create a cluster</strong>: To <a href="/docs/containers?topic=containers-subnets#subnets_custom">reuse subnets from an unneeded cluster when you create a new cluster</a>, the subnets must be user-managed subnets that you manually added from an on-premises network. All subnets that were automatically ordered during cluster creation are immediately marked for deletion after you delete a cluster, and you cannot reuse these subnets to create a new cluster.</li>
    </ul></td>
</tr>
<tr>
    <td>12 June 2019</td>
    <td><strong>Aggregating cluster roles</strong>: Added steps for <a href="/docs/containers?topic=containers-users#rbac_aggregate">extending users' existing permissions by aggregating cluster roles</a>.</td>
</tr>
<tr>
    <td>07 June 2019</td>
    <td><ul>
    <li><strong>Access to the Kubernetes master through the private cloud service endpoint</strong>: Added <a href="/docs/containers?topic=containers-access_cluster#access_private_se">steps</a> to expose the private cloud service endpoint through a private load balancer. After you complete these steps, your authorized cluster users can access the Kubernetes master from a VPN or {{site.data.keyword.dl_full_notm}} connection.</li>
    <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: Added {{site.data.keyword.dl_full_notm}} to the <a href="/docs/containers?topic=containers-vpn">VPN connectivity</a> page as a way to create a direct, private connection between your remote network environments and {{site.data.keyword.containerlong_notm}} without routing over the public internet.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>ingress-auth</code> image to build 330</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>06 June 2019</td>
    <td><ul>
    <li><strong>Fluentd changelog</strong>: Added a <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog">Fluentd version changelog</a>.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>nginx-ingress</code> image to build 470</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>05 June 2019</td>
    <td><strong>CLI reference</strong>: Updated the <a href="/docs/containers?topic=containers-kubernetes-service-cli">CLI reference page</a> to reflect multiple changes for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.34</a> of the {{site.data.keyword.containerlong_notm}} CLI plug-in.</td>
</tr>
<tr>
    <td>04 June 2019</td>
    <td><strong>Version changelogs</strong>: Updated the changelogs for the <a href="/docs/containers?topic=containers-changelog_archive#1142_1521">1.14.2_1521</a>, <a href="/docs/containers?topic=containers-changelog_archive#1136_1524">1.13.6_1524</a>, <a href="/docs/containers?topic=containers-changelog_archive#1129_1555">1.12.9_1555</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11110_1561">1.11.10_1561</a> patch releases.
    </td>
</tr>
<tr>
    <td>03 June 2019</td>
    <td><ul>
    <li><strong>Bringing your own Ingress controller</strong>: Updated the <a href="/docs/containers?topic=containers-ingress-user_managed">steps</a> to reflect changes to the default community controller and to require a health check for controller IP addresses in multizone clusters.</li>
    <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: Updated the <a href="/docs/containers?topic=containers-object_storage#install_cos">steps</a> to install the {{site.data.keyword.cos_full_notm}} plug-in with or without the Helm server, Tiller.</li>
    <li><strong>Ingress ALB changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog">ALB <code>nginx-ingress</code> image to build 467</a>.</li>
    <li><strong>Kustomize</strong>: Added an example of <a href="/docs/containers?topic=containers-app#kustomize">reusing Kubernetes configuration files across multiple environments with Kustomize</a>.</li>
    <li><strong>Razee</strong>: Added <a href="https://github.com/razee-io/Razee">Razee</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> to the supported integrations to visualize deployment information in the cluster and to automate the deployment of Kubernetes resources. </li></ul>
    </td>
</tr>
</tbody></table>


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
    <td>30 May 2019</td>
    <td><ul>
    <li><strong>CLI reference</strong>: Updated the <a href="/docs/containers?topic=containers-kubernetes-service-cli">CLI reference page</a> to reflect multiple changes for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.33</a> of the {{site.data.keyword.containerlong_notm}} CLI plug-in.</li>
    <li><strong>Troubleshooting storage</strong>: <ul>
    <li>Added a file and block storage troubleshooting topic for <a href="/docs/containers?topic=containers-file_pvc_pending">PVC pending states</a>.</li>
    <li>Added a block storage troubleshooting topic for when <a href="/docs/containers?topic=containers-block_app_failures">an app cannot access or write to PVC</a>.</li>
    </ul></li>
    </ul></td>
</tr>
<tr>
    <td>28 May 2019</td>
    <td><ul>
    <li><strong>Cluster add-ons changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog">ALB <code>nginx-ingress</code> image to build 462</a>.</li>
    <li><strong>Troubleshooting registry</strong>: Added a <a href="/docs/containers?topic=containers-ts_image_pull_create">troubleshooting topic</a> for when your cluster cannot pull images from {{site.data.keyword.registryfull}} due to an error during cluster creation.
    </li>
    <li><strong>Troubleshooting storage</strong>: <ul>
    <li>Added a topic for debugging persistent storage failures.</li>
    <li>Added a troubleshooting topic for <a href="/docs/containers?topic=containers-missing_permissions">PVC creation failures due to missing permissions</a>.</li>
    </ul></li>
    </ul></td>
</tr>
<tr>
    <td>23 May 2019</td>
    <td><ul>
    <li><strong>CLI reference</strong>: Updated the <a href="/docs/containers?topic=containers-kubernetes-service-cli">CLI reference page</a> to reflect multiple changes for the <a href="/docs/containers?topic=containers-cs_cli_changelog">release of version 0.3.28</a> of the {{site.data.keyword.containerlong_notm}} CLI plug-in.</li>
    <li><strong>Cluster add-ons changelog</strong>: Updated the <a href="/docs/containers?topic=containers-cluster-add-ons-changelog">ALB <code>nginx-ingress</code> image to build 457</a>.</li>
    <li><strong>Cluster and worker states</strong>: Updated the <a href="/docs/containers?topic=containers-health-monitor#states">Logging and monitoring page</a> to add reference tables about cluster and worker node states.</li>
    <li><strong>Cluster planning and creation</strong>: You can now find information about cluster planning, creation, and removal and network planning in the following pages:
        <ul><li><a href="/docs/containers?topic=containers-plan_clusters">Planning your cluster network setup</a></li>
    <li><a href="/docs/containers?topic=containers-ha_clusters">Planning your cluster for high availability</a></li>
    <li><a href="/docs/containers?topic=containers-planning_worker_nodes">Planning your worker node setup</a></li>
    <li><a href="/docs/containers?topic=containers-clusters">Creating clusters</a></li>
    <li><a href="/docs/containers?topic=containers-add_workers">Adding worker nodes and zones to clusters</a></li>
    <li><a href="/docs/containers?topic=containers-remove">Removing clusters</a></li>
    <li><a href="/docs/containers?topic=containers-cs_network_cluster">Changing service endpoints or VLAN connections</a></li></ul>
    </li>
    <li><strong>Cluster version updates</strong>: Updated the <a href="/docs/containers?topic=containers-cs_versions">unsupported versions policy</a> to note that you cannot update clusters if the master version is three or more versions behind the oldest supported version. You can view if the cluster is <strong>unsupported</strong> by reviewing the <strong>State</strong> field when you list clusters.</li>
    <li><strong>Istio</strong>: Updated the <a href="/docs/containers?topic=containers-istio">Istio page</a> to remove the limitation that Istio does not work in clusters that are connected to a private VLAN only. Added a step to the <a href="/docs/containers?topic=containers-managed-addons#updating-managed-add-ons">Updating managed add-ons topic</a> to re-create Istio gateways that use TLS sections after the update of the Istio managed add-on is complete.</li>
    <li><strong>Popular topics</strong>: Replaced the popular topics with this release notes page for new features and updates that are specific to {{site.data.keyword.containershort_notm}}. For the latest information on {{site.data.keyword.cloud_notm}} products, check out the <a href="https://www.ibm.com/cloud/blog/announcements">Announcements</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>20 May 2019</td>
    <td><strong>Version changelogs</strong>: Added <a href="/docs/containers?topic=containers-changelog">worker node fix pack changelogs</a>.</td>
</tr>
<tr>
    <td>16 May 2019</td>
    <td><ul>
    <li><strong>CLI reference</strong>: Updated the <a href="/docs/containers?topic=containers-kubernetes-service-cli">CLI reference page</a> to add COS endpoints for <code>logging collect</code> commands and to clarify that <code>cluster master refresh</code> restarts the Kubernetes master components.</li>
    <li><strong>Unsupported: Kubernetes version 1.10</strong>: <a href="/docs/containers?topic=containers-cs_versions#cs_v114">Kubernetes version 1.10</a> is now unsupported.</li>
    </ul></td>
</tr>
<tr>
    <td>15 May 2019</td>
    <td><ul>
    <li><strong>Default Kubernetes version</strong>: The default Kubernetes version is now 1.13.6.</li>
    <li><strong>Service limits</strong>: Added a <a href="/docs/containers?topic=containers-limitations#tech_limits">service limitations topic</a>.</li>
    </ul></td>
</tr>
<tr>
    <td>13 May 2019</td>
    <td><ul>
    <li><strong>Version changelogs</strong>: Added that new patch updates are available for <a href="/docs/containers?topic=containers-changelog_archive#1141_1518">1.14.1_1518</a>, <a href="/docs/containers?topic=containers-changelog_archive#1136_1521">1.13.6_1521</a>, <a href="/docs/containers?topic=containers-changelog_archive#1128_1552">1.12.8_1552</a>, <a href="/docs/containers?topic=containers-changelog_archive#11110_1558">1.11.10_1558</a>, and <a href="/docs/containers?topic=containers-changelog_archive#11013_1558">1.10.13_1558</a>.</li>
    <li><strong>Worker node flavors</strong>: Removed all <a href="/docs/containers?topic=containers-planning_worker_nodes#vm">virtual machine worker node flavors</a> that are 48 or more cores per <a href="https://cloud.ibm.com/status?component=containers-kubernetes&selected=status">cloud status</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. You can still provision <a href="/docs/containers?topic=containers-planning_worker_nodes#bm">bare metal worker nodes</a> with 48 or more cores.</li></ul></td>
</tr>
<tr>
    <td>08 May 2019</td>
    <td><ul>
    <li><strong>API</strong>: Added a link to the <a href="https://containers.cloud.ibm.com/global/swagger-global-api/#/">global API swagger docs</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li>
    <li><strong>Cloud Object Storage</strong>: <a href="/docs/containers?topic=containers-cos_pvc_pending">Added a troubleshooting guide for Cloud Object Storage</a> in your {{site.data.keyword.containerlong_notm}} clusters.</li>
    <li><strong>Kubernetes strategy</strong>: Added a topic about <a href="/docs/containers?topic=containers-strategy#knowledge">What knowledge and technical skills are good to have before I move my apps to {{site.data.keyword.containerlong_notm}}?</a>.</li>
    <li><strong>Kubernetes version 1.14</strong>: Added that the <a href="/docs/containers?topic=containers-cs_versions#cs_v114">Kubernetes 1.14 release</a> is certified.</li>
    <li><strong>Reference topics</strong>: Updated information for various service binding, <code>logging</code>, and <code>nlb</code> operations in the <a href="/docs/containers?topic=containers-access_reference">user access</a> and <a href="/docs/containers?topic=containers-kubernetes-service-cli">CLI</a> reference pages.</li></ul></td>
</tr>
<tr>
    <td>07 May 2019</td>
    <td><ul>
    <li><strong>Cluster DNS provider</strong>: <a href="/docs/containers?topic=containers-cluster_dns">Explained the benefits of CoreDNS</a> now that clusters that run Kubernetes 1.14 and later support only CoreDNS.</li>
    <li><strong>Edge nodes</strong>: Added private load balancer support for <a href="/docs/containers?topic=containers-edge">edge nodes</a>.</li>
    <li><strong>Free clusters</strong>: Clarified where <a href="/docs/containers?topic=containers-regions-and-zones#regions_free">free clusters</a> are supported.</li>
    <li><strong>New! Integrations</strong>: Added and restructure information about <a href="/docs/containers?topic=containers-ibm-3rd-party-integrations">{{site.data.keyword.cloud_notm}} services and third-party integrations</a>, <a href="/docs/containers?topic=containers-supported_integrations">popular integrations</a>, and <a href="/docs/containers?topic=containers-service-partners">partnerships</a>.</li>
    <li><strong>New! Kubernetes version 1.14</strong>: Create or update your clusters to <a href="/docs/containers?topic=containers-cs_versions#cs_v114">Kubernetes 1.14</a>.</li>
    <li><strong>Deprecated Kubernetes version 1.11</strong>: <a href="/docs/containers?topic=containers-update">Update</a> any clusters that run <a href="/docs/containers?topic=containers-cs_versions#cs_v111">Kubernetes 1.11</a> before they become unsupported.</li>
    <li><strong>Permissions</strong>: Added an FAQ, <a href="/docs/containers?topic=containers-faqs#faq_access">What access policies do I give my cluster users?</a></li>
    <li><strong>Worker pools</strong>: Added instructions for how to <a href="/docs/containers?topic=containers-add_workers#worker_pool_labels">apply labels to existing worker pools</a>.</li>
    <li><strong>Reference topics</strong>: To support new features such as Kubernetes 1.14, <a href="/docs/containers?topic=containers-changelog#changelog">changelog</a> reference pages are updated.</li></ul></td>
</tr>
<tr>
    <td>01 May 2019</td>
    <td><strong>Assigning infrastructure access</strong>: Revised the <a href="/docs/containers?topic=containers-access-creds#infra_access">steps to assign IAM permissions for opening support cases</a>.</td>
</tr>
</tbody></table>






