---

copyright:
  years: 2014, 2025
lastupdated: "2025-08-12"


keywords: kubernetes, envoy, sidecar, mesh, bookinfo, istio

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}






# Getting started with Istio
{: #istio-qs}

Get started with the managed Istio add-on in {{site.data.keyword.containerlong}}. In this set of steps, you deploy the BookInfo sample app to practice using several of Istio's service mesh capabilities.
{: shortdesc}

Before you begin, review the [Istio add-on change log](/docs/containers?topic=containers-istio-changelog) for version information.

## Step 1: Enable the Istio add-on
{: #istio-qs-1}

Set up the managed Istio add-on in your cluster.
{: shortdesc}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

2. Enable the `istio` add-on.
    ```sh
    ibmcloud ks cluster addon enable istio --cluster <cluster_name_or_ID>
    ```
    {: pre}

3. Verify that the managed Istio add-on has a status of `Addon Ready`. Note that it can take a few minutes for the add-on to be ready.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    Name            Version     Health State   Health Status
    istio           1.23       normal         Addon Ready
    ```
    {: screen}

4. You can also check out the individual components of the add-on to ensure that the Istio pods are deployed.
    ```sh
    kubectl get pods -n istio-system
    ```
    {: pre}  


    ```sh
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
        ```sh
        curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.23.5 sh -
        ```
        {: pre}

    2. Navigate to the Istio package directory.
        ```sh
        cd istio-1.23.5
        ```
        {: pre}

    3. Linux and macOS users: Add the `istioctl` client to your `PATH` system variable.
        ```sh
        export PATH=$PWD/bin:$PATH
        ```
        {: pre}

    4. Label the `default` namespace for automatic sidecar injection. Any new pods that are deployed to `default` are now automatically created with Envoy proxy sidecar containers.
        ```sh
        kubectl label namespace default istio-injection=enabled
        ```
        {: pre}

    5. Deploy the BookInfo application, gateway, and destination rules.
        ```sh
        kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
        kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
        kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
        ```
        {: pre}

    6. Ensure that the BookInfo microservices pods are `Running`.
        ```sh
        kubectl get pods
        ```
        {: pre}

        ```sh
        NAME                                     READY     STATUS      RESTARTS   AGE
        details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
        productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
        ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
        reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
        reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
        reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
        ```
        {: screen}

1. Get the public address for the `istio-ingressgateway` load balancer that exposes BookInfo.
    * **Classic clusters**
        1. Set the Istio ingress IP address as an environment variable.
            ```sh
            export INGRESS_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        2. Set the Istio ingress port as an environment variable.
            ```sh
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        3. Create a `GATEWAY_URL` environment variable that uses the Istio ingress host and port.
            ```sh
            export GATEWAY_URL=$INGRESS_IP:$INGRESS_PORT
            ```
            {: pre}

    * **VPC clusters**: Create a `GATEWAY_URL` environment variable that uses the Istio ingress hostname.
        ```sh
        export GATEWAY_URL=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
        ```
        {: pre}

1. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
    ```sh
    curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
    ```
    {: pre}

1. View the BookInfo web page in a browser.

    Mac OS or Linux

    ```sh
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Windows

    ```sh
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

1. Try refreshing the page several times. Different versions of the reviews section round-robin through no stars (`v1` of `reviews`), black stars (`v2`), and red stars (`v3`).

For more information about how routing works in Istio, see [Understanding what happened](/docs/containers?topic=containers-istio-mesh#istio_bookinfo_understanding).

## Step 3: Simulate a phased rollout of BookInfo
{: #istio-qs-3}

To simulate a release of an app, you can perform a phased rollout `v3` of the `reviews` microservice of BookInfo.
{: shortdesc}

After you finish testing your app and are ready to start directing live traffic to it, you can perform rollouts gradually through Istio. For example, you can first release `v3` to 10% of the users, then to 20% of users, and so on.

1. Configure a virtual service to distribute 0% of traffic to `v1`, 90% of traffic to `v2`, and 10% of traffic to `v3` of `reviews`.
    
    ```yaml
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
    ```
    {: pre}
    
    ```sh
    kubectl apply -f <filename>.yaml
    ```
    {: pre}

2. View the BookInfo web page in a browser by running `open http://$GATEWAY_URL/productpage` on Mac OS or Linux or by running `start http://$GATEWAY_URL/productpage` on Windows.

3. Try refreshing the page several times. Notice that the page with no stars (`v1`) is no longer shown, and that a majority of page refreshes show the black stars (`v2`). Only rarely is the page with red stars (`v3`) shown.

4. Change the traffic distribution so that all traffic is sent only to `v3`. Note that in a real scenario, you might slowly roll out your version changes by changing the traffic distribution first to 80:20, then 70:30, and so on, until all traffic is routed to only the latest version.
    1. Edit the configuration file for the `reviews` virtual service.
        ```sh
        kubectl edit VirtualService reviews
        ```
        {: pre}

    2. Change the `weight` of `v2` to `0` and the `weight` of `v3` to `100`.
    3. Save and close the file.

5. Try refreshing the BookInfo page several times. Notice that the page with black stars (`v2`) is no longer shown, and only the page with red stars (`v3`) shown.

6. **If you have envoy access logs enabled**: Verify that in the time since you changed the YAML file for the reviews `VirtualService`, no logs exist for requests to `v2`.
    ```sh
    kubectl logs -l app=reviews,version=v2 -c istio-proxy
    ```
    {: pre}

## Step 4: Monitor BookInfo with {{site.data.keyword.mon_full_notm}}
{: #istio-qs-4}

Use one of the {{site.data.keyword.mon_short}} predefined Istio dashboards to monitor your BookInfo microservices.
{: shortdesc}

To deploy monitoring agents to your cluster, complete the following steps.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}}](https://cloud.ibm.com/observability/catalog/ibm-cloud-monitoring){: external}.

2. [Configure a monitoring agent in your cluster.](/docs/monitoring?topic=monitoring-kubernetes_cluster)

3. In the [Monitoring console](https://cloud.ibm.com/observe/monitoring){: external}, click **Open Dashboard** for the instance that you provisioned.

4. In the {{site.data.keyword.mon_short}} UI, click **Add new dashboard**.

5. Search for `Istio` and select one of the {{site.data.keyword.mon_short}} predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out the [How to monitor Istio, the Kubernetes service mesh](https://www.sysdig.com/blog/monitor-istio){: external} blog post.

## Step 5: Secure in-cluster traffic by enabling mTLS
{: #mtls-qs}

Enable encryption for workloads in a namespace to achieve mutual TLS (mTLS) inside the cluster. Traffic that is routed by Envoy among pods in the cluster is encrypted with TLS. The certificate management for mTLS is handled by Istio. For more information, see the [Istio mTLS documentation](https://istio.io/latest/docs/tasks/security/authentication/authn-policy){: external}.
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
    ```sh
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
    ```sh
    kubectl apply -f destination-mtls.yaml -n <namespace>
    ```
    {: pre}

5. If you want to achieve mTLS for service mesh workloads in other namespaces, repeat these steps each namespace.

Destination rules are also used for non-authentication reasons, such as routing traffic to different versions of a service. Any destination rule that you create for a service must also contain the same TLS block that is set to `mode: ISTIO_MUTUAL`. This block prevents the rule from overriding the mesh-wide mTLS settings that you configured in this section.
{: note}
