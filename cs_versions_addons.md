---

copyright:
  years: 2014, 2021
lastupdated: "2021-08-05"

keywords: kubernetes, iks, nginx, ingress controller, fluentd

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:audio: .audio}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: .ph data-hd-programlang='c#'}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: #curl .ph data-hd-programlang='curl'}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: .external target="_blank"}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:middle: .ph data-hd-position='middle'}
{:navgroup: .navgroup}
{:new_window: target="_blank"}
{:node: .ph data-hd-programlang='node'}
{:note: .note}
{:note:.deprecated}
{:objectc: .ph data-hd-programlang='Objective C'}
{:objectc: data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: .ph data-hd-programlang='PHP'}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:right: .ph data-hd-position='right'}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:step: data-tutorial-type='step'} 
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:terraform: .ph data-hd-interface='terraform'}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:topicgroup: .topicgroup}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
  

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
```
ibmcloud ks ingress alb versions
```
{: pre}

The Kubernetes Ingress version follows the format `<community_version>_<ibm_build>_iks`. The IBM build number indicates the most recent build of the Kubernetes Ingress NGINX release that {{site.data.keyword.containerlong_notm}} released. For example, the version `0.47.0_1434_iks` indicates the most recent build of the `0.47.0` Ingress NGINX version. {{site.data.keyword.containerlong_notm}} might release builds of the community image version to address vulnerabilities.

When automatic updates are enabled for ALBs, your ALBs are updated to the most recent build of the version that is marked as `default`. If you want to use a version other than the default, you must [disable automatic updates](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_disable). Typically, the latest version becomes the default version one month after the latest version is released by the Kubernetes community. Actual availability and release dates of versions are subject to change and depend on various factors, such as community updates, security patches, and technology changes between versions.

