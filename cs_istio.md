---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-07"

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



# Using the managed Istio add-on (beta)
{: #istio}

Istio on {{site.data.keyword.containerlong}} provides a seamless installation of Istio, automatic updates and lifecycle management of Istio control plane components, and integration with platform logging and monitoring tools.
{: shortdesc}

With one click, you can get all Istio core components, additional tracing, monitoring, and visualization, and the BookInfo sample app up and running. Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on, so {{site.data.keyword.Bluemix_notm}} automatically keeps all your Istio components up to date.

## Understanding Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_ov}

### What is Istio?
{: #istio_ov_what_is}

[Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/info/istio) is an open service mesh platform to connect, secure, control, and observe microservices on cloud platforms such as Kubernetes in {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

When you shift monolith applications to a distributed microservice architecture, a set of new challenges arise such as how to control the traffic of your microservices, do dark launches and canary rollouts of your services, handle failures, secure the service communication, observe the services, and enforce consistent access policies across the fleet of services. To address these difficulties, you can leverage a service mesh. A service mesh provides a transparent and language-independent network for connecting, observing, securing, and controlling the connectivity between microservices. Istio provides insights and control over the service mesh by allowing you to manage network traffic, load balance across microservices, enforce access policies, verify service identity, and more.

For example, using Istio in your microservice mesh can help you:
- Achieve better visibility into the apps running in your cluster
- Deploy canary versions of apps and control the traffic that is sent to them
- Enable automatic encryption of data that is transferred between microservices
- Enforce rate limiting and attribute-based whitelist and blacklist policies

An Istio service mesh is composed of a data plane and a control plane. The data plane consists of Envoy proxy sidecars in each app pod, which mediate communication between microservices. The control plane consists of Pilot, Mixer telemetry and policy, and Citadel, which apply Istio configurations in your cluster. For more information about each of these components, see the [`istio` add-on description](#istio_components).

### What is Istio on {{site.data.keyword.containerlong_notm}} (beta)?
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} is offered as a managed add-on that integrates Istio directly with your Kubernetes cluster.
{: shortdesc}

**What does this look like in my cluster?**</br>
When you install the Istio add-on, the Istio control and data planes use the VLANs that your cluster is already connected to. Configuration traffic flows over the private network within your cluster, and does not require you to open any additional ports or IP addresses in your firewall. If you expose your Istio-managed apps with an Istio Gateway, external traffic requests to the apps flows over the public VLAN.

**How does the update process work?**</br>
The Istio version in the managed add-on is tested by {{site.data.keyword.Bluemix_notm}} and approved for the use in {{site.data.keyword.containerlong_notm}}. Additionally, the Istio add-on simplifies the maintenance of your Istio control plane so you can focus on managing your microservices. {{site.data.keyword.Bluemix_notm}} keeps all your Istio components up-to-date by automatically rolling out updates to the most recent version of Istio supported by {{site.data.keyword.containerlong_notm}}.  

If you need to use the latest version of Istio or customize your Istio installation, you can install the open source version of Istio by following the steps in the [Quick Start with {{site.data.keyword.Bluemix_notm}} tutorial ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/quick-start-ibm/).
{: tip}

<br />


## What can I install?
{: #istio_components}

Istio on {{site.data.keyword.containerlong_notm}} is offered as three managed add-ons in your cluster.
{: shortdesc}

<dl>
<dt>Istio (`istio`)</dt>
<dd>Installs the core components of Istio, including Prometheus. For more information about any of the following control plane components, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/concepts/what-is-istio).
  <ul><li>`Envoy` proxies inbound and outbound traffic for all services in the mesh. Envoy is deployed as a sidecar container in the same pod as your app container.</li>
  <li>`Mixer` provides telemetry collection and policy controls.<ul>
    <li>Telemetry pods are enabled with a Prometheus endpoint, which aggregates all telemetry data from the Envoy proxy sidecars and services in your app pods.</li>
    <li>Policy pods enforce access control, including rate limiting and applying whitelist and blacklist policies.</li></ul>
  </li>
  <li>`Pilot` provides service discovery for the Envoy sidecars and configures the traffic management routing rules for sidecars.</li>
  <li>`Citadel` uses identity and credential management to provide service-to-service and end-user authentication.</li>
  <li>`Galley` validates configuration changes for the other Istio control plane components.</li>
</ul></dd>
<dt>Istio extras (`istio-extras`)</dt>
<dd>Optional: Installs [Grafana ![External link icon](../icons/launch-glyph.svg "External link icon")](https://grafana.com/), [Jaeger ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.jaegertracing.io/), and [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/) to provide extra monitoring, tracing, and visualization for Istio.</dd>
<dt>BookInfo sample app (`istio-sample-bookinfo`)</dt>
<dd>Optional: Deploys the [BookInfo sample application for Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/examples/bookinfo/). This deployment includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.</dd>
</dl>

<br>
You can always see which Istio add-ons are enabled in your cluster by running the following command:
```
ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
```
{: pre}

The `istio` managed add-on can be installed into a free cluster. To also install the `istio-extras` and `istio-sample-bookinfo` add-ons, create a standard cluster with at least two worker nodes.
{: note}

<br />


## Installing Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_install}

Install Istio managed add-ons in an existing cluster.
{: shortdesc}

**Before you begin**</br>
* Ensure you have the [**Writer** or **Manager** {{site.data.keyword.Bluemix_notm}} IAM service role](/docs/containers/cs_users.html#platform) for {{site.data.keyword.containerlong_notm}}.
* [Target the CLI to an existing 1.10 or later cluster](/docs/containers/cs_cli_install.html#cs_cli_configure).
* If you previously installed Istio in the cluster by using the IBM Helm chart or through another method, [clean up that Istio installation](#istio_uninstall_other).

### Installing managed Istio add-ons in the CLI
{: #istio_install_cli}

1. Enable the `istio` add-on.
  ```
  ibmcloud ks cluster-addon-enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Optional: Enable the `istio-extras` add-on.
  ```
  ibmcloud ks cluster-addon-enable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Optional: Enable the `istio-sample-bookinfo` add-on.
  ```
  ibmcloud ks cluster-addon-enable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

4. Verify that the managed Istio add-ons that you installed are enabled in this cluster.
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name                      Version
  istio                     1.0.5
  istio-extras              1.0.5
  istio-sample-bookinfo     1.0.5
  ```
  {: screen}

5. You can also check out the individual components of each add-on in your cluster.
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
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP   2m
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

### Installing managed Istio add-ons in the UI
{: #istio_install_ui}

1. In your [cluster dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/containers-kubernetes/clusters), click the name of a version 1.10 or later cluster.

2. Click the **Add-ons** tab.

3. On the Istio card, click **Install**.

4. The **Istio** check box is already selected. To also install the Istio extras and BookInfo sample app, select the **Istio Extras** and the **Istio Sample** check boxes.

5. Click **Install**.

6. On the Istio card, verify that the add-ons you enabled are listed.

Next, you can try out Istio's capabilities by checking out the [BookInfo sample app](#istio_bookinfo).

<br />


## Trying out the BookInfo sample app
{: #istio_bookinfo}

The BookInfo add-on (`istio-sample-bookinfo`) deploys the [BookInfo sample application for Istio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/examples/bookinfo/) into the `default` namespace. This deployment includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.
{: shortdesc}

The four BookInfo microservices include:
* `productpage` calls the `details` and `reviews` microservices to populate the page.
* `details` contains book information.
* `reviews` contains book reviews and calls the `ratings` microservice.
* `ratings` contains book ranking information that accompanies a book review.

The `reviews` microservice has multiple versions:
* `v1` does not call the `ratings` microservice.
* `v2` calls the `ratings` microservice and displays ratings as 1 to 5 black stars.
* `v3` calls the `ratings` microservice and displays ratings as 1 to 5 red stars.

The deployment YAMLs for each of these microservices are modified so that Envoy sidecar proxies are pre-injected as containers into the microservices' pods before they are deployed. For more information about manual sidecar injection, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/sidecar-injection/). The BookInfo app is also already exposed on a public IP ingress address by an Istio Gateway. Note that although the BookInfo app can help you get started, the app is not meant for production use.

Before you begin, [install the `istio`, `istio-extras`, and `istio-sample-bookinfo` managed add-ons](#istio_install) in a cluster.

1. Get the public address for your cluster.
  * Standard clusters:
      2. Set the ingress host.
        ```
        export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        ```
        {: pre}

      3. Set the ingress port.
        ```
        export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
        ```
        {: pre}

      4. Create a `GATEWAY_URL` environment variable that uses the ingress host and port.
         ```
         export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
         ```
         {: pre}

  * Free clusters:
      1. Set the ingress host. This host is the public IP address of any worker node in your cluster.
        ```
        export INGRESS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
        ```
        {: pre}

      2. Set the ingress port.
        ```
        export INGRESS_PORT=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
        ```
        {: pre}

      3. Create a GATEWAY_URL environment variable that uses the public IP address of the worker node and a NodePort.
         ```
         export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
         ```
         {: pre}

2. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

3.  View the BookInfo web page in a browser.

    For Mac OS or Linux:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    For Windows:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

4. Try refreshing the page several times. Different versions of the reviews section round robin through red stars, black stars, and no stars. The changes that you see are the result of the different versions, `v1`, `v2`, and `v3`, of the `reviews` microservice that are called randomly each time. The versions are selected randomly because the destination rules that are applied to the BookInfo app give equal weight to the `v1`, `v2`, and `v3` of the `reviews` microservice. To see the destination rules that are applied to BookInfo, run `kubectl get destinationrules -o yaml`.



Next, you can  [log, monitor, trace, and visualize](#istio_health) the service mesh for the BookInfo app.

<br />


## Logging, monitoring, tracing, and visualizing Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_health}

To log, monitor, trace, and visualize your apps that are managed by Istio on {{site.data.keyword.containerlong_notm}}, you can launch the Grafana, Jaeger, and Kiali dashboards that are installed in the `istio-extras` add-on or deploy LogDNA and Sysdig as a third-party services to your worker nodes.
{: shortdesc}

### Launching the Grafana, Jaeger, and Kiali dashboards
{: #istio_health_extras}

The Istio extras add-on (`istio-extras`) installs [Grafana ![External link icon](../icons/launch-glyph.svg "External link icon")](https://grafana.com/), [Jaeger ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.jaegertracing.io/), and [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/). Launch the dashboards for each of these services to provide extra monitoring, tracing, and visualization for Istio.
{: shortdesc}

Before you begin, [install the `istio` and `istio-extras` managed add-ons](#istio_install) in a cluster.

**Grafana**</br>
1. Start Kubernetes port forwarding for the Grafana dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
  ```
  {: pre}

2. To open the Istio Grafana dashboard, go to the following URL: http://localhost:3000/dashboard/db/istio-mesh-dashboard. If you installed the [BookInfo add-on](#istio_bookinfo), the Istio dashboard shows metrics for the traffic that you generated when you refreshed the product page a few times. For more information about using the Istio Grafana dashboard, see [Viewing the Istio Dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/telemetry/using-istio-dashboard/) in the Istio open source documentation.

**Jaeger**</br>
1. Start Kubernetes port forwarding for the Jaeger dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
  ```
  {: pre}

2. To open the Jaeger UI, go to the following URL: http://localhost:16686.

3. If you installed the [BookInfo add-on](#istio_bookinfo), you can select `productpage` from the **Service** list and click **Find Traces**. Traces for the traffic that you generated when you refreshed the product page a few times are shown. For more information about using Jaeger with Istio, see [Generating traces using the Bookinfo sample ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/telemetry/distributed-tracing/#generating-traces-using-the-bookinfo-sample) in the Istio open source documentation.

**Kiali**</br>
1. Start Kubernetes port forwarding for the Kiali dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001 &
  ```
  {: pre}

2. To open the Kiali UI, go to the following URL: http://localhost:20001.

3. Enter `admin` for both the username and passphrase. For more information about using Kiali to visualize your Istio-managed microservices, see [Generating a service graph ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/tasks/telemetry/kiali/#generating-a-service-graph) in the Istio open source documentation.

### Setting up logging with {{site.data.keyword.la_full_notm}}
{: #istio_health_logdna}

Seamlessly manage logs for your app container and the Envoy proxy sidecar container in each pod by deploying LogDNA to your worker nodes to forward logs to {{site.data.keyword.loganalysislong}}.
{: shortdesc}

To use [{{site.data.keyword.la_full}}](/docs/services/Log-Analysis-with-LogDNA/overview.html), you deploy a logging agent to every worker node in your cluster. This agent collects logs with the extension `*.log` and extensionless files that are stored in the `/var/log` directory of your pod from all namespaces, including `kube-system`. These logs include logs from your app container and the Envoy proxy sidecar container in each pod. The agent then forwards the logs to the {{site.data.keyword.la_full_notm}} service.

To get started, set up LogDNA for your cluster by following the steps in [Managing Kubernetes cluster logs with {{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).




### Setting up monitoring with {{site.data.keyword.mon_full_notm}}
{: #istio_health_sysdig}

Gain operational visibility into the performance and health of your Istio-managed apps by deploying Sysdig to your worker nodes to forward metrics to {{site.data.keyword.monitoringlong}}.
{: shortdesc}

With Istio on {{site.data.keyword.containerlong_notm}}, the managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregates all telemetry data for your pods. When you deploy a Sysdig agent to every worker node in your cluster, Sysdig is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.Bluemix_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy Sysdig in your cluster.

1. Set up Sysdig by following the steps in [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster).

2. [Launch the Sysdig UI ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#step3).

3. Click **Add new dashboard**.

4. Search for `Istio` and select one of Sysdig's predefined Istio dashboards.

For more information on referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the Sysdig blog post [How to monitor Istio, the Kubernetes service mesh ![External link icon](../icons/launch-glyph.svg "External link icon")](https://sysdig.com/blog/monitor-istio/). Look for the section called "Monitoring Istio: reference metrics and dashboards".

<br />


## Setting up sidecar injection for your apps
{: #istio_sidecar}

Ready to manage your own apps by using Istio? Before you deploy your app, you must first decide how you want to inject the Envoy proxy sidecars into app pods.
{: shortdesc}

Each app pod must be running an Envoy proxy sidecar so that the microservices can be included in the service mesh. You can make sure sidecars are injected into each app pod automatically or manually. For more information about sidecar injection, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/sidecar-injection/).

### Enabling automatic sidecar injection
{: #istio_sidecar_automatic}

When automatic sidecar injection is enabled, a namespace listens for any new deployments and automatically modifies the deployment YAMLs to add sidecars. Enable automatic sidecar injection for a namespace when you plan to deploy multiple apps that you want to integrate with Istio into that namespace. Note that automatic sidecar injection is not enabled for any namespaces by default in the Istio managed add-on.

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

3. Deploy apps into the labeled namespace, or re-deploy apps that are already in the namespace.
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

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container running alongside your app container.

### Manually injecting sidecars
{: #istio_sidecar_manual}

If you do not want to enable automatic sidecar injection on a namespace, you can manually inject the sidecar into a deployment YAML. Inject sidecars manually when apps are running in namespaces alongside other deployments that you do not want sidecars automatically injected into.

To manually inject sidecars into a deployment:

1. Download the `istioctl` client.
  ```
  curl -L https://git.io/getIstio | sh -
  ```

2. Navigate to the Istio package directory.
  ```
  cd istio-1.0.5
  ```
  {: pre}

3. Inject the Envoy sidecar into you app deployment YAML.
  ```
  istioctl kube-inject -f <myapp>.yaml | kubectl apply -f -
  ```
  {: pre}

4. Deploy your app.
  ```
  kubectl apply <myapp>.yaml
  ```
  {: pre}

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container running alongside your app container.

<br />




## Uninstalling Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_uninstall}

If you're finished working with Istio, you can clean up the Istio resources in your cluster by uninstalling Istio add-ons.
{:shortdesc}

Note that the `istio` add-on is a dependency for the `istio-extras`, `istio-sample-bookinfo`, and [`knative`](/docs/containers/cs_tutorials_knative.html) add-ons. The `istio-extras` add-on is a dependency for the `istio-sample-bookinfo` add-on.

### Uninstalling managed Istio add-ons in the CLI
{: #istio_uninstall_cli}

1. Disable the `istio-sample-bookinfo` add-on.
  ```
  ibmcloud ks cluster-addon-disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Disable the `istio-extras` add-on.
  ```
  ibmcloud ks cluster-addon-disable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Disable the `istio` add-on.
  ```
  ibmcloud ks cluster-addon-disable istio --cluster <cluster_name_or_ID> -f
  ```
  {: pre}

4. Verify that all managed Istio add-ons are disabled in this cluster. No Istio add-ons are returned in the output.
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

### Uninstalling managed Istio add-ons in the UI
{: #istio_uninstall_ui}

1. In your [cluster dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/containers-kubernetes/clusters), click the name of a version 1.10 or later cluster.

2. Click the **Add-ons** tab.

3. On the Istio card, click the menu icon.

4. Uninstall individual or all Istio add-ons.
  - Individual Istio add-ons:
    1. Click **Update**.
    2. Unselect the check boxes for the add-ons you want to disable. If you unselect an add-on, other add-ons that require that ad-on as a dependency might be automatically unselected.
    3. Click **Update**. The Istio add-ons are disabled and the resources for those add-ons are removed from this cluster.
  - All Istio add-ons:
    1. Click **Uninstall**. All managed Istio add-ons are disabled in this cluster and all Istio resources in this cluster are removed.

5. On the Istio card, verify that the add-ons you uninstalled are no longer listed.

<br />


### Uninstalling other Istio installations in your cluster
{: #istio_uninstall_other}

If you previously installed Istio in the cluster by using the IBM Helm chart or through another method, clean up that Istio installation before enabling the managed Istio add-ons in the cluster. To check whether Istio is already in a cluster, run `kubectl get namespaces` and look for the `istio-system` namespace in the output.
{: shortdesc}

- If you installed Istio by using the {{site.data.keyword.Bluemix_notm}} Istio Helm chart:
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

- If you installed Istio manually or used the Istio community Helm chart, see the [Istio uninstall documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/setup/kubernetes/quick-start/#uninstall-istio-core-components).
* If you previously installed BookInfo in the cluster, clean up those resources.
  1. Change the directory to the Istio file location.
    ```
    cd <filepath>/istio-1.0.5
    ```
    {: pre}

  2. Delete all BookInfo services, pods, and deployments in the cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

## What's next?
{: #istio_next}

* To explore Istio further, you can find more guides in the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/).
    * [Intelligent Routing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/guides/intelligent-routing.html): This example shows how to route traffic to a specific version of BookInfo's reviews and ratings microservices by using Istio's traffic management capabilities.
    * [In-Depth Telemetry ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/guides/telemetry.html): This example includes how to get uniform metrics, logs, and traces across BookInfo's microservices by using Istio Mixer and the Envoy proxy.
* Learn how expose your Istio-managed apps by using the {{site.data.keyword.containerlong_notm}} Ingress hostname and an Istio Gateway in this [blog post ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/).
* Take the [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Note**: You can skip the Istio installation section of this course.
* Check out this blog post on using [Vistio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) to visualize your Istio service mesh.
