---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-18"

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

# Getting started with Istio
{: #istio-qs}

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

1. Install BookInfo in your cluster.
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

5. Try refreshing the page several times. Different versions of the reviews section round-robin through red stars, black stars, and no stars.

For more tasks you can try with BookInfo, see [Trying out the BookInfo sample app](/docs/containers?topic=containers-istio-mesh#istio_bookinfo).

## Step 3:
{: #istio-qs-3}



## Step 4: Secure traffic between pods by enabling mTLS
{: #istio-qs-4}

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


## Step 5: Visualize the service mesh with Kiali
{: #istio-qs-5}

To visualize the BookInfo microservices in the Istio service mesh, launch the [Kiali ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.kiali.io/) dashboard.
{: shortdesc}

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

3. Enter the username and passphrase that you defined in step 1.

For more information about using Kiali to visualize your Istio-managed microservices, see [Generating a service graph ![External link icon](../icons/launch-glyph.svg "External link icon")](https://archive.istio.io/v1.0/docs/tasks/telemetry/kiali/#generating-a-service-graph) in the Istio open source documentation.


## Step 6: Monitor BookInfo with {{site.data.keyword.mon_full_notm}}
{: #istio-qs-6}

Use one of Sysdig's predefined Istio dashboards to monitor your BookInfo microservices.
{: shortdesc}

The managed `istio` add-on installs Prometheus into your cluster. The `istio-mixer-telemetry` pods in your cluster are annotated with a Prometheus endpoint so that Prometheus can aggregate all telemetry data for your pods. When you deploy a Sysdig agent to the worker nodes in your cluster, Sysdig is already automatically enabled to detect and scrape the data from these Prometheus endpoints to display them in your {{site.data.keyword.cloud_notm}} monitoring dashboard.

Since all of the Prometheus work is done, all that is left for you is to deploy Sysdig in your cluster.

1. [Provision an instance of {{site.data.keyword.mon_full_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon").](https://cloud.ibm.com/observe/monitoring/create)

2. [Configure a Sysdig agent in your cluster.](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-config_agent#config_agent_kube_script)

3. In the [Monitoring console ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/observe/monitoring), click **View Sysdig** for the instance that you provisioned.

4. In the Sysdig UI, click **Add new dashboard**.

5. Search for `Istio` and select one of Sysdig's predefined Istio dashboards.

For more information about referencing metrics and dashboards, monitoring Istio internal components, and monitoring Istio A/B deployments and canary deployments, check out [How to monitor Istio, the Kubernetes service mesh ![External link icon](../icons/launch-glyph.svg "External link icon")](https://sysdig.com/blog/monitor-istio/) on the Sysdig blog.

