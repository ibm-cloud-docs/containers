---

copyright:
  years: 2014, 2024
lastupdated: "2024-02-29"


keywords: kubernetes, fluentd
subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Fluentd add-on change log
{: #fluentd_changelog}

View image version changes for the Fluentd component for logging in your {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

As of 14 November 2019, a Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you don't forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).
{: important}

Refer to the following information for a summary of changes for each build of the Fluentd component.

## 14 November 2019
{: #14-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
- None
    
Disruptive
- The Fluentd component is created for your cluster only if you [create a logging configuration to forward logs to a syslog server](/docs/containers?topic=containers-health#configuring). If no logging configurations for syslog exist in your cluster, the Fluentd component is removed automatically. If you don't forward logs to syslog and want to ensure that the Fluentd component is removed from your cluster, [automatic updates to Fluentd must be enabled](/docs/containers?topic=containers-update#logging-up).

## 06 November 2019
{: #06-nov-2019}

The following changes occurred for the `c7901bf0d1323806d44ce5f92bce5085f9b6c791` Fluentd component.

Non-disruptive changes
- Fixes `LibSass` vulnerabilities for [CVE-2018-19218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19218){: external}.
    
Disruptive
- None

## 28 October 2019
{: #28-oct-2019}

The following changes occurred for the `ee01ba3471cadbb9925269183acd724f4bf0e5bd` Fluentd component.

Non-disruptive changes
- Fixes Ruby vulnerabilities
- [CVE-2019-15845](https://www.ruby-lang.org/en/news/2019/10/01/nul-injection-file-fnmatch-cve-2019-15845/){: external}
- [CVE-2019-16201](https://www.ruby-lang.org/en/news/2019/10/01/webrick-regexp-digestauth-dos-cve-2019-16201/){: external}
- [CVE-2019-16254](https://www.ruby-lang.org/en/news/2019/10/01/http-response-splitting-in-webrick-cve-2019-16254/){: external}
- [CVE-2019-16255](https://www.ruby-lang.org/en/news/2019/10/01/code-injection-shell-test-cve-2019-16255/){: external}
    
Disruptive
- None

## 24 September 2019
{: #24-sept-2019}

The following changes occurred for the `58c604236080f142f35d14fe3b6c4b4484290121` Fluentd component.

Non-disruptive changes
- Fixes OpenSSL vulnerabilities
- [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}
- [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}
- [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}
    
Disruptive
- None

## 18 September 2019
{: #18-sept-2019}

The following changes occurred for the `7c94e41a34ff1b7a56b9163471ff740a9585e053` Fluentd component.

Non-disruptive changes
- Updates the Kubernetes API version in the Fluentd deployment from `extensions/v1beta1` to `apps/v1`.
    
Disruptive
- None

## 15 August 2019
{: #14-aug-2019}

The following changes occurred for the `e7e944a8279deee0c3a8743e2fa69696ed71b6f5` Fluentd component.

Non-disruptive changes
- Fixes GNU binary utilities (`binutils`) vulnerabilities
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
- None


## 09 August 2019
{: #09-aug-2019}

The following changes occurred for the `d24b1afcc004ec9745dc3f9ef1328d3ed4b495f8` Fluentd component.

Non-disruptive changes
-  Fixes `musl libc` vulnerabilities for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.
    
Disruptive
- None

## 22 July 2019
{: #22-july-2019}

The following changes occurred for the `96f399cdea1c86c63a4ca4e043180f81f3559676` Fluentd component.

Non-disruptive changes
- Updates Alpine packages
- [CVE-2019-8905](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905){: external}
- [CVE-2019-8906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906){: external}
- [CVE-2019-8907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907){: external}
    
Disruptive
- None

## 30 June 2019
{: #30-june-2019}

The following changes occurred for the `e7c10d74350dc64d4d92ba7f72bb4ff9219315d2` Fluentd component.

Non-disruptive changes
- Updates the Fluent config map to always ignore pod logs from IBM namespaces, even when the Kubernetes master is unavailable.
    
Disruptive
- None

## 21 May 2019
{: #21-may-2019}

The following changes occurred for the `c16fe1602ab65db4af0a6ac008f99ca2a526e6f6` Fluentd component.

Non-disruptive changes
- Fixes a bug where worker node metrics did not display.
    
Disruptive
- None


## 10 May 2019
{: #10-may-2019}

The following changes occurred for the `60fc11f7bd39d9c6cfed923c598bf6457b3f2037` Fluentd component.

Non-disruptive changes
- Updates Ruby packages
- [CVE-2019-8320](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
- [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
- [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
- [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
- [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
- [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
- None

## 08 May 2019
{: #08-may-2019}

The following changes occurred for the `91a737f68f7d9e81b5d2223c910aaa7d7f91b76d` Fluentd component.

Non-disruptive changes
- Updates Ruby packages
- [CVE-2019-8320])https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320){: external}
- [CVE-2019-8321](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321){: external}
- [CVE-2019-8322](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322){: external}
- [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}
- [CVE-2019-8324](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324){: external}
- [CVE-2019-8325](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325){: external}
    
Disruptive
- None


## 11 April 2019
{: #11-april-2019}

The following changes occurred for the `d9af69e286986a05ed4a50469585b1cf978ddb1d` Fluentd component.

Non-disruptive changes
- Updates the cAdvisor plug-in to use TLS 1.2.
    
Disruptive
- None

## 01 April 2019
{: #01-april-2019}

The following changes occurred for the `3100ddb62580a9f46ffdff7bab2ebec40b164de6` Fluentd component.

Non-disruptive changes
- Updates the Fluentd service account.
    
Disruptive
- None

## 18 March 2019
{: #18-mar-2019}

The following changes occurred for the `c85567b75bd7ad1c9428794cd63a8e239c3fd8f5` Fluentd component.

Non-disruptive changes
- Removes the dependency on cURL for [CVE-2019-8323](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323){: external}.
    
Disruptive
- None

## 18 February 2019
{: #18-feb-2019}

The following changes occurred for the `320ffdf87de068ee2f7f34c0e7a47a111e8d457b` Fluentd component.

Non-disruptive changes
- Updates Fluentd to version 1.3.
- Removes Git from the Fluentd image for [CVE-2018-19486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486){: external}.
    
Disruptive
- None


## 01 January 2019
{: #01-jan-2019}

The following changes occurred for the `972865196aefd3324105087878de12c518ed579f` Fluentd component.

Non-disruptive changes
- Enables UTF-8 encoding for the Fluentd `in_tail` plug-in.
- Minor bug fixes.
    
Disruptive
- None
