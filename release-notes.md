---

copyright: 
  years: 2014, 2023
lastupdated: "2023-02-20"

keywords: kubernetes, release notes

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



## February 2023
{: #containers-feb23}



### 20 February 2023
{: #containers-feb2023}
{: release-note}

Ingress ALB version `1.3.1_3777_iks`, `1.4.0_3783_iks`, and `1.5.1_3779_iks`
:   For more information, see the [change log](/docs/containers?topic=containers-cluster-add-ons-changelog).


  
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
:   For more information, see the [change log](/docs/containers?topic=containers-cluster-add-ons-changelog).




### 9 February 2023
{: #containers-feb0923}
{: release-note}


{{site.data.keyword.block_storage_is_short}} add-on version `5.1`.
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).


### 8 February 2023
{: #containers-feb0823}
{: release-note}

ALB OAuth Proxy add-on version `2.0.0_1420`.
:   For more information, see the [change log](/docs/containers?topic=containers-alb-oauth-proxy-changelog).



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
:   You can now create a [persistent VPC load balancer](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_persist) that remains available even after your cluster is deleted. 

Customized VPC load balancer health checks
:   For more control over your VPC load balancer health checks, you can use [optional annotations](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_health_custom) to customize your health checks with advanced configurations for test intervals, timeouts, and retries.

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
:   For more information, see the [change log](/docs/containers?topic=containers-cluster-add-ons-changelog).



### 24 January 2023
{: #containers-jan2423}
{: release-note}

CLI version 1.0.487 change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.487.

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.16_1779` and `5.0.5_1784`.
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).

Cluster autoscaler add-on version `1.0.7_940`.
:   For more information, see [the change log](/docs/containers?topic=containers-ca_changelog).

Ingress ALB version `1.3.1_3685_iks`, `1.4.0_3684_iks`, and `1.5.1_3683_iks`
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).


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
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).

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
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).



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
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).

ALB OAuth Proxy add-on version 2.0.0_1354
:   For more information, see the [change log](/docs/containers?topic=containers-alb-oauth-proxy-changelog).



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
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).



### 9 December 2022
{: #containers-dec0922}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.5` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).



### 8 December 2022
{: #containers-dec0822}
{: release-note}

Ingress ALB version `1.3.1_3192_iks` change log updates
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).




### 5 December 2022
{: #containers-dec0522}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.4` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

Ingress ALB version `1.2.1_3186_iks` change log updates
:   For more information, see the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog).

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
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for version `1.3.1_3108_iks`.





### 21 November 2022
{: #containers-nov2122}
{: release-note}



Worker node fix pack 1.22.16_1579, 1.23.14_1553, 1.24.8_1545, and 1.25.4_1523
:   For more information, see the change logs: [1.22.16_1579](/docs/containers?topic=containers-changelog_122), [1.23.14_1553](/docs/containers?topic=containers-changelog_123), [1.24.8_1545](/docs/containers?topic=containers-changelog_124), and [1.25.4_1523](/docs/containers?topic=containers-changelog_125).




### 17 November 2022
{: #containers-nov1722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on versions `4.4.13_1712` and `5.0.2_1713`
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).




### 16 November 2022
{: #containers-nov1622}
{: release-note}



ALB OAuth Proxy add-on version 2.0.0_1315
:   For more information, see the [change log](/docs/containers?topic=containers-alb-oauth-proxy-changelog).
  
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
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).



### 10 November 2022
{: #containers-nov1022}
{: release-note}

Istio add-on version `1.15.3`
:   For more information, see the [change log](/docs/containers?topic=containers-istio-changelog#1153).


### 9 November 2022
{: #containers-nov0922}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `4.4.12_1700` and `5.0.1_1695`
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).



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
:   Beginning with version `2.12` Portworx uses an operator-based deployment model instead of the Helm based model use in version `2.11` and earlier. If you want to update from Portworx `2.11` to version `2.12`, follow the migration steps in the [Portworx documentation](https://docs.portworx.com/operations/operate-kubernetes/migrate-daemonset/){: external}.

Cluster autoscaler add-on version `1.0.7_883`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

## October 2022
{: #containers-oct22}



### 31 October 2022
{: #containers-oct3122}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for version `1.3.0_2907_iks`.



### 27 October 2022
{: #containers-oct2722}
{: release-note}



ALB OAuth Proxy add-on version 2.0.0_1297
:   For more information, see the [change log](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

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
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.3.0_2847_iks`, `1.2.1_2809_iks`, and `1.1.2_2808_iks`.

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
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).




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
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.1_2646_iks` and `1.1.2_2645_iks`.

ALB OAuth Proxy add-on
:   Version 2.0.0_1265 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) is released. 



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
:   Kubernetes [1.21.14_1578](/docs/containers?topic=containers-changelog_121), [1.22.15_1573](/docs/containers?topic=containers-changelog_122), [1.23.12_1547](/docs/containers?topic=containers-changelog_123) and [1.24.6_1539](/docs/containers?topic=containers-changelog_124).




### 23 September 2022
{: #containers-sep2322}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version `4.4.11_1614`.
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).




### 22 September 2022
{: #containers-sep2222}
{: release-note}

Cluster autoscaler add-on versions `1.1.0_798`, `1.0.6_800`, and `1.0.5_779`.
:   For more information, see [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

{{site.data.keyword.block_storage_is_short}} add-on version `4.3.7_1613`.
:   For more information, see [the change log](/docs/containers?topic=containers-vpc_bs_changelog).


### 21 September 2022
{: #containers-sep2122}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.452.




Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.1_2558_iks` and `1.1.2_2586_iks`.




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
:   For more information, see [version 4.4.10_1578](/docs/containers?topic=containers-vpc_bs_changelog).

New! vGPU worker node flavors are now available for VPC Gen 2.
:   For more information about the available worker node flavors, see [VPC Gen 2 flavors](/docs/containers?topic=containers-vpc-flavors). Worker node flavors with vGPU support are the `gx2` flavor class, for example: `gx2.16x128.2v100`.

### 12 September 2022
{: #containers-sep1222}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.3.6_1579 is available.
:   For more information, see [version 4.3.6_1579](/docs/containers?topic=containers-vpc_bs_changelog)

{{site.data.keyword.cos_full_notm}} plug-in version `2.2.0` is available.
:   For more information, see the [change log](/docs/containers?topic=containers-cos_plugin_changelog).

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.446.



ALB OAuth Proxy add-on
:   Version 2.0.0_1214 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) is released. 

### 8 September 2022
{: #containers-sep0822}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.444.

### 7 September 2022
{: #containers-sep722}
{: release-note}

Master fix pack update
:   Kubernetes [1.24.4_1536](/docs/containers?topic=containers-changelog_124), [1.23.10_1544](/docs/containers?topic=containers-changelog_123), [1.22.13_1570](/docs/containers?topic=containers-changelog_122), and [1.21.14_1579](/docs/containers?topic=containers-changelog_121).


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
:   Kubernetes [1.21.14_1578](/docs/containers?topic=containers-changelog_121), [1.22.13_1568](/docs/containers?topic=containers-changelog_122), [1.23.10_1543](/docs/containers?topic=containers-changelog_123) and [1.24.4_1535](/docs/containers?topic=containers-changelog_124).


### 26 August 2022
{: #containers-aug2622}
{: release-note}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.439.

### 25 August 2022
{: #containers-aug2522}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.4.9_1566 is available.
:   For more information, see [version 4.4.9_1566](/docs/containers?topic=containers-vpc_bs_changelog)



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.1_2506_iks` and `1.1.2_2507_iks`.



### 24 August 2022
{: #containers-aug2422}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on version 4.3.5_1563 is available.

:   For more information, see [version 4.3.5_1563](/docs/containers?topic=containers-vpc_bs_changelog)

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
:   Kubernetes [1.21.14_1576](/docs/containers?topic=containers-changelog_121), [1.22.12_1566](/docs/containers?topic=containers-changelog_122), [1.23.9_1541](/docs/containers?topic=containers-changelog_123) and [1.24.3_1533](/docs/containers?topic=containers-changelog_124).


Istio add-on
:   Version [`1.14.3`](/docs/containers?topic=containers-istio-changelog#1143) and [`1.13.7`](/docs/containers?topic=containers-istio-changelog#1137) is available.


### 11 August 2022
{: #containers-aug1122}
{: release-note}

Dynamically provision {{site.data.keyword.cos_full_notm}} buckets with quotas enabled
:   [Follow the tutorial](/docs/containers?topic=containers-storage-cos-tutorial-quota) to set up the {{site.data.keyword.cos_full_notm}} plug-in to automatically set quotas on buckets that are provisioned with PVCs. 



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.1_2487_iks` and `1.1.2_2488_iks`.



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
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.1_2426_iks` and `1.1.2_2411_iks`.



### 1 August 2022
{: #containers-aug0122}
{: release-note}

Worker node fix pack
:   Kubernetes [1.21.14_1575](/docs/containers?topic=containers-changelog_121), [1.22.12_1565](/docs/containers?topic=containers-changelog_122), [1.23.9_1540](/docs/containers?topic=containers-changelog_123) and [1.24.3_1532](/docs/containers?topic=containers-changelog_124).



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
:   Kubernetes [1.24.3_1531](/docs/containers?topic=containers-changelog_124), [1.23.9_1539](/docs/containers?topic=containers-changelog_123), [1.22.12_1564](/docs/containers?topic=containers-changelog_122), and [1.21.14_1574](/docs/containers?topic=containers-changelog_121).



### 22 July 2022
{: #containers-july2222}
{: release-note}




Cluster autoscaler add-on
:   Version `1.1.0_729` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 19 July 2022
{: #containers-july1922}
{: release-note}



Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.1.2_2368_iks` and `1.2.1_2415_iks`.



Cluster autoscaler add-on
:   Version `1.0.5_728` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).



### 18 July 2022
{: #containers-july1822}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.3.4_1551](/docs/containers?topic=containers-vpc_bs_changelog) and [Version 4.4.8_1550](/docs/containers?topic=containers-vpc_bs_changelog) are available.

Worker node fix pack
:   Kubernetes [1.21.14_1572](/docs/containers?topic=containers-changelog_121), [1.22.11_1562](/docs/containers?topic=containers-changelog_122), [1.23.8_1537](/docs/containers?topic=containers-changelog_123) and [1.24.2_1529](/docs/containers?topic=containers-changelog_124).


### 15 July 2022
{: #containers-july1522}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.431.

Cluster autoscaler add-on
:   Versions `1.0.6_742` is available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

### 14 July 2022
{: #containers-july1422}

Cross-account encryption
:   You can now set up cross-account encryption. Note that this feature is available for allowlisted accounts only. For more infomration see, [Encrypting the Kubernetes secrets by using a KMS provider](/docs/containers?topic=containers-encryption#keyprotect).

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.18` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on.
:   Version [5.0.1-beta_1411](/docs/containers?topic=containers-vpc_bs_changelog) is available.



### 13 July 2022
{: #containers-july1322}

CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.430.





### 7 July 2022
{: #containers-july0722}
{: release-note} 
 
ALB OAuth Proxy add-on
:   Version 2.0.0_1187 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) is released. 




### 5 July 2022
{: #containers-july0522}
{: release-note}

Worker node fix pack
:   Kubernetes [1.21.14_1565](/docs/containers?topic=containers-changelog_121), [1.22.11_1557](/docs/containers?topic=containers-changelog_122), [1.23.8_1535](/docs/containers?topic=containers-changelog_123) and [1.24.2_1527](/docs/containers?topic=containers-changelog_124).


Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for version `1.1.2_2305_iks`. Version `0.49.3` is no longer supported.

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
:   [Version 4.4.6_1446](/docs/containers?topic=containers-vpc_bs_changelog) is available.

### 22 June 2022
{: #containers-jun2222}
{: release-note}

New! Portworx Cloud Drive support
:   You can now dynamically provision storage for Portworx during installation by using Portworx Cloud Drives. For more information, see [Getting started with Portworx](/docs/containers?topic=containers-portworx).




### 21 June 2022
{: #containers-jun2122}
{: release-note}

Istio add-on
:   Version [`1.13.5`](/docs/containers?topic=containers-istio-changelog#1135) and [`1.12.8`](/docs/containers?topic=containers-istio-changelog#1128) is available.




### 20 June 2022
{: #containers-jun2022}
{: release-note}

Worker node fix pack
:   Kubernetes [1.21.14_1564](/docs/containers?topic=containers-changelog_121), [1.22.11_1556](/docs/containers?topic=containers-changelog_122), [1.23.8_1534](/docs/containers?topic=containers-changelog_123) and [1.24.2_1526](/docs/containers?topic=containers-changelog_124).


### 17 June 2022
{: #containers-jun1722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version version 4.3.2_1441](/docs/containers?topic=containers-vpc_bs_changelog) is available.




### 16 June 2022
{: #containers-jun1622}
{: release-note}

Certified Kubernetes
:   Version [1.24](/docs/containers?topic=containers-cs_versions_124) release is now certified.

Version 1.20 is unsupported as of 19 June 2022
:   Update your cluster to a supported as soon as possible. For more information, see the 1.20 [release information](/docs/containers?topic=containers-cs_versions_120) and [change log](/docs/containers?topic=containers-changelog_120). For more information about the supported releases, see the [version information](/docs/containers?topic=containers-cs_versions).

Istio add-on
:   Version [`1.14.1`](/docs/containers?topic=containers-istio-changelog#1141) is available.




### 15 June 2022
{: #containers-jun1522}
{: release-note}

{{site.data.keyword.mon_full_notm}} metrics and label updates
:   Metrics and labels are now stored and displayed in a Prometheus compatible naming convention. Some metrics and labels are deprecated. For more information, see [Discontinued Metrics and Labels](https://docs.sysdig.com/en/docs/release-notes/enhanced-metric-store/#discontinued-metrics-and-labels){: external} and [removed features](https://docs.sysdig.com/en/docs/release-notes/enhanced-metric-store/#removed-featurees){: external}.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version version 5.0.1-beta_1411](/docs/containers?topic=containers-vpc_bs_changelog) is available for allowlisted accounts.




### 13 June 2022
{: #containers-jun1322}
{: release-note}


{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.4.5_1371](/docs/containers?topic=containers-vpc_bs_changelog) is available.



### 10 June 2022
{: #containers-jun1022}
{: release-note}

{{site.data.keyword.loganalysisshort}} and {{site.data.keyword.at_full_notm}} changes
:   {{site.data.keyword.containerlong_notm}} clusters running in Washington, D.C. (`us-east`) now send logs to {{site.data.keyword.loganalysisshort}} and {{site.data.keyword.at_full_notm}} instances in the same region, Washington, D.C. (`us-east`). For more information, see [{{site.data.keyword.at_full_notm}}](/docs/containers?topic=containers-at_events).

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for version `1.2.1_2337_iks`.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 5.0.0-beta_1125](/docs/containers?topic=containers-vpc_bs_changelog) is available for allowlisted accounts.

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
:   Kubernetes [1.20.15_1583](/docs/containers?topic=containers-changelog_120), [1.21.13_1562](/docs/containers?topic=containers-changelog_121), [1.22.10_1554](/docs/containers?topic=containers-changelog_122), [1.23.7_1532](/docs/containers?topic=containers-changelog_123).


### 3 June 2022
{: #containers-jun322}
{: release-note}

Master fix pack update
:   Kubernetes [1.23.7_1531](/docs/containers?topic=containers-changelog_123), [1.22.10_1553](/docs/containers?topic=containers-changelog_122), [1.21.13_1561](/docs/containers?topic=containers-changelog_121), and [1.20.15_1582](/docs/containers?topic=containers-changelog_120).




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
:   [Version 4.3.0_1163](/docs/containers?topic=containers-vpc_bs_changelog) is available.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.6_1161](/docs/containers?topic=containers-vpc_bs_changelog) is available.

### 20 May 2022
{: #containers-may2022}
{: release-note}

Worker node fix pack
:   Kubernetes [1.20.15_1581](/docs/containers?topic=containers-changelog_120), [1.21.12_1560](/docs/containers?topic=containers-changelog_121), [1.22.9_1552](/docs/containers?topic=containers-changelog_122), [1.23.6_1530](/docs/containers?topic=containers-changelog_123).


### 19 May 2022
{: #containers-may1922}
{: release-note}

Istio add-on
:   Version [`1.12.7`](/docs/containers?topic=containers-istio-changelog#1127) is available.

Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.0_2251_iks`, `1.1.2_2252_iks`, and `0.49.3_2253_iks`.


### 16 May 2022
{: #containers-may1622}
{: release-note}

Cluster autoscaler add-on
:   Versions `1.0.5_628` and `1.1.0_615` are available. See [Cluster autoscaler add-on change log](/docs/containers?topic=containers-ca_changelog).

ALB OAuth Proxy add-on
:   Verion 1.0.0 is no longer supported. For more information, see the [change log](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

### 12 May 2022
{: #containers-may1222}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.5_1106](/docs/containers?topic=containers-vpc_bs_changelog) is available.

### 9 May 2022
{: #containers-may0922}
{: release-note}

Worker node fix pack
:   Kubernetes [1.20.15_1580](/docs/containers?topic=containers-changelog_120), [1.21.12_1559](/docs/containers?topic=containers-changelog_121), [1.22.9_1551](/docs/containers?topic=containers-changelog_122), [1.23.6_1529](/docs/containers?topic=containers-changelog_123).



### 6 May 2022
{: #containers-may0622}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.15` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

### 4 May 2022
{: #containers-may0422}
{: release-note}

  
ALB OAuth Proxy add-on
:   Version 2.0.0_1064 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) is released.
Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.2.0_2147_iks`, `1.1.2_2146_iks`, and `0.49.3_2145_iks`.




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
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.404.



Cluster security groups
:   You can now specify up to five security groups to attach to workers when you create a VPC cluster. For more information, see [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group&interface=ui#vpc-sg-cluster-workers).

### 26 April 2022
{: #containers-apr2622}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog) for version `1.2.0_2131_iks`. Version `1.1.1` is no longer available.


CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.403.

### 25 April 2022
{: #containers-apr2522}  
{: release-note}

Worker node fix pack
:   Kubernetes [1.23.6_1528](/docs/containers?topic=containers-changelog_123), [1.22.9_1550](/docs/containers?topic=containers-changelog_122), [1.21.12_1558](/docs/containers?topic=containers-changelog_121), [1.20.15_1579](/docs/containers?topic=containers-changelog_120).




  
### 21 April 2022
{: #containers-apr2122}  
{: release-note}
  
Ingress ALB change log updates
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.1.2_2121_iks`, `1.1.1_2119_iks`, and `0.49.3_2120_iks`.
  




### 19 April 2022
{: #containers-apr1922}

Istio add-on
:   Version [`1.12.6`](/docs/containers?topic=containers-istio-changelog#1126) is available. 

### 13 April 2022
{: #containers-apr1322}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.14` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

### 12 April 2022
{: #containers-apr1222}



Create and manage dedicated hosts in VPC Gen 2.
:   You can now create clusters on dedicated hosts in VPC Gen 2. Note that support for dedicated hosts is available only for allowlisted accounts. For more information, see [Creating and managing dedicated hosts](/docs/openshift?topic=openshift-dedicated-hosts).

  
### 11 April 2022
{: #containers-apr1122}



New! {{site.data.keyword.secrets-manager_full}}
:   With the deprecation of {{site.data.keyword.cloudcerts_long}}, you can now manage certificates and secrets with {{site.data.keyword.secrets-manager_full}}. You can integrate your own {{site.data.keyword.secrets-manager_short}} instances with your Kubernetes clusters. {{site.data.keyword.secrets-manager_short}} instances can be used across multiple clusters, and a single cluster can have more than one instance. For more information, see [Migrating from IBM Cloud Certificate Manager to IBM Cloud {{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-certs-mgr-migration).



{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.3_983](/docs/containers?topic=containers-vpc_bs_changelog) is available.

Worker node fix pack
:   Kubernetes [1.23.5_1526](/docs/containers?topic=containers-changelog_123), [1.22.8_1548](/docs/containers?topic=containers-changelog_122), [1.21.11_1556](/docs/containers?topic=containers-changelog_121), [1.20.15_1577](/docs/containers?topic=containers-changelog_120).





### 7 April 2022
{: #containers-apr0722}

{{site.data.keyword.containerlong_notm}} clusters in Mexico City (MEX01) are deprecated and become unsupported later this year. 
:   To prevent any interruption of service, [redeploy your cluster workloads](/docs/containers?topic=containers-update_app#copy_apps_cluster) to a [supported data center](/docs/containers?topic=containers-regions-and-zones#zones-mz) and remove your MEX01 clusters by 31 October 2022. Clusters remaining in these data centers after 31 October 2022 will be removed. You cannot create clusters in this location after 07 May 2022. For more information about data center closures and recommended data centers, see [Data center consolidations](/docs/get-support?topic=get-support-dc-closure).


Ingress ALB change log updates
:   Updated the [Ingress ALB change log](/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.1.2_2084_iks`, `1.1.1_2085_iks`, and `0.49.3_2083_iks`.




CLI change log update
:   The [CLI change log](/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.394.

### 6 April 2022
{: #containers-apr0622}}

Master fix pack update
:   Kubernetes [1.23.5_1525](/docs/containers?topic=containers-changelog_123), [1.22.8_1547](/docs/containers?topic=containers-changelog_122), [1.21.11_1555](/docs/containers?topic=containers-changelog_121), and [1.20.15_1576](/docs/containers?topic=containers-changelog_120).






## March 2022
{: #containers-mar22}

### 30 March 2022
{: #containers-mar3022}
{: release-note}

Cluster autoscaler add-on
:   Version [1.1.0_475](/docs/containers?topic=containers-ca_changelog) is available.

{{site.data.keyword.containershort}} 1.20 end of support date change
:   The end of support date of {{site.data.keyword.containershort}} 1.20 is now 15 June 2022. The [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions#cs_versions_available) page has been updated with the new date. 

Master fix pack update
:   Kubernetes [1.23.5_1523](/docs/containers?topic=containers-changelog_123#1235_1523), [1.22.8_1545](/docs/containers?topic=containers-changelog_122#1228_1545), [1.21.11_1553](/docs/containers?topic=containers-changelog_121#12111_1553), and [1.20.15_1574](/docs/containers?topic=containers-changelog_120#12015_1574).

### 28 March 2022
{: #containers-mar2822}
{: release-note}

Worker node fix pack update.
:   Kubernetes [1.23.5_1524](/docs/containers?topic=containers-changelog_123), [1.22.8_1546](/docs/containers?topic=containers-changelog_122), [1.21.11_1552](/docs/containers?topic=containers-changelog_121), [1.20.15_1575](/docs/containers?topic=containers-changelog_120), and [1.19.16_1579](/docs/containers?topic=containers-changelog_119).


### 24 March 2022
{: #containers-mar2422}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.13` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.2_900](/docs/containers?topic=containers-vpc_bs_changelog) is available.

  
ALB OAuth Proxy add-on
:   Versions 1.0.0_1024 and 2.0.0_1023 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) are released.



### 22 March 2022
{: #containers-mar2222}
{: release-note}

Hong Kong (`HKG02`) and Seoul (`SEO01`) are deprecated and become unsupported later this year.
:   To prevent any interruption of service, [redeploy your cluster workloads](/docs/containers?topic=containers-update_app#copy_apps_cluster) to a [supported data center](/docs/containers?topic=containers-regions-and-zones#zones-mz) and remove your Hong Kong (`HKG02`) and Seoul (`SEO01`) clusters by 28 September 2022. Clusters remaining in these data centers after 28 September 2022 will be removed. Cluster creation in these locations will be stopped on 29 April 2022. For more information about data center closures and recommended data centers, see [Data center consolidations](/docs/get-support?topic=get-support-dc-closure).

Ingress ALB change log updates
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `1.1.2_2050_iks`, `1.1.1_1996_iks`, and `0.49.3_1994_iks`.

Istio add-on
:   Versions [`1.13.2`](/docs/containers?topic=containers-istio-changelog#1132), [`1.12.5`](/docs/containers?topic=containers-istio-changelog#1125), and [`1.11.8`](/docs/containers?topic=containers-istio-changelog#1118) are available. Note that this is the final update for version 1.11. 


### 21 March 2022
{: #containers-mar2122}
{: release-note}

CLI change log update
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.384.

### 17 March 2022
{: #containers-mar1722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2.1_895](/docs/containers?topic=containers-vpc_bs_changelog) is available.


  
### 16 March 2022
{: #containers-mar1622}
{: release-note}

Cluster autoscaler add-on
:   Version [1.1.0_429](/docs/containers?topic=containers-ca_changelog) is available.

### 15 March 2022
{: #containers-mar1522}
{: release-note}

Version 1.19 unsupported 
:   Clusters that run version 1.19 are unsupported. Update your clusters to at least [version 1.20](/docs/containers?topic=containers-cs_versions_120) as soon as possible.


### 14 March 2022
{: #containers-mar1422}
{: release-note}


Worker node fix pack update.
:   Kubernetes [1.23.4_1522](/docs/containers?topic=containers-changelog_123), [1.22.7_1543](/docs/containers?topic=containers-changelog_122), [1.21.10_1552](/docs/containers?topic=containers-changelog_121), [1.20.15_1573](/docs/containers?topic=containers-changelog_120), and [1.19.16_1579](/docs/containers?topic=containers-changelog_119).




### 11 March 2022
{: #containers-mar1122}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.12` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).



### 9 March 2022
{: #containers-mar922}
{: release-note}

Istio add-on
:   [Version `1.13.1`](/docs/containers?topic=containers-istio-changelog#1131) is available.




### 8 March 2022
{: #containers-mar822}
{: release-note}

Master fix pack update.
:   Kubernetes [1.23.4_1520](/docs/containers?topic=containers-changelog_123#1234_1520), [1.22.7_1541](/docs/containers?topic=containers-changelog_122#1227_1541), [1.21.10_1550](/docs/containers?topic=containers-changelog_121#12110_1550), [1.20.15_1571](/docs/containers?topic=containers-changelog_120#12015_1571), and [1.19.16_1578](/docs/containers?topic=containers-changelog_119#11916_1578).




Istio add-on
:   [Version `1.12.4`](/docs/containers?topic=containers-istio-changelog#1124) and [Version `1.11.7`](/docs/containers?topic=containers-istio-changelog#1117) of the managed Istio add-on are available. 





### 3 March 2022
{: #containers-mar322}
{: release-note}


{{site.data.keyword.containershort}} default version update.
:   [1.22](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.

Maintenance Windows for {{site.data.keyword.containershort}} ALBs
:   You can now further control and manage your ALB updates by [creating a customized ConfigMap](/docs/containers?topic=containers-ingress-alb-manage#alb-scheduled-updates) that specifies the time you want the updates to occur and the percentage of ALBs you want to update.



## February 2022
{: #containers-feb22}

### 28 February 2022
{: #containers-feb2822}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.2](/docs/containers?topic=containers-vpc_bs_changelog) is available.

Cluster autoscaler
:   Version [1.0.5_415](/docs/containers?topic=containers-ca_changelog) is available.
:   New pages for [Preparing your cluster for autoscaling](/docs/openshift?topic=openshift-cluster-scaling-classic-vpc), [Installing the cluster autoscaler add-on](/docs/containers?topic=containers-cluster-scaling-install-addon), and [Enabling autoscaling](/docs/containers?topic=containers-cluster-scaling-enable).
:   New troubleshooting pages for [resizing worker pools](/docs/containers?topic=containers-ts-ca-resize) and updating [unbalanced worker pools](/docs/containers?topic=containers-ts-ca-unbalanced) in autoscaled clusters. 


  
ALB OAuth Proxy add-on
:   Versions 1.0.0_1001 and 2.0.0_999 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) are released.


Worker node fix pack
:   Kubernetes [1.23.4_1521](/docs/containers?topic=containers-changelog_123#1234_1521), [1.22.7_1542](/docs/containers?topic=containers-changelog_122#1227_1542), [1.21.10_1551](/docs/containers?topic=containers-changelog_121#12110_1551), [1.20.15_1572](/docs/containers?topic=containers-changelog_120#12015_1572), and [1.19.16_1579](/docs/containers?topic=containers-changelog_119#11916_1579).


### 24 February 2022
{: #containers-feb2422}
{: release-note}


Container service CLI 
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.374.



Kubernetes Ingress image
:   Versions 1.1.1_1996_iks, 1.0.3_1995_iks, and 0.49.3_1994_iks of the [Kubernetes Ingress image](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) are released.






### 23 February 2022
{: #containers-feb2322}
{: release-note}

Cluster autoscaler
:   Version [1.0.4_410](/docs/containers?topic=containers-ca_changelog) is available.



Istio add-on
:   [Version `1.12.3`](/docs/containers?topic=containers-istio-changelog#1116) of the managed Istio add-on is available. 




### 18 February 2022
{: #containers-feb1822}
{: release-note}

Container service CLI 
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.372.


### 17 February 2022
{: #containers-feb1722}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.10` of the {{site.data.keyword.cos_full_notm}} plug-in [is available](/docs/containers?topic=containers-cos_plugin_changelog).




  
### 15 February 2022
{: #containers-feb1522}
{: release-note}

Istio add-on
:   [Version `1.11.6`](/docs/containers?topic=containers-istio-changelog#1116) of the managed Istio add-on is available. 



### 14 February 2022
{: #containers-feb1422}
{: release-note}

Worker node fix pack
:   Kubernetes [1.23.3_1519](/docs/containers?topic=containers-changelog_123#1233_1519), [1.22.6_1539](/docs/containers?topic=containers-changelog_122#1226_1539), [1.21.9_1549](/docs/containers?topic=containers-changelog_121#1219_1549), [1.20.15_1570](/docs/containers?topic=containers-changelog_120#12015_1570), and [1.19.16_1577](/docs/containers?topic=containers-changelog_119#11916_1577).


{{site.data.keyword.cos_full_notm}} doc restructuring. 
:   For more information, see [Storing data on {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-storage-cos-understand), [Installing the {{site.data.keyword.cos_full_notm}} plug-in](/docs/containers?topic=containers-storage_cos_install), [Setting up authorized IP addresses for {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-storage_cos_vpc_ip), [Adding {{site.data.keyword.cos_full_notm}} storage to apps](/docs/containers?topic=containers-storage_cos_apps), and [Storage class reference](/docs/containers?topic=containers-storage_cos_reference).


{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.1.3_846](/docs/containers?topic=containers-vpc_bs_changelog) is released.


### 10 February 2022
{: #containers-feb1022}
{: release-note}


Certified Kubernetes
:   Version [1.23](/docs/containers?topic=containers-cs_versions_123) release is now certified.


  
ALB OAuth Proxy add-on
:   Version 2.0.0_981 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) is released.




### 9 February 2022
{: #containers-feb922}
{: release-note}




New! Kubernetes 1.23
:   You can create or [update clusters to Kubernetes version 1.23](/docs/containers?topic=containers-cs_versions_123). With Kubernetes 1.23, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product. 

Deprecated and unsupported Kubernetes versions
:   With the release of Kubernetes 1.23, clusters that run version 1.20 remain deprecated, with a tentative unsupported date of May 2022. Update your cluster to at least [version 1.21](/docs/containers?topic=containers-cs_versions_121) as soon as possible.




  


### 3 February 2022
{: #containers-feb322}
{: release-note}

Istio add-on
:   [Version `1.12.2`](/docs/containers?topic=containers-istio-changelog#1122) of the managed Istio add-on is available. 





## January 2022
{: #containers-jan22}

### 31 January 2022
{: #containers-jan3122}

Version change log
:   Fix pack update.
:   Kubernetes [1.22.6_1538](/docs/containers?topic=containers-changelog_122#1226_1538), [1.21.9_1548](/docs/containers?topic=containers-changelog_121#1219_1548), [1.20.15_1569](/docs/containers?topic=containers-changelog_120#12015_1569), [1.19.16_1576](/docs/containers?topic=containers-changelog_119#11916_1576).



**New!** Worker node flavor reference
:   View a list of all available worker node flavors by zone. For more information, see [VPC Gen 2 flavors](/docs/containers?topic=containers-classic-flavors) or [Classic flavors](/docs/containers?topic=containers-vpc-flavors).



### 27 January 2022
{: #containers-jan2722}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.1.2_834](/docs/containers?topic=containers-vpc_bs_changelog) is released.

**New!** Gathering Ingress logs
:   When troubleshooting Ingress, follow the steps in [gathering Ingress logs](/docs/openshift?topic=openshift-ingress-must-gather) to retrieve useful debugging information.





### 26 January 2022
{: #containers-jan2622}
{: release-note}

ALB OAuth Proxy add-on
:   Versions 1.0.0_924 and 2.0.0_923 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) are released.



### 25 January 2022
{: #containers-jan2522}
{: release-note}


Kubernetes Ingress image
:   Versions 1.1.1_1949_iks, 1.0.3_1933_iks, and 0.49.3_1941_iks of the [Kubernetes Ingress image](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) are released.
  
Kubernetes Ingress annotations
:   Clusters created on or after 31 January 2022 by default no longer support server-snippet annotations in Ingress resources for the managed Kubernetes Ingress Controller (ALB). All new clusters are deployed with the `allow-server-snippets` configuration set to `false`, which prevents the ALB from correctly processing Ingress resources with the offending annotations. You must edit the ConfigMap manually to change this setting in order for the add-on to work.



### 24 January 2022
{: #containers-jan2422}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.9` of the {{site.data.keyword.cos_full_notm}} plug-in is released. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).


### 20 January 2022
{: #containers-jan2022}
{: release-note}

Cluster autoscaler add-on.
:   [Version 1.0.4_403](/docs/containers?topic=containers-ca_changelog) is released.

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.1.1_827](/docs/containers?topic=containers-vpc_bs_changelog) is released.

OpenShift Data Foundation
:   New and updated parameters for OpenShift Data Foundation.
:   Automatic disk discovery is now available for Classic clusters version 4.8 and later. Enable this feature by setting the `autoDiscoverDevices` parameter to `true` parameter. For more information, see [ODF using local disks](/docs/openshift?topic=openshift-deploy-odf-classic).
:   The `monDevicePaths` and `monSize` parameters are no longer required for add-on version 4.8 and later.



### 18 January 2022
{: #containers-jan1822}
{: release-note}

Review the release notes for January 2022.
{: shortdesc}

**New!** {{site.data.keyword.containerlong_notm}} CLI Map
:   The [{{site.data.keyword.containerlong_notm}} CLI Map](/docs/containers?topic=containers-icks_map) lists all `ibmcloud ks` commands as they are structured in the CLI. Use this page as a visual reference for how ibmcloud ks commands are organized, or to quickly find a specific command. 

{{site.data.keyword.containershort}} 1.19, 1.20, 1.21, and 1.22 unsupported date change
:   The [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions#cs_versions_available) page has been updated with the new unsupported dates. 

Worker node fix pack update.
:   Kubernetes [1.22.4_1536](/docs/containers?topic=containers-changelog_122#1224_1536), [1.21.7_1546](/docs/containers?topic=containers-changelog_121#1217_1546), [1.20.13_1567](/docs/containers?topic=containers-changelog_120#12013_1567), and [1.19.16_1574](/docs/containers?topic=containers-changelog_119#11916_1574).



### 17 January 2022
{: #containers-jan1722}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.8` of the {{site.data.keyword.cos_full_notm}} plug-in is released. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).



### 13 January 2022
{: #containers-jan1321}
{: release-note}

Istio add-on
:   [Version `1.12.1`](/docs/containers?topic=containers-istio-changelog#1121) and [Version `1.10.6`](/docs/containers?topic=containers-istio-changelog#1106) of the Istio managed add-on are released.






### 06 January 2022
{: #containers-jan0622}
{: release-note}


{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.1.0_807](/docs/containers?topic=containers-vpc_bs_changelog) is released.


{{site.data.keyword.containershort}} 1.20 end of support date change
:   The end of support date of {{site.data.keyword.containershort}} 1.20 is now March 2022. The [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions#cs_versions_available) page has been updated with the new date. 


### 4 January 2022
{: #containers-jan422}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for worker node versions [`1.22.4_1534`](/docs/containers?topic=containers-changelog_122#1224_1534), [`1.21.7_1544`](/docs/containers?topic=containers-changelog_121#1217_1544), [`1.20.13_1566`](/docs/containers?topic=containers-changelog_120#12013_1566), and [`1.19.16_1573`](/docs/containers?topic=containers-changelog_119#11916_1573).

## December 2021
{: #containers-dec21}

Review the release notes for December 2021.
{: shortdesc}

### 20 December 2021
{: #containers-dec2021}
{: release-note}





  
Deprecated and unsupported Kubernetes versions
:   Clusters that run version 1.19 are deprecated, with a tentative unsupported date of 31 Jan 2022. Update your clusters to at least [version 1.20](/docs/containers?topic=containers-cs_versions_120) as soon as possible.


### 14 December 2021
{: #containers-dec1421}
{: release-note}


Istio add-on
:   [Version `1.11.5`](/docs/containers?topic=containers-istio-changelog#1115) of the Istio managed add-on is released.



### 7 December 2021
{: #containers-dec721}
{: release-note}



Istio add-on
:   [Version `1.12`](/docs/containers?topic=containers-istio-changelog#1102) of the Istio managed add-on is released.

Master fix pack update
:   Changelog documentation is available for version [`1.22.4_1531`](/docs/containers?topic=containers-changelog_122#1224_1531), [`1.21.7_1541`](/docs/containers?topic=containers-changelog_121#1217_1541), [`1.20.13_1563`](/docs/containers?topic=containers-changelog_120#12013_1563), and [`1.19.16_1570`](/docs/containers?topic=containers-changelog_119#11916_1570).



### 6 December 2021
{: #containers-dec621}
{: release-note}



Worker node fix pack update
:   Changelog documentation is available for version [`1.22.4_1532`](/docs/containers?topic=containers-changelog_122#1224_1532), [`1.21.7_1542`](/docs/containers?topic=containers-changelog_121#1217_1542), [`1.20.13_1564`](/docs/containers?topic=containers-changelog_120#12013_1564), and [`1.19.16_1571`](/docs/containers?topic=containers-changelog_119#11916_1571).



### 2 December 2021
{: #containers-dec221}
{: release-note}



{{site.data.keyword.containershort}} default version update.
:   [1.21](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.




## November 2021
{: #containers-nov21}

Review the release notes for November 2021.
{: shortdesc}


### 29 November 2021
{: #containers-nov2921}
{: release-note}

Container service CLI 
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.347.



### 22 November 2021
{: #containers-nov2221}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for version [`1.22.3_1530`](/docs/containers?topic=containers-changelog_122#1223_1530), [`1.21.6_1540`](/docs/containers?topic=containers-changelog_121#1216_1540), [`1.20.12_1562`](/docs/containers?topic=containers-changelog_120#12012_1562), and [`1.19.16_1569`](/docs/containers?topic=containers-changelog_119#11916_1569).

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.0.3_793](/docs/containers?topic=containers-vpc_bs_changelog) is released.

Cluster autoscaler add-on.
:   [Version 1.0.4_387](/docs/containers?topic=containers-ca_changelog) is released.


### 19 November 2021
{: #containers-nov1921}
{: release-note}



ALB OAuth Proxy add-on
:   Versions 1.0.0_756 and 2.0.0_755 of the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog) are released.

Kubernetes Ingress image
:   Versions `1.0.3_1730_iks` and `0.49.3_1830_iks` of the [Kubernetes Ingress image](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) are released.



### 18 November 2021
{: #containers-nov1821}
{: release-note}

{{site.data.keyword.cloudaccesstraillong_notm}} and {{site.data.keyword.at_full_notm}}
:   Previously, clusters running in Toronto (`ca-tor`) sent logs to Washington D.C., and clusters running in Osaka (`jp-osa`) or Sydney (`au-syd`) sent logs to Tokyo. Beginning 18 November 2021, all instances of Log Analysis and Activity Tracker that are used for clusters running in Osaka (`jp-osa`), Toronto (`ca-tor`), and Sydney (`au-syd`) send logs to their respective regions. To continue receiving logs for clusters in these regions, you must create instances of {{site.data.keyword.cloudaccesstraillong_notm}} and {{site.data.keyword.at_full_notm}} in the same region as your cluster. If you already have instances in these regions, look for logs in those instances.

{{site.data.keyword.cos_full_notm}}
:   Version 2.1.7 of the [{{site.data.keyword.cos_full_notm}} plug-in](/docs/containers?topic=containers-cos_plugin_changelog) is released.

  
### 17 November 2021
{: #containers-nov1721}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for version [`1.22.3_1529`](/docs/containers?topic=containers-changelog_122#1223_1529), [`1.21.6_1539`](/docs/containers?topic=containers-changelog_121#1216_1539), [`1.20.12_1561`](/docs/containers?topic=containers-changelog_120#12012_1561), and [`1.19.16_1568`](/docs/containers?topic=containers-changelog_119#11916_1568).


### 15 November 2021
{: #containers-nov1521}
{: release-note}

CLI changelog
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.344. 

### 12 November 2021
{: #containers-nov1221}
{: release-note}

Master fix pack updates
:   Changelog documentation is available for version  [`1.22.2_1526`](/docs/containers?topic=containers-changelog_122#1222_1526), [`1.21.5_1536`](/docs/containers?topic=containers-changelog_121#1215_1536), [`1.20.11_1558`](/docs/containers?topic=containers-changelog_120#12011_1558), and [`1.19.15_1565`](/docs/containers?topic=containers-changelog_119#11915_1565).

### 10 November 2021
{: #containers-nov1021}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for version [`1.22.2_1528`](/docs/containers?topic=containers-changelog_122#1222_1528), [`1.21.5_1538`](/docs/containers?topic=containers-changelog_121#1215_1538), [`1.20.11_1560`](/docs/containers?topic=containers-changelog_120#12011_1560), and [`1.19.15_1567`](/docs/containers?topic=containers-changelog_119#11915_1567).

### 8 November 2021
{: #containers-nov821}
{: release-note}

Update commands to use `docker build`
:   Updates commands that use `cr build` to use `docker build` instead. 


### 4 November 2021
{: #containers-nov421}
{: release-note}

IAM trusted profiles for pod authorization
:   Updates for pod authorization with IAM trusted profiles. Authorizing pods with IAM trusted profiles is available for clusters that run version 1.21 or later. Note that for new clusters, authorizing pods with IAM trusted profiles is enabled automatically. You can enable IAM trusted profiles on existing clusters by running [`ibmcloud ks cluster master refresh`](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). For more information, see [Authorizing pods in your cluster to IBM Cloud services with IAM trusted profiles](/docs/containers?topic=containers-pod-iam-identity).


### 2 November 2021
{: #containers-nov221}
{: release-note}

Istio add-on change log
:   [Version `1.11.4`](/docs/containers?topic=containers-istio-changelog#1114) of the Istio managed add-on is released.



## October 2021
{: #containers-oct21}

Review the release notes for October 2021.
{: shortdesc}

### 28 October 2021
{: #containers-oct2821}
{: release-note}

Istio add-on change log
:   [Version `1.10.5`](/docs/containers?topic=containers-istio-changelog#1105) of the Istio managed add-on is released.

### 26 October 2021
{: #containers-oct2621}
{: release-note}

CLI changelog
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.334. 

### 25 October 2021
{: #containers-oct2521}
{: release-note}

Worker node fix pack update
:   Changelog documentation is available for version [`1.22.2_1527`](/docs/containers?topic=containers-changelog_122#1222_1527), [`1.21.5_1537`](/docs/containers?topic=containers-changelog_121#1215_1537), [`1.20.11_1559`](/docs/containers?topic=containers-changelog_120#12011_1559), and [`1.19.15_1566`](/docs/containers?topic=containers-changelog_119#11915_1566).

### 22 October 2021
{: #containers-oct2221}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in.
:   [Version 2.1.6](/docs/containers?topic=containers-cos_plugin_changelog) is released.

### 19 October 2021
{: #containers-oct1921}
{: release-note}

Ingress ALB change log updates
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog) for versions `0.49.3_1745_iks` and `1.0.3_1730_iks`.

### 18 October 2021
{: #containers-oct1821}
{: release-note}

New troubleshooting topic
:   See [Why does my cluster master status say it is approaching its resource limit?](/docs/containers?topic=containers-master_resource_limit). 



### 13 October 2021
{: #containers-oct1321}
{: release-note}

CLI changelog
:   The [CLI change log(/docs/containers?topic=containers-cs_cli_changelog) is updated for version 1.0.331. 

### 11 October 2021
{: #containers-oct1121}
{: release-note}



Unsupported Kubernetes version 1.18
:   Kubernetes version 1.18 is unsupported. To continue receiving important security updates and support, you must [update your cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately. 



Worker node fix pack update
:   Changelog documentation is available for version [`1.22.2_1524`](/docs/containers?topic=containers-changelog_122#1222_1524), [`1.21.5_1533`](/docs/containers?topic=containers-changelog_121#1215_1533), [`1.20.11_1555`](/docs/containers?topic=containers-changelog_120#12011_1555), and [`1.19.15_1562`](/docs/containers?topic=containers-changelog_119#11915_1562).

### 7 October 2021
{: #containers-oct721}
{: release-note}

Istio add-on change log
:   [Version `1.11.3`](/docs/containers?topic=containers-istio-changelog#1113) of the Istio managed add-on is released.

Cluster autoscaler add-on.
:   [Version 1.0.4](/docs/containers?topic=containers-ca_changelog) is released.



### 6 October 2021
{: #containers-oct621}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on.
:   [Version 4.0.1_780](/docs/containers?topic=containers-vpc_bs_changelog) is released.


### 5 October 2021
{: #containers-oct521}
{: release-note}

Updated supported, deprecated, and unsupported versions for strongSwan Helm chart.
:   [Upgrading or disabling the strongSwan Helm chart](/docs/containers?topic=containers-vpn#vpn_upgrade)



{{site.data.keyword.cos_full_notm}} plug-in.
:   [Version 2.1.5](/docs/containers?topic=containers-cos_plugin_changelog) is released.


## September 2021
{: #containers-sep21}

Review the release notes for September 2021.
{: shortdesc}

### 29 September 2021
{: #containers-sep2921}
{: release-note}



New! Kubernetes 1.22
:   You can create or [update clusters to Kubernetes version 1.22](/docs/containers?topic=containers-cs_versions_122). With Kubernetes 1.22, you get the latest stable enhancements from the Kubernetes community as well as enhancements to the {{site.data.keyword.cloud_notm}} product. For more information, [see the blog announcement](https://www.ibm.com/cloud/blog/announcements/kubernetes-version-121-now-available-in-ibm-cloud-kubernetes-service){: external}.

Deprecated and unsupported Kubernetes versions
:   With the release of Kubernetes 1.22, clusters that run version 1.18 remain deprecated, with a tentative unsupported date of 10 Oct 2021. Update your cluster to at least [version 1.20](/docs/containers?topic=containers-cs_versions_120) as soon as possible.

Master fix pack and worker node fix pack update
:   Change log documentation is available for Kubernetes version [`1.22.2_1522` and `1.22.2_1523`](/docs/containers?topic=containers-changelog_122#1222_1522_and_1222_1523).





### 27 September 2021
{: #containers-sep2721}
{: release-note}

Master fix pack update
:   Change log documentation is available for version [`1.21.5_1531`](/docs/containers?topic=containers-changelog_121#1215_1531), [`1.20.11_1553`](/docs/containers?topic=containers-changelog_120#12011_1553), [`1.19.15_1560`](/docs/containers?topic=containers-changelog_119#11915_1560), [`1.18.20_1565`](/docs/containers?topic=containers-118_changelog#11820_1565).


Worker node fix pack update
:   Change log documentation is available for version [`1.18.20_1566`](/docs/containers?topic=containers-118_changelog#11820_1566), [`1.19.15_1561`](/docs/containers?topic=containers-changelog_119#11915_1561), [`12011_1554`](/docs/containers?topic=containers-changelog_120#12011_1554), and [`1.21.5_1532`](/docs/containers?topic=containers-changelog_121#1215_1532).

### 23 September 2021
{: #containers-sep2321}
{: release-note}

Review the release notes for 23 September 2021.
{: shortdesc}

Istio add-on change log
:   [Version `1.11.2`](/docs/containers?topic=containers-istio-changelog#1112) of the Istio managed add-on is released.

### 22 September 2021
{: #containers-sep2221}
{: release-note}

Review the release notes for 22 September 2021.
{: shortdesc}

Ingress ALB version change log
:   [Version `1.0.0_1699_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#1_0_0) is now available. Updates for versions [`0.48.1_1698_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_48_0) and [`0.43.0_1697_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_47_0) are available in the change log. 




### 16 September 2021
{: #containers-sep1621}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on  
:   Version [`4.0.0_769`](/docs/containers?topic=containers-vpc_bs_changelog) is available.




### 14 September 2021
{: #containers-sep1421}
{: release-note}

Review the release notes for 14 September 2021.
{: shortdesc}

Ingress ALB version change log
:   [Version `1.0.0_1645_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#1_0_0) is now available. Updates for versions [`0.48.1_1613_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_48_0) and [`0.47.0_1614_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_47_0) are available in the change log. 

Istio add-on change log
:   [Version `1.10.4`](/docs/containers?topic=containers-istio-changelog#1104) and [version `1.9.8`](/docs/containers?topic=containers-istio-changelog#198) of the Istio managed add-on is released.


### 13 September 2021
{: #containers-sep1321}
{: release-note}

Worker node fix pack update
:   Change log documentation is available for version [`1.18.20_1564`](/docs/containers?topic=containers-118_changelog#11820_1564), [`1.19.14_1559`](/docs/containers?topic=containers-changelog_119#11914_1559), [`1.20.10_1552`](/docs/containers?topic=containers-changelog_120#12010_1552), and [`1.21.4_1530`](/docs/containers?topic=containers-changelog_121#12104_1530).

### 9 September 2021
{: #containers-sep921}
{: release-note}

Ingress ALB changelog
:   Updated the [change log](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1613_iks`, `0.47.0_1614_iks`, and `0.43.0_1612_iks`.



### 1 September 2021
{: #containers-sep121}
{: release-note}

Review the release notes for 1 September 2021.
{: shortdesc}

{{site.data.keyword.block_storage_is_short}} add-on
:   Version [`4.0`](/docs/containers?topic=containers-vpc_bs_changelog) is available.

{{site.data.keyword.cos_full_notm}} plug-in 
:   Version [`2.1.4`](/docs/containers?topic=containers-cos_plugin_changelog) is available.


## August 2021
{: #containers-aug21}

Review the release notes for August 2021.
{: shortdesc}

### 31 August 2021
{: #containers-aug3121}
{: release-note}

Review the release notes for 31 August 2021.
{: shortdesc}

Istio add-on change log
:   [Version 1.11.1](/docs/containers?topic=containers-istio-changelog#1111) of the Istio managed add-on is released.

New! Sao Paulo multizone region
:   You can now create VPC clusters in the Sao Paulo, Brazil [location](/docs/containers?topic=containers-regions-and-zones).

 VPC disk encryption on worker nodes
:   Now, you can manage the encryption for the disk on your VPC worker nodes. For more information, see [VPC worker nodes](/docs/containers?topic=containers-encryption#worker-encryption-vpc).

### 30 August 2021
{: #containers-aug3021}
{: release-note}

Review the release notes for 30 August 2021.
{: shortdesc}



Worker node fix pack update
:   Change log documentation is available for version [`1.17.17_1568`](/docs/containers?topic=containers-117_changelog#11717_1568), [`1.18.20_1563`](/docs/containers?topic=containers-118_changelog#11820_1563), [`1.19.14_1558`](/docs/containers?topic=containers-changelog_119#11914_1558), [`1.20.10_1551`](/docs/containers?topic=containers-changelog_120#12010_1551), and [`1.21.4_1529`](/docs/containers?topic=containers-changelog_121#12104_1529).



### 25 August 2021
{: #containers-aug2621}
{: release-note}

New! Create a cluster with a template
:   No longer do you have to manually specify the networking and worker node details to create a cluster, or enable security integrations such as logging and monitoring after creation. Instead, you can try out the **technical preview** to create a multizone cluster with nine worker nodes and encryption, logging, and monitoring already enabled. For more information, see [Creating a cluster by using an {{site.data.keyword.bpfull_notm}} template](/docs/openshift?topic=openshift-templates&interface=ui).

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.3` is [released](/docs/containers?topic=containers-cos_plugin_changelog).
Master fix pack update change log documentation

:   Master fix pack update change log documentation is available for version [1.21.4_ 1528](/docs/containers?topic=containers-changelog_121#1214_1528), [1.20.10_1550](/docs/containers?topic=containers-changelog_120#12010_1550), [1.19.14_1557](/docs/containers?topic=containers-changelog_119#11914_1557), and [1.18.20_1562](/docs/containers?topic=containers-118_changelog#11820_1562).

### 23 August 2021
{: #containers-aug2321}
{: release-note}

Registry token update
:   Registry tokens are no longer accepted for authentication in {{site.data.keyword.registrylong_notm}}. Update your clusters to use {{site.data.keyword.cloud_notm}} IAM authentication. For more information, see [Accessing {{site.data.keyword.registrylong_notm}}](/docs/Registry?topic=Registry-registry_access). For more information about Registry token deprecation, see [IBM Cloud Container Registry Deprecates Registry Tokens for Authentication](https://www.ibm.com/cloud/blog/announcements/ibm-cloud-container-registry-deprecates-registry-tokens-for-authentication){: external}.

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1541_iks`, `0.47.0_1540_iks`, and `0.43.0_1539_iks`. Version `0.45.0_1482_iks` is removed.


  
ALB OAuth Proxy
:   Updated the version change log for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).



### 16 August 2021
{: #containers-aug1621}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available. For more information, see [Version change log(/docs/containers?topic=containers-changelog).


  
### 12 August 2021
{: #containers-aug1221}
{: release-note}

Istio add-on change log
:   [Version 1.9.7](/docs/containers?topic=containers-istio-changelog#196) of the Istio managed add-on is released.



### 10 August 2021
{: #containers-aug1021}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.48.1_1465_iks`, `0.47.0_1480_iks`, and `0.45.0_1482_iks`.



ALB OAuth Proxy
:   Updated the version change log for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

 

### 9 August 2021
{: #containers-aug0921}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.312](/docs/containers?topic=containers-cs_cli_changelog).

### 2 August 2021
{: #containers-aug0221}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.47.0_1434_iks` and `0.45.0_1435_iks`. Version `0.35.0` is now unsupported. 

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.21.3_1526](/docs/containers?topic=containers-changelog_121#1213_1526), [1.20.9_1548](/docs/containers?topic=containers-changelog_120#1209_1548), [1.19.13_1555](/docs/containers?topic=containers-changelog_119#11913_1555), and [1.18.20_1560](/docs/containers?topic=containers-118_changelog#11820_1560).

## July 2021
{: #containers-jul21} 

### 27 July 2021
{: #containers-july2721}
{: release-note}

New! IAM trusted profile support
:   Link your cluster to a trusted profile in IAM so that the pods in your cluster can authenticate with IAM to use other {{site.data.keyword.cloud_notm}} services.

Master versions
:   Master fix pack update change log documentation is available for version [1.21.3_1525](/docs/containers?topic=containers-changelog_121#1213_1525), [1.20.9_1547](/docs/containers?topic=containers-changelog_120#1209_1547), [1.19.13_1554](/docs/containers?topic=containers-changelog_119#11913_1554), and [1.18.20_1559](/docs/containers?topic=containers-118_changelog#11820_1559).

### 22 July 2021
{: #containers-july2221}
{: release-note}

Istio add-on change log
:   [Version 1.9.6](/docs/containers?topic=containers-istio-changelog#196) of the Istio managed add-on is released.



### 19 July 2021
{: #containers-july1921}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.21.2_1524](/docs/containers?topic=containers-changelog_121#1212_1524), [1.20.8_1546](/docs/containers?topic=containers-changelog_120#1208_1546), [1.19.12_1553](/docs/containers?topic=containers-changelog_119#11912_1553), [1.18.29_1558](/docs/containers?topic=containers-118_changelog#11829_1558), and [1.17.17_1568](/docs/containers?topic=containers-117_changelog#11717_1568).

### 15 July 2021
{: #containers-july1521}
{: release-note}

Istio add-on change log
:   [Version 1.10.2](/docs/containers?topic=containers-istio-changelog#v110) of the Istio managed add-on is released. 



### 12 July 2021
{: #containers-july1221}
{: release-note}



Snapshots
:   Before updating to Kubernetes version `1.20` or `1.21`, snapshot CRDs must be changed to version `v1beta1`. For more information, see the [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions_121#121_before).



### 6 July 2021
{: #containers-july0621}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions `0.47.0_1376_iks`, `0.45.0_1375_iks`, and `0.35.0_1374_iks`.

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.21.2_1523](/docs/containers?topic=containers-changelog_121#1212_1523), [1.20.8_1545](/docs/containers?topic=containers-changelog_120#1208_1545), [1.19.12_1552](/docs/containers?topic=containers-changelog_119#11912_1552), [1.18.20_1557](/docs/containers?topic=containers-118_changelog#11820_1557), and [1.17.17_1567](/docs/containers?topic=containers-117_changelog#11717_1567_worker).

### 2 July 2021
{: #containers-july0221}
{: release-note}

Unsupported Kubernetes version 1.17
:   To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.

## June 2021
{: #containers-jun21}

From 07 to 31 July 2021, the DNS provider is changed from Cloudflare to Akamai for all `containers.appdomain.cloud`, `containers.mybluemix.net`, and `containers.cloud.ibm.com` domains for all clusters in {{site.data.keyword.containerlong_notm}}. Review the following actions that you must make to your Ingress setup.
{: important}

- If you currently allow inbound traffic to your classic cluster from the Cloudflare source IP addresses, you must also allow inbound traffic from the [Akamai source IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/akamai/gtm-liveness-test){: external} before 07 July. After the migration completes on 31 July, you can remove the Cloudflare IP address rules.

- The Akamai health check does not support verification of the body of the health check response. Update any custom health check rules that you configured for Cloudflare that use verification of the body of the health check responses.

- Cluster subdomains that were health checked in Cloudflare are now registered in the Akamai DNS as CNAME records. These CNAME records point to an Akamai Global Traffic Management domain that health checks the subdomains. When a client runs a DNS query for a health checked subdomain, a CNAME record is returned to the client, as opposed to Cloudflare, in which an A record was returned. If your client expects an A record for a subdomain that was health checked in Cloudflare, update your logic to accept a CNAME record.

- During the migration, an Akamai Global Traffic Management (GTM) health check was automatically created for any subdomains that had a Cloudflare health check. If you previously created a Cloudflare health check for a subdomain, and you create an Akamai health check for the subdomain after the migration, the two Akamai health checks might conflict. Note that Akamai GTM configurations don't support nested subdomains. In these cases, you can use the `ibmcloud ks nlb-dns monitor disable` command to disable the Akamai health check that the migration automatically configured for your subdomain.

### 28 June 2021
{: #containers-june2821}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available for version [1.21.2_1522](/docs/containers?topic=containers-changelog_121#1212_1522), [1.20.8_1544](/docs/containers?topic=containers-changelog_120#1208_1544), [1.19.12_1551](/docs/containers?topic=containers-changelog_119#11912_1551), [1.18.20_1556](/docs/containers?topic=containers-118_changelog#11820_1556), and [1.17.17_1567](/docs/containers?topic=containers-117_changelog#11717_1567).

### 24 June 2021
{: #containers-june2421}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.295](/docs/containers?topic=containers-cs_cli_changelog#10).

### 23 June 2021
{: #containers-june2321}
{: release-note}

Cluster autoscaler add-on
:   [Version `1.0.3`](/docs/containers?topic=containers-ca_changelog) of the cluster autoscaler add-on is available.

### 22 June 2021
{: #containers-june2221}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.1.2` of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.21.1_1521](/docs/containers?topic=containers-changelog_121#1211_1521), [1.20.7_1543](/docs/containers?topic=containers-changelog_120#1207_1543), [1.19.11_1550](/docs/containers?topic=containers-changelog_119#11911_1550), [1.18.19_1555](/docs/containers?topic=containers-118_changelog#11819_1555) and [1.17.17_1566](/docs/containers?topic=containers-117_changelog#11717_1566).

### 21 June 2021
{: #containers-june2121}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the release of version 0.47.0 of the Kubernetes Ingress image.

New! The `addon options` command is now available
:   For more information, see [`addon options`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_addon_options).



### 17 June 2021
{: #containers-june1721}
{: release-note}



ALB OAuth Proxy
:   Updated the version change log for the [ALB OAuth Proxy](/docs/containers?topic=containers-alb-oauth-proxy-changelog) add-on.



### 15 June 2021
{: #containers-june1521}
{: release-note}

New! Private VPC NLB
:   You can now create [private Network Load Balancers for VPC](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_nlb_priv) to expose apps in clusters that run version 1.19 and later.

### 10 June 2021
{: #containers-june1021}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for versions 0.45.0, 0.35.0, and 0.34.1 of the Kubernetes Ingress image.



### 9 June 2021
{: #containers-june0921}
{: release-note}



New! Kubernetes 1.21
:   You can create or (/docs/containers?topic=containers-cs_versions_121)update your cluster to Kubernetes version 1.21. With Kubernetes 1.21, you get the latest stable enhancements from the community, such as stable `CronJob`, `EndpointSlice`, and `PodDisruptionBudget` resources. You also get enhancements to the {{site.data.keyword.cloud_notm}} product, such as a refreshed user interface experience. For more information, see the [blog announcement](https://www.ibm.com/cloud/blog/announcements/kubernetes-version-121-now-available-in-ibm-cloud-kubernetes-service){: external}.

Deprecated Kubernetes 1.18
:   With the release of Kubernetes 1.21, clusters that run version 1.18 are deprecated, with a tentative unsupported date of 10 October 2021. Update your cluster to at least [version 1.19](/docs/containers?topic=containers-cs_versions_119) as soon as possible.



Expanded Troubleshooting
:   You can now find troubleshooting steps for {{site.data.keyword.cloud_notm}} persistent storage in the following pages.  
    - [{{site.data.keyword.filestorage_short}}](/docs/openshift?topic=openshift-debug_storage_file)
    - [{{site.data.keyword.blockstorageshort}}](/docs/openshift?topic=openshift-debug_storage_block)
    - [{{site.data.keyword.cos_short}}](/docs/openshift?topic=openshift-debug_storage_cos)
    - [Portworx](/docs/openshift?topic=openshift-debug_storage_px)

### 07 June 2021
{: #containers-june0721}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.7_1542](/docs/containers?topic=containers-changelog_120#1207_1542), [1.19.11_1549](/docs/containers?topic=containers-changelog_119#11911_1549), [1.18.19_1554](/docs/containers?topic=containers-118_changelog#11819_1554), and [1.17.17_1565](/docs/containers?topic=containers-117_changelog#11717_1565).

### 3 June 2021
{: #containers-june0321}
{: release-note}

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.0.8` of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).

### 2 June 2021
{: #containers-june0221}
{: release-note}



End of support for custom IBM Ingress image
:   The custom {{site.data.keyword.containerlong_notm}} Ingress image is unsupported. In clusters that were created before 01 December 2020, [migrate any ALBs that continue to run the custom IBM Ingress image to the Kubernetes Ingress image](/docs/containers?topic=containers-managed-ingress-about). Not ready to switch your ALBs to the Kubernetes Ingress image yet? The custom {{site.data.keyword.containerlong_notm}} Ingress image is available as an [open source project](https://github.com/IBM-Cloud/iks-ingress-controller/){: external}. However, this project is not officially supported by {{site.data.keyword.cloud_notm}}, and you are responsible for deploying, managing, and maintaining the Ingress controllers in your cluster.



## May 2021
{: #containers-may21}




  
### 27 May 2021
{: #containers-may2721}
{: release-note}

Istio add-on change log
:   [Version 1.9.5](/docs/containers?topic=containers-istio-changelog#v19) and version [1.8.6](/docs/containers?topic=containers-istio-changelog#v18) of the Istio managed add-on are released.



### 26 May 2021
{: #containers-may2621}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.275](/docs/containers?topic=containers-cs_cli_changelog#10).

Version 0.45.0 of the Kubernetes Ingress image
:   Due to a [regression in the community Kubernetes Ingress NGINX code](https://github.com/kubernetes/ingress-nginx/issues/6931){: external}, trailing slashes (`/`) are removed from subdomains during TLS redirects.

### 24 May 2021
{: #containers-may2421}
{: release-note}



Master versions
:   Master fix pack update change log documentation is available for version [1.20.7_1540](/docs/containers?topic=containers-changelog_120#1207_1540), [1.19.11_1547](/docs/containers?topic=containers-changelog_119#11911_1547), [1.18.19_1552](/docs/containers?topic=containers-118_changelog#11819_1552), and [1.17.17_1563](/docs/containers?topic=containers-117_changelog#11717_1563).

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.7_1541](/docs/containers?topic=containers-changelog_120#1207_1541), [1.19.11_1548](/docs/containers?topic=containers-changelog_119#11911_1548), [1.18.19_1553](/docs/containers?topic=containers-118_changelog#11819_1553), and [1.17.17_1564](/docs/containers?topic=containers-117_changelog#11717_1564).

### 17 May 2021
{: #containers-may1721}
{: release-note}

Deprecated: Kubernetes web terminal.
:   The Kubernetes web terminal add-on is deprecated and becomes unsupported 1 July 2021. Instead, use the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cs_cli_install#cloud-shell).



Istio add-on
:   [Version 1.9.4 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v19) is released.

Deprecated Ubuntu 16 end of support date
:   The Ubuntu 16 worker node flavors were deprecated 1 December 2020, with an initial unsupported date of April 2021. To give customers more time to migrate to a newer Ubuntu version, the end of support date is extended to 31 December 2021. Before 31 December 2021, [update the worker pools in your cluster to run Ubuntu 18](/docs/containers?topic=containers-update#machine_type). For more information, see the [{{site.data.keyword.cloud_notm}} blog](https://www.ibm.com/cloud/blog/announcements/new-bare-metal-servers-available-for-kubernetes-and-openshift-clusters){: external}.

### 11 May 2021
{: #containers-may1121}
{: release-note}

VPC cluster healthchecks
:   If you set up [VPC security groups](/docs/openshift?topic=openshift-vpc-security-group) or [VPC access control lists (ACLs)](/docs/openshift?topic=openshift-vpc-acls) to secure your cluster network, you can now create the rules to allow the necessary traffic from the control plane IP addresses and Akamai IPv4 IP addresses to health check your ALBs. Previously, a quota on the number of rules per security group or ACL prevented the ability to create all necessary rules for health checks.

### 10 May 2021
{: #containers-may1021}
{: release-note}

New! PX-Backup is now available
:   For more information, see [Backing up and restoring apps and data with PX-Backup](/docs/containers?topic=containers-portworx).



Calico KDD update in 1.19
:   Added a step to check for Calico `NetworkPolicy` resources that are scoped to non-existent namespaces before [updating your cluster to Kubernetes version 1.19](/docs/containers?topic=containers-cs_versions_119#119_before).



Cluster autoscaler add-on
:   [Patch update `1.0.2_267`](/docs/containers?topic=containers-ca_changelog) of the cluster autoscaler add-on is available.

{{site.data.keyword.cos_full_notm}} plug-in
:   [Version `2.0.9`](/docs/containers?topic=containers-cos_plugin_changelog) of the {{site.data.keyword.cos_full_notm}} plug-in is available.

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.6_1539](/docs/containers?topic=containers-changelog_120#1206_1539), [1.19.10_1546](/docs/containers?topic=containers-changelog_119#11910_1546), [1.18.18_1551](/docs/containers?topic=containers-118_changelog#11818_1551), and [1.17.17_1562](/docs/containers?topic=containers-117_changelog#11717_1562).

### 4 May 2021
{: #containers-may0421}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available for version [1.20.5_1538](/docs/containers?topic=containers-changelog_120#1206_1538) and [1.19.10_1545](/docs/containers?topic=containers-changelog_119#11910_1545).

## April 2021
{: #containers-apr21}



### 29 April 2021
{: #containers-april2921}
{: release-note}

Custom IOPs for Istio
:   Added a page for creating a custom Istio ingress and egress gateways for the managed Istio add-on by [using `IstioOperator`](/docs/containers?topic=containers-istio-custom-gateway).

Istio add-on change log
:   [Version 1.9.3](/docs/containers?topic=containers-istio-changelog#v19) and version [1.8.5](/docs/containers?topic=containers-istio-changelog#v18) of the Istio managed add-on are released.



### 28 April 2021
{: #containers-april2821}
{: release-note}

Default version
:   The default version for new clusters is now 1.20.

### 27 April 2021
{: #containers-april2721}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available for version [1.20.6_1536](/docs/containers?topic=containers-changelog_120#1206_1536), [1.19.10_1543](/docs/containers?topic=containers-changelog_119#11910_1543), [1.18.18_1549](/docs/containers?topic=containers-118_changelog#11818_1549), and [1.17.17_1560](/docs/containers?topic=containers-117_changelog#11717_1560).

### 26 April 2021
{: #containers-april2621}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.258](/docs/containers?topic=containers-cs_cli_changelog#10).



VPC NLB
:   Adds steps for [registering a VPC network load balancer with a DNS record and TLS certificate](/docs/containers?topic=containers-vpc-lbaas#vpc_nlb_dns).

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.6_1537](/docs/containers?topic=containers-changelog_120#1206_1537), [1.19.10_1544](/docs/containers?topic=containers-changelog_119#11910_1544), [1.18.18_1550](/docs/containers?topic=containers-118_changelog#11818_1550), and [1.17.17_1561](/docs/containers?topic=containers-117_changelog#11717_1561).


  
### 23 April 2021
{: #containers-april2321}
{: release-note}

Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the release of version 0.45.0 of the Kubernetes Ingress image. Version 0.33.0 is now unsupported.



### 20 April 2021
{: #containers-april2021}
{: release-note}

New! Toronto multizone region for VPC
:   You can now create clusters on VPC infrastructure in the Toronto, Canada (`ca-tor`) [location](/docs/containers?topic=containers-regions-and-zones).

### 19 April 2021
{: #containers-april1921}
{: release-note}

add-on change logs
:   Updated version changelogs for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

Cluster autoscaler add-on
:   [Patch update `1.0.2_256`](/docs/containers?topic=containers-ca_changelog) of the cluster autoscaler add-on is available.

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.0.8` of the {{site.data.keyword.cos_full_notm}} plug-in is released. Update your clusters to use the latest version. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).


  
Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images.



### 16 April 2021
{: #containers-april1621}
{: release-note}

New fields and events for {{site.data.keyword.at_short}}
:   To align with event auditing standards across {{site.data.keyword.cloud_notm}}, the previously deprecated cluster fields and events are now replaced by new fields and events. For an updated list of events, see [{{site.data.keyword.at_full_notm}} events](/docs/containers?topic=containers-at_events).

### 15 April 2021
{: #containers-april1521}
{: release-note}



Accessing VPC clusters
:   Updated the steps for [accessing VPC clusters through the private cloud service endpoint](/docs/containers?topic=containers-access_cluster#vpc_private_se) by configuring the VPC VPN gateway to access the `166.8.0.0/14` subnet.



### 12 April 2021
{: #containers-april1221}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.5_1535](/docs/containers?topic=containers-changelog_120#1205_1535), [1.19.9_1542](/docs/containers?topic=containers-changelog_119#1199_1542), [1.18.17_1548](/docs/containers?topic=containers-118_changelog#11817_1548), and [1.17.17_1559](/docs/containers?topic=containers-117_changelog#11717_1559).



Ingress changelogs
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images.



### 5 April 2021
{: #containers-april0521}
{: release-note}

Deprecated data centers for classic clusters
:   Houston (`hou02`) and Oslo (`osl01`) are deprecated and become unsupported later this year. To prevent any interruption of service, [redeploy all your cluster workloads](/docs/containers?topic=containers-update_app#copy_apps_cluster) to a [supported data center](/docs/containers?topic=containers-regions-and-zones#zones-mz) and remove your `osl01` or `hou02` clusters by **1 August 2021**. Before the unsupported date, you are blocked from adding new worker nodes and clusters starting on **1 July 2021**. For more information, see [Data center closures in 2021](/docs/get-support?topic=get-support-dc-closure).

### 2 April 2021
{: #containers-april0221}
{: release-note}



Istio add-on
:   [Version 1.9.2 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v19) is released.



### 1 April 2021
{: #containers-april0121}
{: release-note}

Cluster autoscaler add-on
:   [Patch update `1.0.2_249`](/docs/containers?topic=containers-ca_changelog) of the cluster autoscaler add-on is available.

{{site.data.keyword.block_storage_is_short}} add-on
:   [Patch update `3.0.0_521`](/docs/containers?topic=containers-vpc_bs_changelog) of the {{site.data.keyword.block_storage_is_short}} add-on is available.

{{site.data.keyword.block_storage_is_short}} driver
:   Added steps to install the `vpc-block-csi-driver` on unmanaged clusters. For more information, see [Storing data on {{site.data.keyword.block_storage_is_short}} for unmanaged clusters](/docs/containers?topic=containers-vpc-block-storage-driver-unmanaged).

New! image security add-on
:   In clusters that run version 1.18 or later, you can (/docs/containers?topic=containers-images#portieris-image-sec)install the container image security enforcement add-onto set up the (https://github.com/IBM/portieris){: external} Portieris project in your cluster.


## March 2021
{: #containers-mar21}



### 30 March 2021
{: #containers-march3021}
{: release-note}

add-on change logs
:   Added version changelogs for the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-alb-oauth-proxy-changelog).

Master versions
:   Master fix pack update change log documentation is available for version [1.20.5_1533](/docs/containers?topic=containers-changelog_120#1205_1533), [1.19.9_1540](/docs/containers?topic=containers-changelog_119#1199_1540), [1.18.17_1546](/docs/containers?topic=containers-118_changelog#11817_1546), and [1.17.17_1557](/docs/containers?topic=containers-117_changelog#11717_1557).

### 29 March 2021
{: #containers-march2921}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.5_1534](/docs/containers?topic=containers-changelog_120#1205_1534), [1.19.9_1541](/docs/containers?topic=containers-changelog_119#1199_1541), [1.18.17_1547](/docs/containers?topic=containers-118_changelog#11817_1547), and [1.17.17_1558](/docs/containers?topic=containers-117_changelog#11717_1558).

### 25 March 2021
{: #containers-march2521}
{: release-note}

 

{{site.data.keyword.cloudcerts_short}} instances
:   The default {{site.data.keyword.cloudcerts_short}} instance for your cluster is now named in the format `kube-crtmgr-<cluster_ID>`.


  
### 23 March 2021
{: #containers-march2321}
{: release-note}

Istio add-on
:   [Version 1.8.4 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#184) is released.



### 22 March 2021
{: #containers-march2221}
{: release-note}



Ingress ALB changelog
:   Updated the [Ingress ALB change log(/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for updates to the Kubernetes Ingress and {{site.data.keyword.containerlong_notm}} Ingress images.





### 17 March 2021
{: #containers-mar1721}
{: release-note}

Deprecated events to be replaced for {{site.data.keyword.at_short}}
:   To align with event auditing standards across {{site.data.keyword.cloud_notm}}, the following cluster events are deprecated and are replaced in 30 days on 16 April 2021 by new events.
    - `containers-kubernetes.account.create` 
    - `containers-kubernetes.account.delete` 
    - `containers-kubernetes.account.get` 
    - `containers-kubernetes.account.update` 
    - `containers-kubernetes.cluster.config` 
    - `containers-kubernetes.cluster.create` 
    - `containers-kubernetes.cluster.delete` 
    - `containers-kubernetes.cluster.update` 
    - `containers-kubernetes.credentials.ready-to-use` 
    - `containers-kubernetes.logging-config.create` 
    - `containers-kubernetes.logging-config.delete` 
    - `containers-kubernetes.logging-config.refresh` 
    - `containers-kubernetes.logging-filter.create` 
    - `containers-kubernetes.logging-filter.delete` 
    - `containers-kubernetes.logging-filter.update` 
    - `containers-kubernetes.logging-autoupdate.changed` 
    - `containers-kubernetes.masterlog-retrieve` 
    - `containers-kubernetes.masterlog-status` 
    - `containers-kubnertes.cluster.rbac.update` 
    - `containers-kubernetes.service.create` 
    - `containers-kubernetes.service.delete` 
    - `containers-kubernetes.subnet.add` 
    - `containers-kubernetes.subnet.create` 
    - `containers-kubernetes.subnet.update` 
    - `containers-kubernetes.vlan.create` 
    - `containers-kubernetes.vlan.delete` 
    - `containers-kubernetes.worker.create` 
    - `containers-kubernetes.worker.delete` 
    - `containers-kubernetes.worker.update` 
    - `containers-kubernetes.workerpool.create` 
    - `containers-kubernetes.workerpool.delete` 
    - `containers-kubernetes.workerpool.update` 
    - `containers-kubernetes.zone.delete` 
    - `containers-kubernetes.zone.update`
    
Deprecated fields across events
:   The following fields are deprecated and replaced by or updated with new values across events. 
    - The `correlationID` is replaced by `correlationId` to align with field casing standards. 
    - The `resourceGroupID` field is no longer used. Instead, the resource group ID can be found in the `target.resourceGroupId` field. 
    - The `reason.reasonCode` field is now formatted as an integer (`int`) instead of string (`string`). 
    - The `requestData` field is now formatted as a JSON object instead of a JSON string. 
    - The `responseData` field is now formatted as a JSON object instead of string. 
    - The `target.typeURI` values are updated for consistency. All values now have a prefix of `containers-kubernetes/` instead of `container/`. For example, `container/cluster` is now `containers-kubernetes/cluster` and `container/worker` is now `containers-kubernetes/worker`.

### 16 March 2021
{: #containers-march1621}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 2458](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

### 12 March 2021
{: #containers-march1221}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.4_1532](/docs/containers?topic=containers-changelog_120#1204_1532), [1.19.8_1539](/docs/containers?topic=containers-changelog_119#1198_1539), [1.18.16_1545](/docs/containers?topic=containers-118_changelog#11816_1545), and [1.17.17_1556](/docs/containers?topic=containers-117_changelog#11717_1556).



### 10 March 2021
{: #containers-march1021}
{: release-note}

Istio add-on
:   [Version 1.7.8 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#178) is released.



### 9 March 2021
{: #containers-march0921}
{: release-note}

Cluster autoscaler add-on
:   Version 1.0.2 of the cluster autoscaler add-on is released. For more information, see the [cluster autoscaler add-on change log(/docs/containers?topic=containers-ca_changelog).



### 5 March 2021
{: #containers-march0521}
{: release-note}

Trusted images
:   You can now [set up trusted content for container images](/docs/containers?topic=containers-images#trusted_images) that are signed and stored in {{site.data.keyword.registrylong_notm}}.

### 1 March 2021
{: #containers-march0121}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.233](/docs/containers?topic=containers-cs_cli_changelog#10).



Istio add-on
:   [Version 1.8.3 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#183) is released.



Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.20.4_1531](/docs/containers?topic=containers-changelog_120#1204_1531), [1.19.8_1538](/docs/containers?topic=containers-changelog_119#1198_1538), [1.18.16_1544](/docs/containers?topic=containers-118_changelog#11816_1544), and [1.17.17_1555](/docs/containers?topic=containers-117_changelog#11717_1555_worker).

## February 2021
{: #containers-feb21}

### 27 February 2021
{: #containers-feb2721}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available for version [1.20.4_1531](/docs/containers?topic=containers-changelog_120#1204_1531_master), [1.19.8_1538](/docs/containers?topic=containers-changelog_119#1198_1538_master), and [1.18.16_1544](/docs/containers?topic=containers-118_changelog#11816_1544_master).

### 26 February 2021
{: #containers-feb2621}
{: release-note}

{{site.data.keyword.block_storage_is_short}} add-on
:   Version `3.0.0` of the {{site.data.keyword.block_storage_is_short}} add-on is released. Update your clusters to use the latest version. For more information, see the [{{site.data.keyword.block_storage_is_short}} add-on change log(/docs/containers?topic=containers-vpc_bs_changelog).



End of service of VPC Gen 1
:   Removed steps for using VPC Gen 1 compute. You can now [create new VPC clusters on Generation 2 compute only](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui). Move any remaining workloads from VPC Gen 1 clusters to VPC Gen 2 clusters before 01 March 2021, when any remaining VPC Gen 1 worker nodes are automatically deleted.



### 25 February 2021
{: #containers-feb2521}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.231](/docs/containers?topic=containers-cs_cli_changelog#10).


  
### 24 February 2021
{: #containers-feb2421}
{: release-note}

Default version
:   Kubernetes 1.19 is now the default cluster version.



### 23 February 2021
{: #containers-feb2321}
{: release-note}

VPE
:   In VPC clusters that run Kubernetes version 1.20 or later, worker node communication to the Kubernetes master is now established over the [VPC virtual private endpoint (VPE)](/docs/containers?topic=containers-vpc-subnets#vpc_basics_vpe).

### 22 February 2021
{: #containers-feb2221}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available for version [1.20.4_1530](/docs/containers?topic=containers-changelog_120#1204_1530), [1.19.8_1537](/docs/containers?topic=containers-changelog_119#1198_1537), [1.18.16_1543](/docs/containers?topic=containers-118_changelog#11816_1543), and [1.17.17_1555](/docs/containers?topic=containers-117_changelog#11717_1555).

### 20 February 2021
{: #containers-feb2021}
{: release-note}

Certified Kubernetes
:   Version [1.20](/docs/containers?topic=containers-cs_versions_120) release is now certified.

### 17 February 2021
{: #containers-feb1721}
{: release-note}



New! Kubernetes 1.20
:   You can create or [update](/docs/containers?topic=containers-cs_versions_120) your cluster to Kubernetes version 1.20. With Kubernetes 1.20, you get the latest stable enhancements from the community, as well as beta access to features such as [API server priority](/docs/containers?topic=containers-kubeapi-priority). For more information, see the [blog announcement](http://www.ibm.com/cloud/blog/announcements/kubernetes-version-120-now-available-in-ibm-cloud-kubernetes-service){: external}.

Deprecated Kubernetes 1.17
:   With the release of Kubernetes 1.20, clusters that run version 1.17 are deprecated, with a tentative unsupported date of 2 July 2021. Update your cluster to at least [version 1.18](/docs/containers?topic=containers-cs_versions#k8s_version_archive) as soon as possible.



### 15 February 2021
{: #containers-feb1521}
{: release-note}

New! Osaka multizone region
:   You can now create classic or VPC clusters in the Osaka, Japan (`jp-osa`) [location](/docs/containers?topic=containers-regions-and-zones).

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.19.7_1535](/docs/containers?topic=containers-changelog_119#1197_1535), [1.18.15_1541](/docs/containers?topic=containers-118_changelog#11815_1541), and [1.17.17_1553](/docs/containers?topic=containers-117_changelog#11717_1553).

### 12 February 2021
{: #containers-feb1221}
{: release-note}

Gateway firewalls and Calico policies
:   For classic clusters in Frankfurt, updated the required IP addresses and ports that you must open in a [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private) or [Calico private network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation/eu-de){: external}.

### 10 February 2021
{: #containers-feb1021}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 2452](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

Gateway firewalls and Calico policies
:   For classic clusters in Dallas, Washington D.C., and Frankfurt, updated the required IP addresses and ports that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound), [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private), or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies){: external}.

### 8 February 2021
{: #containers-feb0821}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.223](/docs/containers?topic=containers-cs_cli_changelog#10).



Istio add-on
:   [Version 1.7.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#177) is released.



### 4 February 2021
{: #containers-feb0421}
{: release-note}

Worker node modifications
:   Summarized the modifications that you can make to the [default worker node settings](/docs/containers?topic=containers-kernel#worker-default).



### 3 February 2021
{: #containers-feb0321}
{: release-note}

Worker node versions
:   A worker node fix pack for internal documentation updates is available for version [1.19.7_1534](/docs/containers?topic=containers-changelog_119#1197_1534), and [1.18.15_1540](/docs/containers?topic=containers-118_changelog#11815_1540).



### 1 February 2021
{: #containers-feb0121}
{: release-note}

Unsupported: Kubernetes version 1.16
:   Clusters that run Kubernetes version 1.16 are unsupported as of 31 January 2021. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.19.7_1533](/docs/containers?topic=containers-changelog_119#1197_1533), [1.18.15_1539](/docs/containers?topic=containers-118_changelog#11815_1539), and [1.17.17_1552](/docs/containers?topic=containers-117_changelog#11717_1552).

## January 2021
{: #containers-jan21}

### 27 January 2021
{: #containers-jan2721}
{: release-note}

Block Storage for VPC add-on
:   Block Storage for VPC add-on patch update `2.0.3_471` is released. For more information, see the [Block Storage for VPC add-on change log(/docs/containers?topic=containers-vpc_bs_changelog).



Reminder: VPC Gen 1 deprecation
:   You can continue to use VPC Gen 1 resources only until 26 February 2021, when all service for VPC Gen 1 ends. On 01 March 2021, any remaining VPC Gen 1 worker nodes are automatically deleted. To ensure continued support, [create new VPC clusters on Generation 2 compute only](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui), and move your workloads from existing VPC Gen 1 clusters to VPC Gen 2 clusters.



### 25 January 2021
{: #containers-jan2521}
{: release-note}



Istio add-on
:   [Version 1.8.2 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#182) is released.

New! Private service endpoint allowlists
:   You can now control access to your private cloud service endpoint by [creating a subnet allowlist](/docs/containers?topic=containers-access_cluster#private-se-allowlist). Only authorized requests to your cluster master that originate from subnets in the allowlist are permitted through the cluster's private cloud service endpoint.

Private Kubernetes Ingress
:   Added steps for [privately exposing apps with ALBs that run the Kubernetes Ingress image](/docs/containers?topic=containers-managed-ingress-setup).

### 19 January 2021
{: #containers-jan1921}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 2424](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

Master versions
:   Master fix pack update change log documentation is available for version [1.19.7_1532](/docs/containers?topic=containers-changelog_119#1197_1532_master), [1.18.15_1538](/docs/containers?topic=containers-118_changelog#11815_1538_master), [1.17.17_1551](/docs/containers?topic=containers-117_changelog#11717_1551_master), and [1.16.15_1557](/docs/containers?topic=containers-116_changelog#11615_1557_master).

### 18 January 2021
{: #containers-jan1821}
{: release-note}

Knative add-on is unsupported
:   The Knative add-on is automatically removed from your cluster. Instead, use the [Knative open source project](https://knative.dev/docs/install/){: external} or [{{site.data.keyword.codeenginefull}}](/docs/codeengine?topic=codeengine-getting-started), which includes Knative's open-source capabilities.

Worker node versions
:   Worker node fix pack update change log documentation is available for version [1.19.7_1532](/docs/containers?topic=containers-changelog_119#1197_1532), [1.18.15_1538](/docs/containers?topic=containers-118_changelog#11815_1538), [1.17.17_1551](/docs/containers?topic=containers-117_changelog#11717_1551), and [1.16.15_1557](/docs/containers?topic=containers-116_changelog#11615_1557).

### 14 January 2021
{: #containers-jan1421}
{: release-note}

Cluster autoscaler
:   Cluster autoscaler add-on patch update `1.0.1_210` is released. For more information, see the [Cluster autoscaler add-on change log(/docs/containers?topic=containers-ca_changelog).

### 12 January 2021
{: #containers-jan1221}
{: release-note}

Ingress resources
:   Added example Ingress resource definitions that are compatible with Kubernetes version 1.19. 

Kubernetes benchmarks
:   Added how to [run the CIS Kubernetes benchmark tests on your own worker nodes](/docs/containers?topic=containers-cis-benchmark#cis-worker-test). 

Removal of data center support
:   Updated the documentation to reflect that Melbourne (`mel01`) is no longer available as an option to create {{site.data.keyword.cloud_notm}} resources in.


  
### 7 January 2021
{: #containers-jan0721}
{: release-note}

Ingress ALB changelog
:   Updated the latest [Kubernetes Ingress image build to `0.35.0_869_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0).



### 6 January 2021
{: #containers-jan0621}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available.
:   [1.19.6_1531](/docs/containers?topic=containers-changelog_119#1196_1531), [1.18.14_1537](/docs/containers?topic=containers-118_changelog#11814_1537), [1.17.16_1550](/docs/containers?topic=containers-117_changelog#11716_1550), and [1.16.15_1556](/docs/containers?topic=containers-116_changelog#11615_1556).

## December 2020
{: #containers-dec20}

### 21 December 2020
{: #containers-dec2120}
{: release-note}

Gateway firewalls and Calico policies
:   For classic clusters in Tokyo, updated the {{site.data.keyword.containerlong_notm}} IP addresses that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound) or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/public-network-isolation){: external}.

Worker node versions
:   Worker node fix pack update change log documentation is available.
:   [1.19.5_1530](/docs/containers?topic=containers-changelog_119#1195_1530), [1.18.13_1536](/docs/containers?topic=containers-118_changelog#11813_1536), [1.17.15_1549](/docs/containers?topic=containers-117_changelog#11715_1549), and [1.16.15_1555](/docs/containers?topic=containers-116_changelog#11615_1555).

### 18 December 2020
{: #containers-dec1820}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.208](/docs/containers?topic=containers-cs_cli_changelog#10).

{{site.data.keyword.cos_full_notm}} plug-in
:   Version `2.0.6` of the {{site.data.keyword.cos_full_notm}} plug-in is released. For more information, see the [{{site.data.keyword.cos_full_notm}} plug-in change log(/docs/containers?topic=containers-cos_plugin_changelog).

### 17 December 2020
{: #containers-dec1720}
{: release-note}

Audit documentation
:   Reorganized information about the configuration and forwarding of Kubernetes API server [audit logs](/docs/containers?topic=containers-health-audit).

Back up and restore
:   Version `1.0.5` of the `ibmcloud-backup-restore` Helm chart is released. For more information, see the [Back up and restore Helm chart change log(/docs/containers?topic=containers-backup_restore_changelog).



Ingress ALB changelog
:   Updated the latest [Kubernetes Ingress image build to `0.35.0_826_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0).
:   Updated the [`ingress-auth` build to 954](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

  
### 16 December 2020
{: #containers-dec1620}
{: release-note}

Istio add-on
:   Versions [1.8.1](/docs/containers?topic=containers-istio-changelog#181) and [1.7.6](/docs/containers?topic=containers-istio-changelog#176) of the Istio managed add-on are released. Version 1.6 is unsupported.

### 15 December 2020
{: #containers-dec1520}
{: release-note}

Cluster autoscaler
:   Cluster autoscaler add-on patch update `1.0.1_205` is released. For more information, see the [Cluster autoscaler add-on change log(/docs/containers?topic=containers-ca_changelog).

### 14 December 2020
{: #containers-dec1420}
{: release-note}



Ingress ALB changelog
:   Updated the latest [Kubernetes Ingress image build to `0.35.0_767_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0).
:   Updated the [`nginx-ingress` build to 2410 and the `ingress-auth` build to 947](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

Master versions
:   Master fix pack update change log documentation is available.
:   [1.19.5_1529](/docs/containers?topic=containers-changelog_119#1195_1529), [1.18.13_1535](/docs/containers?topic=containers-118_changelog#11813_1535), [1.17.15_1548](/docs/containers?topic=containers-117_changelog#11715_1548), and [1.16.15_1554](/docs/containers?topic=containers-116_changelog#11615_1554_master).

### 11 December 2020
{: #containers-dec1120}
{: release-note}

Storage add-ons
:   Cluster autoscaler add-on patch update `1.0.1_195` is released. For more information, see the [Cluster autoscaler add-on change log(/docs/containers?topic=containers-ca_changelog). {{site.data.keyword.block_storage_is_short}} add-on patch update `2.0.3_464` is released. For more information, see the [{{site.data.keyword.block_storage_is_short}} add-on change log(/docs/containers?topic=containers-vpc_bs_changelog).

strongSwan versions
:   Added information about which [strongSwan Helm chart versions](/docs/containers?topic=containers-116_changelog#11615_1554) are supported.



Worker node versions
:   Worker node fix pack update change log documentation is available for Kubernetes version [1.19.4_1529](/docs/containers?topic=containers-changelog_119#1194_1529), [1.18.12_1535](/docs/containers?topic=containers-118_changelog#11812_1535), [1.17.14_1548](/docs/containers?topic=containers-117_changelog#11714_1548), and [1.16.15_1554](/docs/containers?topic=containers-116_changelog#11615_1554).



### 9 December 2020
{: #containers-dec0920}
{: release-note}

Accessing clusters
:   Updated the steps for [accessing clusters through the private cloud service endpoint](/docs/containers?topic=containers-access_cluster#access_private_se) to use the `--endpoint private` option in the **`ibmcloud ks cluster config`** command.

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.206](/docs/containers?topic=containers-cs_cli_changelog#10).

Proxy protocol for Ingress
:   In VPC clusters, you can now [enable the PROXY protocol](/docs/containers?topic=containers-comm-ingress-annotations#preserve_source_ip_vpc) for all load balancers that expose Ingress ALBs in your cluster. The PROXY protocol enables load balancers to pass client connection information that is contained in headers on the client request, including the client IP address, the proxy server IP address, and both port numbers, to ALBs.

Helm version 2 unsupported
:   Removed all steps for using Helm v2, which is unsupported. [Migrate to Helm v3 today](https://helm.sh/docs/topics/v2_v3_migration/){: external} for several advantages over Helm v2, such as the removal of the Helm server, Tiller.



Istio add-on
:   [Version 1.8 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v18) is released.



### 7 December 2020
{: #containers-dec0720}
{: release-note}

{{site.data.keyword.keymanagementserviceshort}} enhancements
:   For clusters that run `1.18.8_1525` or later, your cluster now [integrates more features from {{site.data.keyword.keymanagementserviceshort}}](/docs/containers?topic=containers-encryption#kms-keyprotect-features) when you enable {{site.data.keyword.keymanagementserviceshort}} as the KMS provider for the cluster. When you enable this integration, a **Reader** [service-to-service authorization policy](/docs/account?topic=account-serviceauth) between {{site.data.keyword.containerlong_notm}} and {{site.data.keyword.keymanagementserviceshort}} is automatically created for your cluster, if the policy does not already exist. If you have a cluster that runs an earlier version, [update your cluster](/docs/containers?topic=containers-update) and then [re-enable KMS encryption](/docs/containers?topic=containers-encryption#keyprotect) to register your cluster with {{site.data.keyword.keymanagementserviceshort}} again.

Worker node versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.19.4_1528](/docs/containers?topic=containers-changelog_119#1194_1528), [1.18.12_1534](/docs/containers?topic=containers-118_changelog#11812_1534), [1.17.14_1546](/docs/containers?topic=containers-117_changelog#11714_1546), and [1.16.15_1553](/docs/containers?topic=containers-116_changelog#11615_1553)..

### 3 December 2020
{: #containers-dec0320}
{: release-note}

Cluster autoscaler add-on
:   Patch update `1.0.1_146` is released. For more information, see the [Cluster autoscaler add-on change log(/docs/openshift?topic=openshift-ca_changelog).



Istio add-on
:   Versions [1.6.14](/docs/containers?topic=containers-istio-changelog#1614) and [1.7.5](/docs/containers?topic=containers-istio-changelog#175) of the Istio managed add-on are released.



### 1 December 2020
{: #containers-dec0120}
{: release-note}

Default Kubernetes Ingress image
:   In all new {{site.data.keyword.containerlong_notm}} clusters, default application load balancers (ALBs) now run the Kubernetes Ingress image. In existing clusters, ALBs continue to run the previously supported {{site.data.keyword.containerlong_notm}} Ingress image, which is now deprecated. For more information and migration actions, see [Setting up Kubernetes Ingress](/docs/containers?topic=containers-managed-ingress-about).

## November 2020
{: #containers-nov20}



### 24 November 2020
{: #containers-nov2420}
{: release-note}

New! Reservations to reduce classic worker node costs
:   Create a reservation with contracts for 1 or 3 year terms for classic worker nodes to lock in a reduced cost for the life of the contract. Typical savings range between 30-50% compared to worker node costs. Reservations can be created in the {{site.data.keyword.cloud_notm}} console for classic infrastructure only. For more information, see [Reserving instances to reduce classic worker node costs](/docs/containers?topic=containers-reservations).

### 23 November 2020
{: #containers-nov2320}
{: release-note}

Worker node versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.19.4_1527](/docs/containers?topic=containers-changelog_119#1194_1527_worker), [1.18.12_1533](/docs/containers?topic=containers-118_changelog#11812_1533_worker), [1.17.14_1545](/docs/containers?topic=containers-117_changelog#11714_1545_worker), and [1.16.15_1552](/docs/containers?topic=containers-116_changelog#11615_1552_worker).

### 20 November 2020
{: #containers-nov2020}
{: release-note}

New! Portieris for image security enforcement
:   With the [open source Portieris project](https://github.com/IBM/portieris){: external}, you can set up a Kubernetes admission controller to enforce image security policies by namespace or cluster. Use [Portieris](/docs/Registry?topic=Registry-security_enforce_portieris) instead of the deprecated Container Image Security Enforcement Helm chart.

### 19 November 2020
{: #containers-nov1920}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 653 and the `ingress-auth` build to 425](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

### 18 November 2020
{: #containers-nov1820}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.197](/docs/containers?topic=containers-cs_cli_changelog#10).



Knative add-on deprecation
:   As of 18 November 2020 the Knative managed add-on is deprecated. On 18 December 2020 the add-on becomes unsupported and can no longer be installed, and on 18 January 2021 the add-on is automatically uninstalled from all clusters. If you use the Knative add-on, consider migrating to the [Knative open source project](https://knative.dev/docs/install/){: external} or to [{{site.data.keyword.codeenginefull}}](/docs/codeengine?topic=codeengine-getting-started), which includes the open source capabilities of Knative.



New! {{site.data.keyword.block_storage_is_short}} changelog
:   Added a [change log(/docs/containers?topic=containers-vpc_bs_changelog) for the {{site.data.keyword.block_storage_is_short}} add-on.

### 16 November 2020
{: #containers-nov1620}
{: release-note}


      
GPU worker nodes
:   Added a reference to the [NVIDIA GPU operator installation guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#operator-install-guide){: external} in the [deploying a sample GPU workload](/docs/containers?topic=containers-deploy_app#gpu_app) topic.


  
Master versions
:   Master fix pack update change log documentation is available for Kubernetes version [1.19.4_1527](/docs/containers?topic=containers-changelog_119#1194_1527), [1.18.12_1533](/docs/containers?topic=containers-118_changelog#11812_1533), [1.17.14_1545](/docs/containers?topic=containers-117_changelog#11714_1545), and [1.16.15_1552](/docs/containers?topic=containers-116_changelog#11615_1552)..

### 13 November 2020
{: #containers-nov1320}
{: release-note}

{{site.data.keyword.at_full_notm}} and IAM events
:   Added [IAM actions and {{site.data.keyword.cloudaccesstrailshort}} events](/docs/containers?topic=containers-api-at-iam#ks-ingress) for the Ingress secret, Ingress ALB, and NLB DNS APIs.

### 9 November 2020
{: #containers-nov0920}
{: release-note}



Worker node versions
:   Worker node fix pack update change log documentation is available.

:   Kubernetes version [1.19.3_1526](/docs/containers?topic=containers-changelog_119#1193_1526), [1.18.10_1532](/docs/containers?topic=containers-118_changelog#11810_1532), [1.17.13_1544](/docs/containers?topic=containers-117_changelog#11713_1544), and [1.16.15_1551](/docs/containers?topic=containers-116_changelog#11615_1551).

### 5 November 2020
{: #containers-nov0520}
{: release-note}

{{site.data.keyword.block_storage_is_short}}
:   Added topics for [verifying your {{site.data.keyword.block_storage_is_short}} file system](/docs/containers?topic=containers-vpc-block#vpc-block-fs-verify), [enabling every user to customize the default PVC settings](/docs/containers?topic=containers-vpc-block#customize-with-secret), and [enforcing base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key CRN](/docs/containers?topic=containers-vpc-block#static-secret).

Classic-enabled VPCs
:   Added steps in [Creating VPC subnets for classic access](/docs/containers?topic=containers-vpc-subnets#ca_subnet_cli) for creating a classic-enabled VPC and VPC subnets without the automatic default address prefixes.



Gateway firewalls and Calico policies
:   For classic clusters in Dallas and Frankfurt, updated the required IP addresses and ports that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound), [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private), or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies){: external}.


 
Istio add-on
:   Versions [1.6.13](/docs/containers?topic=containers-istio-changelog#1613) and [1.7.4](/docs/containers?topic=containers-istio-changelog#174) of the Istio managed add-on are released.



### 2 November 2020
{: #containers-nov0220}
{: release-note}



General availability of Kubernetes Ingress support
:   The Kubernetes Ingress image, which is built on the community Kubernetes project's implementation of the NGINX Ingress controller, is now generally available for the Ingress ALBs in your cluster.



Persistent storage
:   Added the following topics.
    - [Creating {{site.data.keyword.cos_full_notm}} service credentials](/docs/containers?topic=containers-storage-cos-understand#create_cos_secret)
    - [Adding your {{site.data.keyword.cos_full_notm}} credentials to the default storage classes](/docs/containers?topic=containers-storage-cos-understand#service_credentials)
    - [Backing up and restoring storage data](/docs/containers?topic=containers-storage_br)
    


## October 2020
{: #containers-oct20}

### 26 October 2020
{: #containers-oct2620}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available.

:   Kubernetes version [1.19.3_1525](/docs/containers?topic=containers-changelog_119#1193_1525), [1.18.10_1531](/docs/containers?topic=containers-118_changelog#11810_1531), [1.17.13_1543](/docs/containers?topic=containers-117_changelog#11713_1543), and [1.16.15_1550](/docs/containers?topic=containers-116_changelog#11615_1550).

Worker node versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.19.3_1525](/docs/containers?topic=containers-changelog_119#1193_1525_worker), [1.18.10_1531](/docs/containers?topic=containers-118_changelog#11810_1531_worker), [1.17.13_1543](/docs/containers?topic=containers-117_changelog#11713_1543_worker), and [1.16.15_1550](/docs/containers?topic=containers-116_changelog#11615_1550_worker).


### 22 October 2020
{: #containers-oct2220}
{: release-note}

API key
:   Added more information about [how the {{site.data.keyword.containerlong_notm}} API key is used](/docs/containers?topic=containers-access-creds#api_key_about).



Benchmark for Kubernetes 1.19
:   Review the [1.5 CIS Kubernetes benchmark results](/docs/containers?topic=containers-cis-benchmark-119) for clusters that run Kubernetes version 1.19.

Huge pages
:   In clusters that run Kubernetes 1.19 or later, you can [enable Kubernetes `HugePages` scheduling on your worker nodes](/docs/containers?topic=containers-kernel#huge-pages).

Istio add-on
:   Version [1.6.12](/docs/containers?topic=containers-istio-changelog#1612) of the Istio managed add-on is released.


  
### 16 October 2020
{: #containers-oct1620}
{: release-note}

Gateway firewalls and Calico policies
:   For classic clusters in Dallas, updated the required IP addresses and ports that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound), [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private), or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies){: external}.



Ingress classes
:   Added information about [specifying Ingress classes](/docs/containers?topic=containers-managed-ingress-about#managed-ingress-class) to apply Ingress resources to specific ALBs.



{{site.data.keyword.cos_short}}

:   Added steps to help you [decide on the object storage configuration](/docs/containers?topic=containers-storage_cos_install#configure_cos) and added troubleshooting steps for when [app pods fail because of an `Operation not permitted` error](/docs/containers?topic=containers-cos_operation_not_permitted).


### 13 October 2020
{: #containers-oct1320}
{: release-note}



New! Certified Kubernetes version 1.19
:   You can now create clusters that run Kubernetes version 1.19. To update an existing cluster, see the [Version 1.19 preparation actions](/docs/containers?topic=containers-cs_versions_119). The Kubernetes 1.19 release is also certified.

Deprecated: Kubernetes version 1.16
:   With the release of version 1.19, clusters that run version 1.16 are deprecated. Update your clusters to at least [version 1.17](/docs/containers?topic=containers-cs_versions#k8s_version_archive) today.

New! Network load balancer for VPC
:   In VPC Gen 2 clusters that run Kubernetes version 1.19, you can now create a layer 4 Network Load Balancer for VPC. VPC network load balancers offer source IP preservation and increased performance through direct server return (DSR). For more information, see [About VPC load balancing in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-vpc-lbaas#lbaas_about).



Version changelogs
:   Changelog documentation is available for [1.19.2_1524](/docs/containers?topic=containers-changelog_119#1192_1524).

VPC load balancer
:   Added support for setting the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-node-selector` and `service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-subnet` annotations when you create new VPC load balancers in clusters that run Kubernetes version 1.19.

VPC security groups
:   Expanded the list of required rules based on the cluster version for default VPC security groups.

{{site.data.keyword.cos_short}} in VPC Gen 2
:   Added support for authorized IP addresses in {{site.data.keyword.cos_full_notm}} for VPC Gen 2. For more information, see [Allowing IP addresses for {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-storage_cos_vpc_ip).

### 12 October 2020
{: #containers-oct1220}
{: release-note}

Versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.9_1530](/docs/containers?topic=containers-118_changelog#1189_1530), [1.17.12_1542](/docs/containers?topic=containers-117_changelog#11712_1542), and [1.16.15_1549](/docs/containers?topic=containers-116_changelog#11615_1549).


### 8 October 2020
{: #containers-oct0820}
{: release-note}

Ingress ALB changelog
:   Updated the [Kubernetes Ingress image build to `0.35.0_474_iks`](/docs/containers?topic=containers-cluster-add-ons-changelog#0_35_0).

### 6 October 2020
{: #containers-oct0620}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.178](/docs/containers?topic=containers-cs_cli_changelog#10).

Ingress secret expiration synchronization
:   Added a troubleshooting topic for when Ingress secret expiration dates are out of sync or are not updated.



Istio add-on
:   Versions [1.7.3](/docs/containers?topic=containers-istio-changelog#173) and [1.6.11](/docs/containers?topic=containers-istio-changelog#1611) of the Istio managed add-on are released.



### 1 October 2020
{: #containers-oct0120}
{: release-note}

Default version
:   The default version for clusters is now 1.18.

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 652 and the `ingress-auth` build to 424](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.

## September 2020
{: #containers-sep20}



### 29 September 2020
{: #containers-sept2920}
{: release-note}

Gateway firewalls and Calico policies
:   For classic clusters in London or Dallas, updated the required IP addresses and ports that you must open in a [public gateway firewall device](/docs/containers?topic=containers-firewall#firewall_outbound), [private gateway device firewall](/docs/containers?topic=containers-firewall#firewall_private), or [Calico network isolation policies](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies){: external}.

### 26 September 2020
{: #containers-sept2620}
{: release-note}

Versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.9_1529](/docs/containers?topic=containers-118_changelog#1189_1529), [1.17.12_1541](/docs/containers?topic=containers-117_changelog#11712_1541), and [1.16.15_1548](/docs/containers?topic=containers-116_changelog#11615_1548).


### 24 September 2020
{: #containers-sept2420}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.171](/docs/containers?topic=containers-cs_cli_changelog#10).

### 23 September 2020
{: #containers-sept2320}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` build to 651 and the `ingress-auth` build to 423](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for the {{site.data.keyword.containerlong_notm}} Ingress image.



Istio add-on
:   Version [1.7.2](/docs/containers?topic=containers-istio-changelog#172) of the Istio managed add-on is released.



### 22 September 2020
{: #containers-sept2220}
{: release-note}

Unsupported: Kubernetes version 1.15
:   Clusters that run version 1.15 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.

### 21 September 2020
{: #containers-sept2120}
{: release-note}

Versions
:   Master fix pack update change log documentation is available.
:   Kubernetes version [1.18.9_1528](/docs/containers?topic=containers-118_changelog#1189_1528), [1.17.12_1540](/docs/containers?topic=containers-117_changelog#11712_1540), and [1.16.15_1547](/docs/containers?topic=containers-116_changelog#11615_1547).




Versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.8_1527](/docs/containers?topic=containers-118_changelog#1188_1527), [1.17.11_1539](/docs/containers?topic=containers-117_changelog#11711_1539), [1.16.14_1546](/docs/containers?topic=containers-116_changelog#11614_1546), and [1.15.12_1552](/docs/containers?topic=containers-115_changelog#11512_1552).




Istio add-on
:   Versions [1.7.1](/docs/containers?topic=containers-istio-changelog#171) and [1.6.9](/docs/containers?topic=containers-istio-changelog#169) of the Istio managed add-on are released.

VPC load balancer
:   In version 1.18 and later VPC clusters, added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "proxy-protocol"` annotation to preserve the source IP address of requests to apps in your cluster.
  
### 4 September 2020
{: #containers-sept0420}
{: release-note}

New! CIS Kubernetes Benchmark
:   Added information about {{site.data.keyword.containerlong_notm}} compliance with the [Center for Internet Security (CIS) Kubernetes Benchmark](/docs/containers?topic=containers-cis-benchmark) 1.5 for clusters that run Kubernetes version 1.18.



### 3 September 2020
{: #containers-sept0320}
{: release-note}

CA certificate rotation
:   Added steps to [revoke existing certificate authority (CA) certificates in your cluster and issue new CA certificates](/docs/containers?topic=containers-security#cert-rotate).


  
### 2 September 2020
{: #containers-sept0220}
{: release-note}

Istio add-on
:   [Version 1.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#v17) is released.

### 1 September 2020
{: #containers-sept120}
{: release-note}

Deprecation of VPC Gen 1 compute
:   Virtual Private Cloud Generation 1 is deprecated. If you did not create any VPC Gen 1 resources before 01 September 2020, you can no longer provision any VPC Gen 1 resources. If you created any VPC Gen 1 resources before 01 September 2020, you can continue to provision and use VPC Gen 1 resources until 26 February 2021, when all service for VPC Gen 1 ends and all remaining VPC Gen 1 resources are deleted. To ensure continued support, create new VPC clusters on Generation 2 compute only, and move your workloads from existing VPC Gen 1 clusters to VPC Gen 2 clusters.

Istio add-on
:   [Version 1.5.10](/docs/containers?topic=containers-istio-changelog#1510) of the Istio managed add-on is released.




## August 2020
{: #containers-aug20}

### 31 August 2020
{: #containers-aug3120}
{: release-note}

Versions
:   Worker node fix pack update change log documentation is available. 
:   Kubernetes version [1.18.8_1526](/docs/containers?topic=containers-118_changelog#1188_1526), [1.17.11_1538](/docs/containers?topic=containers-117_changelog#11711_1538), [1.16.14_1545](/docs/containers?topic=containers-116_changelog#11614_1545), and [1.15.12_1551](/docs/containers?topic=containers-115_changelog#11512_1551).


### 27 August 2020
{: #containers-aug2720}
{: release-note}

Observability CLI plug-in
:   Added the following commands to manage your {{site.data.keyword.la_full_notm}} and {{site.data.keyword.mon_full_notm}} configurations.
    - [**`ibmcloud ob logging agent discover`**](/docs/containers?topic=containers-observability_cli#logging_agent_discover)
    - [**`ibmcloud ob logging config enable public-endpoint`** or `private-endpoint`](/docs/containers?topic=containers-observability_cli#logging_config_enable)
    - [**`ibmcloud ob logging config show`**](/docs/containers?topic=containers-observability_cli#logging_config_show)
    - [**`ibmcloud ob monitoring agent discover`**](/docs/containers?topic=containers-observability_cli#monitoring_agent_discover)
    - [**`ibmcloud ob monitoring config enable public-endpoint`** or `private-endpoint`](/docs/containers?topic=containers-observability_cli#monitoring_config_enable)

New! Worker node flavors
:   You can create worker nodes with new [bare metal](/docs/containers?topic=containers-planning_worker_nodes#bm-table) and [bare metal SDS](/docs/containers?topic=containers-planning_worker_nodes#sds-table) flavors in the `me4c` and `mb4c` flavors. These flavors include 2nd Generation Intel® Xeon® Scalable Processors chip sets for better performance for workloads such as machine learning, AI, and IoT.

### 24 August 2020
{: #containers-aug2420}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.157](/docs/containers?topic=containers-cs_cli_changelog#10).

Cluster autoscaler
:   The [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) is available as a managed add-on. The cluster autoscaler Helm chart is deprecated. Migrate your autoscaled worker pools to use the add-on.

New! Community Kubernetes Ingress support
:   The Ingress ALBs in your cluster can now run the Kubernetes Ingress image, which is built on the community Kubernetes project's implementation of the NGINX Ingress controller. To use the Kubernetes Ingress image, you create your Ingress resources and ConfigMaps according to the Kubernetes Ingress format, including community Kubernetes Ingress annotations instead of custom {{site.data.keyword.containerlong_notm}} annotations. 

New! Default {{site.data.keyword.cloudcerts_long}} instances
:   An {{site.data.keyword.cloudcerts_long_notm}} service instance is now created by default for all new and existing standard clusters. The {{site.data.keyword.cloudcerts_short}} service instance, which is named in the format `kube-crtmgr-<cluster_ID>`, stores the TLS certificate for your cluster's default Ingress subdomain. You can also upload your own TLS certificates for custom Ingress domains to this {{site.data.keyword.cloudcerts_short}} instance and use the new [**`ibmcloud ks ingress secret`** commands](/docs/containers?topic=containers-kubernetes-service-cli#cs_ingress_secret_create) to create secrets for these certificates in your cluster. To ensure that a {{site.data.keyword.cloudcerts_short}} instance is automatically created for your new or existing cluster, verify that the API key for the region and resource group that the cluster is created in has the correct {{site.data.keyword.cloudcerts_short}} permissions.



### 18 August 2020
{: #containers-aug1820}
{: release-note}

Versions
:   Master fix pack update change log documentation is available.
:   Kubernetes version [1.18.8_1525](/docs/containers?topic=containers-118_changelog#1188_1525_master), [1.17.11_1537](/docs/containers?topic=containers-117_changelog#11711_1537_master), [1.16.14_1544](/docs/containers?topic=containers-116_changelog#11614_1544_master), and [1.15.12_1550](/docs/containers?topic=containers-115_changelog#11512_1550_master).


### 17 August 2020
{: #containers-aug1720}
{: release-note}

Locations
:   You can create [clusters on VPC infrastructure](/docs/containers?topic=containers-regions-and-zones#zones-vpc) in the Tokyo multizone region.

Versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.8_1525](/docs/containers?topic=containers-118_changelog#1188_1525), [1.17.11_1537](/docs/containers?topic=containers-117_changelog#11711_1537), [1.16.14_1544](/docs/containers?topic=containers-116_changelog#11614_1544), and [1.15.12_1550](/docs/containers?topic=containers-115_changelog#11512_1550)
.


  
VPC Gen 2
:   Added a tutorial for migrating VPC Gen 1 cluster resources to VPC Gen 2.

  
### 12 August 2020
{: #containers-aug1220}
{: release-note}

Istio add-on
:   [Version 1.6.8](/docs/containers?topic=containers-istio-changelog#168) and [version 1.5.9](/docs/containers?topic=containers-istio-changelog#159) of the Istio managed add-on are released.



### 6 August 2020
{: #containers-aug0620}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.143](/docs/containers?topic=containers-cs_cli_changelog#10).

### 5 August 2020
{: #containers-aug0520}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 647 and the `ingress-auth` image build to 421](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).


  
### 4 August 2020
{: #containers-aug0420}
{: release-note}

Istio add-on
:   [Version 1.6.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#167) is released.



### 3 August 2020
{: #containers-aug0320}
{: release-note}

Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_private) that you must open in a private gateway device firewall.

Versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.6_1523](/docs/containers?topic=containers-118_changelog#1186_1523), [1.17.9_1535](/docs/containers?topic=containers-117_changelog#1179_1535), [1.16.13_1542](/docs/containers?topic=containers-116_changelog#11613_1542), and [1.15.12_1549](/docs/containers?topic=containers-115_changelog#11512_1549).


## July 2020
{: #containers-july20}

### 31 July 2020
{: #containers-july3120}
{: release-note}

{{site.data.keyword.redhat_openshift_notm}} version 4.4
:   The [{{site.data.keyword.redhat_openshift_notm}} version 4.4 release](/docs/containers?topic=containers-cs_versions#k8s_version_archive) is certified for Kubernetes version 1.17.

### 28 July 2020
{: #containers-july2820}
{: release-note}

Ingress ALB versions
:   Added the `ibmcloud ks ingress alb versions` CLI command to show the available versions for the ALBs in your cluster and the `ibmcloud ks ingress alb update` CLI command to update or rollback ALBs to a specific version.

UI for creating clusters
:   Updated getting started and task topics for the updated process for the [Kubernetes cluster creation console](https://cloud.ibm.com/kubernetes/catalog/create){: external}.

### 24 July 2020
{: #containers-july2420}
{: release-note}

Minimum cluster size
:   Added an FAQ about [the smallest size cluster that you can make](/docs/containers?topic=containers-faqs#smallest_cluster).

Versions
:   Master fix pack update change log documentation is available.
:   Kubernetes version [1.18.6_1522](/docs/containers?topic=containers-118_changelog#1186_1522), [1.17.9_1534](/docs/containers?topic=containers-117_changelog#1179_1534), [1.16.13_1541](/docs/containers?topic=containers-116_changelog#11613_1541), and [1.15.12_1548](/docs/containers?topic=containers-115_changelog#11512_1548).


Worker node replacement
:   Added a troubleshooting topic for when [replacing a worker node does not create a worker node](/docs/containers?topic=containers-auto-rebalance-off).



### 20 July 2020
{: #containers-july2020}
{: release-note}

Master versions
:   Master fix pack update change log documentation is available.
:   Kubernetes version [1.18.6_1521](/docs/containers?topic=containers-118_changelog#1186_1521), [1.17.9_1533](/docs/containers?topic=containers-117_changelog#1179_1533), [1.16.13_1540](/docs/containers?topic=containers-116_changelog#11613_1540), and [1.15.12_1547](/docs/containers?topic=containers-115_changelog#11512_1547).


Worker node versions
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.6_1520](/docs/containers?topic=containers-118_changelog#1186_1520), [1.17.9_1532](/docs/containers?topic=containers-117_changelog#1179_1532), [1.16.13_1539](/docs/containers?topic=containers-116_changelog#11613_1539), and [1.15.12_1546](/docs/containers?topic=containers-115_changelog#11512_1546).



  
### 17 July 2020
{: #containers-july1720}
{: release-note}

Istio add-on
:   [Version 1.6.5 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#165) is released.



### 16 July 2020
{: #containers-july1620}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 645 and the `ingress-auth` image build to 420](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).



Istio add-on
:   [Version 1.5.8 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#158) is released.

Istio ports
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) that you must open in a public gateway device to use the managed Istio add-on.


Pod and service subnets
:   Added information about bringing your own pod and service subnets in [VPC clusters](/docs/containers?topic=containers-subnets#basics_subnets) classic or (/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets).



### 8 July 2020
{: #containers-july0820}
{: release-note}

Istio add-on
:   [Version 1.6 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#16) is released.

Knative add-on
:   Version 0.15.1 of the Knative managed add-on is released. If you installed the Knative add-on before, you must uninstall and reinstall the add-on to apply these changes in your cluster.



### 7 July 2020
{: #containers-july0720}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.118](/docs/containers?topic=containers-cs_cli_changelog#10).

### 6 July 2020
{: #containers-july0620}
{: release-note}

Version changelogs
:   Worker node fix pack update change log documentation is available.
:   Kubernetes version [1.18.4_1518](/docs/containers?topic=containers-118_changelog#1184_1518), [1.17.7_1530](/docs/containers?topic=containers-117_changelog#1177_1530), [1.16.11_1537](/docs/containers?topic=containers-116_changelog#11611_1537), and [1.15.12_1544](/docs/containers?topic=containers-115_changelog#11512_1544).


### 2 July 2020
{: #containers-july0220}
{: release-note}



VPC load balancer
:   Added support for specifying the `service.kubernetes.io/ibm-load-balancer-cloud-provider-zone` annotation in the [configuration file for VPC load balancers](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb).

## June 2020
{: #containers-june20}

### 24 June 2020
{: #containers-june2420}
{: release-note}

Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) that you must open in a public gateway device.

Ingress ALB changelog
:   Updated the [`ingress-auth` image build to 413](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 23 June 2020
{: #containers-june2320}
{: release-note}



Istio add-on
:   [Version 1.5.6 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#15) is released.



### 22 June 2020
{: #containers-june2220}
{: release-note}

Version changelogs
:   Changelog documentation is available.
:   Kubernetes version [1.18.4_1517](/docs/containers?topic=containers-118_changelog#1184_1517), [1.17.7_1529](/docs/containers?topic=containers-117_changelog#1177_1529), [1.16.11_1536](/docs/containers?topic=containers-116_changelog#11611_1536), and [1.15.12_1543](/docs/containers?topic=containers-115_changelog#11512_1543).


### 18 June 2020
{: #containers-june1820}
{: release-note}

Ingress ALB changelog
:   Updated the [`ingress-auth` image build to 413](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 16 June 2020
{: #containers-june1620}
{: release-note}



CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.99](/docs/containers?topic=containers-cs_cli_changelog#10).

### 9 June 2020
{: #containers-june0920}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.94](/docs/containers?topic=containers-cs_cli_changelog#10).

Permissions
:   Added a [Permissions to create a cluster](/docs/containers?topic=containers-access_reference#cluster_create_permissions) reference topic, and restructured cluster creation and user access topics to refer to this reference topic.

New! Static routes add-on
:   Added information about creating static routes on your worker nodes by enabling the [static routes cluster add-on](/docs/containers?topic=containers-static-routes).

### 8 June 2020
{: #containers-june0820}
{: release-note}

Version changelogs
:   Worker node change log documentation is available.
:   Kubernetes [1.18.3_1515](/docs/containers?topic=containers-118_changelog#1183_1515), [1.17.6_1527](/docs/containers?topic=containers-117_changelog#1176_1527), [1.16.10_1534](/docs/containers?topic=containers-116_changelog#11610_1534), and [1.15.12_1541](/docs/containers?topic=containers-115_changelog#11512_1541)


### 4 June 2020
{: #containers-june0420}
{: release-note}



Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) that you must open in a public gateway device firewall.

Istio mTLS
:   Changed the sample [mTLS policy](/docs/containers?topic=containers-istio-mesh#mtls) to use `kind: "PeerAuthentication"`.



Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 637](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).


VPC network security
:   Expanded information about your options for using access control lists (ACLs), security groups, and other network policies to [control traffic to and from your VPC cluster](/docs/containers?topic=containers-vpc-network-policy).

### 1 June 2020
{: #containers-june0120}
{: release-note}



Kubernetes 1.17
:   [Kubernetes 1.17](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.



VPC ACLs
:   Added required rules for using VPC load balancers to steps for [Creating access control lists (ACLs) to control traffic to and from your VPC cluster](/docs/openshift?topic=openshift-vpc-acls).


## May 2020
{: #containers-may20}



### 31 May 2020
{: #containers-may3120}
{: release-note}

Unsupported: Kubernetes version 1.14
:   With the release of version 1.18, clusters that run version 1.14 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.



### 26 May 2020
{: #containers-may2620}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.84](/docs/containers?topic=containers-cs_cli_changelog#10).

Image pull secrets
:   Now, the `default-icr-io` and `default-<region>-icr-io` image pull secrets in the `default` project are replaced by a single `all-icr-io` image pull secret that has credentials to all the public and private regional registry domains. Clusters that run Kubernetes 1.15 - 1.17 still have the previous `default-<region>-icr-io` image pull secrets for backwards compatibility.

Ingress status
:   Added information about [health reporting for your Ingress components](/docs/containers?topic=containers-ingress-status).



NodeLocal DNS cache
:   Added how to customize the [NodeLocal DNS cache](/docs/containers?topic=containers-cluster_dns#dns_nodelocal_customize).



Version changelogs
:   Master and worker node change log documentation is available.
:   Kubernetes [1.18.3_1514](/docs/containers?topic=containers-118_changelog#1183_1514), [1.17.6_1526](/docs/containers?topic=containers-117_changelog#1176_1526), [1.16.10_1533](/docs/containers?topic=containers-116_changelog#11610_1533), [1.15.12_1540](/docs/containers?topic=containers-115_changelog#11512_1540), and [1.14.10_1555](/docs/containers?topic=containers-114_changelog#11410_1555).


  
### 20 May 2020
{: #containers-may2020}
{: release-note}

New! Virtual Private Cloud Generation 2
:   You can now create standard Kubernetes clusters in your [Gen 2 Virtual Private Cloud (VPC)](/docs/vpc?topic=vpc-getting-started). VPC gives you the security of a private cloud environment with the dynamic scalability of a public cloud. VPC Gen 2 clusters are available for only standard, Kubernetes clusters and are not supported in free clusters.

:   For more information, check out the following links. 
    - [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers)
    - [Supported virtual machine flavors for VPC Gen 2 worker nodes](/docs/containers?topic=containers-planning_worker_nodes#vm)
    - [New VPC Gen 2 commands for the CLI](/docs/containers?topic=containers-kubernetes-service-cli)
    - [VPC cluster limitations](/docs/containers?topic=containers-limitations#ks_vpc_gen2_limits)
    
:   Ready to get started? Try out the [Creating a cluster in your VPC on generation 2 compute tutorial](/docs/containers?topic=containers-vpc_ks_tutorial).



### 19 May 2020
{: #containers-may1920}
{: release-note}

Istio add-on
:   [Version 1.5 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#15) is released.



### 18 May 2020
{: #containers-may1820}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 628](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).


  
### 14 May 2020
{: #containers-may1420}
{: release-note}

Kubernetes version 1.18
:   [Kubernetes 1.18 release](/docs/containers?topic=containers-cs_versions#k8s_version_archive) is certified.





### 11 May 2020
{: #containers-may1120}
{: release-note}



New! Kubernetes version 1.18
:   You can now create clusters that run Kubernetes version 1.18. To update an existing cluster, see the [Version 1.18 preparation actions](/docs/containers?topic=containers-cs_versions#k8s_version_archive).

Deprecated: Kubernetes version 1.15
:   With the release of version 1.18, clusters that run version 1.15 are deprecated. Consider [updating to at least version 1.16](/docs/containers?topic=containers-cs_versions#k8s_version_archive) today.

NodeLocal DNS cache
:   [NodeLocal DNS cache](/docs/containers?topic=containers-cluster_dns#dns_cache) is generally available for clusters that run Kubernetes 1.18, but still not enabled by default.

Zone-aware DNS beta
:   For multizone clusters that run Kubernetes 1.18, you can set up [zone-aware DNS](/docs/containers?topic=containers-cluster_dns#dns_zone_aware) to improve DNS performance and availability.

Version changelogs
:   Changelog documentation is available for Kubernetes version [1.18.2_1512](/docs/containers?topic=containers-118_changelog#1182_1512).
:   Kubernetes [1.17.5_1524](/docs/containers?topic=containers-117_changelog#1175_1524), [1.16.9_1531](/docs/containers?topic=containers-116_changelog#1169_1531), [1.15.11_1538](/docs/containers?topic=containers-115_changelog#11511_1538), and [1.14.10_1554](/docs/containers?topic=containers-114_changelog#11410_1554)


### 8 May 2020
{: #containers-may0820}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.57](/docs/containers?topic=containers-cs_cli_changelog#10).



### 6 May 2020
{: #containers-may0620}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} observability plug-in
:   You can now use the {{site.data.keyword.containerlong_notm}} observability plug-in to create a logging or monitoring configuration for your cluster so that you can forward cluster logs and metrics to an {{site.data.keyword.la_full_notm}} and {{site.data.keyword.mon_full_notm}} service instance. For more information, see [Forwarding cluster and app logs to {{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health#logging) and [Viewing cluster and app metrics with {{site.data.keyword.mon_full_notm}}](/docs/containers?topic=containers-health-monitor). You can also use the command line to create the logging and monitoring configuration. For more information, see the [Observability plug-in CLI](/docs/containers?topic=containers-observability_cli) reference.



### 4 May 2020
{: #containers-may0420}
{: release-note}

Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) that you must open in a public gateway device firewall.

Ingress troubleshooting
:   Added a [troubleshooting topic](/docs/containers?topic=containers-alb-pod-affinity) for when ALB pods don't deploy correctly to worker nodes.

## April 2020
{: #containers-apr20}

### 30 April 2020
{: #containers-april3020}
{: release-note}

Cluster and worker node quotas
:   Now, each region in your {{site.data.keyword.cloud_notm}} account has quotas for {{site.data.keyword.containershort}} clusters and workers. You can have **100 clusters** and **500 worker nodes** across clusters per region and per [infrastructure provider](/docs/containers?topic=containers-infrastructure_providers). With quotas in place, your account is better protected from accidental requests or billing surprises. Need more clusters? No problem, just [contact IBM Support](/docs/get-support?topic=get-support-using-avatar). In the support case, include the new cluster or worker node quota limit for the region and infrastructure provider that you want. For more information, see the [Service limitations](/docs/containers?topic=containers-limitations).

### 29 April 2020
{: #containers-april2920}
{: release-note}

ALB pod scaling
:   Added steps for scaling up your ALB processing capabilities by [increasing the number of ALB pods replicas](/docs/containers?topic=containers-ingress-alb-manage#alb_replicas).



VPC cluster architecture
:   Refreshed [networking diagrams for VPC scenarios](/docs/containers?topic=containers-service-arch#architecture_vpc).

VPC cluster master access
:   Updated [accessing the master via a private cloud service endpoint](/docs/containers?topic=containers-access_cluster#vpc_private_se) for VPC clusters.



### 27 April 2020
{: #containers-april2720}
{: release-note}

Ingress ALB changelog
:   Updated the [`ingress-auth` image build to 401](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Version changelogs
:   Kubernetes [1.17.5_1523](/docs/containers?topic=containers-117_changelog#1175_1523), [1.16.9_1530](/docs/containers?topic=containers-116_changelog#1169_1530), [1.15.11_1537](/docs/containers?topic=containers-115_changelog#11511_1537), and [1.14.10_1553](/docs/containers?topic=containers-114_changelog#11410_1553)


### 23 April 2020
{: #containers-april2320}
{: release-note}

Version changelogs
:   Kubernetes [1.17.5_1522](/docs/containers?topic=containers-117_changelog#1175_1522), [1.16.9_1529](/docs/containers?topic=containers-116_changelog#1169_1529), [1.15.11_1536](/docs/containers?topic=containers-115_changelog#11511_1536), and [1.14.10_1552](/docs/containers?topic=containers-114_changelog#11410_1552).


### 22 April 2020
{: #containers-april2220}
{: release-note}

 

Private network connection to registry
:   For accounts that have VRF and service endpoints enabled, image push and pull traffic to {{site.data.keyword.registrylong_notm}} is now on [the private network](/docs/containers?topic=containers-registry#cluster_registry_auth_private).



### 17 April 2020
{: #containers-april1720}
{: release-note}

Version changelog
:   Master patch updates are available for Kubernetes [1.17.4_1521](/docs/containers?topic=containers-117_changelog#1174_1521_master).



### 16 April 2020
{: #containers-april1620}
{: release-note}

Ingress ALB changelog
:   Updated the [`ingress-auth` image build to 394](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 13 April 2020
{: #containers-april1320}
{: release-note}

Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_private) that you must open in a private gateway device firewall for {{site.data.keyword.registrylong_notm}}.



Version changelogs
:   Worker node patch updates are available.
:   Kubernetes [1.17.4_1521](/docs/containers?topic=containers-117_changelog#1174_1521), [1.16.7_1528](/docs/containers?topic=containers-116_changelog#1168_1528), [1.15.10_1535](/docs/containers?topic=containers-115_changelog#11511_1535), and [1.14.10_1551](/docs/containers?topic=containers-114_changelog#11410_1551).


### 6 April 2020
{: #containers-april0620}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.28](/docs/containers?topic=containers-cs_cli_changelog#10).

 

Kubernetes cluster context
:   Added topics for [Setting the Kubernetes context for multiple clusters](/docs/containers?topic=containers-cs_cli_install#cli_config_multiple) and [Creating a temporary `kubeconfig` file](/docs/containers?topic=containers-cs_cli_install#cli_temp_kubeconfig).

### 1 April 2020
{: #containers-april0120}
{: release-note}

Istio add-on
:   [Version 1.4.7 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#147) is released.



## March 2020
{: #containers-mar20}

### 30 March 2020
{: #containers-mar3020}
{: release-note}

Version changelogs
:   Worker node patch updates are available.
:   Kubernetes [1.17.3_1520](/docs/containers?topic=containers-117_changelog#1174_1520), [1.16.7_1527](/docs/containers?topic=containers-116_changelog#1168_1527), [1.15.10_1534](/docs/containers?topic=containers-115_changelog#11511_1534), and [1.14.10_1550](/docs/containers?topic=containers-114_changelog#11410_1550).


File storage classes
:   Added `gid` file storage classes to specify a supplemental group ID that you can assign to a non-root user ID so that the non-root user can read and write to the file storage instance. For more information, see the storage class [reference](/docs/containers?topic=containers-file_storage#file_storageclass_reference). 

### 27 March 2020
{: #containers-mar2720}
{: release-note}

Tech overview
:   Added an [Overview of personal and sensitive data storage and removal options](/docs/containers?topic=containers-service-arch#ibm-data).

### 25 March 2020
{: #containers-mar2520}
{: release-note}



Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 627](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 24 March 2020
{: #containers-mar2420}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.15](/docs/containers?topic=containers-cs_cli_changelog#10).


### 18 March 2020
{: #containers-mar1820}
{: release-note}



IAM issuer details
:   Added a [reference topic](/docs/containers?topic=containers-access_reference) for the IAM issuer details of RBAC users.

### 16 March 2020
{: #containers-mar1620}
{: release-note}

New! CLI 1.0
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 1.0.0](/docs/containers?topic=containers-cs_cli_changelog#10). This version contains permanent syntax and behavior changes that are not compatible with earlier versions, so before you update be sure to follow the guidance in [Using version 1.0 of the plug-in](/docs/containers?topic=containers-cs_cli_changelog#changelog_beta).



Installing SGX drivers
:   Added a topic for [installing SGX drivers and platform software on SGX-capable worker nodes](/docs/containers?topic=containers-add_workers#install-sgx).

Sizing workloads
:   Enhanced the topic with a [How do I monitor resource usage and capacity in my cluster?](/docs/containers?topic=containers-strategy#sizing_manage) FAQ.
:   `sticky-cookie-services` annotation.
:   Added the `secure` and `httponly` parameters to the [`sticky-cookie-services` annotation](/docs/containers?topic=containers-comm-ingress-annotations#session-affinity-cookies).



Version changelogs
:   Master and worker node patch updates are available.
:   Kubernetes [1.17.4_1519](/docs/containers?topic=containers-117_changelog#1174_1519), [1.16.8_1526](/docs/containers?topic=containers-116_changelog#1168_1526), [1.15.11_1533](/docs/containers?topic=containers-115_changelog#11511_1533), and [1.14.10_1549](/docs/containers?topic=containers-114_changelog#11410_1549).


### 12 March 2020
{: #containers-mar1220}
{: release-note}





Version update policy
:   Now, you can update your cluster master version only to the next version (`n+1`). For example, if your cluster runs Kubernetes version 1.15 and you want to update to the latest version, 1.17, you must first update to 1.16.

### 10 March 2020
{: #containers-mar1020}
{: release-note}

Istio add-on
:   [Version 1.4.6 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#146) is released.



### 9 March 2020
{: #containers-mar0920}
{: release-note}

Managing Ingress ALBs
:   Added a page for [managing the lifecycle of your ALBs](/docs/containers?topic=containers-managed-ingress-about), including information about creating, updating, and moving ALBs.


  
Add-on troubleshooting
:   Added a troubleshooting page for managed add-ons, including a topic for [reviewing add-on state and statuses](/docs/containers?topic=containers-debug_addons).

Kubernetes 1.16
:   [Kubernetes 1.16](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.

Updating the {{site.data.keyword.block_storage_is_short}} add-on
:   Added steps to update the {{site.data.keyword.block_storage_is_short}} add-on.



### 4 March 2020
{: #containers-mar0420}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.102](/docs/containers?topic=containers-cs_cli_changelog#04).

Ingress ALB changelog
:   Updated the [`ingress-auth` image build to 390](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 2 March 2020
{: #containers-mar0220}
{: release-note}

Version changelogs
:   Worker node patch updates are available.
:   Kubernetes [1.17.3_1518](/docs/containers?topic=containers-117_changelog#1173_1518), [1.16.7_1525](/docs/containers?topic=containers-116_changelog#1167_1525), [1.15.10_1532](/docs/containers?topic=containers-115_changelog#11510_1532), and [1.14.10_1548](/docs/containers?topic=containers-114_changelog#11410_1548).


## February 2020
{: #containers-feb20}



### 28 February 2020
{: #containers-feb2820}
{: release-note}

VPC clusters
:   You can create VPC generation 1 compute clusters in the [**Washington DC** location (`us-east` region)](/docs/containers?topic=containers-regions-and-zones#zones-vpc).

### 22 February 2020
{: #containers-feb2220}
{: release-note}

Unsupported: Kubernetes version 1.13
:   With the release of version 1.17, clusters that run version 1.13 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.



### 19 February 2020
{: #containers-feb1920}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.90](/docs/containers?topic=containers-cs_cli_changelog).



Developing and deploying apps
:   You can now find expanded information on how to develop and deploy an app to your cluster in the following pages.
    - [Planning app deployments](/docs/containers?topic=containers-plan_deploy)
    - [Building containers from images](/docs/containers?topic=containers-images)
    - [Developing Kubernetes-native apps](/docs/containers?topic=containers-app)
    - [Deploying Kubernetes-native apps in clusters](/docs/containers?topic=containers-deploy_app)
    - [Managing the app lifecycle](/docs/containers?topic=containers-update_app)

Learning paths
:   Curated learning paths for [administrators](/docs/containers?topic=containers-learning-path-admin) and [developers](/docs/containers?topic=containers-learning-path-dev) are now available to help guide you through your {{site.data.keyword.containerlong_notm}} experience.

Setting up image build pipelines
:   You can now find expanded information on how to set up an image registry and build pipelines in the following pages. 
    - [Setting up an image registry](/docs/containers?topic=containers-registry)
    - [Setting up continuous integration and delivery](/docs/containers?topic=containers-cicd)
    
Firewall subnets
:   Removed outdated [subnet IP addresses for {{site.data.keyword.registrylong_notm}}](/docs/containers?topic=containers-firewall#vyatta_firewall).



### 17 February 2020
{: #containers-feb1720}
{: release-note}



Kubernetes version 1.17
:   [Kubernetes 1.17 release is certified](/docs/containers?topic=containers-cs_versions#k8s_version_archive).



Version changelogs
:   Master and worker node patch updates.
:   Kubernetes [1.17.3_1516](/docs/containers?topic=containers-117_changelog#1173_1516), [1.16.7_1524](/docs/containers?topic=containers-116_changelog#1167_1524), [1.15.10_1531](/docs/containers?topic=containers-115_changelog#11510_1531), [1.14.10_1547](/docs/containers?topic=containers-114_changelog#11410_1547), and [1.13.12_1550](/docs/containers?topic=containers-113_changelog#11312_1550)

  
### 14 February 2020
{: #containers-feb1420}
{: release-note}

Istio add-on
:   [Version 1.4.4 of the Istio managed add-on](/docs/containers?topic=containers-istio-changelog#144) is released.



### 10 February 2020
{: #containers-feb1020}
{: release-note}



New! Kubernetes version 1.17
:   You can now create clusters that run Kubernetes version 1.17. To update an existing cluster, see the [Version 1.17 preparation actions](/docs/containers?topic=containers-cs_versions#k8s_version_archive).

Deprecated: Kubernetes version 1.14
:   With the release of version 1.17, clusters that run version 1.14 are deprecated. Consider [updating to at least version 1.15](/docs/containers?topic=containers-cs_versions#k8s_version_archive) today.

VPC cluster creation troubleshooting
:   Added [troubleshooting steps](/docs/containers?topic=containers-ts_no_vpc) for when no VPCs are listed when you try to create a VPC cluster in the console.

Knative changelogs
:   Check out the changes that are in version 0.12.1 of the managed Knative add-on. If you installed the Knative add-on before, you must uninstall and reinstall the add-on to apply these changes in your cluster.



### 6 February 2020
{: #containers-feb0620}
{: release-note}

Cluster autoscaler
:   Added a [debugging guide for the cluster autoscaler](/docs/containers?topic=containers-debug_cluster_autoscaler).



Tags
:   Added how to [add {{site.data.keyword.cloud_notm}} tags to existing clusters](/docs/containers?topic=containers-add_workers#cluster_tags).

VPC security groups
:   [Modify the security group rules](/docs/openshift?topic=openshift-vpc-security-group)for VPC Gen 2 clusters to allow traffic requests that are routed to node ports on your worker nodes.

### 3 February 2020
{: #containers-feb0320}
{: release-note}

Version changelog
:   Kubernetes worker node fix packs [1.16.5_1523](/docs/containers?topic=containers-116_changelog#1165_1523), [1.15.8_1530](/docs/containers?topic=containers-115_changelog#1158_1530), [1.14.10_1546](/docs/containers?topic=containers-114_changelog#11410_1546), and [1.13.12_1549](/docs/containers?topic=containers-113_changelog#11312_1549).



  
Expanded troubleshooting
:   You can now find troubleshooting steps for {{site.data.keyword.containerlong_notm}} clusters in the following pages.
    - [Clusters and masters](/docs/containers?topic=containers-debug_clusters)
    - [Worker nodes](/docs/containers?topic=containers-debug_worker_nodes)
    - [Cluster networking](/docs/containers?topic=containers-coredns_lameduck)
    - [Apps and integrations](/docs/containers?topic=containers-debug_apps)
    - [Load balancers](/docs/containers?topic=containers-cs_loadbalancer_fails)
    - [Ingress](/docs/containers?topic=containers-debug_worker_nodes)
    - Persistent storage



## January 2020
{: #containers-jan20}

### 30 January 2020
{: #containers-jan3020}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 625](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 27 January 2020
{: #containers-jan2720}
{: release-note}



Istio changelog
:   Added an [Istio add-on version change log(/docs/containers?topic=containers-istio-changelog).



Back up and restore File and Block storage
:   Added steps for deploying the [`ibmcloud-backup-restore` Helm chart](/docs/containers?topic=containers-utilities#ibmcloud-backup-restore).

### 22 January 2020
{: #containers-jan2220}
{: release-note}



Kubernetes 1.15
:   [Kubernetes 1.15](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.

### 21 January 2020
{: #containers-jan2120}
{: release-note}

Default {{site.data.keyword.containerlong_notm}} settings
:   Review the [default settings](/docs/containers?topic=containers-service-settings) for Kubernetes components, such as the `kube-apiserver`, `kubelet`, or `kube-proxy`.



### 20 January 2020
{: #containers-jan2020}
{: release-note}

Helm version 3
:   Updated [Adding services by using Helm charts](/docs/containers?topic=containers-helm) to include steps for installing Helm v3 in your cluster. Migrate to Helm v3 today for several advantages over Helm v2, such as the removal of the Helm server, Tiller.

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 621](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog). 

Version changelog
:   Patch updates are available.
:   Kubernetes [1.16.5_1522](/docs/containers?topic=containers-116_changelog#1165_1522), [1.15.8_1529](/docs/containers?topic=containers-115_changelog#1158_1529), [1.14.10_1545](/docs/containers?topic=containers-114_changelog#11410_1545), and [1.13.12_1548](/docs/containers?topic=containers-113_changelog#11312_1548).



  
### 13 January 2020
{: #containers-jan1320}
{: release-note}

{{site.data.keyword.blockstorageshort}}
:   Added steps for [adding raw {{site.data.keyword.blockstorageshort}} to VPC worker nodes](/docs/containers?topic=containers-utilities#vpc_api_attach).

### 6 January 2020
{: #containers-jan0620}
{: release-note}

Ingress ALB changelog
:   Updated the [`ingress-auth` image to build 373](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 3 January 2020
{: #containers-jan0320}
{: release-note}

Version changelog
:   Worker node patch updates are available.
:   Kubernetes [1.16.3_1521](/docs/containers?topic=containers-116_changelog#1163_1521), [1.15.6_1528](/docs/containers?topic=containers-115_changelog#1156_1528), [1.14.9_1544](/docs/containers?topic=containers-114_changelog#1149_1544), and [1.13.12_1547](/docs/containers?topic=containers-113_changelog#11312_1547)


## December 2019
{: #containers-dec19}

### 18 December 2019
{: #containers-dec1819}
{: release-note}

Ingress ALB changelog
:   Updated the [`nginx-ingress` image build to 615 and the `ingress-auth` image to build 372](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 17 December 2019
{: #containers-dec1719}
{: release-note}

Version changelog
:   Master patch updates are available.
:   Kubernetes [1.16.3_1520](/docs/containers?topic=containers-116_changelog#1163_1520), [1.15.6_1527](/docs/containers?topic=containers-115_changelog#1156_1527), [1.14.9_1543](/docs/containers?topic=containers-114_changelog#1149_1543), and [1.13.12_1546](/docs/containers?topic=containers-113_changelog#11312_1546)




Adding classic infrastructure servers to gateway-enabled clusters
:   [Adding classic IBM Cloud infrastructure server instances to your cluster network](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available for classic gateway-enabled clusters.



Assigning access
:   Updated the steps to [assign access to your clusters through the {{site.data.keyword.cloud_notm}} IAM console](/docs/containers?topic=containers-users#add_users).



### 12 December 2019
{: #containers-dec1219}
{: release-note}

Setting up a service mesh with Istio
:   Includes the following new pages.
    - [About the managed Istio add-on](/docs/containers?topic=containers-istio-about)
    - [Setting up Istio](/docs/containers?topic=containers-istio)
    - [Managing apps in the service mesh](/docs/containers?topic=containers-istio-mesh)
    - [Observing Istio traffic](/docs/containers?topic=containers-istio-health)



### 11 December 2019
{: #containers-dec1119}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.64](/docs/containers?topic=containers-cs_cli_changelog).



Configuring VPC subnets
:   [Added information](/docs/containers?topic=containers-vpc-subnets) about configuring VPC subnets, public gateways, and network segmentation for your VPC clusters.



Kubernetes version lifecycles
:   Added information about [the release lifecycle of supported Kubernetes versions](/docs/containers?topic=containers-cs_versions#release_lifecycle).

Managed Knative add-on
:   Added information about Istio version support.



### 9 December 2019
{: #containers-dec0919}
{: release-note}

Version changelog
:   Worker node patch updates are available.
:   Kubernetes [1.16.3_1519](/docs/containers?topic=containers-116_changelog#1163_1519_worker), [1.15.6_1526](/docs/containers?topic=containers-115_changelog#1156_1526_worker), [1.14.9_1542](/docs/containers?topic=containers-114_changelog#1149_1542_worker), and [1.13.12_1545](/docs/containers?topic=containers-113_changelog#11312_1545_worker).


### 4 December 2019
{: #containers-dec0419}
{: release-note}

Exposing apps with load balancers or Ingress ALBs
:   Added quick start pages to help you get up and running with [load balancers](/docs/containers?topic=containers-loadbalancer-qs) and [Ingress ALBs](/docs/containers?topic=containers-managed-ingress-about).



Kubernetes web terminal for VPC clusters
:   To use the Kubernetes web terminal for VPC clusters, make sure to [configure access to external endpoints](/docs/containers?topic=containers-cs_cli_install#cli_web).

Monitoring Istio
:   Added [steps](/docs/containers?topic=containers-istio-health#istio_inspect) to launch the ControlZ component inspection and Envoy sidecar dashboards for the Istio managed add-on.

Tuning network performance
:   Added [steps](/docs/containers?topic=containers-kernel#calico-portmap) for disabling the `portmap` plug-in for for the Calico container network interface (CNI).



Use the internal KVDB in Portworx
:   Automatically set up a key-value database (KVDB) during the Portworx installation to store your Portworx metadata. For more information, see [Using the Portworx KVDB](/docs/containers?topic=containers-portworx#portworx-kvdb).

## November 2019
{: #containers-nov19}

### 26 November 2019
{: #containers-nov2619}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.61](/docs/containers?topic=containers-cs_cli_changelog).

Cluster autoscaling for VPC clusters
:   You can [set up the cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-helm) on clusters that run on the first generation of compute for Virtual Private Cloud (VPC).

New! Reservations and limits for PIDs
:   Worker nodes that run Kubernetes version 1.14 or later set [process ID (PID) reservations and limits that vary by flavor](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node), to help prevent malicious or runaway apps from consuming all available PIDs.

Version changelog
:   Worker node patch updates are available.
:   Kubernetes [1.16.3_1518](/docs/containers?topic=containers-116_changelog#1163_1518_worker), [1.15.6_1525](/docs/containers?topic=containers-115_changelog#1156_1525_worker), [1.14.9_1541](/docs/containers?topic=containers-114_changelog#1149_1541_worker), and [1.13.12_1544](/docs/containers?topic=containers-113_changelog#11312_1544_worker)


### 22 November 2019
{: #containers-nov2219}
{: release-note}

Bring your own DNS for load balancers
:   Added steps for bringing your own custom domain for [NLBs](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_dns) in classic clusters and [VPC load balancers](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns) in VPC clusters.

Gateway appliance firewalls
:   Updated the [required IP addresses and ports](/docs/containers?topic=containers-firewall#vyatta_firewall) that you must open in a public gateway device firewall.

Ingress ALB subdomain format
:   [Changes are made to the Ingress subdomain](/docs/containers?topic=containers-managed-ingress-about#managed-ingress-subdomain). New clusters are assigned an Ingress subdomain in the format `cluster_name.globally_unique_account_HASH-0000.region.containers.appdomain.cloud` and an Ingress secret in the format `cluster_name.globally_unique_account_HASH-0000`. Any existing clusters that use the `cluster_name.region.containers.mybluemix.net` subdomain are assigned a CNAME record that maps to a `cluster_name.region_or_zone.containers.appdomain.cloud` subdomain.


### 21 November 2019
{: #containers-nov2119}
{: release-note}

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to 597 and the `ingress-auth` image to build 353](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Version changelog
:   Master patch updates are available.
:   Kubernetes [1.16.3_1518](/docs/containers?topic=containers-116_changelog#1163_1518), [1.15.6_1525](/docs/containers?topic=containers-115_changelog#1156_1525), [1.14.9_1541](/docs/containers?topic=containers-114_changelog#1149_1541), and [1.13.12_1544](/docs/containers?topic=containers-113_changelog#11312_1544).



### 19 November 2019
{: #containers-nov1919}
{: release-note}

Fluentd component changes
:   The Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you don't forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).


  
Istio managed add-on GA
:   The Istio managed add-on is generally available for Kubernetes version 1.16 clusters. In Kubernetes version 1.16 clusters, you can install the Istio add-on or [update your existing beta add-on to the latest version](/docs/containers?topic=containers-istio#istio_update).

Bringing your own Ingress controller in VPC clusters
:   Added steps for exposing your Ingress controller by creating a VPC load balancer and subdomain.



### 14 November 2019
{: #containers-nov1419}
{: release-note}

New! Diagnostics and Debug Tool add-on
:   The [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-debug-tool) is now available as a cluster add-on.



### 11 November 2019
{: #containers-nov1119}
{: release-note}

Exposing apps that are external to your cluster by using Ingress
:   Added information for how to use the `proxy-external-service` Ingress annotation to include an app that is external to your cluster in Ingress application load balancing.



Accessing your cluster
:   Added an [Accessing Kubernetes clusters page](/docs/containers?topic=containers-access_cluster).



Version changelog
:   Worker node patch updates are available.
:    Kubernetes [1.16.2_1515](/docs/containers?topic=containers-116_changelog#1162_1515_worker), [1.15.5_1522](/docs/containers?topic=containers-115_changelog#1155_1522_worker), [1.14.8_1538](/docs/containers?topic=containers-114_changelog#1148_1538_worker), and [1.13.12_1541](/docs/containers?topic=containers-113_changelog#11312_1541_worker).



### 7 November 2019
{: #containers-nov0719}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.51](/docs/containers?topic=containers-cs_cli_changelog).



Ingress ALB changelog
:   Updated the [ALB `ingress-auth` image to build 345](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).


### 5 November 2019
{: #containers-nov0519}
{: release-note}

New! Adding classic infrastructure servers to gateway-enabled classic clusters (Beta)
:   If you have non-containerized workloads on a classic IBM Cloud infrastructure virtual server or bare metal server, you can connect those workloads to the workloads in your gateway-enabled classic cluster by [adding the server instance to your cluster network](/docs/containers?topic=containers-add_workers#gateway_vsi).

### 4 November 2019
{: #containers-nov0419}
{: release-note}

New! Kubernetes version 1.16
:   You can now create clusters that run Kubernetes version 1.16. To update an existing cluster, see the [Version 1.16 preparation actions](/docs/containers?topic=containers-cs_versions#k8s_version_archive).

Deprecated: Kubernetes version 1.13
:   With the release of version 1.16, clusters that run version 1.13 are deprecated. Consider [updating to 1.14](/docs/containers?topic=containers-cs_versions#k8s_version_archive) today.

Unsupported: Kubernetes version 1.12
:   With the release of version 1.16, clusters that run version 1.12 are unsupported. To continue receiving important security updates and support, you must [update the cluster to a supported version](/docs/containers?topic=containers-cs_versions#prep-up) immediately.

### 1 November 2019
{: #containers-nov0119}
{: release-note}

New! Keep your own key (KYOK) support (beta)
:   You can now [enable several key management service (KMS) providers](/docs/containers?topic=containers-encryption#kms), so that you can use your own root key to encrypt the secrets in your cluster.



## October 2019
{: #containers-oct19}



### 28 October 2019
{: #containers-oct2819}
{: release-note}

Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.5_1521](/docs/containers?topic=containers-115_changelog#1155_1521), [1.14.8_1537](/docs/containers?topic=containers-114_changelog#1148_1537), [1.13.12_1540](/docs/containers?topic=containers-113_changelog#11312_1540), [1.12.10_1570](/docs/containers?topic=containers-112_changelog#11210_1570), and {{site.data.keyword.redhat_openshift_notm}} [3.11.153_1529_openshift](/docs/openshift?topic=openshift-openshift_changelog_311#311153_1529).



New! Resource groups for VPC clusters
:   You can now [create Kubernetes clusters](/docs/containers?topic=containers-vpc_ks_tutorial) in different resource groups than the resource group of the Virtual Private Cloud (VPC).



### 24 October 2019
{: #containers-oct2419}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.42](/docs/containers?topic=containers-cs_cli_changelog).



Scaling down file storage
:   Added steps for [scaling down the default file storage plug-in](/docs/containers?topic=containers-file_storage#file_scaledown_plugin) in classic clusters.



Ingress subdomain troubleshooting
:   Added troubleshooting steps for when [no Ingress subdomain exists after cluster creation](/docs/containers?topic=containers-ingress_subdomain).
    

### 23 October 2019
{: #containers-oct2319}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 584 and `ingress-auth` image build to 344](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Ingress annotations
:   Added the [`proxy-ssl-verify-depth` and `proxy-ssl-name` optional parameters to the `ssl-services` annotation](/docs/containers?topic=containers-comm-ingress-annotations#ssl-services-support).

### 22 October 2019
{: #containers-oct2219}
{: release-note}

Version changelogs
:   Master patch updates are available for Kubernetes [1.15.5_1520](/docs/containers?topic=containers-115_changelog#1155_1520), [1.14.8_1536](/docs/containers?topic=containers-114_changelog#1148_1536), [1.13.12_1539](/docs/containers?topic=containers-113_changelog#11312_1539), and {{site.data.keyword.redhat_openshift_notm}} [3.11.146_1528_openshift](/docs/openshift?topic=openshift-openshift_changelog_311#311146_1528).



### 17 October 2019
{: #containers-oct1719}
{: release-note}

New! Cluster autoscaler
:   The cluster autoscaler is available for private network-only clusters. To get started, update to the latest Helm chart version.

New DevOps tutorial
:   Learn how to set up your own DevOps toolchain and configure continuous delivery pipeline stages to deploy your containerized app that is stored in GitHub to a cluster in {{site.data.keyword.containerlong_notm}}.



### 14 October 2019
{: #containers-oct1419}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.38](/docs/containers?topic=containers-cs_cli_changelog).



Calico MTU
:   Added [steps](/docs/containers?topic=containers-kernel#calico-mtu) for changing the Calico plug-in maximum transmission unit (MTU) to meet the network throughput requirements of your environment.



Creating DNS subdomains for VPC load balancers and private Ingress ALBs
:   Added steps for [registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns) and for [exposing apps to a private network](/docs/containers?topic=containers-managed-ingress-setup) in VPC clusters.



Let's Encrypt rate limits for Ingress
:   Added troubleshooting steps for when no subdomain or secret is generated for the Ingress ALB when you create or delete clusters of the same name.

Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.4_1519](/docs/containers?topic=containers-115_changelog#1154_1519_worker), [1.14.7_1535](/docs/containers?topic=containers-114_changelog#1147_1535_worker), [1.13.11_1538](/docs/containers?topic=containers-113_changelog#11311_1538_worker), [1.12.10_1569](/docs/containers?topic=containers-112_changelog#11210_1569_worker), and {{site.data.keyword.redhat_openshift_notm}} [3.11.146_1527_openshift](/docs/openshift?topic=openshift-openshift_changelog_311#311146_1527).



### 3 October 2019
{: #containers-oct0319}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 579 and `ingress-auth` image build to 341](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

DevOps toolchain
:   You can now use the **DevOps** tab on the cluster details page to configure your DevOps toolchain. For more information, see [Setting up a continuous delivery pipeline for a cluster](/docs/containers?topic=containers-cicd#continuous-delivery-pipeline).



Security for VPC clusters
:   Added information for how to achieve [network segmentation and privacy in VPC clusters](/docs/containers?topic=containers-security#network_segmentation_vpc).


    
    

### 1 October 2019
{: #containers-oct0119}
{: release-note}

End of service of {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}}
:   Removed steps for using {{site.data.keyword.la_full_notm}} and {{site.data.keyword.monitoringlong_notm}} to work with cluster logs and metrics. You can collect logs and metrics for your cluster by setting up [{{site.data.keyword.la_full_notm}}](/docs/containers?topic=containers-health#logging) and [{{site.data.keyword.mon_full_notm}}](/docs/monitoring?topic=monitoring-kubernetes_cluster#kubernetes_cluster) instead.



New! Gateway-enabled classic clusters
:   Keep your compute workloads private and allow limited public connectivity to your classic cluster by enabling a gateway. You can enable a gateway only on standard, Kubernetes clusters during cluster creation.
:   When you enable a gateway on a classic cluster, the cluster is created with a `compute` worker pool of compute worker nodes that are connected to a private VLAN only, and a `gateway` worker pool of gateway worker nodes that are connected to public and private VLANs. Traffic into or out of the cluster is routed through the gateway worker nodes, which provide your cluster with limited public access. For more information, check out the following links.
        - [Using a gateway-enabled cluster](/docs/containers?topic=containers-plan_basics#gateway)
        - [Isolating networking workloads to edge nodes in classic gateway-enabled clusters](/docs/containers?topic=containers-edge#edge_nodes)
        - Flow of traffic to apps when using an [NLB 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_gateway), an [NLB 2.0](/docs/containers?topic=containers-loadbalancer-about#v2_gateway), or Ingress ALBs.

:   Ready to get started? [Create a standard classic cluster with a gateway in the CLI](/docs/containers?topic=containers-cluster-create-classic&interface=ui).



Version changelogs
:   Patch updates are available for Kubernetes [1.15.4_1518](/docs/containers?topic=containers-115_changelog#1154_1518), [1.14.7_1534](/docs/containers?topic=containers-114_changelog#1147_1534), [1.13.11_1537](/docs/containers?topic=containers-113_changelog#11311_1537), and [1.12.10_1568](/docs/containers?topic=containers-112_changelog#11210_1568_worker).

    

## September 2019
{: #containers-sept19}



### 27 September 2019
{: #containers-sept2719}
{: release-note}

{{site.data.keyword.cos_full_notm}} supported in VPC clusters
:   You can now provision {{site.data.keyword.cos_full_notm}} for your apps that run in a VPC cluster. For more information, see [Storing data on {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-storage-cos-understand).



### 24 September 2019
{: #containers-sept2419}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.31](/docs/containers?topic=containers-cs_cli_changelog).

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
{: #containers-sept1919}
{: release-note}

Sending custom Ingress certificates to legacy clients
:   Added [steps](/docs/containers?topic=containers-comm-ingress-annotations) for ensuring that your custom certificate, instead of the default IBM-provided certificate, is sent by the Ingress ALB to legacy clients that don't support SNI.



### 16 September 2019
{: #containers-sept1619}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the release of version 0.4.23.

{{site.data.keyword.at_full_notm}} events
:   Added information about [which {{site.data.keyword.at_short}} location your events are sent to](/docs/containers?topic=containers-at_events#at-ui) based on the {{site.data.keyword.containerlong_notm}} location where the cluster is located.



Version changelogs
:   Worker node patch updates are available for Kubernetes [1.15.3_1517](/docs/containers?topic=containers-115_changelog#1153_1517_worker), [1.14.6_1533](/docs/containers?topic=containers-114_changelog#1146_1533_worker), [1.13.10_1536](/docs/containers?topic=containers-113_changelog#11310_1536_worker), and [1.12.10_1567](/docs/containers?topic=containers-112_changelog#11210_1567_worker).


    

### 13 September 2019
{: #containers-sept1319}
{: release-note}



Entitled software
:   If you have licensed products from your [MyIBM.com](https://myibm.ibm.com){: external} container software library, you can [set up your cluster to pull images from the entitled registry](/docs/containers?topic=containers-registry#secret_entitled_software).

`script update` command
:   Added [steps for using the `script update` command](/docs/containers?topic=containers-kubernetes-service-cli#script_update) to prepare your automation scripts for the release of version 1.0 of the {{site.data.keyword.containerlong_notm}} plug-in.
    

### 12 September 2019
{: #containers-sept1219}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 552](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).



### 5 September 2019
{: #containers-sept0519}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`ingress-auth` image to build 340](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 4 September 2019
{: #containers-sept0419}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.4.3](/docs/containers?topic=containers-cs_cli_changelog).

IAM allowlists
:   If you use an IAM allowlist, you must [allow the CIDRs of the {{site.data.keyword.containerlong_notm}} control plane](/docs/containers?topic=containers-firewall) for the zones in the region where your cluster is located so that {{site.data.keyword.containerlong_notm}} can create Ingress ALBs and `LoadBalancers` in your cluster.



### 3 September 2019
{: #containers-sept0319}
{: release-note}

New! {{site.data.keyword.containerlong_notm}} plug-in version `0.4`
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for multiple changes in the [release of version 0.4.1](/docs/containers?topic=containers-cs_cli_changelog).

Version changelog
:   Worker node patch updates are available for Kubernetes [1.15.3_1516](/docs/containers?topic=containers-115_changelog#1153_1516_worker), [1.14.6_1532](/docs/containers?topic=containers-114_changelog#1146_1532_worker), [1.13.10_1535](/docs/containers?topic=containers-113_changelog#11310_1535_worker), [1.12.10_1566](/docs/containers?topic=containers-112_changelog#11210_1566_worker), and {{site.data.keyword.redhat_openshift_notm}} [3.11.135_1523](/docs/openshift?topic=openshift-openshift_changelog_311#311135_1523_worker).

## August 2019
{: #containers-aug19}



### 29 August 2019
{: #containers-aug2919}
{: release-note}

Forwarding Kubernetes API audit logs to {{site.data.keyword.la_full_notm}}
:   Added steps to [create an audit webhook in your cluster](/docs/containers?topic=containers-health-audit) to collect Kubernetes API audit logs from your cluster and forward them to {{site.data.keyword.la_full_notm}}.

### 28 August 2019
{: #containers-aug2819}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.3.112](/docs/containers?topic=containers-cs_cli_changelog).



Version changelogs
:   Updated the changelogs for [1.15.3_1515](/docs/containers?topic=containers-115_changelog#1153_1515), [1.14.6_1531](/docs/containers?topic=containers-114_changelog#1146_1531), [1.13.10_1534](/docs/containers?topic=containers-113_changelog#11310_1534), and [1.12.10_1565](/docs/containers?topic=containers-112_changelog#11210_1565) master fix pack updates.



    

### 26 August 2019
{: #containers-aug2619}
{: release-note}

Cluster autoscaler
:   With the latest version of the cluster autoscaler, you can [enable autoscaling for worker pools during the Helm chart installation](/docs/containers?topic=containers-cluster-scaling-helm) instead of modifying the config map after installation.

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 524 and `ingress-auth` image to build 337](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).



### 23 August 2019
{: #containers-aug2319}
{: release-note}



App networking in VPC
:   Updated the [Planning in-cluster and external networking for apps](/docs/containers?topic=containers-cs_network_planning) topic with information for planning app networking in a VPC cluster.

Istio in VPC
:   Updated the [managed Istio add-on](/docs/containers?topic=containers-istio) topic with information for using Istio in a VPC cluster.

Remove bound services from cluster
:   Added instructions for how to remove an {{site.data.keyword.cloud_notm}} service that you added to a cluster by using service binding. For more information, see [Removing a service from a cluster](/docs/containers?topic=containers-service-binding#unbind-service).




### 20 August 2019
{: #containers-aug2019}
{: release-note}

Ingress ALB changelog
:   Updated the ALB [`nginx-ingress` image to build 519](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog) for a `custom-ports` bug fix.



### 19 August 2019
{: #containers-aug1919}
{: release-note}

New! Virtual Private Cloud
:   You can create standard Kubernetes clusters on classic infrastructure in the next generation of the {{site.data.keyword.cloud_notm}} platform, in your Virtual Private Cloud. VPC gives you the security of a private cloud environment with the dynamic scalability of a public cloud. Classic on VPC clusters are available for only standard, Kubernetes clusters and are not supported in free or {{site.data.keyword.redhat_openshift_notm}} clusters.
:   With classic clusters in VPC, {{site.data.keyword.containerlong_notm}} introduces version 2 of the API, which supports multiple infrastructure providers for your clusters. Your cluster network setup also changes, from worker nodes that use public and private VLANs and the public cloud service endpoint to worker nodes that are on a private subnet only and have the private cloud service endpoint enabled. For more information, check out the following links.
    - [Overview of Classic and VPC infrastructure providers](/docs/containers?topic=containers-infrastructure_providers)
    - [About the v2 API](/docs/containers?topic=containers-cs_api_install#api_about)
    - [Understanding network basics of VPC clusters](/docs/containers?topic=containers-plan_vpc_basics)
    
:   Ready to get started? Try out the [Creating a classic cluster in your VPC tutorial](/docs/containers?topic=containers-vpc_ks_tutorial).

Kubernetes 1.14
:   [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_versions_available) is now the default version.



### 17 August 2019
{: #containers-aug1719}
{: release-note}

{{site.data.keyword.at_full}}
:   The [{{site.data.keyword.at_full_notm}} service](/docs/containers?topic=containers-at_events) is now supported for you to view, manage, and audit user-initiated activities in your clusters.



Version changelogs
:   Updated the changelogs for [1.15.2_1514](/docs/containers?topic=containers-115_changelog#1152_1514), [1.14.5_1530](/docs/containers?topic=containers-114_changelog#1145_1530), [1.13.9_1533](/docs/containers?topic=containers-113_changelog#1139_1533), and [1.12.10_1564](/docs/containers?topic=containers-112_changelog#11210_1564) master fix pack updates.



### 15 August 2019
{: #containers-aug1519}
{: release-note}



App deployments
:   Added steps for [copying deployments from one cluster to another](/docs/containers?topic=containers-update_app#copy_apps_cluster).

FAQs
:   Added an FAQ about [free clusters](/docs/containers?topic=containers-faqs#faq_free).

Istio
:   Added steps for [exposing Istio-managed apps with TLS termination](/docs/containers?topic=containers-istio-mesh#istio_expose_bookinfo_tls), [securing in-cluster traffic by enabling mTLS](/docs/containers?topic=containers-istio-mesh#mtls), and [Updating the Istio add-ons](/docs/containers?topic=containers-istio#istio_update).

Knative
:   Added instructions for how to use volumes to access secrets and config maps, pull images from a private registry, scale apps based on CPU usage, change the default container port, and change the `scale-to-zero-grace-period`.

Version changelogs
:   Updated the changelogs for [1.15.2_1513](/docs/containers?topic=containers-115_changelog#1152_1513), [1.14.5_1529](/docs/containers?topic=containers-114_changelog#1145_1529), [1.13.9_1532](/docs/containers?topic=containers-113_changelog#1139_1532), and [1.12.10_1563](/docs/containers?topic=containers-112_changelog#11210_1563) master fix pack updates.



### 12 August 2019
{: #containers-aug1219}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.3.103](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the ALB `ingress-auth` image to build 335 for [`musl libc` vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

### 5 August 2019
{: #containers-aug0519}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.3.99](/docs/containers?topic=containers-cs_cli_changelog).



New! `NodeLocal` DNS caching (beta)
:   For clusters that run Kubernetes 1.15 or later, you can set up improved cluster DNS performance with [`NodeLocal` DNS caching](/docs/containers?topic=containers-cluster_dns#dns_cache).

New! Version 1.15
:   You can create community Kubernetes clusters that run version 1.15. To update from a previous version, review the [1.15 changes](/docs/containers?topic=containers-cs_versions#k8s_version_archive).

Deprecated: Version 1.12
:   Kubernetes version 1.12 is deprecated. Review the [changes across versions](/docs/containers?topic=containers-cs_versions), and update to a more recent version.

Version changelogs
:   Updated the changelogs for [1.14.4_1527](/docs/containers?topic=containers-114_changelog#1144_1527_worker), [1.13.8_1530](/docs/containers?topic=containers-113_changelog#1138_1530_worker), and [1.12.10_1561](/docs/containers?topic=containers-112_changelog#11210_1561_worker) worker node patch updates.




## July 2019
{: #containers-jul19}

### 30 July 2019
{: #containers-july3019}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.3.95](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the ALB `nginx-ingress` image to build 515 for the [ALB pod readiness check](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Removing subnets from a cluster
:   Added steps for removing subnets [in an IBM Cloud infrastructure account](/docs/containers?topic=containers-subnets#remove-subnets) from a cluster. 



### 23 July 2019
{: #containers-july2319}
{: release-note}

Fluentd changelog
:   Fixes [Alpine vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).



### 22 July 2019
{: #containers-july2219}
{: release-note}

Version policy
:   Increased the [version deprecation](/docs/containers?topic=containers-cs_versions#cs_versions_available) period from 30 to 45 days.

Version changelogs
:   Updated the changelogs for [1.14.4_1526](/docs/containers?topic=containers-114_changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-113_changelog#1138_1529_worker), and [1.12.10_1560](/docs/containers?topic=containers-112_changelog#11210_1560_worker) worker node patch updates.

Version changelog
:   [Version 1.11is unsupported](/docs/containers?topic=containers-111_changelog#111_changelog).




### 17 July 2019
{: #containers-july1719}
{: release-note} 

Ingress ALB changelog
:   Fixes [`rbash` vulnerabilities](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 15 July 2019
{: #containers-july1519}
{: release-note}



Cluster and worker node ID
:   The ID format for clusters and worker nodes is changed. Existing clusters and worker nodes keep their existing IDs. If you have automation that relies on the previous format, update it for new clusters.
    - **Cluster ID**: In the regex format `{a-v0-9}7]{a-z0-9}[2]{a-v0-9}[11]`.
    - **Worker node ID**: In the format: `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`



Ingress ALB changelog
:   Updated the ALB `nginx-ingress` image to build 497.

Troubleshooting clusters
:   Added [troubleshooting steps](/docs/containers?topic=containers-common_worker_nodes_issues) for when you can't manage clusters and worker nodes because the time-based one-time passcode (TOTP) option is enabled for your account.



Version changelogs
:   Updated the changelogs for [1.14.4_1526](/docs/containers?topic=containers-114_changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-113_changelog#1138_1529), and [1.12.10_1560](/docs/containers?topic=containers-112_changelog#11210_1560) master fix pack updates.

### 8 July 2019
{: #containers-july0819}
{: release-note}

Version changelogs
:   Updated the changelogs for [1.14.3_1525](/docs/containers?topic=containers-114_changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-113_changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-112_changelog#1129_1559), and [1.11.10_1564](/docs/containers?topic=containers-111_changelog#11110_1564) worker node patch updates.



### 2 July 2019
{: #containers-july0219}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of version 0.3.58](/docs/containers?topic=containers-cs_cli_changelog).

### 1 July 2019
{: #containers-july0119}
{: release-note}

Infrastructure permissions
:   Updated the [classic infrastructure roles](/docs/containers?topic=containers-classic-roles) required for common use cases.



strongSwan VPN service
:   If you install strongSwan in a multizone cluster and use the `enableSingleSourceIP=true` setting, you can now [set `local.subnet` to the `%zoneSubnet` variable and use the `local.zoneSubnet` to specify an IP address as a /32 subnet for each zone of the cluster](/docs/containers?topic=containers-vpn#strongswan_4).


## June 2019
{: #containers-jun19}

### 24 June 2019
{: #containers-june2419}
{: release-note}

Calico network policies
:   Added a set of [public Calico policies](/docs/containers?topic=containers-network_policies#isolate_workers_public) and expanded the set of [private Calico policies](/docs/containers?topic=containers-network_policies#isolate_workers) to protect your cluster on public and private networks.

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 477](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).



Service limitations
:   Updated the [maximum number of pods per worker node limitation](/docs/containers?topic=containers-limitations#tech_limits). For worker nodes that run Kubernetes 1.13.7_1527, 1.14.3_1524, or later and that have more than 11 CPU cores, the worker nodes can support 10 pods per core, up to a limit of 250 pods per worker node.

Version changelogs
:   Added changelogs for [1.14.3_1524](/docs/containers?topic=containers-114_changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-113_changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-112_changelog#1129_1558), and [1.11.10_1563](/docs/containers?topic=containers-111_changelog#11110_1563) worker node patch updates.


    

### 21 June 2019
{: #containers-june2119}
{: release-note}


  
Accessing the Kubernetes master through the private cloud service endpoint
:   Added steps for [editing the local Kubernetes configuration file](/docs/containers?topic=containers-access_cluster#access_private_se) when both the public and private cloud service endpoints are enabled, but you want to access the Kubernetes master through the private cloud service endpoint only.
    

### 18 June 2019
{: #containers-june1819}
{: release-note}

CLI changelog
:   Updated the {{site.data.keyword.containerlong_notm}} CLI plug-in change log page for the [release of versions 0.3.47 and 0.3.49](/docs/containers?topic=containers-cs_cli_changelog).

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 473 and `ingress-auth` image to build 331](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Managed add-on versions
:   Updated the version of the Istio managed add-on to 1.1.7 and the Knative managed add-on to 0.6.0.

Removing persistent storage
:   Updated the information for how you are billed when you delete persistent storage.

Service bindings with private endpoint
:   [Added steps](/docs/containers?topic=containers-service-binding) for how to manually create service credentials with the private cloud service endpoint when you bind the service to your cluster.

Version changelogs
:   Updated the changelogs for [1.14.3_1523](/docs/containers?topic=containers-114_changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-113_changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-112_changelog#1129_1557), and [1.11.10_1562] (/docs/containers?topic=containers-111_changelog#11110_1562) patch updates.
    

### 14 June 2019
{: #containers-june1419}
{: release-note}

`kubectl` troubleshooting
:   Added a [troubleshooting topic](/docs/containers?topic=containers-ts_clis#kubectl_fails) for when you have a `kubectl` client version that is 2 or more versions apart from the server version or the {{site.data.keyword.redhat_openshift_notm}} version of `kubectl`, which does not work with community Kubernetes clusters.

Tutorials landing page
:   Replaced the related links page with a new tutorials landing page for all tutorials that are specific to {{site.data.keyword.containershort_notm}}.

Using existing subnets to create a cluster
:   To [reuse subnets from an unneeded cluster when you create a new cluster](/docs/containers?topic=containers-subnets#subnets_custom), the subnets must be user-managed subnets that you manually added from an on-premises network. All subnets that were automatically ordered during cluster creation are immediately marked for deletion after you delete a cluster, and you can't reuse these subnets to create a new cluster.
    

### 12 June 2019
{: #containers-june1219}
{: release-note}

Aggregating cluster roles
:   Added steps for [extending users' existing permissions by aggregating cluster roles](/docs/containers?topic=containers-users#rbac_aggregate).

### 7 June 2019
{: #containers-june0719}
{: release-note}

Access to the Kubernetes master through the private cloud service endpoint
:   Added [steps](/docs/openshift?topic=openshift-access_cluster#access_private_se) to expose the private cloud service endpoint through a private load balancer. After you complete these steps, your authorized cluster users can access the Kubernetes master from a VPN or {{site.data.keyword.dl_full_notm}} connection.

{{site.data.keyword.BluDirectLink}}
:   Added {{site.data.keyword.dl_full_notm}} to the [VPN connectivity](/docs/containers?topic=containers-vpn) page as a way to create a direct, private connection between your remote network environments and {{site.data.keyword.containerlong_notm}} without routing over the public internet.

Ingress ALB changelog
:   Updated the [ALB `ingress-auth` image to build 330](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 6 June 2019
{: #containers-june0619}
{: release-note}

Fluentd changelog
:   Added a [Fluentd version change log(/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 470](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).
    

### 5 June 2019
{: #containers-june0519}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to reflect multiple changes for the release of version [0.3.34](/docs/containers?topic=containers-cs_cli_changelog) of the {{site.data.keyword.containerlong_notm}} CLI plug-in.



### 4 June 2019
{: #containers-june0419}
{: release-note}

Version changelogs
:   Updated the changelogs for the [1.14.2_1521](/docs/containers?topic=containers-114_changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-113_changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-112_changelog#1129_1555), and [1.11.10_1561](/docs/containers?topic=containers-111_changelog#11110_1561) patch releases.

### 3 June 2019
{: #containers-june0319}
{: release-note}

Bringing your own Ingress controller
:   Updated the steps to reflect changes to the default community controller and to require a health check for controller IP addresses in multizone clusters.

{{site.data.keyword.cos_full_notm}}
:   Updated the [steps](/docs/containers?topic=containers-storage_cos_install) to install the {{site.data.keyword.cos_full_notm}} plug-in with or without the Helm server, Tiller.

Ingress ALB changelog
:   Updated the [ALB `nginx-ingress` image to build 467](/docs/containers?topic=containers-cluster-add-ons-changelog#kube_ingress_changelog).

Kustomize
:   Added an example of [reusing Kubernetes configuration files across multiple environments with Kustomize](/docs/containers?topic=containers-app#kustomize).

Razee
:   Added [Razee](https://github.com/razee-io/Razee){: external} to the supported integrations to visualize deployment information in the cluster and to automate the deployment of Kubernetes resources. 

## May 2019
{: #containers-may19}

### 30 May 2019
{: #containers-may3019}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to reflect multiple changes for the [release of version 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) of the {{site.data.keyword.containerlong_notm}} CLI plug-in.

Troubleshooting storage
:   Added a file and block storage troubleshooting topic for [PVC pending states](/docs/containers?topic=containers-file_pvc_pending).
    - Added a block storage troubleshooting topic for when [an app can't access or write to PVC](/docs/containers?topic=containers-block_app_failures). 

### 28 May 2019
{: #containers-may2819}
{: release-note}

Cluster add-ons changelog
:   Updated the [ALB `nginx-ingress` image to build 462](/docs/containers?topic=containers-cluster-add-ons-changelog).

Troubleshooting registry
:   Added a [troubleshooting topic](/docs/containers?topic=containers-ts_image_pull_create) for when your cluster can't pull images from {{site.data.keyword.registryfull}} due to an error during cluster creation.
    
Troubleshooting storage
:   Added a topic for debugging persistent storage failures.
    - Added a troubleshooting topic for [PVC creation failures due to missing permissions](/docs/containers?topic=containers-missing_permissions).

### 23 May 2019
{: #containers-may2319}
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
{: #containers-may2019}
{: release-note}

Version changelogs
:   Added [worker node fix pack changelogs](/docs/containers?topic=containers-changelog).

### 16 May 2019
{: #containers-may1619}
{: release-note}

CLI reference
:   Updated the [CLI reference page](/docs/containers?topic=containers-kubernetes-service-cli) to add COS endpoints for `logging collect` commands and to clarify that `cluster master refresh` restarts the Kubernetes master components.

Unsupported: Kubernetes version 1.10
:   [Kubernetes version 1.10](/docs/containers?topic=containers-cs_versions#k8s_version_archive) is now unsupported.
    

### 15 May 2019
{: #containers-may1519}
{: release-note}

Default Kubernetes version
:   The default Kubernetes version is now 1.13.6.

Service limits
:   Added a [service limitations topic](/docs/containers?topic=containers-limitations#tech_limits).
    
### 13 May 2019
{: #containers-may1319}
{: release-note}

Version changelogs
:   Added that new patch updates are available for [1.14.1_1518](/docs/containers?topic=containers-114_changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-113_changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-112_changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-111_changelog#11110_1558), and [1.10.13_1558](/docs/containers?topic=containers-110_changelog#11013_1558).

Worker node flavors
:   Removed all [virtual machine worker node flavors](/docs/containers?topic=containers-planning_worker_nodes#vm) that are 48 or more cores. You can still provision [bare metal worker nodes](/docs/containers?topic=containers-planning_worker_nodes#bm) with 48 or more cores.

### 8 May 2019
{: #containers-may0819}
{: release-note}

API
:   Added a link to the [global API swagger docs](https://containers.cloud.ibm.com/global/swagger-global-api/#/){: external}.

Cloud Object Storage
:   [Added a troubleshooting guide for Cloud Object Storage](/docs/containers?topic=containers-cos_pvc_pending) in your {{site.data.keyword.containerlong_notm}} clusters.

Kubernetes strategy
:   Added a topic about [What knowledge and technical skills are good to have before I move my apps to {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).

Kubernetes version 1.14
:   Added that the [Kubernetes 1.14 release](/docs/containers?topic=containers-cs_versions#k8s_version_archive) is certified.

Reference topics
:   Updated information for various service binding, `logging`, and `nlb` operations in the [user access](/docs/containers?topic=containers-access_reference) and [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli) pages.

### 7 May 2019
{: #containers-may0719}
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
:   Create or update your clusters to [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#k8s_version_archive).

Deprecated Kubernetes version 1.11
:   [Update any clusters](/docs/containers?topic=containers-update) that run [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#k8s_version_archive) before they become unsupported.

Permissions
:   Added an FAQ, [What access policies do I give my cluster users?](/docs/containers?topic=containers-faqs#faq_access)

Worker pools
:   Added instructions for how to [apply labels](/docs/containers?topic=containers-add_workers#worker_pool_labels) to existing worker pools.

Reference topics
:   To support new features such as Kubernetes 1.14, [change log reference](/docs/containers?topic=containers-cs_versions#cs_versions_available) pages are updated.

### 1 May 2019
{: #containers-may0119}
{: release-note}

Assigning infrastructure access
:   Revised the [steps](/docs/containers?topic=containers-access-creds#infra_access) to assign IAM permissions for opening support cases.


