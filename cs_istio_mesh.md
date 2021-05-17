---

copyright:
  years: 2014, 2021
lastupdated: "2021-05-17"

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
  
 


# Managing apps in the service mesh
{: #istio-mesh}

After you [install the Istio add-on](/docs/containers?topic=containers-istio#istio_install) in your cluster, you can deploy your apps into the Istio service mesh by setting up Envoy proxy sidecar injection and exposing your apps with a subdomain.

## Trying out the BookInfo sample app
{: #istio_bookinfo}

The [BookInfo sample application for Istio](https://istio.io/latest/docs/examples/bookinfo/){: external} includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.
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

The deployment YAMLs for each of these microservices are modified so that Envoy sidecar proxies are pre-injected as containers into the microservices' pods before they are deployed. For more information about manual sidecar injection, see the [Istio documentation](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/){: external}. The BookInfo app is also already exposed on a public IP address by an Istio Gateway. Although the BookInfo app can help you get started, the app is not meant for production use.

### Setting up the BookInfo sample app
{: #bookinfo_setup}

1. Install BookInfo in your cluster.
  1. Download the latest Istio package for your operating system, which includes the configuration files for the BookInfo app.
    ```
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.4 sh -
    ```
    {: pre}

  2. Navigate to the Istio package directory.
    ```
    cd istio-1.9.4
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
    * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **Classic clusters**:
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

    * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **VPC clusters**: Create a `GATEWAY_URL` environment variable that uses the Istio ingress hostname.
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

### Exposing BookInfo by using an IBM-provided subdomain without TLS
{: #istio_expose_bookinfo}

When you enable the BookInfo add-on in your cluster, the Istio gateway `bookinfo-gateway` is created for you. The gateway uses Istio virtual service and destination rules to configure a load balancer, `istio-ingressgateway`, that publicly exposes the BookInfo app. In the following steps, you create a subdomain for the `istio-ingressgateway` load balancer IP address in classic clusters or the hostname in VPC clusters through which you can publicly access BookInfo.
{: shortdesc}

1. Register the IP address in classic clusters or the hostname in VPC clusters for the `istio-ingressgateway` load balancer by creating a DNS subdomain.
  * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic:
    ```
    ibmcloud ks nlb-dns create classic --ip $INGRESS_IP --cluster <cluster_name_or_id>
    ```
    {: pre}
  * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC:
    ```
    ibmcloud ks nlb-dns create vpc-gen2 --lb-host $GATEWAY_URL --cluster <cluster_name_or_id>
    ```
    {: pre}

2. Verify that the subdomain is created and copy the subdomain.
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

3. In a web browser, open the BookInfo product page. Because no TLS is configured, make sure that you use HTTP.
  ```
  http://<subdomain>/productpage
  ```
  {: codeblock}

4. Try refreshing the page several times. The requests to `http://<subdomain>/productpage` are received by the Istio gateway load balancer. The different versions of the `reviews` microservice are still returned randomly because the Istio gateway manages the virtual service and destination routing rules for microservices.

### Exposing BookInfo by using an IBM-provided subdomain with TLS
{: #istio_expose_bookinfo_tls}

When you enable the BookInfo add-on in your cluster, the Istio gateway `bookinfo-gateway` is created for you. The gateway uses Istio virtual service and destination rules to configure a load balancer, `istio-ingressgateway`, that publicly exposes the BookInfo app. In the following steps, you create a subdomain for the `istio-ingressgateway` load balancer IP address in classic clusters or the hostname in VPC clusters through which you can publicly access BookInfo. You also use the SSL certificate to enable HTTPS connections to the BookInfo app.
{: shortdesc}

1. Register the IP address in classic clusters or the hostname in VPC clusters for the `istio-ingressgateway` load balancer by creating a DNS subdomain.
  * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic:
    ```
    ibmcloud ks nlb-dns create classic --ip $INGRESS_IP --secret-namespace istio-system --cluster <cluster_name_or_id>
    ```
    {: pre}
  * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC:
    ```
    ibmcloud ks nlb-dns create vpc-gen2 --lb-host $GATEWAY_URL --secret-namespace istio-system --cluster <cluster_name_or_id>
    ```
    {: pre}

2. Verify that the subdomain is created and note the name of your SSL secret in the **SSL Cert Secret Name** field.
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

3. Configure the `bookinfo-gateway` to use TLS termination.
  1. Delete the existing `bookinfo-gateway`, which is not configured to handle TLS connections.
    ```
    kubectl delete gateway bookinfo-gateway
    ```
    {: pre}
  2. Create a new `bookinfo-gateway` configuration file that uses TLS termination. Save the following YAML file as `bookinfo-gateway.yaml`. Replace `<secret_name>` with the name of the SSL secret that you previously found.
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: Gateway
    metadata:
      name: bookinfo-gateway
    spec:
      selector:
        istio: ingressgateway
      servers:
      - port:
          number: 443
          name: https
          protocol: HTTPS
        tls:
          mode: SIMPLE
          credentialName: <secret_name>
        hosts:
        - "*"
    ```
    {: codeblock}

  3. Create the new `bookinfo-gateway` in your cluster.
    ```
    kubectl apply -f bookinfo-gateway.yaml
    ```
    {: pre}

4. In a web browser, open the BookInfo product page. Ensure that you use HTTPS for the subdomain that you found in step 2.
  ```
  https://<subdomain>/productpage
  ```
  {: codeblock}

5. Try refreshing the page several times. The requests to `https://<subdomain>/productpage` are received by the Istio gateway load balancer. The different versions of the `reviews` microservice are still returned randomly because the Istio gateway manages the virtual service and destination routing rules for microservices.

### Understanding what happened
{: #istio_bookinfo_understanding}

The BookInfo sample demonstrates how three of Istio's traffic management components work together to route ingress traffic to the app.
{: shortdesc}

<dl>
<dt>`Gateway`</dt>
<dd>The `bookinfo-gateway` [Gateway ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/latest/docs/reference/config/networking/gateway/) describes a load balancer, the `istio-ingressgateway` service in the `istio-system` namespace that acts as the entry point for inbound HTTP/TCP traffic for BookInfo. Istio configures the load balancer to listen for incoming requests to Istio-managed apps on the ports that are defined in the gateway configuration file.
</br></br>To see the configuration file for the BookInfo gateway, run the following command.
<pre class="pre"><code>kubectl get gateway bookinfo-gateway -o yaml</code></pre></dd>

<dt>`VirtualService`</dt>
<dd>The `bookinfo` [`VirtualService` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/latest/docs/reference/config/networking/virtual-service/) defines the rules that control how requests are routed within the service mesh by defining microservices as `destinations`. In the `bookinfo` virtual service, the `/productpage` URI of a request is routed to the `productpage` host on port `9080`. In this way, all requests to the BookInfo app are routed first to the `productpage` microservice, which then calls the other microservices of BookInfo.
</br></br>To see the virtual service rule that is applied to BookInfo, run the following command.
<pre class="pre"><code>kubectl get virtualservice bookinfo -o yaml</code></pre></dd>

<dt>`DestinationRule`</dt>
<dd>After the gateway routes the request according to virtual service rule, the `details`, `productpage`, `ratings`, and `reviews` [`DestinationRules` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/latest/docs/reference/config/networking/destination-rule/) define policies that are applied to the request when it reaches a microservice. For example, when you refresh the BookInfo product page, the changes that you see are the result of the `productpage` microservice randomly calling different versions, `v1`, `v2`, and `v3`, of the `reviews` microservice. The versions are selected randomly because the `reviews` destination rule gives equal weight to the `subsets`, or the named versions, of the microservice. These subsets are used by the virtual service rules when traffic is routed to specific versions of the service.
</br></br>To see the destination rules that are applied to BookInfo, run the following command.
<pre class="pre"><code>kubectl describe destinationrules</code></pre></dd>
</dl>

</br>

<br />

## Including apps in the Istio service mesh by setting up sidecar injection
{: #istio_sidecar}

Ready to manage your own apps by using Istio? Before you deploy your app, you must first decide how you want to inject the Envoy proxy sidecars into app pods.
{: shortdesc}

Each app pod must be running an Envoy proxy sidecar so that the microservices can be included in the service mesh. You can make sure that sidecars are injected into each app pod automatically or manually. For more information about sidecar injection, see the [Istio documentation](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/){: external}.

### Enabling automatic sidecar injection
{: #istio_sidecar_automatic}

When automatic sidecar injection is enabled, a namespace listens for any new deployments and automatically modifies the pod template specification so that app pods are created with Envoy proxy sidecar containers. Enable automatic sidecar injection for a namespace when you plan to deploy multiple apps that you want to integrate with Istio into that namespace. Automatic sidecar injection is not enabled for any namespaces by default in the Istio managed add-on.

Do not enable sidecar injection for the `kube-system`, `ibm-system,` or `ibm-operators` namespaces.
{: note}

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

5. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/latest/docs/ops/deployment/requirements/){: external}.

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

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding this YAML file.</caption>
    <thead>
    <col width="25%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
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

Do not enable sidecar injection for the `kube-system`, `ibm-system,` or `ibm-operators` namespaces.
{: note}

**Before you begin**:
1. Download the `istioctl` client.
  ```
  curl -L https://istio.io/downloadIstio | sh -
  ```
  {: pre}

2. Navigate to the Istio package directory.
  ```
  cd istio-1.9.4
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

3. If you did not create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/latest/docs/ops/deployment/requirements/){: external}.

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

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding this YAML file.</caption>
    <thead>
    <col width="20%">
    <thead>
    <th>Parameter</th>
    <th>Description</th>
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

## Enabling or disabling public Istio load balancers
{: #config-gateways}

By default, one public Istio load balancer, `istio-ingressgateway`, is enabled in your cluster to load balance incoming requests from the internet to your Istio-managed apps. You can achieve higher availability by enabling an Istio load balancer in each zone of your cluster.
{: shortdesc}

1. Edit the `managed-istio-custom` configmap resource.
  ```
  kubectl edit cm managed-istio-custom -n ibm-operators
  ```
  {: pre}

2. Check or add your cluster's zones in the `istio-ingressgateway-zone` fields.
  * If you initially installed the Istio add-on at version 1.5 or later, verify that all of your cluster zones are included in the `istio-ingressgateway-zone` fields.
  * If you initially installed the Istio add-on at version 1.4 and updated to version 1.5 or later, add your cluster's zones to the configmap.
      1. Get the zones that your worker nodes are deployed to.
        ```
        ibmcloud ks cluster get -c <cluster_name_or_ID> | grep Zones
        ```
        {: pre}
      2. Add the zones to the `istio-ingressgateway-zone` fields.

   Example for a classic, multizone cluster in Dallas:
   ```yaml
   istio-ingressgateway-zone-1: "dal10"
   istio-ingressgateway-zone-2: "dal12"
   istio-ingressgateway-zone-3: "dal13"
   ```
   {: screen}

3. Enable or disable an Istio load balancer in each zone by setting the `istio-ingressgateway-public-1|2|3-enabled` fields to `"true"` or `"false"`.

  <p class="note">If you want you apps to be accessible to clients, ensure that at least one load balancer is enabled, or [create custom gateway load balancers](/docs/containers?topic=containers-istio-custom-gateway). If you disable all load balancers in all zones, your app is no longer exposed and cannot be accessed externally.</p>

  Example to enable a public gateway in each zone:
   ```yaml
   istio-ingressgateway-public-1-enabled: "true"
   istio-ingressgateway-public-2-enabled: "true"
   istio-ingressgateway-public-3-enabled: "true"
   ```
   {: codeblock}

4. Save and close the configuration file.

5. Verify that the new `istio-ingressgateway` load balancer services are created.
  ```
  kubectl get svc -n istio-system
  ```
  {: pre}

To expose Istio-managed apps by using the `istio-ingressgateway` load balancer services, specify the `istio: ingressgateway` selector in your `Gateway` resource. For more information, see [Exposing Istio-managed apps](#istio_expose).


## Exposing the Istio ingress gateway with DNS
{: #istio_expose}

Publicly expose your Istio-managed apps by creating a DNS entry for the `istio-ingressgateway` load balancer and configuring the load balancer to forward traffic to your app.
{: shortdesc}

In the following steps, you set up a subdomain through which your users can access your app by creating the following resources:
* A gateway that is called `my-gateway`. This gateway acts as the public entry point to your apps and uses the existing `istio-ingressgateway` load balancer service to expose your app. The gateway can optionally be configured for TLS termination.
* A virtual service that is called `my-virtual-service`. `my-gateway` uses the rules that you define in `my-virtual-service` to route traffic to your app.
* A subdomain for the `istio-ingressgateway` load balancer. All user requests to the subdomain are forwarded to your app according to your `my-virtual-service` routing rules.

</br>

### Exposing the Istio ingress gateway with DNS without TLS termination
{: #no-tls}

**Before you begin:**

1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

To publicly expose apps:

1. Create a gateway that uses the public `istio-ingressgateway` load balancer service to expose port 80 for HTTP. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. For more information about gateway YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/gateway/){: external}.
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

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. If your microservices listen on a different port than `80`, add that port. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/virtual-service/){: external}.
  ```yaml
  apiVersion: networking.istio.io/v1beta1
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

  <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
  <caption>Understanding this YAML file.</caption>
  <thead>
  <col width="30%">
  <th>Parameter</th>
  <th>Description</th>
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

5. Get the **EXTERNAL-IP** address (classic clusters) or the hostname (VPC clusters) for the `istio-ingressgateway` public load balancer. If you [enabled an Istio load balancer in each zone of your cluster](#config-gateways), get the IP address or hostname of the load balancer service in each zone.
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

6. Register the load balancer IP or hostname by creating a DNS subdomain. For more information about registering DNS subdomains in {{site.data.keyword.containerlong_notm}}, see [Classic: Registering an NLB subdomain](/docs/containers?topic=containers-loadbalancer_hostname) or [Registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns).
  * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic clusters:
    ```
    ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP> [--ip <LB_zone2_IP> ...]
    ```
    {: pre}
  * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC clusters:
    ```
    ibmcloud ks nlb-dns create vpc-gen2 -c <cluster_name_or_ID> --lb-host <LB_hostname>
    ```
    {: pre}

7. Verify that the subdomain is created. In the output, copy the name of your SSL secret in the **SSL Cert Secret Name** field.
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

6. Verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.
  ```
  http://<host_name>/<service_path>
  ```
  {: codeblock}

</br>

### Exposing the Istio ingress gateway with DNS with TLS termination
{: #tls}

**Before you begin:**

1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they can be included in the Istio service mesh](#istio_sidecar).

To publicly expose apps:

1. Create a gateway that uses the public `istio-ingressgateway` load balancer service to expose port 80 for HTTP. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. For more information about gateway YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/gateway/){: external}.
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

3. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/virtual-service/){: external}.
   ```yaml
   apiVersion: networking.istio.io/v1beta1
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

  <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
  <caption>Understanding this YAML file.</caption>
  <thead>
  <col width="30%">
  <th>Parameter</th>
  <th>Description</th>
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

5. Get the **EXTERNAL-IP** address (classic clusters) or the hostname (VPC clusters) for the `istio-ingressgateway` public load balancer. If you [enabled an Istio load balancer in each zone of your cluster](#config-gateways), get the IP address or hostname of the load balancer service in each zone.
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

6. Register the load balancer IP or hostname by creating a DNS subdomain. For more information about registering DNS subdomains in {{site.data.keyword.containerlong_notm}}, see [Classic: Registering an NLB subdomain](/docs/containers?topic=containers-loadbalancer_hostname) or [Registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns).
  * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic clusters:
    ```
    ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP> [--ip <LB_zone2_IP> ...]
    ```
    {: pre}
  * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC clusters:
    ```
    ibmcloud ks nlb-dns create vpc-gen2 -c <cluster_name_or_ID> --lb-host <LB_hostname>
    ```
    {: pre}

7. Verify that the subdomain is created. In the output, copy the name of your SSL secret in the **SSL Cert Secret Name** field.
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

8. Verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.
  ```
  https://<host_name>/<service_path>
  ```
  {: codeblock}

The certificates for the NLB DNS host secret expires every 90 days. The secret in the default namespace is automatically renewed by {{site.data.keyword.containerlong_notm}} 37 days before it expires, but you must manually copy the secret to the `istio-system` namespace every time that the secret is renewed. Use scripts to automate this process.
{: note}

Looking for even more fine-grained control over routing? To create rules that are applied after the load balancer routes traffic to each microservice, such as rules for sending traffic to different versions of one microservice, you can create and apply [`DestinationRules`](https://istio.io/latest/docs/reference/config/networking/destination-rule/){: external}.
{: tip}

<br />

## Securing in-cluster traffic by enabling mTLS
{: #mtls}

Enable encryption for workloads in a namespace to achieve mutual TLS (mTLS) inside the cluster. Traffic that is routed by Envoy among pods in the cluster is encrypted with TLS. The certificate management for mTLS is handled by Istio. For more information, see the [Istio mTLS documentation](https://istio.io/v1.4/docs/tasks/security/authentication/authn-policy/){: external}.
{: shortdesc}

1. Create an authentication policy file that is named `default.yaml`. This policy is namespace-scoped and configures workloads in the service mesh to accept only encrypted requests with TLS. Note that no `targets` specifications are included because the policy applies to all services in the mesh in this namespace.
  ```yaml
  apiVersion: "security.istio.io/v1beta1"
  kind: "PeerAuthentication"
  metadata:
    name: "default"
  spec:
    mtls:
      mode: STRICT
  ```
  {: codeblock}

2. Apply the authentication policy to a namespace.
  ```
  kubectl apply -f default.yaml -n <namespace>
  ```
  {: pre}

3. Create a destination rule file that is named `destination-mtls.yaml`. This policy configures service mesh workloads in a namespace to send traffic by using TLS. Note that the `host: *.local` wildcard applies this destination rule to all services in the mesh.
  ```yaml
  apiVersion: "networking.istio.io/v1beta1"
  kind: "DestinationRule"
  metadata:
    name: "destination-mtls"
  spec:
    host: "*.local"
    trafficPolicy:
      tls:
        mode: ISTIO_MUTUAL
  ```
  {: codeblock}

4. Apply the destination rule.
  ```
  kubectl apply -f destination-mtls.yaml -n <namespace>
  ```
  {: pre}

5. If you want to achieve mTLS for service mesh workloads in other namespaces, repeat these steps each namespace.

Destination rules are also used for non-authentication reasons, such as routing traffic to different versions of a service. Any destination rule that you create for a service must also contain the same TLS block that is set to `mode: ISTIO_MUTUAL`. This block prevents the rule from overriding the mesh-wide mTLS settings that you configured in this section.
{: note}

