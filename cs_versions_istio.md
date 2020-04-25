---

copyright:
  years: 2014, 2020
lastupdated: "2020-04-25"

keywords: kubernetes, iks, istio, add-on

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Istio add-on version changelog
{: #istio-changelog}

View information for patch updates to the [managed Istio add-on](/docs/containers?topic=containers-istio-about#istio_ov_addon) in your {{site.data.keyword.containerlong}} Kubernetes clusters.
{:shortdesc}

* **Patch updates**: {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}.
* **`istioctl` and sidecar updates**: Whenever the managed Istio add-on is updated, make sure that you [update your `istioctl` client and the Istio sidecars for your app](/docs/containers?topic=containers-istio#update_client_sidecar) to match the Istio version of the add-on. You can check whether the versions of your `istioctl` client and the Istio add-on control plane match by running `istioctl version`.

The Istio managed add-on is generally available for Kubernetes version 1.16 and later clusters as of 19 November 2019. The beta version of the managed add-on, which runs Istio version 1.3 or earlier, can no longer be installed on 14 February 2020. In Kubernetes version 1.16 or later clusters, you can [update your add-on to the latest version](/docs/containers?topic=containers-istio#istio_update) by uninstalling the Istio version 1.3 or earlier add-on and installing the Istio version 1.4 or later add-on.
{: important}

## Changelog for 1.4.7, released 01 April 2020
{: #147}

The following table shows the changes that are included in version 1.4.7 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.6 | 1.4.7 | <ul><li>See the Istio release notes for [Istio 1.4.7](https://istio.io/news/releases/1.4.x/announcing-1.4.7/){:external}.</li><li>Resolves vulnerabilities for [CVE-2020-1764](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1764){: external}, [CVE-2019-19925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19925){: external}, [CVE-2019-13750](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13750){: external}, [CVE-2019-13752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13752){: external}, [CVE-2019-19959](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19959){: external}, [CVE-2019-19926](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19926){: external}, [CVE-2019-13753](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13753){: external}, [CVE-2019-13751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13751){: external}, [CVE-2019-19923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19923){: external}, [CVE-2019-19924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19924){: external}, [CVE-2019-20218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20218){: external}, [CVE-2020-9327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9327){: external}, [CVE-2019-13734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13734){: external}, and [CVE-2019-19880](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19880){: external}.</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.6" caption-side="top"}

## Changelog for 1.4.6, released 09 March 2020
{: #146}

The following table shows the changes that are included in version 1.4.6 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.5 | 1.4.6 | <ul><li>See the Istio release notes for [Istio 1.4.6](https://istio.io/news/releases/1.4.x/announcing-1.4.6/){:external}.</li><li>Resolves vulnerabilities for [CVE-2020-8659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8659){: external}, [CVE-2020-8660](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8660){: external}, [CVE-2020-8661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8661){: external}, and [CVE-2020-8664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8664){: external}.</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.5" caption-side="top"}

## Changelog for 1.4.5, released 21 February 2020
{: #145}

The following table shows the changes that are included in version 1.4.5 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.4 | 1.4.5 | <ul><li>See the Istio release notes for [Istio 1.4.5](https://istio.io/news/releases/1.4.x/announcing-1.4.5/){:external}.</li><li>Resolves vulnerabilities for [CVE-2019-18634](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18634){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, and [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}. Resolves vulnerabilities for [usn-4263-1](https://usn.ubuntu.com/4263-1/){: external}, [usn-4249-1](https://usn.ubuntu.com/4249-1/){: external}, [usn-4269-1](https://usn.ubuntu.com/4269-1/){: external}, and [usn-4246-1](https://usn.ubuntu.com/4246-1/){: external}. </li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.4" caption-side="top"}

## Changelog for 1.4.4, released 14 February 2020
{: #144}

The following table shows the changes that are included in version 1.4.4 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.3 | 1.4.4 | <ul><li>See the Istio release notes for [Istio 1.4.4](https://istio.io/news/releases/1.4.x/announcing-1.4.4/){:external}.</li><li>Disables [protocol sniffing and detection](https://istio.io/docs/ops/configuration/traffic-management/protocol-selection/).</li><li>Improves the termination sequence for rolling updates of ingress and egress gateways.</li><li>Resolves vulnerabilities for [CVE-2020-8595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8595){: external}, [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}, [CVE-2019-15166](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15166){: external}, [CVE-2019-1010220](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1010220){: external}, [CVE-2019-19906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19906){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}, [CVE-2019-13734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13734){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, [CVE-2019-11729](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11729){: external}, [CVE-2019-11745](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11745){: external}, [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}, [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, [CVE-2018-14882](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14882){: external}, [CVE-2018-19519](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19519){: external}, [CVE-2018-14467](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14467){: external}, [CVE-2018-16451](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16451){: external}, [CVE-2018-14464](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14464){: external}, [CVE-2018-14463](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14463){: external}, [CVE-2018-14468](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14468){: external}, [CVE-2018-14879](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14879){: external}, [CVE-2018-14462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14462){: external}, [CVE-2018-14881](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14881){: external}, [CVE-2018-14470](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14470){: external}, [CVE-2018-14469](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14469){: external}, [CVE-2018-16227](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16227){: external}, [CVE-2018-16452](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16452){: external}, [CVE-2018-14466](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14466){: external}, [CVE-2018-14880](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14880){: external}, [CVE-2018-10105](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10105){: external}, [CVE-2018-16229](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16229){: external}, [CVE-2018-16230](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16230){: external}, [CVE-2018-10103](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10103){: external}, [CVE-2018-14461](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14461){: external}, [CVE-2018-16300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16300){: external}, [CVE-2018-16228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16228){: external}, [CVE-2018-14465](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14465){: external}, and [CVE-2017-16808](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16808){: external}. For more information, see the [Istio security bulletin 2020-001](https://istio.io/news/security/istio-security-2020-001/){:external}.</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.3" caption-side="top"}

## Changelog for 1.4.3, released 16 January 2020
{: #143}

The following table shows the changes that are included in version 1.4.3 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.2 | 1.4.3 | [See the Istio release notes](https://istio.io/news/releases/1.4.x/announcing-1.4.3){: external}. |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.2" caption-side="top"}

## Changelog for 1.4.2, released 16 December 2020
{: #142}

The following table shows the changes that are included in version 1.4.2 of the managed Istio add-on.
{: shortdesc}

| Previous | Current | Description |
| -------- | ------- | ----------- |
| 1.4.0 | 1.4.2 | <ul><li>See the Istio release notes for [Istio 1.4.1](https://istio.io/news/releases/1.4.x/announcing-1.4.1){: external} and [Istio 1.4.2](https://istio.io/news/releases/1.4.x/announcing-1.4.2){: external}.</li><li>Resolves vulnerabilities for [CVE-2019-18801](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18801){: external}, [CVE-2019-18802](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18802){: external}, and [CVE-2019-18838](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18838){: external}. For more information, see the [Istio security bulletin](https://istio.io/news/security/istio-security-2019-007/){: external}.</li></ul> |
{: summary="The rows are read from left to right. The first column is the previous version number of the component. The second column is the current version number of the component. The third column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.4.0" caption-side="top"}
