---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-04"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}

# Using the managed Istio add-on
{: #istio}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}

With one click, you can get all Istio core components and additional tracing, monitoring, and visualization up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on, so {{site.data.keyword.cloud_notm}} automatically keeps all your Istio components up-to-date.

The Istio managed add-on is generally available for Kubernetes version 1.16 and later clusters as of 19 November 2019. In Kubernetes version 1.16 or later clusters, you can [update your add-on to the latest version](#istio_update) by uninstalling the Istio version 1.3 or earlier add-on and installing the Istio version 1.4 add-on.
{: important}

## Understanding Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_ov}

### What is Istio?
{: #istio_ov_what_is}

[Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/istio) is an open service mesh platform to connect, secure, control, and observe microservices on cloud platforms such as Kubernetes in {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

When you shift monolith applications to a distributed microservice architecture, a set of new challenges arises such as how to control the traffic of your microservices, do dark launches and canary rollouts of your services, handle failures, secure the service communication, observe the services, and enforce consistent access policies across the fleet of services. To address these difficulties, you can leverage a service mesh. A service mesh provides a transparent and language-independent network for connecting, observing, securing, and controlling the connectivity between microservices. Istio provides insights and control over the service mesh by so that you can manage network traffic, load balance across microservices, enforce access policies, verify service identity, and more.

For example, using Istio in your microservice mesh can help you:
- Achieve better visibility into the apps that run in your cluster.
- Deploy canary versions of apps and control the traffic that is sent to them.
- Enable automatic encryption of data that is transferred between microservices.
- Enforce rate limiting and attribute-based whitelist and blacklist policies.

An Istio service mesh is composed of a data plane and a control plane. The data plane consists of Envoy proxy sidecars in each app pod, which mediate communication between microservices. The control plane consists of Pilot, Mixer telemetry and policy, and Citadel, which apply Istio configurations in your cluster. For more information about each of these components, see the [`istio` add-on description](#istio_install).

### What is Istio on {{site.data.keyword.containerlong_notm}}?
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on that integrates Istio directly with your Kubernetes cluster.
{: shortdesc}

**What does this look like in my cluster?**</br>
When you install the Istio add-on, the Istio control and data planes use the network interfaces that your cluster is already connected to. Configuration traffic flows over the private network within your cluster, and does not require you to open any additional ports or IP addresses in your firewall. If you expose your Istio-managed apps with an Istio Gateway, external traffic requests to the apps flow over the public network interface.

**How does the update process work?**</br>
The Istio version in the managed add-on is tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}. Additionally, the Istio add-on simplifies the maintenance of your Istio control plane so you can focus on managing your microservices. {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio supported by {{site.data.keyword.containerlong_notm}}.

If you need to use the latest version of Istio or customize your Istio installation, you can install the open source version of Istio by following the steps in the [Quick Start with {{site.data.keyword.cloud_notm}} tutorial ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/platform-setup/ibm/).
{: tip}

<br />


## Installing the Istio add-on
{: #istio_install}

Install the Istio managed add-on in an existing cluster.
{: shortdesc}

### Kubernetes version 1.16 and later clusters
{: #install_116}

In Kubernetes version 1.16 and later clusters, you can install the generally available managed Istio add-on, which runs Istio version 1.4.
{: shortdesc}

The Istio add-on installs the core components of Istio. For more information about any of the following control plane components, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/concepts/what-is-istio/).
* `Envoy` proxies inbound and outbound traffic for all services in the mesh. Envoy is deployed as a sidecar container in the same pod as your app container.
* `Mixer` provides telemetry collection and policy controls.
  * Telemetry pods are enabled with a Prometheus endpoint, which aggregates all telemetry data from the Envoy proxy sidecars and services in your app pods.
  * Policy pods enforce access control, including rate limiting and applying whitelist and blacklist policies.
* `Pilot` provides service discovery for the Envoy sidecars and configures the traffic management routing rules for sidecars.
* `Citadel` uses identity and credential management to provide service-to-service and end-user authentication.
* `Galley` validates configuration changes for the other Istio control plane components.

To provide extra monitoring, tracing, and visualization for Istio, the add-on also installs [Prometheus ![External link icon](../icons/launch-glyph.svg "External link icon")](https://prometheus.io/), [Grafana ![External link icon](../icons/launch-glyph.svg "External link icon")](https://grafana.com/), [Jaeger ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.jaegertracing.io/), and [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/).

**Before you begin**</br>
* Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
* [Create a standard Kubernetes version 1.16 or later cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b3c.4x16`) or more](/docs/containers?topic=containers-clusters#clusters_ui). To use an existing cluster, you must update both the [cluster master to version 1.16](/docs/containers?topic=containers-update#master) and the [worker nodes to version 1.16](/docs/containers?topic=containers-update#worker_node).
* If you use an existing cluster and you previously installed Istio in the cluster by using the IBM Helm chart or through another method, [clean up that Istio installation](#istio_uninstall_other).
* In multizone clusters, ensure that you enable a [Virtual Router Function (VRF)](/docs/resources?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure account. To enable VRF, [contact your IBM Cloud infrastructure account representative](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).

**To use the {{site.data.keyword.cloud_notm}} console:**

1. In your [cluster dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/clusters), click the name of the cluster where you want to install the Istio add-ons.

2. Click the **Add-ons** tab.

3. On the Managed Istio card, click **Install**.

4. Click **Install** again.

5. On the Managed Istio card, verify that the add-on is listed.

**To use the CLI:**

1. [Target the CLI to your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

2. Enable the `istio` add-on. The default version of the generally available Istio managed add-on, 1.4, is installed.
  ```
  ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Verify that the managed Istio add-on is enabled in this cluster.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name                      Version
  istio                     1.4.0
  ```
  {: screen}

4. You can also check out the individual components of the add-on to ensure that the Istio services and their corresponding pods are deployed.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

### Kubernetes version 1.15 and earlier clusters
{: #install_115}

In Kubernetes version 1.15 and earlier clusters, you can use only the CLI to install the three beta managed Istio add-ons, which run Istio version 1.3 or earlier.
{: shortdesc}

<dl>
<dt>Istio (`istio`)</dt>
<dd>Installs the core components of Istio, including Prometheus. For more information about any of the following control plane components, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/concepts/what-is-istio/).
  <ul><li>`Envoy` proxies inbound and outbound traffic for all services in the mesh. Envoy is deployed as a sidecar container in the same pod as your app container.</li>
  <li>`Mixer` provides telemetry collection and policy controls.<ul>
    <li>Telemetry pods are enabled with a Prometheus endpoint, which aggregates all telemetry data from the Envoy proxy sidecars and services in your app pods.</li>
    <li>Policy pods enforce access control, including rate limiting and applying whitelist and blacklist policies.</li></ul>
  <li>`Pilot` provides service discovery for the Envoy sidecars and configures the traffic management routing rules for sidecars.</li>
  <li>`Citadel` uses identity and credential management to provide service-to-service and end-user authentication.</li>
  <li>`Galley` validates configuration changes for the other Istio control plane components.</li>
</ul></dd>
<dt>Istio extras (`istio-extras`)</dt>
<dd>Optional: Installs [Grafana ![External link icon](../icons/launch-glyph.svg "External link icon")](https://grafana.com/), [Jaeger ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.jaegertracing.io/), and [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/) to provide extra monitoring, tracing, and visualization for Istio.</dd>
<dt>BookInfo sample app (`istio-sample-bookinfo`)</dt>
<dd>Optional: Deploys the [BookInfo sample application for Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/examples/bookinfo/). This deployment includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.</dd>
</dl>

**Before you begin**</br>
* Ensure that you have the [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for {{site.data.keyword.containerlong_notm}}.
* [Create or use an existing standard Kubernetes version 1.15 or earlier cluster with at least 3 worker nodes that each have 4 cores and 16 GB memory (`b3c.4x16`) or more](/docs/containers?topic=containers-clusters#clusters_ui). Additionally, the cluster and worker nodes must run at least the minimum supported version of Kubernetes, which you can review by running `ibmcloud ks addon-versions --addon istio`.
* If you use an existing cluster and you previously installed Istio in the cluster by using the IBM Helm chart or through another method, [clean up that Istio installation](#istio_uninstall_other).
* In multizone clusters, ensure that you enable a [Virtual Router Function (VRF)](/docs/resources?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure account. To enable VRF, [contact your IBM Cloud infrastructure account representative](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).

To enable the Istio add-on:

1. [Target the CLI to your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

2. Enable the `istio` add-on and optionally the `istio-extras` and `istio-sample-bookinfo` add-ons.
  * `istio`:
    ```
    ibmcloud ks cluster addon enable istio --version 1.3.4 --cluster <cluster_name_or_ID>
    ```
    {: pre}
  * `istio-extras`:
    ```
    ibmcloud ks cluster addon enable istio-extras --cluster <cluster_name_or_ID>
    ```
    {: pre}
  * `istio-sample-bookinfo`:
    ```
    ibmcloud ks cluster addon enable istio-sample-bookinfo --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. Verify that the managed Istio add-ons that you installed are enabled in this cluster.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name                      Version
  istio                     1.3.4* (1.4 latest)
  istio-extras              1.3.4
  istio-sample-bookinfo     1.3.4
  ```
  {: screen}

4. You can also check out the individual components of each add-on in your cluster.
  - Components of `istio` and `istio-extras`: Ensure that the Istio services and their corresponding pods are deployed.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

  - Components of `istio-sample-bookinfo`: Ensure that the BookInfo microservices and their corresponding pods are deployed.
    ```
    kubectl get svc -n default
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
    ```
    {: screen}

    ```
    kubectl get pods -n default
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

<br />


## Trying out the BookInfo sample app
{: #istio_bookinfo}

The [BookInfo sample application for Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/examples/bookinfo/) includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.
{: shortdesc}

In Istio version 1.4 and later, BookInfo is not offered as a managed add-on and must be installed separately. To install BookInfo, see [Setting up the BookInfo sample app](#bookinfo_setup).
{: note}

The four BookInfo microservices include:
* `productpage` calls the `details` and `reviews` microservices to populate the page.
* `details` contains book information.
* `ratings` contains book ranking information that accompanies a book review.
* `reviews` contains book reviews and calls the `ratings` microservice. The `reviews` microservice has multiple versions:
  * `v1` does not call the `ratings` microservice.
  * `v2` calls the `ratings` microservice and displays ratings as 1 to 5 black stars.
  * `v3` calls the `ratings` microservice and displays ratings as 1 to 5 red stars.

The deployment YAMLs for each of these microservices are modified so that Envoy sidecar proxies are pre-injected as containers into the microservices' pods before they are deployed. For more information about manual sidecar injection, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/). The BookInfo app is also already exposed on a public IP address by an Istio Gateway. Although the BookInfo app can help you get started, the app is not meant for production use.

### Setting up the BookInfo sample app
{: #bookinfo_setup}

1. Install BookInfo in your cluster.
  * **Kubernetes version 1.16 and later clusters**:
    1. Download the latest Istio package for your operating system, which includes the configuration files for the BookInfo app.
      ```
      curl -L https://istio.io/downloadIstio | sh -
      ```
      {: pre}

    2. Navigate to the Istio package directory.
      ```
      cd istio-1.4.0
      ```
      {: pre}
    3. Label the `default` namespace for automatic sidecar injection.
      ```
      kubectl label namespace default istio-injection=enabled
      ```
      {: pre}
    4. Deploy the BookInfo application, gateway, and destination rules.
      ```
      kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
      kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
      kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
      ```
      {: pre}
  * **Kubernetes version 1.15 and earlier clusters**: Install the `istio-sample-bookinfo` managed add-on.
    ```
    ibmcloud ks cluster addon enable istio-sample-bookinfo --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Ensure that the BookInfo microservices and their corresponding pods are deployed.
  ```
  kubectl get svc
  ```
  {: pre}

  ```
  NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
  details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
  kubernetes                ClusterIP      172.21.0.1       <none>         443/TCP          1d
  productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
  ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
  reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
  ```
  {: screen}

  ```
  kubectl get pods
  ```
  {: pre}

  ```
  NAME                                     READY     STATUS      RESTARTS   AGE
  details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
  productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
  ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
  reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
  reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
  reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
  ```
  {: screen}


### Publicly accessing BookInfo
{: #istio_access_bookinfo}

1. Get the public address for your cluster.
    * **Classic clusters**:
      1. Set the Istio ingress host.
         ```
         export INGRESS_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
         ```
         {: pre}

      2. Set the Istio ingress port.
         ```
         export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
         ```
         {: pre}

      3. Create a `GATEWAY_URL` environment variable that uses the Istio ingress host and port.
         ```
         export GATEWAY_URL=$INGRESS_IP:$INGRESS_PORT
         ```
         {: pre}

    * **VPC clusters**: Create a `GATEWAY_URL` environment variable that uses the Istio ingress hostname.
      ```
      export GATEWAY_URL=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
      ```
      {: pre}

2. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

3.  View the BookInfo web page in a browser.

    Mac OS or Linux:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Windows:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

4. Try refreshing the page several times. Different versions of the reviews section round-robin through red stars, black stars, and no stars.

### Exposing BookInfo by using an IBM-provided subdomain
{: #istio_expose_bookinfo}

When you enable the BookInfo add-on in your cluster, the Istio gateway `bookinfo-gateway` is created for you. The gateway uses Istio virtual service and destination rules to configure a load balancer, `istio-ingressgateway`, that publicly exposes the BookInfo app. In the following steps, you create a subdomain for the `istio-ingressgateway` load balancer IP address in classic clusters or the hostname in VPC clusters through which you can publicly access BookInfo.
{: shortdesc}

1. Register the IP address in classic clusters or the hostname in VPC clusters for the `istio-ingressgateway` load balancer by creating a DNS subdomain.
  * Classic:
    ```
    ibmcloud ks nlb-dns create classic --ip $INGRESS_IP --cluster <cluster_name_or_id>
    ```
    {: pre}
  * VPC:
    ```
    ibmcloud ks nlb-dns create vpc-classic --lb-host $GATEWAY_URL --cluster <cluster_name_or_id>
    ```
    {: pre}

2. Verify that the subdomain is created.
  ```
  ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Example output:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

3. In a web browser, open the BookInfo product page.
  ```
  https://<subdomain>/productpage
  ```
  {: codeblock}

4. Try refreshing the page several times. The requests to `https://<subdomain>/productpage` are received by the Istio gateway load balancer. The different versions of the `reviews` microservice are still returned randomly because the Istio gateway manages the virtual service and destination routing rules for microservices.


### Understanding what happened
{: #istio_bookinfo_understanding}

The BookInfo sample demonstrates how three of Istio's traffic management components work together to route ingress traffic to the app.
{: shortdesc}

<dl>
<dt>`Gateway`</dt>
<dd>The `bookinfo-gateway` [Gateway ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/gateway/) describes a load balancer, the `istio-ingressgateway` service in the `istio-system` namespace that acts as the entry point for inbound HTTP/TCP traffic for BookInfo. Istio configures the load balancer to listen for incoming requests to Istio-managed apps on the ports that are defined in the gateway configuration file.
</br></br>To see the configuration file for the BookInfo gateway, run the following command.
<pre class="pre"><code>kubectl get gateway bookinfo-gateway -o yaml</code></pre></dd>

<dt>`VirtualService`</dt>
<dd>The `bookinfo` [`VirtualService` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/virtual-service/) defines the rules that control how requests are routed within the service mesh by defining microservices as `destinations`. In the `bookinfo` virtual service, the `/productpage` URI of a request is routed to the `productpage` host on port `9080`. In this way, all requests to the BookInfo app are routed first to the `productpage` microservice, which then calls the other microservices of BookInfo.
</br></br>To see the virtual service rule that is applied to BookInfo, run the following command.
<pre class="pre"><code>kubectl get virtualservice bookinfo -o yaml</code></pre></dd>

<dt>`DestinationRule`</dt>
<dd>After the gateway routes the request according to virtual service rule, the `details`, `productpage`, `ratings`, and `reviews` [`DestinationRules` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/destination-rule/) define policies that are applied to the request when it reaches a microservice. For example, when you refresh the BookInfo product page, the changes that you see are the result of the `productpage` microservice randomly calling different versions, `v1`, `v2`, and `v3`, of the `reviews` microservice. The versions are selected randomly because the `reviews` destination rule gives equal weight to the `subsets`, or the named versions, of the microservice. These subsets are used by the virtual service rules when traffic is routed to specific versions of the service.
</br></br>To see the destination rules that are applied to BookInfo, run the following command.
<pre class="pre"><code>kubectl describe destinationrules</code></pre></dd>
</dl>

</br>

<br />


## Logging, monitoring, tracing, and visualizing Istio
{: #istio_health}

To log, monitor, trace, and visualize your apps that are managed by Istio on {{site.data.keyword.containerlong_notm}}, you can launch the Grafana, Jaeger, and Kiali dashboards or deploy LogDNA and Sysdig as third-party services to your worker nodes. You can also launch ControlZ and Envoy dashboards to inspect the performance of the core Istio components, such as Galley, Pilot, Mixer, and Envoy.
{: shortdesc}

### Launching the Prometheus, Grafana, Jaeger, and Kiali dashboards
{: #istio_health_extras}

For extra monitoring, tracing, and visualization of Istio, launch the [Prometheus ![External link icon](../icons/launch-glyph.svg "External link icon")](https://prometheus.io/), [Grafana ![External link icon](../icons/launch-glyph.svg "External link icon")](https://grafana.com/), [Jaeger ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.jaegertracing.io/), and [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/) dashboards.
{: shortdesc}

**Before you begin**
* [Install the `istio` managed add-on](#istio_install) in a cluster. If your cluster runs Kubernetes version 1.15 or earlier, you must also [install the `istio-extras` add-on](#install_115).
* Install the `istioctl` client.
  1. Download the `istioctl` client.
    ```
    curl -L https://istio.io/downloadIstio | sh -
    ```
    {: pre}

  2. Navigate to the Istio package directory.
    ```
    cd istio-1.4.0
    ```
    {: pre}

**Promethueus**</br>

1. Send traffic to your service. For example, if you installed BookInfo, curl the product page microservice.
  ```
  curl http://$GATEWAY_URL/productpage
  ```
  {: pre}

2. Access the Prometheus dashboard.
  ```
  istioctl dashboard prometheus
  ```
  {: pre}

3. In Prometheus UI, click **Graph**.

4. In the **Expression** field, enter `istio_requests_total`.

5. Run the query by clicking **Execute**.

</br>
**Grafana**</br>

1. Access the Grafana dashboard.
  ```
  istioctl dashboard grafana
  ```
  {: pre}

2. If you installed BookInfo, the Istio dashboard shows metrics for the traffic that you generated when you refreshed the product page a few times. For more information about using the Istio Grafana dashboard, see [Viewing the Istio Dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/telemetry/metrics/using-istio-dashboard/) in the Istio open source documentation.

</br>
**Jaeger**</br>

1. By default, Istio generates trace spans for 1 out of every 100 requests, which is a sampling rate of 1%. You must send at least 100 requests before the first trace is visible. To send 100 requests to the `productpage` service of BookInfo, run the following command.
  ```
  for i in `seq 1 100`; do curl -s -o /dev/null http://$GATEWAY_URL/productpage; done
  ```
  {: pre}

2. Access the Jaeger dashboard.
  ```
  istioctl dashboard jaeger
  ```
  {: pre}

3. If you installed BookInfo, you can select `productpage` from the **Service** list and click **Find Traces**. Traces for the traffic that you generated when you refreshed the product page a few times are shown. For more information about using Jaeger with Istio, see [Generating traces using the BookInfo sample ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/telemetry/distributed-tracing/#generating-traces-using-the-bookinfo-sample) in the Istio open source documentation.

</br>
**Kiali**</br>

1. Define the credentials that you want to use to access Kiali.
  1. Copy and paste the following command. This command starts a text entry for you to enter a user name, which is then encoded in base64 and stored in the `KIALI_USERNAME` environment variable.
    ```
    KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)
    ```
    {: pre}
  2. Copy and paste the following command. This command starts a text entry for you to enter a passphrase, which is then encoded in base64 and stored in the `KIALI_PASSPHRASE` environment variable.
    ```
    KIALI_PASSPHRASE=$(read -p 'Kiali Passphrase: ' pval && echo -n $pval | base64)
    ```
    {: pre}
  3. Create a file to store the credentials in a Kubernetes secret. Name the file `kiali-secret.yaml`.
      ```
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: Secret
      metadata:
        name: kiali
        namespace: istio-system
        labels:
          app: kiali
      type: Opaque
      data:
        username: $KIALI_USERNAME
        passphrase: $KIALI_PASSPHRASE
      EOF
      ```
      {: pre}

2. Access the Kiali dashboard.
  ```
  istioctl dashboard kiali
  ```
  {: pre}

3. Enter the user name and passphrase that you defined in step 1. For more information about using Kiali to visualize your Istio-managed microservices, see [Generating a service graph ![External link icon](../icons/launch-glyph.svg "External link icon")](https://archive.istio.io/v1.0/docs/tasks/telemetry/kiali/#generating-a-service-graph) in the Istio open source documentation.

### Launching the ControlZ component inspection and Envoy sidecar dashboards
{: #istio_inspect}

To inspect specific components of Istio, launch the [ControlZ ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/ops/diagnostic-tools/controlz/) and [Envoy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/commands/istioctl/#istioctl-dashboard-envoy) dashboards.
{: shortdesc}

The ControlZ dashboard accesses the Istio component ports to provide an interactive view into the internal state of each component. The Envoy dashboard provides configuration information and metrics for an Envoy sidecar proxy that runs in an app pod.

**Before you begin**
* [Install the `istio` managed add-on](#istio_install) in a cluster.
* Install the `istioctl` client.
  1. Download the `istioctl` client.
    ```
    curl -L https://istio.io/downloadIstio | sh -
    ```
    {: pre}

  2. Navigate to the Istio package directory.
    ```
    cd istio-1.4.0
    ```
    {: pre}

**ControlZ**</br>

1. Get the pod name for the Istio component that you want to inspect. You can inspect the component pods for `istio-citadel`, `istio-galley`, `istio-pilot`, `istio-policy`, and `istio-telemetry`.
  ```
  kubectl get pods -n istio-system | grep istio
  ```
  {: pre}

  Example output:
  ```
  NAME                                      READY   STATUS    RESTARTS   AGE
  istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
  istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
  istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
  istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
  istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
  istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
  istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
  istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
  istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
  ```
  {: screen}

2. Access the ControlZ dashboard for that component.
  ```
  istioctl dashboard controlz <component_pod_name>.istio-system
  ```
  {: pre}

</br>
**Envoy**</br>

1. Get the name of the app pod where you want to inspect the Envoy sidecar container.
  ```
  kubectl get pods -n <namespace>
  ```
  {: pre}

2. Access the Envoy dashboard for that pod.
  ```
  istioctl dashboard envoy <pod-name>.<namespace>
  ```
  {: pre}


### Setting up logging with {{site.data.keyword.la_full_notm}}
{: #istio_health_logdna}

Seamlessly manage logs for your app container and the Envoy proxy sidecar container in each pod by deploying LogDNA to your worker nodes to forward logs to {{site.data.keyword.la_full}}.
{: shortdesc}

To use [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-getting-started), you deploy a logging agent to every worker node in your cluster. This agent collects logs with the extension `*.log` and extensionless files that are stored in the `/var/log` directory of your pod from all namespaces, including `kube-system`. These logs include logs from your app container and the Envoy proxy sidecar container in each pod. The agent then forwards the logs to the {{site.data.keyword.la_full_notm}} service.

To get started, set up LogDNA for your cluster by following the steps in [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).




### Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #istio_health_sysdig}

Gain operational visibility into the performance and health of your Istio-managed apps by deploying Sysdig to your worker nodes to forward metrics to {{site.data.keyword.mon_full}}.
{: shortdesc}

With Istio on {{site.data.keyword.containerlong_notm}}, the managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregate all telemetry data for your pods. When you deploy a Sysdig agent to every worker node in your cluster, Sysdig is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.cloud_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy Sysdig in your cluster.

1. Set up Sysdig by following the steps in [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster).

2. [Launch the Sysdig UI ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster_step3).

3. Click **Add new dashboard**.

4. Search for `Istio` and select one of Sysdig's predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the [How to monitor Istio, the Kubernetes service mesh ![External link icon](../icons/launch-glyph.svg "External link icon")](https://sysdig.com/blog/monitor-istio/). Look for the section called "Monitoring Istio: reference metrics and dashboards" blog post.

<br />


## Including apps in the Istio service mesh by setting up sidecar injection
{: #istio_sidecar}

Ready to manage your own apps by using Istio? Before you deploy your app, you must first decide how you want to inject the Envoy proxy sidecars into app pods.
{: shortdesc}

Each app pod must be running an Envoy proxy sidecar so that the microservices can be included in the service mesh. You can make sure that sidecars are injected into each app pod automatically or manually. For more information about sidecar injection, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/).

### Enabling automatic sidecar injection
{: #istio_sidecar_automatic}

When automatic sidecar injection is enabled, a namespace listens for any new deployments and automatically modifies the pod template specification so that app pods are created with Envoy proxy sidecar containers. Enable automatic sidecar injection for a namespace when you plan to deploy multiple apps that you want to integrate with Istio into that namespace. Automatic sidecar injection is not enabled for any namespaces by default in the Istio managed add-on.

To enable automatic sidecar injection for a namespace:

1. Get the name of the namespace where you want to deploy Istio-managed apps.
  ```
  kubectl get namespaces
  ```
  {: pre}

2. Label the namespace as `istio-injection=enabled`.
  ```
  kubectl label namespace <namespace> istio-injection=enabled
  ```
  {: pre}

3. Deploy apps into the labeled namespace, or redeploy apps that are already in the namespace.
  * To deploy an app into the labeled namespace:
    ```
    kubectl apply <myapp>.yaml --namespace <namespace>
    ```
    {: pre}
  * To redeploy an app that is already deployed in that namespace, delete the app pod so that it is redeployed with the injected sidecar.
    ```
    kubectl delete pod -l app=<myapp>
    ```
    {: pre}

5. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/additional-setup/requirements/).

  1. Define a service for the app.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector:
        <selector_key>: <selector_value>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the service YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>Enter the label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) pair that you want to use to target the pods where your app runs.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>The port that the service listens on.</td>
     </tr>
     </tbody></table>

  2. Create the service in your cluster. Ensure that the service deploys into the same namespace as the app.
    ```
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container that runs alongside your app container.

### Manually injecting sidecars
{: #istio_sidecar_manual}

If you do not want to enable automatic sidecar injection for a namespace, you can manually inject the sidecar into a deployment YAML. Inject sidecars manually when apps are running in namespaces alongside other deployments that you do not want sidecars automatically injected into.

**Before you begin**:
1. Download the `istioctl` client.
  ```
  curl -L https://istio.io/downloadIstio | sh -
  ```
  {: pre}

2. Navigate to the Istio package directory.
  ```
  cd istio-1.4.0
  ```
  {: pre}

To manually inject sidecars into a deployment:

1. Inject the Envoy sidecar into your app deployment YAML.
  ```
  istioctl kube-inject -f <myapp>.yaml | kubectl apply -f -
  ```
  {: pre}

2. Deploy your app.
  ```
  kubectl apply <myapp>.yaml
  ```
  {: pre}

3. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/additional-setup/requirements/).

  1. Define a service for the app.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector:
        <selector_key>: <selector_value>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the service YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>Enter the label key (<em>&lt;selector_key&gt;</em>) and value (<em>&lt;selector_value&gt;</em>) pair that you want to use to target the pods where your app runs.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>The port that the service listens on.</td>
     </tr>
     </tbody></table>

  2. Create the service in your cluster. Ensure that the service deploys into the same namespace as the app.
    ```
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container that runs alongside your app container.

<br />


## Exposing Istio-managed apps by using an IBM-provided subdomain
{: #istio_expose}

Publicly expose your Istio-managed apps by creating a DNS entry for the `istio-ingressgateway` load balancer and configuring the load balancer to forward traffic to your app.
{: shortdesc}

In the following steps, you set up a subdomain through which your users can access your app by creating the following resources:
* A gateway that is called `my-gateway`. This gateway acts as the public entry point to your apps and uses the existing `istio-ingressgateway` load balancer service to expose your app. The gateway can optionally be configured for TLS termination.
* A virtual service that is called `my-virtual-service`. `my-gateway` uses the rules that you define in `my-virtual-service` to route traffic to your app.
* A subdomain for the `istio-ingressgateway` load balancer. All user requests to the subdomain are forwarded to your app according to your `my-virtual-service` routing rules.

### Exposing Istio-managed apps without TLS termination
{: #no-tls}

**Before you begin:**

1. [Install the `istio` managed add-on](#istio_install) in a cluster.
2. Install the `istioctl` client.
  1. Download `istioctl`.
    ```
    curl -L https://istio.io/downloadIstio | sh -
    ```
    {: pre}
  2. Navigate to the Istio package directory.
    ```
    cd istio-1.4.0
    ```
    {: pre}
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

**To publicly expose your Istio-managed apps with a subdomain without using TLS:**

1. Create a gateway. This sample gateway uses the `istio-ingressgateway` load balancer service to expose port 80 for HTTP. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. If your microservices listen on a different port than `80`, add that port. For more information about gateway YAML components, see the [Istio reference documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/gateway/).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: my-gateway
    namespace: <namespace>
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: http
        number: 80
        protocol: HTTP
      hosts:
      - '*'
  ```
  {: codeblock}

2. Apply the gateway in the namespace where your Istio-managed microservices are deployed.
  ```
  kubectl apply -f my-gateway.yaml -n <namespace>
  ```
  {: pre}

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/virtual-service/).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: my-virtual-service
    namespace: <namespace>
  spec:
    gateways:
    - my-gateway
    hosts:
    - '*'
    http:
    - match:
      - uri:
          exact: /<service_path>
      route:
      - destination:
          host: <service_name>
          port:
            number: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
  </thead>
  <tbody>
  <tr>
  <td><code>namespace</code></td>
  <td>Replace <em>&lt;namespace&gt;</em> with the namespace where your Istio-managed microservices are deployed.</td>
  </tr>
  <tr>
  <td><code>gateways</code></td>
  <td>The <code>my-gateway</code> is specified so that the gateway can apply these virtual service routing rules to the <code>istio-ingressgateway</code> load balancer.<td>
  </tr>
  <tr>
  <td><code>http.match.uri.exact</code></td>
  <td>Replace <em>&lt;service_path&gt;</em> with the path that your entrypoint microservice listens on. For example, in the BookInfo app, the path is defined as <code>/productpage</code>.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.host</code></td>
  <td>Replace <em>&lt;service_name&gt;</em> with the name of your entrypoint microservice. For example, in the BookInfo app, <code>productpage</code> served as the entrypoint microservice that called the other app microservices.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.port.number</code></td>
  <td>If your microservice listens on a different port, replace <em>&lt;80&gt;</em> with the port.</td>
  </tr>
  </tbody></table>

4. Apply the virtual service rules in the namespace where your Istio-managed microservice is deployed.
  ```
  kubectl apply -f my-virtual-service.yaml -n <namespace>
  ```
  {: pre}

5. Get the subdomain for the `istio-ingressgateway` load balancer.
  * **Classic clusters**: Register a DNS subdomain for the `istio-ingressgateway` load balancer. For more information about registering DNS subdomains in {{site.data.keyword.containerlong_notm}}, including information about setting up custom health checks for subdomains, see [Registering an NLB subdomain](/docs/containers?topic=containers-loadbalancer_hostname).
      1. Get the **EXTERNAL-IP** address for the `istio-ingressgateway` load balancer.
        ```
        kubectl get svc -n istio-system
        ```
        {: pre}

        In the following example output, the **EXTERNAL-IP** is `168.1.1.1`.
        ```
        NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
        ...
        istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   169.1.1.1       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                                  8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
        ```
        {: screen}

      2. Register the `istio-ingressgateway` load balancer IP by creating a DNS subdomain.
        ```
        ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP>
        ```
        {: pre}

      3. Verify that the subdomain is created.
        ```
        ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
        ```
        {: pre}

        Example output:
        ```
        Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
        mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
        ```
        {: screen}

  * **VPC clusters**: The `istio-ingressgateway` load balancer is automatically assigned a hostname instead of an IP address by the VPC load balancer for your cluster. Get the hostname for `istio-ingressgateway` and look for the **EXTERNAL-IP** in the output.
    ```
    kubectl -n istio-system get service istio-ingressgateway -o wide
    ```
    {: pre}
    In this example output, the hostname is `6639a113-us-south.lb.appdomain.cloud`:
    ```
    NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP                            PORT(S)                                                                                                                                      AGE       SELECTOR
    istio-ingressgateway   LoadBalancer   172.21.101.250   6639a113-us-south.lb.appdomain.cloud   15020:32377/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31360/TCP,15030:31563/TCP,15031:32157/TCP,15032:31072/TCP,15443:31458/TCP   20m       app=istio-ingressgateway,istio=ingressgateway,release=istio
    ```
    {: screen}

6. In a web browser, verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.
  ```
  http://<host_name>/<service_path>
  ```
  {: codeblock}

### Exposing Istio-managed apps with TLS termination
{: #tls}

**Before you begin:**

1. [Install the `istio` managed add-on](#istio_install) in a cluster.
2. Install the `istioctl` client.
  1. Download `istioctl`.
    ```
    curl -L https://istio.io/downloadIstio | sh -
    ```
    {: pre}
  2. Navigate to the Istio package directory.
    ```
    cd istio-1.4.0
    ```
    {: pre}
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

**To publicly expose your Istio-managed apps with a subdomain using TLS:**

1. Create a gateway. This sample gateway uses the `istio-ingressgateway` load balancer service to expose port 443 for HTTPS. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. If your microservices listen on a different port than `443`, add that port. For more information about gateway YAML components, see the [Istio reference documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/gateway/).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: my-gateway
    namespace: <namespace>
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: https
        protocol: HTTPS
        number: 443
        tls:
          mode: SIMPLE
          serverCertificate: /etc/istio/ingressgateway-certs/tls.crt
          privateKey: /etc/istio/ingressgateway-certs/tls.key
      hosts:
      - "*"
  ```
  {: codeblock}

2. Apply the gateway in the namespace where your Istio-managed microservices are deployed.
  ```
  kubectl apply -f my-gateway.yaml -n <namespace>
  ```
  {: pre}

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/virtual-service/).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: my-virtual-service
    namespace: <namespace>
  spec:
    gateways:
    - my-gateway
    hosts:
    - '*'
    http:
    - match:
      - uri:
          exact: /<service_path>
      route:
      - destination:
          host: <service_name>
          port:
            number: 443
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
  </thead>
  <tbody>
  <tr>
  <td><code>namespace</code></td>
  <td>Replace <em>&lt;namespace&gt;</em> with the namespace where your Istio-managed microservices are deployed.</td>
  </tr>
  <tr>
  <td><code>gateways</code></td>
  <td>The <code>my-gateway</code> is specified so that the gateway can apply these virtual service routing rules to the <code>istio-ingressgateway</code> load balancer.<td>
  </tr>
  <tr>
  <td><code>http.match.uri.exact</code></td>
  <td>Replace <em>&lt;service_path&gt;</em> with the path that your entrypoint microservice listens on. For example, in the BookInfo app, the path is defined as <code>/productpage</code>.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.host</code></td>
  <td>Replace <em>&lt;service_name&gt;</em> with the name of your entrypoint microservice. For example, in the BookInfo app, <code>productpage</code> served as the entrypoint microservice that called the other app microservices.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.port.number</code></td>
  <td>If your microservice listens on a different port, replace <em>&lt;443&gt;</em> with the port.</td>
  </tr>
  </tbody></table>

4. Apply the virtual service rules in the namespace where your Istio-managed microservice is deployed.
  ```
  kubectl apply -f my-virtual-service.yaml -n <namespace>
  ```
  {: pre}

5. Get the **EXTERNAL-IP** address (classic clusters) or the hostname (VPC clusters) for the `istio-ingressgateway` load balancer.
  ```
  kubectl get svc -n istio-system
  ```
  {: pre}

  Example output for classic clusters:
  ```
  NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                                                                                                AGE
  ...
  istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   169.1.1.1       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
  ```
  {: screen}
  Example output for VPC clusters:
  ```
  NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                 PORT(S)                                                                                                                AGE
  ...
  istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   1234abcd-us-south.lb.appdomain.cloud       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
  ```
  {: screen}

6. Register the `istio-ingressgateway` load balancer IP by creating a DNS subdomain.
  * Classic clusters:
    ```
    ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}
  * VPC clusters:
    ```
    ibmcloud ks nlb-dns create vpc-classic --cluster <cluster_name_or_ID> --lb-host <LB_hostname>
    ```
    {: pre}

7. Verify that the subdomain is created and note the name of your SSL secret in the **SSL Cert Secret Name** field.
  ```
  ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Example output for classic clusters:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}
  Example output for VPC clusters:
  ```
  Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
  ```
  {: screen}

8. Retrieve the YAML file of the SSL secret and save it to a `mysecret.yaml` file on your local machine.
  ```
  kubectl get secret <secret_name> --namespace default --export -o yaml > mysecret.yaml
  ```
  {: pre}

9. In the `mysecret.yaml` file, change the value of `name:` to `istio-ingressgateway-certs` and save the file.

10. Apply the modified secret to the `istio-system` namespace in your cluster.
  ```
  kubectl apply -f ./mysecret.yaml -n istio-system
  ```
  {: pre}

11. Restart the Istio ingress pods so that the pods use the secret and are configured for TLS termination.
  ```
  kubectl delete pod -n istio-system -l istio=ingressgateway
  ```
  {: pre}

12. In a web browser, verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.
  ```
  https://<host_name>/<service_path>
  ```
  {: codeblock}

The certificates for the NLB DNS host secret expires every 90 days. The secret in the default namespace is automatically renewed by {{site.data.keyword.containerlong_notm}} 37 days before it expires, but you must manually copy the secret to the `istio-system` namespace every time that the secret is renewed. Use scripts to automate this process.
{: note}

Looking for even more fine-grained control over routing? To create rules that are applied after the load balancer routes traffic to each microservice, such as rules for sending traffic to different versions of one microservice, you can create and apply [`DestinationRules` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/reference/config/networking/v1alpha3/destination-rule/).
{: tip}

<br />


## Securing in-cluster traffic by enabling mTLS
{: #mtls}

Enable encryption for the entire Istio service mesh to achieve mutual TLS (mTLS) inside the cluster. Traffic that is routed by Envoy among pods in the cluster is encrypted with TLS. The certificate management for mTLS is handled by Istio. For more information, see the [Istio mTLS documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/security/authn-policy/#globally-enabling-istio-mutual-tls).
{: shortdesc}

1. Create a mesh-wide authentication policy file that is named `meshpolicy.yaml`. This policy configures all workloads in the service mesh to accept only encrypted requests with TLS. Note that no `targets` specifications are included because the policy applies to all services in the mesh.
  ```
  apiVersion: "authentication.istio.io/v1alpha1"
  kind: "MeshPolicy"
  metadata:
    name: "default"
  spec:
    peers:
    - mtls: {}
  ```
  {: codeblock}

2. Apply the authentication policy.
  ```
  kubectl apply -f meshpolicy.yaml
  ```
  {: pre}

3. Create a mesh-wide destination rule file that is named `destination-mtls.yaml`. This policy configures all workloads in the service mesh to send traffic by using TLS. Note that the `host: *.local` wildcard applies this destination rule to all services in the mesh.
  ```
  apiVersion: "networking.istio.io/v1alpha3"
  kind: "DestinationRule"
  metadata:
    name: "default"
    namespace: "istio-system"
  spec:
    host: "*.local"
    trafficPolicy:
      tls:
        mode: ISTIO_MUTUAL
  ```
  {: codeblock}

4. Apply the destination rule.
  ```
  kubectl apply -f destination-mtls.yaml
  ```
  {: pre}

Destination rules are also used for non-authentication reasons, such as routing traffic to different versions of a service. Any destination rule that you create for a service must also contain the same TLS block that is set to `mode: ISTIO_MUTUAL`. This block prevents the rule from overriding the mesh-wide mTLS settings that you configured in this section.
{: note}

## Securing Istio-managed apps with {{site.data.keyword.appid_short_notm}}
{: #app-id}

By using the App Identity and Access adapter, you can centralize all of your identity management with a single instance of {{site.data.keyword.appid_full}}. The adapter can be configured to work with any OIDC compliant identity provider, which enables the adapter to control authentication and authorization policies in all environments including frontend and backend applications. To use this feature, you do not need to make changes to your code or redeploy your app. To get started, see [Securing multicloud apps with Istio](/docs/services/appid?topic=appid-istio-adapter) in the {{site.data.keyword.appid_short_notm}} documentation.

<br />


## Updating the Istio add-ons
{: #istio_update}

Update your Istio add-ons to the latest versions, which are tested by {{site.data.keyword.cloud_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Updating your add-on from beta versions to the generally available version
{: #istio-ga}

The Istio managed add-on is generally available for Kubernetes version 1.16 and later clusters as of 19 November 2019. In Kubernetes version 1.16 or later clusters, you can [update your add-on](#istio_update) by uninstalling the Istio version 1.3 or earlier add-on and installing the Istio version 1.4 add-on.
{: shortdesc}

During the update, any traffic that is sent to Istio-managed services is interrupted, but your apps continue to run uninterruptedly. After you install the Istio version 1.4 add-on in a Kubernetes version 1.16 or later cluster, {{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio supported by {{site.data.keyword.containerlong_notm}}.

1. Save any resources, such as configuration files for any services or apps, that you created or modified in the `istio-system` namespace. Example command:
   ```
   kubectl get pod <pod_name> -o yaml -n istio-system
   ```
   {: pre}

2. Save the Kubernetes resources that were automatically generated in the namespace of the managed add-on to a YAML file on your local machine. These resources are generated by using custom resource definitions (CRDs).
   1. Get the CRDs for your add-on.
      ```
      kubectl get crd
      ```
      {: pre}

   2. Save any resources created from these CRDs.

3. If you enabled the `istio-sample-bookinfo` and `istio-extras` add-ons, disable them.
   1. Disable the `istio-sample-bookinfo` add-on.
      ```
      ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
      ```
      {: pre}

   2. Disable the `istio-extras` add-on.
      ```
      ibmcloud ks cluster addon disable istio-extras --cluster <cluster_name_or_ID>
      ```
      {: pre}

4. Disable the Istio add-on.
   ```
   ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
   ```
   {: pre}

5. Before you continue to the next step, verify that all add-on resources are removed.
  1. Verify that the beta Istio add-ons are removed.
     ```
     ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
     ```
     {: pre}
  2. Verify that the `istio-system` namespace is removed.
    ```
    kubectl get namespaces
    ```
    {: pre}

6. Re-enable Istio. The default version of the generally available Istio managed add-on, 1.4, is installed.
   ```
   ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
   ```
   {: pre}

7. Apply the CRD resources that you saved in step 2.
    ```
    kubectl apply -f <file_name> -n <namespace>
    ```
    {: pre}

9. Optional: [Install the BookInfo sample app.](#bookinfo_setup) In version 1.4 and later of the managed Istio add-on, the Grafana, Jaeger, and Kiali components that were previously installed by the `istio-extras` add-on are now included in the `istio` add-on. However, the BookInfo sample app that was previously installed by the `istio-sample-bookinfo` add-on is not included in the `istio` add-on and must be installed separately.

10. Optional: If you use TLS sections in your gateway configuration files, you must delete and re-create the gateways so that Envoy can access the secrets.
  ```
  kubectl delete gateway mygateway
  kubectl apply -f mygateway.yaml
  ```
  {: pre}

8. Next, [update your `istioctl` client and sidecars](#update_client_sidecar).

### Updating the `istioctl` client and sidecars
{: #update_client_sidecar}

Whenever the Istio managed add-on is updated, update your `istioctl` client and your app's Istio sidecars.
{: shortdesc}

For example, the patch version of your add-on might be updated automatically by {{site.data.keyword.containerlong_notm}}, or you might [manually update your add-on](#istio_update) from older beta versions to a generally available version. In either case, update your `istioctl` client and your app's existing Istio sidecars to match the Istio version of the add-on.

1. Check the version of your `istioctl` client and the Istio add-on control plane.
  ```
  istioctl version
  ```
  {: pre}
  Example output:
  ```
  client version: 1.3.3
  control plane version: 1.4.0
  ```
  {: screen}
  * If the `client version` (`istioctl`) matches the `control plane version` (Istio add-on control plane), including the patch version, continue to the next step.
  * If the `client version` does not match the `control plane version`:
    1. Download the `istioctl` client of the same version as the control plane.
      ```
      curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.4.0 sh -
      ```
      {: pre}
    2. Navigate to the Istio package directory.
      ```
      cd istio-1.4.0
      ```
      {: pre}

2. Check the version of your sidecar injector component.
  ```
  istioctl version --short=false | grep sidecar
  ```
  {: pre}
  Example output:
  ```
  sidecar-injector version: version.BuildInfo{Version:"1.3.3", GitRevision:"c562694ea6e554c2b60d12c9876d2641cfdd917d-dirty", User:"root", Host:"ccdab576-c621-11e9-abca-26bcb80ec4e0", GolangVersion:"go1.12.9", DockerHub:"docker.io/istio", BuildStatus:"Modified", GitTag:"1.2.3"}
  ```
  {: screen}
  * If the `Version` matches the control plane version that you found in the previous step, no further updates are required.
  * If the `Version` does not match the control plane version, [update your sidecars ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/upgrade/steps/#sidecar-upgrade).


<br />


## Uninstalling Istio
{: #istio_uninstall}

If you're finished working with Istio, you can clean up the Istio resources in your cluster by uninstalling Istio add-ons.
{:shortdesc}

The `istio` add-on is a dependency for the `istio-extras`, `istio-sample-bookinfo`, and [`knative`](/docs/containers?topic=containers-serverless-apps-knative) add-ons. The `istio-extras` add-on is a dependency for the `istio-sample-bookinfo` add-on.
{: important}

**Optional**: Any resources that you created or modified in the `istio-system` namespace and all Kubernetes resources that were automatically generated by custom resource definitions (CRDs) are removed. If you want to keep these resources, save them before you uninstall the `istio` add-ons.
1. Save any resources, such as configuration files for any services or apps, that you created or modified in the `istio-system` namespace.
   Example command:
   ```
   kubectl get pod <pod_name> -o yaml -n istio-system
   ```
   {: pre}

2. Save the Kubernetes resources that were automatically generated by CRDs in `istio-system` to a YAML file on your local machine.
   1. Get the CRDs in `istio-system`.
      ```
      kubectl get crd -n istio-system
      ```
      {: pre}

   2. Save any resources created from these CRDs.

### Uninstalling managed Istio add-ons from the console
{: #istio_uninstall_ui}

1. In your [cluster dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/clusters), click the name of the cluster where you want to remove the Istio add-ons.

2. Click the **Add-ons** tab.

3. On the Managed Istio card, click the Action menu icon.

4. Click **Uninstall**. All managed Istio add-ons are disabled in this cluster and all Istio resources in this cluster are removed.

5. On the Managed Istio card, verify that the add-ons you uninstalled are no longer listed.

### Uninstalling managed Istio add-ons from the CLI
{: #istio_uninstall_cli}

1. Disable the `istio-sample-bookinfo` add-on.
  ```
  ibmcloud ks cluster addon disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Disable the `istio-extras` add-on.
  ```
  ibmcloud ks cluster addon disable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Disable the `istio` add-on.
  ```
  ibmcloud ks cluster addon disable istio --cluster <cluster_name_or_ID> -f
  ```
  {: pre}

4. Verify that all managed Istio add-ons are disabled in this cluster. No Istio add-ons are returned in the output.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

<br />


### Uninstalling other Istio installations in your cluster
{: #istio_uninstall_other}

If you previously installed Istio in the cluster by using the IBM Helm chart or through another method, clean up that Istio installation before you enable the managed Istio add-on in the cluster. To check whether Istio is already in a cluster, run `kubectl get namespaces` and look for the `istio-system` namespace in the output.
{: shortdesc}

- If you installed Istio by using the {{site.data.keyword.cloud_notm}} Istio Helm chart:
  1. Uninstall the Istio Helm deployment.
    ```
    helm del istio --purge
    ```
    {: pre}

  2. If you used Helm 2.9 or earlier, delete the extra job resource.
    ```
    kubectl -n istio-system delete job --all
    ```
    {: pre}

  3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.

- If you installed Istio manually or used the Istio community Helm chart, see the [Istio uninstall documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/install/kubernetes/#uninstall-istio-core-components).
* If you previously installed BookInfo in the cluster, clean up those resources.
  1. Change the directory to the Istio file location.
    ```
    cd <filepath>/istio-1.4.0
    ```
    {: pre}

  2. Delete all BookInfo services, pods, and deployments in the cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

  3. The uninstallation process can take up to 10 minutes. Before you install the Istio managed add-on in the cluster, run `kubectl get namespaces` and verify that the `istio-system` namespace is removed.

<br />


## Troubleshooting
{: #istio-ts}

Resolve some common issues that you might encounter when you use the managed Istio add-on.
{: shortdesc}

### Istio components are missing
{: #control_plane}

{: tsSymptoms}
One or more of the Istio control plane components, such as `istio-citadel` or `istio-telemetry`, does not exist in your cluster.

{: tsCauses}
* You deleted one of the Istio deployments that is installed in your cluster Istio managed add-on.
* You changed the default `IstioControlPlane` resource. When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane. Only the `IstioControlPlane` resources that are managed by IBM are supported. Changing the control plane settings might result in an unsupported control plane state.

{: tsResolve}
Refresh your `IstioControlPlane` resource. The Istio operator reconciles the installation of Istio to the original add-on settings, including the core components of the Istio control plane.
```
kubectl annotate icp -n ibm-operators managed-istiocontrolplane --overwrite restartedAt=$(date +%H-%M-%S)
```
{: pre}

## Limitations
{: #istio_limitations}

Review the following limitations for the managed Istio add-on.
{: shortdesc}

* You cannot enable the managed Istio add-on in your cluster if you installed the [container image security enforcer admission controller](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in your cluster.
* When you enable the managed Istio add-on, you cannot use `IstioControlPlane` resources to customize the Istio control plane installation. Only the `IstioControlPlane` resources that are managed by IBM are supported.
* You cannot modify the `istio` configuration map in the `istio-system` namespace. This configuration map determines the Istio control plane settings after the managed add-on is installed.
* The following features are not supported in the managed Istio add-on:
  * [Policy enforcement ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/policy-enforcement/enabling-policy/)
  * [Secret discovery service (SDS) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/security/citadel-config/auth-sds/)
  * [Any features by the community that are in alpha or beta release stages ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/about/feature-stages/)

## What's next?
{: #istio_next}

* To explore Istio further, you can find more guides in the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/).
* Take the [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Note**: You can skip the Istio installation section of this course.
* Check out this blog post on using [Vistio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) to visualize your Istio service mesh.
