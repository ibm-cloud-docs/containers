---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-20"


keywords: autoscaler, add-on, autoscaler change log, cluster autoscaler

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Cluster autoscaler add-on change log
{: #ca_changelog}


View information for patch updates to the cluster autoscaler add-on in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}


Patch updates
:   Patch updates are delivered automatically by IBM and don't contain any feature updates or changes in the supported add-on and cluster versions.

Release updates
:   Release updates contain new features for the cluster autoscaler or changes in the supported add-on or cluster versions. You must manually apply release updates to your cluster autoscaler add-on. To update your cluster autoscaler add-on, see [Updating the cluster autoscaler add-on](/docs/containers?topic=containers-cluster-scaling-install-addon#cluster-scaling-install-addon-update-addon).

Refer to the following tables for a summary of changes for each version of the [cluster autoscaler add-on](/docs/containers?topic=containers-cluster-scaling-install-addon).

To view a list of add-ons and the supported cluster versions, run the following command or see the [Supported cluster add-ons table](/docs/containers?topic=containers-supported-cluster-addon-versions).

```sh
ibmcloud ks cluster addon versions
```
{: pre}



## Version 1.2.4
{: #0124_ca_addon}

### Change log for patch update 1.2.4_680, released 18 July 2025.
{: #124_680_ca}

- Resolves the following CVEs: [CVE-2025-3576](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2025-3576){: external}, [CVE-2025-4673](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2025-4673){: external}, [CVE-2025-4802](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2025-4802){: external}.   
- Updates Go to 1.23.10
- Updates the `storage-secret-sidecar` image to `v1.3.30`
- Image tags: `1.28.7 124-1`, `1.29.5 124-1`, `1.30.4 124-1`, `1.31.1 124-1`, `1.32.1 124-1`.


### Change log for patch update 1.2.4_629, released 22 April 2025.
{: #124_629_ca}

- Adds support for version 1.32
- Updates golang version to 1.23.7
- Updates the `storage-secret-sidecar` image to `v1.3.26`
- Updates open source source cluster autoscaler code to latest versions for: `1.28.7`, `1.29.5`, `1.30.4`, `1.31.2`, `1.32.1`.
- Image tags: `1.28.7 124-0`, `1.29.5 124-0`, `1.30.4 124-0`, `1.31.1 124-0`, `1.32.1 124-0`.


## Version 1.2.3
{: #0123_ca_addon}

### Change log for patch update 1.2.3_716, released 25 July 2025.
{: #123_716_ca}

- Resolves the following CVEs: CVE-2025-3576, CVE-2025-4673, CVE-2025-4802, CVE-2025-0426, CVE-2024-9042, CVE-2025-0426, CVE-2024-9042.
- Updates Go to `1.23.10`.
- Updates storage secret sidecar to `1.3.30`.
- Image tags: `1.28.7 123-3`, `1.29.5 123-3`, `1.30.4 123-3`, `1.31.2 123-3`.
    


### Change log for patch update 1.2.3_540, released 10 March 2025
{: #123_540_ca}

- Updates golang version to `1.22.11` for cluster version `1.28`, `1.29`, `1.30`, and `1.31`.
- Updates the `storage-secret-sidecar` image to `v1.3.23`.
- Updates source code to version `1.28.7`, `1.29.5`, `1.30.3`, and `1.31.1`.
- Image tags: `1.27.3 123-1`, `1.28.7 123-2`, `1.29.5 123-2`, `1.30.3 123-2`, `1.31.1 123-2`.
- Resolves [CVE-2024-24789](https://nvd.nist.gov/vuln/detail/CVE-2024-24789){: external}, [CVE-2024-24790](https://nvd.nist.gov/vuln/detail/CVE-2024-24790){: external}, [CVE-2024-34158](https://nvd.nist.gov/vuln/detail/CVE-2024-34158){: external}, [CVE-2024-34155](https://nvd.nist.gov/vuln/detail/CVE-2024-34155){: external}, [CVE-2024-34156](https://nvd.nist.gov/vuln/detail/CVE-2024-34156){: external}, and [CVE-2024-43040](https://nvd.nist.gov/vuln/detail/CVE-2024-43040){: external}.

### Change log for patch update 1.2.3_512, released 31 October 2024
{: #123_512_ca}

- Adds support for version 1.31.
- Updates the storage-secret-sidecar image to v1.3.16.
- Image tags: `1.27.3 123-1`, `1.28.0 123-1`, `1.29.0 123-1`, `1.30.2 123-1`, `1.31.0 123-1`



## Version 1.2.2
{: #0122_ca_addon}

### Change log for patch update 1.2.2_466, released 15 July 2024
{: #122_466_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.10`.
- Resolves [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external} and [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}
- Image tags: `1.24.0-122-0`, `1.25.0-122-0`, `1.26.4-122-0`, `1.27.3-122-0`, `1.28.0-122-0`, `1.29.0-122-0`.


### Change log for patch update 1.2.2_452, released 20 June 2024
{: #122452_ca}

- Adds support for version 1.30.
- Changes the format of the `cluster-autoscaler-status` configmap. For more information, see the [Community Kubernetes pull request](https://github.com/kubernetes/autoscaler/pull/6375){: external}.
- Image tags: `1.22.0-122-0`, `1.23.0-122-0`, `1.24.0-122-0`, `1.25.0-122-0`, `1.26.4-122-0`, `1.27.3-122-0`, `1.28.0-122-0`, `1.29.0-122-0`, `1.30.0-122-0`.



## Version 1.2.1
{: #0121_ca_addon}

### Change log for patch update 1.2.1_467, released 15 July 2024
{: #121_467_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.10`.
- Resolves [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external} and [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}
- Image tags: `1.24.0-121-2`, `1.25.0-121-2`, `1.26.4-121-2`, `1.27.3-121-2`, `1.28.0-121-2`, `1.29.0-121-2`.


### Change log for patch update 1.2.1_444, released 21 June 2024
{: #121444_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.9`.
- Updates golang version to `1.21.11`.
- Image tags: `1.24.0-121-2`, `1.25.0-121-2`, `1.26.4-121-2`, `1.27.3-121-2`, `1.28.0-121-2`, `1.29.0-121-2`.


### Change log for patch update 1.2.1_425, released 05 May 2024
{: #121425_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.7`
- Fixes a utilization calculation bug during scale down.
- Image tags: `1.22.0-121-1`, `1.23.0-121-1`, `1.24.0-121-1`, `1.25.0-121-1`, `1.26.4-121-1`, `1.27.3-121-1`, `1.28.0-121-1`, and `1.28.0-121-1`.

### Change log for patch update 1.2.1_418, released 02 April 2024
{: #121418_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.6`
- Adds support for `drainPriorityConfig`, `dynamicNodeDeleteDelayAfterTaintEnabled`, `loggingFormat`, `emitPerNodegroupMetrics`, `kubeApiContentType`, `featureGates` parameters.
- Image tags: `1.22.0-121-0`, `1.23.0-121-0`, `1.24.0-121-0`, `1.25.0-121-0`, `1.26.4-121-0`, `1.27.3-121-0`, `1.28.0-121-0`.


### Change log for patch update 1.2.1_395, released 28 February 2024
{: #121395_ca}

- Adds support for cluster version 1.29.
- Image tags: `1.22.0-121-0`, `1.23.0-121-0`, `1.24.0-121-0`, `1.25.0-121-0`, `1.26.4-121-0`, `1.27.3-121-0`, `1.28.0-121-0`.

## Version 1.2.0
{: #0120_ca_addon}

### Change log for patch update 1.2.0_468, released 15 July 2024
{: #120_468_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.10`.
- Resolves [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external} and [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}
- Image tags: `1.24.0-120-6`, `1.25.0-120-6`, `1.26.4-120-6`, `1.27.3-120-6`, `1.28.0-120-6`.

### Change log for patch update 1.2.0_443, released 21 June 2024
{: #120443_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.9`.
- Updates golang version to `1.21.11`.
- Image tags: `1.24.0-120-6`, `1.25.0-120-6`, `1.26.4-120-6`, `1.27.3-120-6`, `1.28.0-120-6`.

### Change log for patch update 1.2.0_426, released 05 May 2024
{: #120426_ca}

- Updates the storage-secret-sidecar image to `v1.3.7`
- Fixes a utilization calculation bug during scale down.
- Image tags: `1.22.0-120-5`, `1.23.0-120-5`, `1.24.0-120-5`, `1.25.0-120-5`, `1.26.4-120-5`, `1.27.3-120-5`, and `1.28.0-120-5`.

### Change log for patch update 1.2.0_410, released 02 April 2024
{: #120410_ca}

- Updates the `storage-secret-sidecar` image to `v1.3.6`
- Images tags: `1.22.0-120-4`, `1.23.0-120-4`, `1.24.0-120-4`, `1.25.0-120-4`, `1.26.4-120-4`, `1.27.3-120-4`, `1.28.0-120-4`.

### Change log for patch update 1.2.0_365, released 21 February 2024
{: #120365_ca}

- Updated the storage-secret-sidecar image to `v1.3.5`.
- Image tags: `1.22.0-120-4`, `1.23.0-120-4`, `1.24.0-120-4`, `1.25.0-120-4`, `1.26.4-120-4`, `1.27.3-120-4`, and `1.28.0-120-4`.

### Change log for patch update 1.2.0_322, released 16 January 2024
{: #120322_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}
- Updated the storage-secret-sidecar image to `v1.3.4`
- Fixes an issue while updating custom variables via add-on.
- Adds support for the `maxPodEvictionTime` parameter.
- Image tags: `1.22.0-120-3`, `1.23.0-120-3`, `1.24.0-120-3`, `1.25.0-120-3`, `1.26.4-120-3`, `1.27.3-120-3`, and `1.28.0-120-3`.


### Change log for patch update 1.2.0_290, released 27 November 2023
{: #120290_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, and [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}.
- Updated the storage-secret-sidecar image to `v1.3.3`.
- Image tags: `1.22.0-120-2`, `1.23.0-120-2`, `1.24.0-120-2`, `1.25.0-120-2`, `1.26.4-120-2`, `1.27.3-120-2`, and `1.28.0-120-2`.

### Change log for patch update 1.2.0_228, released 15 November 2023
{: #120228_ca}

- Adds support for cluster version 1.28
- Image tags: `1.22.0-120-2`, `1.23.0-120-2`, `1.24.0-120-2`, `1.25.0-120-2`, `1.26.4-120-2`, `1.27.3-120-2`, and `1.28.0-120-2`.

## Version 1.1.0 (Beta)
{: #0110_ca_addon}

Version 1.1.0 is a {{site.data.keyword.satelliteshort}} Beta release. Patches might be slower on this version.
{: preview}

### Change log for patch update 1.1.0_362, released 16 February 2024
{: #110362_ca}

- Image tags: `1.21.0 110-10`, `1.22.0 110-10`, `1.23.0 110-10`, `1.24.0 110-10`, `1.25.0 110-10`.
- Updates `golang` version to `1.20.11`.


### Change log for patch update 1.1.0_1066, released 15 May 2023
{: #111066_ca}

- Image tags: `1.21.0 110-9`, `1.22.0 110-9`, `1.23.0 110-9`, `1.24.0 110-9`, `1.25.0 110-9`
- Resolves issues while reading secrets. 

### Change log for patch update 1.1.0_1060, released 26 April 2023
{: #111060_ca}

- Image tags: `1.19.1 110-8`, `1.20.0 110-8`, `1.21.0 110-8`, `1.22.0 110-8`, `1.23.0 110-8`.
- Updates `golang` version to `1.19.8`.
- Adds support for {{site.data.keyword.satelliteshort}} cluster versions 4.11 and 4.12.

### Change log for patch update 1.1.0_978, released 16 March 2023
{: #110978_ca}

- Image tags: `1.19.1 110-6`, `1.20.0 110-6`, `1.21.0 110-6`, `1.22.0 110-6`, `1.23.0 110-6`.
- Updates `golang` version to `1.19.6`.

### Change log for patch update 1.1.0_897, released 9 January 2023
{: #110897_ca}

- Image tags: `1.19.1 110-5`, `1.20.0 110-5`, `1.21.0 110-5`, `1.22.0 110-5`, `1.23.0 110-5`.
- Golang updated to `1.18.9`
- Updates the `storage-secret-sidecar` image to `v1.2.14`
- Resolves the following CVEs: [CVE-2022-42898](https://www.cve.org/CVERecord?id=CVE-2022-42898){: external}, [CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}, [CVE-2022-41720](https://www.cve.org/CVERecord?id=CVE-2022-41720){: external}

### Change log for patch update 1.1.0_798, released 22 September 2022
{: #110798_ca}

- Image tags: `1.19.1-110-5`,`1.20.0-110-5`,`1.21.0-110-5`,`1.22.0-110-5`,`1.23.0-110-5`.
- Resolves [CVE-2022-27664](https://www.cve.org/CVERecord?id=CVE-2022-27664){: external}, [CVE-2022-32190](https://www.cve.org/CVERecord?id=CVE-2022-32190){: external}.

### Change log for patch update 1.1.0_776, released 31 August 2022
{: #110776_ca}

- Image tags: `1.19.1-110-4`, `1.20.0-110-4`, `1.21.0-110-4`, `1.22.0-110-4`, `1.23.0-110-4`
- Resolves [CVE-2022-30630](https://nvd.nist.gov/vuln/detail/CVE-2022-30630){: external}, [CVE-2022-30635](https://nvd.nist.gov/vuln/detail/CVE-2022-30635){: external}, [CVE-2022-32148](https://nvd.nist.gov/vuln/detail/CVE-2022-32148){: external}, [CVE-2022-30631](https://nvd.nist.gov/vuln/detail/CVE-2022-30631){: external}, [CVE-2022-30632](https://nvd.nist.gov/vuln/detail/CVE-2022-30632){: external}, [CVE-2022-32189](https://nvd.nist.gov/vuln/detail/CVE-2022-32189){: external}, [CVE-2022-28131](https://nvd.nist.gov/vuln/detail/CVE-2022-28131){: external}, [CVE-2022-30633](https://nvd.nist.gov/vuln/detail/CVE-2022-30633){: external}, and [CVE-2022-1705](https://nvd.nist.gov/vuln/detail/CVE-2022-1705){: external}.

### Change log for patch update 1.1.0_729, released 21 July 2022
{: #110729_ca}

- Image tags: `1.19.1-101-2`, `1.20.0-101-2`, `1.21.0-101-2`, `1.22.0-101-2`, `1.23.0-101-2`
- Resolves [CVE-2022-29526](https://nvd.nist.gov/vuln/detail/CVE-2022-29526){: external}.

### Change log for patch update 1.1.0_682, released 30 June 2022
{: #110682_ca}

- Image tags: `1.19.1 110-1`, `1.20.0 110-1`, `1.21.0 110-1`, `1.22.0 110-1`, `1.23.0 110-1`
- Adds `storage-secret-store` compatibility fixes for {{site.data.keyword.satelliteshort}} clusters.
- Adds logging improvements.

### Change log for patch update 1.1.0_615, released 16 May 2022
{: #110615_ca}

- Image tags: `1.19.1-110-0`, `1.20.0-110-0`, `1.21.0-110-0`, `1.22.0-110-0`, `1.23.0-110-0`
- Resolves [CVE-2022-28327](https://nvd.nist.gov/vuln/detail/CVE-2022-28327){: external}, [CVE-2022-24675](https://nvd.nist.gov/vuln/detail/CVE-2022-24675){: external}, and [CVE-2022-27536](https://nvd.nist.gov/vuln/detail/CVE-2022-27536){: external}.
- Ignores label `ibm-cloud.kubernetes.io/vpc-instance-id` for zone balancing in satellite environments.
- Adds experimental option `balancingIgnoreLabelsFlag`. This option defines a node label that should be ignored when considering node group similarity. One label can be defined per option occurrence.

### Change log for patch update 1.1.0_475, released 30 March 2022
{: #110475_ca}

- Image tags: `1.19.1-12`, `1.20.0-12`, `1.21.0-8`, `1.22.0-6`, `1.23.0-3`
- Resolves [CVE-2022-24921](https://nvd.nist.gov/vuln/detail/CVE-2022-24921){: external}.
- Adds permissions for `cluster-autoscaler` to watch namespaces.

### Change log for patch update 1.1.0_429, released 16 March 2022
{: #110429_ca}

- Image tags: `1.19.1-11`, `1.20.0-11`, `1.21.0-7`, `1.22.0-5`, `1.23.0-2`
- Adds Beta support for {{site.data.keyword.satelliteshort}} clusters in allowlisted accounts.


## Version 1.0.9
{: #0109_ca_addon}

Version 1.0.9 version is deprecated and becomes unsupported on 30 April 2024.
{: note}

### Change log for patch update 1.0.9_411, released 02 April 2024
{: #109411_ca}

- Updates the `storage-secret-sidecar` image to `v1.2.33`
- Images tags: `1.22.0-109-3`, `1.23.0-109-3`, `1.24.0-109-3`, `1.25.0-109-3`, `1.26.1-109-3`, `1.27.2-109-3`.

### Change log for patch update 1.0.9_377, released 21 February 2024
{: #109377_ca}

- Updated the storage-secret-sidecar image to `v1.2.31`.
- Fixed naming issues with the `nodeDeleteDelayAfterTaint` and `maxNodesTotal` parameters.
- Image tags: `1.22.0-109-3`, `1.23.0-109-3`, `1.24.0-109-3`, `1.25.0-109-3`, `1.26.1-109-3`, `1.27.2-109-3`.

### Change log for patch update 1.0.9_328, released 16 January 2024
{: #109328_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}
- Updates the storage-secret-sidecar image to `v1.2.30`.
- Fixes an issue while updating custom variables via add-on.

### Change log for patch update 1.0.9_290, released 27 November 2023
{: #109290_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, and [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}.
- Updated the storage-secret-sidecar image to `v1.2.29`.
- Image tags: `1.22.0-109-2`, `1.23.0-109-2`, `1.24.0-109-2`, `1.25.0-109-2`, `1.26.1-109-2`, `1.27.2-109-2`.

### Change log for patch update 1.0.9_195, released 13 November 2023
{: #109195_ca}

- Updates the `storage-secret-sidecar` image to `v1.2.28`.
- Updates Golang to 1.20.10.
- Image tags: `1.22.0-109-2`, `1.23.0-109-2`, `1.24.0-109-2`, `1.25.0-109-2`, `1.26.1-109-2`, `1.27.2-109-2`.


### Change log for patch update 1.0.9_134, released 04 October 2023
{: #109134_ca}

- Adds constraints to allow add-on deployment on `amd64` architecture only.
- Image tags: `1.22.0-109-1`, `1.23.0-109-1`, `1.24.0-109-1`, `1.25.0-109-1`, `1.26.1-109-1`, `1.27.2-109-1`.

### Change log for patch update 1.0.9_103, released 15 September 2023
{: #109103_ca}

- Image tags: `1.22.0-109-3`, `1.23.0-109-3`, `1.24.0-109-3`, `1.25.0-109-3`, `1.26.1-109-3`, `1.27.2-109-3`.
- Updated the storage-secret-sidecar image to `v1.2.26`.
- Golang update to resolve [CVE-2023-29409](https://nvd.nist.gov/vuln/detail/CVE-2023-29409){: external}.


### Change log for patch update 1.0.9_81, released 07 August 2023
{: #10981_ca}

- Image tags: `1.22.0-109-0`, `1.23.0-109-0`, `1.24.0-109-0`, `1.25.0-109-0`,`1.26.1-109-0`,`1.27.2-109-0`.
- Updates the `storage-secret-sidecar` image to `v1.2.25`.
- Resolves the followings CVEs:[CVE-2023-2283](https://nvd.nist.gov/vuln/detail/CVE-2023-2283){: external},[CVE-2023-26604](https://nvd.nist.gov/vuln/detail/CVE-2023-26604){: external},[CVE-2020-24736](https://nvd.nist.gov/vuln/detail/CVE-2020-24736){: external}, and [CVE-2023-1667](https://nvd.nist.gov/vuln/detail/CVE-2023-1667){: external}.

### Change log for patch update 1.0.9_70, released 24 July 2023
{: #10970_ca}

- Adds support for the `prometheusScrape` annotation.
- Image tags: `1.22.0-109-0`, `1.23.0-109-0`, `1.24.0-109-0`, `1.25.0-109-0`, `1.26.1-109-0`, `1.27.2-109-0`.


### Change log for patch update 1.0.9_44, released 22 June 2023
{: #10944_ca}


- Adds support for cluster version 1.27.
- Adds the `scaleDownUnreadyEnabled`, `maxNodesPerScaleup`, `maxNodegroupBinpackingDuration`, `kubeClientBurst`, and `kubeClientQPS` parameters.
- Updates the `storage-secret-sidecar` image to `v1.2.24`.
- Updates Golang to `1.19.10` for `iks-cluster-autoscaler` `1.22-1.26` and Golang version `1.20.5` for `iks-cluster-autoscaler 1.27`.
- Image tags: `1.22.0 109-0`, `1.23.0 109-0`, `1.24.0 109-0`, `1.25.0 109-0`, `1.26.1 109-0`, `1.27.2 109-0`.



## Version 1.0.8
{: #0108_ca_addon}

### Change log for patch update 1.0.8_346, released 01 February  2024
{: #108346_ca}

- Updates the `storage-secret-sidecar` image to `v1.2.30`.
- Image tags: `1.20.0 108-5`, `1.21.0 108-5`, `1.22.0 108-5`, `1.23.0 108-5`, `1.24.0 108-5`, `1.25.0 108-5`, and `1.26.0 108-5`.

### Change log for patch update 1.0.8_292, released 27 November 2023
{: #108292_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, and [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}.
- Updated the storage-secret-sidecar image to `v1.2.29`.
- Image tags: `1.20.0 108-5`, `1.21.0 108-5`, `1.22.0 108-5`, `1.23.0 108-5`, `1.24.0 108-5`, `1.25.0 108-5`, and `1.26.0 108-5`.

### Change log for patch update 1.0.8_233, released 13 November 2023
{: #108233_ca}


- Updates the `storage-secret-sidecar` image to `v1.2.28`.
- Updates Golang to 1.20.10.
- Image tags: `1.20.0 108-5`, `1.21.0 108-5`, `1.22.0 108-5`, `1.23.0 108-5`, `1.24.0 108-5`, `1.25.0 108-5`, and `1.26.0 108-5`.


### Change log for patch update 1.0.8_104, released 15 September 2023
{: #108104_ca}

- Image tags: `1.22.0-108-4`, `1.23.0-109-4`, `1.24.0-108-4`, `1.25.0-108-4`, `1.26.1-108-4`, `1.27.2-109-4`.
- Updated the storage-secret-sidecar image to `v1.2.26`.
- Golang update to resolve [CVE-2023-29409](https://nvd.nist.gov/vuln/detail/CVE-2023-29409){: external}.


### Change log for patch update 1.0.8_82, released 7 August 2023
{: #10882_ca}

- Image tags: `1.20.0 108-3`, `1.21.0 108-3`, `1.22.0 108-3`, `1.23.0 108-3`, `1.24.0 108-3`, `1.25.0 108-3`, `1.26.0 108-3`.
- Updates the `storage-secret-sidecar` image to `v1.2.25`.
- Resolves the followings CVEs:[CVE-2023-2283](https://nvd.nist.gov/vuln/detail/CVE-2023-2283){: external},[CVE-2023-26604](https://nvd.nist.gov/vuln/detail/CVE-2023-26604){: external},[CVE-2020-24736](https://nvd.nist.gov/vuln/detail/CVE-2020-24736){: external}, and [CVE-2023-1667](https://nvd.nist.gov/vuln/detail/CVE-2023-1667){: external}.

### Change log for patch update 1.0.8_56, released 6 July 2023
{: #10856_ca}

- Image tags: `1.20.0 108-3`, `1.21.0 108-3`, `1.22.0 108-3`, `1.23.0 108-3`, `1.24.0 108-3`, `1.25.0 108-3`, `1.26.0 108-3`.
- Updates the `storage-secret-sidecar` image to `v1.2.21`.
- Updates the `golang` version to `1.19.8`.

### Change log for patch update 1.0.8_1078, released 15 May 2023
{: #1081078_ca}

- Image tags: `1.20.0 108-2`, `1.21.0 108-2`, `1.22.0 108-2`, `1.23.0 108-2`, `1.24.0 108-2`, `1.25.0 108-2`, `1.26.0 108-2`.
- Updates `storage-secret-sidecar` image to `v1.2.21`.
- Golang updated to `1.19.8`.

### Change log for patch update 1.0.8_1016, released 5 April 2023
{: #1081016_ca}

- Image tags: `1.20.0 108-1`, `1.21.0 108-1`, `1.22.0 108-1`, `1.23.0 108-1`, `1.24.0 108-1`, `1.25.0 108-1`, and `1.26.0 108-1`.
- Updates the `storage-secret-sidecar` image to `v1.2.20`.
- Updates the `golang` version to `1.19.7`.
- Resolves an issue where `cluster-autoscaler` stops retrying requests that return HTTP 401 codes.
- Logging improvements.

### Change log for patch update 1.0.8_987, released 29 March 2023
{: #108987_ca}

- Image tags: `1.20.0 108-0`, `1.21.0 108-0`, `1.22.0 108-0`, `1.23.0 108-0`, `1.24.0 108-0`, `1.25.0 108-0`, and `1.26.0 108-0`.
- Resolves [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}.
- Updates the `storage-secret-sidecar` image to `v1.2.19`.

### Change log for patch update 1.0.8_968, released 9 March 2023
{: #108968_ca}

- Image tags: `1.20.0 108-0`, `1.21.0 108-0`, `1.22.0 108-0`, `1.23.0 108-0`, `1.24.0 108-0`, `1.25.0 108-0`, and `1.26.0 108-0`
- Golang updated to `1.19.6`
- Adds support for cluster version 1.26 based on the Kubernetes community [cluster-autoscaler](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.26.0){: external}.

## Version 1.0.7
{: #0107_ca_addon}

### Change log for patch update 1.0.7_291, released 27 November 2023
{: #107291_ca}

- Fixes [CVE-2007-4559](https://nvd.nist.gov/vuln/detail/CVE-2007-4559){: external}, [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, and [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}.
- Updated the storage-secret-sidecar image to `v1.2.29`.
- Image tags: `1.20.0 107-7`, `1.21.0 107-7`, `1.22.0 107-7`, `1.23.0 107-7`, `1.24.0 107-7`, and `1.25.0 107-7`.

### Change log for patch update 1.0.7_185, released 13 November 2023
{: #107_185_ca}

- Updates the `storage-secret-sidecar` image to `v1.2.28`.
- Updates Golang to 1.20.10.
- Image tags: `1.20.0 107-7`, `1.21.0 107-7`, `1.22.0 107-7`, `1.23.0 107-7`, `1.24.0 107-7`, and `1.25.0 107-7`.


### Change log for patch update 1.0.7_102, released 15 September 2023
{: #107102_ca}

- Image tags: `1.22.0-107-7`, `1.23.0-107-7`, `1.24.0-107-7`, `1.25.0-107-7`, `1.26.1-107-7`, `1.27.2-107-7`.
- Updated the storage-secret-sidecar image to `v1.2.26`.
- Golang update to resolve [CVE-2023-29409](https://nvd.nist.gov/vuln/detail/CVE-2023-29409){: external}.

### Change log for patch update 1.0.7_83, released 7 August 2023
{: #10783_ca}

- Image tags: `1.20.0 107-6`, `1.21.0 107-6`, `1.22.0 107-6`, `1.23.0 107-6`, `1.24.0 107-6`,`1.25.0 107-6`.
- Updates the `storage-secret-sidecar` image to `v1.2.25`.
- Resolves the followings CVEs:[CVE-2023-2283](https://nvd.nist.gov/vuln/detail/CVE-2023-2283){: external},[CVE-2023-26604](https://nvd.nist.gov/vuln/detail/CVE-2023-26604){: external},[CVE-2020-24736](https://nvd.nist.gov/vuln/detail/CVE-2020-24736){: external}, and [CVE-2023-1667](https://nvd.nist.gov/vuln/detail/CVE-2023-1667){: external}.


### Change log for patch update 1.0.7_57, released 6 July 2023
{: #10757_ca}

- Image tags: `1.20.0 107-6`, `1.21.0 107-6`, `1.22.0 107-6`, `1.23.0 107-6`, `1.24.0 107-6`,`1.25.0 107-6`.
- Updates the `storage-secret-sidecar` image to `v1.2.21`.
- Updates the `golang` version to `1.19.8`.
- Fixes an issue where `cluster-autoscaler` stops retrying requests that return `HTTP401` code.

### Change log for patch update 1.0.7_1076, released 15 May 2023
{: #1071076_ca}

- Image tags: `1.20.0 107-5`, `1.21.0 107-5`, `1.22.0 107-5`, `1.23.0 107-5`, `1.24.0 107-5`,`1.25.0 107-5`.
- Updates the `storage-secret-sidecar` image to `v1.2.21`
- Golang updated to `1.19.8`.
- Fixes issue where `cluster-autoscaler` stops retrying requests return `HTTP401` code.


### Change log for patch update 1.0.7_1021, released 5 April 2023
{: #1071021_ca}

- Image tags: `1.20.0 107-4`, `1.21.0 107-4`,  `1.22.0 107-4`, `1.23.0 107-4`, `1.24.0 107-4`, and `1.25.0 107-4`.
- Updates the `storage-secret-sidecar` image to `v1.2.20`.
- Updates the `golang` version to `1.19.7`.

### Change log for patch update 1.0.7_988, released 29 March 2023
{: #107988_ca}

- Image tags: `1.20.0 107-3`, `1.21.0 107-3`,  `1.22.0 107-3`, `1.23.0 107-3`, `1.24.0 107-3`, and `1.25.0 107-3`.
- Resolves [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}.
- Updates the `storage-secret-sidecar` image to `v1.2.19`.

### Change log for patch update 1.0.7_956, released 7 March 2023
{: #107956_ca}

- Image tags: `1.20.0 107-3`, `1.21.0 107-3`,  `1.22.0 107-3`, `1.23.0 107-3`, `1.24.0 107-3`, and `1.25.0 107-3`.
- Updates the `golang` version to `1.19.6`.
- Updates the `storage-secret-sidecar` image to `v1.2.18`.
- Resolves the following CVEs: [CVE-2022-41724](https://nvd.nist.gov/vuln/detail/CVE-2022-41724){: external}, [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2020-10735](https://nvd.nist.gov/vuln/detail/CVE-2020-10735){: external}, [CVE-2021-28861](https://nvd.nist.gov/vuln/detail/CVE-2021-28861){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}, and [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}.

### Change log for patch update 1.0.7_944, released 17 February 2023
{: #107944_ca}

- Image tags: `1.20.0 107-2`, `1.21.0 107-2`,  `1.22.0 107-2`, `1.23.0 107-2`, `1.24.0 107-2`, and `1.25.0 107-2`.
- Updates the `storage-secret-sidecar` image to `v1.2.17`.
- Resolves [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}.

### Change log for patch update 1.0.7_940, released 24 January 2023:
{: #107940_ca}

- Image tags: `1.20.0 107-2`, `1.21.0 107-2`,  `1.22.0 107-2`, `1.23.0 107-2`, `1.24.0 107-2`, and `1.25.0 107-2`.
- Updates the `storage-secret-sidecar` image to `v1.2.15`.
- Resolves the following [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/cve-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/cve-2022-40304){: external}, [CVE-2022-35737](https://nvd.nist.gov/vuln/detail/cve-2022-35737){: external}, [CVE-2021-46848](https://nvd.nist.gov/vuln/detail/CVE-2021-46848){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}.

### Change log for patch update 1.0.7_900, released 9 January 2023
{: #107900_ca}

- Image tags: `1.20.0 107-2`, `1.21.0 107-2`, `1.22.0 107-2`, `1.23.0 107-2`, `1.24.0 107-2`, `1.25.0 107-2`.
- Golang updated to `1.18.9`
- Updates the `storage-secret-sidecar` image to `v1.2.14`
- Resolves the following CVEs: [CVE-2022-42898](https://www.cve.org/CVERecord?id=CVE-2022-42898){: external}, [CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}, [CVE-2022-41720](https://www.cve.org/CVERecord?id=CVE-2022-41720){: external}

### Change log for patch update 1.0.7_883, released 3 November 2022
{: #107883_ca}

- Image tags: `1.20.0-107-1`, `1.21.0-107-1`, `1.22.0-107-1`, `1.23.0-107-1`, `1.24.0-107-1`, `1.25.0-107-1`.
- Adds compute identity support.
- Adds currency support for IKS [Cluster-autoscaler 1.25](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.25.0){: external}.

## Version 1.0.6
{: #0106_ca_addon}

### Change log for patch update 1.0.6_1077, released 15 May 2023
{: #1061077_ca}

- Image tags: `1.19.1 106-8`, `1.20.0 106-8`, `1.21.0 106-8`, `1.22.0 106-8`, `1.23.0 106-8`, `1.24.0 106-8`.
- Updates the `storage-secret-sidecar` image to `v1.2.21`
- Golang updated to `1.19.8`.
- Fixes issue where `cluster-autoscaler` stops retrying requests return `HTTP401` code.

### Change log for patch update 1.0.6_1010, released 5 April 2023
{: #1061010_ca}

- Image tags: `1.19.1 106-7`, `1.20.0 106-7`,  `1.21.0 106-7`, `1.22.0 106-7`, `1.23.0 106-7`, and `1.24.0 106-7`.
- Updates the `golang` version to `1.19.7`.

### Change log for patch update 1.0.6_955, released 7 March 2023
{: #106955_ca}

- Image tags: `1.19.1 106-6`, `1.20.0 106-6`,  `1.21.0 106-6`, `1.22.0 106-6`, `1.23.0 106-6`, and `1.24.0 106-6`.
- Updates the `golang` version to `1.19.6`.
- Resolves the following CVEs: [CVE-2022-41724](https://nvd.nist.gov/vuln/detail/CVE-2022-41724){: external}, [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2020-10735](https://nvd.nist.gov/vuln/detail/CVE-2020-10735){: external}, [CVE-2021-28861](https://nvd.nist.gov/vuln/detail/CVE-2021-28861){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}, and [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}.

### Change log for patch update 1.0.6_899, released 9 January 2023
{: #106899_ca}

- Image tags: `1.19.1 106-5`, `1.20.0 106-5`, `1.21.0 106-5`, `1.22.0 106-5`, `1.23.0 106-5`, `1.24.0 106-5`.
- Golang updated to `1.18.9`
- Updates the `storage-secret-sidecar` image to `v1.2.14`
- Resolves the following CVEs: [CVE-2022-42898](https://www.cve.org/CVERecord?id=CVE-2022-42898){: external}, [CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}, [CVE-2022-41720](https://www.cve.org/CVERecord?id=CVE-2022-41720){: external}

### Change log for patch update 1.0.6_828, released 10 October 2022
{: #106828_ca}

- Adds support for setting up to 5 additional ignore labels while balancing `balancingIgnoreLabel[1-5]`.
- `1.19.1 106-4`, `1.20.0 106-4`, `1.21.0 106-4`, `1.22.0 106-4`, `1.23.0 106-4`, `1.24.0 106-4`.


### Change log for patch update 1.0.6_800, released 22 September 2022
{: #106800_ca}

- Image tags: `1.19.1-106-4`, `1.20.0-106-4`, `1.21.0-106-4`, `1.22.0-106-4`, `1.23.0 106-4`, `1.24.0 106-4`.
- Resolves [CVE-2022-27664](https://www.cve.org/CVERecord?id=CVE-2022-27664){: external}, [CVE-2022-32190](https://www.cve.org/CVERecord?id=CVE-2022-32190){: external}.

### Change log for patch update 1.0.6_774, released 31 August 2022
{: #106774_ca}

- Image tags: `1.19.1-106-3`, `1.20.0-106-3`, `1.21.0-106-3`, `1.22.0-106-3`, `1.23.0-106-3`, `1.24.0-106-3`
- Resolves [CVE-2022-30630](https://nvd.nist.gov/vuln/detail/CVE-2022-30630){: external}, [CVE-2022-30635](https://nvd.nist.gov/vuln/detail/CVE-2022-30635){: external}, [CVE-2022-32148](https://nvd.nist.gov/vuln/detail/CVE-2022-32148){: external}, [CVE-2022-30631](https://nvd.nist.gov/vuln/detail/CVE-2022-30631){: external}, [CVE-2022-30632](https://nvd.nist.gov/vuln/detail/CVE-2022-30632){: external}, [CVE-2022-32189](https://nvd.nist.gov/vuln/detail/CVE-2022-32189){: external}, [CVE-2022-28131](https://nvd.nist.gov/vuln/detail/CVE-2022-28131){: external}, [CVE-2022-30633](https://nvd.nist.gov/vuln/detail/CVE-2022-30633){: external}, and [CVE-2022-1705](https://nvd.nist.gov/vuln/detail/CVE-2022-1705){: external}.

### Change log for patch update 1.0.6_763, released 17 August 2022
{: #106763_ca}

- Image tags: `1.19.1-106-1`, `1.20.0-106-1`, `1.21.0-106-2`, `1.22.0-106-2`, `1.23.0-106-2`, `1.24.0-106-2`
- All non-deleting workers are considered while scaling up.
- Worker deletion is not retried while scaling down.

### Change log for patch update 1.0.6_742, released 15 July 2022
{: #106742_ca}

- Adds support for Kubernetes 1.24.
- Resolves [CVE-2022-29526](https://nvd.nist.gov/vuln/detail/CVE-2022-29526){: external}.
- Image tags: `1.19.1-106-2`, `1.20.0-106-2`, `1.21.0 106-1`, `1.22.0 106-1`, `1.23.0 106-1`, `1.24.0 106-1`

## Version 1.0.5
{: #0105_ca_addon}

### Change log for patch update 1.0.5_898, released 9 January 2023
{: #105898_ca}

- Image tags: `1.19.1 105-6`, `1.20.0 105-6`, `1.21.0 105-6`, `1.22.0 105-6`, `1.23.0 105-6`.
- Golang updated to `1.18.9`
- Updates the `storage-secret-sidecar` image to `v1.2.14`
- Resolves the following CVEs: [CVE-2022-42898](https://www.cve.org/CVERecord?id=CVE-2022-42898){: external}, [CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}, [CVE-2022-41720](https://www.cve.org/CVERecord?id=CVE-2022-41720){: external}

### Change log for patch update 1.0.5_779, released 22 September 2022
{: #105779_ca}

- Image tags: `1.19.1-105-5`,`1.20.0-105-5`,`1.21.0-105-5`,`1.22.0-105-5`,`1.23.0-105-5`.
- Resolves [CVE-2022-27664](https://www.cve.org/CVERecord?id=CVE-2022-27664){: external}, [CVE-2022-32190](https://www.cve.org/CVERecord?id=CVE-2022-32190){: external}.

### Change log for patch update 1.0.5_775, released 31 August 2022
{: #105775_ca}

- Image tags: `1.19.1-105-4`, `1.20.0-105-4`, `1.21.0-105-4`, `1.22.0-105-4`, `1.23.0-105-4`
- Resolves [CVE-2022-30630](https://nvd.nist.gov/vuln/detail/CVE-2022-30630){: external}, [CVE-2022-30635](https://nvd.nist.gov/vuln/detail/CVE-2022-30635){: external}, [CVE-2022-32148](https://nvd.nist.gov/vuln/detail/CVE-2022-32148){: external}, [CVE-2022-30631](https://nvd.nist.gov/vuln/detail/CVE-2022-30631){: external}, [CVE-2022-30632](https://nvd.nist.gov/vuln/detail/CVE-2022-30632){: external}, [CVE-2022-32189](https://nvd.nist.gov/vuln/detail/CVE-2022-32189){: external}, [CVE-2022-28131](https://nvd.nist.gov/vuln/detail/CVE-2022-28131){: external}, [CVE-2022-30633](https://nvd.nist.gov/vuln/detail/CVE-2022-30633){: external}, and [CVE-2022-1705](https://nvd.nist.gov/vuln/detail/CVE-2022-1705){: external}.

### Change log for patch update 1.0.5_754, released 17 August 2022
{: #105754_ca}

- Image tags: `1.19.1-105-3`, `1.20.0-105-3`, `1.21.0-105-3`, `1.22.0-105-3`, `1.23.0-105-3`
- All non-deleting workers are considered while scaling up.
- Worker deletion is not retried while scaling down.

### Change log for patch update 1.0.5_728, released 19 July 2022
{: #105728_ca}

- Image tags: `1.19.1-105-2`, `1.20.0-105-2`, `1.21.0-105-2`, `1.22.0-105-2`, `1.23.0-105-2`
- Resolves [CVE-2022-29526](https://nvd.nist.gov/vuln/detail/CVE-2022-29526){: external}.

### Change log for patch update 1.0.5_694, released 30 June 2022
{: #105694_ca}

- Image tags: `1.19.1 105-1`, `1.20.0 105-1`, `1.21.0 105-1`, `1.22.0 105-1`, `1.23.0 105-1`
- Adds logging improvements.

### Change log for patch update 1.0.5_628, released 16 May 2022
{: #105628_ca}

- Image tags: `1.19.1-105-0`, `1.20.0-105-0`, `1.21.0-105-0`, `1.22.0-105-0`, `1.23.0-105-0`
- Resolves [CVE-2022-28327](https://nvd.nist.gov/vuln/detail/CVE-2022-28327){: external}, [CVE-2022-24675](https://nvd.nist.gov/vuln/detail/CVE-2022-24675){: external}, and [CVE-2022-27536](https://nvd.nist.gov/vuln/detail/CVE-2022-27536){: external}.
- Ignores label `ibm-cloud.kubernetes.io/vpc-instance-id` for zone balancing in satellite environments.
- Adds experimental option `balancingIgnoreLabelsFlag`. This option defines a node label that should be ignored when considering node group similarity. One label can be defined per option occurrence.

### Change log for patch update 1.0.5_415, released 28 February 2022
{: #104415_ca}

Image tags: `1.19.1 9`, `1.20.0 9`, `1.21.0 5`, `1.22.0 3`
Adds support for Kubernetes 1.23


## Version 1.0.4
{: #0104_ca_addon}

Review the changes included in version 1.0.4 of the managed cluster autoscaler add-on.
{: shortdesc}


### Change log for patch update 1.0.4_410, released 23 February 2022
{: #104410_ca}

Image tags: `1.19.1 9`, `1.20.0 9`, `1.21.0 5`, `1.22.0 3`
Resolves the following CVEs: [CVE-2022-23772](https://nvd.nist.gov/vuln/detail/CVE-2022-23772){: external}, [CVE-2022-23773](https://nvd.nist.gov/vuln/detail/CVE-2022-23773){: external}, and [CVE-2022-23806](https://nvd.nist.gov/vuln/detail/CVE-2022-23806){: external}.




### Change log for patch update 1.0.4_403, released 20 January 2022
{: #104403_ca}

Review the changes in version `1.0.4_403` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.19.1-8`, `1.20.0-8`, `1.21.0-4`, and `1.22.0-2`.
- Supported cluster versions:  1.19.0 to 1.23.0
- Includes fixes for [CVE-2021-44716](https://nvd.nist.gov/vuln/detail/CVE-2021-44716){: external} and [CVE-2021-44717](https://nvd.nist.gov/vuln/detail/CVE-2021-44717){: external}. 


### Change log for patch update 1.0.4_387, released 22 November 2021
{: #104387_ca}

Review the changes in version `1.0.4_387` of the cluster autoscaler add-on. 
{: shortdesc}

- Image tags: `1.19.1-7`, `1.20.0-7`, `1.21.0-3`, and `1.22.0-2`.
- Updates the Golang version to `1.16.10` which includes fixes for [CVE-2021-41772](https://nvd.nist.gov/vuln/detail/CVE-2021-41772){: external} and [CVE-2021-41771](https://nvd.nist.gov/vuln/detail/CVE-2021-41771){: external}.

### Change log for patch update 1.0.4_374, released 7 October 2021
{: #104374_ca}

Review the changes in version `1.0.4_374` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.19.1-6`, `1.20.0-6`, `1.21.0-2`, and `1.22.0-1`.
- Adds support for Kubernetes version 1.22
- Pulls the base Golang image from a proxy registry.
- Adds an owner label to the `cluster-autoscaler` images.




## Version 1.0.3
{: #0103_ca_addon}

Review the changes included in version 1.0.3 of the managed cluster autoscaler add-on.
{: shortdesc}



### Change log for patch update 1.0.3_360, released 26 August 2021
{: #103360_ca}

Review the changes in version `1.0.3_360` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags:  `1.17.4-5`, `1.18.3-5`, `1.19.1-5`, `1.20.0-5`, and `1.21.0-1`.  
- Supported cluster versions: 1.17 to 1.21  
- Updates the Golang version to `1.16.6` which includes a fix for `PVR0281096`.  
- Increases the default resource requests and limits.
    - Previous values:
        ```yaml
        resourcesLimitsCPU: "600m"	    
        resourcesLimitsMemory: "600Mi"	     
        resourcesRequestsCPU: "200m"	      
        resourcesRequestsMemory: "200Mi"
        ```
        {: screen}	

    - Updated values:
        ```yaml
        resourcesLimitsCPU: "800m"
        resourcesLimitsMemory: "1000Mi"
        resourcesRequestsCPU: "200m"
        resourcesRequestsMemory: "400Mi"
        ```
        {: screen}




### Change log for patch update 1.0.3_352, released 23 June 2021
{: #103352_ca}

Review the changes in version `1.0.3_352` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.17.4-4`, `1.18.3-4`, `1.19.1-4`, `1.20.0-4`, and `1.21.0-0`.   
- Supported cluster versions: 1.17 to 1.21  
- Adds support for Kubernetes 1.21.  



## Version 1.0.2
{: #0102_ca_addon}

Review the changes that are in version 1.0.2 of the managed cluster autoscaler add-on.
{: shortdesc}



### Change log for patch update 1.0.2_267, released 10 May 2021
{: #102267_ca}

Review the changes in version `1.0.2_267` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.17.4-3`, `1.18.3-3`, `1.19.1-3`, and `1.20.0-3`.  
- Supported cluster versions: 1.17 <1.21.0  
- Includes a bug fix for the `worker replace` command on VPC clusters that caused worker creation to fail.  

### Change log for patch update 1.0.2_256, released 19 April 2021 
{: #102256_ca}

Review the changes in version `1.0.2_256` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.17.4-2`, `1.18.3-2`, `1.19.1-2`, and `1.20.0-2`  
- Supported cluster versions: 1.17 - 1.20  
- Includes fixes for [CVE-2021-27919](https://nvd.nist.gov/vuln/detail/CVE-2021-27919){: external} and [CVE-2021-27918](https://nvd.nist.gov/vuln/detail/CVE-2021-27918){: external}.  

### Change log for patch update 1.0.2_249, released 01 April 2021
{: #102249_ca}

Review the changes in version `1.0.2_249` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.16.7-1`, `1.17.4-1`, `1.18.3-1`, `1.19.1-1`, and `1.20.0-1`.  
- Supported cluster versions: 1.17 - 1.20  
- Includes fixes for [CVE-2021-3114](https://nvd.nist.gov/vuln/detail/CVE-2021-3114){: external} and [CVE-2021-3115](https://nvd.nist.gov/vuln/detail/CVE-2021-3114){: external}.  
- Removes the `init` container. In previous versions, the cluster autoscaler pods would remain in the `initContainer` state if the API key was missing or malformed. This update removes the `init` container so that if the API key is missing or malformed, the cluster autoscaler pod fails.  

### Change log for patch update 1.0.2_224, released 09 March 2021
{: #10224_ca}

Review the changes in version `1.0.2_224` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.16.7-0`, `1.17.4-0`, `1.18.3-0`, `1.19.1-0`, and `1.20.0-0`.  
- Supported cluster versions: 1.17 - 1.20  
- Adds support for Kubernetes version 1.20.  


## Version 1.0.1
{: #0101_ca_addon}

Review the changes that are in version 1.0.1 of the managed cluster autoscaler add-on.  
{: shortdesc}



### Change log for patch update 1.0.1_219, released 16 February 2021
{: #101219_ca}

Review the changes in version `1.0.1_219` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.16.7-0` `1.17.4-0`, `1.18.3-0`, and `1.19.1-0`.  
- Supported cluster versions: 1.15.0 - 1.20.0  
- Updates the code base to synchronize with the community autoscaler. For more information, see the [Kubernetes autoscaler documentation](https://github.com/kubernetes/autoscaler/releases){: external}.  

### Change log for patch update 1.0.1_210, released 13 January 2021
{: #101210_ca}

Review the changes in version `1.0.1_210` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.16.2-9`, `1.17.0-10`, `1.18.1-9`, and `1.19.0-4`.  
- Supported cluster versions: 1.15.0 - 1.20.0  
- Update addresses [`DLA-2509-1`](https://lists.debian.org/debian-lts-announce/2020/12/msg00039.html){: external}.  

### Change log for patch update 1.0.1_205, released 15 December 2020
{: #101205_ca}

Review the changes in version `1.0.1_205` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.11.0-7`, `1.16.2-8`, `1.17.0-9`, `1.18.1-8`, and `1.19.0-3`.  
- Supported cluster versions: 1.15 - 1.19  
- Updates the `initContainer` to use the universal base image (UBI).  

### Change log for patch update 1.0.1_195, released 10 December 2020
{: #101195_ca}

Review the changes in version `1.0.1_195` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.11.0-7`, `1.16.2-8`, `1.17.0-9`, `1.18.1-8`, and `1.19.0-3`.  
- Supported cluster versions: 1.15 - 1.19  
- Images are now signed.  
- Resources that are deployed by the cluster autoscaler add-on are now linked with the corresponding source code and build URLs.  
- Updates the Go version to `1.15.5`.  

### Change log for patch update 1.0.1_146, released 03 December 2020
{: #101146_ca}

Review the changes in version `1.0.1_146` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.15.4-4`, `1.16.2-7`, `1.17.0-8`, `1.18.1-7`, and `1.19.0-2`.  
- Supported cluster versions: 1.15 - 1.19  
- Updates the cluster autoscaler to run as non-root.  
- Adds a feature to validate secrets before the autoscaler pods are initialized.  

### Change log for patch update 1.0.1_128, released 27 October 2020
{: #101128_ca}

Review the changes in version `1.0.1_128` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.15.4-4`, `1.16.2-6`, `1.17.0-7`, `1.18.1-6`, and `1.19.0-1`.  
- Supported cluster versions: 1.15 - 1.19  
- Updates the Go version to `1.15.2`.  

### Change log for patch update 1.0.1_124, released 16 October 2020
{: #101124_ca}

Review the changes in version `1.0.1_124` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.15.4-4`, `1.16.2-6`, `1.17.0-7`, `1.18.1-6`, and `1.19.0-1`.  
- Supported cluster versions: 1.15 - 1.19  
- Exposes the `--new-pod-scale-up-delay` option in the ConfigMap.  
- Adds support for Kubernetes 1.19.  

### Change log for patch update 1.0.1_114, released 10 September 2020
{: #101114_ca}

Review the changes in version `1.0.1_114` of the cluster autoscaler add-on.
{: shortdesc}

- Image tags: `1.15.4-4`, `1.16.2-5`, `1.17.0-6`, and `1.18.1-5`.  
- Supported cluster versions: 1.15 - 1.18  
- Includes fixes for `CVE-5188` and `CVE-3180`.  
- Unlike the previous Helm chart, you can modify all the add-on configuration settings via a single configmap.  
