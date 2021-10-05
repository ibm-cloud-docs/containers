---

copyright:
  years: 2014, 2021
lastupdated: "2021-10-05"

keywords: kubernetes, iks, oauth proxy, add-on

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

  



# ALB OAuth Proxy add-on changelog
{: #alb-oauth-proxy-changelog}

View information for version updates to the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-comm-ingress-annotations#app-id).
{: shortdesc}

* **Patch updates**: {{site.data.keyword.cloud_notm}} keeps all your add-on components up-to-date by automatically rolling out patch updates to the most recent version of the ALB OAuth Proxy that is offered by {{site.data.keyword.containerlong_notm}}.
* **Minor version updates**: To update your add-on components to the most recent minor version of the ALB OAuth Proxy that is offered by {{site.data.keyword.containerlong_notm}}, follow the steps in [Updating managed add-ons](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons).

## Version 1.0.0
{: #1_0_0}

|Version build|Release date|Changes|
|-------------|------------|-------|
| 1.0.0_684 | 23 August 2021 | Updates to address [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-36221){: external}. |
| 1.0.0_638 | 10 August 2021 | OAuth proxy image upgrade from 6.1.1. to 7.1.2. Updates to address [CVE-2021-34558](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-34558){: external}, [CVE-2021-21411](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-21411){: external}, and [CVE-2021-21291](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-21291){: external}. |
| 1.0.0_618 | 17 Jun 2021 | Updates to address [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external} and [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}.|
| 1.0.0_590 | 19 Apr 2021 | Updates to address [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-3121){: external}, [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}, and [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}.|
|1.0.0_574|30 Mar 2021|Updates the Go version to 1.15.10 for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external} and [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}.|
{: summary="The rows are read from left to right. The first column is the build of the image version. The second column is the build release date. The third column contains a brief description of the change made in the version build."}
{: caption="Changelog for version 1.0.0 of the ALB OAuth Proxy add-on" caption-side="top"}









