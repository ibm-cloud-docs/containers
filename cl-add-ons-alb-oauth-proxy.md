---

copyright:
  years: 2024, 2026

lastupdated: "2026-02-26"


keywords: change log, version history, ALB OAuth Proxy

subcollection: "containers"

---

{{site.data.keyword.attribute-definition-list}}




# ALB OAuth Proxy add-on version change log
{: #cl-add-ons-alb-oauth-proxy}


Patch updates
:   Patch updates are delivered automatically by IBM and don't contain any feature updates or changes in the supported add-on and cluster versions.

Release updates
:   Release updates contain new features or changes in the supported add-on or cluster versions. You must manually apply release updates to your cluster autoscaler add-on.

To view a list of add-ons and the supported cluster versions, run the following command or see the [Supported cluster add-ons table](/docs/containers?topic=containers-supported-cluster-addon-versions).

```sh
ibmcloud ks cluster addon versions
```
{: pre}


Review the version history for ALB OAuth Proxy.
{: shortdesc}


## Version 2.0.0
{: #cl-add-ons-alb-oauth-proxy-2.0.0}


### 2.0.0_318867667, released 23 February 2026
{: #cl-add-ons-alb-oauth-proxy-200_318867667}

- Resolves the following CVEs: [CVE-2025-68121](https://nvd.nist.gov/vuln/detail/CVE-2025-68121){: external}.
- `oauth2-proxy v7.13.0-318860469`


### 2.0.0_315379759, released 10 February 2026
{: #cl-add-ons-alb-oauth-proxy-200_315379759}

- `oauth2-proxy v7.13.0-314571599`


### 2.0.0_302041660, released 04 December 2025
{: #cl-add-ons-alb-oauth-proxy-200_302041660}

- Updates Go to version `1.25`.
- `oauth2-proxy v7.13.0-302028748`


### 2.0.0_2943, released 18 August 2025
{: #cl-add-ons-alb-oauth-proxy-200_2943}

- Updates Go to version `1.24`.
- `oauth2-proxy v7.11.0-3074`


### 2.0.0_2897, released 16 August 2025
{: #cl-add-ons-alb-oauth-proxy-200_2897}

- Updates Go to version `1.24`.
- `oauth2-proxy v7.11.0-3052`


### 2.0.0_2817, released 22 July 2025
{: #cl-add-ons-alb-oauth-proxy-200_2817}

- Updates Go to version `1.24`.
- `oauth2-proxy v7.9.0-2982`


### 2.0.0_2765, released 23 June 2025
{: #cl-add-ons-alb-oauth-proxy-200_2765}

- Resolves the following CVEs: [CVE-2025-22872](https://nvd.nist.gov/vuln/detail/CVE-2025-22872){: external}.
- Updates Go to version `1.24`.
- `oauth2-proxy v7.9.0-2912`


### 2.0.0_2629, released 27 April 2025
{: #cl-add-ons-alb-oauth-proxy-200_2629}

- Resolves the following CVEs: [CVE-2025-22870](https://nvd.nist.gov/vuln/detail/CVE-2025-22870){: external}.
- `oauth2-proxy v7.5.0-2814`


### 2.0.0_2557, released 13 March 2025
{: #cl-add-ons-alb-oauth-proxy-200_2557}

- Resolves the following CVEs: [CVE-2025-22868](https://nvd.nist.gov/vuln/detail/CVE-2025-22868){: external}.
- `oauth2-proxy v7.5.0-2760`


### 2.0.0_2473, released 15 January 2025
{: #cl-add-ons-alb-oauth-proxy-200_2473}

- `oauth2-proxy v7.5.0-2683`


### 2.0.0_2400, released 31 October 2024
{: #cl-add-ons-alb-oauth-proxy-200_2400}

- Updates Go to version `1.22.7`.
- removed unnecessary image pull secret configuration 
- `oauth2-proxy v7.5.0-2542`


### 2.0.0_2340, released 03 September 2024
{: #cl-add-ons-alb-oauth-proxy-200_2340}

- Updates Go to version `1.22.4`.
- `oauth2-proxy v7.5.0-2505`


### 2.0.0_2301, released 06 June 2024
{: #cl-add-ons-alb-oauth-proxy-200_2301}

- Resolves the following CVEs: [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}.
- `oauth2-proxy v7.5.0-2417`


### 2.0.0_2266, released 04 June 2024
{: #cl-add-ons-alb-oauth-proxy-200_2266}

- Resolves the following CVEs: [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}.
- Updates Go to version `1.22.3`.
- `oauth2-proxy v7.5.0-2390`


### 2.0.0_2250, released 08 May 2024
{: #cl-add-ons-alb-oauth-proxy-200_2250}

- Resolves the following CVEs: [CVE-2024-24786](https://nvd.nist.gov/vuln/detail/CVE-2024-24786){: external}, and [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.
- Updates Go to version `1.22.0`.
- `oauth2-proxy v7.5.0-2356`
