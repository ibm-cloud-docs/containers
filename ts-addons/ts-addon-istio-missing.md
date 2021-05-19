---

copyright:
  years: 2014, 2021
lastupdated: "2021-05-17"

keywords: kubernetes, iks, help

subcollection: containers
content-type: troubleshoot

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
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
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
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
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
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
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
  

# Why are Istio components missing?
{: #istio_control_plane}

**Infrastructure provider**:
  * <img src="../images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic
  * <img src="../images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC

{: tsSymptoms}
One or more of the Istio control plane components, such as `istiod`, does not exist in your cluster.

{: tsCauses}
* You deleted one of the Istio deployments that is installed in your cluster Istio managed add-on.
* You changed the default `IstioOperator` resource. When you enable the managed Istio add-on, you cannot use `IstioOperator` (`iop`) resources to customize the Istio control plane installation. Only the `IstioOperator` resources that are managed by IBM for the Istio control plane are supported. Changing the control plane settings might result in an unsupported control plane state. If you create an `IstioOperator` resource for custom gateways in your Istio data plane, you are responsible for managing those resources.

{: tsResolve}
To verify the control plane components installation:

1. Check the values of any customizations that you specified in the customization configmap. For example, if the value of the `istio-components-pilot-requests-cpu` setting is too high, control plane components might not be scheduled.
  ```
  kubectl describe cm managed-istio-custom -n ibm-operators
  ```sh
  {: pre}

2. Check the logs of the Istio operator. If any logs indicate that the operator is failing to reconcile your customization settings, verify your settings for the [customized Istio installation](/docs/containers?topic=containers-istio#customize) again.
  ```
  kubectl logs -n ibm-operators -l name=managed-istio-operator
  ```
  {: pre}

3. Optional: To refresh your `managed-istio-custom` configmap resource, delete the configmap from your cluster. After about 5 minutes, a default configmap that contains the original installation settings is created in your cluster. The Istio operator reconciles the installation of Istio to the original add-on settings, including the core components of the Istio control plane.
  ```sh
  kubectl delete cm managed-istio-custom -n ibm-operators
  ```
  {: pre}

4. If Istio control plane components or other Istio resources are still unavailable, refresh the cluster master.
  ```sh
  ibmcloud ks cluster master refresh -c <cluster_name_or_ID>
  ```
  {: pre}
