---

copyright: 
  years: 2014, 2021
lastupdated: "2021-12-20"

keywords: kubernetes, release notes

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Release notes
{: #iks-release}

Use the release notes to learn about the latest changes to the {{site.data.keyword.containerlong}} documentation that are grouped by month.
{: shortdesc}

Looking for {{site.data.keyword.cloud_notm}} status, platform announcements, security bulletins, or maintenance notifications? See [{{site.data.keyword.cloud_notm}} status](https://cloud.ibm.com/status?selected=status).
{: note}

## December 2021
{: #release-dec-2021}






### 17 December 2021
{: #17dec2021}
{: release-note}

Deprecated and unsupported Kubernetes versions
:   Clusters that run version 1.19 are deprecated, with a tentative unsupported date of 31 Jan 2022. Update your clusters to at least [version 1.20](/docs/containers?topic=containers-cs_versions#cs_v120) as soon as possible.



### 14 December 2021
{: #14dec2021}
{: release-note}



Istio add-on

:   [Version `1.11.5`](/docs/containers?topic=containers-istio-changelog#1115) of the Istio managed add-on is released.

### 7 December 2021
{: #7dec2021}
{: release-note}



Istio add-on

:   [Version `1.12`](/docs/containers?topic=containers-istio-changelog#1102) of the Istio managed add-on is released.

Master fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.4_1531`](/docs/containers?topic=containers-changelog#1224_1531), [`1.21.7_1541`](/docs/containers?topic=containers-changelog#1217_1541), [`1.20.13_1563`](/docs/containers?topic=containers-changelog#12013_1563), and [`1.19.16_1570`](/docs/containers?topic=containers-changelog#11916_1570).



### 6 December 2021
{: #6dec2021}
{: release-note}



Worker node fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.4_1532`](/docs/containers?topic=containers-changelog#1224_1532), [`1.21.7_1542`](/docs/containers?topic=containers-changelog#1217_1542), [`1.20.13_1564`](/docs/containers?topic=containers-changelog#12013_1564), and [`1.19.16_1571`](/docs/containers?topic=containers-changelog#11916_1571).



### 2 December 2021
{: #2dec2021}
{: release-note}



{{site.data.keyword.containershort}} default version update.
:   [1.21](/docs/containers?topic=containers-cs_versions#version_types) is now the default version.


## November 2021
{: #release-nov-2021}

Review the release notes for November 2021.
{: shortdesc}


### 29 November 2021
{: #29nov2021}
{: release-note}

Container service CLI 
:   The [CLI changelog](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.347.



### 22 November 2021
{: #22nov2021}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.3_1530`](/docs/containers?topic=containers-changelog#1223_1530), [`1.21.6_1540`](/docs/containers?topic=containers-changelog#1216_1540), [`1.20.12_1562`](/docs/containers?topic=containers-changelog#12012_1562), and [`1.19.16_1569`](/docs/containers?topic=containers-changelog#11916_1569).

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.0.3_793](/docs/containers?topic=containers-vpc_bs_changelog) is released.

Cluster autoscaler add-on.
:   [Version 1.0.4_387](/docs/containers?topic=containers-ca_changelog) is released.


### 19 November 2021
{: #19nov2021}
{: release-note}



ALB OAuth Proxy add-on
:   Versions 1.0.0_756 and 2.0.0_755 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) are released.

Kubernetes Ingress image
:   Versions 1.0.3_1730_iks and 0.49.3_1830_iks of the [Kubernetes Ingress image](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) are released.



### 18 November 2021
{: #18nov2021}
{: release-note}

{{site.data.keyword.cloudaccesstraillong_notm}} and {{site.data.keyword.at_full_notm}}
:   Previously, clusters running in Toronto (`ca-tor`) sent logs to Washington D.C., and clusters running in Osaka (`jp-osa`) or Sydney (`au-syd`) sent logs to Tokyo. Beginning 18 November 2021, all instances of Log Analysis and Activity Tracker that are used for clusters running in Osaka (`jp-osa`), Toronto (`ca-tor`), and Sydney (`au-syd`) send logs to their respective regions. To continue receiving logs for clusters in these regions, you must create instances of {{site.data.keyword.cloudaccesstraillong_notm}} and {{site.data.keyword.at_full_notm}} in the same region as your cluster. If you already have instances in these regions, look for logs in those instances.

{{site.data.keyword.cos_full_notm}}
:   Version 2.1.7 of the [{{site.data.keyword.cos_full_notm}} plug-in](/docs/containers?topic=containers-cos_plugin_changelog) is released.




### 15 November 2021
{: #15nov2021}
{: release-note}

CLI changelog
:   The [CLI changelog](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.344. 

### 12 November 2021
{: #12nov2021}
{: release-note}

Master fix pack updates
:   Changelog documentation is available for Kubernetes version  [`1.22.2_1526`](/docs/containers?topic=containers-changelog#1222_1526), [`1.21.5_1536`](/docs/containers?topic=containers-changelog#1215_1536), [`1.20.11_1558`](/docs/containers?topic=containers-changelog#12011_1558), and [`1.19.15_1565`](/docs/containers?topic=containers-changelog#11915_1565).

### 10 November 2021
{: #10nov2021}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.2_1528`](/docs/containers?topic=containers-changelog#1222_1528), [`1.21.5_1538`](/docs/containers?topic=containers-changelog#1215_1538), [`1.20.11_1560`](/docs/containers?topic=containers-changelog#12011_1560), and [`1.19.15_1567`](/docs/containers?topic=containers-changelog#11915_1567).

### 8 November 2021
{: #8nov2021}
{: release-note}

Update commands to use `docker build`
:   Updates commands that use `cr build` to use `docker build` instead. 


### 4 November 2021
{: #4nov2021}
{: release-note}

IAM trusted profiles for pod authorization
:   Updates for pod authorization with IAM trusted profiles. Authorizing pods with IAM trusted profiles is available for clusters that run Kubernetes version 1.21 or later. Note that for new clusters, authorizing pods with IAM trusted profiles is enabled automatically. You can enable IAM trusted profiles on existing clusters by running [`ibmcloud ks cluster master refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). For more information, see [Authorizing pods in your cluster to IBM Cloud services with IAM trusted profiles](/docs/containers?topic=containers-pod-iam-identity).


### 2 November 2021
{: #2nov2021}
{: release-note}

Istio add-on change log
:   [Version `1.11.4`](/docs/containers?topic=containers-istio-changelog#1114) of the Istio managed add-on is released.



## October 2021
{: #release-oct-2021}

Review the release notes for October 2021.
{: shortdesc}

### 28 October 2021
{: #28oct2021}
{: release-note}

Istio add-on change log
:   [Version `1.10.5`](/docs/containers?topic=containers-istio-changelog#1105) of the Istio managed add-on is released.

### 26 October 2021
{: #26oct2021}
{: release-note}

CLI changelog
:   The [CLI changelog](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.334. 

### 25 October 2021
{: #25oct2021}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.2_1527`](/docs/containers?topic=containers-changelog#1222_1527), [`1.21.5_1537`](/docs/containers?topic=containers-changelog#1215_1537), [`1.20.11_1559`](/docs/containers?topic=containers-changelog#12011_1559), and [`1.19.15_1566`](/docs/containers?topic=containers-changelog#11915_1566).

### 22 October 2021
{: #22oct2021}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in.
:   [Version 2.1.6](/docs/containers?topic=containers-cos_plugin_changelog) is released.

### 19 October 2021
{: #19oct2021}
{: release-note}

Ingress ALB changelog updates
:   Updated the [Ingress ALB changelog](/docs/containers?topic=containers-iks-release) for versions `0.49.3_1745_iks` and `1.0.3_1730_iks`.

### 18 October 2021
{: #18oct2021}
{: release-note}

New troubleshooting topic
:   See [Why does my cluster master status say it is approaching its resource limit?](/docs/containers?topic=containers-master_resource_limit). 



### 13 October 2021
{: #13oct2021}
{: release-note}

CLI changelog
:   The [CLI changelog](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.331. 

### 11 October 2021
{: #11oct2021}
{: release-note}



Unsupported Kubernetes version 1.18
:   Kubernetes version 1.18 is unsupported. To continue receiving important security updates and support, you must [update your cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately. 

Worker node fix pack update
:   Changelog documentation is available for Kubernetes version [`1.22.2_1524`](/docs/containers?topic=containers-changelog#1222_1524), [`1.21.5_1533`](/docs/containers?topic=containers-changelog#1215_1533), [`1.20.11_1555`](/docs/containers?topic=containers-changelog#12011_1555), and [`1.19.15_1562`](/docs/containers?topic=containers-changelog#11915_1562).

### 7 October 2021
{: #7oct2021}
{: release-note}

Istio add-on change log
:   [Version `1.11.3`](/docs/containers?topic=containers-istio-changelog#1113) of the Istio managed add-on is released.

Cluster autoscaler add-on.
:   [Version 1.0.4](/docs/containers?topic=containers-ca_changelog) is released.



### 6 October 2021
{: #6oct2021}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.0.1_780](/docs/containers?topic=containers-vpc_bs_changelog) is released.


### 5 October 2021
{: #5oct2021}
{: release-note}

Updated supported, deprecated, and unsupported versions for strongSwan Helm chart.
:   [Upgrading or disabling the strongSwan Helm chart](/docs/containers?topic=containers-vpn#vpn_upgrade)



{{site.data.keyword.cos_full_notm}} plug-in.
:   [Version 2.1.5](/docs/containers?topic=containers-cos_plugin_changelog) is released.


## September 2021
{: #release-sep-2021}

Review the release notes for September 2021.
{: shortdesc}

### 29 September 2021
{: #29sep2021}
{: release-note}

New! Kubernetes 1.22
:   You can create or [update clusters to Kubernetes version 1.22](/docs/containers?topic=containers-cs_versions#cs_v122). With Kubernetes 1.22, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product. For more information, [see the blog announcement](https://www.ibm.com/cloud/blog/announcements/kubernetes-version-121-now-available-in-ibm-cloud-kubernetes-service){: external}.

Deprecated and unsupported Kubernetes versions
:   With the release of Kubernetes 1.22, clusters that run version 1.18 remain deprecated, with a tentative unsupported date of 10 Oct 2021. Update your cluster to at least [version 1.20](/docs/containers?topic=containers-cs_versions#cs_v120) as soon as possible.

Master fix pack and worker node fix pack update
:   Change log documentation is available for Kubernetes version [`1.22.2_1522` and `1.22.2_1523`](/docs/containers?topic=containers-changelog#1222_1522_and_1222_1523).



### 27 September 2021
{: #27sep2021}
{: release-note}

Master fix pack update
:   Change log documentation is available for Kubernetes version [`1.21.5_1531`](/docs/containers?topic=containers-changelog#1215_1531), [`1.20.11_1553`](/docs/containers?topic=containers-changelog#12011_1553), [`1.19.15_1560`](/docs/containers?topic=containers-changelog#11915_1560), [`1.18.20_1565`](/docs/containers?topic=containers-changelog_archive#11820_1565).


Worker node fix pack update
:   Change log documentation is available for Kubernetes version [`1.18.20_1566`](/docs/containers?topic=containers-changelog_archive#11820_1566), [`1.19.15_1561`](/docs/containers?topic=containers-changelog#11915_1561), [`12011_1554`](/docs/containers?topic=containers-changelog#12011_1554), and [`1.21.5_1532`](/docs/containers?topic=containers-changelog#1215_1532).

### 23 September 2021
{: #23sep2021}
{: release-note}

Review the release notes for 23 September 2021.
{: shortdesc}

Istio add-on change log
:   [Version `1.11.2`](/docs/containers?topic=containers-istio-changelog#1112) of the Istio managed add-on is released.

### 22 September 2021
{: #22sep2021}
{: release-note}

Review the release notes for 22 September 2021.
{: shortdesc}

Ingress ALB version change log
:   [Version `1.0.0_1699_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#1_0_0) is now available. Updates for versions [`0.48.1_1698_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_48_0) and [`0.43.0_1697_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_47_0) are available in the change log. 




### 16 September 2021
{: #16sep2021}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on  
:   Version [`4.0.0_769`](/docs/containers?topic=containers-vpc_bs_changelog) is available.




### 14 September 2021
{: #14sep2021}
{: release-note}

Review the release notes for 14 September 2021.
{: shortdesc}

Ingress ALB version change log
:   [Version `1.0.0_1645_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#1_0_0) is now available. Updates for versions [`0.48.1_1613_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_48_0) and [`0.47.0_1614_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_47_0) are available in the change log. 

Istio add-on change log
:   [Version `1.10.4`](/docs/containers?topic=containers-istio-changelog#1104) and [version `1.9.8`](/docs/containers?topic=containers-istio-changelog#198) of the Istio managed add-on is released.


### 13 September 2021
{: #13sep2021}
{: release-note}

Worker node fix pack update
:   Change log documentation is available for Kubernetes version [`1.18.20_1564`](/docs/containers?topic=containers-changelog_archive#11820_1564), [`1.19.14_1559`](/docs/containers?topic=containers-changelog#11914_1559), [`1.20.10_1552`](/docs/containers?topic=containers-changelog#12010_1552), and [`1.21.4_1530`](/docs/containers?topic=containers-changelog#12104_1530).

### 9 September 2021
{: #9sep2021}
{: release-note}

Ingress ALB changelog
:   Updated the [change log](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1613_iks`, `0.47.0_1614_iks`, and `0.43.0_1612_iks`.



### 1 September 2021
{: #1sep2021}
{: release-note}

Review the release notes for 1 September 2021.
{: shortdesc}

{{site.data.keyword.block_storage_is_short}} add-on
:   Version [`4.0`](/docs/containers?topic=containers-vpc_bs_changelog) is available.

{{site.data.keyword.cos_full_notm}} plug-in 
:   Version [`2.1.4`](/docs/containers?topic=containers-cos_plugin_changelog) is available.


## August 2021
{: #aug21}

Review the release notes for August 2021.
{: shortdesc}

### 31 August 2021
{: #31aug2021}
{: release-note}

Review the release notes for 31 August 2021.
{: shortdesc}

Istio add-on changelog
:   [Version 1.11.1](/docs/containers?topic=containers-istio-changelog#1111) of the Istio managed add-on is released.

New! Sao Paolo multizone region
:   You can now create VPC clusters in the Sao Paolo, Brazil [location](/docs/containers?topic=containers-regions-and-zones).

 VPC disk encryption on worker nodes
:   Now, you can manage the encryption for the disk on your VPC worker nodes. For more information, see [VPC worker nodes](/docs/containers?topic=containers-encryption#worker-encryption-vpc).

### 30 August 2021
{: #30aug2021}
{: release-note}

Review the release notes for 30 August 2021.
{: shortdesc}

Worker node fix pack update
:   Change log documentation is available for Kubernetes version [`1.17.17_1568`](/docs/containers?topic=containers-changelog_archive#11717_1568), [`1.18.20_1563`](/docs/containers?topic=containers-changelog_archive#11820_1563), [`1.19.14_1558`](/docs/containers?topic=containers-changelog#11914_1558), [`1.20.10_1551`](/docs/containers?topic=containers-changelog#12010_1551), and [`1.21.4_1529`](/docs/containers?topic=containers-changelog#12104_1529).

### 25 August 2021
{: #26aug2021}
{: release-note}

New! Create a cluster with a template
:   No longer do you have to manually specify the networking and worker node details to create a cluster, or enable security integrations such as logging and monitoring after creation. Instead, you can try out the **technical preview** to create a multizone cluster with nine worker nodes and encryption, logging, and monitoring already enabled. For more information, see [Creating a cluster by using an {{site.data.keyword.bpfull_notm}} template](/docs/openshift?topic=openshift-templates&interface=ui).

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.3` is [released](/docs/containers?topic=containers-cos_plugin_changelog).
Master fix pack update changelog documentation

:   Master fix pack update changelog documentation is available for Kubernetes version [1.21.4_ 1528](/docs/containers?topic=containers-changelog#1214_1528), [1.20.10_1550](/docs/containers?topic=containers-changelog#12010_1550), [1.19.14_1557](/docs/containers?topic=containers-changelog#11914_1557), and [1.18.20_1562](/docs/containers?topic=containers-changelog_archive#11820_1562).

### 23 August 2021
{: #23aug2021}
{: release-note}

Registry token update
:   Registry tokens are no longer accepted for authentication in {{site.data.keyword.registrylong_notm}}. Update your clusters to use {{site.data.keyword.cloud_notm}} IAM authentication. For more information, see [Accessing {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=Registry-registry_access). For more information about Registry token deprecation, see [IBM Cloud Container Registry Deprecates Registry Tokens for Authentication](https://www.ibm.com/cloud/blog/announcements/ibm-cloud-container-registry-deprecates-registry-tokens-for-authentication){: external}.

Ingress changelogs
:   Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1541_iks`, `0.47.0_1540_iks`, and `0.43.0_1539_iks`. Version `0.45.0_1482_iks` is removed.
  
ALB OAuth Proxy
:   Updated the version changelog for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

### 16 August 2021
{: #16aug2021}
{: release-note}

Worker node versions
:   Worker node fix pack update changelog documentation is available for Kubernetes. For more information, see [Version changelog](/docs/containers?topic=containers-changelog).
  
### 12 August 2021
{: #12aug2021}
{: release-note}

Istio add-on changelog
:   [Version 1.9.7](/docs/containers?topic=containers-istio-changelog#196) of the Istio managed add-on is released.

### 10 August 2021
{: #10aug2021}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1465_iks`, `0.47.0_1480_iks`, and `0.45.0_1482_iks`.

ALB OAuth Proxy
:   Updated the version changelog for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog). 

### 9 August 2021
{: #09aug2021}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 1.0.312](/docs/containers?topic=containers-cs_cli_changelog).

### 2 August 2021
{: #02aug2021}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.47.0_1434_iks` and `0.45.0_1435_iks`. Version `0.35.0` is now unsupported. 

Worker node versions
:   Worker node fix pack update changelog documentation is available for Kubernetes version [1.21.3_1526](/docs/containers?topic=containers-changelog#1213_1526), [1.20.9_1548](/docs/containers?topic=containers-changelog#1209_1548), [1.19.13_1555](/docs/containers?topic=containers-changelog#11913_1555), and [1.18.20_1560](/docs/containers?topic=containers-changelog_archive#11820_1560).

## July 2021
{: #jul21} 

### 27 July 2021
{: #27july2021}
{: release-note}

New! IAM trusted profile support
:   Link your cluster to a trusted profile in IAM so that the pods in your cluster can authenticate with IAM to use other {{site.data.keyword.cloud_notm}} services.

Master versions
:   Master fix pack update changelog documentation is available for Kubernetes version [1.21.3_1525](/docs/containers?topic=containers-changelog#1213_1525), [1.20.9_1547](/docs/containers?topic=containers-changelog#1209_1547), [1.19.13_1554](/docs/containers?topic=containers-changelog#11913_1554), and [1.18.20_1559](/docs/containers?topic=containers-changelog_archive#11820_1559).

### 26 July 2021
{: #26july2021}
{: release-note}



### 28 October 2019
{: #28oct2019}
{: release-note}

Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.5_1521](/docs/containers?topic=containers-changelog_archive#1155_1521), [1.14.8_1537](/docs/containers?topic=containers-changelog_archive#1148_1537), [1.13.12_1540](/docs/containers?topic=containers-changelog_archive#11312_1540), [1.12.10_1570](/docs/containers?topic=containers-changelog_archive#11210_1570), and {{site.data.keyword.openshiftshort}} [3.11.153_1529_openshift](/docs/openshift?topic=openshift-openshift_changelog#311153_1529).

New! Resource groups for VPC clusters
:   You can now [create Kubernetes clusters](/docs/containers?topic=containers-vpc_ks_tutorial) in different resource groups than the resource group of the Virtual Private Cloud (VPC).

### 24 October 2019
{: #24oct2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.4.42](/docs/containers?topic=containers-cs_cli_changelog).

Scaling down file storage
:   Added steps for [scaling down the default file storage plug-in](/docs/containers?topic=containers-file_storage#file_scaledown_plugin) in classic clusters.

Ingress subdomain troubleshooting
:   Added troubleshooting steps for when [no Ingress subdomain exists after cluster creation](/docs/containers?topic=containers-ingress_subdomain).
    

### 23 October 2019
{: #23oct2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 584 and `ingress-auth` image build to 344](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Ingress annotations
:   Added the [`proxy-ssl-verify-depth` and `proxy-ssl-name` optional parameters to the `ssl-services` annotation](/docs/containers?topic=containers-comm-ingress-annotations#ssl-services-support).

### 22 October 2019
{: #22oct2019}
{: release-note}

Version changelogs
:   Master patch updates are available for Kubernetes [1.15.5_1520](/docs/containers?topic=containers-changelog_archive#1155_1520), [1.14.8_1536](/docs/containers?topic=containers-changelog_archive#1148_1536), [1.13.12_1539](/docs/containers?topic=containers-changelog_archive#11312_1539), and {{site.data.keyword.openshiftshort}} [3.11.146_1528_openshift](/docs/openshift?topic=openshift-openshift_changelog#311146_1528).

### 17 October 2019
{: #17oct2019}
{: release-note}

New! Cluster autoscaler
:   The cluster autoscaler is available for private network-only clusters. To get started, update to the latest Helm chart version.

New DevOps tutorial
:    Learn how to set up your own DevOps toolchain and configure continuous delivery pipeline stages to deploy your containerized app that is stored in GitHub to a cluster in {{site.data.keyword.containerlong_notm}}.

### 14 October 2019
{: #14oct2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.4.38](/docs/containers?topic=containers-cs_cli_changelog).

Calico MTU
:   Added [steps](/docs/containers?topic=containers-kernel#calico-mtu) for changing the Calico plug-in maximum transmission unit (MTU) to meet the network throughput requirements of your environment.

Creating DNS subdomains for VPC load balancers and private Ingress ALBs
:   Added steps for [registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns) and for [exposing apps to a private network](/docs/containers?topic=containers-ingress-types#alb-comm-create-private) in VPC clusters.

Let's Encrypt rate limits for Ingress
:   Added troubleshooting steps for when no subdomain or secret is generated for the Ingress ALB when you create or delete clusters of the same name.

Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.4_1519](/docs/containers?topic=containers-changelog_archive#1154_1519_worker), [1.14.7_1535](/docs/containers?topic=containers-changelog_archive#1147_1535_worker), [1.13.11_1538](/docs/containers?topic=containers-changelog_archive#11311_1538_worker), [1.12.10_1569](/docs/containers?topic=containers-changelog_archive#11210_1569_worker), and {{site.data.keyword.openshiftshort}} [3.11.146_1527_openshift](/docs/openshift?topic=openshift-openshift_changelog#311146_1527).

### 3 October 2019
{: #03oct2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 579 and `ingress-auth` image build to 341](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

DevOps toolchain
:   You can now use the **DevOps** tab on the cluster details page to configure your DevOps toolchain. For more information, see [Setting up a continuous delivery pipeline for a cluster](/docs/containers?topic=containers-cicd#continuous-delivery-pipeline).

Security for VPC clusters
:   Added information for how to achieve [network segmentation and privacy in VPC clusters](/docs/containers?topic=containers-security#network_segmentation_vpc).
    
    

### 1 October 2019
{: #01oct2019}
{: release-note}

End of service of {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}}
:   Removed steps for using {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}} to work with cluster logs and metrics. You can collect logs and metrics for your cluster by setting up [{{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health#logging) and [{{site.data.keyword.mon_full_notm}}](/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster) instead.

New! Gateway-enabled classic clusters
:   Keep your compute workloads private and allow limited public connectivity to your classic cluster by enabling a gateway. You can enable a gateway only on standard, Kubernetes clusters during cluster creation.
:   When you enable a gateway on a classic cluster, the cluster is created with a `compute` worker pool of compute worker nodes that are connected to a private VLAN only, and a `gateway` worker pool of gateway worker nodes that are connected to public and private VLANs. Traffic into or out of the cluster is routed through the gateway worker nodes, which provide your cluster with limited public access. For more information, check out the following links.
         - [Using a gateway-enabled cluster](/docs/containers?topic=containers-plan_clusters#gateway)
         - [Isolating networking workloads to edge nodes in classic gateway-enabled clusters](/docs/containers?topic=containers-edge#edge_gateway)
         - Flow of traffic to apps when using an [NLB 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_gateway), an [NLB 2.0](/docs/containers?topic=containers-loadbalancer-about#v2_gateway), or [Ingress ALBs](/docs/containers?topic=containers-ingress-about#classic-gateway)
:   Ready to get started? [Create a standard classic cluster with a gateway in the CLI](/docs/containers?topic=containers-clusters#gateway_cluster_cli).

Version changelogs
:   Patch updates are available for Kubernetes [1.15.4_1518](/docs/containers?topic=containers-changelog_archive#1154_1518), [1.14.7_1534](/docs/containers?topic=containers-changelog_archive#1147_1534), [1.13.11_1537](/docs/containers?topic=containers-changelog_archive#11311_1537), and [1.12.10_1568](/docs/containers?topic=containers-changelog_archive#11210_1568_worker).    

## September 2019
{: #sept19}



### 27 September 2019
{: #27sept2019}
{: release-note}

{{site.data.keyword.cos_full_notm}} supported in VPC clusters
:   You can now provision {{site.data.keyword.cos_full_notm}} for your apps that run in a VPC cluster. For more information, see [Storing data on {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage).

### 24 September 2019
{: #24sept2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.4.31](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 566](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Managing cluster network traffic for VPC clusters
:   Includes the following new content.
    - [Opening required ports and IP addresses in your firewall for VPC clusters](/docs/containers?topic=containers-vpc-firewall)
    - [Controlling traffic with VPC ACLs and network policies](/docs/containers?topic=containers-vpc-network-policy)
    - [Setting up VPC VPN connectivity](/docs/containers?topic=containers-vpc-vpnaas)

Customizing PVC settings for VPC Block Storage
:   You can create a customized storage class or use a Kubernetes secret to create VPC Block Storage with the configuration that you want. For more information, see [Customizing the default settings](/docs/containers?topic=containers-vpc-block#vpc-customize-default).
    

### 19 September 2019
{: #19sept2019}
{: release-note}

Sending custom Ingress certificates to legacy clients
:   Added [steps](/docs/containers?topic=containers-comm-ingress-annotations) for ensuring that your custom certificate, instead of the default IBM-provided certificate, is sent by the Ingress ALB to legacy clients that don't support SNI.


### 16 September 2019
{: #16sept2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the release of version 0.4.23.

{{site.data.keyword.at_full_notm}} events
:   Added information about [which {{site.data.keyword.at_short}} location your events are sent to](/docs/containers?topic=containers-at_events#at-ui) based on the {{site.data.keyword.containerlong_notm}} location where the cluster is located.

Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.3_1517](/docs/containers?topic=containers-changelog_archive#1153_1517_worker), [1.14.6_1533](/docs/containers?topic=containers-changelog_archive#1146_1533_worker), [1.13.10_1536](/docs/containers?topic=containers-changelog_archive#11310_1536_worker), and [1.12.10_1567](/docs/containers?topic=containers-changelog_archive#11210_1567_worker).
    

### 13 September 2019
{: #13sept2019}
{: release-note}



Entitled software
:   If you have licensed products from your [MyIBM.com](https://myibm.ibm.com){: external} container software library, you can [set up your cluster to pull images from the entitled registry](/docs/containers?topic=containers-registry#secret_entitled_software).

`script update` command
:   Added [steps for using the `script update` command](/docs/containers?topic=containers-kubernetes-service-cli#script_update) to prepare your automation scripts for the release of version 1.0 of the {{site.data.keyword.containerlong_notm}} plug-in.
    

### 12 September 2019
{: #12sept2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 552](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).



### 5 September 2019
{: #05sept2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`ingress-auth` image to build 340](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 4 September 2019
{: #04sept2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.4.3](/docs/containers?topic=containers-cs_cli_changelog).

IAM allowlists
:   If you use an IAM allowlist, you must [allow the CIDRs of the {{site.data.keyword.containerlong_notm}} control plane](/docs/containers?topic=containers-firewall#iam_allowlist) for the zones in the region where your cluster is located so that {{site.data.keyword.containerlong_notm}} can create Ingress ALBs and `LoadBalancers` in your cluster.

### 3 September 2019
{: #03sept2019}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} plug-in version `0.4`
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for multiple changes in the [release of version 0.4.1](/docs/containers?topic=containers-cs_cli_changelog).

Version changelog
:   Worker node patch updates are available for Kubernetes [1.15.3_1516](/docs/containers?topic=containers-changelog_archive#1153_1516_worker), [1.14.6_1532](/docs/containers?topic=containers-changelog_archive#1146_1532_worker), [1.13.10_1535](/docs/containers?topic=containers-changelog_archive#11310_1535_worker), [1.12.10_1566](/docs/containers?topic=containers-changelog_archive#11210_1566_worker), and {{site.data.keyword.openshiftshort}} [3.11.135_1523](/docs/openshift?topic=openshift-openshift_changelog#311135_1523_worker).

## August 2019
{: #aug19}



### 29 August 2019
{: #29aug2019}
{: release-note}

Forwarding Kubernetes API audit logs to {{site.data.keyword.la_full_notm}}
:   Added steps to [create an audit webhook in your cluster](/docs/containers?topic=containers-health-audit) to collect Kubernetes API audit logs from your cluster and forward them to {{site.data.keyword.la_full_notm}}.

### 28 August 2019
{: #28aug2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.3.112](/docs/containers?topic=containers-cs_cli_changelog).

Version changelogs
:   Updated the changelogs for [1.15.3_1515](/docs/containers?topic=containers-changelog_archive#1153_1515), [1.14.6_1531](/docs/containers?topic=containers-changelog_archive#1146_1531), [1.13.10_1534](/docs/containers?topic=containers-changelog_archive#11310_1534), and [1.12.10_1565](/docs/containers?topic=containers-changelog_archive#11210_1565) master fix pack updates.
    

### 26 August 2019
{: #26aug2019}
{: release-note}

Cluster autoscaler
:   With the latest version of the cluster autoscaler, you can [enable autoscaling for worker pools during the Helm chart installation](/docs/containers?topic=containers-ca#ca_helm) instead of modifying the config map after installation.

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 524 and `ingress-auth` image to build 337](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 23 August 2019
{: #23aug2019}
{: release-note}



App networking in VPC
:   Updated the [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning) topic with information for planning app networking in a VPC cluster.

Istio in VPC
:   Updated the [managed Istio add-on](/docs/containers?topic=containers-istio) topic with information for using Istio in a VPC cluster.

Remove bound services from cluster
:   Added instructions for how to remove an {{site.data.keyword.cloud_notm}} service that you added to a cluster by using service binding. For more information, see [Removing a service from a cluster](/docs/containers?topic=containers-service-binding#unbind-service).

### 20 August 2019
{: #20aug2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 519](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for a `custom-ports` bug fix.

### 19 August 2019
{: #19aug2019}
{: release-note}

New! Virtual Private Cloud
:   You can create standard Kubernetes clusters on classic infrastructure in the next generation of the {{site.data.keyword.cloud_notm}} platform, in your Virtual Private Cloud. VPC gives you the security of a private cloud environment with the dynamic scalability of a public cloud. Classic on VPC clusters are available for only standard, Kubernetes clusters and are not supported in free or {{site.data.keyword.openshiftshort}} clusters.
:   With classic clusters in VPC, {{site.data.keyword.containerlong_notm}} introduces version 2 of the API, which supports multiple infrastructure providers for your clusters. Your cluster network setup also changes, from worker nodes that use public and private VLANs and the public cloud service endpoint to worker nodes that are on a private subnet only and have the private cloud service endpoint enabled. For more information, check out the following links.
    - [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers)
    - [About the v2 API](/docs/containers?topic=containers-cs_api_install#api_about)
    - [Understanding network basics of VPC clusters](/docs/containers?topic=containers-plan_clusters#plan_vpc_basics)
    
:   Ready to get started? Try out the [Creating a classic cluster in your VPC tutorial](/docs/containers?topic=containers-vpc_ks_tutorial).

Kubernetes 1.14
:   [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#version_types) is now the default version.

### 17 August 2019
{: #17aug2019}
{: release-note}

{{site.data.keyword.at_full}}
:   The [{{site.data.keyword.at_full_notm}} service](/docs/containers?topic=containers-at_events) is now supported for you to view, manage, and audit user-initiated activities in your clusters.

Version changelogs
:   Updated the changelogs for [1.15.2_1514](/docs/containers?topic=containers-changelog_archive#1152_1514), [1.14.5_1530](/docs/containers?topic=containers-changelog_archive#1145_1530), [1.13.9_1533](/docs/containers?topic=containers-changelog_archive#1139_1533), and [1.12.10_1564](/docs/containers?topic=containers-changelog_archive#11210_1564) master fix pack updates.

### 15 August 2019
{: #15aug2019}
{: release-note}


App deployments
:   Added steps for [copying deployments from one cluster to another](/docs/containers?topic=containers-update_app#copy_apps_cluster).

FAQs
:   Added an FAQ about [free clusters](/docs/containers?topic=containers-faqs#faq_free).

Istio
:   Added steps for [exposing Istio-managed apps with TLS termination](/docs/containers?topic=containers-istio-mesh#tls), [securing in-cluster traffic by enabling mTLS](/docs/containers?topic=containers-istio-mesh#mtls), and [Updating the Istio add-ons](/docs/containers?topic=containers-istio#istio_update).

Knative
:   Added instructions for how to use volumes to access secrets and config maps, pull images from a private registry, scale apps based on CPU usage, change the default container port, and change the `scale-to-zero-grace-period`.

Version changelogs
:   Updated the changelogs for [1.15.2_1513](/docs/containers?topic=containers-changelog_archive#1152_1513), [1.14.5_1529](/docs/containers?topic=containers-changelog_archive#1145_1529), [1.13.9_1532](/docs/containers?topic=containers-changelog_archive#1139_1532), and [1.12.10_1563](/docs/containers?topic=containers-changelog_archive#11210_1563) master fix pack updates.

### 12 August 2019
{: #12aug2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.3.103](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the ALB `ingress-auth` image to build 335 for [`musl libc` vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 5 August 2019
{: #05aug2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.3.99](/docs/containers?topic=containers-cs_cli_changelog).

New! `NodeLocal` DNS caching (beta)
:   For clusters that run Kubernetes 1.15 or later, you can set up improved cluster DNS performance with [`NodeLocal` DNS caching](/docs/containers?topic=containers-cluster_dns#dns_cache).

New! Version 1.15
:   You can create community Kubernetes clusters that run version 1.15. To update from a previous version, review the [1.15 changes](/docs/containers?topic=containers-cs_versions#cs_v115).

Deprecated: Version 1.12
:   Kubernetes version 1.12 is deprecated. Review the [changes across versions](/docs/containers?topic=containers-cs_versions), and update to a more recent version.

Version changelogs
:   Updated the changelogs for [1.14.4_1527](/docs/containers?topic=containers-changelog_archive#1144_1527_worker), [1.13.8_1530](/docs/containers?topic=containers-changelog_archive#1138_1530_worker), and [1.12.10_1561](/docs/containers?topic=containers-changelog_archive#11210_1561_worker) worker node patch updates.



## July 2019
{: #jul19}

### 30 July 2019
{: #30july2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.3.95](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the ALB `nginx-ingress` image to build 515 for the [ALB pod readiness check](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Removing subnets from a cluster
:   Added steps for removing subnets [in an IBM Cloud infrastructure account](/docs/containers?topic=containers-subnets#remove-subnets) from a cluster. 



### 23 July 2019
{: #23july2019}
{: release-note}

Fluentd changelog
:   Fixes [Alpine vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).

### 22 July 2019
{: #22july2019}
{: release-note}

Version policy
:   Increased the [version deprecation](/docs/containers?topic=containers-cs_versions#version_types) period from 30 to 45 days.

Version changelogs
:   Updated the changelogs for [1.14.4_1526](/docs/containers?topic=containers-changelog_archive#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog_archive#1138_1529_worker), and [1.12.10_1560](/docs/containers?topic=containers-changelog_archive#11210_1560_worker) worker node patch updates.

Version changelog
:   [Version 1.11is unsupported](/docs/containers?topic=containers-changelog_archive#111_changelog).

### 17 July 2019
{: #17july2019}
{: release-note} 

Ingress ALB changelog
:   Fixes [`rbash` vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 15 July 2019
{: #15july2019}
{: release-note}


Cluster and worker node ID
:   The ID format for clusters and worker nodes is changed. Existing clusters and worker nodes keep their existing IDs. If you have automation that relies on the previous format, update it for new clusters.
    - **Cluster ID**: In the regex format `{a-v0-9}7]{a-z0-9}[2]{a-v0-9}[11]`.
    - **Worker node ID**: In the format `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`

Ingress ALB changelog
:   Updated the ALB `nginx-ingress` image to build 497.

Troubleshooting clusters
:   Added [troubleshooting steps](/docs/containers?topic=containers-worker_infra_errors#cs_totp) for when you can't manage clusters and worker nodes because the time-based one-time passcode (TOTP) option is enabled for your account.

Version changelogs
:   Updated the changelogs for [1.14.4_1526](/docs/containers?topic=containers-changelog_archive#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog_archive#1138_1529), and [1.12.10_1560](/docs/containers?topic=containers-changelog_archive#11210_1560) master fix pack updates.

### 8 July 2019
{: #08july2019}
{: release-note}

Version changelogs
:   Updated the changelogs for [1.14.3_1525](/docs/containers?topic=containers-changelog_archive#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog_archive#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog_archive#1129_1559), and [1.11.10_1564](/docs/containers?topic=containers-changelog_archive#11110_1564) worker node patch updates.

### 2 July 2019
{: #02july2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of version 0.3.58](/docs/containers?topic=containers-cs_cli_changelog).

### 1 July 2019
{: #01july2019}
{: release-note}

Infrastructure permissions
:   Updated the [classic infrastructure roles](/docs/containers?topic=containers-access_reference#infra) required for common use cases.

strongSwan VPN service
:   If you install strongSwan in a multizone cluster and use the `enableSingleSourceIP=true` setting, you can now [set `local.subnet` to the `%zoneSubnet` variable and use the `local.zoneSubnet` to specify an IP address as a /32 subnet for each zone of the cluster](/docs/containers?topic=containers-vpn#strongswan_4).


## June 2019
{: #jun19}

### 24 June 2019
{: #24june2019}
{: release-note}

Calico network policies
:   Added a set of [public Calico policies](/docs/containers?topic=containers-network_policies#isolate_workers_public) and expanded the set of [private Calico policies](/docs/containers?topic=containers-network_policies#isolate_workers) to protect your cluster on public and private networks.

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 477](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Service limitations
:   Updated the [maximum number of pods per worker node limitation](/docs/containers?topic=containers-limitations#tech_limits). For worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later and that have more than 11 CPU cores, the worker nodes can support 10 pods per core, up to a limit of 250 pods per worker node.

Version changelogs
:   Added changelogs for [1.14.3_1524](/docs/containers?topic=containers-changelog_archive#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog_archive#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog_archive#1129_1558), and [1.11.10_1563](/docs/containers?topic=containers-changelog_archive#11110_1563) worker node patch updates.
    

### 21 June 2019
{: #21june2019}
{: release-note}


  
Accessing the Kubernetes master through the private cloud service endpoint
:   Added steps for [editing the local Kubernetes configuration file](/docs/containers?topic=containers-access_cluster#access_private_se) when both the public and private cloud service endpoints are enabled, but you want to access the Kubernetes master through the private cloud service endpoint only.
    

### 18 June 2019
{: #18june2019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in changelog page for the [release of versions 0.3.47 and 0.3.49](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 473 and `ingress-auth` image to build 331](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Managed add-on versions
:   Updated the version of the Istio managed add-on to 1.1.7 and the Knative managed add-on to 0.6.0.

Removing persistent storage
:   Updated the information for how you are billed when you delete persistent storage.

Service bindings with private endpoint
:   [Added steps](/docs/containers?topic=containers-service-binding) for how to manually create service credentials with the private cloud service endpoint when you bind the service to your cluster.

Version changelogs
:   Updated the changelogs for [1.14.3_1523](/docs/containers?topic=containers-changelog_archive#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog_archive#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog_archive#1129_1557), and [1.11.10_1562] (/docs/containers?topic=containers-changelog_archive#11110_1562) patch updates.
    

### 14 June 2019
{: #14june2019}
{: release-note}

`kubectl` troubleshooting
:   Added a [troubleshooting topic](/docs/containers?topic=containers-ts_clis#kubectl_fails) for when you have a `kubectl` client version that is 2 or more versions apart from the server version or the {{site.data.keyword.openshiftshort}} version of `kubectl`, which does not work with community Kubernetes clusters.

Tutorials landing page
:   Replaced the related links page with a new tutorials landing page for all tutorials that are specific to {{site.data.keyword.containershort_notm}}.

Tutorial to create a cluster and deploy an app
:   Combined the tutorials for creating clusters and deploying apps into one comprehensive [tutorial](/docs/containers?topic=containers-cs_cluster_tutorial).

Using existing subnets to create a cluster
:   To [reuse subnets from an unneeded cluster when you create a new cluster](/docs/containers?topic=containers-subnets#subnets_custom), the subnets must be user-managed subnets that you manually added from an on-premises network. All subnets that were automatically ordered during cluster creation are immediately marked for deletion after you delete a cluster, and you can't reuse these subnets to create a new cluster.
    

### 12 June 2019
{: #12june2019}
{: release-note}

Aggregating cluster roles
:   Added steps for [extending users' existing permissions by aggregating cluster roles](/docs/containers?topic=containers-users#rbac_aggregate).

### 7 June 2019
{: #07june2019}
{: release-note}

Access to the Kubernetes master through the private cloud service endpoint
:   Added [steps](/docs/containers?topic=containers-access_cluster#access_private_se) to expose the private cloud service endpoint through a private load balancer. After you complete these steps, your authorized cluster users can access the Kubernetes master from a VPN or {{site.data.keyword.dl_full_notm}} connection.

{{site.data.keyword.BluDirectLink}}
:   Added {{site.data.keyword.dl_full_notm}} to the [VPN connectivity](/docs/containers?topic=containers-vpn) page as a way to create a direct, private connection between your remote network environments and {{site.data.keyword.containerlong_notm}} without routing over the public internet.

Ingress ALB changelog
:   Updated the [ALB `ingress-auth` image to build 330](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 6 June 2019
{: #06june2019}
{: release-note}

Fluentd changelog
:   Added a [Fluentd version changelog](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 470](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 5 June 2019
{: #05june2019}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to reflect multiple changes for the release of version [0.3.34](/docs/containers?topic=containers-cs_cli_changelog) of the {{site.data.keyword.containerlong_notm}} CLI plug-in.

### 4 June 2019
{: #04june2019}
{: release-note}

Version changelogs
:   Updated the changelogs for the [1.14.2_1521](/docs/containers?topic=containers-changelog_archive#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog_archive#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog_archive#1129_1555), and [1.11.10_1561](/docs/containers?topic=containers-changelog_archive#11110_1561) patch releases.

### 3 June 2019
{: #03june2019}
{: release-note}

Bringing your own Ingress controller
:   Updated the [steps](/docs/containers?topic=containers-ingress-user_managed) to reflect changes to the default community controller and to require a health check for controller IP addresses in multizone clusters.

{{site.data.keyword.cos_full_notm}}
:   Updated the [steps](/docs/containers?topic=containers-object_storage#install_cos) to install the {{site.data.keyword.cos_full_notm}} plug-in with or without the Helm server, Tiller.

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 467](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Kustomize
:   Added an example of [reusing Kubernetes configuration files across multiple environments with Kustomize](/docs/containers?topic=containers-app#kustomize).

Razee
:   Added [Razee](https://github.com/razee-io/Razee){: external} to the supported integrations to visualize deployment information in the cluster and to automate the deployment of Kubernetes resources. 

## May 2019
{: #may19}

### 30 May 2019
{: #30may2019}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to reflect multiple changes for the [release of version 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) of the {{site.data.keyword.containerlong_notm}} CLI plug-in.

Troubleshooting storage: 
:   Added a file and block storage troubleshooting topic for [PVC pending states](/docs/containers?topic=containers-file_pvc_pending).
    - Added a block storage troubleshooting topic for when [an app can't access or write to PVC](/docs/containers?topic=containers-block_app_failures). 

### 28 May 2019
{: #28may2019}
{: release-note}

Cluster add-ons changelog
:   Updated the [ALB `nginx-ingress` image to build 462](/docs/containers?topic=containers-cluster-add-ons-changelog).

Troubleshooting registry
:   Added a [troubleshooting topic](/docs/containers?topic=containers-ts_image_pull_create) for when your cluster can't pull images from {{site.data.keyword.registryfull}} due to an error during cluster creation.
    
Troubleshooting storage
:   Added a topic for debugging persistent storage failures.
    - Added a troubleshooting topic for [PVC creation failures due to missing permissions](/docs/containers?topic=containers-missing_permissions).

### 23 May 2019
{: #23may2019}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to reflect multiple changes for the [release of version 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) of the {{site.data.keyword.containerlong_notm}} CLI plug-in.

Cluster add-ons changelog
:   Updated the [ALB `nginx-ingress` image to build 457](/docs/containers?topic=containers-cluster-add-ons-changelog).

Cluster and worker states
:   Updated the [Logging and monitoring page](/docs/containers?topic=containers-health-monitor#states) to add reference tables about cluster and worker node states.

Cluster planning and creation
:   You can now find information about cluster planning, creation, and removal and network planning in the following pages:
    - [Planning your cluster network setup](/docs/containers?topic=containers-plan_clusters)
    - [Planning your cluster for high availability](/docs/containers?topic=containers-ha_clusters)
    - [Planning your worker node setup](/docs/containers?topic=containers-planning_worker_nodes)
    - [Creating clusters](/docs/containers?topic=containers-clusters)
    - [Adding worker nodes and zones to clusters](/docs/containers?topic=containers-add_workers)
    - [Removing clusters](/docs/containers?topic=containers-remove)
    - [Changing service endpoints or VLAN connections](/docs/containers?topic=containers-cs_network_cluster)
    
Cluster version updates
:   Updated the [unsupported versions policy](/docs/containers?topic=containers-cs_versions) to note that you can't update clusters if the master version is three or more versions behind the oldest supported version. You can view if the cluster is **unsupported** by reviewing the **State** field when you list clusters.

Istio
:   Updated the [Istio page](/docs/containers?topic=containers-istio) to remove the limitation that Istio does not work in clusters that are connected to a private VLAN only. Added a step to the [Updating managed add-ons topic](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) to re-create Istio gateways that use TLS sections after the update of the Istio managed add-on is complete.

Popular topics
:   Replaced the popular topics with this release notes page for new features and updates that are specific to {{site.data.keyword.containershort_notm}}. For the latest information on {{site.data.keyword.cloud_notm}} products, check out the [Announcements](https://www.ibm.com/cloud/blog/announcements){: external}.
    

### 20 May 2019
{: #20may2019}
{: release-note}

Version changelogs
:   Added [worker node fix pack changelogs](/docs/containers?topic=containers-changelog).

### 16 May 2019
{: #16may2019}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to add COS endpoints for `logging collect` commands and to clarify that `cluster master refresh` restarts the Kubernetes master components.

Unsupported: Kubernetes version 1.10
:   [Kubernetes version 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) is now unsupported.
    

### 15 May 2019
{: #15may2019}
{: release-note}

Default Kubernetes version
:   The default Kubernetes version is now 1.13.6.

Service limits
:   Added a [service limitations topic](/docs/containers?topic=containers-limitations#tech_limits).
    
### 13 May 2019
{: #13may2019}
{: release-note}

Version changelogs
:   Added that new patch updates are available for [1.14.1_1518](/docs/containers?topic=containers-changelog_archive#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog_archive#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog_archive#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog_archive#11110_1558), and [1.10.13_1558](/docs/containers?topic=containers-changelog_archive#11013_1558).

Worker node flavors
:   Removed all [virtual machine worker node flavors](/docs/containers?topic=containers-planning_worker_nodes#vm) that are 48 or more cores. You can still provision [bare metal worker nodes](/docs/containers?topic=containers-planning_worker_nodes#bm) with 48 or more cores.

### 8 May 2019
{: #08may2019}
{: release-note}

API
:   Added a link to the [global API swagger docs](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}.

Cloud Object Storage
:   [Added a troubleshooting guide for Cloud Object Storage](/docs/containers?topic=containers-cos_pvc_pending) in your {{site.data.keyword.containerlong_notm}} clusters.

Kubernetes strategy
:   Added a topic about [What knowledge and technical skills are good to have before I move my apps to {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).

Kubernetes version 1.14
:   Added that the [Kubernetes 1.14 release](/docs/containers?topic=containers-cs_versions#cs_v114) is certified.

Reference topics
:   Updated information for various service binding, `logging`, and `nlb` operations in the [user access](/docs/containers?topic=containers-access_reference) and [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli) pages.

### 7 May 2019
{: #07may2019}
{: release-note}

Cluster DNS provider
:   [Explained the benefits of CoreDNS](/docs/containers?topic=containers-cluster_dns) now that clusters that run Kubernetes 1.14 and later support only CoreDNS.

Edge nodes
:   Added private load balancer support for [edge nodes](/docs/containers?topic=containers-edge).

Free clusters
:   Clarified where [free clusters](/docs/containers?topic=containers-regions-and-zones#regions_free) are supported.

New! Integrations
:   Added and restructure information about [{{site.data.keyword.cloud_notm}} services and third-party integrations](/docs/containers?topic=containers-ibm-3rd-party-integrations), [popular integrations](/docs/containers?topic=containers-supported_integrations), and [partnerships](/docs/containers?topic=containers-service-partners).

New! Kubernetes version 1.14
:   Create or update your clusters to [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).

Deprecated Kubernetes version 1.11
:   [Updateany clusters](/docs/containers?topic=containers-update) that run [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) before they become unsupported.

Permissions
:   Added an FAQ, [What access policies do I give my cluster users?](/docs/containers?topic=containers-faqs#faq_access)

Worker pools
:   Added instructions for how to [apply labels](/docs/containers?topic=containers-add_workers#worker_pool_labels) to existing worker pools.

Reference topics
:   To support new features such as Kubernetes 1.14, [changelog reference](/docs/containers?topic=containers-changelog#changelog) pages are updated.

### 1 May 2019
{: #01may2019}
{: release-note}

Assigning infrastructure access
:   Revised the [steps](/docs/containers?topic=containers-access-creds#infra_access) to assign IAM permissions for opening support cases.
