---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-04"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Managing apps in the service mesh
{: #istio-mesh}

After you [install the Istio add-on](/docs/containers?topic=containers-istio#istio_install) in your cluster, you can deploy your apps into the Istio service mesh by setting up Envoy proxy sidecar injection and exposing your apps with a subdomain.

## Trying out the BookInfo sample app
{: #istio_bookinfo}

The [BookInfo sample application for Istio](https://istio.io/docs/examples/bookinfo/){: external} includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.
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

The deployment YAMLs for each of these microservices are modified so that Envoy sidecar proxies are pre-injected as containers into the microservices' pods before they are deployed. For more information about manual sidecar injection, see the [Istio documentation](https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/){: external}. The BookInfo app is also already exposed on a public IP address by an Istio Gateway. Although the BookInfo app can help you get started, the app is not meant for production use.

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
      cd istio-1.4.2
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

1. Get the public address for the `istio-ingressgateway` load balancer that exposes BookInfo.
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


## Including apps in the Istio service mesh by setting up sidecar injection
{: #istio_sidecar}

Ready to manage your own apps by using Istio? Before you deploy your app, you must first decide how you want to inject the Envoy proxy sidecars into app pods.
{: shortdesc}

Each app pod must be running an Envoy proxy sidecar so that the microservices can be included in the service mesh. You can make sure that sidecars are injected into each app pod automatically or manually. For more information about sidecar injection, see the [Istio documentation](https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/){: external}.

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

5. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/docs/setup/kubernetes/additional-setup/requirements/){: external}.

  1. Define a service for the app.
    ```yaml
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
  cd istio-1.4.2
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

3. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/docs/setup/kubernetes/additional-setup/requirements/){: external}.

  1. Define a service for the app.
    ```yaml
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


## Publicly exposing Istio-managed apps
{: #istio_expose}

Publicly expose your Istio-managed apps by creating a DNS entry for the `istio-ingressgateway` load balancer and configuring the load balancer to forward traffic to your app.
{: shortdesc}

In the following steps, you set up a subdomain through which your users can access your app by creating the following resources:
* A gateway that is called `my-gateway`. This gateway acts as the public entry point to your apps and uses the existing `istio-ingressgateway` load balancer service to expose your app. The gateway can optionally be configured for TLS termination.
* A virtual service that is called `my-virtual-service`. `my-gateway` uses the rules that you define in `my-virtual-service` to route traffic to your app.
* A subdomain for the `istio-ingressgateway` load balancer. All user requests to the subdomain are forwarded to your app according to your `my-virtual-service` routing rules.

### Publicly exposing Istio-managed apps without TLS termination
{: #no-tls}

**Before you begin:**

1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

**To publicly expose your Istio-managed apps with a subdomain without using TLS:**

1. Create a gateway. This sample gateway uses the `istio-ingressgateway` load balancer service to expose port 80 for HTTP. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. If your microservices listen on a different port than `80`, add that port. For more information about gateway YAML components, see the [Istio reference documentation](https://istio.io/docs/reference/config/networking/v1alpha3/gateway/){: external}.
  ```yaml
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

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/docs/reference/config/networking/v1alpha3/virtual-service/){: external}.
  ```yaml
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

### Publicly exposing Istio-managed apps with TLS termination
{: #tls}

**Before you begin:**

1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

**To publicly expose your Istio-managed apps with a subdomain using TLS:**

1. Create a gateway. This sample gateway uses the `istio-ingressgateway` load balancer service to expose port 443 for HTTPS. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. If your microservices listen on a different port than `443`, add that port. For more information about gateway YAML components, see the [Istio reference documentation](https://istio.io/docs/reference/config/networking/v1alpha3/gateway/){: external}.
  ```yaml
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

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/docs/reference/config/networking/v1alpha3/virtual-service/){: external}.
  ```yaml
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

Looking for even more fine-grained control over routing? To create rules that are applied after the load balancer routes traffic to each microservice, such as rules for sending traffic to different versions of one microservice, you can create and apply [`DestinationRules`](https://istio.io/docs/reference/config/networking/v1alpha3/destination-rule/){: external}.
{: tip}

<br />


## Securing in-cluster traffic by enabling mTLS
{: #mtls}

Enable encryption for the entire Istio service mesh to achieve mutual TLS (mTLS) inside the cluster. Traffic that is routed by Envoy among pods in the cluster is encrypted with TLS. The certificate management for mTLS is handled by Istio. For more information, see the [Istio mTLS documentation](https://istio.io/docs/tasks/security/authn-policy/#globally-enabling-istio-mutual-tls){: external}.
{: shortdesc}

1. Create a mesh-wide authentication policy file that is named `meshpolicy.yaml`. This policy configures all workloads in the service mesh to accept only encrypted requests with TLS. Note that no `targets` specifications are included because the policy applies to all services in the mesh.
  ```yaml
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
  ```yaml
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



