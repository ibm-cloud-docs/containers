---

copyright:
  years: 2014, 2025
lastupdated: "2025-09-05"


keywords: kubernetes, envoy, sidecar, mesh, bookinfo, istio

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# About the managed Istio add-on
{: #istio-about}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}

With one click, you can get all Istio core components up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on so that {{site.data.keyword.cloud_notm}} automatically keeps all your Istio components up-to-date.

## What is Istio?
{: #istio_ov_what_is}

[Istio](https://www.ibm.com/products/istio){: external} is an open service mesh platform to connect, secure, control, and observe microservices on cloud platforms such as Kubernetes in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

When you shift monolith applications to a distributed microservice architecture, a set of new challenges arises such as how to control the traffic of your microservices, do dark launches and canary rollouts of your services, handle failures, secure the service communication, observe the services, and enforce consistent access policies across the fleet of services. To address these difficulties, you can leverage a service mesh. A service mesh provides a transparent and language-independent network for connecting, observing, securing, and controlling the connectivity between microservices. Istio provides insights and control over the service mesh by so that you can manage network traffic, load balance across microservices, enforce access policies, verify service identity, and more.

For example, using Istio in your microservice mesh can help you:
- Achieve better visibility into the apps that run in your cluster.
- Deploy canary versions of apps and control the traffic that is sent to them.
- Enable automatic encryption of data that is transferred between microservices.

An Istio service mesh is composed of two main components, a data plane and a control plane. 

Data plane
:   The data plane consists of your applications, the sidecars that are injected into your application pods, the gateways, and data plane configuration resources like `ServiceEntries`, `VirtualServices`, `Gateways`, `DestinationRules`, `EnvoyFilters`, and more. You are responsible for configuring your service mesh, updating your sidecars and custom gateways on a patch update, and upgrading the add-on as newer versions are released.

Control plane
:   The control plane consists of the Istio operator, the managed Istio Operator, and `Istiod` which contains Pilot, Mixer telemetry and policy, and Citadel components. For more information about each of these components, see the [`istio` add-on description](#istio_ov_components). {{site.data.keyword.cloud_notm}} manages the control plane by providing patch updates, resolving vulnerabilities, and reconciling the managed resources.


## What is Istio on {{site.data.keyword.containerlong_notm}}?
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on that integrates Istio directly with your Kubernetes cluster.
{: shortdesc}

### What does this look like in my cluster?
{: #istio-addon-resources}

When you install the Istio add-on, the Istio control and data planes use the network interfaces that your cluster is already connected to. Configuration traffic flows over the private network within your cluster, and does not require you to open any additional ports or IP addresses in your firewall. If you expose your Istio-managed apps with an Istio Gateway, external traffic requests to the apps flow over the public network interface.

### How does the update process work?
{: #istio-addon-update}

The Istio version in the managed add-on is tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}. Additionally, the Istio add-on simplifies the maintenance of your Istio control plane so you can focus on managing your microservices. {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. To update your Istio components to the most recent minor version of Istio that is supported by {{site.data.keyword.containerlong_notm}}, such as from Istio version 1.6 to 1.7, you can follow the steps in [Updating the minor version of the Istio add-on](/docs/containers?topic=containers-istio-update#istio_minor).

Whenever the managed Istio add-on is updated, make sure that you [update your `istioctl` client and the Istio sidecars for your app](/docs/containers?topic=containers-istio-update#update_client_sidecar) to match the Istio version of the add-on. You can check whether the versions of your `istioctl` client and the Istio add-on control plane match by running `istioctl version`.

If you need to use the latest version of Istio or customize your Istio installation, you can install the open source version of Istio by following the steps in the [Quick Start with {{site.data.keyword.cloud_notm}} tutorial](https://istio.io/latest/docs/setup/platform-setup/ibm/){: external}. However, note that you can't run community Istio concurrently with the managed Istio add-on in your cluster.
{: note}


## What comes with the Istio add-on?
{: #istio_ov_components}

In Kubernetes clusters, you can install the generally available managed Istio add-on, which runs Istio version 1.23.5.
{: shortdesc}

The Istio add-on installs the core components of Istio. For more information about any of the following control plane components, see the [Istio documentation](https://istio.io/latest/about/service-mesh/){: external}.
* `Envoy` proxies inbound and outbound traffic for all services in the mesh. Envoy is deployed as a sidecar container in the same pod as your app container.
* `istiod` unifies functionality that Pilot, Galley, Citadel, and the sidecar injector previously performed into a single control plane package.
* The `istio-ingressgateway` and `istio-egressgateway` control incoming traffic to and outgoing traffic from your Istio-managed apps.
* The Istio operator (`addon-istio-operator` in Istio version 1.10 or later, or `managed-istio-operator` in Istio version 1.9 or earlier) in the `ibm-operators` namespace validates and reconciles any custom Istio operator (IOP) changes that you make.


## Limitations
{: #istio_limitations}

Review the following limitations for the managed Istio add-on.
{: shortdesc}

* When you enable the managed Istio add-on, you can't use `IstioOperator` (IOP) resources to customize the Istio control plane installation. Only the `IstioOperator` resources that are managed by IBM for the Istio control plane are supported. If you create an `IstioOperator` resource for custom gateways in your Istio data plane, you are responsible for managing those resources.
* You can't modify any Istio resources that are created for you in the `istio-system` namespace. If you need to customize the Istio installation, you can [edit the `managed-istio-custom` configmap resource](/docs/containers?topic=containers-istio#customize).
* The following features are not supported in the managed Istio add-on:
    * [Any features by the community that are in alpha release stages](https://istio.io/latest/docs/releases/feature-stages/){: external}
