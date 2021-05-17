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
  
 


# Getting started with Istio
{: #istio-qs}

Get started with the managed Istio add-on in {{site.data.keyword.containerlong}}. In this set of steps, you deploy the BookInfo sample app to practice using several of Istio's service mesh capabilities.
{: shortdesc}

## Step 1: Enable the Istio add-on
{: #istio-qs-1}

Set up the managed Istio add-on in your cluster.
{: shortdesc}

1. [Target the CLI to your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

2. Enable the `istio` add-on.
  ```
  ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. Verify that the managed Istio add-on has a status of `Addon Ready`. Note that it can take a few minutes for the add-on to be ready.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name            Version     Health State   Health Status
  istio           1.9.4       normal         Addon Ready
  ```
  {: screen}

4. You can also check out the individual components of the add-on to ensure that the Istio pods are deployed.
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}  
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

For more information about Istio in {{site.data.keyword.containerlong_notm}}, see [About the managed Istio add-on](/docs/containers?topic=containers-istio-about).

## Step 2: Set up the BookInfo sample app
{: #istio-qs-2}

The BookInfo sample application includes a basic Istio configuration so that you can try out Istio's capabilities immediately.
{: shortdesc}

The four BookInfo microservices include:
* `productpage` calls the `details` and `reviews` microservices to populate the page.
* `details` contains book information.
* `ratings` contains book ranking information that accompanies a book review.
* `reviews` contains book reviews and calls the `ratings` microservice. The `reviews` microservice has multiple versions:
  * `v1` does not call the `ratings` microservice.
  * `v2` calls the `ratings` microservice and displays ratings as 1 to 5 black stars.
  * `v3` calls the `ratings` microservice and displays ratings as 1 to 5 red stars.

The BookInfo app is also already exposed on a public IP address by an Istio Gateway. To see the BookInfo architecture, check out the [Istio documentation](https://istio.io/latest/docs/examples/bookinfo/){: external}.

1. Install BookInfo in your cluster.
  1. Download the latest Istio package, which includes the configuration files for the BookInfo app.
    ```
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.4 sh -
    ```
    {: pre}

  2. Navigate to the Istio package directory.
    ```
    cd istio-1.9.4
    ```
    {: pre}

  3. Linux and macOS users: Add the `istioctl` client to your `PATH` system variable.
    ```
    export PATH=$PWD/bin:$PATH
    ```
    {: pre}

  4. Label the `default` namespace for automatic sidecar injection. Any new pods that are deployed to `default` are now automatically created with Envoy proxy sidecar containers.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

  5. Deploy the BookInfo application, gateway, and destination rules.
    ```
    kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
    kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
    kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
    ```
    {: pre}

  6. Ensure that the BookInfo microservices pods are `Running`.
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

2. Get the public address for the `istio-ingressgateway` load balancer that exposes BookInfo.
  * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **Classic clusters**:
    1. Set the Istio ingress IP address as an environment variable.
       ```
       export INGRESS_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
       ```
       {: pre}

    2. Set the Istio ingress port as an environment variable.
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

3. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

4. View the BookInfo web page in a browser.

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

5. Try refreshing the page several times. Different versions of the reviews section round-robin through no stars (`v1` of `reviews`), black stars (`v2`), and red stars (`v3`).

For more information about how routing works in Istio, see [Understanding what happened](/docs/containers?topic=containers-istio-mesh#istio_bookinfo_understanding).

## Step 3: Simulate a phased rollout of BookInfo
{: #istio-qs-3}

To simulate a release of an app, you can perform a phased rollout `v3` of the `reviews` microservice of BookInfo.
{: shortdesc}

After you finish testing your app and are ready to start directing live traffic to it, you can perform rollouts gradually through Istio. For example, you can first release `v3` to 10% of the users, then to 20% of users, and so on.

1. Configure a virtual service to distribute 0% of traffic to `v1`, 90% of traffic to `v2`, and 10% of traffic to `v3` of `reviews`.
  ```
  kubectl apply -f - <<EOF
  apiVersion: networking.istio.io/v1beta1
  kind: VirtualService
  metadata:
    name: reviews
  spec:
    hosts:
      - reviews
    http:
    - route:
      - destination:
          host: reviews
          subset: v1
        weight: 0
      - destination:
          host: reviews
          subset: v2
        weight: 90
      - destination:
          host: reviews
          subset: v3
        weight: 10
  EOF
  ```
  {: codeblock}

4. View the BookInfo web page in a browser.

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

5. Try refreshing the page several times. Notice that the page with no stars (`v1`) is no longer shown, and that a majority of page refreshes show the black stars (`v2`). Only rarely is the page with red stars (`v3`) shown.

6. Change the traffic distribution so that all traffic is sent only to `v3`. Note that in a real scenario, you might slowly roll out your version changes by changing the traffic distribution first to 80:20, then 70:30, and so on, until all traffic is routed to only the latest version.
    1. Edit the configuration file for the `reviews` virtual service.
      ```
      kubectl edit VirtualService reviews
      ```
      {: pre}
    2. Change the `weight` of `v2` to `0` and the `weight` of `v3` to `100`.
    3. Save and close the file.

7. Try refreshing the BookInfo page several times. Notice that the page with black stars (`v2`) is no longer shown, and only the page with red stars (`v3`) shown.

8. Verify that in the time since you changed the YAML file for the reviews `VirtualService`, no logs exist for requests to `v2`.
  ```
  kubectl logs -l app=reviews,version=v2 -c istio-proxy
  ```
  {: pre}

## Step 4: Monitor BookInfo with {{site.data.keyword.mon_full_notm}}
{: #istio-qs-4}

Use one of {{site.data.keyword.mon_short}}'s predefined Istio dashboards to monitor your BookInfo microservices.
{: shortdesc}

The managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregate all telemetry data for your pods. When you deploy a monitoring agent to the worker nodes in your cluster, {{site.data.keyword.mon_short}} is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.cloud_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy monitoring agents in your cluster.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observe/monitoring/create){: external}.

2. [Configure a monitoring agent in your cluster.](/docs/monitoring?topic=monitoring-config_agent#config_agent_kube_script)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **Open Dashboard** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Add new dashboard**.

5. Search for `Istio` and select one of {{site.data.keyword.mon_short}}'s predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the [How to monitor Istio, the Kubernetes service mesh](https://sysdig.com/blog/monitor-istio/){: external} blog post.

## Step 5: Secure in-cluster traffic by enabling mTLS
{: #mtls-qs}

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
