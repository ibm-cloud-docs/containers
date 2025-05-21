---

copyright: 
  years: 2014, 2025
lastupdated: "2025-05-21"


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



## May 2025
{: #containers-may25}



### 21 May 2025
{: #containers-21may25}
{: release-note}

Ingress ALB cluster add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

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
:   Support for the Observability plug-in ends on 28 March 2025. Review and complete the migration steps before support ends. For more information, see [Migrating logging and monitoring agents to Cloud Logs](/docs/containers?topic=containers-health#logging_forwarding).






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
:   [Version 1.27 change log](/docs/containers?topic=containers-changelog_127)







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
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)
:   [Version 1.27 change log](/docs/containers?topic=containers-changelog_127)








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
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)
:   [Version 1.27 change log](/docs/containers?topic=containers-changelog_127)






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
:   [Version 1.29 change log](/docs/containers?topic=containers-changelog_129)
:   [Version 1.28 change log](/docs/containers?topic=containers-changelog_128)
:   [Version 1.27 change log](/docs/containers?topic=containers-changelog_127)






{{site.data.keyword.cos_full_notm}} plug-in updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 29 July 2024
{: #containers-july2924}
{: release-note}



{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.30](/docs/containers?topic=containers-changelog_130)
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)



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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)




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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)



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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)

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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)

ALB OAuth Proxy add-on patch updates.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).




### 3 June 2024
{: #containers-june0324}
{: release-note}

{{site.data.keyword.containerlong_notm}} version 1.26 is no longer supported.
:   Update your cluster to at least [version 1.27](/docs/containers?topic=containers-cs_versions_127) as soon as possible.



## May 2024
{: #containers-may24}





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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)








### 23 May 2024
{: #containers-may2324}
{: release-note}




{{site.data.keyword.containerlong_notm}} worker node fix packs.
:   Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)







### 10 May 2024
{: #containers-may1024}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch update.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).





Istio add-on version `1.19` is no longer supported.
:   Update the add-on in your clusters to a supported version. For more information, see the [Updating the Istio add-on](/docs/containers?topic=containers-istio&interface=ui#istio_update) and the [change log](/docs/containers?topic=containers-istio-changelog).







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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)






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
:   For more information, see the [change log](https://cloud.ibm.com/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).



### 24 April 2024
{: #containers-apr2424}
{: release-note}







{{site.data.keyword.containerlong_notm}} master and worker node fix packs.
:   Master fix packs are applied automatically over the course of several days. You can choose to use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply the patch. Worker node fix packs can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)








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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)








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
:   [1.29](/docs/containers?topic=containers-changelog_128)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)





### 25 March 2024
{: #containers-mar2524}
{: release-note}



Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure. Review the following change logs for your cluster version.
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)






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
:   [1.29](/docs/containers?topic=containers-changelog_129)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)

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
:   [1.29](/docs/containers?topic=containers-changelog_128)
:   [1.28](/docs/containers?topic=containers-changelog_128)
:   [1.27](/docs/containers?topic=containers-changelog_127)
:   [1.26](/docs/containers?topic=containers-changelog_126)








