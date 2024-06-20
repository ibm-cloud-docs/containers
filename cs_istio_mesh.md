---

copyright:
  years: 2014, 2024
lastupdated: "2024-06-20"


keywords: kubernetes, envoy, sidecar, mesh, bookinfo, istio

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Managing and exposing apps in the service mesh
{: #istio-mesh}

After you [install the Istio add-on](/docs/containers?topic=containers-istio#istio_install) in your cluster, you can deploy your apps into the Istio service mesh by setting up Envoy proxy sidecar injection and exposing your apps with a subdomain.

## Understanding the BookInfo sample app
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

## Setting up the BookInfo sample app
{: #bookinfo_setup}

1. Install BookInfo in your cluster. Download the latest Istio package for your operating system, which includes the configuration files for the BookInfo app.
    ```sh
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.22.1 sh -
    ```
    {: pre}

1. Navigate to the Istio package directory.
    ```sh
    cd istio-1.22.1
    ```
    {: pre}

1. Label the `default` namespace for automatic sidecar injection.
    ```sh
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

1. Deploy the BookInfo application, gateway, and destination rules.
    ```sh
    kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
    kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
    kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
    ```
    {: pre}

1. Ensure that the BookInfo microservices and their corresponding pods are deployed.
    ```sh
    kubectl get svc
    kubectl get pods
    ```
    {: pre}

    ```sh
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
    kubernetes                ClusterIP      172.21.0.1       <none>         443/TCP          1d
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

## Publicly accessing BookInfo
{: #istio_access_bookinfo}

Get the public address for the `istio-ingressgateway` load balancer that exposes BookInfo.
{: shortdesc}

### Creating a gateway URL in Classic clusters
{: #istio_create_gatewayURL_classic}

1. Set the Istio ingress host.
    ```sh
    export INGRESS_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    ```
    {: pre}

2. Set the Istio ingress port.
    ```sh
    export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
    ```
    {: pre}

3. Create a `GATEWAY_URL` environment variable that uses the Istio ingress host and port.
    ```sh
    export GATEWAY_URL=$INGRESS_IP:$INGRESS_PORT
    ```
    {: pre}

4. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
    ```sh
    curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
    ```
    {: pre}

5. Try refreshing the page several times. Different versions of the reviews section round-robin through red stars, black stars, and no stars.

### Creating a gateway URL in VPC clusters
{: #create-gateway-vpc}

1. Create a `GATEWAY_URL` environment variable that uses the Istio ingress hostname.
    ```sh
    export GATEWAY_URL=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    ```
    {: pre}

1. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.
    ```sh
    curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
    ```
    {: pre}



### Viewing the BookInfo web page in a browser
{: #viewing-bookinfo}

Run the following command based on your operating to view the BookInfo app in your browser.
{: shortdesc}

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


Try refreshing the page several times. Different versions of the reviews section round-robin through red stars, black stars, and no stars.
{: tip}

### Exposing BookInfo by using an IBM-provided subdomain without TLS
{: #istio_expose_bookinfo}

When you enable the BookInfo add-on in your cluster, the Istio gateway `bookinfo-gateway` is created for you. The gateway uses Istio virtual service and destination rules to configure a load balancer, `istio-ingressgateway`, that publicly exposes the BookInfo app. In the following steps, you create a subdomain for the `istio-ingressgateway` load balancer IP address in classic clusters or the hostname in VPC clusters through which you can publicly access BookInfo.
{: shortdesc}

1. Register the IP address in classic clusters or the hostname in VPC clusters for the `istio-ingressgateway` load balancer by creating a DNS subdomain.
    * Classic:
        ```sh
        ibmcloud ks nlb-dns create classic --ip $INGRESS_IP --cluster <cluster_name_or_id>
        ```
        {: pre}

    * VPC:
        ```sh
        ibmcloud ks nlb-dns create vpc-gen2 --lb-host $GATEWAY_URL --cluster <cluster_name_or_id>
        ```
        {: pre}

2. Verify that the subdomain is created and copy the subdomain.
    ```sh
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

Example output for Classic clusters

```sh
Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
```
{: screen}

Example output for VPC clusters

```sh
Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
```
{: screen}

In a web browser, open the BookInfo product page. Because no TLS is configured, make sure that you use HTTP.

```sh
http://<subdomain>/productpage
```
{: codeblock}

Try refreshing the page several times. The requests to `http://<subdomain>/productpage` are received by the Istio gateway load balancer. The different versions of the `reviews` microservice are still returned randomly because the Istio gateway manages the virtual service and destination routing rules for microservices.
{: tip}

### Exposing BookInfo by using an IBM-provided subdomain with TLS
{: #istio_expose_bookinfo_tls}

When you enable the BookInfo add-on in your cluster, the Istio gateway `bookinfo-gateway` is created for you. The gateway uses Istio virtual service and destination rules to configure a load balancer, `istio-ingressgateway`, that publicly exposes the BookInfo app. In the following steps, you create a subdomain for the `istio-ingressgateway` load balancer IP address in classic clusters or the hostname in VPC clusters through which you can publicly access BookInfo. You also use the SSL certificate to enable HTTPS connections to the BookInfo app.
{: shortdesc}

1. Register the IP address in classic clusters or the hostname in VPC clusters for the `istio-ingressgateway` load balancer by creating a DNS subdomain.
    * Classic:
        ```sh
        ibmcloud ks nlb-dns create classic --ip $INGRESS_IP --secret-namespace istio-system --cluster <cluster_name_or_id>
        ```
        {: pre}

    * VPC:
        ```sh
        ibmcloud ks nlb-dns create vpc-gen2 --lb-host $GATEWAY_URL --secret-namespace istio-system --cluster <cluster_name_or_id>
        ```
        {: pre}

2. Verify that the subdomain is created and note the name of your SSL secret in the **SSL Cert Secret Name** field.
    ```sh
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output for classic clusters.

    ```sh
    Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
    ```
    {: screen}

    Example output for VPC clusters

    ```sh
    Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
    ```
    {: screen}

### Configuring the bookinfo-gateway to use TLS termination
{: #bookinfo-tls}

Complete the following steps to set up TLS termination for the `bookinfo-gateway`.
{: shortdesc}

1. Delete the existing `bookinfo-gateway`, which is not configured to handle TLS connections.
    ```sh
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
    ```sh
    kubectl apply -f bookinfo-gateway.yaml
    ```
    {: pre}

4. In a web browser, open the BookInfo product page. Ensure that you use HTTPS for the subdomain that you found in step 2.
    ```sh
    https://<subdomain>/productpage
    ```
    {: codeblock}

5. Try refreshing the page several times. The requests to `https://<subdomain>/productpage` are received by the Istio gateway load balancer. The different versions of the `reviews` microservice are still returned randomly because the Istio gateway manages the virtual service and destination routing rules for microservices.

### Understanding what happened
{: #istio_bookinfo_understanding}

The BookInfo sample demonstrates how three of Istio's traffic management components work together to route ingress traffic to the app.
{: shortdesc}

`Gateway`
:   The `bookinfo-gateway` [Gateway](https://istio.io/latest/docs/reference/config/networking/gateway/){: external} describes a load balancer, the `istio-ingressgateway` service in the `istio-system` namespace that acts as the entry point for inbound HTTP/TCP traffic for BookInfo. Istio configures the load balancer to listen for incoming requests to Istio-managed apps on the ports that are defined in the gateway configuration file. To see the configuration file for the BookInfo gateway, run the following command. 

```sh
kubectl get gateway bookinfo-gateway -o yaml
```
{: pre}

`VirtualService`
:   The `bookinfo` [VirtualService](https://istio.io/latest/docs/reference/config/networking/virtual-service/){: external} defines the rules that control how requests are routed within the service mesh by defining microservices as `destinations`. In the `bookinfo` virtual service, the `/productpage` URI of a request is routed to the `productpage` host on port `9080`. In this way, all requests to the BookInfo app are routed first to the `productpage` microservice, which then calls the other microservices of BookInfo. To see the virtual service rule, run the following command.

```sh
kubectl get virtualservice bookinfo -o yaml
```
{: pre}

`DestinationRule`
:   After the gateway routes the request according to virtual service rule, the `details`, `productpage`, `ratings`, and `reviews` [DestinationRules](https://istio.io/latest/docs/reference/config/networking/destination-rule/){: external} define policies that are applied to the request when it reaches a microservice. For example, when you refresh the BookInfo product page, the changes that you see are the result of the `productpage` microservice randomly calling different versions, `v1`, `v2`, and `v3`, of the `reviews` microservice. The versions are selected randomly because the `reviews` destination rule gives equal weight to the `subsets`, or the named versions, of the microservice. These subsets are used by the virtual service rules when traffic is routed to specific versions of the service. To see the destination rules that are applied to BookInfo, run the following command.

```sh
kubectl describe destinationrules
```
{: pre}


## Including apps in the Istio service mesh by setting up sidecar injection
{: #istio_sidecar}

Ready to manage your own apps by using Istio? Before you deploy your app, you must first decide how you want to inject the Envoy proxy sidecars into app pods.
{: shortdesc}

Each app pod must be running an Envoy proxy sidecar so that the microservices are in the service mesh. You can make sure that sidecars are injected into each app pod automatically or manually. For more information about sidecar injection, see the [Istio documentation](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/){: external}.

### Enabling automatic sidecar injection
{: #istio_sidecar_automatic}

When automatic sidecar injection is enabled, a namespace listens for any new deployments and automatically modifies the pod template specification so that app pods are created with Envoy proxy sidecar containers. Enable automatic sidecar injection for a namespace when you plan to deploy multiple apps that you want to integrate with Istio into that namespace. Automatic sidecar injection is not enabled for any namespaces by default in the Istio managed add-on.

Do not enable sidecar injection for the `kube-system`, `ibm-system,` or `ibm-operators` namespaces.
{: note}

To enable automatic sidecar injection for a namespace:

1. Get the name of the namespace where you want to deploy Istio-managed apps.
    ```sh
    kubectl get namespaces
    ```
    {: pre}

1. Label the namespace as `istio-injection=enabled`.
    ```sh
    kubectl label namespace <namespace> istio-injection=enabled
    ```
    {: pre}

1. Deploy apps into the labeled namespace, or redeploy apps that are already in the namespace.
    ```sh
    kubectl apply <myapp>.yaml --namespace <namespace>
    ```
    {: pre}

1. **Optional** To redeploy an app in that namespace, delete the app pod so that it is redeployed with the injected sidecar.
    ```sh
    kubectl delete pod -l app=<myapp>
    ```
    {: pre}

1. If you didn't create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/latest/docs/ops/deployment/application-requirements/){: external}.

1. Define a service for the app.
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector: 
        <selector_key>: <selector_value> # Enter the label key `selector_key` and value `selector_value` pair that you want to use to target the pods where your app runs.
      ports:
      - protocol: TCP
        port: 8080 # The port that the service listens on
    ```
    {: codeblock}

1. Create the service in your cluster. Ensure that the service deploys into the same namespace as the app.
    ```sh
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container that runs alongside your app container.

### Manually injecting sidecars
{: #istio_sidecar_manual}

If you don't want to enable automatic sidecar injection for a namespace, you can manually inject the sidecar into a deployment YAML. Inject sidecars manually when apps are running in namespaces alongside other deployments that you don't want sidecars automatically injected into.

Do not enable sidecar injection for the `kube-system`, `ibm-system,` or `ibm-operators` namespaces.
{: note}


1. Download the `istioctl` client.
    ```sh
    curl -L https://istio.io/downloadIstio | sh -
    ```
    {: pre}

1. Navigate to the Istio package directory.
    ```sh
    cd istio-1.22.1
    ```
    {: pre}

To manually inject sidecars into a deployment:

1. Inject the Envoy sidecar into your app deployment YAML.
    ```sh
    istioctl kube-inject -f <myapp>.yaml | kubectl apply -f -
    ```
    {: pre}

1. Deploy your app.
    ```sh
    kubectl apply <myapp>.yaml
    ```
    {: pre}

1. If you didn't create a service to expose your app, create a Kubernetes service. Your app must be exposed by a Kubernetes service to be included as a microservice in the Istio service mesh. Ensure that you follow the [Istio requirements for pods and services](https://istio.io/latest/docs/ops/deployment/application-requirements/){: external}.

1. Define a service for the app.
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector:
        <selector_key>: <selector_value> # Enter the label key `selector_key` and value `selector_value` pair that you want to use to target the pods where your app runs.
      ports:
      - protocol: TCP
        port: 8080 # The port that the service listens on.
    ```
    {: codeblock}

1. Create the service in your cluster. Ensure that the service deploys into the same namespace as the app.
    ```sh
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

The app pods are now integrated into your Istio service mesh because they have the Istio sidecar container that runs alongside your app container.



## Enabling or disabling public Istio load balancers
{: #config-gateways}

By default, one public Istio load balancer, `istio-ingressgateway`, is enabled in your cluster to load balance incoming requests from the internet to your Istio-managed apps. You can achieve higher availability by enabling an Istio load balancer in each zone of your cluster.
{: shortdesc}

1. Edit the `managed-istio-custom` ConfigMap resource.
    ```sh
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

2. Verify that all your cluster zones are in the `istio-ingressgateway-zone` fields.

    Example for a classic, multizone cluster in Dallas:
    ```yaml
    istio-ingressgateway-zone-1: "dal10"
    istio-ingressgateway-zone-2: "dal12"
    istio-ingressgateway-zone-3: "dal13"
    ```
    {: screen}

3. Enable or disable an Istio load balancer in each zone by setting the `istio-ingressgateway-public-1|2|3-enabled` fields to `"true"` or `"false"`.

    If you want you apps to be accessible to clients, ensure that at least one load balancer is enabled, or [create custom gateway load balancers](/docs/containers?topic=containers-istio-custom-gateway). If you disable all load balancers in all zones, your app is no longer exposed and can't be accessed externally.
    {: note}

    Example to enable a public gateway in each zone:
    ```yaml
    istio-ingressgateway-public-1-enabled: "true"
    istio-ingressgateway-public-2-enabled: "true"
    istio-ingressgateway-public-3-enabled: "true"
    ```
    {: codeblock}

4. Save and close the configuration file.

5. Verify that the new `istio-ingressgateway` load balancer services are created.
    ```sh
    kubectl get svc -n istio-system
    ```
    {: pre}

To expose Istio-managed apps by using the `istio-ingressgateway` load balancer services, specify the `istio: ingressgateway` selector in your `Gateway` resource. For more information, see [Exposing Istio-managed apps](#istio_expose).


## Exposing the Istio ingress gateway with DNS
{: #istio_expose}

Publicly expose your Istio-managed apps by creating a DNS entry for the `istio-ingressgateway` load balancer and configuring the load balancer to forward traffic to your app.
{: shortdesc}

In the following steps, you set up a subdomain through which your users can access your app by creating the following resources:
* A gateway called `my-gateway`. This gateway acts as the public entry point to your apps and uses the existing `istio-ingressgateway` load balancer service to expose your app. The gateway can optionally be configured for TLS termination.
* A virtual service called `my-virtual-service`. `my-gateway` uses the rules that you define in `my-virtual-service` to route traffic to your app.
* A subdomain for the `istio-ingressgateway` load balancer. All user requests to the subdomain are forwarded to your app according to your `my-virtual-service` routing rules.


### Exposing the Istio ingress gateway with DNS without TLS termination
{: #istio-no-tls}

1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio&interface=cli#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they are in the Istio service mesh](#istio_sidecar).

To publicly expose apps:

1. Create a gateway that uses the public `istio-ingressgateway` load balancer service to expose port 80 for HTTP. Replace `<namespace>` with the namespace where your Istio-managed microservices are deployed. For more information about gateway YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/gateway/){: external}.
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: Gateway
    metadata:
      name: my-gateway
    spec:
      selector:
        app: ingressgateway
      servers:
      - port:
          number: 80
          name: http
          protocol: HTTP
        hosts:
        - "*"
    ```
    {: codeblock}

1. Apply the gateway in the namespace where your Istio-managed microservices are deployed.
    ```sh
    kubectl apply -f my-gateway.yaml -n <namespace>
    ```
    {: pre}

1. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. If your microservices listen on a different port than `80`, add that port. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/virtual-service/){: external}.
    ```yaml
    apiVersion: networking.istio.io/v1beta1
    kind: VirtualService
    metadata:
      name: my-virtual-service
      namespace: <namespace> # The namespace where your Istio-managed microservices are deployed.
    spec:
      gateways:
      - my-gateway # `my-gateway` is specified so that the gateway can apply these virtual service routing rules to the `istio-ingressgateway` load balancer.
      hosts:
      - '*'
      http:
      - match:
        - uri:
            exact: /<service_path> # Replace `service_path` with the path that your entrypoint microservice listens on. For example, in the BookInfo app, the path is defined as `/productpage`.
        route:
        - destination:
            host: <service_name> # Replace `service_name` with the name of your entrypoint microservice. For example, in the BookInfo app, `productpage` served as the entrypoint microservice that called the other app microservices.
            port:
              number: 80 # If your microservice listens on a different port, replace `80` with the port.
    ```
    {: codeblock}

1. Apply the virtual service rules in the namespace where your Istio-managed microservice is deployed.
    ```sh
    kubectl apply -f my-virtual-service.yaml -n <namespace>
    ```
    {: pre}

1. Get the **EXTERNAL-IP** address (classic clusters) or the hostname (VPC clusters) for the `istio-ingressgateway` public load balancer. If you [enabled an Istio load balancer in each zone of your cluster](#config-gateways), get the IP address or hostname of the load balancer service in each zone.
    ```sh
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```sh
    # Example output for classic clusters
    istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   169.1.1.1       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
    ```
    {: screen}

    ```sh
    # Example output for VPC clusters:
    istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   1234abcd-us-south.lb.appdomain.cloud       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
    ```
    {: screen}

1. Register the load balancer IP or hostname by creating a DNS subdomain. For more information about registering DNS subdomains in {{site.data.keyword.containerlong_notm}}, see [Classic: Registering an NLB subdomain](/docs/containers?topic=containers-loadbalancer_hostname) or [Registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns).
    Example command for Classic clusters.
    ```sh
    ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP> [--ip <LB_zone2_IP> ...]
    ```
    {: pre}

    Example command for VPC clusters.
    ```sh
    ibmcloud ks nlb-dns create vpc-gen2 -c <cluster_name_or_ID> --lb-host <LB_hostname>
    ```
    {: pre}

1. Verify that the subdomain is created. In the output, copy the name of your SSL secret in the **SSL Cert Secret Name** field.
    ```sh
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output for classic clusters.

    ```txt
    Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
    ```
    {: screen}

    Example output for VPC clusters.

    ```txt
    Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
    ```
    {: screen}

1. Verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.

    ```sh
    http://<host_name>/<service_path>
    ```
    {: codeblock}

Looking for even more fine-grained control over routing? To create rules that are applied after the load balancer routes traffic to each microservice, such as rules for sending traffic to different versions of one microservice, you can create and apply [`DestinationRules`](https://istio.io/latest/docs/reference/config/networking/destination-rule/){: external}.
{: tip}

Need to debug ingress or egress setups? Make sure that the `istio-global-proxy-accessLogFile` option in the [`managed-istio-custom` ConfigMap](/docs/containers?topic=containers-istio#customize) is set to `"/dev/stdout"`. Envoy proxies print access information to their standard output, which you can view by running `kubectl logs` commands for the Envoy containers. If you notice that the `ibm-cloud-provider-ip` pod for a gateway is stuck in `pending`, see [this troubleshooting topic](/docs/containers?topic=containers-istio_gateway_affinity).
{: tip}



### Exposing the Istio ingress gateway with DNS with TLS termination
{: #istio_tls}


1. [Install the `istio` managed add-on](/docs/containers?topic=containers-istio#istio_install) in a cluster.
2. [Install the `istioctl` CLI](/docs/containers?topic=containers-istio&interface=cli#istioctl).
3. [Set up sidecar injection for your app microservices, deploy the app microservices into a namespace, and create Kubernetes services for the app microservices so that they are in the Istio service mesh](#istio_sidecar).

To publicly expose apps:

1. Register the load balancer IP or hostname by creating a DNS subdomain. For more information about registering DNS subdomains in {{site.data.keyword.containerlong_notm}}, see [Classic: Registering an NLB subdomain](/docs/containers?topic=containers-loadbalancer_hostname) or [Registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-vpc-lbaas#vpc_lb_dns).
    * Classic clusters:
        ```sh
        ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP> [--ip <LB_zone2_IP> ...]
        ```
        {: pre}

    * VPC clusters:
        ```sh
        ibmcloud ks nlb-dns create vpc-gen2 -c <cluster_name_or_ID> --lb-host <LB_hostname>
        ```
        {: pre}

1. Verify that the subdomain is created. In the output, copy the name of your SSL secret in the **SSL Cert Secret Name** field.
    ```sh
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    ```sh
    # Example output for classic clusters:
    Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
    ```
    {: screen}

    ```sh
    # Example output for VPC clusters:
    Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
    ```
    {: screen}

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

1. Apply the gateway in the namespace where your Istio-managed microservices are deployed.
    ```sh
    kubectl apply -f my-gateway.yaml -n <namespace>
    ```
    {: pre}

1. Create a virtual service that uses the `my-gateway` gateway and defines routing rules for your app microservices. For more information about virtual service YAML components, see the [Istio reference documentation](https://istio.io/latest/docs/reference/config/networking/virtual-service/){: external}.
    ```yaml
    apiVersion: networking.istio.io/v1beta1
    kind: VirtualService
    metadata:
      name: my-virtual-service
      namespace: <namespace> # The namespace where your Istio-managed microservices are deployed.
    spec:
      gateways:
      - my-gateway # `my-gateway` is specified so that the gateway can apply these virtual service routing rules to the `istio-ingressgateway` load balancer.
      hosts:
      - '*'
      http:
      - match:
        - uri:
            exact: /<service_path> # Replace `service_path` with the path that your entrypoint microservice listens on. For example, in the BookInfo app, the path is defined as `/productpage`.
        route:
        - destination:
            host: <service_name> # The name of your entrypoint microservice. For example, in the BookInfo app, `productpage` served as the entrypoint microservice that called the other app microservices.
            port:
              number: 443 # If your microservice listens on a different port, replace 443 with the port.
    ```
    {: codeblock}

1. Apply the virtual service rules in the namespace where your Istio-managed microservice is deployed.
    ```sh
    kubectl apply -f my-virtual-service.yaml -n <namespace>
    ```
    {: pre}

1. Get the **EXTERNAL-IP** address (classic clusters) or the hostname (VPC clusters) for the `istio-ingressgateway` public load balancer. If you [enabled an Istio load balancer in each zone of your cluster](#config-gateways), get the IP address or hostname of the load balancer service in each zone.
    ```sh
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```sh
    # Example output for classic clusters:
    istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   169.1.1.1       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
    ```
    {: screen}

    ```sh
    # Example output for VPC clusters:
    istio-ingressgateway     LoadBalancer   172.21.XXX.XXX   1234abcd-us-south.lb.appdomain.cloud       80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP  22m
    ```
    {: screen}


1. Verify that traffic is routed to your Istio-managed microservices by entering the URL of the app microservice.
    ```txt
    https://<host_name>/<service_path>
    ```
    {: codeblock}

The certificates for the NLB DNS host secret expires every 90 days. The secret in the default namespace is automatically renewed by {{site.data.keyword.containerlong_notm}} 37 days before it expires, but you must manually copy the secret to the `istio-system` namespace every time that the secret is renewed. Use scripts to automate this process.
{: note}

Looking for even more fine-grained control over routing? To create rules that are applied after the load balancer routes traffic to each microservice, such as rules for sending traffic to different versions of one microservice, you can create and apply [`DestinationRules`](https://istio.io/latest/docs/reference/config/networking/destination-rule/){: external}.
{: tip}

Need to debug ingress or egress setups? Make sure that the `istio-global-proxy-accessLogFile` option in the [`managed-istio-custom` ConfigMap](/docs/containers?topic=containers-istio#customize) is set to `"/dev/stdout"`. Envoy proxies print access information to their standard output, which you can view by running `kubectl logs` commands for the Envoy containers. If you notice that the `ibm-cloud-provider-ip` pod for a gateway is stuck in `pending`, see [this troubleshooting topic](/docs/containers?topic=containers-istio_gateway_affinity).
{: tip}

## Securing in-cluster traffic by enabling mTLS
{: #mtls}

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






