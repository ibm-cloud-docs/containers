---

copyright:
  years: 2014, 2021
lastupdated: "2021-02-04"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

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



# About the managed Istio add-on
{: #istio-about}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}

With one click, you can get all Istio core components up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on so that {{site.data.keyword.cloud_notm}} automatically keeps all your Istio components up-to-date.

## What is Istio?
{: #istio_ov_what_is}

[Istio](https://www.ibm.com/cloud/istio){: external} is an open service mesh platform to connect, secure, control, and observe microservices on cloud platforms such as Kubernetes in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

When you shift monolith applications to a distributed microservice architecture, a set of new challenges arises such as how to control the traffic of your microservices, do dark launches and canary rollouts of your services, handle failures, secure the service communication, observe the services, and enforce consistent access policies across the fleet of services. To address these difficulties, you can leverage a service mesh. A service mesh provides a transparent and language-independent network for connecting, observing, securing, and controlling the connectivity between microservices. Istio provides insights and control over the service mesh by so that you can manage network traffic, load balance across microservices, enforce access policies, verify service identity, and more.

For example, using Istio in your microservice mesh can help you:
- Achieve better visibility into the apps that run in your cluster.
- Deploy canary versions of apps and control the traffic that is sent to them.
- Enable automatic encryption of data that is transferred between microservices.

An Istio service mesh is composed of a data plane and a control plane. The data plane consists of Envoy proxy sidecars in each app pod, which mediate communication between microservices. The control plane consists of Pilot, Mixer telemetry and policy, and Citadel, which apply Istio configurations in your cluster. For more information about each of these components, see the [`istio` add-on description](#istio_ov_components).

<br />

## What is Istio on {{site.data.keyword.containerlong_notm}}?
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on that integrates Istio directly with your Kubernetes cluster.
{: shortdesc}

**What does this look like in my cluster?**

When you install the Istio add-on, the Istio control and data planes use the network interfaces that your cluster is already connected to. Configuration traffic flows over the private network within your cluster, and does not require you to open any additional ports or IP addresses in your firewall. If you expose your Istio-managed apps with an Istio Gateway, external traffic requests to the apps flow over the public network interface.

**How does the update process work?**

The Istio version in the managed add-on is tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}. Additionally, the Istio add-on simplifies the maintenance of your Istio control plane so you can focus on managing your microservices. {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. To update your Istio components to the most recent minor version of Istio that is supported by {{site.data.keyword.containerlong_notm}}, such as from Istio version 1.6 to 1.7, you can follow the steps in [Updating the minor version of the Istio add-on](/docs/containers?topic=containers-istio#istio_minor).

Whenever the managed Istio add-on is updated, make sure that you [update your `istioctl` client and the Istio sidecars for your app](/docs/containers?topic=containers-istio#update_client_sidecar) to match the Istio version of the add-on. You can check whether the versions of your `istioctl` client and the Istio add-on control plane match by running `istioctl version`.

If you need to use the latest version of Istio or customize your Istio installation, you can install the open source version of Istio by following the steps in the [Quick Start with {{site.data.keyword.cloud_notm}} tutorial](https://istio.io/latest/docs/setup/platform-setup/ibm/){: external}. However, note that you cannot run community Istio concurrently with the managed Istio add-on in your cluster.
{: note}

<br />

## What comes with the Istio add-on?
{: #istio_ov_components}

In Kubernetes clusters, you can install the generally available managed Istio add-on, which runs Istio version 1.8.2.
{: shortdesc}

The Istio add-on installs the core components of Istio. For more information about any of the following control plane components, see the [Istio documentation](https://istio.io/latest/docs/concepts/what-is-istio/){: external}.
* `Envoy` proxies inbound and outbound traffic for all services in the mesh. Envoy is deployed as a sidecar container in the same pod as your app container.
* `istiod` unifies functionality that Pilot, Galley, Citadel, and the sidecar injector previously performed into a single control plane package.
* `istio-ingressgateway` and `istio-egressgateway` control incoming traffic to and outgoing traffic from your Istio-managed apps.

<br />

## Limitations
{: #istio_limitations}

Review the following limitations for the managed Istio add-on.
{: shortdesc}

* When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane installation. Only the `IstioControlPlane` resources that are managed by IBM are supported.
* You cannot modify any Istio resources that are created for you in the `istio-system` namespace. If you need to customize the Istio installation, you can [edit the `managed-istio-custom` configmap resource](/docs/containers?topic=containers-istio#customize).
* The following features are not supported in the managed Istio add-on:
  * [Any features by the community that are in alpha release stages](https://istio.io/latest/about/feature-stages/){: external}
