---

copyright:
  years: 2014, 2020
lastupdated: "2020-01-08"

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

3. Verify that the managed Istio add-on has a status of `Addon Ready`.
  ```
  ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name            Version     Health State   Health Status
  istio           1.4.2       normal         Addon Ready
  ```
  {: screen}

4. You can also check out the individual components of the add-on to ensure that the Istio pods are deployed.
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

For more information about Istio in {{site.data.keyword.containerlong_notm}}, see [About the managed Istio add-on](/docs/containers?topic=containers-istio-about).

## Step 2: Set up the BookInfo sample app
{: #istio-qs-2}

The BookInfo sample application for Istio includes the base demo setup and the default destination rules so that you can try out Istio's capabilities immediately.
{: shortdesc}

The four BookInfo microservices include:
* `productpage` calls the `details` and `reviews` microservices to populate the page.
* `details` contains book information.
* `ratings` contains book ranking information that accompanies a book review.
* `reviews` contains book reviews and calls the `ratings` microservice. The `reviews` microservice has multiple versions:
  * `v1` does not call the `ratings` microservice.
  * `v2` calls the `ratings` microservice and displays ratings as 1 to 5 black stars.
  * `v3` calls the `ratings` microservice and displays ratings as 1 to 5 red stars.

The BookInfo app is also already exposed on a public IP address by an Istio Gateway.

1. Install BookInfo in your cluster.
    1. Download the latest Istio package, which includes the configuration files for the BookInfo app.
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

    5. Ensure that the BookInfo microservices pods are `Running`.
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

1. Generate 100 requests to the `productpage` service of BookInfo.
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

3. Enter the username and passphrase that you previously defined.

4. In the menu, click **Graph**.

5. In the **Select a namespace** drop-down list, select the namespace where your apps are deployed.

6. In the **No edge labels** drop-down list, select **Requests percentage**.

    If you do not see any percentages in the graph, in the upper-right corner of the dashboard, change the timeframe to **Last 5m** or **Last 10m**.
    {: tip}

7. Notice that the **reviews** section of the graph shows approximately equal percentages of traffic between `v1`, `v2`, and `v3` of the `reviews` microservice.

For more information about using Kiali to visualize your Istio-managed microservices, see [Generating a service graph ![External link icon](../icons/launch-glyph.svg "External link icon")](https://archive.istio.io/v1.0/docs/tasks/telemetry/kiali/#generating-a-service-graph) in the Istio open source documentation.

## Step 4: Simulate a phased rollout of BookInfo
{: #istio-qs-4}

To simulate a release of an app, you can perform a phased rollout `v3` of the `reviews` microservice of BookInfo.
{: shortdesc}

After you finish testing your app and are ready to start directing live traffic to it, you can perform rollouts gradually through Istio. For example, you can first release `v3` to 10% of the users, then to 20% of users, and so on.

1. Configure a virtual service to distribute 0% of traffic to `v1`, 90% of traffic to `v2`, and 10% of traffic to `v3` of `reviews`.
  ```
  kubectl apply -f - <<EOF
  apiVersion: networking.istio.io/v1alpha3
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

2. [Configure a Sysdig agent in your cluster.](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-config_agent#config_agent_kube_script)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **View Sysdig** for the instance that you provisioned.

4. In the Sysdig UI, click **Add new dashboard**.

5. Search for `Istio` and select one of Sysdig's predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out [How to monitor Istio, the Kubernetes service mesh](https://sysdig.com/blog/monitor-istio/){: external} on the Sysdig blog.

