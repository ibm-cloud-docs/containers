---

copyright:
  years: 2014, 2023
lastupdated: "2023-10-12"

keywords: kubernetes, nginx, ingress controller, fluentd
subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Ingress ALB and Fluentd version change log
{: #cluster-add-ons-changelog}

Your {{site.data.keyword.containerlong}} cluster comes with components, such as the Fluentd and Ingress ALB components, that are updated automatically by IBM. You can also disable automatic updates for some components and manually update them separately from the master and worker nodes. Refer to the tables in the following sections for a summary of changes for each version.
{: shortdesc}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an IBM Security Bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

For more information about managing updates for Fluentd and Ingress ALBs, see [Updating cluster components](/docs/containers?topic=containers-update#components).

## Kubernetes Ingress image change log
{: #kube_ingress_changelog}


View version changes for Ingress application load balancers (ALBs) that run the [community Kubernetes Ingress image](/docs/containers?topic=containers-managed-ingress-about).
{: shortdesc}

When you create a new ALB, enable an ALB that was previously disabled, or manually update an ALB, you can specify an image version for your ALB in the `--version` option. The latest three versions of the Kubernetes Ingress image are supported for ALBs. To list the currently supported versions, run the following command:


```sh
ibmcloud ks ingress alb versions
```
{: pre}

The Kubernetes Ingress version follows the format `<community_version>_<ibm_build>_iks`. The IBM build number indicates the most recent build of the Kubernetes Ingress NGINX release that {{site.data.keyword.containerlong_notm}} released. For example, the version `1.1.2_2507_iks` indicates the most recent build of the `0.47.0` Ingress NGINX version. {{site.data.keyword.containerlong_notm}} might release builds of the community image version to address vulnerabilities.

When automatic updates are enabled for ALBs, your ALBs are updated to the most recent build of the version that is marked as `default`. If you want to use a version other than the default, you must [disable automatic updates](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_autoupdate_disable). Typically, the latest version becomes the default version one month after the latest version is released by the Kubernetes community. Actual availability and release dates of versions are subject to change and depend on various factors, such as community updates, security patches, and technology changes between versions.

## Version 1.8.1
{: #1_8_1}

1.8.1 is now the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image.


### 1.8.1_5434_iks, released 11 October 2023
{: #1.8.1_5434_iks}

- Go version update.
 

### 1.8.1_5384_iks, released 5 October 2023
{: #1.8.1_5384_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}


### 1.8.1_5317_iks, released 31 August 2023
{: #1.8.1_5317_iks}

- Initial release of `1.8.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.8.1){: external}.


## Version 1.6.4
{: #1_6_4}

### 1.6.4_5435_iks, released 11 October 2023
{: #1.6.4_5435_iks}

Go version update.

### 1.6.4_5406_iks, released 5 October 2023
{: #1.6.4_5406_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}

### 1.6.4_5270_iks, released 31 August 2023
{: #1.6.4_5270_iks}

- Resolves [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}
- Updates `golang` version to `1.20.7`.

### 1.6.4_5219_iks, released 26 July 2023
{: #1.6.4_5219_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

### 1.6.4_5161_iks, released 5 July 2023
{: #1.6.4_5161_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

### 1.6.4_5067_iks, released 6 June 2023
{: #1.6.4_5067_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

### 1.6.4_4170_iks, released 23 May 2023
{: #1.6.4_4170_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

### 1.6.4_4117_iks, released 4 May 2023
{: #1.6.4_4117_iks}

- Image update.

### 1.6.4_4073_iks, released 27 April 2023
{: #1.6.4_4073_iks}

- [CVE-2023-1255](https://nvd.nist.gov/vuln/detail/CVE-2023-1255){: external}
- [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}
- [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}

### 1.6.4_3976_iks, released 12 April 2023
{: #1.6.4_3976_iks}

Updates `golang` to version `1.20.3`.

### 1.6.4_3947_iks, released 4 April 2023
{: #1.6.4_3947_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}
- [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}

### 1.6.4_3898_iks, released 24 March 2023
{: #1.6.4_3898_iks}

- Updates `golang` version to `1.20.2`.
- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

### 1.6.4_3864_iks, released 13 March 2023
{: #1.6.4_3864_iks}

- Initial release of `1.6.4`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.6.4){: external}.
- Updates the default OpenSSL version from `1.1.1t` to `3.0.8`. 

TLS 1.0 and TLS 1.1 are no longer supported. Upgrade to the newer TLS version, or as a workaround you can change the security level to `0` for OpenSSL, by appending `@SECLEVEL=0` to your cipher list in the `kube-system/ibm-k8s-controller-config` ConfigMap. For example: `ssl-ciphers: HIGH:!aNULL:!MD5:!CAMELLIA:!AESCCM:!ECDH+CHACHA20@SECLEVEL=0`
{: important}

## Version 1.5.1
{: #1_5_1}

### 1.5.1_5436_iks, released 11 October 2023
{: #1.5.1_5436_iks}

Go version update.

### 1.5.1_5407_iks, released 5 October 2023
{: #1.5.1_5407_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}

### 1.5.1_5318_iks, released 31 August 2023
{: #1.5.1_5318_iks}

- Resolves [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}
- Updates `golang` version to `1.20.7`.

### 1.5.1_5217_iks, released 26 July 2023
{: #1.5.1_5217_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

### 1.5.1_5160_iks, released 5 July 2023
{: #1.5.1_5160_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

### 1.5.1_5074_iks, released 6 June 2023
{: #1.5.1_5074_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

### 1.5.1_4168_iks, released 23 May 2023
{: #1.5.1_4168_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

### 1.5.1_4113_iks, released 4 May 2023
{: #1.5.1_4113_iks}

- Image update.

### 1.5.1_4064_iks, released 27 April 2023
{: #1.5.1_4064_iks}

- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

### 1.5.1_3977_iks, released 12 April 2023
{: #1.5.1_3977_iks}

Updates `golang` to version `1.20.3`.

### 1.5.1_3951_iks, released 4 April 2023
{: #1.5.1_3951_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}

### 1.5.1_3897_iks, released 24 March 2023
{: #1.5.1_3897_iks}

Updates `golang` version to `1.20.2`.

### 1.5.1_3863_iks, released 13 March 2023
{: #1.5.1_3863_iks}

Dependency updates.

### 1.5.1_3809_iks, released 23 February 2023
{: #1.5.1_3809_iks}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

### 1.5.1_3779_iks, released 20 February 2023
{: #1.5.1_3779_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}
- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

### 1.5.1_3705_iks, released 30 January 2023
{: #1.5.1_3705_iks}

Updates the golang version to 1.19.5.

### 1.5.1_3683_iks, released 24 January 2023
{: #1.5.1_3683_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

### 1.5.1_3536_iks, released 3 January 2023
{: #1.5.1_3536_iks}

Initial release of `1.5.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.5.1){: external}.

## Version 1.4.0 (unsupported)
{: #1_4_0}

Version 1.4.0 is no longer supported.

### 1.4.0_5218_iks, released 26 July 2023
{: #1.4.0_5218_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

### 1.4.0_5159_iks, released 5 July 2023
{: #1.4.0_5159_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

### 1.4.0_5068_iks, released 6 June 2023
{: #1.4.0_5068_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

### 1.4.0_4169_iks, released 23 May 2023
{: #1.4.0_4169_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

### 1.4.0_4114_iks, released 4 May 2023
{: #1.4.0_4114_iks}

- Image update.

### 1.4.0_4062_iks, released 27 April 2023
{: #1.4.0_4062_iks}

- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

### 1.4.0_3978_iks, released 12 April 2023
{: #1.4.0_3978_iks}

Updates `golang` to version `1.20.3`.


### 1.4.0_3953_iks, released 4 April 2023
{: #1.4.0_3953_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}

### 1.4.0_3896_iks, released 24 March 2023
{: #1.4.0_3896_iks}

Updates `golang` version to `1.20.2`.

### 1.4.0_3862_iks, released 13 March 2023
{: #1.4.0_3862_iks}

Dependency updates.

### 1.4.0_3808_iks, released 23 February 2023
{: #1.4.0_3808_iks}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

### 1.4.0_3783_iks, released 20 February 2023
{: #1.4.0_3783_iks}

- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

### 1.4.0_3755_iks, released 10 February 2023
{: #1.4.0_3755_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}

### 1.4.0_3703_iks, released 30 January 2023
{: #1.4.0_3703_iks}

Updates the golang version to 1.19.5.

### 1.4.0_3684_iks, released 24 January 2023
{: #1.4.0_3684_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

### 1.4.0_3537_iks, released 3 January 2023
{: #1.4.0_3537_iks}

- [CVE-2022-43551](https://nvd.nist.gov/vuln/detail/CVE-2022-43551){: external}
- [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}

### 1.4.0_3297_iks, released 15 December 2022
{: #1.4.0_3297_iks}

[CVE-2022-41717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-41717){: external}

### 1.4.0_3212_iks, released 12 December 2022
{: #1.4.0_3212_iks}

Initial release of `1.4.0`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.4.0){: external}.

## Version 1.3.1 (unsupported)
{: #1_3_1}

Version 1.3.1 is no longer supported.

### 1.3.1_3807_iks, released 23 February 2023
{: #1.3.1_3807_ikss}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

### 1.3.1_3777_iks, released 20 February 2023
{: #1.3.1_3777_iks}

- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

### 1.3.1_3754_iks, released 10 February 2023
{: #1.3.1_3754_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}

### 1.3.1_3704_iks, released 30 January 2023
{: #1.3.1_3704_iks}

Updates the golang version to 1.19.5.

### 1.3.1_3685_iks, released 24 January 2023
{: #1.3.1_3685_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

### 1.3.1_3538_iks, released 3 January 2023
{: #1.3.1_3538_iks}

- [CVE-2022-43551](https://nvd.nist.gov/vuln/detail/CVE-2022-43551){: external}
- [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}

### 1.3.1_3298_iks, released 15 December 2022
{: #1.3.1_3298_iks}

[CVE-2022-41717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-41717){: external}

### 1.3.1_3192_iks, released 8 December 2022
{: #1.3.1_3192_iks}

Updated the golang version to 1.19.3.

### 1.3.1_3108_iks, released 30 November 2022
{: #1.3.1_3108_iks}

Initial release of `1.3.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.3.1){: external}.


## Version 1.3.0 (unsupported)
{: #1_3_0}

Version 1.3.0 is no longer supported.

### 1.3.0_2907_iks, released 31 October 2022
{: #1.3.0_2907_iks}

- [CVE-2022-32221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32221){: external}
- [CVE-2022-42915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42915){: external}
- [CVE-2022-42916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42916){: external} 

### 1.3.0_2847_iks, released 25 October 2022
{: #1.3.0_2847_iks}

Initial release of `1.3.0`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.3.0){: external}.

## Version 1.2.1 (unsupported)
{: #1_2_1}

Version 1.2.1 is no longer supported.

### 1.2.1_3299_iks, released 15 December 2022
{: #1.2.1_3299_iks}

[CVE-2022-41717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-41717){: external}

### 1.2.1_3186_iks, released 5 December 2022
{: #1.2.1_3186_iks}

Updated the golang version to 1.19.3.

### 1.2.1_3111_iks, released 30 November 2022
{: #1.2.1_3111_iks}

Metadata changes.

### 1.2.1_2809_iks, released 25 October 2022
{: #1.2.1_2809_iks}

- [CVE-2022-32149](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32149){: external}
- [CVE-2022-40303](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40303){: external}
- [CVE-2022-40304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40304){: external} 

### 1.2.1_2714_iks, released 13 October 2022
{: #1.2.1_2714_iks}

Updated the NGINX base image.

### Version 1.2.1_2646_iks, released 3 October 2022
{: #1.2.1_2646_iks}

- Managed configuration changes. For more information, see [Ingress ConfigMap change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).

### Version 1.2.1_2558_iks, released 21 September 2022
{: #1.2.1_2558_iks}

- [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}
- [CVE-2022-27664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27664){: external}

### Version 1.2.1_2506_iks, released 25 August 2022
{: #1.2.1_2506_iks}

- [CVE-2022-3209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3209){: external}

### Version 1.2.1_2488_iks, released 11 August 2022
{: #1.2.1_2488_iks}

- [CVE-2022-37434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-37434){: external}

### Version 1.2.1_2487_iks, released 11 August 2022
{: #1.2.1_2487_iks}

- [CVE-2022-37434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-37434){: external}

### Version 1.2.1_2426_iks, released 2 August 2022
{: #1.2.1_2426_iks}

- [CVE-2022-30065](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-30065){: external}
- [CVE-2022-21221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21221){: external}



### Version 1.2.1_2415_iks, released 19 July 2022
{: #1.2.1_2415_iks}

- [CVE-2022-29458](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29458){: external}
- [CVE-2022-2097](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2097){: external}
- [CVE-2022-27781](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27781){: external}
- [CVE-2022-27782](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27782){: external}
- [CVE-2022-32205](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32205){: external}
- [CVE-2022-32206](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32206){: external}
- [CVE-2022-32207](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32207){: external}
- [CVE-2022-32208](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32208){: external} 

### Version 1.2.1_2337_iks, released 10 Jun 2022
{: #1.2.1_2337_iks}

- Initial release of `1.2.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.1){: external}.
- Resolves [CVE-2021-25748](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25748){: external}

## Version 1.2.0
{: #1_2_0}

### Version 1.2.0_2251_iks, released 19 May 2022
{: #1.2.0_2251_iks}

Resolves [CVE-2022-29824](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29824){: external}

### Version 1.2.0_2147_iks, released 4 May 2022
{: #1.2.0_2147_iks}

- [CVE-2022-22576](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22576){: external}
- [CVE-2022-27774](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27774){: external}
- [CVE-2022-27775](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27775){: external}
- [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27776){: external}
- [CVE-2022-28327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28327){: external}
- [CVE-2022-24675](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-24675){: external}
- [CVE-2022-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27536){: external}

### Version 1.2.0_2131_iks, released 26 April 2022
{: #1.2.0_2131_iks}

- Initial release of `1.2.0`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.0){: external}.
- Resolves [CVE-2021-25745](https://access.redhat.com/security/cve/cve-2021-25745){: external} and [CVE-2021-25746](https://access.redhat.com/security/cve/cve-2021-25746){: external}. For more information, see the [security bulletin](https://www.ibm.com/support/pages/node/6575101){: external}.

## Version 1.1.2 
{: #1_1_2}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following table for a summary of changes for each build of version 1.1.2 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

Version 1.1.2 is no longer available.

### Version 1.1.2_2808_iks, released on 25 October 2022
{: #1.1.2_2808_iks}

- [CVE-2022-32149](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32149){: external}
- [CVE-2022-40303](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40303){: external}
- [CVE-2022-40304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40304){: external} 

### Version 1.1.2_2645_iks, released on 3 October 2022
{: #1.1.2_2645_iks}

- Managed configuration changes. For more information, see [Ingress ConfigMap change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).

### Version 1.1.2_2586_iks, released on 21 September 2022
{: #1.1.2_2586_iks}

- [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}
- [CVE-2022-27664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27664){: external}

### Version 1.1.2_2507_iks, released on 25 August 2022
{: #1.1.2_2507_iks}

- [CVE-2022-3209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3209){: external}

### Version 1.1.2_2411_iks, released on 2 August 2022
{: #1.1.2_2411_iks}

Resolves [CVE-2022-30065](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-30065){: external}



### Version 1.1.2_2368_iks, released on 19 July 2022
{: #1.1.2_2368_iks}

- [CVE-2022-29458](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29458){: external}
- [CVE-2022-2097](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2097){: external}

### Version 1.1.2_2305_iks, released on 5 July 2022
{: #1.1.2_2305_iks}

- [CVE-2022-29162](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29162){: external}
- [CVE-2022-21221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-21221){: external}

### Version 1.1.2_2252_iks, released on 19 May 2022
{: #1.1.2_2252_iks}

Resolves [CVE-2022-29824](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29824){: external}

### Version 1.1.2_2146_iks, released on 4 May 2022
{: #1.1.2_2146_iks}

- [CVE-2022-22576](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22576){: external}
- [CVE-2022-27774](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27774){: external}
- [CVE-2022-27775](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27775){: external}
- [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27776){: external}
- [CVE-2022-28327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28327){: external}
- [CVE-2022-24675](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-24675){: external}
- [CVE-2022-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27536){: external}

### Version 1.1.2_2121_iks, released on 21 April 2022
{: #1.1.2_2121_iks}

Resolves [CVE-2022-1271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1271){: external}

### Version 1.1.2_2084_iks, released on 7 April 2022
{: #1.1.2_2084_iks}

- [CVE-2018-25032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-25032){: external}
- [CVE-2022-28391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28391){: external}
- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}

### Version 1.1.2_2050_iks, released on 22 March 2022
{: #1.1.2_2050_iks}

- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}
- [CVE-2022-23308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23308){: external}

## Version 1.1.1 
{: #1_1_1}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following table for a summary of changes for each build of version 1.1.1 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}




### Version 1.1.1_2119_iks, released on 21 April 2022
{: #1.1.1_2119_iks}

Resolves [CVE-2022-1271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1271){: external}

### Version 1.1.1_2085_iks, released on 7 April 2022
{: #1.1.1_2085_iks}

- [CVE-2018-25032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-25032){: external}
- [CVE-2022-28391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28391){: external}
- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}

### Version 1.1.1_2054_iks, released on 22 March 2022
{: #1.1.1_2054_iks}

- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}
- [CVE-2022-23308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23308){: external}

### Version 1.1.1_1996_iks, released on 24 February 2022
{: #1.1.1_1996_iks}

- [CVE-2022-23772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23772){: external}
- [CVE-2022-23773](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23773){: external}
- [CVE-2022-23806](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23806){: external}


### Version 1.1.1_1949_iks, released on 25 January 2022
{: #1.1.1_1949_iks}

- [CVE-2021-44716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44716){: external}
- [CVE-2021-44717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44717){: external}


## Version 1.0.0 
{: #1_0_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following table for a summary of changes for each build of version 1.0.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 1.0.3_1995_iks, released on 24 February 2022
{: #1.0.3_1995_iks}

- [CVE-2022-23772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23772){: external}
- [CVE-2022-23773](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23773){: external}
- [CVE-2022-23806](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23806){: external}

### Version 1.0.3_1933_iks, released on 25 January 2022
{: #1.0.3_1933_iks}

- [CVE-2021-44716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44716){: external}
- [CVE-2021-44717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44717){: external}

### Version 1.0.3_1831_iks, released on 19 November 2021
{: #1.0.3_1831_iks}

- [CVE-2021-41771](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41771){: external}
- [CVE-2021-41772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41772){: external}

### Version 1.0.3_1730_iks, released on 20 October 2021
{: #1.0.3_1730_iks}



### Version 1.0.0_1699_iks, released on 22 September 2021
{: #1.0.0_1699_iks}

- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){: external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){: external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){: external}

### Version 1.0.0_1645_iks, released on 14 September 2021
{: #1.0.0_1645_iks}

Initial release of version 1.0.0. 

## Version 0.49.0
{: #0_49_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#100){: external}. Refer to the following sections for a summary of changes for each build of version 0.49.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.49.3_2253_iks, released on 19 May 2022
{: #0.49.3_2253_iks}

This image is no longer available.
{: note}

Resolves [CVE-2022-29824](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29824){: external}

### Version 0.49.3_2145_iks, released on 4 May 2022
{: #0.49.3_2145_iks}

- [CVE-2022-22576](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22576){: external}
- [CVE-2022-27774](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27774){: external}
- [CVE-2022-27775](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27775){: external}
- [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27776){: external}
- [CVE-2022-28327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28327){: external}
- [CVE-2022-24675](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-24675){: external}
- [CVE-2022-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27536){: external}

### Version 0.49.3_2120_iks, released on 21 April 2022
{: #0.49.3_2120_iks}

Resolves [CVE-2022-1271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1271){: external}

### Version 0.49.3_2083_iks, released on 7 April 2022
{: #0.49.3_2083_iks}

- [CVE-2018-25032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-25032){: external}
- [CVE-2022-28391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28391){: external}
- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}

### Version 0.49.3_2051_iks, released on 22 March 2022
{: #0.49.3_2051_iks}

- [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}
- [CVE-2022-23308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23308){: external}

### Version 0.49.3_1994_iks, released on 24 February 2022
{: #0.49.3_1994_iks}

- [CVE-2022-23772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23772){: external}
- [CVE-2022-23773](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23773){: external}
- [CVE-2022-23806](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23806){: external}

### Version 0.49.3_1941_iks, released on 22 January 2022
{: #0.49.3_1941_iks}

- [CVE-2021-44716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44716){: external}
- [CVE-2021-44717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44717){: external}

### Version 0.49.3_1830_iks, released on 19 November 2021
{: #0.49.3_1830_iks}

- [CVE-2021-41771](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41771){: external}
- [CVE-2021-41772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-41772){: external}

### Version 0.49.3_1745_iks, released on 20 October 2021
{: #0.49.3_1745_iks}

As of 14 Sept 2021, this is the only image supported for Kubernetes version 1.18 clusters. 

## Version 0.48.0 
{: #0_48_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0480){: external}. Refer to the following table for a summary of changes for each build of version 0.48.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.48.1_1698_iks, released on 22 September 2021
{: #0.48.1_1698_iks}

This image is no longer available.
{: note}

- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){: external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){: external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){: external}

### Version 0.48.1_1613_iks, released on 09 September 2021
{: #0.48.1_1613_iks}

- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external}
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.48.1_1579_iks, released on 01 September 2021
{: #0.48.1_1579_iks}

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.48.1_1541_iks, released on 23 August 2021
{: #0.48.1_1541_iks}

- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}

### Version 0.48.1_1465_iks, released on 10 August 2021
{: #0.48.1_1465_iks}

## Version 0.47.0 
{: #0_47_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0470){: external}. Refer to the following table for a summary of changes for each build of version 0.47.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}


### Version 0.47.0_1614_iks, released on 09 September 2021
{: #0.47.0_1614_iks}

This image is no longer available.
{: note}

- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external}
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.47.0_1578_iks, released on 01 September 2021
{: #0.47.0_1578_iks}

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.47.0_1540_iks, released on 23 August 2021
{: #0.47.0_1540_iks}

- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}

### Version 0.47.0_1480_iks, released on 10 August 2021
{: #0.47.0_1480_iks}

- [CVE-2021-34558](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-34558){: external}

### Version 0.47.0_1434_iks, released on 02 August 2021
{: #0.47.0_1434_iks}

- [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external}{: extenral}
- [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}
- [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}

### Version 0.47.0_1376_iks, released on 06 July 2021
{: #0.47.0_1376_iks}

- [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.

### Version 0.47.0_1341_iks, released on 21 June 2021
{: #0.47.0_1341_iks}


## Version 0.45.0
{: #0_45_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0450){: external}. Refer to the following table for a summary of changes for each build of version 0.45.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.45.0_1482_iks, released on 10 August 2021
{: #0.45.0_1482_iks}

This image is no longer available.
{: note}

### Version 0.45.0_1435_iks, released on 02 August 2021
{: #0.45.0_1435_iks}

- [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external}{: extenral}
- [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}
- [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}

### Version 0.45.0_1329_iks, released on 21 June 2021
{: #0.45.0_1329_iks}

- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

### Version regression, released on 25 May 2021
{: #regression}

Due to a [regression in the community Kubernetes Ingress NGINX code](https://github.com/kubernetes/ingress-nginx/issues/6931){: external}, trailing slashes (`/`) are removed from subdomains during TLS redirects.

### Version 0.45.0_1228_iks, released on 23 April 2021
{: #0.45.0_1228_iks}

## Version 0.43.0
{: #0_43_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0430){: external}. Refer to the following table for a summary of changes for each build of version 0.43.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

### Version 0.43.0_1697_iks, released on 22 September 2021
{: #0.43.0_1697_iks}

This image is no longer available.
{: note}

- [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){: external}
- [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){: external}
- [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){: external}

### Version 0.43.0_1612_iks, released on 09 September 2021
{: #0.43.0_1612_iks}

- [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} 
- [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}

### Version 0.43.0_1580_iks, released on 01 September 2021
{: #0.43.0_1580_iks}

Updates to support arbitrary controller values in the Ingress classes.

### Version 0.43.0_1539_iks, released on 23 August 2021
{: #0.43.0_1539_iks}

- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36221){: external}
- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}

## Archive
{: #archive-unsupported}

### Version 0.35.0
{: #0_35_0}

Kubernetes Ingress controller version 0.35.0 is no longer supported.
{: important}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0350){: external}. Refer to the following table for a summary of changes for each build of version 0.35.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.35.0_1374_iks, released on 06 July 2021
{: #0.35.0_1374_iks}

- [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.

#### Version 0.35.0_1330_iks, released on 21 Jun 2021
{: #0.35.0_1330_iks}

- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

#### Version 0.35.0_1182_iks, released on 19 April 2021
{: #0.35.0_1182_iks}

- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.35.0_1155_iks, released on 12 April 2021
{: #0.35.0_1155_iks}

- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}

#### Version update, released on 25 March 2021
{: #version-update}

In the `ibm-k8s-controller-config` ConfigMap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. 

#### Version 0.35.0_1094_iks, released on 22 March 2021
{: #0.35.0_1094_iks}

- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.35.0_869_iks, released on 07 January 2021
{: #0.35.0_869_iks}

- [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}

#### Version 0.35.0_826_iks, released on 17 December 202
{: #0.35.0_826_iks}

- [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.35.0_767_iks, released on 14 December 2020
{: #0.35.0_767_iks}

- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.35.0_474_iks, released on 07 October 2020
{: #0.35.0_474_iks}

- [CVE-2020-24977](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24977){: external}
- [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169){: external}
- [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}


### Version 0.34.1 (unsupported)
{: #0_34_1}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0341){: external}. Refer to the following table for a summary of changes for each build of version 0.34.1 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.34.1_1331_iks, released on 21 June 2021
{: #0.34.1_1331_iks}

- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}
- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}
- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}

#### Version 0.34.1_1191_iks, released on 19 April 2021
{: #0.34.1_1191_iks}

- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.34.1_1153_iks, released on 12 April 2021
{: #0.34.1_1153_iks}

- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}.

#### Version update, released on 25 March 2021
{: #version-update-34}

In the `ibm-k8s-controller-config` ConfigMap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.34.1_1096_iks, released on 22 March 2021
{: #0.34.1_1096_iks}

- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.34.1_866_iks, released on 07 January 2021
{: #0.34.1_866_iks}

- [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.

#### Version 0.34.1_835_iks, released on 17 December 2020
{: #0.34.1_835_iks}

- [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.34.1_764_iks, released on 14 December 2020
{: #0.34.1_764_iks}

- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.34.1_391_iks, released on 24 August 2020
{: #0.34.1_391_iks}

- [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

### Version 0.33.0 (unsupported)
{: #0_33_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0330){: external}. Refer to the following table for a summary of changes for each build of version 0.33.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version 0.33.0_1198_iks, released on 19 April 2021
{: #0.33.0_1198_iks}

- [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

#### Version 0.33.0_1154_iks, released on 12 April 2021
{: #0.33.0_1154_iks}

- [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
- [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}

#### Version updates, released on 25 March 2021
{: #version-updates-33}

In the `ibm-k8s-controller-config` ConfigMap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.33.0_1097_iks, released on 22 March 2021
{: #0.33.0_1097_iks}

- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}

#### Version 0.33.0_865_iks, released on 07 January 2021
{: #0.33.0_865_iks}

- [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.

#### Version 0.33.0_834_iks, released on 17 December 2020
{: #0.33.0_834_iks}

- [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.

#### Version 0.33.0_768_iks, released on 14 December 2020
{: #0.33.0_768_iks}

- [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}
- [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}
- [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}

#### Version 0.33.0_390_iks, released on 24 August 2020
{: #0.33.0_390_iks}

- [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

### Version 0.32.0 (unsupported)
{: #0_32_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community change log for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0320){: external}. Refer to the following table for a summary of changes for each build of version 0.32.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

#### Version update, released on 22 September 2021
{: #version-update-32}

In the `ibm-k8s-controller-config` ConfigMap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers.

#### Version 0.32.0_392_iks, released on 24 August 2020
{: #0.32.0_392_iks}

- [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.

## Fluentd for logging change log
{: #fluentd_changelog}


View image version changes for the Fluentd component for logging in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

As of 14 November 2019, a Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you don't forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).
{: important}

Refer to the following information for a summary of changes for each build of the Fluentd component.

### 14 Nov 2019
{: #14-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
:   None
    
Disruptive
:   The Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you don't forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).

### 06 Nov 2019
{: #06-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
:   Fixes `LibSass` vulnerabilities for [CVE-2018-19218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19218){: external}.
    
Disruptive
:   None

### 28 October 2019
{: #28-oct-2019}

The following changes occurred for the `ee01ba3471cadbb9925269183acd724f4bf0e5bd` Fluentd component.

Non-disruptive changes
:   Fixes Ruby vulnerabilities
        - [CVE-2019-15845](https://www.ruby-lang.org/en/news/2019/10/01/nul-injection-file-fnmatch-cve-2019-15845/){: external}
        - [CVE-2019-16201](https://www.ruby-lang.org/en/news/2019/10/01/webrick-regexp-digestauth-dos-cve-2019-16201/){: external}
        - [CVE-2019-16254](https://www.ruby-lang.org/en/news/2019/10/01/http-response-splitting-in-webrick-cve-2019-16254/){: external}
        - [CVE-2019-16255](https://www.ruby-lang.org/en/news/2019/10/01/code-injection-shell-test-cve-2019-16255/){: external}
    
Disruptive
:   None

### 24 September 2019
{: #24-sept-2019}

The following changes occurred for the `58c604236080f142f35d14fe3b6c4b4484290121` Fluentd component.

Non-disruptive changes
:   Fixes OpenSSL vulnerabilities
        - [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}
        - [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}
        - [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}
    
Disruptive
:   None

### 18 September 2019
{: #18-sept-2019}

The following changes occurred for the `7c94e41a34ff1b7a56b9163471ff740a9585e053` Fluentd component.

Non-disruptive changes
:   Updates the Kubernetes API version in the Fluentd deployment from `extensions/v1beta1` to `apps/v1`.
    
Disruptive
:   None

### 15 August 2019
{: #14-aug-2019}

The following changes occurred for the `e7e944a8279deee0c3a8743e2fa69696ed71b6f5` Fluentd component.

Non-disruptive changes
:   Fixes GNU binary utilities (`binutils`) vulnerabilities
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
:   None


### 09 August 2019
{: #09-aug-2019}

The following changes occurred for the `d24b1afcc004ec9745dc3f9ef1328d3ed4b495f8` Fluentd component.

Non-disruptive changes
:    Fixes `musl libc` vulnerabilities for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.
    
Disruptive
:   None

### 22 July 2019
{: #22-july-2019}

The following changes occurred for the `96f399cdea1c86c63a4ca4e043180f81f3559676` Fluentd component.

Non-disruptive changes
:   Updates Alpine packages
        - [CVE-2019-8905](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905){: external}
        - [CVE-2019-8906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906){: external}
        - [CVE-2019-8907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907){: external}
    
Disruptive
:   None

### 30 June 2019
{: #30-june-2019}

The following changes occurred for the `e7c10d74350dc64d4d92ba7f72bb4ff9219315d2` Fluentd component.

Non-disruptive changes
:   Updates the Fluent config map to always ignore pod logs from IBM namespaces, even when the Kubernetes master is unavailable.
    
Disruptive
:   None

### 21 May 2019
{: #21-may-2019}

The following changes occurred for the `c16fe1602ab65db4af0a6ac008f99ca2a526e6f6` Fluentd component.

Non-disruptive changes
:   Fixes a bug where worker node metrics did not display.
    
Disruptive
:   None


### 10 May 2019
{: #10-may-2019}

The following changes occurred for the `60fc11f7bd39d9c6cfed923c598bf6457b3f2037` Fluentd component.

Non-disruptive changes
:   Updates Ruby packages
        - [CVE-2019-8320](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
        - [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
        - [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
        - [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
        - [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
        - [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
:   None

### 08 May 2019
{: #08-may-2019}

The following changes occurred for the `91a737f68f7d9e81b5d2223c910aaa7d7f91b76d` Fluentd component.

Non-disruptive changes
:   Updates Ruby packages
        - [CVE-2019-8320])https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
        - [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
        - [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
        - [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
        - [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
        - [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
:   None


### 11 April 2019
{: #11-april-2019}

The following changes occurred for the `d9af69e286986a05ed4a50469585b1cf978ddb1d` Fluentd component.

Non-disruptive changes
:   Updates the cAdvisor plug-in to use TLS 1.2.
    
Disruptive
:   None

### 01 April 2019
{: #01-april-2019}

The following changes occurred for the `3100ddb62580a9f46ffdff7bab2ebec40b164de6` Fluentd component.

Non-disruptive changes
:   Updates the Fluentd service account.
    
Disruptive
:   None

### 18 March 2019
{: #18-mar-2019}

The following changes occurred for the `c85567b75bd7ad1c9428794cd63a8e239c3fd8f5` Fluentd component.

Non-disruptive changes
:   Removes the dependency on cURL for [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}.
    
Disruptive
:   None

### 18 February 2019
{: #18-feb-2019}

The following changes occurred for the `320ffdf87de068ee2f7f34c0e7a47a111e8d457b` Fluentd component.

Non-disruptive changes
:   Updates Fluentd to version 1.3.
      - Removes Git from the Fluentd image for [CVE-2018-19486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486){: external}.
    
Disruptive
:   None


### 01 January 2019
{: #01-jan-2019}

The following changes occurred for the `972865196aefd3324105087878de12c518ed579f` Fluentd component.

Non-disruptive changes
:   Enables UTF-8 encoding for the Fluentd `in_tail` plug-in.
      - Minor bug fixes.
    
Disruptive
:   None
