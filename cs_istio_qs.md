---

copyright:
  years: 2014, 2020
lastupdated: "2020-09-22"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
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
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
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
{:swift: #swift .ph data-hd-programlang='swift'}
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
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
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
  istio           1.7.2       normal         Addon Ready
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
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.7.2 sh -
    ```
    {: pre}

  2. Navigate to the Istio package directory.
    ```
    cd istio-1.7.2
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

## Step 3: Visualize the service mesh with Kiali
{: #istio-qs-3}

To visualize the BookInfo microservices in the Istio service mesh, launch the Kiali dashboard.
{: shortdesc}

1. Enable Kiali for your Istio installation.
  1. Edit the `managed-istio-custom` configmap resource.
    ```
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

  2. In the `data` section, set the `istio-monitoring` setting to `"true"`. If the setting is not listed, add a `data` section and add the setting as `istio-monitoring: "true"`. This setting enables Prometheus, Grafana, Jaeger, and Kiali.

  3. Save the configuration file.

  4. Apply the changes to your Istio installation. Changes might take up to 10 minutes to take effect.
    ```
    kubectl annotate iop -n ibm-operators managed-istio --overwrite version="custom-applied-at: $(date)"
    ```
    {: pre}

2. Generate 100 requests to the `productpage` service of BookInfo.
  ```
  for i in `seq 1 100`; do curl -s -o /dev/null http://$GATEWAY_URL/productpage; done
  ```
  {: pre}
1. Define the credentials that you want to use to access Kiali.
  1. Copy and paste the following command. This command starts a text entry for you to enter a username, which is then encoded in base64 and stored in the `KIALI_USERNAME` environment variable.
    ```
    KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)
    ```
    {: pre}
  2. Copy and paste the following command. This command starts a text entry for you to enter a passphrase, which is then encoded in base64 and stored in the `KIALI_PASSPHRASE` environment variable.
    ```
    KIALI_PASSPHRASE=$(read -p 'Kiali Passphrase: ' pval && echo -n $pval | base64)
    ```
    {: pre}
  3. Apply the following configuration to store the credentials in a Kubernetes secret.
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

3. Enter the username and passphrase that you previously defined.

4. In the menu, click **Graph**.

5. In the **Select a namespace** drop-down list, select the namespace where your apps are deployed.

8. In the **No edge labels** drop-down list, select **Requests percentage**.

    If you do not see any percentages in the graph, in the upper-right corner of the dashboard, change the timeframe to **Last 5m** or **Last 10m**.
    {: tip}

9. Notice that the **reviews** section of the graph shows approximately equal percentages of traffic between `v1`, `v2`, and `v3` of the `reviews` microservice.

For more information about using Kiali to visualize your Istio-managed microservices, see [Generating a service graph](https://istio.io/v1.0/docs/tasks/telemetry/kiali/#generating-a-service-graph){: external} in the Istio open source documentation.

## Step 4: Simulate a phased rollout of BookInfo
{: #istio-qs-4}

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

6. Generate 100 requests to the `productpage` service of BookInfo.
  ```
  for i in `seq 1 100`; do curl -s -o /dev/null http://$GATEWAY_URL/productpage; done
  ```
  {: pre}

7. Review the traffic distribution in Kiali.
    1. Access the Kiali dashboard
      ```
      istioctl dashboard kiali
      ```
      {: pre}
    2. In the menu, click **Graph**.
    3. In the **Select a namespace** drop-down list, select the namespace where your apps are deployed.
    4. In the **No edge labels** drop-down list, select **Requests percentage**.

        If you do not see any percentages in the graph, in the upper-right corner of the dashboard, change the timeframe to **Last 5m** or **Last 10m**.
        {: tip}
    5. Notice that the **reviews** section of the graph shows approximately 90% of traffic is sent to `v2` and 10% of traffic is sent to `v3` of the `reviews` microservice.

8. Change the traffic distribution so that all traffic is sent only to `v3`. Note that in a real scenario, you might slowly roll out your version changes by changing the traffic distribution first to 80:20, then 70:30, and so on, until all traffic is routed to only the latest version.
    1. In the menu of the Kiali dashboard, click **Istio Config**.
    2. Click the **reviews** `VirtualService`.
    3. Click the **YAML** tab.
    4. Change the `weight` of `v2` to `0` and the `weight` of `v3` to `100`.
    5. Click **Save**.

9. Try refreshing the BookInfo page several times. Notice that the page with black stars (`v2`) is no longer shown, and only the page with red stars (`v3`) shown.

10. In the **Graph** page of the Kiali dashboard, verify that 100% of traffic is now sent to `v3` of `reviews`.

11. Verify that in the time since you changed the YAML file for the reviews `VirtualService`, no logs exist for requests to `v2`.
  ```
  kubectl logs -l app=reviews,version=v2 -c istio-proxy
  ```
  {: pre}

## Step 5: Monitor BookInfo with {{site.data.keyword.mon_full_notm}}
{: #istio-qs-5}

Use one of Sysdig's predefined Istio dashboards to monitor your BookInfo microservices.
{: shortdesc}

The managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregate all telemetry data for your pods. When you deploy a Sysdig agent to the worker nodes in your cluster, Sysdig is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.cloud_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy Sysdig in your cluster.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observe/monitoring/create){: external}.

2. [Configure a Sysdig agent in your cluster.](/docs/Monitoring-with-Sysdig?topic=Monitoring-with-Sysdig-config_agent#config_agent_kube_script)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **View Sysdig** for the instance that you provisioned.

4. In the Sysdig UI, click **Add new dashboard**.

5. Search for `Istio` and select one of Sysdig's predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out [How to monitor Istio, the Kubernetes service mesh](https://sysdig.com/blog/monitor-istio/){: external} on the Sysdig blog.


## Step 6: Secure in-cluster traffic by enabling mTLS
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

