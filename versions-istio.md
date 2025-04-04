---

copyright:
  years: 2014, 2025
lastupdated: "2025-04-04"


keywords: kubernetes, istio, add-on, change log, add-on version, istio version

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Istio add-on change log
{: #istio-changelog}

View information for patch and minor version updates to the [managed Istio add-on](/docs/containers?topic=containers-istio-about#istio_ov_addon) in your {{site.data.keyword.containerlong}} Kubernetes clusters.
{: shortdesc}

* **Patch updates**: {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. You can check the patch version of your add-on by running `kubectl get iop managed-istio -n ibm-operators -o jsonpath='{.metadata.annotations.version}'`.
* **Minor version updates**: To update your Istio components to the most recent minor version of Istio that is supported by {{site.data.keyword.containerlong_notm}}, such as from version 1.8 to 1.9, follow the steps in [Updating the minor version of the Istio add-on](/docs/containers?topic=containers-istio#istio_minor). When a minor version (`n`) of the Istio add-on is released, 1 minor version behind (`n-1`) is supported for typically 6 weeks after the latest version release date.
* **`istioctl` and sidecar updates**: Whenever the managed Istio add-on is updated, make sure that you [update your `istioctl` client and the Istio sidecars for your app](/docs/containers?topic=containers-istio#update_client_sidecar) to match the Istio version of the add-on. You can check whether the versions of your `istioctl` client and the Istio add-on control plane match by running `istioctl version`.

To view a list of add-ons and the supported cluster versions, run the following command or see the [Supported cluster add-on versions](/docs/containers?topic=containers-supported-cluster-addon-versions).

```sh
ibmcloud ks cluster addon versions
```
{: pre}

## Version 1.23
{: #v123}

### Change log for 1.23.5, released 4 March 2025
{: #1235}

Review the changes that are included in version 1.23.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.23.4

Current version
:   1.23.5

Updates in this version
:   See the Istio release notes for [Istio 1.23.5](https://istio.io/latest/news/releases/1.23.x/announcing-1.23.5/){: external}.
:   Expanded testing and support to IKS 1.31.
:   Resolves the following CVEs:
    - [CVE-2025-0665](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2025-0665){: external}
    - [CVE-2024-11053](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-11053){: external}

### Change log for 1.23.4, released 28 Jan 2025
{: #1234}

Review the changes that are included in version 1.23.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.23.3

Current version
:   1.23.4

Updates in this version
:   See the Istio release notes for [Istio 1.23.4](https://istio.io/latest/news/releases/1.23.x/announcing-1.23.4/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-9681](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-9681){: external}

### Change log for 1.23.3, released 3 Dec 2024
{: #1233}

Review the changes that are included in version 1.23.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.23.2

Current version
:   1.23.3

Updates in this version
:   See the Istio release notes for [Istio 1.23.3](https://istio.io/latest/news/releases/1.23.x/announcing-1.23.3/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-8096](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-8096){: external}

### Change log for 1.23.2, released 9 Oct 2024
{: #1232}

Review the changes that are included in version 1.23.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.23.1

Current version
:   1.23.2

Updates in this version
:   See the Istio release notes for [Istio 1.23.2](https://istio.io/latest/news/releases/1.23.x/announcing-1.23.2/){: external}.

### Change log for 1.23.1, released 20 September 2024
{: #1231}

Review the changes that are included in version 1.23.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.22.4

Current version
:   1.23.1

Updates in this version
:   See the Istio release notes for [Istio 1.23.0](https://istio.io/latest/news/releases/1.23.x/announcing-1.23/){: external} and [Istio 1.23.1](https://istio.io/latest/news/releases/1.23.x/announcing-1.23.1/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-6119](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-6119){: external}
    - [usn-6986-1](https://ubuntu.com/security/notices/USN-6986-1){: external}

## Version 1.22
{: #v122}


### Change log for 1.22.6, released 3 Dec 2024
{: #1226}

Review the changes that are included in version 1.22.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.22.4

Current version
:   1.22.6

Updates in this version
:   See the Istio release notes for [Istio 1.22.5](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.5/){: external} and [Istio 1.22.6](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.6/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-6119](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-6119){: external}
    - [CVE-2024-8096](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-8096){: external}




### Change log for 1.22.4, released 18 August 2024
{: #1224}

Review the changes that are included in version 1.22.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.22.3

Current version
:   1.22.4

Updates in this version
:   See the Istio release notes for [Istio 1.22.4](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.4/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-4603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-4603){: external}
    - [CVE-2024-37371](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-37371){: external}
    - [CVE-2024-2511](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-2511){: external}
    - [CVE-2024-4741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-4741){: external}
    - [CVE-2022-37370](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-37370){: external}
    - [CVE-2024-5535](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-5535){: external}
    - [CVE-2024-7264](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-7264){: external}
    - [usn-6937-1](https://ubuntu.com/security/notices/USN-6937-1){: external}
    - [usn-6947-1](https://ubuntu.com/security/notices/USN-6947-1){: external}
    - [usn-6944-1](https://ubuntu.com/security/notices/USN-6944-1){: external}

### Change log for 1.22.3, released 20 August 2024
{: #1223}

Review the changes that are included in version 1.22.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.22.1

Current version
:   1.22.3

Updates in this version
:   See the Istio release notes for [Istio 1.22.2](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.2/){: external} and [Istio 1.22.3](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.3/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-33599](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33599){: external}
    - [CVE-2024-33600](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33600){: external}
    - [CVE-2024-33601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33601){: external}
    - [CVE-2024-33602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33602){: external}
    - [CVE-2022-40735](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40735){: external}
    - [CVE-2024-28182](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-28182){: external}
    - [usn-6804-1](https://ubuntu.com/security/notices/USN-6804-1){: external}
    - [usn-6854-1](https://ubuntu.com/security/notices/USN-6854-1){: external}
    - [usn-6754-1](https://ubuntu.com/security/notices/USN-6754-1){: external}

:   For more information, see the [Istio security bulletin 2024-005](https://istio.io/latest/news/security/istio-security-2024-005/){: external}.

### Change log for 1.22.1, released 21 June 2024
{: #1221}

Review the changes that are included in version 1.22.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.21.3

Current version
:   1.22.1

Updates in this version
:   See the Istio release notes for [Istio 1.22.0](https://istio.io/latest/news/releases/1.22.x/announcing-1.22/){: external} and [Istio 1.22.1](https://istio.io/latest/news/releases/1.22.x/announcing-1.22.1/){: external}.


## Version 1.21
{: #v121}

### Change log for 1.21.6, released 9 Oct 2024
{: #1216}

Review the changes that are included in version 1.21.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.21.5

Current version
:   1.21.6

Updates in this version
:   This is the final version of addon-istio 1.21 Addon-istio 1.21 is unsupported on 13 November 2024.
:   See the Istio release notes for [Istio 1.21.6](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.6/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-4603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-4603){: external}
    - [CVE-2024-37371](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-37371){: external}
    - [CVE-2024-2511](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-2511){: external}
    - [CVE-2024-4741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-4741){: external}
    - [CVE-2022-37370](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-37370){: external}
    - [CVE-2024-5535](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-5535){: external}
    - [CVE-2024-7264](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-7264){: external}
    - [CVE-2024-6119](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-6119){: external}
    - [CVE-2024-8096](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-8096){: external}
    - [usn-6937-1](https://ubuntu.com/security/notices/USN-6937-1){: external}
    - [usn-6947-1](https://ubuntu.com/security/notices/USN-6947-1){: external}
    - [usn-6944-1](https://ubuntu.com/security/notices/USN-6944-1){: external}
    - [usn-6986-1](https://ubuntu.com/security/notices/USN-6986-1){: external}
    - [usn-7012-1](https://ubuntu.com/security/notices/USN-7012-1){: external}

### Change log for 1.21.5, released 20 August 2024
{: #1215}

Review the changes that are included in version 1.21.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.21.3

Current version
:   1.21.5

Updates in this version
:   See the Istio release notes for [Istio 1.21.4](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.4/){: external} and [Istio 1.21.5](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.5/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-33599](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33599){: external}
    - [CVE-2024-33600](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33600){: external}
    - [CVE-2024-33601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33601){: external}
    - [CVE-2024-33602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33602){: external}
    - [CVE-2022-40735](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-40735){: external}
    - [usn-6804-1](https://ubuntu.com/security/notices/USN-6804-1){: external}
    - [usn-6854-1](https://ubuntu.com/security/notices/USN-6854-1){: external}

:   For more information, see the [Istio security bulletin 2024-005](https://istio.io/latest/news/security/istio-security-2024-005/){: external}.

### Change log for 1.21.3, released 19 June 2024
{: #1213}

Review the changes that are included in version 1.21.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.21.2

Current version
:   1.21.3

Updates in this version
:   See the Istio release notes for [Istio 1.21.3](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.3/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-2961](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-2961){: external}
    - [CVE-2024-28182](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-28182){: external}
    - [usn- 6737-1](https://ubuntu.com/security/notices/USN-6737-1){: external}
    - [usn-6754-1](https://ubuntu.com/security/notices/USN-6754-1){: external}

:   For more information, see the [Istio security bulletin 2024-004](https://istio.io/latest/news/security/istio-security-2024-004/){: external}

### Change log for 1.21.2, released 8 May 2024
{: #1212}

Review the changes that are included in version 1.21.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.21.1

Current version
:   1.21.2

Updates in this version
:   For more information, see the [Istio security bulletin 2024-003](https://istio.io/latest/news/security/istio-security-2024-003){: external}.
:   See the Istio release notes for [Istio 1.21.2](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.2/.){: external}.
:   Resolves the following CVEs:
    - USN-6733-1
    - CVE-2024-28835
    - CVE-2024-28834 

### Change log for 1.21.1, released 26 April 2024
{: #1211}

Review the changes that are included in version 1.21.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.5

Current version
:   1.21.1

Updates in this version
:   See the Istio release notes for [Istio 1.21.0](https://istio.io/latest/news/releases/1.21.x/announcing-1.21/){: external} and [Istio 1.21.1](https://istio.io/latest/news/releases/1.21.x/announcing-1.21.1/){: external}.
:   `Addon-Istio` no longer deletes the `managed-istio` IOP when you disable the add-on. If you choose to disable `addon-istio`, you can choose between uninstalling or no longer managing Istio. See the [Setting up Istio](/docs/containers?topic=containers-istio) documentation for more information.


## Version 1.20
{: #v120}

### Change log for 1.20.8, released 20 August 2024
{: #1208}

Review the changes that are included in version 1.20.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.7

Current version
:   1.20.8

Updates in this version
:   This is the final version of addon-istio 1.20. Addon-istio 1.20 is unsupported on 18 September 2024.
:   See the Istio release notes for [Istio 1.20.8](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.8/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-33599](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33599){: external}
    - [CVE-2024-33600](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33600){: external}
    - [CVE-2024-33601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33601){: external}
    - [CVE-2024-33602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-33602){: external}
    - [usn-6804-1](https://ubuntu.com/security/notices/USN-6804-1){: external}

### Change log for 1.20.7, released 19 June 2024
{: #1207}

Review the changes that are included in version 1.20.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.6

Current version
:   1.20.7

Updates in this version
:   See the Istio release notes for [Istio 1.20.7](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.7/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-2961](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-2961){: external}
    - [CVE-2024-28182](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-28182){: external}
    - [usn- 6737-1](https://ubuntu.com/security/notices/USN-6737-1){: external}
    - [usn-6754-1](https://ubuntu.com/security/notices/USN-6754-1){: external}

:   For more information, see the [Istio security bulletin 2024-004](https://istio.io/latest/news/security/istio-security-2024-004/){: external}   


### Change log for 1.20.6, released 8 May 2024
{: #1206}

Review the changes that are included in version 1.20.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.5

Current version
:   1.20.6

Updates in this version
:   For more information, see the [Istio security bulletin 2024-003](https://istio.io/latest/news/security/istio-security-2024-003){: external}.
:   See the Istio release notes for [Istio 1.20.6](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.6/.){: external}.
:   Resolves the following CVEs:
    - USN-6733-1
    - CVE-2024-28835
    - CVE-2024-28834 

### Change log for 1.20.5, released 24 April 2024
{: #1205}

Review the changes that are included in version 1.20.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.4

Current version
:   1.20.5

Updates in this version
:   For more information, see the [Istio security bulletin 2024-002](https://istio.io/latest/news/security/istio-security-2024-002){: external}.

:   See the Istio release notes for [Istio 1.20.5](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.5/){: external}.

:   Resolves the following CVEs:
    - [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}
    - [CVE-2024-28085](https://nvd.nist.gov/vuln/detail/CVE-2024-28085){: external}
    - [CVE-2022-3715](https://nvd.nist.gov/vuln/detail/CVE-2022-3715){: external}

### Change log for 1.20.4, released 03 April 2024
{: #1204}

Review the changes that are included in version 1.20.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.3

Current version
:   1.20.4

Updates in this version
:   Uninstalling `Addon-Istio` no longer deletes the `istio-system` namespace. This cleanup became unnecessary over time.
:   See the Istio release notes for [Istio 1.20.4](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.4/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}
    - [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}
    - [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}
    - [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external}
    - [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}


### Change log for 1.20.3, released 06 March 2024
{: #1203}

Review the changes that are included in version 1.20.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.2

Current version
:   1.20.3

Updates in this version
:   See the Istio release notes for [Istio 1.20.3](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.3/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-6779](https://nvd.nist.gov/vuln/detail/CVE-2023-6779){: external}
    - [CVE-2023-6246](https://nvd.nist.gov/vuln/detail/CVE-2023-6246){: external}
    - [CVE-2023-6004](https://nvd.nist.gov/vuln/detail/CVE-2023-6004){: external}
    - [CVE-2024-0553](https://nvd.nist.gov/vuln/detail/CVE-2024-0553){: external}
    - [CVE-2023-6918](https://nvd.nist.gov/vuln/detail/CVE-2023-6918){: external}
    - [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}
    - [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}
    - [CVE-2024-0567](https://nvd.nist.gov/vuln/detail/CVE-2024-0567){: external}
    - [CVE-2023-6780](https://nvd.nist.gov/vuln/detail/CVE-2023-6780){: external}

### Change log for 1.20.2, released 07 February 2024
{: #1202}

Review the changes that are included in version 1.20.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.1

Current version
:   1.20.2

Updates in this version
:   For more information, see the [Istio 1.20.2 release notes](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.2/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-39804](https://nvd.nist.gov/vuln/detail/CVE-2023-39804){: external}
    - [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}


### Change log for 1.20.1, released 10 January 2024
{: #1201}

Review the changes that are included in version 1.20.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.20.0

Current version
:   1.20.1

Updates in this version
:   For more information, see the [Istio security bulletin 2023-005](https://istio.io/latest/news/security/istio-security-2023-005/){: external}.
:   See the Istio release notes for [Istio 1.20.1](https://istio.io/latest/news/releases/1.20.x/announcing-1.20.1/.){: external}.
:   Resolves the following CVEs:
    - [USN-6517-1](https://ubuntu.com/security/notices/USN-6517-1){: external}
    - [CVE-2022-48522](https://nvd.nist.gov/vuln/detail/CVE-2022-48522){: external}
    - [CVE-2023-47038](https://nvd.nist.gov/vuln/detail/CVE-2023-47038){: external}
    - [USN-6477-1](https://ubuntu.com/security/notices/USN-6477-1){: external}
    - [CVE-2023-4016](https://nvd.nist.gov/vuln/detail/CVE-2023-4016){: external}
    - [USN-6427-1](https://ubuntu.com/security/notices/USN-6427-1){: external}
    - [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}
    - [USN-6535-1](https://ubuntu.com/security/notices/USN-6535-1){: external}
    - [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}
    - [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external}
    - [USN-6541-1](https://ubuntu.com/security/notices/USN-6541-1){: external}
    - [CVE-2023-4806](https://nvd.nist.gov/vuln/detail/CVE-2023-4806){: external}
    - [CVE-2023-4813](https://nvd.nist.gov/vuln/detail/CVE-2023-4813){: external}
    - [CVE-2023-5156](https://nvd.nist.gov/vuln/detail/CVE-2023-5156){: external}
    - [USN-6499-1](https://ubuntu.com/security/notices/USN-6499-1){: external}
    - [CVE-2023-5981](https://nvd.nist.gov/vuln/detail/CVE-2023-5981){: external}

### Change log for 1.20.0, released 7 December 2023
{: #1200}

Review the changes that are included in version 1.20.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.4

Current version
:   1.20.0

Updates in this version
:   See the Istio release notes for [Istio 1.20.0](https://istio.io/latest/news/releases/1.20.x/announcing-1.20/){: external}.

## Version 1.19
{: #v119}

### Change log for 1.19.9, released 24 April 2024
{: #1199}

Review the changes that are included in version 1.19.9 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.8

Current version
:   1.19.9

Updates in this version
:   This is the final version of addon-istio 1.19. Addon-istio 1.19 is unsupported on 08 May 2024.
:   For more information, see the [Istio security bulletin 2024-002](https://istio.io/latest/news/security/istio-security-2024-002){: external}.
:   See the Istio release notes for [Istio 1.19.9](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.9/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}
    - [CVE-2024-28085](https://nvd.nist.gov/vuln/detail/CVE-2024-28085){: external}
    - [CVE-2022-3715](https://nvd.nist.gov/vuln/detail/CVE-2022-3715){: external}

### Change log for 1.19.8, released 03 April 2024
{: #1198}

Review the changes that are included in version 1.19.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.7

Current version
:   1.19.8

Updates in this version
:   This version is the final version of `Addon-Istio` 1.19. `Addon-Istio` 1.19 is unsupported on 8 May 2024.
:   Uninstalling `Addon-Istio` no longer deletes the `istio-system` namespace. This cleanup became unnecessary over time.
:   See the Istio release notes for [Istio 1.19.8](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.8/){: external}.
:   Resolves the following CVEs:
    - [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}
    - [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}
    - [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}
    - [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external}
    - [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}

### Change log for 1.19.7, released 06 March 2024
{: #1197}

Review the changes that are included in version 1.19.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.6

Current version
:   1.19.7

Updates in this version
:   See the Istio release notes for [Istio 1.19.7](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.7/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-6779](https://nvd.nist.gov/vuln/detail/CVE-2023-6779){: external}
    - [CVE-2023-6246](https://nvd.nist.gov/vuln/detail/CVE-2023-6246){: external}
    - [CVE-2023-6004](https://nvd.nist.gov/vuln/detail/CVE-2023-6004){: external}
    - [CVE-2024-0553](https://nvd.nist.gov/vuln/detail/CVE-2024-0553){: external}
    - [CVE-2023-6918](https://nvd.nist.gov/vuln/detail/CVE-2023-6918){: external}
    - [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}
    - [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}
    - [CVE-2024-0567](https://nvd.nist.gov/vuln/detail/CVE-2024-0567){: external}
    - [CVE-2023-6780](https://nvd.nist.gov/vuln/detail/CVE-2023-6780){: external}


### Change log for 1.19.6, released 07 February 2024
{: #1196}

Review the changes that are included in version 1.19.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.5

Current version
:   1.19.6

Updates in this version
:   See the [Istio 1.19.6 release notes](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.6){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-39804](https://nvd.nist.gov/vuln/detail/CVE-2023-39804){: external}
    - [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}


### Change log for 1.19.5, released 10 January 2024
{: #1195}

Review the changes that are included in version 1.19.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.4

Current version
:   1.19.5

Updates in this version
:   For more information, see the [Istio security bulletin 2023-005](https://istio.io/latest/news/security/istio-security-2023-005/){: external}.
:   See the Istio release notes for [Istio 1.19.5](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.5/.){: external}.
:   Resolves the following CVEs:
    - [USN-6517-1](https://ubuntu.com/security/notices/USN-6517-1){: external}
    - [CVE-2022-48522](https://nvd.nist.gov/vuln/detail/CVE-2022-48522){: external}
    - [CVE-2023-47038](https://nvd.nist.gov/vuln/detail/CVE-2023-47038){: external}
    - [USN-6477-1](https://ubuntu.com/security/notices/USN-6477-1){: external}
    - [CVE-2023-4016](https://nvd.nist.gov/vuln/detail/CVE-2023-4016){: external}
    - [USN-6427-1](https://ubuntu.com/security/notices/USN-6427-1){: external}
    - [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}
    - [USN-6535-1](https://ubuntu.com/security/notices/USN-6535-1){: external}
    - [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}
    - [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external}
    - [USN-6541-1](https://ubuntu.com/security/notices/USN-6541-1){: external}
    - [CVE-2023-4806](https://nvd.nist.gov/vuln/detail/CVE-2023-4806){: external}
    - [CVE-2023-4813](https://nvd.nist.gov/vuln/detail/CVE-2023-4813){: external}
    - [CVE-2023-5156](https://nvd.nist.gov/vuln/detail/CVE-2023-5156){: external}
    - [USN-6499-1](https://ubuntu.com/security/notices/USN-6499-1){: external}
    - [CVE-2023-5981](https://nvd.nist.gov/vuln/detail/CVE-2023-5981){: external}


### Change log for 1.19.4, released 5 December 2023
{: #1194}

Review the changes that are included in version 1.19.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.19.3

Current version
:   1.19.4

Updates in this version
:   See the Istio release notes for [Istio 1.19.64](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.4/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-2975](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2975){: external}
    - [CVE-2023-3446](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3446){: external}
    - [CVE-2023-38545](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-38545){: external}
    - [CVE-2023-38546](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-38546){: external}
    - [CVE-2023-3817](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3817){: external}
    - [CVE-2023-4911](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-4911){: external}
    - [CVE-2023-5363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-5363){: external}
    - [CVE-2023-36054](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-36054){: external}
    - [usn-6429-1](https://ubuntu.com/security/notices/USN-6429-1){: external}  
    - [usn-6450-1](https://ubuntu.com/security/notices/USN-6450-1){: external}

### Change log for 1.19.3, released 10 October 2023
{: #1193}

Review the changes that are included in version 1.19.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.18.3

Current version
:   1.19.3

Updates in this version
:   For more information, see the [Istio security bulletin 2023-004](https://istio.io/latest/news/security/istio-security-2023-004/){: external}
:   See the Istio release notes for [Istio 1.19.3](https://istio.io/latest/news/releases/1.19.x/announcing-1.19.3/.){: external}.
:   Upstream announcement for [Istio 1.19.0](https://istio.io/latest/news/releases/1.19.x/announcing-1.19/.){: external}.   
:   Addon-Istio does not support ambient mesh at this time


## Unsupported: Version 1.18
{: #v118}

### Change log for 1.18.7, released 07 February 2024
{: #1187}

Review the changes that are included in version 1.18.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.18.6

Current version
:   1.18.7

Updates in this version
:   This version is the EOL version for 1.18. Support for Istio 1.18 ends on 21 February 2024.
:   See the Istio release notes for [Istio 1.18.7](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.7){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-39804](https://nvd.nist.gov/vuln/detail/CVE-2023-39804){: external}
    - [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}


### Change log for 1.18.6, released 10 January 2024
{: #1186}

Review the changes that are included in version 1.18.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.18.5

Current version
:   1.18.6

Updates in this version
:   See the Istio release notes for [Istio 1.18.6](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.6/.){: external}.
:   For more information, see the [Istio security bulletin 2023-005](https://istio.io/latest/news/security/istio-security-2023-005/){: external}.
:   Resolves the following CVEs:
    - [USN-6517-1](https://ubuntu.com/security/notices/USN-6517-1){: external}
    - [CVE-2022-48522](https://nvd.nist.gov/vuln/detail/CVE-2022-48522){: external}
    - [CVE-2023-47038](https://nvd.nist.gov/vuln/detail/CVE-2023-47038){: external}
    - [USN-6450-1](https://ubuntu.com/security/notices/USN-6450-1){: external}
    - [CVE-2023-2975](https://nvd.nist.gov/vuln/detail/CVE-2023-2975){: external}
    - [CVE-2023-5363](https://nvd.nist.gov/vuln/detail/CVE-2023-5363){: external}
    - [USN-6435-1](https://ubuntu.com/security/notices/USN-6435-1){: external}
    - [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}
    - [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}
    - [USN-6467-1](https://ubuntu.com/security/notices/USN-6467-1){: external}
    - [CVE-2023-36054](https://nvd.nist.gov/vuln/detail/CVE-2023-36054){: external}
    - [USN-6429-1](https://ubuntu.com/security/notices/USN-6429-1){: external}
    - [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/CVE-2023-38545){: external}
    - [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}
    - [USN-6543-1](https://ubuntu.com/security/notices/USN-6543-1){: external}
    - [CVE-2023-39804](https://nvd.nist.gov/vuln/detail/CVE-2023-39804){: external}
    - [USN-6477-1](https://ubuntu.com/security/notices/USN-6477-1){: external}
    - [CVE-2023-4016](https://nvd.nist.gov/vuln/detail/CVE-2023-4016){: external}
    - [USN-6427-1](https://ubuntu.com/security/notices/USN-6427-1){: external}
    - [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}
    - [USN-6535-1](https://ubuntu.com/security/notices/USN-6535-1){: external}
    - [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}
    - [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external}
    - [USN-6541-1](https://ubuntu.com/security/notices/USN-6541-1){: external}
    - [CVE-2023-4806](https://nvd.nist.gov/vuln/detail/CVE-2023-4806){: external}
    - [CVE-2023-4813](https://nvd.nist.gov/vuln/detail/CVE-2023-4813){: external}
    - [CVE-2023-5156](https://nvd.nist.gov/vuln/detail/CVE-2023-5156){: external}
    - [USN-6499-1](https://ubuntu.com/security/notices/USN-6499-1){: external}
    - [CVE-2023-5981](https://nvd.nist.gov/vuln/detail/CVE-2023-5981){: external}













### Change log for 1.18.5, released 18 October 2023
{: #1185}

Previous version
:   1.18.3

Current version
:   1.18.5

Updates in this version
:   See the Istio release notes for [Istio 1.18.5](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.5/.){: external}.
:   Resolves [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external} and [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325){: external}.
:   For more information, see the [Istio security bulletin 2023-004](https://istio.io/latest/news/security/istio-security-2023-004/){: external}.  


### Change log for 1.18.3, released 3 October 2023
{: #1183}

Review the changes that are included in version 1.18.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.18.2

Current version
:   1.18.3

Updates in this version
:   See the Istio release notes for [Istio 1.18.3](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.3/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28321){: external}
    - [CVE-2023-28322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28322){: external}
    - [CVE-2023-32001](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-32001){: external}
    - [usn-6237-2](https://ubuntu.com/security/notices/USN-5328-1){: external}

### Change log for 1.18.2, released 8 August 2023
{: #1182}

Review the changes that are included in version 1.18.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.18.1

Current version
:   1.18.2

Updates in this version
:   See the Istio release notes for [Istio 1.18.2](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.2/){: external}.
:   For more information, see the [Istio security bulletin 2023-003](https://istio.io/latest/news/security/istio-security-2023-003/){: external}.

### Change log for 1.18.1, released 27 July 2023
{: #1181}

Review the changes that are included in version 1.18.1 of the managed Istio add-on. For more information, see the [Istio security bulletin 2023-002](https://istio.io/latest/news/security/istio-security-2023-002/){: external}.
{: shortdesc}

Previous version
:   1.18.0

Current version
:   1.18.1

Updates in this version
:   See the Istio release notes for [Istio 1.18.1](https://istio.io/latest/news/releases/1.18.x/announcing-1.18.1/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-2602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2602){: external}
    - [CVE-2023-2603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2603){: external}
    - [usn-6166-1](https://ubuntu.com/security/notices/USN-6166-1){: external}


### Change log for 1.18.0, released 12 July 2023
{: #1180}

Review the changes that are included in version 1.18.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.17.3

Current version
:   1.18.0

Updates in this version
:   See the Istio release notes for [Istio 1.18.0](https://istio.io/latest/news/releases/1.18.x/announcing-1.18/){: external}.
:   Adds an `enable-targeted-envoy-access-log` Envoy extension provider to the mesh config. You can use Telemetry CRs to enable Envoy access logs on specific workloads rather than enabling it for the entire mesh. For more information, see [Observing Istio traffic](/docs/containers?topic=containers-istio-health).
:   Protocol sniffing is now enabled for Addon-Istio.
:   Addon-Istio pods now have a `nodeAffinity` for amd64 architecture nodes.
:   Adjusts how `meshConfig` sets `enableAutoMtls`, `enableTracing`, and `protocolDetectionTimeout` to their current values. This results in a no operation change because the values are not changing. The only change is whether they are set implicitly or explicitly.
:   Sets the security context explicitly in the Istio Operator CR. This results in a no operation change because the values are not changing. The only change is whether they are set implicitly or explicitly.
:   Resolves the following CVEs:
    - [CVE-2023-1667](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1667){: external}
    - [CVE-2023-2283](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2283){: external}
    - [usn-6138-1](https://ubuntu.com/security/notices/USN-6138-1){: external}


## Unsupported: Version 1.17
{: #v117}

Version 1.17 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.17.8, released 18 October 2023
{: #1178}

Previous version
:   1.17.6

Current version
:   1.17.8

Updates in this version
:   See the Istio release notes for [Istio 1.17.8](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.8/.){: external}.
:   Resolves [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487) and [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325).
:   For more information, see the [Istio security bulletin 2023-004](https://istio.io/latest/news/security/istio-security-2023-004/){: external}   


### Change log for 1.17.6, released 3 October 2023
{: #1176}

Review the changes that are included in version 1.17.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.17.6

Current version
:   1.17.5

Updates in this version
:   See the Istio release notes for [Istio 1.17.6](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.6/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28321){: external}
    - [CVE-2023-28322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28322){: external}
    - [CVE-2023-32001](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-32001){: external}
    - [usn-6237-2](https://ubuntu.com/security/notices/USN-5328-1){: external}

### Change log for 1.17.5, released 8 August 2023
{: #1175}

Review the changes that are included in version 1.17.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.17.4

Current version
:   1.17.5

Updates in this version
:   See the Istio release notes for [Istio 1.17.5](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.5/){: external}.
:   For more information, see the [Istio security bulletin 2023-003](https://istio.io/latest/news/security/istio-security-2023-003/){: external}.


### Change log for 1.17.4, released 27 July 2023
{: #1174}

Review the changes that are included in version 1.17.4 of the managed Istio add-on. For more information, see the [Istio security bulletin 2023-002](https://istio.io/latest/news/security/istio-security-2023-002/){: external}.
{: shortdesc}

Previous version
:   1.17.3

Current version
:   1.17.4

Updates in this version
:   See the Istio release notes for [Istio 1.17.4](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.4/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-2602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2602){: external}
    - [CVE-2023-2603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2603){: external}
    - [CVE-2023-1667](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1667){: external}
    - [CVE-2023-2283](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2283){: external}
    - [usn-6166-1](https://ubuntu.com/security/notices/USN-6166-1){: external}
    - [usn-6138-1](https://ubuntu.com/security/notices/USN-6138-1){: external}

### Change log for 1.17.3, released 22 June 2023
{: #1173}

Review the changes that are included in version 1.17.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.17.2

Current version
:   1.17.3

Updates in this version
:   See the Istio release notes for [Istio 1.17.3](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.3/){: external}.
:   Resolves the following CVEs:
    - [CVE-2019-17594](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17594){: external}
    - [CVE-2019-17595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17595){: external}
    - [CVE-2021-39537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-39537){: external}
    - [CVE-2022-29458](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29458){: external}
    - [CVE-2023-29491](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-29491){: external}
    - [CVE-2023-1255](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1255){: external}
    - [CVE-2023-2650](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2650){: external}
    - [CVE-2022-3996](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3996){: external}
    - [CVE-2023-0464](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0464){: external}
    - [CVE-2023-0466](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0466){: external}
    - [CVE-2023-28486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28486){: external}
    - [CVE-2023-28487](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28487){: external}
    - [usn-6105-1](https://ubuntu.com/security/notices/USN-6105-1){: external}
    - [usn-6099-1](https://ubuntu.com/security/notices/USN-6099-1){: external}
    - [usn-6119-1](https://ubuntu.com/security/notices/USN-6119-1){: external}
    - [usn-6039-1](https://ubuntu.com/security/notices/USN-6039-1){: external}
    - [usn-6005-1](https://ubuntu.com/security/notices/USN-6005-1){: external}   


### Change log for 1.17.2, released 20 April 2023
{: #1172}

Review the changes that are included in version 1.17.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.17.1

Current version
:   1.17.2

Updates in this version
:   See the Istio release notes for [Istio 1.17.2](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.2/){: external} and the [Istio security bulletin 2023-001](https://istio.io/latest/news/security/istio-security-2023-001/){: external}
:   Resolves the following CVEs:
    - [CVE-2023-27487](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27487){: external}
    - [CVE-2023-27488](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27488){: external}
    - [CVE-2023-27491](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27491){: external}
    - [CVE-2023-27492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27492){: external}
    - [CVE-2023-27493](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27493){: external}
    - [CVE-2023-27496](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27496){: external}
    - [CVE-2023-27533](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27533){: external}
    - [CVE-2023-27534](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27534){: external}
    - [CVE-2023-27535](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27535){: external}
    - [CVE-2023-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27536){: external}
    - [CVE-2023-27538](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27538){: external}
    - [CVE-2023-23914](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23914){: external}
    - [CVE-2023-23915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23915){: external}
    - [CVE-2023-23916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23916){: external}
    - [CVE-2023-0361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0361){: external}
    - [CVE-2022-48303](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-48303){: external}
    - [CVE-2023-27320](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27320){: external}
    - [usn-5964-1](https://ubuntu.com/security/notices/USN-5964-1){: external}
    - [usn-5891-1](https://ubuntu.com/security/notices/USN-5891-1){: external}
    - [usn-5901-1](https://ubuntu.com/security/notices/USN-5901-1){: external}
    - [usn-5900-1](https://ubuntu.com/security/notices/USN-5900-1){: external}
    - [usn-5908-1](https://ubuntu.com/security/notices/USN-5908-1){: external}


### Change log for 1.17.1, released 7 March 2023
{: #1171}

Review the changes that are included in version 1.17.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.2

Current version
:   1.17.1

Updates in this version
:   See the Istio release notes for [Istio 1.17.1](https://istio.io/latest/news/releases/1.17.x/announcing-1.17.1/){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28321){: external}
    - [CVE-2022-4203](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4203){: external}
    - [CVE-2022-4304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4304){: external}
    - [CVE-2022-4450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4450){: external}
    - [CVE-2023-0215](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0215){: external} 
    - [CVE-2023-0216](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0216){: external}
    - [CVE-2023-0217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0217){: external}
    - [CVE-2023-0286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0286){: external}
    - [CVE-2023-0401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0401){: external}
    - [usn-5825-2](https://ubuntu.com/security/notices/USN-5825-2){: external}
    - [usn-5844-1](https://ubuntu.com/security/notices/USN-5844-1){: external}

## Unsupported: Version 1.16
{: #v116}

Version 1.16 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.16.7, released 8 August 2023
{: #1167}

Review the changes that are included in version 1.16.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.6

Current version
:   1.16.7

Updates in this version
:   See the Istio release notes for [Istio 1.16.7](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.7/){: external}.
:   For more information, see the [Istio security bulletin 2023-003](https://istio.io/latest/news/security/istio-security-2023-003/){: external}.


### Change log for 1.16.6, released 27 July 2023
{: #1166}

Review the changes that are included in version 1.16.6 of the managed Istio add-on. For more information, see the [Istio security bulletin 2023-002](https://istio.io/latest/news/security/istio-security-2023-002/){: external}.
{: shortdesc}

Previous version
:   1.16.5

Current version
:   1.16.6

Updates in this version
:   See the Istio release notes for [Istio 1.16.6](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.6/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-2602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2602){: external}
    - [CVE-2023-2603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2603){: external}
    - [CVE-2019-17594](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17594){: external}
    - [CVE-2019-17595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17595){: external}
    - [CVE-2021-39537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-39537){: external}
    - [CVE-2022-29458](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-29458){: external}
    - [CVE-2023-29491](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-29491){: external}
    - [CVE-2023-1667](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1667){: external}
    - [CVE-2023-2283](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2283){: external}
    - [CVE-2023-1255](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1255){: external}
    - [CVE-2023-2650](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-2650){: external}
    - [usn-6105-1](https://ubuntu.com/security/notices/USN-6105-1){: external}
    - [usn-6166-1](https://ubuntu.com/security/notices/USN-6166-1){: external}
    - [usn-6099-1](https://ubuntu.com/security/notices/USN-6099-1){: external}
    - [usn-6138-1](https://ubuntu.com/security/notices/USN-6138-1){: external}
    - [usn-6199-1](https://ubuntu.com/security/notices/USN-6199-1){: external}

### Change log for 1.16.5, released 8 June 2022
{: #1165}

Review the changes that are included in version 1.16.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.4

Current version
:   1.16.5

Updates in this version
:   See the Istio release notes for [Istio 1.16.5](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.5/){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-3996](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3996){: external}
    - [CVE-2023-0464](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0464){: external}
    - [CVE-2023-0466](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0466){: external}
    - [CVE-2023-28486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28486){: external}
    - [CVE-2023-28487](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-28487){: external}
    - [CVE-2023-1255](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-1255){: external}
    - [usn-6005-1](https://ubuntu.com/security/notices/USN-6005-1){: external}
    - [usn-6039-1](https://ubuntu.com/security/notices/USN-6039-1){: external}

### Change log for 1.16.4, released 20 April 2023
{: #1164}

Review the changes that are included in version 1.16.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.3

Current version
:   1.16.4

Updates in this version
:   See the Istio release notes for [Istio 1.16.4](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.4/){: external} and the [Istio security bulletin 2023-001](https://istio.io/latest/news/security/istio-security-2023-001/){: external}.
:   Resolves the following CVEs:
    - [CVE-2023-27487](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27487){: external}
    - [CVE-2023-27488](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27488){: external}
    - [CVE-2023-27491](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27491){: external}
    - [CVE-2023-27492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27492){: external}
    - [CVE-2023-27493](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27493){: external}
    - [CVE-2023-27496](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27496){: external}
    - [CVE-2023-27533](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27533){: external}
    - [CVE-2023-27534](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27534){: external}
    - [CVE-2023-27535](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27535){: external}
    - [CVE-2023-27536](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27536){: external}
    - [CVE-2023-27538](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27538){: external}
    - [CVE-2023-23914](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23914){: external}
    - [CVE-2023-23915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23915){: external}
    - [CVE-2023-23916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-23916){: external}
    - [CVE-2023-0361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0361){: external}
    - [CVE-2022-48303](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-48303){: external}
    - [CVE-2023-27320](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-27320){: external}
    - [usn-5964-1](https://ubuntu.com/security/notices/USN-5964-1){: external}
    - [usn-5891-1](https://ubuntu.com/security/notices/USN-5891-1){: external}
    - [usn-5901-1](https://ubuntu.com/security/notices/USN-5901-1){: external}
    - [usn-5900-1](https://ubuntu.com/security/notices/USN-5900-1){: external}
    - [usn-5908-1](https://ubuntu.com/security/notices/USN-5908-1){: external}


### Change log for 1.16.3, released 9 March 2023
{: #1163}

Review the changes that are included in version 1.16.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.2

Current version
:   1.16.3

Updates in this version
:   See the Istio release notes for [Istio 1.16.3](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.3/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28321){: external}
    - [CVE-2022-4203](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4203){: external}
    - [CVE-2022-4304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4304){: external}
    - [CVE-2022-4450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4450){: external}
    - [CVE-2023-0215](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0215){: external} 
    - [CVE-2023-0216](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0216){: external}
    - [CVE-2023-0217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0217){: external}
    - [CVE-2023-0286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0286){: external}
    - [CVE-2023-0401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0401){: external}
    - [usn-5825-2](https://ubuntu.com/security/notices/USN-5825-2){: external}
    - [usn-5844-1](https://ubuntu.com/security/notices/USN-5844-1){: external}

### Change log for 1.16.2, released 14 February 2023
{: #1162}

Review the changes that are included in version 1.16.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.16.1

Current version
:   1.16.2

Updates in this version
:   See the Istio release notes for [Istio 1.16.2](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.2/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-43551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43551){: external}
    - [CVE-2022-43552](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43552){: external}
    - [CVE-2018-20217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20217){: external}
    - [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}
    - [CVE-2022-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28321){: external}
    - [CVE-2022-33070](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-33070){: external}
    - [CVE-2023-22809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43551){: external}
    - [usn-5788-1](https://ubuntu.com/security/notices/USN-5788-1){: external}
    - [usn-5828-1](https://ubuntu.com/security/notices/USN-5828-1){: external}
    - [usn-5825-1](https://ubuntu.com/security/notices/USN-5825-1){: external}
    - [usn-5811-1](https://ubuntu.com/security/notices/USN-5811-1){: external}

### Change log for 1.16.1, released 10 January 2023
{: #1161}


Previous version
:   1.16.0

Current version
:   1.16.1

Updates in this version
:   See the Istio release notes for [Istio 1.16.1](https://istio.io/latest/news/releases/1.16.x/announcing-1.16.1/){: external}.
:   Fixes a `podAntiAffinity` label bug where the value was incorrect. 
:   Adds support for [Gateway API resource](https://istio.io/latest/news/releases/1.16.x/announcing-1.16/upgrade-notes/#gateway-api-resources).
:   Resolves the following CVEs:
    - [CVE-2013-4235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4235){: external}
    - [usn-5761-1](https://ubuntu.com/security/notices/USN-5761-1){: external}
    - [usn-5745-1](https://ubuntu.com/security/notices/USN-5745-1){: external}
    


### Change log for 1.16.0, released November 30th, 2022
{: #1160}

Review the changes that are included in version 1.16.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.3

Current version
:   1.16.0

Updates in this version
:   See the Istio release notes for [Istio 1.16.0](https://istio.io/latest/news/releases/1.16.x/announcing-1.16/){: external}.
:   The [Gateway API resource](https://istio.io/latest/news/releases/1.16.x/announcing-1.16/upgrade-notes/#gateway-api-resources) is now supported. 
:   Resolves the following CVEs:
    - [usn-5702-1](https://ubuntu.com/security/notices/USN-5702-1){: external}
    - [CVE-2022-32221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32221){: external}
    - [CVE-2022-35260](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35260){: external}
    - [CVE-2022-42915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42915){: external}
    - [CVE-2022-42916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42916){: external}
    - [usn-5704-1](https://ubuntu.com/security/notices/USN-5704-1){: external}
    - [CVE-2022-42010](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42010){: external}
    - [CVE-2022-42011](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42011){: external}
    - [CVE-2022-42012](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42012){: external}
    - [usn-5710-1](https://ubuntu.com/security/notices/USN-5710-1){: external}
    - [CVE-2022-3358](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3508){: external}
    - [CVE-2022-3602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3602){: external}
    - [CVE-2022-3786](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3786){: external}
    
    



## Unsupported: Version 1.15
{: #v115}


Version 1.15 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.15.6, released 9 March 2023
{: #1156}

Review the changes that are included in version 1.15.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.5

Current version
:   1.15.6

Updates in this version
:   See the Istio release notes for [Istio 1.15.6](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.6/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28321){: external}
    - [CVE-2022-4203](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4203){: external}
    - [CVE-2022-4304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4304){: external}
    - [CVE-2022-4450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-4450){: external}
    - [CVE-2023-0215](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0215){: external} 
    - [CVE-2023-0216](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0216){: external}
    - [CVE-2023-0217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0217){: external}
    - [CVE-2023-0286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0286){: external}
    - [CVE-2023-0401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-0401){: external}
    - [usn-5825-2](https://ubuntu.com/security/notices/USN-5825-2){: external}
    - [usn-5844-1](https://ubuntu.com/security/notices/USN-5844-1){: external}

### Change log for 1.15.5, released 14 February 2023
{: #1155}

Review the changes that are included in version 1.15.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.4

Current version
:   1.15.5

Updates in this version
:   See the Istio release notes for [Istio 1.15.5](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.5/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-43551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43551){: external}
    - [CVE-2022-43552](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43552){: external}
    - [CVE-2018-20217](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20217){: external}
    - [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}
    - [CVE-2022-28321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-28321){: external}
    - [CVE-2022-33070](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-33070){: external}
    - [CVE-2023-22809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-43551){: external}
    - [usn-5788-1](https://ubuntu.com/security/notices/USN-5788-1){: external}
    - [usn-5828-1](https://ubuntu.com/security/notices/USN-5828-1){: external}
    - [usn-5825-1](https://ubuntu.com/security/notices/USN-5825-1){: external}
    - [usn-5811-1](https://ubuntu.com/security/notices/USN-5811-1){: external}


### Change log for 1.15.4, released 10 January 2023
{: #1154}

Previous version
:   1.15.3

Current version
:   1.15.4

Updates in this version
:   See the Istio release notes for [Istio 1.15.4](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.4/){: external}.
:   Fixes a `podAntiAffinity` label bug where the value was incorrect.
:   Resolves the following CVEs:
    - [CVE-2022-32221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32221){: external}
    - [CVE-2022-35260](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35260){: external}
    - [CVE-2022-42915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42915){: external} 
    - [CVE-2022-42916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42916){: external}
    - [CVE-2022-42010](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42010){: external}  
    - [CVE-2022-42011](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42011){: external}
    - [CVE-2022-42012](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42012){: external}
    - [CVE-2022-3358](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3358){: external}
    - [CVE-2022-3602](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3602){: external}
    - [CVE-2022-3786](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3786){: external}
    - [CVE-2013-4235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4235){: external}
    - [usn-5761-1](https://ubuntu.com/security/notices/USN-5761-1){: external}
    - [usn-5702-1](https://ubuntu.com/security/notices/USN-5702-1){: external}
    - [usn-5704-1](https://ubuntu.com/security/notices/USN-5704-1){: external}
    - [usn-5710-1](https://ubuntu.com/security/notices/USN-5710-1){: external}
    - [usn-5745-1](https://ubuntu.com/security/notices/USN-5745-1){: external}
    
    
 


### Change log for 1.15.3, released 10 November 2022
{: #1153}

Review the changes that are included in version 1.15.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.2

Current version
:   1.15.3

Updates in this version
:   See the Istio release notes for [Istio 1.15.3](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.3/){: external}.

### Change log for 1.15.2, released 25 October 2022
{: #1152}

Review the changes that are included in version 1.15.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.1

Current version
:   1.15.2

Updates in this version
:   See the Istio release notes for [Istio 1.15.2](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.2/){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}
    - [CVE-2022-1586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1586){: external}
    - [CVE-2022-1587](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1587){: external}
    - [usn-5587-1](https://ubuntu.com/security/notices/USN-5587-1){: external}
    - [usn-5627-1](https://ubuntu.com/security/notices/USN-5627-1){: external}

### Change log for 1.15.1, released 11 October 2022
{: #1151}

Review the changes that are included in version 1.15.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.15.0

Current version
:   1.15.1

Updates in this version
:   See the Istio release notes for [Istio 1.15.1](https://istio.io/latest/news/releases/1.15.x/announcing-1.15.1/.){: external}.
:   Fixes the Istio operator memory leak issue.
:   Resolves the following CVEs:
    - [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}
    - [usn-5587-1](https://ubuntu.com/security/notices/USN-5587-1){: external}



### Change log for 1.15.0, released 15 September 2022
{: #1150}

Review the changes that are included in version 1.15.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.14.3

Current version
:   1.15.0

Updates in this version
:   See the Istio release notes for [Istio 1.15.0](https://istio.io/latest/news/releases/1.15.x/announcing-1.15/){: external}.
:   Adds a 1 G memory limit and a 100 M memory request to the `add-on-istio-operator` deployment. This addition resolves an error in which a reconcile loop increased memory usage over time. Because of this change, your Istio operator pod might restart frequently. However, the frequent operator pod restarts do not affect Istio on the cluster and your Kubernetes deployment still matches what was specified in the IOPs. 
:   Resolves the following CVEs:
    - [usn-5550-1](https://ubuntu.com/security/notices/USN-5550-1){: external}
    - [CVE-2021-4209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-4209){: external}
    - [CVE-2022-2509](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2509){: external}



## Unsupported: Version 1.14
{: #v114}

Version 1.14 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.14.6, released 10 January 2023
{: #1146}

Review the changes that are included in version 1.14.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.14.5

Current version
:   1.14.6

Updates in this version
:   See the Istio release notes for [Istio 1.14.6](https://istio.io/latest/news/releases/1.14.x/announcing-1.14.6/){: external}.
:   Fixes a `podAntiAffinity` label bug where the value was incorrect.
:   Resolves the following CVEs:
    - [CVE-2022-32221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32221){: external}
    - [CVE-2022-35260](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35260){: external}
    - [CVE-2022-42915](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42915){: external} 
    - [CVE-2022-42916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42916){: external}
    - [CVE-2021-43618](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-43618){: external}  
    - [CVE-2018-16860](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16860){: external}
    - [CVE-2019-12098](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12098){: external}
    - [CVE-2021-3671](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3671){: external}
    - [CVE-2022-3116](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3116){: external}
    - [CVE-2022-35737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35737){: external}
    - [CVE-2022-41916](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-41916){: external}
    - [CVE-2013-4235](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4235){: external}
    - [CVE-2022-37434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-37434){: external}
    - [usn-5761-1](https://ubuntu.com/security/notices/USN-5761-1){: external}
    - [usn-5745-2](https://ubuntu.com/security/notices/USN-5745-2){: external}
    - [usn-5766-1](https://ubuntu.com/security/notices/USN-5766-1){: external}
    - [usn-5745-1](https://ubuntu.com/security/notices/USN-5745-1){: external}
    - [usn-5716-1](https://ubuntu.com/security/notices/USN-5716-1){: external}
    - [usn-5702-1](https://ubuntu.com/security/notices/USN-5702-1){: external}
    - [usn-5675-1](https://ubuntu.com/security/notices/USN-5675-1){: external}
    - [usn-5672-1](https://ubuntu.com/security/notices/USN-5672-1){: external}
    - [usn-5570-2](https://ubuntu.com/security/notices/USN-5570-2){: external}


 

### Change log for 1.14.5, released 25 October 2022
{: #1145}

Review the changes that are included in version 1.14.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.14.4

Current version
:   1.14.5

Updates in this version
:   See the Istio release notes for [Istio 1.14.5](https://istio.io/latest/news/releases/1.14.x/announcing-1.14.5/){: external}.
:   The istio operator memory leak is fixed in 1.14.5.
:   Resolves the following CVEs:
    - [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}
    - [CVE-2022-1586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1586){: external}
    - [CVE-2022-1587](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1587){: external}
    - [usn-5587-1](https://ubuntu.com/security/notices/USN-5587-1){: external}
    - [usn-5627-1](https://ubuntu.com/security/notices/USN-5627-1){: external}



### Change log for 1.14.4, released 4 October 2022
{: #1144}

Review the changes that are included in version 1.14.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.14.3

Current version
:   1.14.4

Updates in this version
:   See the Istio release notes for [Istio 1.14.4](https://istio.io/latest/news/releases/1.14.x/announcing-1.14.4/){: external}.
:   Adds a 1G memory limit and a 100M memory request to the `add-on-istio-operator` deployment. This addition resolves an error in which a reconcile loop increased memory usage over time. Because of this change, your Istio operator pod might restart frequently. However, the frequent operator pod restarts do not affect Istio on the cluster and your Kubernetes deployment still matches what was specified in the IOPs.
:   Resolves the following CVEs:
    - [usn-5550-1](https://ubuntu.com/security/notices/USN-5550-1){: external}
    - [CVE-2021-4209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-4209){: external}
    - [CVE-2022-2509](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2509){: external}



### Change log for 1.14.3, released 16 August 2022
{: #1143}

Review the changes that are included in version 1.14.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.14.1

Current version
:   1.14.3

Updates in this version
:   See the Istio release notes for [Istio 1.14.3](https://istio.io/latest/news/releases/1.14.x/announcing-1.14.3/){: external}.
:   Resolves the following CVEs:
    - [usn-5464-1](https://ubuntu.com/security/notices/USN-5464-1){: external}
    - [usn-5473-1](https://ubuntu.com/security/notices/USN-5473-1){: external}
    - [usn-5488-1](https://ubuntu.com/security/notices/USN-5488-1){: external}
    - [usn-5495-1](https://ubuntu.com/security/notices/USN-5495-1){: external}
    - [usn-5502-1](https://ubuntu.com/security/notices/USN-5502-1){: external}
    - [CVE-2022-32205](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32205){: external}
    - [CVE-2022-32206](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32206){: external}
    - [CVE-2022-32207](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32207){: external}
    - [CVE-2022-32208](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32208){: externa}
    - [CVE-2022-1304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1304){: external}
    - [CVE-2022-2097](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2097){: externa}
    - [CVE-2022-2068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2068){: external}

### Change log for 1.14.1, released 16 June 2022
{: #1141}

Review the changes that are included in version 1.14.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.4

Current version
:   1.14.1

Updates in this version
:   See the Istio release notes for [Istio 1.14.1](https://istio.io/latest/news/releases/1.14.x/announcing-1.14.1/.){: external}.

## Unsupported: Version 1.13
{: #v113}

Version 1.13 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.13.9, released 25 October 2022
{: #1139}

Review the changes that are included in version 1.13.9 of the managed Istio add-on.
{: shortdesc}

This is the final update for version 1.13, which becomes unsupported on 17 Nov 2022. You can update the minor version of the add-on from 1.12 to 1.13 for as long as 1.13 is supported. You can update the minor version of the add-on from 1.13 to 1.14 for as long as 1.14 is supported. For more information, see [Upgrading the Istio add-on](/docs/containers?topic=containers-istio#istio_update).
{: important}

Previous version
:   1.13.8

Current version
:   1.13.9

Updates in this version
:   See the Istio release notes for [Istio 1.13.9](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.9/){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-1586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1586){: external}
    - [CVE-2022-1587](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1587){: external}
    - [usn-5627-1](https://ubuntu.com/security/notices/USN-5627-1){: external}

### Change log for 1.13.8, released 4 October 2022
{: #1138}

Review the changes that are included in version 1.13.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.7

Current version
:   1.13.8

Updates in this version
:   See the Istio release notes for [Istio 1.13.8](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.8/){: external}.
:   Resolves the following CVEs:
    - [usn-5587-1](https://ubuntu.com/security/notices/USN-5587-1){: external}
    - [usn-5550-1](https://ubuntu.com/security/notices/USN-5550-1){: external}
    - [CVE-2021-4209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-4209){: external}
    - [CVE-2022-2509](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2509){: external}
    - [CVE-2022-35252](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-35252){: external}

### Change log for 1.13.7, released 16 August 2022
{: #1137}

Review the changes that are included in version 1.13.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.5

Current version
:   1.13.7

Updates in this version
:   See the Istio release notes for [Istio 1.13.7](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.7/.){: external}.
:   Resolves the following CVEs:
    - [usn-5473-1](https://ubuntu.com/security/notices/USN-5473-1){: external}
    - [CVE-2022-32205](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32205){: external}
    - [CVE-2022-32206](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32206){: external}
    - [CVE-2022-32207](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32207){: external}
    - [CVE-2022-32208](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32208){: externa}
    - [CVE-2022-1304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1304){: external}
    - [CVE-2022-2097](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2097){: externa}
    - [CVE-2022-2068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2068){: external}

### Change log for 1.13.5, released 21 June 2022
{: #1135}

Review the changes that are included in version 1.13.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.4

Current version
:   1.13.5

Updates in this version
:   See the Istio release notes for [Istio 1.13.5](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.5/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-31045](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-31045){: external}
    - [CVE-2022-1664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1664){: external}
    - [CVE-2019-20838](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20838){: external}
    - [CVE-2020-14155](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155){: external}
    - [usn-5446-1](https://ubuntu.com/security/notices/USN-5446-1){: external}
    - [usn-5425-1](https://ubuntu.com/security/notices/USN-5425-1){: external}

:   For more information, see the [Istio security bulletin 2022-005/](https://istio.io/latest/news/security/istio-security-2022-005/){: external}

### Change log for 1.13.4, released 1 June 2022
{: #1134}

Review the changes that are included in version 1.13.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.3

Current version
:   1.13.4

Updates in this version
:   See the Istio release notes for [Istio 1.13.4](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.4/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27780){: external}
    - [CVE-2022-27781](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27781){: external}
    - [CVE-2022-27782](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27782){: external}
    - [CVE-2022-22576](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22576){: external}
    - [CVE-2022-27774](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27774){: external}
    - [CVE-2022-27775](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27775){: external}
    - [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27776){: external}
    - [CVE-2022-1292](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1292){: external}   
    - [CVE-2022-1343](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1343){: external}
    - [CVE-2022-1434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1434){: external}
    - [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1473){: external}
    - [CVE-2021-36084](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36084){: external}
    - [CVE-2021-36085](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36085){: external}
    - [CVE-2021-36086](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36086 ){: external}
    - [CVE-2021-36087](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36087){: external}
    - [CVE-2019-18276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18276){: external}

### Change log for 1.13.3, released 3 May 2021
{: #1133}

Review the changes that are included in version 1.13.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.2

Current version
:   1.13.3 

Updates in this version
:   See the Istio release notes for [Istio 1.13.3](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.3/.){: external}.

:   Resolves the following CVEs: 
    - [CVE-2022-1271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1271){: external}
    - [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}
    - [CVE-2021-20193](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20193){: external}
    - [CVE-2018-16301](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16301){: external} 
    - [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external}
    - [CVE-2018-25032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-25032){: external}
    - [usn-5378-1](https://ubuntu.com/security/notices/USN-5378-1){: external}
    - [usn-5328-1](https://ubuntu.com/security/notices/USN-5328-1){: external}
    - [usn-5329-1](https://ubuntu.com/security/notices/USN-5329-1){: external}
    - [usn-5331-2](https://ubuntu.com/security/notices/USN-5331-2){: external}
    - [usn-5355-1](https://ubuntu.com/security/notices/USN-5355-1){: external}

### Change log for 1.13.2, released 22 March 2022
{: #1132}

Review the changes that are included in version 1.13.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.13.1

Current version
:   1.13.2

Updates in this version
:   See the Istio release notes for [Istio 1.13.2](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.2/.){: external}.

:   Resolves the following CVEs
    - [CVE-2016-10228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10228){: external}
    - [CVE-2019-25013](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-25013){: external}
    - [CVE-2020-27618](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27618){: external}
    - [CVE-2020-29562](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29562){: external}
    - [CVE-2020-6096](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6096 ){: external}
    - [CVE-2021-27645](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27645){: external}
    - [CVE-2021-3326](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3326){: external}
    - [CVE-2021-35942](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-35942){: external}
    - [CVE-2021-3998](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3998){: external}
    - [CVE-2021-3999](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3999 ){: external}
    - [CVE-2022-23218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23218){: external}
    - [CVE-2022-23219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23219){: external}

:   For more information, see the [Istio security bulletin 2022-004](https://istio.io/latest/news/security/istio-security-2022-004/){: external}.

### Change log for 1.13.1, released March 9th, 2021
{: #1131}

Review the changes that are included in version 1.13.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.4

Current version
:   1.13.1

Updates in this version
:   See the Istio release notes for [Istio 1.13.1](https://istio.io/latest/news/releases/1.13.x/announcing-1.13.1/.){: external}.

## Version 1.12 (unsupported)
{: #v112}

Version 1.12 of the managed Istio add-on is unsupported. 
{: important}

If you want to upgrade from Istio minor version 1.11 to version 1.12 and your Istio components were provisioned at version 1.10 or earlier, you **must** take steps to [set up your mutating and validating webhooks](/docs/containers?topic=containers-istio#istio_minor) before you upgrade. If you do not make these changes before upgrading to 1.12, the upgrade will stall.
{: important}

### Change log for 1.12.9, released 26 July 2022
{: #1129}

Review the changes that are included in version 1.12.9 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.8

Current version
:   1.12.9

Updates in this version
:   See the Istio release notes for [Istio 1.12.9](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.9/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-32205](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32205){: external}
    - [CVE-2022-32206](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32206){: external}
    - [CVE-2022-32207](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32207){: external}
    - [CVE-2022-32208](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-32208){: external}
    - [CVE-2022-1304](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1304){: external}
    - [CVE-2022-2097](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2097){: external}
    - [CVE-2022-2068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-2068){: external}
    - [usn-5473-1](https://ubuntu.com/security/notices/USN-5473-1){: external}
    - [usn-5495-1](https://ubuntu.com/security/notices/USN-5495-1){: external}
    - [usn-5464-1](https://ubuntu.com/security/notices/USN-5464-1){: external}
    - [usn-5502-1](https://ubuntu.com/security/notices/USN-5502-1){: external}
    - [usn-5488-1](https://ubuntu.com/security/notices/USN-5488-1){: external}

### Change log for 1.12.8, released 21 June 2022
{: #1128}

Review the changes that are included in version 1.12.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.7

Current version
:   1.12.8

Updates in this version
:   See the Istio release notes for [Istio 1.12.8](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.8/.){: external}.
:   Resolves the following CVEs:
    - [CVE-2022-31045](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-31045){: external}
    - [CVE-2022-1664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1664){: external}
    - [CVE-2019-20838](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20838){: external}
    - [CVE-2020-14155](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155){: external}
    - [CVE-2022-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27780){: external}
    - [CVE-2022-27781](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27781){: external}
    - [CVE-2022-27782](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27782){: external}
    - [CVE-2022-1292](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1292){: external}
    - [CVE-2022-1343](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1343){: external}
    - [CVE-2022-1434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1434){: external}
    - [CVE-2022-1473](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1473){: external}
    - [usn-5446-1](https://ubuntu.com/security/notices/USN-5446-1){: external}
    - [usn-5425-1](https://ubuntu.com/security/notices/USN-5425-1){: external}
    - [usn-5412-1](https://ubuntu.com/security/notices/USN-5412-1){: external}
    - [usn-5402-1](https://ubuntu.com/security/notices/USN-5402-1){: external}

:   For more information, see the [Istio security bulletin 2022-005/](https://istio.io/latest/news/security/istio-security-2022-005/){: external}

### Change log for 1.12.7, released 19 May 2022
{: #1127}

Review the changes that are included in version 1.12.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.6

Current version
:   1.12.7 

Updates in this version
:   See the Istio release notes for [Istio 1.12.7](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.7/.){: external}.

:   Resolves the following CVEs: 
    - [CVE-2019-18276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18276){: external}
    - [CVE-2022-22576](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-22576){: external}
    - [CVE-2022-27774](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27774){: external}
    - [CVE-2022-27775](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27775){: external}
    - [CVE-2022-27776](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-27776){: external}
    - [CVE-CVE-2022-1271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-1271){: external}
    - [CVE-2021-36084](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36084){: external}
    - [CVE-2021-36085](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36085){: external}
    - [CVE-2021-36086](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36086){: external}
    - [CVE-2021-36087](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36087){: external}
    - [CVE-2018-16301](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16301 ){: external}
    - [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external}
    - [CVE-2018-25032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-25032){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}
