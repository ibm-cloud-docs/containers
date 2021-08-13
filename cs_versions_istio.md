---

copyright:
  years: 2014, 2021
lastupdated: "2021-08-13"

keywords: kubernetes, iks, istio, add-on

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

 



# Istio add-on version changelog
{: #istio-changelog}

View information for patch and minor version updates to the [managed Istio add-on](/docs/containers?topic=containers-istio-about#istio_ov_addon) in your {{site.data.keyword.containerlong}} Kubernetes clusters.
{: shortdesc}

* **Patch updates**: {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. You can check the patch version of your add-on by running `kubectl get iop managed-istio -n ibm-operators -o jsonpath='{.metadata.annotations.version}'`.
* **Minor version updates**: To update your Istio components to the most recent minor version of Istio that is supported by {{site.data.keyword.containerlong_notm}}, such as from version 1.8 to 1.9, follow the steps in [Updating the minor version of the Istio add-on](/docs/containers?topic=containers-istio#istio_minor). When a minor version (`n`) of the Istio add-on is released, 1 minor version behind (`n-1`) is supported for typically 6 weeks after the latest version release date.
* **`istioctl` and sidecar updates**: Whenever the managed Istio add-on is updated, make sure that you [update your `istioctl` client and the Istio sidecars for your app](/docs/containers?topic=containers-istio#update_client_sidecar) to match the Istio version of the add-on. You can check whether the versions of your `istioctl` client and the Istio add-on control plane match by running `istioctl version`.

Review the supported versions of {{site.data.keyword.containerlong_notm}}. In the CLI, you can run `ibmcloud ks versions`.

| Istio add-on version | Supported? | Kubernetes version support |
| --- | --- | --- |
| 1.10 | Yes | 1.18, 1.19, 1.20, 1.21 |
| 1.9 | Yes| 1.17, 1.18, 1.19, 1.20 |
| 1.8 | No | - |
| 1.7 | No | - |
| 1.6 | No | - |
| 1.5 | No | - |
| 1.4 | No| - |
{: summary="The rows are read from left to right. The first column is the Istio add-on version. The second column is the version's supported state. The third column is the Kubernetes version of your cluster that the Istio version is supported for."}
{: caption="Supported Istio versions" caption-side="top"}

## Version 1.10
{: #v110}

### Changelog for 1.10.3, released 5 August 2021
{: #1103}


Review the changes that are included in version 1.10.3 of the managed Istio add-on.
{: shortdesc}


**Previous version**: 1.10.2  
**Current version**: 1.10.3   
**Updates in this version:**  
- See the Istio release notes for [Istio 1.10.3](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.3/.){:external}. 
- Resolves the following CVEs:
    - [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22898){: external}
    - [CVE-2021-22924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22924){: external}
    - [CVE-2021-22925](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22925){: external}

### Changelog for 1.10.2, released 15 July 2021
{: #1102}

Review the changes that are included in version 1.10.2 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.9.5  
**Current version**: 1.10.2  
**Updates in this version**  
- See the Istio release notes for:
    - [Istio 1.10.0](https://istio.io/latest/news/releases/1.10.x/announcing-1.10/){: external}
    - [Istio 1.10.1](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.1/){: external}
    - [Istio 1.10.2](https://istio.io/latest/news/releases/1.10.x/announcing-1.10.2/){: external}. 
- The API version of the `IstioOperator` (IOP) custom resource definition is updated from `v1beta1` to `v1`. Although this update does not impact existing custom IOP resources, you can optionally back up your IOP resources before upgrading to Istio version 1.10. 
- The `IstioOperator` deployment is now created by the Istio add-on instead of the Operator Lifecycle Manager (OLM). If you choose to uninstall the add-on, steps are included to uninstall the [deployment resources for the operator](/docs/containers?topic=containers-istio#uninstall_resources). 
- In multizone clusters, the zone labels for default Istio ingress gateways are now sorted in reverse order to improve resiliency. This change does not affect any ingress gateways that are already enabled and assigned a zone label in the `managed-istio-custom` configmap. 
- Resolves the following CVEs:
    - [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}.
    - [CVE-2018-16869](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16869){: external}.
    - [CVE-2021-3580](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3580){: external}. 
  
  
  
## Version 1.9
{: #v19}

### Changelog for 1.9.7, released 12 August 2021
{: #197}


Review the changes that are included in version 1.9.7 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.9.6  
**Current version**: 1.9.7  
**Updates in this version:**  
See the Istio release notes for [Istio 1.9.7](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.7/.){:external}.

### Changelog for 1.9.6, released 22 July 2021
{: #196}

Review the changes that are included in version 1.9.6 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.9.5  
**Current version**: 1.9.6  
**Updates in this version**  
- See the Istio release notes for [Istio 1.9.6](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.6/){: external}. 
- Resolves the following CVEs:
    - [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}.
    - [CVE-2018-16869](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16869){: external}.
    - [CVE-2021-3580](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3580){: external}.

### Changelog for 1.9.5, released 27 May 2021
{: #195}

Review the changes that are included in version 1.9.5 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.9.4  
**Current version** 1.9.5  
**Updates in this version**  
- See the Istio release notes for [Istio 1.9.5](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.5/){: external}. 
- Resolves [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}.

### Changelog for 1.9.4, released 17 May 2021
{: #194}

Review the changes that are included in version 1.9.4 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.9.3  
**Current version** 1.9.4  
**Updates in this version**
See the Istio release notes for [Istio 1.9.4](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.4/){: external}.


### Changelog for 1.9.3, released 29 April 2021
{: #193}

Review the changes that are included in version 1.9.3 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.9.2  
**Current version** 1.9.3  
**Updates in this version**
- See the Istio release notes for [Istio 1.9.3](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.3/){: external}.
- Resolves the following CVEs:
    - [CVE-2021-28683](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28683){: external}
    - [CVE-2021-28682](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28682){: external}
    - [CVE-2021-29258](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-29258){: external}
    - [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}
    - [CVE-2021-22876](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22876){: external}
    - [CVE-2021-22890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22890){: external}
    - [usn-4891-1](https://ubuntu.com/security/notices/USN-4891-1/){: external}
    - [usn-4898-1](https://ubuntu.com/security/notices/USN-4898-1/){: external}. 
- For more information, see the [Istio security bulletin 2021-003](https://istio.io/latest/news/security/istio-security-2021-003/).


### Changelog for 1.9.2, released 1 April 2021
{: #192}

Review the changes that are included in version 1.9.2 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.4  
**Current version** 1.9.2  
**Updates in this version**
- See the Istio release notes for:
    - [Istio 1.9.0](https://istio.io/latest/news/releases/1.9.x/announcing-1.9/){: external}
    - [Istio 1.9.1](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.1/){: external}
    - [Istio 1.9.2](https://istio.io/latest/news/releases/1.9.x/announcing-1.9.2/){: external}. 
- The `istio-components-pilot-requests-cpu` setting is added to the `managed-istio-custom` configmap resource to change the default CPU request of `500` for `istiod`.

  
  
  
  
## Version 1.8 (unsupported)
{: #v18}

### Changelog for 1.8.6, released 27 May 2021
{: #186}

Review the changes that are included in version 1.8.6 of the managed Istio add-on.
{: shortdesc}

This the final update for version 1.8, which becomes unsupported on 01 July 2021.
(: deprecated)

**Previous version** 1.8.5  
**Current version** 1.8.6  
**Updates in this version**
- See the Istio release notes for [Istio 1.8.6](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.6/){: external}. 
- Resolves[CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. 


### Changelog for 1.8.5, released 29 April 2021
{: #185}

Review the changes that are included in version 1.8.5 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.4  
**Current version** 1.8.5  
**Updates in this version**
- See the Istio release notes for [Istio 1.8.5](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.5/){: external}.
- Resolves the following CVEs:
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
- For more information, see the [Istio security bulletin 2021-003](https://istio.io/latest/news/security/istio-security-2021-003/).


### Changelog for 1.8.4, released 23 March 2021
{: #184}

Review the changes that are included in version 1.8.4 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.3  
**Current version** 1.8.4 
**Updates in this version**
- See the Istio release notes for [Istio 1.8.4](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.4/){: external}. 
- Resolves the following CVEs:
    - [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}
    - [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}
    - [CVE-2020-27619](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27619){: external}
    - [CVE-2021-3177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3177){: external}


### Changelog for 1.8.3, released 1 March 2021
{: #183}

Review the changes that are included in version 1.8.3 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.2   
**Current version** 1.8.3  
**Updates in this version**
- See the Istio release notes for [Istio 1.8.3](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.3/){: external}. 
- Resolves the following CVEs: 
    - [CVE-2018-20482](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20482){: external}
    - [CVE-2019-9923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9923){: external}
    - [CVE-2021-23239](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23239){: external}
    - [CVE-2021-3156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3156){: external}


### Changelog for 1.8.2, released 25 January 2021
{: #182}

Review the changes that are included in version 1.8.2 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.1  
**Current version** 1.8.2  
**Updates in this version**
- See the Istio release notes for [Istio 1.8.2](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.2/){: external}. 
- Resolves the following CVEs:
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


### Changelog for 1.8.1, released 16 December 2020
{: #181}

Review the changes that are included in version 1.8.1 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.0 
**Current version** 1.8.1  
**Updates in this version** 
See the Istio release notes for [Istio 1.8.1](https://istio.io/latest/news/releases/1.8.x/announcing-1.8.1/){: external}. 


### Changelog for 1.8.0, released 9 December 2020
{: #180}

Review the changes that are included in version 1.8.0 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.8.0  
**Current version** 1.7.5  
**Updates in this version**  
- See the Istio release notes for [Istio 1.8](https://istio.io/latest/news/releases/1.8.x/announcing-1.8/){: external}. 
- If you created a custom `IstioOperator` (IOP) resource, remove the `revision` field from the resource before you update your add-on to version 1.8 so that the custom gateways use version 1.8 of `istiod`. After you update your Istio add-on, update the tag for any custom gateways to 1.8. All `istio-monitoring` support is removed, and in the `managed-istio-custom` configmap, the `istio-monitoring-components` and `istio-kiali-dashboard-viewOnlyMode` options are unsupported. To use monitoring with Istio, you must install the Kiali, Prometheus, Jaeger, and Grafana components separately from the Istio add-on. For more information, see the [Istio documentation](https://istio.io/latest/docs/ops/integrations/){: external}. 
- The `istio-meshConfig-enableTracing` and `istio-egressgateway-public-1-enabled` optional settings are added to the [`managed-istio-custom` configmap resource](/docs/containers?topic=containers-istio#customize). 

  
  
  

## Version 1.7 (unsupported)
{: #v17}

### Changelog for 1.7.8, released 10 March 2021
{: #178}

Review the changes that are included in version 1.7.8 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.7 
**Current version** 1.7.8  
**Updates in this version**  
- See the Istio release notes for [Istio 1.7.8](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.8/){: external}. 
- Resolves the following CVEs:
    - [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}
    - [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-23841){: external}


### Changelog for 1.7.7, released 8 February 2021
{: #177}

Review the changes that are included in version 1.7.7 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.6 
**Current version** 1.7.7  
**Updates in this version** 
- See the Istio release notes for [Istio 1.7.7](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.7/){: external}. 
- Resolves the following CVEs:
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


### Changelog for 1.7.6, released 16 December 2020
{: #176}

Review the changes that are included in version 1.7.6 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.5 
**Current version** 1.7.6  
**Updates in this version** 
- See the Istio release notes for [Istio 1.7.6](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.6/){: external}. 
- Resolves [CVE-2020-28196](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28196){: external}. 


### Changelog for 1.7.5, released 3 December 2020
{: #175}

Review the changes that are included in version 1.7.5 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.4 
**Current version** 1.7.5  
**Updates in this version** 
See the Istio release notes for [Istio 1.7.5](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.5/){: external}.


### Changelog for 1.7.4, released 5 November 2020
{: #174}

Review the changes that are included in version 1.7.4 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.3 
**Current version** 1.7.4  
**Updates in this version** 
- See the Istio release notes for [Istio 1.7.4](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.4/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-26116](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26116){: external}
    - [usn-4581-1](https://ubuntu.com/security/notices/USN-4581-1){: external} 


### Changelog for 1.7.3, released 06 October 2020
{: #173}

Review the changes that are included in version 1.7.3 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.2 
**Current version** 1.7.3  
**Updates in this version**  
- See the Istio release notes for [Istio 1.7.3](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.3/){: external}. 
- Updates Prometheus to version 2.21.0 and Jaeger to version 1.20.0. Note that these components are deprecated in version 1.7 of the Istio add-on and are automatically removed in [version 1.8 of the Istio add-on](https://istio.io/latest/docs/ops/integrations/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-25017](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25017){: external}
    - [CVE-2018-7738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7738){: external}
    - [usn-4512-1](https://ubuntu.com/security/notices/USN-4512-1){: external}. 
- For more information, see the [Istio security bulletin 2020-010](https://istio.io/latest/news/security/istio-security-2020-010/){: external}.  


### Changelog for 1.7.2, released 23 September 2020
{: #172}

Review the changes that are included in version 1.7.2 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.1 
**Current version** 1.7.2  
**Updates in this version**  
See the Istio release notes for [Istio 1.7.2](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.2/){: external}.


### Changelog for 1.7.1, released 14 September 2020
{: #171}

Review the changes that are included in version 1.7.1 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.7.0 
**Current version** 1.7.1  
**Updates in this version**  
See the Istio release notes for [Istio 1.7.1](https://istio.io/latest/news/releases/1.7.x/announcing-1.7.1/){: external}. 

### Changelog for 1.7.0, released 02 September 2020
{: #170}

Review the changes that are included in version 1.7.0 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.8 
**Current version** 1.7.0  
**Updates in this version**  
- See the Istio release notes for [Istio 1.7](https://istio.io/latest/news/releases/1.7.x/announcing-1.7/){: external}. 
- All `istio-monitoring` support is deprecated in version 1.7 of the Istio add-on and is automatically removed in version 1.8 of the Istio add-on. To use monitoring with Istio, you must install the components separately from the Istio add-on. 
- For more information, see the [Istio documentation](https://istio.io/latest/docs/ops/integrations/){: external}. 
- The `istio-ingressgateway-public-(n)-enabled` and `istio-ingressgateway-zone-(n)` options in the [`managed-istio-custom` configmap resource](/docs/containers?topic=containers-istio#customize) are generally available for production use. 
  
  
  
  
## Version 1.6 (unsupported)
{: #v16}

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

### Changelog for 1.6.14, released 3 December 2020
{: #1614}

Review the changes that are included in version 1.6.14 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.13  
**Current version** 1.6.14  
**Updates in this version** 
- See the Istio release notes for [Istio 1.6.14](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.14/){: external}. 
- Resolves [CVE-2020-28196](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28196){: external}. 

### Changelog for 1.6.13, released 5 November 2020
{: #1613}

Review the changes that are included in version 1.6.13 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.12  
**Current version** 1.6.13  
**Updates in this version** 
- See the Istio release notes for [Istio 1.6.13](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.13/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-26116](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26116){: external}
    - [usn-4581-1](https://ubuntu.com/security/notices/USN-4581-1){: external}.


### Changelog for 1.6.12, released 22 October 2020
{: #1612}

Review the changes that are included in version 1.6.12 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.11  
**Current version** 1.6.12  
**Updates in this version** 
See the Istio release notes for [Istio 1.6.12](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.12/){: external}. 

### Changelog for 1.6.11, released 06 October 2020
{: #1611}

Review the changes that are included in version 1.6.11 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.9  
**Current version** 1.6.11  
**Updates in this version** 
- See the Istio release notes for:
    - [Istio 1.6.10](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.10/){: external}
    - [Istio 1.6.11](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.11/){: external}. 
- Updates Prometheus to version 2.21.0 and Jaeger to version 1.20.0. Note that these components are deprecated in version 1.7 of the Istio add-on and are automatically removed in [version 1.8 of the Istio add-on](https://istio.io/latest/docs/ops/integrations/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-25017](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25017){: external}
    - [CVE-2018-7738](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7738){: external}
    - [usn-4512-1](https://ubuntu.com/security/notices/USN-4512-1){: external}.
- For more information, see the [Istio security bulletin 2020-010](https://istio.io/latest/news/security/istio-security-2020-010/){: external}.


### Changelog for 1.6.9, released 14 September 2020
{: #169}

Review the changes that are included in version 1.6.9 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.8  
**Current version** 1.6.9  
**Updates in this version**  
- See the Istio release notes for [Istio 1.6.9](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.9/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}
    - [usn-4466-1](https://ubuntu.com/security/notices/USN-4466-1){: external}
- For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}.


### Changelog for 1.6.8, released 12 August 2020
{: #168}

Review the changes that are included in version 1.6.8 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.7  
**Current version** 1.6.8  
**Updates in this version**  
- See the Istio release notes for [Istio 1.6.8](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.6/){: external}. 
- Resolves [CVE-2020-16844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16844){: external}. 
- For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}


### Changelog for 1.6.7, released 04 August 2020
{: #167}

Review the changes that are included in version 1.6.7 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6.5  
**Current version** 1.6.7  
**Updates in this version**  
- See the Istio release notes for:
    - [Istio 1.6.6](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.6/){: external}
    - [Istio 1.6.7](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.7/){: external}
- Resolves the following CVEs:
    - [CVE-2019-17514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17514){: external}
    - [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}
    - [CVE-2019-9674](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9674){: external}
    - [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}
    - [usn-4428-1](https://ubuntu.com/security/notices/USN-4428-1){: external}


### Changelog for 1.6.5, released 17 July 2020
{: #165}

Review the changes that are included in version 1.6.5 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.6  
**Current version** 1.6.5  
**Updates in this version**
- See the Istio release notes for [Istio 1.6.5](https://istio.io/latest/news/releases/1.6.x/announcing-1.6.5/){: external}. 
- Resolves the following CVEs:
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
- For more information, see the [Istio security bulletin 2020-008](https://istio.io/latest/news/security/istio-security-2020-008/){: external}


### Changelog for 1.6, released 08 July 2020
{: #16}

Review the changes that are included in version 1.6 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.7  
**Current version** 1.6  
- See the Istio release notes for [Istio 1.6](https://istio.io/latest/news/releases/1.6.x/announcing-1.6/){: external}. 
- Support is added for the `istio-knative-cluster-local-gateway-enabled` and `istio-monitoring-telemetry` options in the [`managed-istio-custom` configmap resource](/docs/containers?topic=containers-istio#customize). You can use these options to manage inclusion of Knative apps in the service mesh and the Istio telemetry enablement. Support for {{site.data.keyword.mon_full_notm}} is enabled for Istio by default.
  
  
  


## Version 1.5 (unsupported)
{: #v15}

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
| `prometheus.enabled: false` | In the managed Istio add-on, the Prometheus, Grafana, Jaeger, and Kiali monitoring components are disabled by default due to current security concerns in the community release of Istio that cannot be adequately addressed for a production environment. |
| `values.global.pilot.enableProtocolSniffingForInbound` and `values.global.pilot.enableProtocolSniffingForOutbound` | In the managed Istio add-on, protocol sniffing is disabled by default until the feature becomes more stable in the community Istio.

### Changelog for 1.5.10, released 1 September 2020
{: #1510}

Review the changes that are included in version 1.5.10 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.9  
**Current version** 1.5.10  
**Updates in this version**
See the Istio release notes for [Istio 1.5.10](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.10/){: external}.


### Changelog for 1.5.9, released 12 August 2020
{: #159}

Review the changes that are included in version 1.6.8 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.8  
**Current version** 1.5.9  
- See the Istio release notes for [Istio 1.5.9](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.9/){: external}. 
- Resolves the following CVEs:
    - [CVE-2019-17514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17514){: external}
    - [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}
    - [CVE-2019-9674](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9674){: external}
    - [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}
    - [CVE-2020-16844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16844){: external}
    - [usn-4428-1](https://ubuntu.com/security/notices/USN-4428-1){: external}. 
- For more information, see the [Istio security bulletin 2020-009](https://istio.io/latest/news/security/istio-security-2020-009/){: external}.


### Changelog for 1.5.8, released 16 July 2020
{: #158}

Review the changes that are included in version 1.5.8 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.7  
**Current version** 1.5.8  
**Updates in this version**  
- See the Istio release notes for [Istio 1.5.8](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.8/){: external}. 
- Resolves the following CVEs:
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
- For more information, see the [Istio security bulletin 2020-008](https://istio.io/latest/news/security/istio-security-2020-008/){: external}. 


### Changelog for 1.5.7, released 8 July 2020
{: #157}

Review the changes that are included in version 1.5.7 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.6  
**Current version** 1.5.7  
**Updates in this version**  
- See the Istio release notes for [Istio 1.5.7](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.7/){: external}. 
- Resolves the following CVEs:
    - [CVE-2020-12603](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12603){: external}
    - [CVE-2020-12605](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12605){: external}
    - [CVE-2020-8663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8663){: external}
    - [CVE-2020-12604](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12604){: external}
    - [CVE-2020-8169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8169){: external}
    - [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}
    - [usn-4402-1](https://ubuntu.com/security/notices/USN-4402-1){: external}
- For more information, see the [Istio security bulletin 2020-007](https://istio.io/latest/news/security/istio-security-2020-007/){: external}. 


### Changelog for 1.5.6, released 23 June 2020
{: #156}

Review the changes that are included in version 1.5.6 of the managed Istio add-on.
{: shortdesc}

**Previous version** 1.5.4  
**Current version** 1.5.6  
**Updates in this version**  
- See the Istio release notes for [Istio 1.5.5](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.6/){: external} and [Istio 1.5.6](https://istio.io/latest/news/releases/1.5.x/announcing-1.5.6/){: external}. 
- Resolves the following CVEs:
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
- For more information, see the [Istio security bulletin 2020-006](https://istio.io/latest/news/security/istio-security-2020-006/){: external}

### Changelog for 1.5, released 19 May 2020
{: #15}

Review the changes that are included in version 1.5 of the managed Istio add-on.
{: shortdesc}

Version 1.5 of the Istio add-on is supported for clusters that run Kubernetes versions 1.17 only.
{: note}

**Previous version** 1.4.9  
**Current version** 1.5  
**Updates in this version**  
- See the Istio release notes for [Istio 1.5](https://istio.io/latest/news/releases/1.5.x/announcing-1.5/change-notes/){: external}. 
- The Citadel secret discovery service (SDS) is now enabled by default to provide identity provisioning and certification for workloads in the service mesh. [With the `managed-istio-custom` configmap resource, you can customize a set of Istio configuration options](/docs/containers?topic=containers-istio#customize). These settings include extra control over monitoring, logging, and networking in your control plane and service mesh. Beta: By default, one public Istio load balancer, `istio-ingressgateway`, is enabled in your cluster. To achieve higher availability, you can now enable an Istio load balancer in each zone of your cluster. For more information, see [Enabling or disabling public Istio load balancers](/docs/containers?topic=containers-istio-mesh#config-gateways). The Prometheus, Grafana, Jaeger, and Kiali monitoring components are disabled by default due to current security concerns in the community release of Istio that cannot be adequately addressed for a production environment. If you use {{site.data.keyword.mon_full_notm}} to monitor your Istio-managed apps, update the `sysdig-agent` configmap so that sidecar metrics are tracked. Changes cannot be made to the Kiali dashboard in view-only mode by default. You can change this setting by [editing the `managed-istio-custom` configmap](/docs/containers?topic=containers-istio#customize). Your cluster must have a secret with credentials to Grafana to access the Grafana dashboard. 
  
  
  

## Version 1.4 (unsupported)
{: #v14}

## Changelog for 1.4.9, released 18 May 2020
{: #149}

Review the changes that are included in version 1.4.9 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.8  
**Current version**: 1.4.9  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.9](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.9/){:external}. 
- Resolves the following CVEs:
    - [CVE-2019-18348](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18348){: external}
    - [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}
    - [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492){: external}
    - [usn-4359-1](https://ubuntu.com/security/notices/USN-4359-1/){: external}
    - [usn-4333-1](https://ubuntu.com/security/notices/USN-4333-1/){: external}
- For more information, see the [Istio security bulletin](https://istio.io/latest/news/security/istio-security-2020-005/){: external}

## Changelog for 1.4.8, released 30 April 2020
{: #148}

Review the changes that are included in version 1.4.8 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.7  
**Current version**: 1.4.8  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.8](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.8/){:external}. 
- Resolves the following CVEs:
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

## Changelog for 1.4.7, released 01 April 2020
{: #147}

Review the changes that are included in version 1.4.7 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.6  
**Current version**: 1.4.7  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.7](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.7/){:external}. 
- Resolves the following CVEs:
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

## Changelog for 1.4.6, released 09 March 2020
{: #146}

Review the changes that are included in version 1.4.6 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.5  
**Current version**: 1.4.6  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.6](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.6/){:external}. 
- Resolves the following CVEs:
    - [CVE-2020-8659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8659){: external}
    - [CVE-2020-8660](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8660){: external}
    - [CVE-2020-8661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8661){: external}
    - [CVE-2020-8664](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8664){: external}

## Changelog for 1.4.5, released 21 February 2020
{: #145}

Review the changes that are included in version 1.4.5 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.4  
**Current version**: 1.4.5  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.5](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.5/){:external}. 
- Resolves the following CVEs:
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

## Changelog for 1.4.4, released 14 February 2020
{: #144}

Review the changes that are included in version 1.4.4 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.3  
**Current version**: 1.4.4  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.4](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.4/){:external}. 
- Disables [protocol sniffing and detection](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/).
- Improves the termination sequence for rolling updates of ingress and egress gateways. 
- Resolves the following CVEs:
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
- For more information, see the [Istio security bulletin 2020-001](https://istio.io/latest/news/security/istio-security-2020-001/){: external}

## Changelog for 1.4.3, released 16 January 2020
{: #143}

Review the changes that are included in version 1.4.3 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.2  
**Current version**: 1.4.3  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.3](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.3/){:external}. 
- Disables [protocol sniffing and detection](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/).
- Improves the termination sequence for rolling updates of ingress and egress gateways. 

## Changelog for 1.4.2, released 16 December 2020
{: #142}

Review the changes that are included in version 1.4.2 of the managed Istio add-on.
{: shortdesc}

**Previous version**: 1.4.0  
**Current version**: 1.4.2  
**Updates in this version:**  
- See the Istio release notes for [Istio 1.4.1](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.1/){:external}. 
- See the Istio release notes for [Istio 1.4.2](https://istio.io/latest/news/releases/1.4.x/announcing-1.4.2/){:external}. 
- Resolves the following CVEs:
    - [CVE-2019-18801](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18801){: external}
    - [CVE-2019-18802](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18802){: external}
    - [CVE-2019-18838](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18838){: external}
- For more information, see the [Istio security bulletin](https://istio.io/latest/news/security/istio-security-2019-007/){: external}.
  