### 27 February 2024
{: #containers-feb2724}
{: release-note}




Worker node fix packs are available for {{site.data.keyword.containerlong_notm}}. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - [1.29.2_1529](/docs/containers?topic=containers-changelog_129)
    - [1.28.7_1547](/docs/containers?topic=containers-changelog_128)
    - [1.27.11_1567](/docs/containers?topic=containers-changelog_127)
    - [1.26.14_1576](/docs/containers?topic=containers-changelog_126)





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
    - [1.28.6_1544](/docs/containers?topic=containers-changelog_128)
    - [1.27.10_1563](/docs/containers?topic=containers-changelog_127)
    - [1.26.13_1571](/docs/containers?topic=containers-changelog_126)

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
:   [1.28.6_1542](/docs/containers?topic=containers-changelog_128)
:   [1.27.10_1561](/docs/containers?topic=containers-changelog_127)
:   [1.26.13_1569](/docs/containers?topic=containers-changelog_126)

{{site.data.keyword.containerlong_notm}} version 1.25 is no longer supported.
:   Update your 1.25 clusters to at least version 1.26. For more information, see [1.26 version information and update actions](/docs/containers?topic=containers-cs_versions_126).






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
    - [1.28.6_1543](/docs/containers?topic=containers-changelog_128)
    - [1.27.10_1562](/docs/containers?topic=containers-changelog_127)
    - [1.26.13_1570](/docs/containers?topic=containers-changelog_126)





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
    - [1.28.4_1541](/docs/containers?topic=containers-changelog_128)
    - [1.27.8_1560](/docs/containers?topic=containers-changelog_127)
    - [1.26.11_1568](/docs/containers?topic=containers-changelog_126)
    - [1.25.16_1573](/docs/containers?topic=containers-changelog_125)






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
:   Follow the steps to update your [Istio components](/docs/containers?topic=containers-istio#istio_minor) to the latest patch version of Istio 1.18 that is supported by {{site.data.keyword.containerlong_notm}}.



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
    - [1.28.4_1540](/docs/containers?topic=containers-changelog_128)
    - [1.27.8_1559](/docs/containers?topic=containers-changelog_127)
    - [1.26.11_1567](/docs/containers?topic=containers-changelog_126)
    - [1.25.16_1572](/docs/containers?topic=containers-changelog_125)






## December 2023
{: #containers-dec23}

### 18 December 2023
{: #containers-dec1823}
{: release-note}



Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - [1.28.4_1539](/docs/containers?topic=containers-changelog_128)
    - [1.27.8_1558](/docs/containers?topic=containers-changelog_127)
    - [1.26.11_1566](/docs/containers?topic=containers-changelog_126)
    - [1.25.16_1571](/docs/containers?topic=containers-changelog_125)





### 14 December 2023
{: #containers-dec1423}
{: release-note}

Information on worker node removal priority.
:   Details are available for [automated worker node removal](/docs/containers?topic=containers-update#worker-scaledown-logic) when scaling down a worker pool.


Kubernetes version 1.24 is unsupported.
:   Update your cluster to at least [version 1.25](/docs/containers?topic=containers-cs_versions_125) as soon as possible.












### 8 December 2023
{: #containers-dec0823}
{: release-note}

Security Bulletin: {{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities
:   For more information, see the [Security Bulletin](https://www.ibm.com/support/pages/node/7091444){: external}. 


### 7 December 2023
{: #containers-dec0723}
{: release-note}

Istio add-on version `1.20.0`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 6 December 2023
{: #containers-dec0623}
{: release-note}



Master fix packs are available. 
:   Review the change logs for your cluster version. Master patch updates are applied automatically.
:   [1.28.4_1537](/docs/containers?topic=containers-changelog_128)
:   [1.27.8_1556](/docs/containers?topic=containers-changelog_127)
:   [1.26.11_1564](/docs/containers?topic=containers-changelog_126)
:   [1.25.16_1569](/docs/containers?topic=containers-changelog_125)







  
### 5 December 2023
{: #containers-dec0523}
{: release-note}

Istio add-on version `1.19.4`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).
  




### 4 December 2023
{: #containers-dec0423}
{: release-note}


  
Ingress ALB updates
:   Ingress ALB versions `1.9.4_5886_iks`, `1.8.4_5885_iks`, `1.6.4_5884_iks` are available. 1.9.4 is now the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - [1.28.4_1538](/docs/containers?topic=containers-changelog_128)
    - [1.27.8_1557](/docs/containers?topic=containers-changelog_127)
    - [1.26.11_1565](/docs/containers?topic=containers-changelog_126)
    - [1.25.16_1570](/docs/containers?topic=containers-changelog_125)
    - [1.24.17_1592](/docs/containers?topic=containers-changelog_124)





## November 2023
{: #containers-nov23}

### 29 November 2023
{: #containers-nov2923}
{: release-note}




Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - [1.28.3_1535](/docs/containers?topic=containers-changelog_128)
    - [1.27.7_1548](/docs/containers?topic=containers-changelog_127)
    - [1.26.10_1561](/docs/containers?topic=containers-changelog_126)
    - [1.25.15_1568](/docs/containers?topic=containers-changelog_125)
    - [1.24.17_1591](/docs/containers?topic=containers-changelog_124)





### 27 November 2023
{: #containers-nov2723}
{: release-note}

The Beta {{site.data.keyword.filestorage_vpc_short}} cluster add-on is now available to all accounts.
:   Previously the add-on was available in allowlisted accounts only. For more information, see [Enabling the {{site.data.keyword.filestorage_vpc_short}} add-on](/docs/containers?topic=containers-cluster-scaling-install-addon).

Cluster autoscaler add-on patch updates `1.2.0_290`, `1.0.9_290`, `1.0.8_292`, and `1.0.7_291`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.23_437` and `5.1.16_446`, and `5.2.11_447`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch `1.1.10_93` and `1.2.3_97`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).





### 21 November 2023
{: #containers-nov2123}
{: release-note}



Ingress ALB updates
:    Ingress ALB versions `1.9.4_5756_iks`, `1.8.4_5757_iks`, `1.6.4_5727_iks` are available. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 20 November 2023
{: #containers-nov2023}
{: release-note}

You can now specify a custom pod subnet size when creating a VPC cluster.
:   For more information, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_cluster-create-vpc-gen2) or [create a VPC cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=cli#cluster_create_vpc) with a custom pod subnet size.

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.22`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 15 November 2023
{: #containers-nov1523}
{: release-note}

The cluster autoscaler add-on now supports version 1.28 clusters.
:   For more information, see [Enabling the cluster autoscaler add-on in your cluster](/docs/containers?topic=containers-cluster-scaling-install-addon).



Master fix packs are available. 
:   Review the change logs for your cluster version. Master patch updates are applied automatically.
:   [1.28.3_1534](/docs/containers?topic=containers-changelog_128)
:   [1.27.7_1547](/docs/containers?topic=containers-changelog_127)
:   [1.26.10_1560](/docs/containers?topic=containers-changelog_126)
:   [1.25.15_1567](/docs/containers?topic=containers-changelog_125)







### 13 November 2023
{: #containers-nov1323}
{: release-note}


{{site.data.keyword.cos_full_notm}} plug-in version `2.2.21`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.21_401` and `5.1.15_419`, and `5.2.10_428`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

Cluster autoscaler add-on patch updates `1.0.9_195`, `1.0.8_233`, and `1.0.7_185`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on patch `1.1.9_87`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).



### 10 November 2023
{: #containers-nov1023}
{: release-note}

Updated sorting and formatting for the Classic and VPC cluster flavor pages.
:   For more information, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors) and [Classic flavors](/docs/containers?topic=containers-classic-flavors).

### 9 November 2023
{: #containers-nov0923}
{: release-note}



Worker node fix packs are available.
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.

:   [1.28.2_1533](/docs/containers?topic=containers-changelog_128)
:   [1.27.6_1546](/docs/containers?topic=containers-changelog_127)
:   [1.26.9_1559](/docs/containers?topic=containers-changelog_126)
:   [1.25.14_1566](/docs/containers?topic=containers-changelog_125)
:   [1.24.17_1590](/docs/containers?topic=containers-changelog_124)





### 7 November 2023
{: #containers-nov0723}
{: release-note}

CLI version `1.0.579` is available.
:   For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



Ingress ALB updates
:    Ingress ALB versions `1.9.4_5698_iks`, `1.8.4_5644_iks`, `1.6.4_5642_iks` are available. Version `1.8.4_5644_iks` is now the default version. Version `1.5.1` is no longer supported. For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




  
### 06 November 2023
{: #containers-nov0623}
{: release-note}

Kubernetes version 1.28 is now the default version for new {{site.data.keyword.containerlong_notm}} clusters.
:   For more information, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions), the [1.28 version information and update actions](/docs/containers?topic=containers-cs_versions_128), and the [1.28 change log](/docs/containers?topic=containers-changelog_128).





## October 2023
{: #containers-oct23}

### 31 October 2023
{: #containers-oct3123}
{: release-note}


VNI functionality for limiting access to {{site.data.keyword.filestorage_vpc_short}} by node, zone, worker pool and more.
:   You now have more granular control over how pods access your {{site.data.keyword.filestorage_vpc_short}}. For more information, see [Limiting file share access by worker node, zone, or worker pool](/docs/containers?topic=containers-storage-file-vpc-apps#storage-file-vpc-vni-setup).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.2`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).


### 30 October 2023
{: #containers-oct3023}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.20`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

Setting up alerts for {{site.data.keyword.blockstorageshort}} PVs with limited network connectivity.
:   For more information, see [Setting up monitoring for `limited` connectivity PVs](/docs/containers?topic=containers-block_storage#storage-block-vpc-limited-monitoring).

### 25 October 2023
{: #containers-oct2523}
{: release-note}



Master fix packs are available.
:   [1.28.2_1531](/docs/containers?topic=containers-changelog_128)
:   [1.27.6_1544](/docs/containers?topic=containers-changelog_127)
:   [1.26.9_1557](/docs/containers?topic=containers-changelog_126)
:   [1.25.14_1564](/docs/containers?topic=containers-changelog_125)


ALB OAuth Proxy add-on version `2.0.0_1901`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).






### 23 October 2023
{: #containers-oct2323}
{: release-note}



Worker node fix packs are available. 
:    Worker node updates can be applied by updating or reloading the worker node in classic infrastructure, or replacing the worker node in VPC infrastructure.
:    Review the following change logs for your cluster version.
    - [1.28.2_1532](/docs/containers?topic=containers-changelog_128)
    - [1.27.6_1545](/docs/containers?topic=containers-changelog_127)
    - [1.26.9_1558](/docs/containers?topic=containers-changelog_126)
    - [1.25.14_1565](/docs/containers?topic=containers-changelog_125)
    - [1.24.17_1589](/docs/containers?topic=containers-changelog_124)





Ingress ALB version `1.8.4_5586_ikss`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 18 October 2023
{: #containers-oct1823}
{: release-note}



Istio add-on version `1.18.5` and `1.17.8`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).
  
ALB OAuth Proxy add-on version `2.0.0_1889`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).






### 17 October 2023
{: #containers-oct1723}
{: release-note}

Ingress ALB versions `1.8.1_5543_iks`, `1.6.4_5544_iks`, and `1.5.1_5542_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 11 October 2023
{: #containers-oct1123}
{: release-note}

Ingress ALB versions `1.5.1_5436_iks`, `1.6.4_5435_iks`, and `1.8.1_5434_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.19`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).




### 10 October 2023
{: #containers-oct1023}
{: release-note}

CLI version `1.0.573` is available.
:   For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).



Istio add-on version `1.19.3`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 9 October 2023
{: #containers-oct923}
{: release-note} 



Worker node fix packs are available.
:   [1.28.2_1529](/docs/containers?topic=containers-changelog_128)
:   [1.27.5_1542](/docs/containers?topic=containers-changelog_127)
:   [1.26.8_1556](/docs/containers?topic=containers-changelog_126)
:   [1.25.13_1563](/docs/containers?topic=containers-changelog_125)
:   [1.24.16_1583](/docs/containers?topic=containers-changelog_124)







### 5 October 2023
{: #containers-oct523}
{: release-note} 

Ingress ALB versions `1.8.1_5384_iks`, `1.6.4_5406_iks`, and `1.5.1_5407_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 4 October 2023
{: #containers-oct423}
{: release-note}


Cluster autoscaler add-on version `1.0.9_134`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).


### 3 October 2023
{: #containers-oct323}
{: release-note}



Istio add-on versions `1.17.6` and `1.18.3`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



## September 2023
{: #containers-sep23}


### 27 September 2023
{: #containers-sep2723}
{: release-note}


  
Worker node fix packs are available.
:   [1.28.2_1528](/docs/containers?topic=containers-changelog_128)
:   [1.27.5_1541](/docs/containers?topic=containers-changelog_127)
:   [1.26.8_1555](/docs/containers?topic=containers-changelog_126)
:   [1.25.12_1562](/docs/containers?topic=containers-changelog_125)
:   [1.24.17_1587](/docs/containers?topic=containers-changelog_124)





### 26 September 2023
{: #containers-sep2623}
{: release-note}



ALB OAuth Proxy add-on version `2.0.0_1843`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).
  



### 25 September 2023
{: #containers-sep2523}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `5.2`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 22 September 2023
{: #containers-sep2223}
{: release-note}


Kubernetes version 1.28 certification
:   Version [1.28](/docs/containers?topic=containers-cs_versions_128) release is now certified.



### 20 September 2023
{: #containers-sep2023}
{: release-note} 



New! {{site.data.keyword.containerlong_notm}} version 1.28.
:   You can create or [update clusters to Kubernetes version 1.28](/docs/containers?topic=containers-cs_versions_128). With Kubernetes 1.28, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

Master fix pack `1.28.2_1527` and worker node fix pack `1.28.1_1523`.
:   For more information, see the [1.28 change log](/docs/containers?topic=containers-changelog_128).

Networking changes for VPC clusters 1.28 and later
:   In version 1.27 and earlier, VPC clusters pull container images from the {{site.data.keyword.registrylong_notm}} through a private cloud service endpoint for the Container Registry. For version 1.28 and later, this network path is updated so that images are pulled through a VPE gateway instead of a private service endpoint. For more information, see the [1.28 change log](/docs/containers?topic=containers-changelog_128).

Trusted profile updates for Kubernetes clusters version 1.28 and later.
:   You can now give trusted profiles service level access to your clusters, then use a federated ID, like App ID, to access the cluster at the level assigned in the trusted profile since trusted profile identities are now synced into the cluster RBAC. For more information, see [Creating trusted profiles](/docs/account?topic=account-create-trusted-profile&interface=ui) and [Logging in with a federated ID](/docs/account?topic=account-federated_id&interface=ui).

New! Updated GPU drivers with version 1.28 clusters.
:   With the release of IBM Cloud Kubernetes Version 1.28, GPU drivers moved to the 500 series version for all GPU worker node flavors. To use the 500 series GPU drivers, ensure that a GPU worker node flavor is being used and the cluster master version is upgraded to at least version 1.28. Versions earlier than 1.28 will still continue to use the 400 series GPU drivers. For more information, see [Deploying an app on a GPU machine](/docs/containers?topic=containers-deploy_app&interface=ui#gpu_app).

  
Master fix packs are available.
:   [1.27.5_1540](/docs/containers?topic=containers-changelog_127)
:   [1.26.8_1554](/docs/containers?topic=containers-changelog_126)
:   [1.25.13_1561](/docs/containers?topic=containers-changelog_125)
:   [1.24.17_1586](/docs/containers?topic=containers-changelog_124)







### 18 September 2023
{: #containers-sep1823}
{: release-note}

CLI version `1.0.566` is available.
:   For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 15 September 2023
{: #containers-sep1523}
{: release-note} 

Cluster autoscaler add-on versions `1.0.9_103`,`1.0.8_104`, and `1.0.7_102`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).


### 14 September 2023
{: #containers-sep1423}
{: release-note} 


{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.1.7_49`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.19_358` and `5.1.13_345`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


### 12 September 2023
{: #containers-sep1223}
{: release-note} 



Worker node fix packs are available.
:   [1.27.4_1538](/docs/containers?topic=containers-changelog_127)
:   [1.26.7_1552](/docs/containers?topic=containers-changelog_126)
:   [1.25.12_1558](/docs/containers?topic=containers-changelog_125)
:   [1.24.16_1583](/docs/containers?topic=containers-changelog_124)





### 7 September 2023
{: #containers-sep723}
{: release-note} 

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.18`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

## August 2023
{: #containers-aug23}



### 31 August 2023
{: #containers-aug3123}
{: release-note} 

Ingress ALB versions `1.8.1_5317_iks`, `1.6.4_5270_iks`, and `1.5.1_5318_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 30 August 2023
{: #containers-aug2023}
{: release-note}



Master fix packs are available.
:   [1.27.4_1536](/docs/containers?topic=containers-changelog_127)
:   [1.26.7_1550](/docs/containers?topic=containers-changelog_126)
:   [1.25.12_1556](/docs/containers?topic=containers-changelog_125)
:   [1.24.16_1581](/docs/containers?topic=containers-changelog_124)








### 29 August 2023
{: #containers-aug2923}
{: release-note}

New! Madrid multizone region
:   You can now [create VPC clusters](/docs/containers?topic=containers-cluster-create-vpc-gen2) in [Madrid](/docs/containers?topic=containers-regions-and-zones).

Worker node fix packs are available.
:   [`1.27.4_1537`](/docs/containers?topic=containers-changelog_127)
:   [`1.26.7_1551`](/docs/containers?topic=containers-changelog_126)
:   [`1.25.12_1557`](/docs/containers?topic=containers-changelog_125)
:   [`1.24.16_1582`](/docs/containers?topic=containers-changelog_124)

### 15 August 2023
{: #containers-aug1523}
{: release-note}



Worker node fix packs are available.
:   [`1.24.16_1580`](/docs/containers?topic=containers-changelog_124)
:   [`1.25.12_1555`](/docs/containers?topic=containers-changelog_125)
:   [`1.26.7_1547`](/docs/containers?topic=containers-changelog_126)
:   [`1.27.4_1535`](/docs/containers?topic=containers-changelog_127)



  


### 9 August 2023
{: #containers-aug0923}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1715`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).




  
### 8 August 2023
{: #containers-aug0823}
{: release-note}

Istio add-on versions `1.16.7`, `1.17.5`, and `1.18.2`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).



### 7 August 2023
{: #containers-aug0723}
{: release-note}

Cluster autoscaler add-on versions `1.0.9_81`,`1.0.8_82`, and `1.0.7_83`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

### 3 August 2023
{: #containers-aug0323}
{: release-note}


CIS benchmarks for {{site.data.keyword.redhat_openshift_notm}} version 4.13.
:   CIS benchmark results are available for {{site.data.keyword.redhat_openshift_notm}} version [4.13](/docs/openshift?topic=openshift-cis-benchmark-413).


### 1 August 2023
{: #containers-aug0123}
{: release-note}



Worker node fix packs are available.
:   [`1.24.16_1579`](/docs/containers?topic=containers-changelog_124)
:   [`1.25.12_1554`](/docs/containers?topic=containers-changelog_125)
:   [`1.26.7_1546`](/docs/containers?topic=containers-changelog_126)
:   [`1.27.4_1534`](/docs/containers?topic=containers-changelog_127)





{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.17_266` and `5.1.12_285`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



## July 2023
{: #containers-july23}



### 31 July 2023
{: #containers-july3123}
{: release-note}


Ubuntu 18 is no longer supported.
:   For more information, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate).




### 28 July 2023
{: #containers-july2823}
{: release-note}





{{site.data.keyword.cos_full_notm}} plug-in version `2.2.17`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 27 July 2023
{: #containers-july2723}
{: release-note}



Master fix packs are available
:   [1.24.16_1578](/docs/containers?topic=containers-changelog_124)
:   [1.25.12_1553](/docs/containers?topic=containers-changelog_125)
:   [1.26.7_1545](/docs/containers?topic=containers-changelog_126)
:   [1.27.4_1533](/docs/containers?topic=containers-changelog_127)





{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.1.6`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).




Istio add-on version `1.16.6`, `1.17.4`, and `1.18.1`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).





### 26 July 2023
{: #containers-july2623}
{: release-note} 

Ingress ALB versions `1.6.4_5219_iks`, `1.5.1_5217_iks`, and `1.4.0_5218_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 25 July 2023
{: #containers-july2523}
{: release-note}


End of support for the free cluster tier 
:   As announced on [23 June 2023](#containers-jun2323), the free cluster option is no longer available. Existing free tier clusters will be allowed to finish their 30-day trial window. If you want to continue testing {{site.data.keyword.containerlong_notm}}, try creating a [Classic cluster](/docs/containers?topic=containers-cluster-create-classic). Then [copy your deployments to the new cluster](/docs/containers?topic=containers-update_app#copy_apps_cluster).




### 24 July 2023
{: #containers-july2423}
{: release-note}


Cluster autoscaler add-on version `1.0.9_70`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).
  
Static route add-on version `1.0.0_1122`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-static-route).



### 21 July 2023
{: #containers-july2123}
{: release-note}

Cluster autoscaler add-on update command.
:   You can now use the `ibmcloud ks cluster addon update` command to update your add-on. For more information, see [Updating the cluster autoscaler add-on](/docs/containers?topic=containers-cluster-scaling-install-addon#cluster-scaling-install-addon-update-addon).

### 19 July 2023
{: #containers-july1923}
{: release-note}

CLI version `1.0.540` is available.
:   For more information, see the [CLI change log](/docs/containers?topic=containers-cs_cli_changelog).


### 17 July 2023
{: #containers-july1723}
{: release-note}


Worker node fix packs `1.24.15_1576`, `1.25.11_1552`, `1.26.6_1544`, and `1.27.3_1532`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125),  [1.26](/docs/containers?topic=containers-changelog_126), and [1.27](/docs/containers?topic=containers-changelog_127).







### 12 July 2023
{: #containers-july1223}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1669`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



### 11 July 2023
{: #containers-july1123}
{: release-note}

New! OpenShift Data Foundation add-on version `4.13.0`.
:   For more information, see the [change log](/docs/openshift?topic=openshift-cl-add-ons-openshift-data-foundation).



### 6 July 2023
{: #containers-july623}
{: release-note} 

Cluster autoscaler add-on version `1.0.8_56` and `1.0.7_57`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).



Istio add-on version `1.18.0`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).




Pod security admission updates
:   Review the [default pod security configuration](/docs/containers?topic=containers-pod-security-admission#psa-plugin-config-default) and the steps to [customize pod security admission in your cluster](/docs/containers?topic=containers-pod-security-admission#psa-plugin-config-custom).





### 5 July 2023
{: #containers-july523}
{: release-note} 

Ingress ALB versions `1.6.4_5161_iks`, `1.5.1_5160_iks`, and `1.4.0_5159_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 3 July 2023
{: #containers-july323}
{: release-note} 

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.16`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.1`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver). 


Worker node fix packs `1.24.15_1574`, `1.25.11_1550`, `1.26.6_1542`, and `1.27.3_1530`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125),  [1.26](/docs/containers?topic=containers-changelog_126), and [1.27](/docs/containers?topic=containers-changelog_127).


## June 2023
{: #containers-jun23}



### 27 June 2023
{: #containers-jun2723}
{: release-note} 




Master fix packs `1.24.15_1573`, `1.25.11_1549`, `1.26.6_1541`, and `1.27.3_1529`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), [1.26](/docs/containers?topic=containers-changelog_126), and [1.27](/docs/containers?topic=containers-changelog_127).


### 26 June 2023
{: #containers-jun2623}
{: release-note} 

CLI version `1.0.528`.
:   For more information, see the [change log](/docs/containers?topic=containers-cs_cli_changelog).



### 23 June 2023
{: #containers-jun2323}
{: release-note} 

Free cluster tier deprecation
:   The free cluster option is deprecated and will be unsupported on 25 July 2023. Existing free tier clusters will be allowed to finish their 30-day trial window. If you want to continue testing {{site.data.keyword.containerlong_notm}}, try creating a [Classic cluster](/docs/containers?topic=containers-cluster-create-classic). Then [copy your deployments to the new cluster](/docs/containers?topic=containers-update_app#copy_apps_cluster).




### 22 June 2023
{: #containers-jun2223}
{: release-note} 



Cluster autoscaler add-on version `1.0.9_44`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).




Istio add-on version `1.17.3`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).





### 21 June 2023
{: #containers-jun2123}
{: release-note} 

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.16_127` and `5.1.11_126`.
:   This patch introduces two new variables to the `addon-vpc-block-csi-driver-configmap`. To get the latest snapshot configmap values users must add the new values to the existing configmap and apply the changes. For more information, see [Customizing snapshots](/docs/containers?topic=containers-vpc-volume-snapshot) and [the add-on change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 20 June 2023
{: #containers-jun2023}
{: release-note} 



Worker node fix pack updates
:   Worker node fix pack updates are available for versions [1.27](/docs/containers?topic=containers-changelog_127), [1.26](/docs/containers?topic=containers-changelog_126), [1.25](/docs/containers?topic=containers-changelog_125), and [1.24](/docs/containers?topic=containers-changelog_124).


### 19 June 2023
{: #containers-jun1923}
{: release-note} 

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.15`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).







### 8 June 2023
{: #containers-jun823}
{: release-note}

Istio add-on version `1.16.5`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).





### 6 June 2023
{: #containers-jun623}
{: release-note}

Ingress ALB versions `1.6.4_5067_iks`, `1.5.1_5074_iks`, and `1.4.0_5068_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 5 June 2023
{: #containers-jun523}
{: release-note}


Worker node fix packs `1.24.14_1571`, `1.25.10_1547`, `1.26.5_1539`, and `1.27.2_1527`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125),  [1.26](/docs/containers?topic=containers-changelog_126), and [1.27](/docs/containers?topic=containers-changelog_127).

## May 2023
{: #containers-may23}

### 31 May 2023
{: #containers-may3123}
{: release-note}



Master fix packs `1.24.14_1568`, `1.25.10_1545`, and `1.26.5_1537`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).

### 25 May 2023
{: #containers-may2523}
{: release-note}

CLI version `1.0.523`.
:   For more information, see the [change log](/docs/containers?topic=containers-cs_cli_changelog).


  
Kubernetes version 1.27 certification
:   Version [1.27](/docs/containers?topic=containers-cs_versions_127) release is now certified.



### 24 May 2023
{: #containers-may2423}
{: release-note}



New! {{site.data.keyword.containerlong_notm}} version 1.27.
:   You can create or [update clusters to Kubernetes version 1.27](/docs/containers?topic=containers-cs_versions_127). With Kubernetes 1.27, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

Master fix pack `1.27.2_1524` and worker node fix pack `1.27.2_1526`.
:   For more information, see the [1.27 change log](/docs/containers?topic=containers-changelog_127).


Worker node fix packs `1.24.14_1570`, `1.25.10_1546`, and `1.26.5_1538`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).



### 23 May 2023
{: #containers-may2323}
{: release-note}

Ingress ALB versions `1.6.4_4170_iks`, `1.5.1_4168_iks`, and `1.4.0_4169_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 16 May 2023
{: #containers-may1623}
{: release-note}

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.0`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver).

### 15 May 2023
{: #containers-may1523}
{: release-note}

Cluster autoscaler add-on versions `1.0.6_1077`, `1.0.7_1076`, `1.0.8_1078`, and `1.1.0_1066`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.filestorage_vpc_full_notm}} add-on version `1.1-beta`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-file-csi-driver). 

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.12_1963` and `5.1.8_1970`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


### 10 May 2023
{: #containers-may1023}
{: release-note}

Create Classic and VPC clusters with Terraform
:   For more information, see [Creating a single-zone classic cluster with Terraform](/docs/containers?topic=containers-cluster-create-classic&interface=terraform#cluster_classic_tf) and [Creating a VPC cluster with Terraform](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=terraform#cluster_vpcg2_tf).


### 9 May 2023
{: #containers-may0923}
{: release-note}


Worker node fix packs `1.24.13_1567`, `1.25.9_1544`, and `1.26.4_1536`.
:   For more information, see the change logs: [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).





### 4 May 2023
{: #containers-may0423}
{: release-note}

Ingress ALB version `1.6.4_4117_iks`, `1.5.1_4113_iks`, and `1.4.0_4114_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 2 May 2023
{: #containers-may0223}
{: release-note}




{{site.data.keyword.cos_full_notm}} plug-in version `2.2.14`
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

## April 2023
{: #containers-apr23}


### 27 April 2023
{: #containers-apr2723}
{: release-note}


  
Ingress ALB version `1.6.4_4073_iks`, `1.5.1_4064_iks`, and `1.4.0_4062_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).
  
Master fix packs `1.23.17_1576`, `1.24.13_1566`, `1.25.9_1543`, and `1.26.4_1535`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).


### 26 April 2023
{: #containers-apr2623}
{: release-note}

Cluster autoscaler add-on version `1.1.0_1060`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

### 24 April 2023
{: #containers-apr2423}
{: release-note}  



Worker node fix packs `1.23.17_1576`, `1.24.13_1566`, `1.25.9_1543`, and `1.26.4_1535`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).



### 20 April 2023
{: #containers-apr2023}
{: release-note}  
  
Istio add-on version `1.16.4` and `1.17.2`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog).





### 13 April 2023
{: #containers-apr1323}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1528`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).





### 12 April 2023
{: #containers-apr1223}
{: release-note}

Ingress ALB version `1.6.4_3976_iks`, `1.5.1_3977_iks`, and `1.4.0_3978_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 11 April 2023
{: #containers-apr1123}
{: release-note}

CLI version `1.0.510`.
:   For more information, see the [change log](/docs/containers?topic=containers-cs_cli_changelog).

Worker node fix packs `1.23.17_1574`, `1.24.12_1564`, `1.25.8_1541`, and `1.26.3_1533`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).

### 5 April 2023
{: #containers-apr0523}
{: release-note}

Cluster autoscaler add-on versions `1.0.6_1010`, `1.0.7_1021`, and `1.0.8_1016`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.10_1869` and `5.1.6_1872`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 4 April 2023
{: #containers-apr0423}
{: release-note}

Ingress ALB version `1.4.0_3953_iks`, `1.5.1_3951_iks`, and `1.6.4_3947_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 3 April 2023
{: #containers-apr0323}
{: release-note}

Pod Security admission 
:   You might need to check your Pod Security set up when you upgrade your cluster from version 1.24 to 1.25. For more information, see [Migrating from PSPs to Pod Security admission](/docs/containers?topic=containers-pod-security-admission-migration&interface=ui).

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.13`
:   **Important** Because there are changes to the storage classes installed with the plug-in, you must uninstall and reinstall the plug-in when you update to version `2.2.13` to get the latest storage class configurations. For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

## March 2023
{: #containers-mar23}

### 29 March 2023
{: #containers-mar2923}
{: release-note}



Worker node fix packs `1.23.17_1572`, `1.24.12_1562`, `1.25.8_1539`, and `1.26.3_1531`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).


{{site.data.keyword.block_storage_is_short}} add-on versions `5.0.9_1862` and `5.1.5_1857`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

Cluster autoscaler add-on versions `1.0.7_988` and `1.0.8_987`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

### 28 March 2023
{: #containers-mar2823}
{: release-note}


  
Master fix packs `1.23.17_1569`, `1.24.12_1559`, `1.25.8_1536`, and `1.26.3_1528`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).

Worker node fix packs `1.23.17_1570`, `1.24.12_1560`, `1.25.8_1537`, and `1.26.3_1529`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).





### 24 March 2023
{: #containers-mar2423}
{: release-note}

Ingress ALB version `1.4.0_3896_iks`, `1.5.1_3897_iks`, and `1.6.4_3898_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 21 March 2023
{: #containers-mar2123}
{: release-note}

New troubleshooting steps for workers in `Critical` or `NotReady` state. 
:   For more information, see [Troubleshooting worker nodes in `Critical` or `NotReady` state](/docs/containers?topic=containers-ts-critical-notready).

### 20 March 2023
{: #containers-mar2023}
{: release-note}


{{site.data.keyword.cos_full_notm}} plug-in version `2.2.12`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 16 March 2023
{: #containers-mar1623}
{: release-note}


Cluster autoscaler add-on version `1.1.0_978`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).




### 14 March 2023
{: #containers-mar1423}
{: release-note}



Ingress ALB version `1.4.0_3862_iks`, `1.5.1_3863_iks`, and `1.6.4_3864_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


Worker node fix packs `1.23.16_1568`, `1.24.10_1558`, `1.25.6_1535`, and `1.26.1_1525`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).





### 9 March 2023
{: #containers-mar0923}
{: release-note}


Cluster autoscaler add-on version `1.0.8_968`
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).



Istio add-on version `1.15.6` and `1.16.3`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1163).




### 7 March 2023
{: #containers-mar0723}
{: release-note}



Worker node fix packs `1.23.16_1567`, `1.24.10_1557`, `1.25.6_1534`, and `1.26.1_1524`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).



Cluster autoscaler add-on version `1.0.6_955` and `1.0.7_956`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).



Istio add-on version `1.17.1`.
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1171).



{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.17_1829`, `5.0.7_1836`, and `5.1.2_1828`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


### 3 March 2023
{: #containers-mar0323}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.10`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 1 March 2023
{: #containers-mar0123}
{: release-note}

CLI version `1.0.498`.
:   For more information, see the [change log](/docs/containers?topic=containers-cs_cli_changelog).

ALB OAuth Proxy add-on version `2.0.0_1487`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).


## February 2023
{: #containers-feb23}



### 27 February 2023
{: #containers-feb2723}
{: release-note}



Worker node fix packs `1.23.16_1563`, `1.24.10_1554`, `1.25.6_1532`, and `1.26.1_1522`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).





### 23 February 2023
{: #containers-feb2323}
{: release-note}

Ingress ALB version `1.3.1_3807_iks`, `1.4.0_3808_iks`, and `1.5.1_3809_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).





### 22 February 2023
{: #containers-feb2223}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1469`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



### 21 February 2023
{: #containers-feb2123}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.10`.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.17_1829`, `5.0.7_1836`, and `5.1.2_1828`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 20 February 2023
{: #containers-feb2023}
{: release-note}

Ingress ALB version `1.3.1_3777_iks`, `1.4.0_3783_iks`, and `1.5.1_3779_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).


  
### 17 February 2023
{: #containers-feb1723}
{: release-note}

Cluster autoscaler add-on version `1.0.7_944`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

### 14 February 2023
{: #containers-feb1423}
{: release-note}

Istio add-on `1.15.5` and `1.16.2`
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1162).

### 13 February 2023
{: #containers-feb1323}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.9` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



Worker node fix packs `1.23.16_1562`, `1.24.10_1553`, `1.25.6_1531`, and `1.26.1_1521`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), [1.25](/docs/containers?topic=containers-changelog_125), and [1.26](/docs/containers?topic=containers-changelog_126).



### 10 February 2023
{: #containers-feb1023}
{: release-note}


New troubleshooting doc for how to recover after deleting a portable subnet in Classic clusters.
:   For more information, see [I deleted a portable subnet and now my Classic cluster my Load Balancers are failing. How do I recover?](/docs/containers?topic=containers-ts-network-subnet-recover).



Ingress ALB version `1.3.1_3754_iks` and `1.4.0_3755_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).




### 9 February 2023
{: #containers-feb0923}
{: release-note}


{{site.data.keyword.block_storage_is_short}} add-on version `5.1`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


### 8 February 2023
{: #containers-feb0823}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1420`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



### 2 February 2023
{: #containers-feb0223}
{: release-note}

Istio add-on `1.14` 
:   Version `1.14` of the managed Istio add-on is no longer supported. For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#v114).

### 1 February 2023
{: #containers-feb0123}
{: release-note}



New! Kubernetes 1.26
:   You can create or [update clusters to Kubernetes version 1.26](/docs/containers?topic=containers-cs_versions_126). With Kubernetes 1.26, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product.

Master fix pack
:   Kubernetes [1.26.1_1519](/docs/containers?topic=containers-changelog_126).

Worker node fix pack
:   Kubernetes [1.26.1_1520](/docs/containers?topic=containers-changelog_126)



Persistent VPC load balancers
:   You can now create a [persistent VPC load balancer](/docs/containers?topic=containers-vpclb_manage#vpc_lb_persist) that remains available even after your cluster is deleted. 

Customized VPC load balancer health checks
:   For more control over your VPC load balancer health checks, you can use [optional annotations](/docs/containers?topic=containers-setup_vpc_alb#vpc_alb_annotations_opt) to customize your health checks with advanced configurations for test intervals, timeouts, and retries.

## January 2023
{: #containers-jan23}

### 30 January 2023
{: #containers-jan3023}
{: release-note}



Master fix packs `1.23.16_1560`, `1.24.10_1551`, and `1.25.6_1529`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).





Worker node fix packs `1.23.16_1561`, `1.24.10_1552`, and `1.25.6_1530`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).



New! Optional secondary disks for worker nodes in VPC clusters.
:   When you create a VPC cluster, you can specify an optional secondary disk for your worker nodes. Secondary disks are used for the container runtime and are useful in scenarios where more container storage is needed, such as running pods with large images. For more information, see [Creating VPC clusters](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui).


CLI version `1.0.489`.
:   For more information, see the [change log](/docs/containers?topic=containers-cs_cli_changelog).



Ingress ALB version `1.5.1_3705_iks`, `1.4.0_3703_iks`, and `1.3.1_3704_iks`.
:   For more information, see the [change log](/docs/containers?topic=containers-cl-ingress-alb).



### 24 January 2023
{: #containers-jan2423}
{: release-note}

CLI version 1.0.487 change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.487.

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.16_1779` and `5.0.5_1784`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

Cluster autoscaler add-on version `1.0.7_940`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

Ingress ALB version `1.3.1_3685_iks`, `1.4.0_3684_iks`, and `1.5.1_3683_iks`
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).


### 23 January 2023
{: #containers-jan2323}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.8` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 16 January 2023
{: #containers-jan1723}
{: release-note}



Worker node fix packs `1.23.15_1558`, `1.24.9_1550`, and `1.25.5_1528`.
:   For more information, see the change logs: [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).



### 10 January 2023
{: #containers-jan1023}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.15_1764` and `5.0.4_1773`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

Istio add-on versions `1.14.6`, `1.15.4`, and `1.16.1`
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1161).

### 9 January 2023
{: #containers-jan0923}
{: release-note}

Cluster autoscaler add-on versions `1.0.5_898`, `1.0.6_899`, `1.0.7_900`, and `1.1.0_897`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 5 January 2023
{: #containers-jan0523}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.7` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).




### 3 January 2023
{: #containers-jan0323}
{: release-note}

Ingress ALB version `1.3.1_3538_iks`, and `1.4.0_3537_iks`
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).



### 2 January 2023
{: #containers-jan0223}
{: release-note}



Worker node fix packs `1.22.17_1584`, `1.23.15_1557`, `1.24.9_1549`, and `1.25.5_1527`
:   For more information, see the change logs: [1.22](/docs/containers?topic=containers-changelog_122), [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).



## December 2022
{: #containers-dec22}

### 19 December 2022
{: #containers-dec1922}
{: release-note}



Worker node fix packs `1.22.17_1583`, `1.23.15_1556`, `1.24.9_1548`, and `1.25.5_1526`
:   For more information, see the change logs: [1.22](/docs/containers?topic=containers-changelog_122), [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).



### 15 December 2022
{: #containers-dec1522}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.6` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



Ingress ALB version `1.2.1_3299_iks`, `1.3.1_3298_iks`, and `1.4.0_3297_iks`
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).

ALB OAuth Proxy add-on version 2.0.0_1354
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).



### 14 December 2022
{: #containers-dec1422}
{: release-note}



Master fix pack `1.22.17_1582`, `1.23.15_1555`, `1.24.9_1547`, and `1.25.5_1525`
:   For more information, see the change logs: [1.22](/docs/containers?topic=containers-changelog_122), [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).

 




Ubuntu 20 is now available for {{site.data.keyword.containerlong_notm}} clusters
:   You can now create {{site.data.keyword.containerlong_notm}} clusters using Ubuntu 20 worker nodes. To review the migration guide, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate). To review operating system support by cluster version, see [{{site.data.keyword.containerlong_notm}} version information](/docs/containers?topic=containers-cs_versions).



CLI version 1.0.480 change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.480.
  
### 12 December 2022
{: #containers-dec1222}
{: release-note}





Ingress ALB version `1.4.0_3212_iks` change log updates
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).



### 9 December 2022
{: #containers-dec0922}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.5` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



### 8 December 2022
{: #containers-dec0822}
{: release-note}

Ingress ALB version `1.3.1_3192_iks` change log updates
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).




### 5 December 2022
{: #containers-dec0522}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.4` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

Ingress ALB version `1.2.1_3186_iks` change log updates
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb).

 Worker node fix packs 1.22.16_1580, 1.23.14_1554, 1.24.8_1546, and 1.25.4_1524
:   For more information, see the change logs: [1.22.16_1580](/docs/containers?topic=containers-changelog_122), [1.23.14_1554](/docs/containers?topic=containers-changelog_123), [1.24.8_1546](/docs/containers?topic=containers-changelog_124), and [1.25.4_1524](/docs/containers?topic=containers-changelog_125).

### 1 December 2022
{: #containers-dec0122}
{: release-note}

CLI version 1.0.471 change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.471.


## November 2022
{: #containers-nov22}

### 30 November 2022
{: #containers-nov3022}
{: release-note}

Istio add-on version `1.16.0`
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1160).


Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for version `1.3.1_3108_iks`.





### 21 November 2022
{: #containers-nov2122}
{: release-note}



Worker node fix pack 1.22.16_1579, 1.23.14_1553, 1.24.8_1545, and 1.25.4_1523
:   For more information, see the change logs: [1.22.16_1579](/docs/containers?topic=containers-changelog_122), [1.23.14_1553](/docs/containers?topic=containers-changelog_123), [1.24.8_1545](/docs/containers?topic=containers-changelog_124), and [1.25.4_1523](/docs/containers?topic=containers-changelog_125).




### 17 November 2022
{: #containers-nov1722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.13_1712` and `5.0.2_1713`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).




### 16 November 2022
{: #containers-nov1622}
{: release-note}



ALB OAuth Proxy add-on version 2.0.0_1315
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).
  
Master fix pack 1.22.16_1578, 1.23.14_1552, 1.24.8_1544, and 1.25.4_1522
:   For more information, see the change logs: [1.22](/docs/containers?topic=containers-changelog_122), [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).

 



### 15 November 2022
{: #containers-nov1522}
{: release-note}

New Ingress status messages
:   You can now use the **`ibmcloud ks ingress status-report get`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_status_report_get) to view your Ingress status. For more information, see [Checking the status of Ingress components](/docs/containers?topic=containers-ingress-status).


{{site.data.keyword.cos_full_notm}} plug-in version `2.2.3` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).


### 11 November 2022
{: #containers-nov1122}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `4.3.8_1705`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 10 November 2022
{: #containers-nov1022}
{: release-note}

Istio add-on version `1.15.3`
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1153).


### 9 November 2022
{: #containers-nov0922}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `4.4.12_1700` and `5.0.1_1695`
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).



### 8 November 2022
{: #containers-nov0822}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.2` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 7 November 2022
{: #containers-nov0722}
{: release-note}


Worker node fix pack 1.22.15_1577, 1.23.13_1551, 1.24.7_1543, and 1.25.3_1521
:   For more information, see the change logs: [1.22.15_1577](/docs/containers?topic=containers-changelog_122), [1.23.13_1551](/docs/containers?topic=containers-changelog_123), [1.24.7_1543](/docs/containers?topic=containers-changelog_124), and [1.25.3_1521](/docs/containers?topic=containers-changelog_125).



### 3 November 2022
{: #containers-nov0322}
{: release-note}

Changes to the Portworx update process beginning with version `2.12`.
:   Beginning with version `2.12` Portworx uses an operator-based deployment model instead of the Helm based model use in version `2.11` and earlier. If you want to update from Portworx `2.11` to version `2.12`, follow the migration steps in the [Portworx documentation](https://docs.portworx.com/portworx-enterprise/operations/operate-kubernetes/migrate-daemonset){: external}.

Cluster autoscaler add-on version `1.0.7_883`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

## October 2022
{: #containers-oct22}



### 31 October 2022
{: #containers-oct3122}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for version `1.3.0_2907_iks`.



### 27 October 2022
{: #containers-oct2722}
{: release-note}



ALB OAuth Proxy add-on version 2.0.0_1297
:   For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).

Master fix pack 1.22.15_1576, 1.23.13_1550, 1.24.7_1542, and 1.25.3_1520
:   For more information, see the change logs: [1.22](/docs/containers?topic=containers-changelog_122), [1.23](/docs/containers?topic=containers-changelog_123), [1.24](/docs/containers?topic=containers-changelog_124), and [1.25](/docs/containers?topic=containers-changelog_125).

 


### 26 October 2022
{: #containers-oct2622}
{: release-note}


Worker node fix pack 1.22.15_1575, 1.23.12_1549, 1.24.6_1541, and 1.25.2_1519
:   For more information, see the change logs: [1.22.15_1575](/docs/containers?topic=containers-changelog_122), [1.23.12_1549](/docs/containers?topic=containers-changelog_123), [1.24.6_1541](/docs/containers?topic=containers-changelog_124), and [1.25.2_1519](/docs/containers?topic=containers-changelog_125).



### 25 October 2022
{: #containers-oct2522}
{: release-note}

Istio add-on
:   Versions [`1.13.9`](/docs/containers?topic=containers-istio-changelog#1139), [`1.14.5`](/docs/containers?topic=containers-istio-changelog#1145), and [`1.15.2`](/docs/containers?topic=containers-istio-changelog#1152) are available.

### 24 October 2022
{: #containers-oct2422}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.3.0_2847_iks`, `1.2.1_2809_iks`, and `1.1.2_2808_iks`.

### 21 October 2022
{: #containers-oct2122}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.459.

### 12 October 2022
{: #containers-oct1222}
{: release-note}

Istio add-on
:   Version [`1.15.1`](/docs/containers?topic=containers-istio-changelog#1151) is available.


### 11 October 2022
{: #containers-oct1122}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `5.0`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).




### 10 October 2022
{: #containers-oct1022}
{: release-note}


Worker node fix pack
:   Kubernetes [1.22.15_1574](/docs/containers?topic=containers-changelog_122), [1.23.12_1548](/docs/containers?topic=containers-changelog_123) and [1.24.6_1540](/docs/containers?topic=containers-changelog_124).


Cluster autoscaler add-on version `1.0.6_828`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).



### 7 October 2022
{: #containers-oct0722}
{: release-note}


Kubernetes version 1.25 certification
:   Version [1.25](/docs/containers?topic=containers-cs_versions_125) release is now certified.

### 6 October 2022
{: #containers-oct0622}
{: release-note}

New! Kubernetes 1.25
:   You can create or [update clusters to Kubernetes version 1.25](/docs/containers?topic=containers-cs_versions_125). With Kubernetes 1.25, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product. 

Master fix pack
:   Kubernetes [1.25.2_1517](/docs/containers?topic=containers-changelog_125).

Worker node fix pack
:   Kubernetes [1.25.2_1516](/docs/containers?topic=containers-changelog_125)





### 4 October 2022
{: #containers-oct0422}
{: release-note}

Istio add-on
:   Version [`1.14.4`](/docs/containers?topic=containers-istio-changelog#1144) and version [`1.13.8`](/docs/containers?topic=containers-istio-changelog#1138) are available.



### 3 October 2022
{: #containers-oct0322}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.454.


Ingress ConfigMap change log updates
:   Updated the [Ingress ConfigMap change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.1_2646_iks` and `1.1.2_2645_iks`.

ALB OAuth Proxy add-on
:   Version 2.0.0_1265 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy) is released. 



## September 2022
{: #containers-sep22}


### 30 September 2022
{: #containers-sep3022}
{: release-note}

New! Enabling Flow logs for VPC components
:    Flow logs gather information about the traffic entering or leaving your VPC cluster worker nodes.  For more information, see [Enabling Flow Logs for VPC cluster components](/docs/containers?topic=containers-vpc-flow-log).


### 26 September 2022
{: #containers-sep2622}
{: release-note}


Worker node fix pack
:   Kubernetes 1.21.14_1578, [1.22.15_1573](/docs/containers?topic=containers-changelog_122), [1.23.12_1547](/docs/containers?topic=containers-changelog_123) and [1.24.6_1539](/docs/containers?topic=containers-changelog_124).




### 23 September 2022
{: #containers-sep2322}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `4.4.11_1614`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).




### 22 September 2022
{: #containers-sep2222}
{: release-note}

Cluster autoscaler add-on versions `1.1.0_798`, `1.0.6_800`, and `1.0.5_779`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.block_storage_is_short}} add-on version `4.3.7_1613`.
:   For more information, see [the change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).


### 21 September 2022
{: #containers-sep2122}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.452.




Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.1_2558_iks` and `1.1.2_2586_iks`.




### 20 September 2022
{: #containers-sep2022}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.1` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



### 15 September 2022
{: #containers-sep1522}
{: release-note}

Istio add-on
:   Version [`1.15.0`](/docs/containers?topic=containers-istio-changelog#1150) is available.



### 13 September 2022
{: #containers-sep1322}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.4.10_1578 is available.
:   For more information, see [version 4.4.10_1578](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).

New! vGPU worker node flavors are now available for VPC Gen 2.
:   For more information about the available worker node flavors, see [VPC Gen 2 flavors](/docs/containers?topic=containers-vpc-flavors). Worker node flavors with vGPU support are the `gx2` flavor class, for example: `gx2.16x128.2v100`. {{site.data.keyword.vpc_short}} worker nodes with GPUs are available for allowlisted accounts only. To request that your account be allowlisted, see [Requesting access to allowlisted features](/docs/containers?topic=containers-allowlist-request). Be sure to include the data centers, the VPC infrastructure profile, and the number of workers that you want use. For example `12 worker nodes in us-east-1 of VPC profile gx2-16x128xv100`.


### 12 September 2022
{: #containers-sep1222}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.3.6_1579 is available.
:   For more information, see [version 4.3.6_1579](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver)

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.0` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.446.



ALB OAuth Proxy add-on
:   Version 2.0.0_1214 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy) is released. 

### 8 September 2022
{: #containers-sep0822}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.444.

### 7 September 2022
{: #containers-sep722}
{: release-note}

Master fix pack update
:   Kubernetes [1.24.4_1536](/docs/containers?topic=containers-changelog_124), [1.23.10_1544](/docs/containers?topic=containers-changelog_123), [1.22.13_1570](/docs/containers?topic=containers-changelog_122), and 1.21.14_1579.


## August 2022
{: #containers-aug22}

### 31 August 2022
{: #containers-aug3122}
{: release-note}

Cluster autoscaler add-on
:   Versions `1.0.5_775`, `1.0.6_774`, and `1.1.0_776` are available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 29 August 2022
{: #containers-aug2922}
{: release-note}

Worker node fix pack
:   Kubernetes 1.21.14_1578, [1.22.13_1568](/docs/containers?topic=containers-changelog_122), [1.23.10_1543](/docs/containers?topic=containers-changelog_123) and [1.24.4_1535](/docs/containers?topic=containers-changelog_124).


### 26 August 2022
{: #containers-aug2622}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.439.

### 25 August 2022
{: #containers-aug2522}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.4.9_1566 is available.
:   For more information, see [version 4.4.9_1566](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver)



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.1_2506_iks` and `1.1.2_2507_iks`.



### 24 August 2022
{: #containers-aug2422}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.3.5_1563 is available.

:   For more information, see [version 4.3.5_1563](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver)

{{site.data.keyword.cos_full_notm}} plug-in version `2.1.21` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 17 August 2022
{: #containers-aug1722}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.1.20` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

Cluster autoscaler add-on
:   Versions `1.0.5_754` and `1.0.6_763` are available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 16 August 2022
{: #containers-aug1622}
{: release-note}

Worker node fix pack
:   Kubernetes 1.21.14_1576, [1.22.12_1566](/docs/containers?topic=containers-changelog_122), [1.23.9_1541](/docs/containers?topic=containers-changelog_123) and [1.24.3_1533](/docs/containers?topic=containers-changelog_124).


Istio add-on
:   Version [`1.14.3`](/docs/containers?topic=containers-istio-changelog#1143) and [`1.13.7`](/docs/containers?topic=containers-istio-changelog#1137) is available.


### 11 August 2022
{: #containers-aug1122}
{: release-note}

Dynamically provision {{site.data.keyword.cos_full_notm}} buckets with quotas enabled
:   [Follow the tutorial](/docs/containers?topic=containers-storage-cos-tutorial-quota) to set up the {{site.data.keyword.cos_full_notm}} plug-in to automatically set quotas on buckets that are provisioned with PVCs. 



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.1_2487_iks` and `1.1.2_2488_iks`.



### 5 August 2022
{: #containers-aug0522}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.433.

### 3 August 2022
{: #containers-august0322}
{: release-note}

New! {{site.data.keyword.filestorage_vpc_full_notm}} CSI Driver (Beta)
:    You can now enable the {{site.data.keyword.filestorage_vpc_full_notm}} add-on in your clusters. For more information, see [Enabling the {{site.data.keyword.filestorage_vpc_full_notm}} add-on](/docs/containers?topic=containers-storage-file-vpc-install). 




### 2 August 2022
{: #containers-aug0222}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.1_2426_iks` and `1.1.2_2411_iks`.



### 1 August 2022
{: #containers-aug0122}
{: release-note}

Worker node fix pack
:   Kubernetes 1.21.14_1575, [1.22.12_1565](/docs/containers?topic=containers-changelog_122), [1.23.9_1540](/docs/containers?topic=containers-changelog_123) and [1.24.3_1532](/docs/containers?topic=containers-changelog_124).



## July 2022
{: #containers-july22}


### 27 July 2022
{: #containers-july2722}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.1.19` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

### 26 July 2022
{: #containers-july2622}
{: release-note}

Master fix pack update
:   Kubernetes [1.24.3_1531](/docs/containers?topic=containers-changelog_124), [1.23.9_1539](/docs/containers?topic=containers-changelog_123), [1.22.12_1564](/docs/containers?topic=containers-changelog_122), and 1.21.14_1574.



### 22 July 2022
{: #containers-july2222}
{: release-note}




Cluster autoscaler add-on
:   Version `1.1.0_729` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 19 July 2022
{: #containers-july1922}
{: release-note}



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.1.2_2368_iks` and `1.2.1_2415_iks`.



Cluster autoscaler add-on
:   Version `1.0.5_728` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 18 July 2022
{: #containers-july1822}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.3.4_1551](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) and [Version 4.4.8_1550](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) are available.

Worker node fix pack
:   Kubernetes 1.21.14_1572, [1.22.11_1562](/docs/containers?topic=containers-changelog_122), [1.23.8_1537](/docs/containers?topic=containers-changelog_123) and [1.24.2_1529](/docs/containers?topic=containers-changelog_124).


### 15 July 2022
{: #containers-july1522}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.431.

Cluster autoscaler add-on
:   Versions `1.0.6_742` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 14 July 2022
{: #containers-july1422}

Cross-account encryption
:   You can now set up cross-account encryption. Note that this feature is available for allowlisted accounts only. For more information see, [Encrypting the Kubernetes secrets by using a KMS provider](/docs/containers?topic=containers-encryption).

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.18` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on.
:   Version [5.0.1-beta_1411](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.



### 13 July 2022
{: #containers-july1322}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.430.





### 7 July 2022
{: #containers-july0722}
{: release-note} 
 
ALB OAuth Proxy add-on
:   Version 2.0.0_1187 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy) is released. 




### 5 July 2022
{: #containers-july0522}
{: release-note}

Worker node fix pack
:   Kubernetes 1.21.14_1565, [1.22.11_1557](/docs/containers?topic=containers-changelog_122), [1.23.8_1535](/docs/containers?topic=containers-changelog_123) and [1.24.2_1527](/docs/containers?topic=containers-changelog_124).


Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for version `1.1.2_2305_iks`. Version `0.49.3` is no longer supported.

## June 2022
{: #containers-jun22}

### 30 June 2022
{: #containers-jun3022}
{: release-note}

Cluster autoscaler add-on
:   Versions `1.0.5_694` and `1.1.0_682` are available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 28 June 2022
{: #containers-jun2822}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.17` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

### 27 June 2022
{: #containers-jun2722}
{: release-note}

{{site.data.keyword.block_storage_is_short}}
:   You can now [set up the {{site.data.keyword.block_storage_is_short}} add-on with {{site.data.keyword.iamshort}} trusted profiles](/docs/containers?topic=containers-storage-block-vpc-trusted-profiles).

### 24 June 2022
{: #containers-jun2422}
{: release-note}

{{site.data.keyword.block_storage_is_short}}
:   You can now [create snapshots of your PVCs](/docs/containers?topic=containers-vpc-volume-snapshot) by using version `5.0.0-beta` of the {{site.data.keyword.block_storage_is_short}} add-on.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.4.6_1446](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.

### 22 June 2022
{: #containers-jun2222}
{: release-note}

New! Portworx Cloud Drive support
:   You can now dynamically provision storage for Portworx during installation by using Portworx Cloud Drives. For more information, see [About Portworx](/docs/containers?topic=containers-storage_portworx_about).




### 21 June 2022
{: #containers-jun2122}
{: release-note}

Istio add-on
:   Version [`1.13.5`](/docs/containers?topic=containers-istio-changelog#1135) and [`1.12.8`](/docs/containers?topic=containers-istio-changelog#1128) is available.




### 20 June 2022
{: #containers-jun2022}
{: release-note}

Worker node fix pack
:   Kubernetes 1.21.14_1564, [1.22.11_1556](/docs/containers?topic=containers-changelog_122), [1.23.8_1534](/docs/containers?topic=containers-changelog_123) and [1.24.2_1526](/docs/containers?topic=containers-changelog_124).


### 17 June 2022
{: #containers-jun1722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.3.2_1441](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.




### 16 June 2022
{: #containers-jun1622}
{: release-note}

Certified Kubernetes
:   Version [1.24](/docs/containers?topic=containers-cs_versions_124) release is now certified.

Version 1.20 is unsupported as of 19 June 2022
:   Update your cluster to a supported as soon as possible. For more information, see the 1.20 release information and change log. For more information about the supported releases, see the [version information](/docs/containers?topic=containers-cs_versions).

Istio add-on
:   Version [`1.14.1`](/docs/containers?topic=containers-istio-changelog#1141) is available.




### 15 June 2022
{: #containers-jun1522}
{: release-note}

{{site.data.keyword.mon_full_notm}} metrics and label updates
:   Metrics and labels are now stored and displayed in a Prometheus compatible naming convention. Some metrics and labels are deprecated. For more information, see [Discontinued Metrics and Labels](https://docs.sysdig.com/en/docs/release-notes/enhanced-metric-store/#discontinued-metrics-and-labels){: external} and [removed features](https://docs.sysdig.com/en/docs/release-notes/enhanced-metric-store/#removed-featurees){: external}.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 5.0.1-beta_1411](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available for allowlisted accounts.




### 13 June 2022
{: #containers-jun1322}
{: release-note}


{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.4.5_1371](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.



### 10 June 2022
{: #containers-jun1022}
{: release-note}

{{site.data.keyword.loganalysisshort}} and {{site.data.keyword.at_full_notm}} changes
:   {{site.data.keyword.containerlong_notm}} clusters running in Washington, D.C. (`us-east`) now send logs to {{site.data.keyword.loganalysisshort}} and {{site.data.keyword.at_full_notm}} instances in the same region, Washington, D.C. (`us-east`). For more information, see [{{site.data.keyword.at_full_notm}}](/docs/containers?topic=containers-at_events_ref).

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for version `1.2.1_2337_iks`.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 5.0.0-beta_1125](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available for allowlisted accounts.

### 9 June 2022
{: #containers-jun922}
{: release-note}

New! Kubernetes 1.24
:   You can create or [update clusters to Kubernetes version 1.24](/docs/containers?topic=containers-cs_versions_124). With Kubernetes 1.24, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product. 

Deprecated and unsupported Kubernetes versions
:   With the release of Kubernetes 1.24, clusters that run version 1.21 are deprecated, with a tentative unsupported date of 31 Aug 2022. Update your cluster to at least [version 1.22](/docs/containers?topic=containers-cs_versions_122) as soon as possible.

### 7 June 2022
{: #containers-jun722}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.419.

### 6 June 2022
{: #containers-jun622}
{: release-note}

Worker node fix pack
:   Kubernetes 1.20.15_1583, [1.22.10_1554](/docs/containers?topic=containers-changelog_122), [1.23.7_1532](/docs/containers?topic=containers-changelog_123).


### 3 June 2022
{: #containers-jun322}
{: release-note}

Master fix pack update
:   Kubernetes [1.23.7_1531](/docs/containers?topic=containers-changelog_123), [1.22.10_1553](/docs/containers?topic=containers-changelog_122), 1.21.13_1561, and 1.20.15_1582.




### 1 June 2022
{: #containers-jun122}
{: release-note}

Istio add-on
:   Version [`1.13.4`](/docs/containers?topic=containers-istio-changelog#1134) is available.

## May 2022
{: #containers-may22}


### 26 May 2022
{: #containers-may2622}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.415.


### 25 May 2022
{: #containers-may2522}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.16` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.3.0_1163](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.6_1161](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.

### 20 May 2022
{: #containers-may2022}
{: release-note}

Worker node fix pack
:   Kubernetes 1.20.15_1581, 1.21.12_1560, [1.22.9_1552](/docs/containers?topic=containers-changelog_122), [1.23.6_1530](/docs/containers?topic=containers-changelog_123).


### 19 May 2022
{: #containers-may1922}
{: release-note}

Istio add-on
:   Version [`1.12.7`](/docs/containers?topic=containers-istio-changelog#1127) is available.

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.0_2251_iks`, `1.1.2_2252_iks`, and `0.49.3_2253_iks`.


### 16 May 2022
{: #containers-may1622}
{: release-note}

Cluster autoscaler add-on
:   Versions `1.0.5_628` and `1.1.0_615` are available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

ALB OAuth Proxy add-on
:   Version 1.0.0 is no longer supported. For more information, see the [change log](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy).

### 12 May 2022
{: #containers-may1222}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.5_1106](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.

### 9 May 2022
{: #containers-may0922}
{: release-note}

Worker node fix pack
:   Kubernetes 1.20.15_1580, 1.21.12_1559, [1.22.9_1551](/docs/containers?topic=containers-changelog_122), [1.23.6_1529](/docs/containers?topic=containers-changelog_123).



### 6 May 2022
{: #containers-may0622}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.15` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

### 4 May 2022
{: #containers-may0422}
{: release-note}

  
ALB OAuth Proxy add-on
:   Version 2.0.0_1064 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-cl-add-ons-alb-oauth-proxy) is released.
Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.2.0_2147_iks`, `1.1.2_2146_iks`, and `0.49.3_2145_iks`.




### 3 May 2022
{: #containers-may0322}
{: release-note}

Istio add-on
:   Version [`1.13.3`](/docs/containers?topic=containers-istio-changelog#1133) is available. 

## April 2022
{: #containers-apr22}


### 28 April 2022
{: #containers-apr2822}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.404.



Cluster security groups
:   You can now specify up to five security groups to attach to workers when you create a VPC cluster. For more information, see [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group).

### 26 April 2022
{: #containers-apr2622}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for version `1.2.0_2131_iks`. Version `1.1.1` is no longer available.


CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.403.

### 25 April 2022
{: #containers-apr2522}  
{: release-note}

Worker node fix pack
:   Kubernetes [1.23.6_1528](/docs/containers?topic=containers-changelog_123), [1.22.9_1550](/docs/containers?topic=containers-changelog_122), 1.21.12_1558, 1.20.15_1579.




  
### 21 April 2022
{: #containers-apr2122}  
{: release-note}
  
Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.1.2_2121_iks`, `1.1.1_2119_iks`, and `0.49.3_2120_iks`.
  




### 19 April 2022
{: #containers-apr1922}

Istio add-on
:   Version [`1.12.6`](/docs/containers?topic=containers-istio-changelog) is available. 

### 13 April 2022
{: #containers-apr1322}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.14` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

### 12 April 2022
{: #containers-apr1222}



Create and manage dedicated hosts in VPC Gen 2.
:   You can now create clusters on dedicated hosts in VPC Gen 2. Note that support for dedicated hosts is available only for allowlisted accounts. For more information, see [Creating and managing dedicated hosts](/docs/containers?topic=containers-dedicated-hosts).

  
### 11 April 2022
{: #containers-apr1122}



New! {{site.data.keyword.secrets-manager_full}}
:   With the deprecation of {{site.data.keyword.cloudcerts_long}}, you can now manage certificates and secrets with {{site.data.keyword.secrets-manager_full}}. You can integrate your own {{site.data.keyword.secrets-manager_short}} instances with your Kubernetes clusters. {{site.data.keyword.secrets-manager_short}} instances can be used across multiple clusters, and a single cluster can have more than one instance. 



{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.3_983](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver) is available.

Worker node fix pack
:   Kubernetes [1.23.5_1526](/docs/containers?topic=containers-changelog_123), [1.22.8_1548](/docs/containers?topic=containers-changelog_122), 1.21.11_1556, 1.20.15_1577.





### 7 April 2022
{: #containers-apr0722}

{{site.data.keyword.containerlong_notm}} clusters in Mexico City (MEX01) are deprecated and become unsupported later this year. 
:   To prevent any interruption of service, [redeploy your cluster workloads](/docs/containers?topic=containers-update_app#copy_apps_cluster) to a [supported data center](/docs/containers?topic=containers-regions-and-zones#zones-mz) and remove your MEX01 clusters by 31 October 2022. Clusters remaining in these data centers after 31 October 2022 will be removed. You cannot create clusters in this location after 07 May 2022. For more information about data center closures and recommended data centers, see [Data center consolidations](/docs/account?topic=account-dc-closure).


Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cl-ingress-alb) for versions `1.1.2_2084_iks`, `1.1.1_2085_iks`, and `0.49.3_2083_iks`.




CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.394.

### 6 April 2022
{: #containers-apr0622}}

Master fix pack update
:   Kubernetes [1.23.5_1525](/docs/containers?topic=containers-changelog_123), [1.22.8_1547](/docs/containers?topic=containers-changelog_122), 1.21.11_1555, and 1.20.15_1576.
