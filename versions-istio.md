---

copyright:
  years: 2014, 2023
lastupdated: "2023-12-05"

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

ibmcloud ks cluster addon versions
{: pre}

## Version 1.19
{: #v119}

### Changelog for 1.19.4, released 5 December 2023
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


## Version 1.18
{: #v118}

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


## Version 1.17
{: #v117}

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

### Change log for 1.12.6, released 19 April 2022
{: #1126}

Review the changes that are included in version 1.12.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.5

Current version
:   1.12.6

Updates in this version
:   See the Istio release notes for [Istio 1.12.6](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.6/.){: external}.

:   Resolves the following CVEs
    - [CVE-2022-0778](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0778){: external}
    - [CVE-2021-20193](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20193){: external}
    - [usn-5328-1](https://ubuntu.com/security/notices/USN-5328-1){: external}
    - [usn-5329-1](https://ubuntu.com/security/notices/USN-5329-1){: external}

### Change log for 1.12.5, released 22 March 2022
{: #1125}

Review the changes that are included in version 1.12.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.4

Current version
:   1.12.5

Updates in this version
:   See the Istio release notes for [Istio 1.12.5](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.5/.){: external}.

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

### Change log for 1.12.4, released 8 March 2022
{: #1124}

Review the changes that are included in version 1.12.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.3

Current version
:   1.12.4

Updates in this version
:   See the Istio release notes for [Istio 1.12.4](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.4/.){: external}.

:   Resolves the following CVEs
    - [CVE-2021-3995](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3995){: external}
    - [CVE-2021-3996](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3996){: external}

:   For more information, see the [Istio security bulletin 2022-003](https://istio.io/latest/news/security/istio-security-2022-003/){: external}.

### Change log for 1.12.3, released 22 February 2021
{: #1123}

Review the changes that are included in version 1.12.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.2

Current version
:   1.12.3

Updates in this version
:   See the Istio release notes for [Istio 1.12.3](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.3/.){: external}.

### Change log for 1.12.2, released 03 February 2022
{: #1122}

Review the changes that are included in version 1.12.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.1

Current version
:   1.12.2

Updates in this version   
:   See the Istio release notes for [Istio 1.12.2](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.2/){: external}. 

:   For more information, see the [Istio security bulletin 2022-001](https://istio.io/latest/news/security/istio-security-2022-001/){: external} and [Istio security bulletin 2022-002](https://istio.io/latest/news/security/istio-security-2022-002/){: external}.

### Change log for 1.12.1, released 13 January 2022
{: #1121}

Review the changes that are included in version 1.12.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.12.0

Current version
:   1.12.1

Updates in this version
:   See the Istio release notes for [Istio 1.12.1](https://istio.io/latest/news/releases/1.12.x/announcing-1.12.1/){: external}. 

### Change log for 1.12.0, released 08 December 2021
{: #1120}

Previous version
:   1.11.4

Current version
:   1.12.0

Updates in this version
:   See the Istio release notes for [Istio 1.12.0](https://istio.io/latest/news/releases/1.12.x/announcing-1.12/){: external}. 

:   Updates the `managed-istio` operator settings. This includes a `TERMINATION_DRAIN_DURATION` of 30 seconds which replaces an earlier `preStop` variable of 25 seconds. If you are already using a `TERMINATION_DRAIN_DURATION` you must increase the value by 30 seconds to account for this change. 

:   Updates the affinity rules in the `k8s.overlay` to `k8s.affinity`. If you are using custom gateways, review the updated configuration for the default gateways to see if you want to use the change in your custom gateways. 

:   Users can now increase the max horizontal pod autoscaler (HPA) pods for istiod. Do not change this value to less than the default of `5`. You can increase this value, but only in situations where you have a large service mesh.

:   Resolves the following CVEs
    - [usn-5089-1](https://ubuntu.com/security/notices/USN-5089-1){: external}


## Version 1.11 (unsupported)
{: #v111}

Review the changes that are in version 1.11 of the managed Istio add-on.
{: shortdesc}

Version 1.11 of the managed Istio add-on is unsupported. 
{: important}

### Change log for 1.11.8, released 22 March 2022
{: #1118}

Review the changes that are included in version 1.11.8 of the managed Istio add-on.
{: shortdesc}

This is the final update for version 1.11, which becomes unsupported on 21 April 2022. You can update the minor version of the add-on from 1.10 to 1.11 for as long as 1.11 is supported. You can update the minor version of the add-on from 1.11 to 1.12 for as long as 1.12 is supported. For more information, see [Upgrading the Istio add-on](/docs/containers?topic=containers-istio#istio_update).
{: important}

Previous version
:   1.11.7

Current version
:   1.11.8

Updates in this version
:   See the Istio release notes for [Istio 1.11.8](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.8/.){: external}.

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


### Change log for 1.11.7, released 8 March 2022
{: #1117}

Review the changes that are included in version 1.11.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.6

Current version
:   1.11.7

Updates in this version
:   See the Istio release notes for [Istio 1.11.7](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.7/.){: external}.

:   Resolves the following CVEs
    - [CVE-2021-3995](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3995){: external}
    - [CVE-2021-3996](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3996){: external}

:   For more information, see the [Istio security bulletin 2022-003](https://istio.io/latest/news/security/istio-security-2022-003/){: external}.

### Change log for 1.11.6, released 15 February 2022
{: #1116}

Review the changes that are included in version 1.11.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.5

Current version
:   1.11.6

Updates in this version
:   See the Istio release notes for [Istio 1.11.6](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.6/.){: external}.

### Change log for 1.11.5, released 14 December 2021
{: #1115}

Review the changes that are in version 1.11.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.4  

Current version
:   1.11.5 

Updates in this version
:   See the Istio release notes for [Istio 1.11.5](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.5/.){: external}. 

:   Resolves the following CVE:
    - [USN-5089-1](https://ubuntu.com/security/notices/USN-5089-1){: external}


### Change log for 1.11.4, released 2 November 2021
{: #1114}

Review the changes that are in version 1.11.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.3  

Current version
:   1.11.4  

Updates in this version
:   See the Istio release notes for [Istio 1.11.4](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.4/){: external}.

### Change log for 1.11.3, released 7 October 2021
{: #1113}

Review the changes that are in version 1.11.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.2  

Current version
:   1.11.3   

Updates in this version
:   See the Istio release notes for [Istio 1.11.3](https://istio.io/latest/docs/releases/supported-releases/#support-status-of-istio-releases){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){: external}
    - [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){: external}
    - [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){: external}
    - [CVE-2021-33560](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33560){: external}
    - [CVE-2021-40528](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-40528){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}.

### Change log for 1.11.2, released 23 September 2021
{: #1112}

Review the changes that are in version 1.11.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.11.1

Current version
:   1.11.2  

Updates in this version
:   See the Istio release notes for [Istio 1.11.2](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.2/){: external}.

:   Resolves the following CVEs
    - [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external}
    - [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}
    - [CVE-2021-3634](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3634){: external}
    
### Change log for 1.11.1, released 31 August 2021
{: #1111}

Review the changes that are in version 1.11.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.10.3

Current version
:   1.11.1  

Updates in this version
:   See the Istio release notes for [Istio 1.11.0](https://istio.io/latest/news/releases/1.11.x/announcing-1.11/){: external} and [Istio 1.11.1](https://istio.io/latest/news/releases/1.11.x/announcing-1.11.1/.){: external}.

:   Adds a `postStart` variable to the sidecar to enable the holdApplicationUntilProxyStarts option. Since the sidecar is normally last this doesn't impact default behavior where Istio places the sidecar as the last container. If you are adding containers to your pods, verify that they get added before the sidecar or can wait for the sidecar to start.

:   Resolves the following CVEs
    - [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22898){: external}
    - [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}
    - [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}.

## Version 1.10 (unsupported)
{: #v110}

Review the changes that are in version 1.10 of the managed Istio add-on.
{: shortdesc}

Version 1.10 of the managed Istio add-on is unsupported. 
{: deprecated}

### Change log for 1.10.6, released 13 January 2022
{: #1106}

Review the changes that are included in version 1.10.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.10.5  

Current version
:   1.10.6 

Updates in this version
:   See the Istio release notes for [Istio 1.10.6](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.6/){: external}. 

### Change log for 1.10.5, released 28 October 2021
{: #1105}

Review the changes that are in version 1.10.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.10.4  

Current version
:   1.10.5  

Updates in this version
:   See the Istio release notes for [Istio 1.10.5](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.5/){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-22945](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22945){: external}
    - [CVE-2021-22946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22946){: external}
    - [CVE-2021-22947](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22947){: external}
    - [CVE-2021-33560](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33560){: external}
    - [CVE-2021-40528](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-40528){: external}
    - [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33560){: external}
    - [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-40528){: external}
    - [usn-5089-1](https://ubuntu.com/security/notices/USN-5089-1){: external}
    - [usn-5079-3](https://ubuntu.com/security/notices/USN-5079-1){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}.

### Change log for 1.10.4, released 14 September 2021
{: #1104}

Review the changes that are in version 1.10.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.10.3 

Current version
:   1.10.4 

Updates in this version
:   See the Istio release notes for [Istio 1.10.4](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.4/.){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22898){: external}
    - [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}
    - [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}.

### Change log for 1.10.3, released 5 August 2021
{: #1103}

Review the changes that are in version 1.10.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.10.2  

Current version
:   1.10.3   

Updates in this version
:   See the Istio release notes for [Istio 1.10.3](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.3/.){: external}. 

### Change log for 1.10.2, released 15 July 2021
{: #1102}

Review the changes that are in version 1.10.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.5  

Current version
:   1.10.2  

Updates in this version
:   See the Istio release notes for:
    - [Istio 1.10.0](https://istio.io/latest/news/releases/1.10.x/announcing-1.10/){: external}
    - [Istio 1.10.1](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.1/){: external}
    - [Istio 1.10.2](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.2/){: external}. 

:   The API version of the `IstioOperator` (IOP) custom resource definition is updated from `v1beta1` to `v1`. Although this update does not impact existing custom IOP resources, you can optionally back up your IOP resources before upgrading to Istio version 1.10. 

:   The `IstioOperator` deployment is now created by the Istio add-on instead of the Operator Lifecycle Manager (OLM). If you choose to uninstall the add-on, steps are included to uninstall the [deployment resources for the operator](/docs/containers?topic=containers-istio#uninstall_resources).

:   In multizone clusters, the zone labels for default Istio ingress gateways are now sorted in reverse order to improve resiliency. This change does not affect any ingress gateways that are already enabled and assigned a zone label in the `managed-istio-custom` ConfigMap. 

:   Resolves the following CVEs
    - [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}.
    - [CVE-2018-16869](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16869){: external}.
    - [CVE-2021-3580](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3580){: external}. 
  
  
## Version 1.9 (unsupported)
{: #v19}

Version 1.9 of the managed Istio add-on is unsupported.
(: deprecated)

### Change log for 1.9.8, released 14 September 2021
{: #198}

Review the changes that are in version 1.9.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.7  

Current version
:   1.9.8   

Updates in this version
:   See the Istio release notes for [Istio 1.9.8](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.8/.){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22898){: external}
    - [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}
    - [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}

:   For more information, see the [Istio security bulletin 2021-008](https://istio.io/latest/news/security/istio-security-2021-008/){: external}.

### Change log for 1.9.7, released 12 August 2021
{: #197}

Review the changes that are in version 1.9.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.6  

Current version
:   1.9.7  

Updates in this version
:   See the Istio release notes for [Istio 1.9.7](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.7/.){: external}.

### Change log for 1.9.6, released 22 July 2021
{: #196}

Review the changes that are in version 1.9.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.5  

Current version
:   1.9.6  

Updates in this version
:   See the Istio release notes for [Istio 1.9.6](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.6/){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}.
    - [CVE-2018-16869](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16869){: external}.
    - [CVE-2021-3580](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3580){: external}.

### Change log for 1.9.5, released 27 May 2021
{: #195}

Review the changes that are in version 1.9.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.4  

Current version
:   1.9.5  

Updates in this version
:   See the Istio release notes for [Istio 1.9.5](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.5/){: external}. 

:   Resolves [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}.

### Change log for 1.9.4, released 17 May 2021
{: #194}

Review the changes that are in version 1.9.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.3  

Current version
:   1.9.4  

Updates in this version
:   See the Istio release notes for [Istio 1.9.4](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.4/){: external}.


### Change log for 1.9.3, released 29 April 2021
{: #193}

Review the changes that are in version 1.9.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.9.2  

Current version
:   1.9.3  

Updates in this version
:   See the Istio release notes for [Istio 1.9.3](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.3/){: external}.

:   Resolves the following CVEs
    - [CVE-2021-28683](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28683){: external}
    - [CVE-2021-28682](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28682){: external}
    - [CVE-2021-29258](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-29258){: external}
    - [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
    - [CVE-2021-22876](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22876){: external}
    - [CVE-2021-22890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22890){: external}
    - [usn-4891-1](https://ubuntu.com/security/notices/USN-4891-1/){: external}
    - [usn-4898-1](https://ubuntu.com/security/notices/USN-4898-1/){: external}. 

:   For more information, see the [Istio security bulletin 2021-003](https://istio.io/latest/news/security/istio-security-2021-003/){: external}.


### Change log for 1.9.2, released 1 April 2021
{: #192}

Review the changes that are in version 1.9.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.4  

Current version
:   1.9.2  

Updates in this version
:   See the Istio release notes for:
    - [Istio 1.9.0](https://istio.io/latest/news/releases/1.9.x/announcing-1.9/){: external}
    - [Istio 1.9.1](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.1/){: external}
    - [Istio 1.9.2](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.2/){: external}. 

:   The `istio-components-pilot-requests-cpu` setting is added to the `managed-istio-custom` ConfigMap resource to change the default CPU request of `500` for `istiod`.

  
## Version 1.8 (unsupported)
{: #v18}

Version 1.8 of the managed Istio add-on is unsupported.
(: deprecated)

### Change log for 1.8.6, released 27 May 2021
{: #186}

Review the changes that are in version 1.8.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.5  

Current version
:   1.8.6  

Updates in this version
:   See the Istio release notes for [Istio 1.8.6](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.6/){: external}. 

:   Resolves[CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. 

### Change log for 1.8.5, released 29 April 2021
{: #185}

Review the changes that are in version 1.8.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.4  

Current version
:   1.8.5  

Updates in this version
:   See the Istio release notes for [Istio 1.8.5](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.5/){: external}.

:   Resolves the following CVEs
    - [CVE-2021-28683](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28683){: external}
    - [CVE-2021-28682](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28682){: external}
    - [CVE-2021-29258](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-29258){: external}
    - [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
    - [CVE-2021-22876](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22876){: external}
    - [CVE-2021-22890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22890){: external}
    - [CVE-2021-24031](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24031){: external}
    - [CVE-2021-24032](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24032){: external}
    - [usn-4760-1](https://ubuntu.com/security/notices/USN-4760-1/){: external}
    - [usn-4891-1](https://ubuntu.com/security/notices/USN-4891-1/){: external}
    - [usn-4898-1](https://ubuntu.com/security/notices/USN-4898-1/){: external}. 

:   For more information, see the [Istio security bulletin 2021-003](https://istio.io/latest/news/security/istio-security-2021-003/){: external}.


### Change log for 1.8.4, released 23 March 2021
{: #184}

Review the changes that are in version 1.8.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.3  

Current version
:   1.8.4 

Updates in this version
:   See the Istio release notes for [Istio 1.8.4](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.4/){: external}.

:   Resolves the following CVEs
    - [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}
    - [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}
    - [CVE-2020-27619](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27619){: external}
    - [CVE-2021-3177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3177){: external}


### Change log for 1.8.3, released 1 March 2021
{: #183}

Review the changes that are in version 1.8.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.2   

Current version
:   1.8.3  

Updates in this version
:   See the Istio release notes for [Istio 1.8.3](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.3/){: external}. 

:   Resolves the following CVEs 
    - [CVE-2018-20482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20482){: external}
    - [CVE-2019-9923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9923){: external}
    - [CVE-2021-23239](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23239){: external}
    - [CVE-2021-3156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3156){: external}


### Change log for 1.8.2, released 25 January 2021
{: #182}

Review the changes that are in version 1.8.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.1  

Current version
:   1.8.2  

Updates in this version
:   See the Istio release notes for [Istio 1.8.2](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.2/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}
    - [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}
    - [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}
    - [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}
    - [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}
    - [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}
    - [usn-4662-1](https://ubuntu.com/security/notices/USN-4662-1){: external}
    - [usn-4665-1](https://ubuntu.com/security/notices/USN-4665-1/){: external}
    - [usn-4667-1](https://ubuntu.com/security/notices/USN-4667-1){: external}
    - [usn-4677-1](https://ubuntu.com/security/notices/USN-4677-1){: external}.


### Change log for 1.8.1, released 16 December 2020
{: #181}

Review the changes that are in version 1.8.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.0 

Current version
:   1.8.1  

Updates in this version
:   See the Istio release notes for [Istio 1.8.1](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.1/){: external}. 

### Change log for 1.8.0, released 9 December 2020
{: #180}

Review the changes that are in version 1.8.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.8.0  

Current version
:   1.7.5  

Updates in this version
:   See the Istio release notes for [Istio 1.8](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/){: external}. 

:   If you created a custom `IstioOperator` (IOP) resource, remove the `revision` field from the resource before you update your add-on to version 1.8 so that the custom gateways use version 1.8 of `istiod`. After you update your Istio add-on, update the tag for any custom gateways to 1.8. All `istio-monitoring` support is removed, and in the `managed-istio-custom` ConfigMap, the `istio-monitoring-components` and `istio-kiali-dashboard-viewOnlyMode` options are unsupported. To use monitoring with Istio, you must install the Kiali, Prometheus, Jaeger, and Grafana components separately from the Istio add-on. For more information, see the [Istio documentation](https://istio.io/latest/docs/ops/integrations/){: external}. 
:   The `istio-meshConfig-enableTracing` and `istio-egressgateway-public-1-enabled` optional settings are added to the [`managed-istio-custom` ConfigMap resource](/docs/containers?topic=containers-istio#customize). 

## Version 1.7 (unsupported)
{: #v17}

Version 1.7 of the managed Istio add-on is unsupported.
(: deprecated)

### Change log for 1.7.8, released 10 March 2021
{: #178}

Review the changes that are in version 1.7.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.7 

Current version
:   1.7.8  

Updates in this version
:   See the Istio release notes for [Istio 1.7.8](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.8/){: external}. 

:   Resolves the following CVEs
    - [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}
    - [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-23841){: external}


### Change log for 1.7.7, released 8 February 2021
{: #177}

Review the changes that are in version 1.7.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.6 

Current version
:   1.7.7  

Updates in this version
:   See the Istio release notes for [Istio 1.7.7](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.7/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}
    - [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}
    - [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}
    - [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}
    - [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}
    - [CVE-2021-23239](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23239){: external}
    - [CVE-2021-3156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3156){: external}
    - [CVE-2020-29361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361){: external}
    - [CVE-2020-29362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362){: external}
    - [CVE-2020-29363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363){: external}
    - [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}
    - [CVE-2018-20482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20482){: external}
    - [CVE-2019-9923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9923){: external}


### Change log for 1.7.6, released 16 December 2020
{: #176}

Review the changes that are in version 1.7.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.5 

Current version
:   1.7.6  

Updates in this version
:   See the Istio release notes for [Istio 1.7.6](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.6/){: external}. 

:   Resolves [CVE-2020-28196](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28196){: external}. 


### Change log for 1.7.5, released 3 December 2020
{: #175}

Review the changes that are in version 1.7.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.4 

Current version
:   1.7.5  

Updates in this version
:   See the Istio release notes for [Istio 1.7.5](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.5/){: external}.


### Change log for 1.7.4, released 5 November 2020
{: #174}

Review the changes that are in version 1.7.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.3 

Current version
:   1.7.4  

Updates in this version
:   See the Istio release notes for [Istio 1.7.4](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.4/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-26116](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26116){: external}
    - [usn-4581-1](https://ubuntu.com/security/notices/USN-4581-1){: external} 


### Change log for 1.7.3, released 06 October 2020
{: #173}

Review the changes that are in version 1.7.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.2 

Current version
:   1.7.3  

Updates in this version
:   See the Istio release notes for [Istio 1.7.3](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.3/){: external}. 

:   Updates Prometheus to version 2.21.0 and Jaeger to version 1.20.0. Note that these components are deprecated in version 1.7 of the Istio add-on and are automatically removed in [version 1.8 of the Istio add-on](https://istio.io/latest/docs/ops/integrations/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-25017](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25017){: external}
    - [CVE-2018-7738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7738){: external}
    - [usn-4512-1](https://ubuntu.com/security/notices/USN-4512-1){: external}. 

:   For more information, see the [Istio security bulletin 2020-010](https://istio.io/latest/news/security/istio-security-2020-010/){: external}.  


### Change log for 1.7.2, released 23 September 2020
{: #172}

Review the changes that are in version 1.7.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.1 

Current version
:   1.7.2  

Updates in this version
:   See the Istio release notes for [Istio 1.7.2](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.2/){: external}.


### Change log for 1.7.1, released 14 September 2020
{: #171}

Review the changes that are in version 1.7.1 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.7.0 

Current version
:   1.7.1  

Updates in this version
:   See the Istio release notes for [Istio 1.7.1](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.1/){: external}. 

### Change log for 1.7.0, released 02 September 2020
{: #170}

Review the changes that are in version 1.7.0 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.8 

Current version
:   1.7.0  

Updates in this version
:   See the Istio release notes for [Istio 1.7](https://istio.io/latest/news/releases/1.7.x/announcing-1.7/){: external}. 

:   All `istio-monitoring` support is deprecated in version 1.7 of the Istio add-on and is automatically removed in version 1.8 of the Istio add-on. To use monitoring with Istio, you must install the components separately from the Istio add-on. 

:   For more information, see the [Istio documentation](https://istio.io/latest/docs/ops/integrations/){: external}. 

:   The `istio-ingressgateway-public-(n)-enabled` and `istio-ingressgateway-zone-(n)` options in the [`managed-istio-custom` ConfigMap resource](/docs/containers?topic=containers-istio#customize) are generally available for production use. 
  

  
## Version 1.6 (unsupported)
{: #v16}

Version 1.6 of the managed Istio add-on is unsupported.
(: deprecated)

### Differences between version 1.6 of managed and community Istio
{: #diff-managed-comm-16}

Review the following differences between the installation profiles of version 1.6 of the managed {{site.data.keyword.containerlong_notm}} Istio and version 1.6 of the community Istio.
{: shortdesc}

To see options for changing settings in the managed version of Istio, see [Customizing the Istio installation](/docs/containers?topic=containers-istio#customize).
{: tip}

| Setting | Differences in the managed Istio add-on |
| ------- | --------------------------------------- |
| `meshConfig.enablePrometheusMerge=true` and `values.telemetry.v2.enabled=true` | In the managed Istio add-on, support for telemetry with {{site.data.keyword.mon_full_notm}} is enabled by default. This support can be disabled by [customizing the Istio installation](/docs/containers?topic=containers-istio#customize). |
| `istio-ingressgateway` and `istio-egressgateway` | In the managed Istio add-on, placement of gateways on edge worker nodes is preferred, but not required. |
| Envoy sidecar proxy lifecycle pre-stop | In the managed Istio add-on, a sleep time of 25 seconds is added to allow traffic connections to close before an Envoy sidecar is removed from an app pod. |
{: caption="Table 1. Differences between the managed {{site.data.keyword.containerlong_notm}} Istio and the community Istio" caption-side="bottom"}

### Change log for 1.6.14, released 3 December 2020
{: #1614}

Review the changes that are in version 1.6.14 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.13  

Current version
:   1.6.14  

Updates in this version
:   See the Istio release notes for [Istio 1.6.14](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.14/){: external}. 

:   Resolves [CVE-2020-28196](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28196){: external}. 

### Change log for 1.6.13, released 5 November 2020
{: #1613}

Review the changes that are in version 1.6.13 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.12  

Current version
:   1.6.13  

Updates in this version
:   See the Istio release notes for [Istio 1.6.13](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.13/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-26116](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26116){: external}
    - [usn-4581-1](https://ubuntu.com/security/notices/USN-4581-1){: external}.


### Change log for 1.6.12, released 22 October 2020
{: #1612}

Review the changes that are in version 1.6.12 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.11  

Current version
:   1.6.12  

Updates in this version
:   See the Istio release notes for [Istio 1.6.12](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.12/){: external}. 

### Change log for 1.6.11, released 06 October 2020
{: #1611}

Review the changes that are in version 1.6.11 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.9  

Current version
:   1.6.11  

Updates in this version
:   See the Istio release notes for:
    - [Istio 1.6.10](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.10/){: external}
    - [Istio 1.6.11](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.11/){: external}. 

:   Updates Prometheus to version 2.21.0 and Jaeger to version 1.20.0. Note that these components are deprecated in version 1.7 of the Istio add-on and are automatically removed in [version 1.8 of the Istio add-on](https://istio.io/latest/docs/ops/integrations/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-25017](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25017){: external}
    - [CVE-2018-7738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7738){: external}
    - [usn-4512-1](https://ubuntu.com/security/notices/USN-4512-1){: external}.

:   For more information, see the [Istio security bulletin 2020-010](https://istio.io/latest/news/security/istio-security-2020-010/){: external}.


### Change log for 1.6.9, released 14 September 2020
{: #169}

Review the changes that are in version 1.6.9 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.8  

Current version
:   1.6.9  

Updates in this version
:   See the Istio release notes for [Istio 1.6.9](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.9/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}
    - [usn-4466-1](https://ubuntu.com/security/notices/USN-4466-1){: external}

:   For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}.


### Change log for 1.6.8, released 12 August 2020
{: #168}

Review the changes that are in version 1.6.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.7  

Current version
:   1.6.8  

Updates in this version
:   See the Istio release notes for [Istio 1.6.8](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.6/){: external}. 

:   Resolves [CVE-2020-16844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16844){: external}. 

:   For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}


### Change log for 1.6.7, released 04 August 2020
{: #167}

Review the changes that are in version 1.6.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6.5  

Current version
:   1.6.7  

Updates in this version
:   See the Istio release notes for:
    - [Istio 1.6.6](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.6/){: external}
    - [Istio 1.6.7](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.7/){: external}

:   Resolves the following CVEs
    - [CVE-2019-17514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17514){: external}
    - [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}
    - [CVE-2019-9674](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9674){: external}
    - [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}
    - [usn-4428-1](https://ubuntu.com/security/notices/USN-4428-1){: external}


### Change log for 1.6.5, released 17 July 2020
{: #165}

Review the changes that are in version 1.6.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.6  

Current version
:   1.6.5  

Updates in this version
:   See the Istio release notes for [Istio 1.6.5](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.5/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-15104](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15104){: external}
    - [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}
    - [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}
    - [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}
    - [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}
    - [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}
    - [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}
    - [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}
    - [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}
    - [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}
    - [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}
    - [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. 

:   For more information, see the [Istio security bulletin 2020-008](https://istio.io/latest/news/security/istio-security-2020-008/){: external}


### Change log for 1.6, released 08 July 2020
{: #16}

Review the changes that are in version 1.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.7  

Current version
:   1.6  

Updates in this version
:   See the Istio release notes for [Istio 1.6](https://istio.io/latest/news/releases/1.6.x/announcing-1.6/){: external}. 

:   Support is added for the `istio-knative-cluster-local-gateway-enabled` and `istio-monitoring-telemetry` options in the [`managed-istio-custom` ConfigMap resource](/docs/containers?topic=containers-istio#customize). You can use these options to manage inclusion of Knative apps in the service mesh and the Istio telemetry enablement. Support for {{site.data.keyword.mon_full_notm}} is enabled for Istio by default.
  
  

## Version 1.5 (unsupported)
{: #v15}

Version 1.5 of the managed Istio add-on is unsupported.
(: deprecated)

### Differences between version 1.5 of managed and community Istio
{: #diff-managed-comm}

Review the following differences between the installation profiles of version 1.5 of the managed {{site.data.keyword.containerlong_notm}} Istio and version 1.5 of the community Istio.
{: shortdesc}

To see options for changing settings in the managed version of Istio, see [Customizing the version 1.5 Istio installation](/docs/containers?topic=containers-istio#customize).
{: tip}

| Setting | Differences in the managed Istio add-on |
| ------- | --------------------------------------- |
| `egressGateways[name: istio-egressgateway].enabled: true` | In the managed Istio add-on, the egress gateway is enabled by default. |
| `istiod`, `istio-ingressgateway`, and `istio-egressgateway` | In the managed Istio add-on, `istiod` and all Istio ingress and egress gateways are set up for basic high availability support. High availability support on these components includes the following settings by default: node anti-affinity, `HorizontalPodAutoscaler`, `PodDisruptionBudget`, and automatic scaling of replicas. |
| `prometheus.enabled: false` | In the managed Istio add-on, the Prometheus, Grafana, Jaeger, and Kiali monitoring components are disabled by default due to current security concerns in the community release of Istio that can't be adequately addressed for a production environment. |
| `values.global.pilot.enableProtocolSniffingForInbound` and `values.global.pilot.enableProtocolSniffingForOutbound` | In the managed Istio add-on, protocol sniffing is disabled by default until the feature becomes more stable in the community Istio.
{: caption="Table 1. Differences between the managed {{site.data.keyword.containerlong_notm}} Istio and the community Istio" caption-side="bottom"}

### Change log for 1.5.10, released 1 September 2020
{: #1510}

Review the changes that are in version 1.5.10 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.9  

Current version
:   1.5.10  

Updates in this version
:   See the Istio release notes for [Istio 1.5.10](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.10/){: external}.

### Change log for 1.5.9, released 12 August 2020
{: #159}

Review the changes that are in version 1.6.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.8  

Current version
:   1.5.9  

Updates in this version
:   See the Istio release notes for [Istio 1.5.9](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.9/){: external}. 

:   Resolves the following CVEs
    - [CVE-2019-17514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17514){: external}
    - [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}
    - [CVE-2019-9674](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9674){: external}
    - [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}
    - [CVE-2020-16844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16844){: external}
    - [usn-4428-1](https://ubuntu.com/security/notices/USN-4428-1){: external}. 

:   For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}.


### Change log for 1.5.8, released 16 July 2020
{: #158}

Review the changes that are in version 1.5.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.7  

Current version
:   1.5.8  

Updates in this version
:   See the Istio release notes for [Istio 1.5.8](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.8/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-15104](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15104){: external}
    - [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}
    - [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}
    - [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}
    - [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}
    - [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}
    - [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}
    - [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}
    - [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}
    - [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}
    - [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}
    - [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. 

:   For more information, see the [Istio security bulletin 2020-008](https://istio.io/latest/news/security/istio-security-2020-008/){: external}. 


### Change log for 1.5.7, released 8 July 2020
{: #157}

Review the changes that are in version 1.5.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.6  

Current version
:   1.5.7  

Updates in this version
:   See the Istio release notes for [Istio 1.5.7](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.7/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-12603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12603){: external}
    - [CVE-2020-12605](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12605){: external}
    - [CVE-2020-8663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8663){: external}
    - [CVE-2020-12604](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12604){: external}
    - [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169){: external}
    - [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}
    - [usn-4402-1](https://ubuntu.com/security/notices/USN-4402-1){: external}

:   For more information, see the [Istio security bulletin 2020-007](https://istio.io/latest/news/security/istio-security-2020-007/){: external}. 


### Change log for 1.5.6, released 23 June 2020
{: #156}

Review the changes that are in version 1.5.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.5.4  

Current version
:   1.5.6  

Updates in this version
:   See the Istio release notes for [Istio 1.5.5](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.6/){: external} and [Istio 1.5.6](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.6/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-11080](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11080){: external}
    - [CVE-2018-8740](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8740){: external}
    - [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external} 
    - [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}
    - [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}
    - [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external} 
    - [CVE-2019-19603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19603){: external} 
    - [CVE-2019-19645](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19645){: external} 
    - [CVE-2019-20795](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20795){: external}
    - [CVE-2020-11655](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11655){: external}
    - [CVE-2020-13434](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13434){: external}
    - [CVE-2020-13435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13435){: external}
    - [CVE-2020-13630](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13630){: external}
    - [CVE-2020-13631](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13631){: external}
    - [CVE-2020-13632,](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13632,){: external}
    - [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}
    - [usn-4357-1](https://ubuntu.com/security/notices/USN-4357-1/){: external}
    - [usn-4359-1](https://ubuntu.com/security/notices/USN-4359-1/){: external}
    - [usn-4376-1](https://ubuntu.com/security/notices/USN-4376-1/){: external}
    - [usn-4377-1](https://ubuntu.com/security/notices/USN-4377-1/){: external}
    - [usn-4394-1](https://ubuntu.com/security/notices/USN-4394-1/){: external}

:   For more information, see the [Istio security bulletin 2020-006](https://istio.io/latest/news/security/istio-security-2020-006/){: external}

### Change log for 1.5, released 19 May 2020
{: #15}

Review the changes that are in version 1.5 of the managed Istio add-on.
{: shortdesc}

Version 1.5 of the Istio add-on is supported for clusters that run Kubernetes versions 1.17 only.
{: note}

Previous version
:   1.4.9  

Current version
:   1.5  

Updates in this version
:   See the Istio release notes for [Istio 1.5](https://istio.io/latest/news/releases/1.5.x/announcing-1.5/change-notes/){: external}. 

:   The Citadel secret discovery service (SDS) is now enabled by default to provide identity provisioning and certification for workloads in the service mesh. [With the `managed-istio-custom` ConfigMap resource, you can customize a set of Istio configuration options](/docs/containers?topic=containers-istio#customize). These settings include extra control over monitoring, logging, and networking in your control plane and service mesh. Beta: By default, one public Istio load balancer, `istio-ingressgateway`, is enabled in your cluster. To achieve higher availability, you can now enable an Istio load balancer in each zone of your cluster. For more information, see [Enabling or disabling public Istio load balancers](/docs/containers?topic=containers-istio-mesh#config-gateways). The Prometheus, Grafana, Jaeger, and Kiali monitoring components are disabled by default due to current security concerns in the community release of Istio that can't be adequately addressed for a production environment. If you use {{site.data.keyword.mon_full_notm}} to monitor your Istio-managed apps, update the `sysdig-agent` ConfigMap so that sidecar metrics are tracked. Changes can't be made to the Kiali dashboard in view-only mode by default. You can change this setting by [editing the `managed-istio-custom` ConfigMap](/docs/containers?topic=containers-istio#customize). Your cluster must have a secret with credentials to Grafana to access the Grafana dashboard. 
  
  
## Version 1.4 (unsupported)
{: #v14}

Version 1.4 of the managed Istio add-on is unsupported.
(: deprecated)

## Change log for 1.4.9, released 18 May 2020
{: #149}

Review the changes that are in version 1.4.9 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.8  

Current version
:   1.4.9  

Updates in this version
:   See the Istio release notes for [Istio 1.4.9](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.9/){: external}. 

:   Resolves the following CVEs
    - [CVE-2019-18348](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18348){: external}
    - [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}
    - [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492){: external}
    - [usn-4359-1](https://ubuntu.com/security/notices/USN-4359-1/){: external}
    - [usn-4333-1](https://ubuntu.com/security/notices/USN-4333-1/){: external}

:   For more information, see the [Istio security bulletin](https://istio.io/latest/news/security/istio-security-2020-005/){: external}

## Change log for 1.4.8, released 30 April 2020
{: #148}

Review the changes that are in version 1.4.8 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.7  

Current version
:   1.4.8  

Updates in this version
:   See the Istio release notes for [Istio 1.4.8](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.8/){: external}. 

:   Resolves the following CVEs
    - [CVE-2017-15412](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-15412){: external}
    - [CVE-2016-5131](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-5131){: external}
    - [CVE-2018-14404](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14404){: external}
    - [CVE-2015-8035](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-8035){: external}
    - [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}
    - [CVE-2019-3820](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3820){: external}
    - [CVE-2019-9924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924){: external}
    - [CVE-2018-14567](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14567){: external}
    - [CVE-2015-2716](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-2716){: external}
    - [CVE-2017-18258](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19880){: external}
    - [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}

## Change log for 1.4.7, released 01 April 2020
{: #147}

Review the changes that are in version 1.4.7 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.6  

Current version
:   1.4.7  

Updates in this version
:   See the Istio release notes for [Istio 1.4.7](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.7/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-1764](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1764){: external}
    - [CVE-2019-19925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19925){: external}
    - [CVE-2019-13750](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13750){: external}
    - [CVE-2019-13752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13752){: external}
    - [CVE-2019-19959](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19959){: external}
    - [CVE-2019-19926](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19926){: external}
    - [CVE-2019-13753](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13753){: external}
    - [CVE-2019-13751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13751){: external}
    - [CVE-2019-19923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19923){: external}
    - [CVE-2019-19924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19924){: external}
    - [CVE-2019-20218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20218){: external}
    - [CVE-2020-9327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9327){: external}
    - [CVE-2019-13734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13734){: external}
    - [CVE-2019-19880](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19880){: external}

## Change log for 1.4.6, released 09 March 2020
{: #146}

Review the changes that are in version 1.4.6 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.5  

Current version
:   1.4.6  

Updates in this version
:   See the Istio release notes for [Istio 1.4.6](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.6/){: external}. 

:   Resolves the following CVEs
    - [CVE-2020-8659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8659){: external}
    - [CVE-2020-8660](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8660){: external}
    - [CVE-2020-8661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8661){: external}
    - [CVE-2020-8664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8664){: external}

## Change log for 1.4.5, released 21 February 2020
{: #145}

Review the changes that are in version 1.4.5 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.4  

Current version
:   1.4.5  

Updates in this version
:   See the Istio release notes for [Istio 1.4.5](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.5/){: external}. 

:   Resolves the following CVEs
    - [CVE-2019-18634](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18634){: external}
    - [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}
    - [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}
    - [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}
    - [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}
    - [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}
    - [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}
    - [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}
    - [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}
    - [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}
    - [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}
    - [usn-4263-1](https://ubuntu.com/security/notices/USN-4263-1/){: external}
    - [usn-4249-1](https://ubuntu.com/security/notices/USN-4249-1/){: external}
    - [usn-4269-1](https://ubuntu.com/security/notices/USN-4269-1/){: external}
    - [usn-4246-1](https://ubuntu.com/security/notices/USN-4246-1/){: external}

## Change log for 1.4.4, released 14 February 2020
{: #144}

Review the changes that are in version 1.4.4 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.3  

Current version
:   1.4.4  

Updates in this version
:   See the Istio release notes for [Istio 1.4.4](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.4/){: external}. 

:   Disables [protocol sniffing and detection](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/){: external}.

:   Improves the termination sequence for rolling updates of ingress and egress gateways. 

:   Resolves the following CVEs
    - [CVE-2020-8595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8595){: external}
    - [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}
    - [CVE-2019-15166](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15166){: external}
    - [CVE-2019-1010220](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1010220){: external}
    - [CVE-2019-19906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19906){: external}
    - [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}
    - [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}
    - [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}
    - [CVE-2019-13734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13734){: external}
    - [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}
    - [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}
    - [CVE-2019-11729](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11729){: external}
    - [CVE-2019-11745](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11745){: external}
    - [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}
    - [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}
    - [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}
    - [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}
    - [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}
    - [CVE-2018-14882](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14882){: external}
    - [CVE-2018-19519](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19519){: external}
    - [CVE-2018-14467](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14467){: external}
    - [CVE-2018-16451](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16451){: external}
    - [CVE-2018-14464](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14464){: external}
    - [CVE-2018-14463](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14463){: external}
    - [CVE-2018-14468](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14468){: external}
    - [CVE-2018-14879](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14879){: external}
    - [CVE-2018-14462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14462){: external}
    - [CVE-2018-14881](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14881){: external}
    - [CVE-2018-14470](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14470){: external}
    - [CVE-2018-14469](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14469){: external}
    - [CVE-2018-16227](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16227){: external}
    - [CVE-2018-16452](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16452){: external}
    - [CVE-2018-14466](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14466){: external}
    - [CVE-2018-14880](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14880){: external}
    - [CVE-2018-10105](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10105){: external}
    - [CVE-2018-16229](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16229){: external}
    - [CVE-2018-16230](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16230){: external}
    - [CVE-2018-10103](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10103){: external}
    - [CVE-2018-14461](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14461){: external}
    - [CVE-2018-16300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16300){: external}
    - [CVE-2018-16228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16228){: external}
    - [CVE-2018-14465](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14465){: external}
    - [CVE-2017-16808](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16808){: external}

:   For more information, see the [Istio security bulletin 2020-001](https://istio.io/latest/news/security/istio-security-2020-001/){: external}

## Change log for 1.4.3, released 16 January 2020
{: #143}

Review the changes that are in version 1.4.3 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.2  

Current version
:   1.4.3  

Updates in this version
:   See the Istio release notes for [Istio 1.4.3](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.3/){: external}. 

:   Disables [protocol sniffing and detection](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/){: external}.

:   Improves the termination sequence for rolling updates of ingress and egress gateways. 

## Change log for 1.4.2, released 16 December 2020
{: #142}

Review the changes that are in version 1.4.2 of the managed Istio add-on.
{: shortdesc}

Previous version
:   1.4.0  

Current version
:   1.4.2  

Updates in this version
:   See the Istio release notes for [Istio 1.4.2](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.2/){: external}. 

:   Resolves the following CVEs
    - [CVE-2019-18801](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18801){: external}
    - [CVE-2019-18802](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18802){: external}
    - [CVE-2019-18838](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18838){: external}

:   For more information, see the [Istio security bulletin](https://istio.io/latest/news/security/istio-security-2019-007/){: external}.
  
