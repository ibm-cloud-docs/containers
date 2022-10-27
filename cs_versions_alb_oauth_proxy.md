---

copyright:
  years: 2014, 2022
lastupdated: "2022-10-27"

keywords: kubernetes, oauth proxy, add-on

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# ALB OAuth Proxy add-on change log
{: #alb-oauth-proxy-changelog}

View information for version updates to the [ALB OAuth Proxy add-on](/docs/containers?topic=containers-comm-ingress-annotations#app-id-auth).
{: shortdesc}

* **Patch updates**: {{site.data.keyword.cloud_notm}} keeps all your add-on components up-to-date by automatically rolling out patch updates to the most recent version of the ALB OAuth Proxy that is offered by {{site.data.keyword.containerlong_notm}}.
* **Minor version updates**: To update your add-on components to the most recent minor version of the ALB OAuth Proxy that is offered by {{site.data.keyword.containerlong_notm}}, follow the steps in [Updating managed add-ons](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons).

## Version 2.0.0
{: #2_0_0}

### Version 2.0.0_1297, released on 27 October 2022.
{: #2_0_0_1297}

Resolves [CVE-2022-32149](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-32149){: external}.

### Version 2.0.0_1265, released on 3 October 2022.
{: #2_0_0_1265}

- Updates `oauth2-proxy` from version 7.2.0 to version 7.3.0.
- Adds support for `oidc-extra-audience` configuration option for `oauth2-proxy`.
- Resolves [CVE-2022-27664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-27664).

### Version 2.0.0_1214, released on 12 September 2022.
{: #2_0_0_1214}

Adds the `whitelist-domains` configuration option to `oauth2-proxy`.

### Version 2.0.0_1187, released on 7 July 2022.
{: #2_0_0_1187}

- [CVE-2022-21698](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-21698){: external}
- [CVE-2022-27191](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-27191){: external}

### Version 2.0.0_1064, released on 4 May 2022.
{: #2_0_0_1064}

- [CVE-2022-28327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-28327){: external}
- [CVE-2022-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-27536){: external}

### Version 2.0.0_1023, released on 24 March 2022.
{: #2_0_0_1023}

The add-on logic has changed. It does not add a configuration snippet annotation to the Ingress resources anymore. This change makes the add-on compatible with the default ALB configuration that disables the usage of snippet annotations.

Resolves [CVE-2022-24921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-24921){: external}

### Version 2.0.0_999, released on 28 February 2022.
{: #2_0_0_999}

- [CVE-2022-23772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23772){: external}
- [CVE-2022-23773](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23773){: external}
- [CVE-2022-23806](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23806){: external}

### Version 2.0.0_981, released on 10 February 2022.
{: #2_0_0_981}

This version addresses an issue that causes periodic restarts for the managed OAuth2 Proxy deployments.

### Version 2.0.0_923, released on 26 January 2022.
{: #2_0_0_923}

- [CVE-2021-44716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-44716){: external}
- [CVE-2021-44717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-44717){: external}

### Version 2.0.0_755, released on 19 November 2021.
{: #2_0_0_755}

- [CVE-2021-41771](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-41771){: external}
- [CVE-2021-41772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-41772){: external}

### Version 2.0.0_704, released on 15 September 2021.
{: #2_0_0_704}

Version 2.0.0 of the add-on supports {{site.data.keyword.containerlong_notm}} clusters 1.19 and later. Version 1.0.0 of the add-on supports {{site.data.keyword.containerlong_notm}} clusters 1.21 and earlier. If you want to upgrade your {{site.data.keyword.containerlong_notm}} cluster to 1.22 or later, you must upgrade the add-on from 1.0.0 to 2.0.0 before the cluster upgrade.


## Version 1.0.0
{: #1_0_0-oauth}

As of 16 May 2022, version 1.0.0 of the add-on is no longer supported.
{: important}

### Version 1.0.0_1024, released on 24 March 2022.
{: #1_0_0_1024}

Resolves [CVE-2022-24921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-24921){: external}

### Version 1.0.0_1001, released on 28 February 2022.
{: #1_0_0_1001}

- [CVE-2022-23772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23772){: external}
- [CVE-2022-23773](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23773){: external}
- [CVE-2022-23806](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2022-23806){: external}

### Version 1.0.0_924, released on 26 January 2022.
{: #1_0_0_924}

- [CVE-2021-44716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-44716){: external}
- [CVE-2021-44717](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-44717){: external}

### Version 1.0.0_756, released on 19 November 2021.
{: #1_0_0_756}

- [CVE-2021-41771](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-41771){: external}
- [CVE-2021-41772](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-41772){: external}

### Version 1.0.0_684, released on 23 August 2021.
{: #1_0_0_684}

- [CVE-2021-36221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-36221){: external}

### Version 1.0.0_638, released on 10 August 2021.
{: #1_0_0_638}

- [CVE-2021-34558](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-34558){: external}
- [CVE-2021-21411](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-21411){: external}
- [CVE-2021-21291](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-21291){: external}

### Version 1.0.0_618, released on 17 June 2021.
{: #1_0_0_618}

- [CVE-2021-31525](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-31525){: external}
- [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-33194){: external}

### Version 1.0.0_590, released on 19 April 2021.
{: #1_0_0_590}

- [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-3121){: external}
- [CVE-2021-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28851){: external}
- [CVE-2021-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-28852){: external}

### Version 1.0.0_574, released on 30 March 2021.
{: #1_0_0_574}

- [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}
- [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}
