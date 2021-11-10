---

copyright:
  years: 2014, 2021
lastupdated: "2021-11-10"

keywords: kubernetes, nginx, ingress controller, fluentd

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Ingress ALB and Fluentd version changelog
{: #cluster-add-ons-changelog}

Your {{site.data.keyword.containerlong}} cluster comes with components, such as the Fluentd and Ingress ALB components, that are updated automatically by IBM. You can also disable automatic updates for some components and manually update them separately from the master and worker nodes. Refer to the tables in the following sections for a summary of changes for each version.
{: shortdesc}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. {{site.data.keyword.containerlong_notm}}. Changelog entries that address other security vulnerabilities but do not also refer to an IBM Security Bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

For more information about managing updates for Fluentd and Ingress ALBs, see [Updating cluster components](/docs/containers?topic=containers-update#components).

## Kubernetes Ingress image changelog
{: #kube_ingress_changelog}

View version changes for Ingress application load balancers (ALBs) that run the [community Kubernetes Ingress image](/docs/containers?topic=containers-ingress-types).
{: shortdesc}

When you create a new ALB, enable an ALB that was previously disabled, or manually update an ALB, you can specify an image version for your ALB in the `--version` flag. The latest three versions of the Kubernetes Ingress image are supported for ALBs. To list the currently supported versions, run the following command:
```sh
ibmcloud ks ingress alb versions
```
{: pre}

The Kubernetes Ingress version follows the format `<community_version>_<ibm_build>_iks`. The IBM build number indicates the most recent build of the Kubernetes Ingress NGINX release that {{site.data.keyword.containerlong_notm}} released. For example, the version `0.47.0_1434_iks` indicates the most recent build of the `0.47.0` Ingress NGINX version. {{site.data.keyword.containerlong_notm}} might release builds of the community image version to address vulnerabilities.

When automatic updates are enabled for ALBs, your ALBs are updated to the most recent build of the version that is marked as `default`. If you want to use a version other than the default, you must [disable automatic updates](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable). Typically, the latest version becomes the default version one month after the latest version is released by the Kubernetes community. Actual availability and release dates of versions are subject to change and depend on various factors, such as community updates, security patches, and technology changes between versions.

## Version 1.0.0 
{: #1_0_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following table for a summary of changes for each build of version 1.0.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 1.0.3_1730_iks (default)
{: #1.0.3_1730_iks}

Version 1.0.3_1730_iks of the Kubernetes Ingress image was released on 20 October 2021.

Version 1.0.3_1730_iks is now the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto-update enabled, your ALBs automatically update to use this image. 



### Version 1.0.0_1699_iks
{: #1.0.0_1699_iks}

Version 1.0.0_1699_iks of the Kubernetes Ingress image was released on 22 September 2021.

Updates address
- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){:external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){:external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){:external}

### Version 1.0.0_1645_iks
{: #1.0.0_1645_iks}

Version 1.0.0_1645_iks of the Kubernetes Ingress image was released on 14 September 2021

## Version 0.49.0
{: #0_49_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following sections for a summary of changes for each build of version 0.49.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.49.3_1745_iks
{: #0.49.3_1745_iks}

Version 0.49.3_1745_iks of the Kubernetes Ingress image was released on 20 October 2021

**As of 14 Sep 2021, this is the only image supported for Kubernetes version 1.18 clusters**. 

## Version 0.48.0 
{: #0_48_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0480){: external}. Refer to the following table for a summary of changes for each build of version 0.48.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.48.1_1698_iks
{: #0.48.1_1698_iks}

Version 0.48.1_1698_iks of the Kubernetes Ingress image was released on 22 September 2021.

This image is no longer available.
{: note}

Updates to address
- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){:external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){:external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){:external}

### Version 0.48.1_1613_iks
{: #0.48.1_1613_iks}

Version 0.48.1_1613_iks of the Kubernetes Ingress image was released on 09 September 2021.

Updates to address
- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external}
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.48.1_1579_iks
{: #0.48.1_1579_iks}

Version 0.48.1_1579_iks of the Kubernetes Ingress image was released on 01 September 2021.

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.48.1_1541_iks
{: #0.48.1_1541_iks}

Version 0.48.1_1541_iks of the Kubernetes Ingress image was released on 23 August 2021.

Updates to address
- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}

### Version 0.48.1_1465_iks
{: #0.48.1_1465_iks}

Version 0.48.1_1465_iks of the Kubernetes Ingress image was released on 10 August 2021.

Version 0.48.1_1465_iks is now the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto-update enabled, your ALBs automatically update to use this image.

## Version 0.47.0 
{: #0_47_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0470){: external}. Refer to the following table for a summary of changes for each build of version 0.47.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}


### Version 0.47.0_1614_iks
{: #0.47.0_1614_iks}

Version 0.47.0_1614_iks of the Kubernetes Ingress image was released on 09 September 2021.

This image is no longer available.
{: note}

Updates to address
- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external}
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.47.0_1578_iks
{: #0.47.0_1578_iks}

Version 0.47.0_1578_iks of the Kubernetes Ingress image was released on 01 September 2021.

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.47.0_1540_iks
{: #0.47.0_1540_iks}

Version 0.47.0_1540_iks of the Kubernetes Ingress image was released on 23 August 2021.

Updates to address
- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}

### Version 0.47.0_1480_iks
{: #0.47.0_1480_iks}

Version 0.47.0_1480_iks of the Kubernetes Ingress image was released on 10 August 2021.

Updates to address
- [CVE-2021-34558](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-34558){: external}

### Version 0.47.0_1434_iks
{: #0.47.0_1434_iks}

Version 0.47.0_1434_iks of the Kubernetes Ingress image was released on 02 August 2021.

Updates to address 
- [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: extenral}
- [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}
- [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}

### Version 0.47.0_1376_iks
{: #0.47.0_1376_iks}

Version 0.47.0_1376_iks of the Kubernetes Ingress image was released on 06 July 2021.

Updates to address [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.

### Version 0.47.0_1341_iks
{: #0.47.0_1341_iks}

Version 0.47.0_1341_iks of the Kubernetes Ingress image was released on 21 June 2021.

Version 0.47.0 is now the default version for all ALBs that run the Kubernetes Ingress image.

## Version 0.45.0
{: #0_45_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0450){: external}. Refer to the following table for a summary of changes for each build of version 0.45.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.45.0_1482_iks
{: #0.45.0_1482_iks}

Version 0.45.0_1482_iks of the Kubernetes Ingress image was released on 10 August 2021.

This image is no longer available.
{: note}

### Version 0.45.0_1435_iks
{: #0.45.0_1435_iks}

Version 0.45.0_1435_iks of the Kubernetes Ingress image was released on 02 August 2021.

Updates to address
- [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: extenral}
- [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}
- [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}

### Version 0.45.0_1329_iks
{: #0.45.0_1329_iks}

Version 0.45.0_1329_iks of the Kubernetes Ingress image was released on 21 June 2021.

Updates to address
- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

### Version regression
{: #regression}

This update was released on 25 May 2021.

Due to a [regression in the community Kubernetes Ingress NGINX code](https://github.com/kubernetes/ingress-nginx/issues/6931){: external}, trailing slashes (`/`) are removed from subdomains during TLS redirects.

### Version 0.45.0_1228_iks
{: #0.45.0_1228_iks}

Version 0.45.0_1228_iks of the Kubernetes Ingress image was released on 23 April 2021.

Version 0.45.0 is now the default version for all ALBs that run the Kubernetes Ingress image.


## Version 0.43.0
{: #0_43_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0430){: external}. Refer to the following table for a summary of changes for each build of version 0.43.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.43.0_1697_iks
{: #0.43.0_1697_iks}

Version 0.43.0_1697_iks of the Kubernetes Ingress image was released on 22 September 2021.

This image is no longer available.
{: note}

Updates to address 
- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){:external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){:external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){:external}

### Version 0.43.0_1612_iks
{: #0.43.0_1612_iks}

Version 0.43.0_1612_iks of the Kubernetes Ingress image was released on 09 September 2021.

Updates to address
- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} 
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.43.0_1580_iks
{: #0.43.0_1580_iks}

Version 0.43.0_1580_iks of the Kubernetes Ingress image was released on 01 September 2021.

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.43.0_1539_iks
{: #0.43.0_1539_iks}

Version 0.43.0_1539_iks of the Kubernetes Ingress image was released on 23 August 2021.

Updates to address
- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}
## Archive
{: #archive-unsupported}

### Version 0.35.0
{: #0_35_0}

Kubernetes Ingress controller version 0.35.0 is no longer supported.
{: important}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0350){: external}. Refer to the following table for a summary of changes for each build of version 0.35.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.35.0_1374_iks
{: #0.35.0_1374_iks}

Version 0.35.0_1374_iks of the Kubernetes Ingress image was released on 06 July 2021.

Updates to address [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.

#### Version 0.35.0_1330_iks
{: #0.35.0_1330_iks}

Version 0.35.0_1330_iks of the Kubernetes Ingress image was released on 21 Jun 2021.

Updates to address 
- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

#### Version 0.35.0_1182_iks
{: #0.35.0_1182_iks}

Version 0.35.0_1182_iks of the Kubernetes Ingress image was released on 19 April 2021.

Updates to address 
- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.35.0_1155_iks
{: #0.35.0_1155_iks}

Version 0.35.0_1155_iks of the Kubernetes Ingress image was released on 12 April 2021.

Fixes OpenSSL vulnerabilities
- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}

#### Version update
{: #version-update}

Version 0.35.0__iks of the Kubernetes Ingress image was released on 25 March 2021.

In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. 

#### Version 0.35.0_1094_iks
{: #0.35.0_1094_iks}

Version 0.35.0_1094_iks of the Kubernetes Ingress image was released on 22 March 2021.

Fixes `golang` vulnerabilities
- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.35.0_869_iks
{: #0.35.0_869_iks}

Version 0.35.0_869_iks of the Kubernetes Ingress image was released on 07 January 2021.

Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}

#### Version 0.35.0_826_iks
{: #0.35.0_826_iks}

Version 0.35.0_826_iks of the Kubernetes Ingress image was released on 17 December 2020.

Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.35.0_767_iks
{: #0.35.0_767_iks}

Version 0.35.0_767_iks of the Kubernetes Ingress image was released on 14 December 2020.

Updates the Go version to 1.15.5
- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.35.0_474_iks
{: #0.35.0_474_iks}

Version 0.35.0_474_iks of the Kubernetes Ingress image was released on 07 October 2020.

Fixes vulnerabilities
- [CVE-2020-24977](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24977){: external}
- [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169){: external}
- [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}


### Version 0.34.1 (unsupported)
{: #0_34_1}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0341){: external}. Refer to the following table for a summary of changes for each build of version 0.34.1 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.34.1_1331_iks
{: #0.34.1_1331_iks}

Version 0.34.1_1331_iks of the Kubernetes Ingress image was released on 21 June 2021.

Updates to address
- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

#### Version 0.34.1_1191_iks
{: #0.34.1_1191_iks}

Version 0.34.1_1191_iks of the Kubernetes Ingress image was released on 19 April 2021.

Updates to address
- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.34.1_1153_iks
{: #0.34.1_1153_iks}

Version 0.34.1_1153_iks of the Kubernetes Ingress image was released on 12 April 2021.

Fixes OpenSSL vulnerabilities
- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}.

#### Version update
{: #version-update-34}

Version update of the Kubernetes Ingress image was released on 25 March 2021.

In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.34.1_1096_iks
{: #0.34.1_1096_iks}

Version 0.34.1_1096_iks of the Kubernetes Ingress image was released on 22 March 2021.

Fixes `golang` vulnerabilities
- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.34.1_866_iks
{: #0.34.1_866_iks}

Version 0.34.1_866_iks of the Kubernetes Ingress image was released on 07 January 2021.

Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.

#### Version 0.34.1_835_iks
{: #0.34.1_835_iks}

Version 0.34.1_835_iks of the Kubernetes Ingress image was released on 17 December 2020.

Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.34.1_764_iks
{: #0.34.1_764_iks}

Version 0.34.1_1_764_iks_iks of the Kubernetes Ingress image was released on 14 December 2020.

Updates the Go version to 1.15.5
- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.34.1_391_iks
{: #0.34.1_391_iks}

Version 0.34.1_391_iks of the Kubernetes Ingress image was released on 24 August 2020.

Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

### Version 0.33.0 (unsupported)
{: #0_33_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0330){: external}. Refer to the following table for a summary of changes for each build of version 0.33.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.33.0_1198_iks
{: #0.33.0_1198_iks}

Version 0.33.0_1198_iks of the Kubernetes Ingress image was released on 19 April 2021.

Updates to address
- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.33.0_1154_iks
{: #0.33.0_1154_iks}

Version 0.33.0_1154_iks of the Kubernetes Ingress image was released on 12 April 2021.

Fixes OpenSSL vulnerabilities
- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}

#### Version updates
{: #version-updates-33}

Version update of the Kubernetes Ingress image was released on 25 March 2021.

In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.33.0_1097_iks
{: #0.33.0_1097_iks}

Version 0.33.0_1097_iks of the Kubernetes Ingress image was released on 22 March 2021.

Fixes `golang` vulnerabilities
- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.33.0_865_iks
{: #0.33.0_865_iks}

Version 0.33.0_865_iks of the Kubernetes Ingress image was released on 07 January 2021.

Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.

#### Version 0.33.0_834_iks
{: #0.33.0_834_iks}

Version 0.33.0_834_iks of the Kubernetes Ingress image was released on 17 December 2020.

Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.33.0_768_iks
{: #0.33.0_768_iks}

Version 0.33.0_768_iks of the Kubernetes Ingress image was released on 14 December 2020.

Updates the Go version to 1.15.5
- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.33.0_390_iks
{: #0.33.0_390_iks}

Version 0.33.0_390_iks of the Kubernetes Ingress image was released on 24 August 2020.

Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

### Version 0.32.0 (unsupported)
{: #0_32_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0320){: external}. Refer to the following table for a summary of changes for each build of version 0.32.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version update
{: #version-update-32}

Version update of the Kubernetes Ingress image was released on 22 September 2021.

In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.32.0_392_iks
{: #0.32.0_392_iks}

Version 0.32.0_392_iks of the Kubernetes Ingress image was released on 24 August 2020.

Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

## Fluentd for logging changelog
{: #fluentd_changelog}

View image version changes for the Fluentd component for logging in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

As of 14 November 2019, a Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you do not forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).
{: important}

Refer to the following information for a summary of changes for each build of the Fluentd component.

### 14 Nov 2019
{: #14-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
    : None
    
Disruptive
    : The Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you do not forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).

### 06 Nov 2019
{: #06-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
    : Fixes `LibSass` vulnerabilities for [CVE-2018-19218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19218){: external}.
    
Disruptive
    : None

### 28 October 2019
{: #28-oct-2019}

The following changes occurred for the `ee01ba3471cadbb9925269183acd724f4bf0e5bd` Fluentd component.

Non-disruptive changes
    : Fixes Ruby vulnerabilities
        - [CVE-2019-15845](https://www.ruby-lang.org/en/news/2019/10/01/nul-injection-file-fnmatch-cve-2019-15845/){: external}
        - [CVE-2019-16201](https://www.ruby-lang.org/en/news/2019/10/01/webrick-regexp-digestauth-dos-cve-2019-16201/){: external}
        - [CVE-2019-16254](https://www.ruby-lang.org/en/news/2019/10/01/http-response-splitting-in-webrick-cve-2019-16254/){: external}
        - [CVE-2019-16255](https://www.ruby-lang.org/en/news/2019/10/01/code-injection-shell-test-cve-2019-16255/){: external}
    
Disruptive
    : None

### 24 September 2019
{: #24-sept-2019}

The following changes occurred for the `58c604236080f142f35d14fe3b6c4b4484290121` Fluentd component.

Non-disruptive changes
    : Fixes OpenSSL vulnerabilities
        - [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}
        - [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}
        - [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}
    
Disruptive
    : None

### 18 September 2019
{: #18-sept-2019}

The following changes occurred for the `7c94e41a34ff1b7a56b9163471ff740a9585e053` Fluentd component.

Non-disruptive changes
    : Updates the Kubernetes API version in the Fluentd deployment from `extensions/v1beta1` to `apps/v1`.
    
Disruptive
    : None

### 15 August 2019
{: #14-aug-2019}

The following changes occurred for the `e7e944a8279deee0c3a8743e2fa69696ed71b6f5` Fluentd component.

Non-disruptive changes
    : Fixes GNU binary utilities (`binutils`) vulnerabilities
        - [CVE-2018-6543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6543){: external}
        - [CVE-2018-6759](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6759){: external}
        - [CVE-2018-6872](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6872){: external}
        - [CVE-2018-7208](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7208){: external}
        - [CVE-2018-7568](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7568){: external}
        - [CVE-2018-7569](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7569){: external}
        - [CVE-2018-7570](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7570){: external}
        - [CVE-2018-7642](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7642){: external}
        - [CVE-2018-7643](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7643){: external}
        - [CVE-2018-8945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8945){: external}
    
Disruptive
    : None

<td></a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
<td>-</td>

### 09 August 2019
{: #09-aug-2019}

The following changes occurred for the `d24b1afcc004ec9745dc3f9ef1328d3ed4b495f8` Fluentd component.

Non-disruptive changes
    : Fixes `musl libc` vulnerabilities for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.
    
Disruptive
    : None

### 22 July 2019
{: #22-july-2019}

The following changes occurred for the `96f399cdea1c86c63a4ca4e043180f81f3559676` Fluentd component.

Non-disruptive changes
    : Updates Alpine packages
        - [CVE-2019-8905](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905){: external}
        - [CVE-2019-8906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906){: external}
        - [CVE-2019-8907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907){: external}
    
Disruptive
    : None

### 30 June 2019
{: #30-june-2019}

The following changes occurred for the `e7c10d74350dc64d4d92ba7f72bb4ff9219315d2` Fluentd component.

Non-disruptive changes
    : Updates the Fluent config map to always ignore pod logs from IBM namespaces, even when the Kubernetes master is unavailable.
    
Disruptive
    : None

### 21 May 2019
{: #21-may-2019}

The following changes occurred for the `c16fe1602ab65db4af0a6ac008f99ca2a526e6f6` Fluentd component.

Non-disruptive changes
    : Fixes a bug where worker node metrics did not display.
    
Disruptive
    : None


### 10 May 2019
{: #10-may-2019}

The following changes occurred for the `60fc11f7bd39d9c6cfed923c598bf6457b3f2037` Fluentd component.

Non-disruptive changes
    : Updates Ruby packages
        - [CVE-2019-8320](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
        - [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
        - [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
        - [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
        - [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
        - [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
    : None

### 08 May 2019
{: #08-may-2019}

The following changes occurred for the `91a737f68f7d9e81b5d2223c910aaa7d7f91b76d` Fluentd component.

Non-disruptive changes
    : Updates Ruby packages
        - [CVE-2019-8320])https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
        - [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
        - [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
        - [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
        - [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
        - [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
    : None


### 11 April 2019
{: #11-april-2019}

The following changes occurred for the `d9af69e286986a05ed4a50469585b1cf978ddb1d` Fluentd component.

Non-disruptive changes
    : Updates the cAdvisor plug-in to use TLS 1.2.
    
Disruptive
    : None

### 01 April 2019
{: #01-april-2019}

The following changes occurred for the `3100ddb62580a9f46ffdff7bab2ebec40b164de6` Fluentd component.

Non-disruptive changes
    : Updates the Fluentd service account.
    
Disruptive
    : None

### 18 March 2019
{: #18-mar-2019}

The following changes occurred for the `c85567b75bd7ad1c9428794cd63a8e239c3fd8f5` Fluentd component.

Non-disruptive changes
    : Removes the dependency on cURL for [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}.
    
Disruptive
    : None

### 18 February 2019
{: #18-feb-2019}

The following changes occurred for the `320ffdf87de068ee2f7f34c0e7a47a111e8d457b` Fluentd component.

Non-disruptive changes
    : - Updates Fluentd to version 1.3.
      - Removes Git from the Fluentd image for [CVE-2018-19486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486){: external}.
    
Disruptive
    : None


### 01 January 2019
{: #01-jan-2019}

The following changes occurred for the `972865196aefd3324105087878de12c518ed579f` Fluentd component.

Non-disruptive changes
    : - Enables UTF-8 encoding for the Fluentd `in_tail` plug-in.
      - Minor bug fixes.
    
Disruptive
    : None



