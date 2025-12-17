---

copyright: 
  years: 2014, 2025
lastupdated: "2025-12-17"


keywords: kubernetes, release notes, containers, {{site.data.keyword.containerlong_notm}}

subcollection: containers

content-type: release-note

---

{{site.data.keyword.attribute-definition-list}}


# Release notes
{: #containers-relnotes}

Use the release notes to learn about the latest changes to the documentation that are grouped by month.
{: shortdesc}

Looking for {{site.data.keyword.cloud_notm}} status, platform announcements, security bulletins, or maintenance notifications? See [{{site.data.keyword.cloud_notm}} status](https://cloud.ibm.com/status?selected=status).
{: tip}

## December 2025
{: #containers-dec25}


### 16 December 2025
{: #containers-dec1625}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.34 change log](/docs/containers?topic=containers-changelog_134)
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)







### 12 December 2025
{: #containers-dec1225}
{: release-note}





{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.34 change log](/docs/containers?topic=containers-changelog_134)
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)






### 10 December 2025
{: #containers-dec1025}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} version 1.34.
:   You can now create or [update clusters to Kubernetes version 1.34](/docs/containers?topic=containers-cs_versions_134). With Kubernetes 1.34, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

{{site.data.keyword.containerlong_notm}} version 1.34 Kubernetes certification
:   {{site.data.keyword.containerlong_notm}} version [1.34](/docs/containers?topic=containers-cs_versions_134) is now Kubernetes certified.

CoreDNS and NodeLocal DNS cache configuration changes in version 1.34 and later
:   The default DNS cache time in both CoreDNS and NodeLocal DNS configurations has been increased from 30 seconds to 120 seconds. This change applies to the ConfigMap settings for DNS caching. Some users were hitting pDNS (or UDP) traffic limits due to frequent DNS lookups caused by short cache durations. A 30-second cache interval is rarely necessary except for DNS records that change very frequently, for example health-check endpoints. For most workloads, a 120-second default cache provides better performance and reduces unnecessary DNS traffic. Users who require shorter cache times for specific use cases can override this setting. For more information, see [Configuring the cluster DNS provider](/docs/containers?topic=containers-cluster_dns).




### 08 December 2025
{: #containers-dec0825}
{: release-note}

New! Chennai multizone region for VPC
:   You can now create clusters on VPC infrastructure in the Chennai, India (`in-che`) [location](/docs/containers?topic=containers-regions-and-zones).


### 04 December 2025
{: #containers-dec0425}
{: release-note}

ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



### 03 December 2025
{: #containers-dec0325}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.34 change log](/docs/containers?topic=containers-changelog_134)
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)







### 02 December 2025
{: #containers-dec0225}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.cos_full_notm}} add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-object-csi-driver).



Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





## November 2025
{: #containers-nov25}



### 18 November 2025
{: #containers-nov1825}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)





### 17 November 2025
{: #containers-nov1725}
{: release-note}

{{site.data.keyword.cos_full_notm}} add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-object-csi-driver).



Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).







### 16 November 2025
{: #containers-nov1625}
{: release-note}

{{site.data.keyword.containerlong_notm}} version 1.30 is unsupported.
:   Update your cluster to at least [version 1.31](/docs/containers?topic=containers-cs_versions_131) as soon as possible.



### 15 November 2025
{: #containers-nov1525}
{: release-note}





{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)




### 12 November 2025
{: #containers-nov1225}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 11 November 2025
{: #containers-nov1125}
{: release-note}

CLI version `1.0.732` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates.
:   For more information, see the [add-on change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

VPC File CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).



### 07 October 2025
{: #containers-nov0725}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)






## October 2025
{: #containers-oct25}



### 28 October 2025
{: #containers-oct2825}
{: release-note}

The strongSwan IPSec VPN Service is deprecated
:    Support the strongSwan IPSec VPN Service ends on 20 December 2025. If you are using the strongSwan IPSec VPN Service in your Classic cluster you must switch to an alternative way to connect your classic cluster to a separate network. For more information, see [Setting up classic VPN connectivity](https://cloud.ibm.com/docs/containers?topic=containers-vpn).



### 27 October 2025
{: #containers-oct2725}
{: release-note}


{{site.data.keyword.containerlong_notm}} version 1.31 is deprecated.
:   Support for 1.31 ends on {{site.data.keyword.kubernetes_131_unsupported_date}}. Update your cluster to [version 1.32](/docs/containers?topic=containers-cs_versions_132) as soon as possible.

{{site.data.keyword.containerlong_notm}} version 1.30 is deprecated.
:   Support for 1.30 ends on {{site.data.keyword.kubernetes_130_unsupported_date}}. Update your cluster to [version 1.31](/docs/containers?topic=containers-cs_versions_131) as soon as possible.



### 23 October 2025
{: #containers-oct2325}
{: release-note}

The Diagnostics and Debug Tool is deprecated and support ends on 20 December 2025.
:   Uninstall the Diagnostics and Debug Tool from your clusters before support ends. For more information, see [Running the Diagnostics and Debug Tool](/docs/containers?topic=containers-debug-tool).


### 22 October 2025
{: #containers-oct2225}
{: release-note}

CLI version `1.0.727` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 21 October 2025
{: #containers-oct2125}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)








### 14 October 2025
{: #containers-oct1425}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


### 13 October 2025
{: #containers-oct1325}
{: release-note}

New! General availability of the {{site.data.keyword.cos_full_notm}} cluster add-on
:   For more information, see the [Installing the {{site.data.keyword.cos_full_notm}} cluster add-on](/docs/containers?topic=containers-storage-cos-install-addon).

### 08 October 2025
{: #containers-oct0825}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)









### 06 October 2025
{: #containers-oct0625}
{: release-note}

Version 1.33 is now the default version for {{site.data.keyword.containerlong_notm}}.
:   For a complete list of available versions, see the [version information](/docs/containers?topic=containers-cs_versions).



### 03 October 2025
{: #containers-oct0325}
{: release-note}




{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)




### 02 October 2025
{: #containers-oct0225}
{: release-note}

CLI version `1.0.724` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

## September 2025
{: #containers-sep25}



### 30 September 2025
{: #containers-sep3025}
{: release-note}

Security Bulletin: {{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities
:   For more information, see the [Security Bulletin for CVE-2025-5187](https://www.ibm.com/support/pages/node/7245968){: external}. 



### 25 September 2025
{: #containers-sep2525}
{: release-note}

CLI version `1.0.718` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 23 September 2025
{: #containers-sep2325}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)





### 22 September 2025
{: #containers-sep2225}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

VPC File CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

IBM Storage Operator cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).



### 16 September 2025
{: #containers-sep1625}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 09 September 2025
{: #containers-sep0925}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)





### 08 September 2025
{: #containers-sep0825}
{: release-note}



New! Version support timelines
:   Version support timeline images are now available to help you plan your cluster update schedule. To view the timelines and end of support dates for cluster versions, see [{{site.data.keyword.containerlong_notm}} version information](/docs/containers?topic=containers-cs_versions)..


### 04 September 2025
{: #containers-sep0425}
{: release-note}


CLI version `1.0.717` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



## August 2025
{: #containers-aug25}

### 26 August 2025
{: #containers-aug2625}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)






### 22 August 2025
{: #containers-aug2225}
{: release-note}

IBM Storage Operator cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).

VPC File CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).




{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)




### 20 August 2025
{: #containers-aug2025}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 19 August 2025
{: #containers-aug1925}
{: release-note}



ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

### 14 August 2025
{: #containers-aug1425}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.33 change log](/docs/containers?topic=containers-changelog_133)
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)





CLI version `1.0.715` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



### 12 August 2025
{: #containers-aug1225}
{: release-note}

{{site.data.keyword.containerlong_notm}} version 1.33 Kubernetes certification
:   {{site.data.keyword.containerlong_notm}} version [1.33](/docs/containers?topic=containers-cs_versions_133) is now Kubernetes certified.



### 08 August 2025
{: #containers-aug0825}
{: release-note}

Trusted profiles
:   You can use trusted profiles to control access to your resources, including components such as Block Storage, File Storage, or Cloud Object Storage. For more information, see [Configuring a trusted profile for cluster components](/docs/containers?topic=containers-configure-trusted-profile&interface=ui)



### 05 August 2025
{: #containers-05aug25}
{: release-note}

CLI version `1.0.714` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



## July 2025
{: #containers-july25}

### 31 July 2025
{: #containers-31july25}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)

New! {{site.data.keyword.containerlong_notm}} version 1.33.
:   You can now create or [update clusters to Kubernetes version 1.33](/docs/containers?topic=containers-cs_versions_133). With Kubernetes 1.33, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

{{site.data.keyword.containerlong_notm}} version 1.30 is deprecated.
:   Support for 1.30 ends on {{site.data.keyword.kubernetes_130_unsupported_date}}. Update your cluster to [version 1.31](/docs/containers?topic=containers-cs_versions_131) as soon as possible.

{{site.data.keyword.containerlong_notm}} version 1.29 is unsupported.
:   Update your cluster to at least [version 1.30](/docs/containers?topic=containers-cs_versions_130) as soon as possible.




### 30 July 2025
{: #containers-30july25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)





### 25 July 2025
{: #containers-25july25}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).




### 22 July 2025
{: #containers-22july25}
{: release-note}

ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).





### 21 July 2025
{: #containers-21july25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 18 July 2025
{: #containers-18july25}
{: release-note}



IBM Storage Operator cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).

VPC File CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 17 July 2025
{: #containers-17july25}
{: release-note}



Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 15 July 2025
{: #containers-15july25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)





### 14 July 2025
{: #containers-14july25}
{: release-note}

VPC Block CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

### 01 July 2025
{: #containers-01july25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)





## June 2025
{: #containers-june25}





### 23 June 2025
{: #containers-june2325}
{: release-note}

ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).





### 18 June 2025
{: #containers-june1825}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)







### 17 June 2025
{: #containers-june1725}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

### 16 June 2025
{: #containers-16june25}
{: release-note}

CLI version `1.0.706` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)





IBM Storage Operator cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).

VPC File CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

### 04 June 2025
{: #containers-04jun25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






### 02 June 2025
{: #containers-02jun25}
{: release-note}

VPC Block CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).
 


Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




## May 2025
{: #containers-may25}

### 30 May 2025
{: #containers-30may25}
{: release-note}





{{site.data.keyword.containerlong_notm}} version 1.28 is unsupported.
:   Update your cluster to at least [version 1.29](/docs/containers?topic=containers-cs_versions_129) as soon as possible.

Ubuntu 20 is unsupported.
:   The Ubuntu 20 operating system is no longer supported. [Migrate your worker nodes to Ubuntu 24](/docs/containers?topic=containers-ubuntu-migrate) as soon as possible. 



### 28 May 2025
{: #containers-28may25}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)










### 20 May 2025
{: #containers-may2025}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






### 15 May 2025
{: #containers-may1525}
{: release-note}

New! Montreal multizone region
:   You can now [create VPC clusters](/docs/containers?topic=containers-cluster-create-vpc-gen2) in [Montreal](/docs/containers?topic=containers-regions-and-zones).
:   In this MZR, you can only create clusters at version 1.31 and later clusters and can only use Ubuntu 24 work nodes.
:   Also note that in this MZR, only webhooks that access an in-cluster service work. Webhooks that directly access an external, out of cluster, URL are blocked.
:   The default installation method for Portworx Enterprise and Portworx Backup is not yet supported for private-only clusters in the Montreal region. Contact Portworx Support if you need to install Portworx Enterprise or Portworx Backup in a private-only cluster in Montreal. For more information, see [Portworx Support](/docs/containers?topic=containers-storage_portworx_about#portworx-billing-support).

### 09 May 2025
{: #containers-09may25}
{: release-note}

VPC Block CSI Driver cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 07 May 2025
{: #containers-07may25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).






## April 2025
{: #containers-april25}

### 30 April 2025
{: #containers-30april25}
{: release-note}




{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







### 29 April 2025
{: #containers-apr2925}
{: release-note}

Istio add-on patch updates.
:   For the latest patch information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 27 April 2025
{: #containers-27april25}
{: release-note}

ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).






### 24 April 2025
{: #containers-24april25}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 22 April 2025
{: #containers-22april25}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







### 21 April 2025
{: #containers-21april25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).







### 08 April 2025
{: #containers-08april25}
{: release-note}





{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).




### 07 April 2025
{: #containers-07april25}
{: release-note}

Ingress ConfigMap change log updates
:   Updated the [Ingress ConfigMap change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).


### 02 April 2025
{: #containers-02april25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 01 April 2025
{: #containers-01april25}
{: release-note}

Creating Ubuntu 20 clusters or worker pools in cluster versions 1.29 - 1.31 is no longer supported.
:   For cluster versions 1.29 - 1.31, you can no longer provision new clusters or worker pools with Ubuntu 20 worker nodes. Ubuntu 20 is deprecated and support ends soon. If you have existing worker pools that use Ubuntu 20, migrate those worker pools to Ubuntu 24 as soon as possible. For more information, see [Migrating to a new Ubuntu 24](/docs/containers?topic=containers-ubuntu-migrate)




## March 2025
{: #containers-mar25}
  
### 27 March 2025
{: #containers-27march25}
{: release-note}





{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







### 25 March 2025
{: #containers-25march25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 24 March 2025
{: #containers-24march25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)








### 17 March 2025
{: #containers-17march25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

### 13 March 2025
{: #containers-13march25}
{: release-note}

CLI version `1.0.687` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).

### 11 March 2025
{: #containers-11march25}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 10 March 2025
{: #containers-10mar25}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 05 March 2025
{: #containers-05march25}
{: release-note}



Version 1.32 is now the default version for {{site.data.keyword.containerlong_notm}}.
:   For a complete list of available versions, see the [version information](/docs/containers?topic=containers-cs_versions).



Migrating from the Observability plug-in to {{site.data.keyword.logs_full_notm}}
:   Support for the Observability plug-in ends on 28 March 2025. Review and complete the migration steps before support ends.






### 04 March 2025
{: #containers-mar0425}
{: release-note}

Istio add-on patch updates.
:   For the latest patch information, see the [change log](/docs/containers?topic=containers-istio-changelog).




## February 2025
{: #containers-feb25}




### 26 February 2025
{: #containers-26february25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 24 February 2025
{: #containers-feb2425}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)






### 19 February 2025
{: #containers-feb1925}
{: release-note}

{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)






### 17 February 2025
{: #containers-feb1725}
{: release-note}

CLI version `1.0.679` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates.
:   For more information, see the [add-on change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

### 12 February 2025
{: #containers-feb1225}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)





### 11 February 2025
{: #containers-feb1125}
{: release-note}

CLI version `1.0.677` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 10 February 2025
{: #containers-feb1025}
{: release-note}

New! Worker node flavors with H200 GPU support are available on an allowlist basis for VPC clusters.
:   To request access to the allowlist, see see [Requesting access to allowlisted features](/docs/containers?topic=containers-allowlist-request).
:   For a list of available worker node flavors for VPC clusters, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors).


### 06 February 2025
{: #containers-06february25}
{: release-note}

Static Route cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-static-route).





## January 2025
{: #containers-jan25}

### 30 January 2025
{: #containers-jan3025}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.32 change log](/docs/containers?topic=containers-changelog_132)
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)






### 29 January 2025
{: #containers-jan2925}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} version 1.32.
:   You can now create or [update clusters to Kubernetes version 1.32](/docs/containers?topic=containers-cs_versions_132). With Kubernetes 1.32, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.




### 28 January 2025
{: #containers-jan2825}
{: release-note}

Istio add-on patch updates.
:   For the latest patch information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 24 January 2025
{: #containers-jan2425}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 23 January 2025
{: #containers-jan2325}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)








### 13 January 2025
{: #containers-jan1325}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)








### 08 January 2025
{: #containers-jan0825}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 06 January 2025
{: #containers-jan0625}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






## December 2024
{: #containers-dec24}

### 16 December 2024
{: #containers-dec1624}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)





### 11 December 2024
{: #containers-dec1124}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on versions `5.1.31_656` and `5.2.26_657`.
:   For more information, see the [add-on change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

Storage Operator cluster add-on patch update.
:  For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).


### 05 December 2024
{: #containers-dec0524}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)





### 04 December 2024
{: #containers-dec0424}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)








### 03 December 2024
{: #containers-dec0324}
{: release-note}

Istio add-on patch updates.
:   For the latest patch information, see the [change log](/docs/containers?topic=containers-istio-changelog).
Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


## November 2024
{: #containers-nov24}



### 21 November 2024
{: #containers-nov2124}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 20 November 2024
{: #containers-nov2024}
{: release-note}



Ubuntu 24 is now the default operating system for {{site.data.keyword.containerlong_notm}} versions 1.29 and 1.30.
:   New clusters and worker pools created at version 1.29 and 1.30 now use Ubuntu 24. The operating system for existing worker pools is not impacted. Ubuntu 20 was deprecated on [09 October 2024](#containers-oct0924) and support ends on 31 May 2025. If you are using Ubuntu 20 worker nodes, migrate your worker nodes to Ubuntu 24 before support ends. For more information, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate).



{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 19 November 2024
{: #containers-nov1924}
{: release-note}

CLI version `1.0.674` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 18 November 2024
{: #containers-nov1824}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






### 14 November 2024
{: #containers-nov1424}
{: release-note}

Secure by default networking can now be enabled on VPC clusters that were created before 1.30.
:   Secure by default networking introduced new security group configurations and behaviors for new VPC clusters beginning with 1.30. Clusters created at versions 1.29 and earlier did not get the secure by default security group configurations when updating to 1.30. However, you can now update your cluster's security group configurations for clusters that were created at versions 1.29 and earlier. For more information, see [Enabling secure by default for clusters created at 1.29 and earlier](/docs/containers?topic=containers-vpc-sbd-enable-existing).

CLI version `1.0.673` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 13 November 2024
{: #containers-nov1324}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







### 07 November 2024
{: #containers-nov0724}
{: release-note}

New! A new tutorial is available for {{site.data.keyword.containerlong_notm}} that covers how to migrate from a private service endpoint allowlist (PSE) to context based restrictions (CBR).
:   Private service endpoint allowlists are deprecated and support ends on 10 February 2025. Migrate from PSE allowlists to CBR as soon as possible. For more information and migration steps, see [Migrating from a private service endpoint allowlist to context based restrictions (CBR)](/docs/containers?topic=containers-pse-to-cbr-migration).

### 05 November 2024
{: #containers-nov0524}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






## October 2024
{: #containers-oct24}


  
 
### 31 October 2024
{: #containers-oct3124}
{: release-note}

ALB OAuth Proxy cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).

Version 1.31 is now the default version for {{site.data.keyword.containerlong_notm}}.
:   For a complete list of available versions, see the [version information](/docs/containers?topic=containers-cs_versions).



### 30 October 2024
{: #containers-oct3024}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)








### 21 October 2024
{: #containers-oct2124}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs are available.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






### 17 October 2024
{: #containers-oct1724}
{: release-note}





Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 11 October 2024
{: #containers-oct1124}
{: release-note}

Istio add-on patch update `1.22.5` has been reverted.
:   For the latest patch information, see the [change log](/docs/containers?topic=containers-istio-changelog).





### 10 October 2024
{: #containers-oct1024}
{: release-note}

Istio add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 09 October 2024
{: #containers-oct0924}
{: release-note}



Ubuntu 20 for {{site.data.keyword.containerlong_notm}} clusters is deprecated and support ends on 31 May 2025.
:   Migrate your worker nodes to Ubuntu 24 before support ends. Make sure you understand the [limitations for Ubuntu 24](/docs/containers?topic=containers-ubuntu-migrate#ubuntu-24-lim) before you begin migration. For more information, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate).

{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)





### 07 October 2024
{: #containers-oct0724}
{: release-note}



New! The `gx3d.160x1792.8h100` worker node flavor with H100 GPU support is available for VPC clusters.
:   For a list of available flavors, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors).

### 03 October 2024
{: #containers-oct0324}
{: release-note}

{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

Storage Operator cluster add-on patch update.
:  For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).


Static route add-on version patch update.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-static-route).


### 01 October 2024
{: #containers-oct0124}
{: release-note}


New! The {{site.data.keyword.cos_full_notm}} cluster add-on is available in Beta for allowlisted accounts.
:   For more information, see the [Installing the {{site.data.keyword.cos_full_notm}} cluster add-on](/docs/containers?topic=containers-storage-cos-install-addon).



## September 2024
{: #containers-sep24}

### 26 September 2024
{: #containers-sep2624}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 25 September 2024
{: #containers-sep2524}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)






### 24 September 2024
{: #containers-sep2424}
{: release-note}



Ubuntu 24 is now available for {{site.data.keyword.containerlong_notm}} clusters.
:   You can now create {{site.data.keyword.containerlong_notm}} clusters that have Ubuntu 24 worker nodes. To migrate existing Ubuntu 20 workers to Ubuntu 24, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate). To review operating system support by cluster version, see [{{site.data.keyword.containerlong_notm}} version information](/docs/containers?topic=containers-cs_versions). To review a list of worker node flavors with Ubuntu 24 support, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors) or [Classic flavors](/docs/containers?topic=containers-classic-flavors).



{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



### 23 September 2024
{: #containers-23september24}
{: release-note}


Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.31 change log](/docs/containers?topic=containers-changelog_131)
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)







### 20 September 2024
{: #containers-sep2024}
{: release-note}

{{site.data.keyword.containerlong_notm}} version 1.31 Kubernetes certification
:   {{site.data.keyword.containerlong_notm}} version [1.31](/docs/containers?topic=containers-cs_versions_131) is now Kubernetes certified.

Istio add-on version `1.23.1` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).




### 18 September 2024
{: #containers-sep1824}
{: release-note}


{{site.data.keyword.containerlong_notm}} CLI plug-in version `1.0.665` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



New! {{site.data.keyword.containerlong_notm}} version 1.31.
:   You can now create or [update clusters to Kubernetes version 1.31](/docs/containers?topic=containers-cs_versions_131). With Kubernetes 1.31, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

{{site.data.keyword.containerlong_notm}} version 1.28 is deprecated.
:   Support for 1.28 ends on {{site.data.keyword.kubernetes_128_unsupported_date}}. Update your cluster to at least [version 1.29](/docs/containers?topic=containers-cs_versions_129) as soon as possible.

{{site.data.keyword.containerlong_notm}} version 1.27 is unsupported.
:   Update your cluster to at least [version 1.28](/docs/containers?topic=containers-cs_versions_128) as soon as possible.


Istio add-on version `1.22.4` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).




### 16 September 2024
{: #containers-sep1624}
{: release-note}

New! The {{site.data.keyword.cloud}} and Compliance Center Workload Protection integration is available for VPC clusters in the UI. 
:   For more information, see the list of Observability Integrations in [Creating a VPC cluster in the console](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui#clusters_vpcg2_ui).

### 12 September 2024
{: #containers-sep1224}
{: release-note}



Ingress ALB patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 10 September 2024
{: #containers-sep1024}
{: release-note}

CLI version `1.0.657` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).





{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)
:   Version 1.27 change log







## August 2024
{: #containers-aug24}



### 29 August 2024
{: #containers-aug2924}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 28 August 2024
{: #containers-aug2824}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   Version 1.29 change log
:   Version 1.28 change log
:   Version 1.27 change log








### 27 August 2024
{: #containers-27august24}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


### 26 August 2024
{: #containers-aug2624}
{: release-note}

{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

Storage Operator cluster add-on patch update.
:  For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).



{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   Version 1.29 change log
:   Version 1.28 change log
:   Version 1.27 change log






### 23 August 2024
{: #containers-aug2324}
{: release-note}

CLI version `1.0.652` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 22 August 2024
{: #containers-aug2224}
{: release-note}

New audit events for cluster operations
:   The `containers-kubernetes.cluster-master.changed` and `containers-kubernetes.cluster-ssl-certificate.update` [audit events](/docs/containers?topic=containers-at_events_ref) are available. 



### 20 August 2024
{: #containers-aug2024}
{: release-note}

Istio add-on versions `1.22.3`, `1.21.5`, and `1.20.8` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).




## July 2024
{: #containers-july24}

### 31 July 2024
{: #containers-july3124}
{: release-note}



{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the following change logs for your cluster version.
:   [Version 1.30 change log](/docs/containers?topic=containers-changelog_130)
:   Version 1.29 change log
:   Version 1.28 change log
:   Version 1.27 change log






{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 29 July 2024
{: #containers-july2924}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   1.29
:   1.28
:   1.27



### 17 July 2024
{: #containers-july1724}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.containerlong_notm}} CLI version `1.0.640` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 15 July 2024
{: #containers-july1524}
{: release-note}





{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   1.29
:   1.28
:   1.27




{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

Storage Operator cluster add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-ibm-storage-operator).

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).





### 12 July 2024
{: #containers-july1224}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.638` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).




### 11 July 2024
{: #containers-july1124}
{: release-note}


Ingress ALB updates are available for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 10 July 2024
{: #containers-july1024}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.635` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 9 July 2024
{: #containers-july924}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.632` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   1.29
:   1.28
:   1.27



### 3 July 2024
{: #containers-july324}
{: release-note}

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version 2.0 is available in Beta.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

## June 2024
{: #containers-june24}

### 24 June 2024
{: #containers-june2424}
{: release-note}



Version 1.30 is the default version for {{site.data.keyword.containerlong_notm}}.
:   For a complete list of available versions, see the [version information](/docs/containers?topic=containers-cs_versions).

Ubuntu 24 in Beta
:   Ubuntu 24 is available in Beta. Limitations apply. For more information, see [Ubuntu 24 limitations](/docs/containers?topic=containers-ubuntu-migrate#ubuntu-24-lim).



Storage optimized flavors for {{site.data.keyword.containerlong_notm}} VPC clusters
:   New storage optimized `ox2` flavors are available. For more information, see the [VPC flavors](/docs/containers?topic=containers-vpc-flavors).

{{site.data.keyword.containerlong_notm}} CLI version `1.0.630` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 21 June 2024
{: #containers-june2124}
{: release-note}

Cluster autoscaler add-on patch updates for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.block_storage_is_short}} add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

### 20 June 2024
{: #containers-june2024}
{: release-note}

Cluster autoscaler add-on patch update for {{site.data.keyword.containerlong_notm}}.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).



Ingress ALB updates are available for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

Istio add-on versions `1.22.1` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 19 June 2024
{: #containers-june1924}
{: release-note}



{{site.data.keyword.containerlong_notm}} master and worker node fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   1.29
:   1.28
:   1.27

Istio add-on versions `1.21.3` and `1.20.7` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).








### 17 June 2024
{: #containers-june1724}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.628` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).







### 5 June 2024
{: #containers-june0524}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.26`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

  
### 4 June 2024
{: #containers-june0424}
{: release-note}
 

{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   1.29
:   1.28
:   1.27

ALB OAuth Proxy add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).




### 3 June 2024
{: #containers-june0324}
{: release-note}

{{site.data.keyword.containerlong_notm}} version 1.26 is no longer supported.
:   Update your cluster to at least [version 1.27](/docs/containers?topic=containers-cs_versions_127) as soon as possible.






### 30 May 2024
{: #containers-may3024}
{: release-note}

Ingress ALB updates are available for {{site.data.keyword.containerlong_notm}}.
:   Version 1.6.4 is no longer supported. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 29 May 2024
{: #containers-may2924}
{: release-note}



New! {{site.data.keyword.containerlong_notm}} version 1.30.
:   You can now create or [update clusters to Kubernetes version 1.30](/docs/containers?topic=containers-cs_versions_130). With Kubernetes 1.30, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

{{site.data.keyword.containerlong_notm}} version 1.30 Kubernetes certification
:   {{site.data.keyword.containerlong_notm}} version [1.30](/docs/containers?topic=containers-cs_versions_130) is now Kubernetes certified.

Important networking changes for {{site.data.keyword.containerlong_notm}} VPC clusters created at version 1.30.
:   For more information, see the [130 version information](/docs/containers?topic=containers-cs_versions_130) and [Understanding Secure by Default Cluster VPC Networking](/docs/containers?topic=containers-vpc-security-group-reference).

Important changes to the default cluster provisioning behavior for new VPC clusters beginning with version 1.30.
:   Beginning with version 1.30, there is a new option available at cluster creation time via the UI, CLI, API, and Terraform. This new option manages outbound traffic protection for the cluster. The default behavior is to have outbound traffic protection enabled, which means new version 1.30 VPC clusters won't have access the public internet by default. If your cluster needs access to the public internet, you must specifically include the option (from the UI, CLI, API, and Terraform) to disable outbound traffic protection. Note that you can also disable outbound traffic protection after your cluster is created. You can also selectively allow outbound traffic as needed after your cluster is created. If you provision clusters via automation, make sure to adjust your automation accordingly.
:   For more information, see the [1.30 version information](/docs/containers?topic=containers-cs_versions_130), [Understanding Secure by Default Cluster VPC Networking](/docs/containers?topic=containers-vpc-security-group-reference), and [Managing outbound traffic protection in VPC clusters](/docs/containers?topic=containers-sbd-allow-outbound).

Managing outbound traffic protection in new version 1.30 VPC clusters.
:   With the introduction of Secure by Default Cluster VPC networking in version 1.30 and later clusters, there are several scenarios where you might need to adjust the security group settings for your clusters to allow outbound traffic to certain resources. For more information, see [Managing outbound traffic protection in VPC clusters](/docs/containers?topic=containers-sbd-allow-outbound).

{{site.data.keyword.containerlong_notm}} version 1.27 is deprecated.
:   Support for 1.27 ends on {{site.data.keyword.kubernetes_127_unsupported_date}}. Update your cluster to at least [version 1.28](/docs/containers?topic=containers-cs_versions_128) as soon as possible.








{{site.data.keyword.containerlong_notm}} master fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27








### 23 May 2024
{: #containers-may2324}
{: release-note}




{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26







### 10 May 2024
{: #containers-may1024}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).





Istio add-on version `1.19` is no longer supported.
:   Update the add-on in your clusters to a supported version. For more information, see the [Updating the Istio add-on](/docs/containers?topic=containers-istio-update) and the [change log](/docs/containers?topic=containers-istio-changelog).







### 08 May 2024
{: #containers-may0824}
{: release-note}



Istio add-on versions `1.21.2` and `1.20.6` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).





ALB OAuth Proxy add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).







### 07 May 2024
{: #containers-may0724}
{: release-note}





{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29 
:   1.28
:   1.27
:   1.26






### 05 May 2024
{: #containers-may0524}
{: release-note}

{{site.data.keyword.containerlong_notm}} cluster autoscaler add-on patch updates.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

### 02 May 2024
{: #containers-may0224}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.618` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



## April 2024
{: #containers-apr24}





### 29 April 2024
{: #containers-apr2924}
{: release-note}

Ingress ConfigMap update
:   For more information, see the [change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).



### 24 April 2024
{: #containers-apr2424}
{: release-note}







{{site.data.keyword.containerlong_notm}} master and worker node fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26








Istio add-on versions `1.21.1`, `1.20.5`, and `1.19.9` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



{{site.data.keyword.cos_full_notm}} plug-in version `2.2.25`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.containerlong_notm}} CLI version `1.0.617` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 18 April 2024
{: #containers-apr1824}
{: release-note}

{{site.data.keyword.containerlong_notm}} CLI version `1.0.613` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

### 09 April 2024
{: #containers-apr0924}
{: release-note}



Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26








### 03 April 2024
{: #containers-apr0324}
{: release-note}



Istio add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).

ALB OAuth Proxy add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



{{site.data.keyword.containerlong_notm}} cluster autoscaler add-on patch updates.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

Version 1.0.9 of the cluster autoscaler add-on is deprecated with an end of support date of 30 April 2024.
:   Update to a supported version of the add-on before 30 April 2024.







## March 2024
{: #containers-mar24}

### 27 March 2024
{: #containers-mar2724}
{: release-note}



Master patch updates for {{site.data.keyword.containerlong_notm}} clusters. Master patches are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26





### 25 March 2024
{: #containers-mar2524}
{: release-note}



Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26






New! NVIDIA L40 GPU support. You can now create VPC clusters with worker nodes which have NVIDIA L40 GPUs.
:   L40 GPU support is available in {{site.data.keyword.containerlong_notm}} clusters at version 1.28 or later with `gx3` worker nodes.
:   When you provision a version 1.28 or later VPC cluster with `gx3` worker nodes, or add a `gx3` worker pool to an existing 1.28 or later VPC cluster, the GPU drivers are automatically installed and you can get started right away. For more information, see [Deploying an app on a GPU machine](/docs/containers?topic=containers-deploy_app#gpu_app).




### 18 March 2024
{: #containers-mar1824}
{: release-note}


Ingress ALB updates are available for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 15 March 2024
{: #containers-mar1524}
{: release-note}



Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26

Version 1.29 is the default version for {{site.data.keyword.containerlong_notm}}.
:   For a complete list of available versions, see the [version information](/docs/openshift?topic=openshift-openshift_versions).






### 08 March 2024
{: #containers-mar0824}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).




### 06 March 2024
{: #containers-mar0624}
{: release-note}


Istio add-on versions `1.20.3` and `1.19.7` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).


CLI version `1.0.601` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

## February 2024
{: #containers-feb24}

### 28 February 2024
{: #containers-feb2824}
{: release-note}

{{site.data.keyword.containerlong_notm}} cluster autoscaler version 1.2.1 is available.
:   Version 1.2.1 of the autoscaler adds support for cluster version 1.29. For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).





Master patch updates for {{site.data.keyword.containerlong_notm}} clusters. Master patches are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Review the change logs for your cluster version.
:   1.29
:   1.28
:   1.27
:   1.26








### 27 February 2024
{: #containers-feb2724}
{: release-note}




Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - 1.29.2_1529
    - 1.28.7_1547
    - 1.27.11_1567
    - 1.26.14_1576





CLI version `1.0.597` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 26 February 2024
{: #containers-feb2624}
{: release-note}

New! NVIDIA L4 GPU support. You can now create VPC clusters with worker nodes which have NVIDIA L4 GPUs.
:   L4 GPU support is available in {{site.data.keyword.containerlong_notm}} clusters at version 1.28 or later with `gx3` worker nodes.
:   When you provision a version 1.28 or later VPC cluster with `gx3` worker nodes, or add a `gx3` worker pool to an existing 1.28 or later VPC cluster, the GPU drivers are automatically installed and you can get started right away. For more information, see [Deploying an app on a GPU machine](/docs/containers?topic=containers-deploy_app#gpu_app).



Ingress ALB patch updates `1.9.4_6376_iks`, `1.8.4_6375_iks`, and `1.6.4_6374_iks` for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



New worker node flavors are available with L4 GPUs.
:   The following worker node flavors with L4 GPUs are now available. For more information, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors).
    - `gx3.16x80x1L4`: 1 GPU, 16 cores, 80 GB memory, 100GB storage, 32 Gbps network speed.
    - `gx3.32x160x2L4`: 2 GPU, 32 cores, 160 GB, memory, 100GB storage, 32 Gbps network speed
    - `gx3.64x320x4L4`: 4 GPU, 64 cores, 320 GB memory, 100GB storage, 32 Gbps network speed




### 22 February 2024
{: #containers-feb2224}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.24`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 21 February 2024
{: #containers-feb2124}
{: release-note}



Kubernetes version 1.29 certification
:   Version [1.29](/docs/containers?topic=containers-cs_versions_129) release is now certified.



{{site.data.keyword.containerlong_notm}} cluster autoscaler add-on patch updates `1.0.9_377` and `1.2.0_365`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).





### 19 February 2024
{: #containers-feb1924}
{: release-note}

Ingress ALB versions `1.9.4_6359_iks` and `1.8.4_6363_iks` are available for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 16 February 2024
{: #containers-feb1624}
{: release-note}



{{site.data.keyword.containerlong_notm}} cluster autoscaler add-on patch update `1.1.0_362`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).





### 14 February 2024
{: #containers-feb1424}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} version 1.29.
:   You can create or [update clusters to Kubernetes version 1.29](/docs/containers?topic=containers-cs_versions_129). With Kubernetes 1.29, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

Master fix pack `1.29.1_1524` and worker node fix pack `1.29.1_1525`.
:   For more information, see the [1.29 change log](/docs/containers?topic=containers-changelog_129).

Starting with {{site.data.keyword.containerlong_notm}} version 1.29, Calico components run in the `calico-system` namespace and the Tigera operator components run in the `tigera-operator` namespace.
:   For more information, see [1.29 version information and update actions](/docs/containers?topic=containers-cs_versions_129).


{{site.data.keyword.containerlong_notm}} version 1.26 is deprecated.
:   Update your cluster to at least [version 1.27](/docs/containers?topic=containers-cs_versions_127) as soon as possible.




### 13 February 2024
{: #containers-feb1324}
{: release-note}



Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - 1.28.6_1544
    - 1.27.10_1563
    - 1.26.13_1571

Ingress ALB versions `1.9.4_6346_iks`, `1.8.4_6345_iks`, `1.6.4_6344_iks` are available for {{site.data.keyword.containerlong_notm}}.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).








### 08 February 2024
{: #containers-feb0824}
{: release-note}

CLI version `1.0.595` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).

{{site.data.keyword.block_storage_is_short}} add-on versions `5.2.15_501` and `5.1.21_506` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.2.6_130` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).




### 07 February 2024
{: #containers-feb0724}
{: release-note}

Istio add-on versions `1.20.2`, `1.19.6`, and `1.18.7` are available.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).


### 05 February 2024
{: #containers-feb0524}
{: release-note}

  
Ingress ALB updates
:   Ingress ALB versions `1.9.4_6292_iks`, `1.8.4_6291_iks`, `1.6.4_6293_iks` are available. 1.9.4 is the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 01 February 2024
{: #containers-feb0124}
{: release-note}



Master fix packs are available for {{site.data.keyword.containerlong_notm}}
:   Review the change logs for your cluster version. Master patch updates are applied automatically.
:   1.28.6_1542
:   1.27.10_1561
:   1.26.13_1569

{{site.data.keyword.containerlong_notm}} version 1.25 is no longer supported.
:   Update your 1.25 clusters to at least version 1.26.






{{site.data.keyword.containerlong_notm}} cluster autoscaler add-on patch update `1.0.8_346`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).


## January 2024
{: #containers-jan24}

### 30 January 2024
{: #containers-jan3024}
{: release-note}



Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - 1.28.6_1543
    - 1.27.10_1562
    - 1.26.13_1570





### 29 January 2024
{: #containers-jan2924}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.23`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



### 22 January 2024
{: #containers-jan2224}
{: release-note}

  
Ingress ALB updates
:   Ingress ALB versions `1.9.4_6251_iks`, `1.8.4_6245_iks`, `1.6.4_6250_iks` are available. 1.9.4 is the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 19 January 2024
{: #containers-jan1924}
{: release-note}

CLI version `1.0.589` is available.
:   For more information, see [Updating the CLI](/docs/containers?topic=containers-cli-update) and the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



### 17 January 2024
{: #containers-jan1724}
{: release-note}



Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - 1.28.4_1541
    - 1.27.8_1560
    - 1.26.11_1568
    - 1.25.16_1573






### 16 January 2024
{: #containers-jan1624}
{: release-note}

Cluster autoscaler add-on patch updates `1.2.0_322` and `1.0.9_328`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).



ALB OAuth Proxy add-on version `2.0.0_2063`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).








### 10 January 2024
{: #containers-jan1024}
{: release-note}

Subscribe to the {{site.data.keyword.cloud_notm}} documentation release notes via RSS.
:   You can get notified via RSS about documentation updates for {{site.data.keyword.containerlong_notm}} such as worker node fix packs, new cluster versions, new cluster add-on versions, and more.  For more information, see [Subscribing to an RSS feed](/docs/containers?topic=containers-best-practices-service#bp-4).


  
Ingress ALB updates
:   Ingress ALB versions `1.9.4_6161_iks`, `1.8.4_6173_iks`, `1.6.4_6177_iks` are available. 1.9.4 is the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

Istio cluster add-on versions `1.20.0`, `1.19.5`, and `1.18.6`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).

Istio add-on version 1.18 will no longer be supported on 21 February 2024
:   Follow the steps to update your [Istio components](/docs/containers?topic=containers-istio-update#istio_minor) to the latest patch version of Istio 1.18 that is supported by {{site.data.keyword.containerlong_notm}}.



{{site.data.keyword.filestorage_vpc_full_notm}} cluster add-on patch update `1.2.5_107`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

{{site.data.keyword.block_storage_is_short}} cluster add-on patch updates `5.2.14_485` and `5.1.19_486`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).





### 2 January 2024
{: #containers-jan0224}
{: release-note}



Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - 1.28.4_1540
    - 1.27.8_1559
    - 1.26.11_1567
    - 1.25.16_1572