### Version 0.47.0 (default)
{: #0_47_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0470){: external}. Refer to the following table for a summary of changes for each build of version 0.47.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 0.47.0_1434_iks | 02 Aug 2021 | Updates to address [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: extenral}, [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}, and [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}. |
| 0.47.0_1376_iks | 06 Jul 2021 | Updates to address [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.|
| 0.47.0_1341_iks | 21 Jun 2021 | Version 0.47.0 is now the default version for all ALBs that run the Kubernetes Ingress image. |
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.47.0 of the Kubernetes Ingress image" caption-side="top"}

### Version 0.45.0
{: #0_45_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0450){: external}. Refer to the following table for a summary of changes for each build of version 0.45.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 0.45.0_1435_iks | 02 Aug 2021 | Updates to address [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: extenral}, [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}, and [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}. |
| 0.45.0_1329_iks | 21 Jun 2021 | Updates to address [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}, [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}, [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}, [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}, and [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}.|
| - | 25 May 2021 | Due to a [regression in the community Kubernetes Ingress NGINX code](https://github.com/kubernetes/ingress-nginx/issues/6931){: external}, trailing slashes (`/`) are removed from subdomains during TLS redirects. |
| 0.45.0_1228_iks | 23 Apr 2021 | Version 0.45.0 is now the default version for all ALBs that run the Kubernetes Ingress image. |
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.45.0 of the Kubernetes Ingress image" caption-side="top"}

### Version 0.35.0
{: #0_35_0}

Kubernetes Ingress controller version 0.35.0 is no longer supported.
{: important}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0350){: external}. Refer to the following table for a summary of changes for each build of version 0.35.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 0.35.0_1374_iks | 06 Jul 2021 | Updates to address [CVE-2019-20633](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2019-20633){: external}.|
| 0.35.0_1330_iks | 21 Jun 2021 | Updates to address [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}, [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}, [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}, [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}, and [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}.|
| 0.35.0_1182_iks | 19 Apr 2021 | Updates to address [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}, [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}, and [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}.|
|0.35.0_1155_iks|12 Apr 2021|Fixes OpenSSL vulnerabilities for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}.|
| - |25 Mar 2021| In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. |
|0.35.0_1094_iks|22 Mar 2021|Fixes `golang` vulnerabilities for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external} and [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}.|
|0.35.0_869_iks|07 Jan 2021|Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.|
|0.35.0_826_iks|17 Dec 2020|Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.|
|0.35.0_767_iks|14 Dec 2020|Updates the Go version to 1.15.5 for [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}, [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, and [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}.|
|0.35.0_474_iks|07 Oct 2020|Fixes vulnerabilities for [CVE-2020-24977](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24977){: external}, [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169){: external}, and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}.|
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.35.0 of the Kubernetes Ingress image" caption-side="top"}

### Version 0.34.1 (unsupported)
{: #0_34_1}

For the community changes for this version of the Kubernetes Ingress image, see the [community Kubernetes changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0341){: external}. Refer to the following table for a summary of changes for each build of version 0.34.1 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 0.34.1_1331_iks | 21 Jun 2021 | Updates to address [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22898){: external}, [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22897){: external}, [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-22901){: external}, [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}, and [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}.|
| 0.34.1_1191_iks | 19 Apr 2021 | Updates to address [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}, [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}, and [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}.|
|0.34.1_1153_iks|12 Apr 2021|Fixes OpenSSL vulnerabilities for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}.|
| - |25 Mar 2021| In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. |
|0.34.1_1096_iks|22 Mar 2021|Fixes `golang` vulnerabilities for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external} and [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}.|
|0.34.1_866_iks|07 Jan 2021|Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.|
|0.34.1_835_iks|17 Dec 2020|Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.|
|0.34.1_764_iks|14 Dec 2020|Updates the Go version to 1.15.5 for [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}, [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, and [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}.|
|0.34.1_391_iks|24 Aug 2020|Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.|
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.34.1 of the Kubernetes Ingress image" caption-side="top"}

### Version 0.33.0 (unsupported)
{: #0_33_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0330){: external}. Refer to the following table for a summary of changes for each build of version 0.33.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 0.33.0_1198_iks | 19 Apr 2021 | Updates to address [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-20305){: external}, and [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}, and [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}.|
|0.33.0_1154_iks|12 Apr 2021|Fixes OpenSSL vulnerabilities for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}.|
| - |25 Mar 2021| In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. |
|0.33.0_1097_iks|22 Mar 2021|Fixes `golang` vulnerabilities for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external} and [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}.|
|0.33.0_865_iks|07 Jan 2021|Fixes an Alpine vulnerability for [CVE-2020-28241](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28241){: external}.|
|0.33.0_834_iks|17 Dec 2020|Fixes an Alpine vulnerability for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}.|
|0.33.0_768_iks|14 Dec 2020|Updates the Go version to 1.15.5 for [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}, [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, and [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}.|
|0.33.0_390_iks|24 Aug 2020|Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.|
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.33.0 of the Kubernetes Ingress image" caption-side="top"}

### Version 0.32.0 (unsupported)
{: #0_32_0}

For the community changes for this version of the Kubernetes Ingress image, see the [community changelog for `ingress-nginx`](https://github.com/kubernetes/ingress-nginx/blob/main/Changelog.md#0320){: external}. Refer to the following table for a summary of changes for each build of version 0.32.0 of the Kubernetes Ingress image that {{site.data.keyword.containerlong_notm}} releases.
{: shortdesc}

|Version build|Release date|Changes|
|-------------|------------|-------|
| - |25 Mar 2021| In the `ibm-k8s-controller-config` configmap, sets the `server-tokens` field to `False` so that the NGINX version is not returned in response headers. |
|0.32.0_392_iks|24 Aug 2020|Fixes vulnerabilities for [CVE-2019-15847](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15847){: external}.|
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Build changelog for version 0.32.0 of the Kubernetes Ingress image" caption-side="top"}

<br />

## Fluentd for logging changelog
{: #fluentd_changelog}

View image version changes for the Fluentd component for logging in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

As of 14 November 2019, a Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you do not forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).
{: important}

Refer to the following table for a summary of changes for each build of the Fluentd component.

<table summary="Overview of build changes for the Fluentd component">
<caption>Changelog for the Fluentd component</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>Fluentd build</th>
<th>Release date</th>
<th>Non-disruptive changes</th>
<th>Disruptive changes</th>
</tr>
</thead>
<tr>
<td>c7901bf0d1323806d44ce5f92bce5085f9b6c791</td>
<td>14 Nov 2019</td>
<td>-</td>
<td>The Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you do not forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).</td>
</tr>
<tr>
<td>c7901bf0d1323806d44ce5f92bce5085f9b6c791</td>
<td>06 Nov 2019</td>
<td>Fixes `LibSass` vulnerabilities for [CVE-2018-19218 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19218).</td>
<td>-</td>
</tr>
<tr>
<td>ee01ba3471cadbb9925269183acd724f4bf0e5bd</td>
<td>28 Oct 2019</td>
<td>Fixes Ruby vulnerabilities for [CVE-2019-15845](https://www.ruby-lang.org/en/news/2019/10/01/nul-injection-file-fnmatch-cve-2019-15845/), [CVE-2019-16201](https://www.ruby-lang.org/en/news/2019/10/01/webrick-regexp-digestauth-dos-cve-2019-16201/), [CVE-2019-16254](https://www.ruby-lang.org/en/news/2019/10/01/http-response-splitting-in-webrick-cve-2019-16254/), and [CVE-2019-16255](https://www.ruby-lang.org/en/news/2019/10/01/code-injection-shell-test-cve-2019-16255/).</td>
<td>-</td>
</tr>
<tr>
<td>58c604236080f142f35d14fe3b6c4b4484290121</td>
<td>24 Sep 2019</td>
<td>Fixes OpenSSL vulnerabilities for [CVE-2019-1547 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547), [CVE-2019-1549 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549), and [CVE-2019-1563 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563).</td>
<td>-</td>
</tr>
<tr>
<td>7c94e41a34ff1b7a56b9163471ff740a9585e053</td>
<td>18 Sep 2019</td>
<td>Updates the Kubernetes API version in the Fluentd deployment from `extensions/v1beta1` to `apps/v1`.</td>
<td>-</td>
</tr>
<tr>
<td>e7e944a8279deee0c3a8743e2fa69696ed71b6f5</td>
<td>15 Aug 2019</td>
<td>Fixes GNU binary utilities (`binutils`) vulnerabilities for [CVE-2018-6543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6543), [CVE-2018-6759 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6759), [CVE-2018-6872 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6872), [CVE-2018-7208 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7208), [CVE-2018-7568 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7568), [CVE-2018-7569 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7569), [CVE-2018-7570 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7570), [CVE-2018-7642 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7642), [CVE-2018-7643 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7643), and [CVE-2018-8945 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8945).</td>
<td>-</td>
</tr>
<tr>
<td>d24b1afcc004ec9745dc3f9ef1328d3ed4b495f8</td>
<td>09 Aug 2019</td>
<td>Fixes `musl libc` vulnerabilities for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
<td>-</td>
</tr>
<tr>
<td>96f399cdea1c86c63a4ca4e043180f81f3559676</td>
<td>22 Jul 2019</td>
<td>Updates Alpine packages for [CVE-2019-8905 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905), [CVE-2019-8906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906), and [CVE-2019-8907 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907).</td>
<td>-</td>
</tr>
<tr>
<td>e7c10d74350dc64d4d92ba7f72bb4ff9219315d2</td>
<td>30 May 2019</td>
<td>Updates the Fluent config map to always ignore pod logs from IBM namespaces, even when the Kubernetes master is unavailable.</td>
<td>-</td>
</tr>
<tr>
<td>c16fe1602ab65db4af0a6ac008f99ca2a526e6f6</td>
<td>21 May 2019</td>
<td>Fixes a bug where worker node metrics did not display.</td>
<td>-</td>
</tr>
<tr>
<td>60fc11f7bd39d9c6cfed923c598bf6457b3f2037</td>
<td>10 May 2019</td>
<td>Updates Ruby packages for [CVE-2019-8320 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320), [CVE-2019-8321 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321), [CVE-2019-8322 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322), [CVE-2019-8323 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323), [CVE-2019-8324 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324), and [CVE-2019-8325 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325).</td>
<td>-</td>
</tr>
<tr>
<td>91a737f68f7d9e81b5d2223c910aaa7d7f91b76d</td>
<td>08 May 2019</td>
<td>Updates Ruby packages for [CVE-2019-8320 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320), [CVE-2019-8321 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321), [CVE-2019-8322 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322), [CVE-2019-8323 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323), [CVE-2019-8324 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324), and [CVE-2019-8325 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325).</td>
<td>-</td>
</tr>
<tr>
<td>d9af69e286986a05ed4a50469585b1cf978ddb1d</td>
<td>11 Apr 2019</td>
<td>Updates the cAdvisor plug-in to use TLS 1.2.</td>
<td>-</td>
</tr>
<tr>
<td>3100ddb62580a9f46ffdff7bab2ebec40b164de6</td>
<td>01 Apr 2019</td>
<td>Updates the Fluentd service account.</td>
<td>-</td>
</tr>
<tr>
<td>c85567b75bd7ad1c9428794cd63a8e239c3fd8f5</td>
<td>18 Mar 2019</td>
<td>Removes the dependency on cURL for [CVE-2019-8323 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323).</td>
<td>-</td>
</tr>
<tr>
<td>320ffdf87de068ee2f7f34c0e7a47a111e8d457b</td>
<td>18 Feb 2019</td>
<td><ul>
<li>Updates Fluentd to version 1.3.</li>
<li>Removes Git from the Fluentd image for [CVE-2018-19486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486).</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>972865196aefd3324105087878de12c518ed579f</td>
<td>01 Jan 2019</td>
<td><ul>
<li>Enables UTF-8 encoding for the Fluentd `in_tail` plug-in.</li>
<li>Minor bug fixes.</li>
</ul></td>
<td>-</td>
</tr>
</tbody>
</table>
