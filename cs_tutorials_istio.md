---

copyright:
  years: 2014, 2018
lastupdated: "2018-06-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Tutorial: Installing Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio](https://www.ibm.com/cloud/info/istio) is an open platform to connect, secure, and manage a network of microservices, also known as a service mesh, on cloud platforms such as Kubernetes in {{site.data.keyword.containerlong}}. With Istio, you can manage network traffic, load balance across microservices, enforce access policies, verify service identity, and more.
{:shortdesc}

In this tutorial, you can see how to install Istio alongside four microservices for a simple mock bookstore app called BookInfo. The microservices include a product web page, book details, reviews, and ratings. When you deploy BookInfo's microservices into an {{site.data.keyword.containershort}} cluster where Istio is installed, you inject the Istio Envoy sidecar proxies in the pods of each microservice.

**Note**: Some configurations and features of the Istio platform are still under development and are subject to change based on user feedback. Allow a few months for stabilization before you use Istio in production. 

## Objectives

-   Download and install Istio in your cluster
-   Deploy the BookInfo sample app
-   Inject Envoy sidecar proxies into the pods of the app's four microservices to connect the microservices in the service mesh
-   Verify the BookInfo app deployment and round robin through the three versions of the ratings service

## Time required

30 minutes

## Audience

This tutorial is intended for software developers and network administrators who are using Istio for the first time.

## Prerequisites

-  [Install the CLIs](cs_cli_install.html#cs_cli_install_steps). Istio requires the Kubernetes version 1.9 or higher. Make sure to install the `kubectl` CLI version that matches the Kubernetes version of your cluster.
-  [Create a cluster](cs_clusters.html#clusters_cli) with a Kubernetes version of 1.9 or higher.
-  [Target the CLI to your cluster](cs_cli_install.html#cs_cli_configure).

## Lesson 1: Download and install Istio
{: #istio_tutorial1}

Download and install Istio in your cluster.
{:shortdesc}


1. Either download Istio directly from [https://github.com/istio/istio/releases ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/istio/istio/releases) or get the latest version by using curl:

   ```
   curl -L https://git.io/getLatestIstio | sh -
   ```
   {: pre}

2. Extract the installation files.

3. Add the `istioctl` client to your PATH. For example, run the following command on a MacOS or Linux system:

   ```
   export PATH=$PWD/istio-0.8.0/bin:$PATH
   ```
   {: pre}

4. Change the directory to the Istio file location.

   ```
   cd filepath/istio-0.8.0
   ```
   {: pre}

5. Install Istio on the Kubernetes cluster. Istio is deployed in the Kubernetes namespace `istio-system`.

   ```
   kubectl apply -f install/kubernetes/istio-demo.yaml
   ```
   {: pre}




6. Ensure the pods for the 10 Istio services and for Prometheus are all fully deployed before you continue. The `istio-mixer-post-install` pod has a status of `Completed` and shows `0/1` pods ready.
   ```
   kubectl get pods -n istio-system
   ```
   {: pre}

   ```
   NAME                                        READY     STATUS      RESTARTS   AGE
   istio-citadel-ff5696f6f-rbxbq               1/1       Running     0          1m
   istio-egressgateway-58d98d898c-wbn7k        1/1       Running     0          1m
   istio-ingress-6fb78f687f-t9d98              1/1       Running     0          1m
   istio-ingressgateway-6bc7c7c4bc-8fdx2       1/1       Running     0          1m
   istio-mixer-post-install-r6tl8              0/1       Completed   0          1m
   istio-pilot-6c5c6b586c-vmk7m                2/2       Running     0          1m
   istio-policy-5c7fbb4b9f-55gvc               2/2       Running     0          1m
   istio-sidecar-injector-dbd67c88d-fbcl8      1/1       Running     0          1m
   istio-statsd-prom-bridge-6dbb7dcc7f-ns2mq   1/1       Running     0          1m
   istio-telemetry-54b5bf4847-vks9v            2/2       Running     0          1m
   prometheus-586d95b8d9-gk2hq                 1/1       Running     0          1m
   ```
   {: screen}

Good work! You successfully installed Istio into your cluster. Next, deploy the BookInfo sample app into your cluster.


## Lesson 2: Deploy the BookInfo app
{: #istio_tutorial2}

Deploy the BookInfo sample app's microservices to your Kubernetes cluster.
{:shortdesc}

These four microservices include a product web page, book details, reviews (with several versions of the review microservice), and ratings. You can find all files that are used in this example in your Istio installation's `samples/bookinfo` directory.

When you deploy BookInfo, Envoy sidecar proxies are injected as containers into your app microservices' pods before the microservice pods are deployed. Istio uses an extended version of the Envoy proxy to mediate all inbound and outbound traffic for all microservices in the service mesh. For more about Envoy, see the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/concepts/what-is-istio/overview.html#envoy).

1. Deploy the BookInfo app. The `kube-inject` command adds Envoy to the `bookinfo.yaml` file and uses this updated file to deploy the app. When the app microservices deploy, the Envoy sidecar is also deployed in each microservice pod.

   ```
   kubectl apply -f samples/bookinfo/kube/bookinfo.yaml
   ```
   {: pre}

2. Ensure that the microservices and their corresponding pods are deployed:

   ```
   kubectl get svc
   ```
   {: pre}

   ```
   NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)              AGE
   details         ClusterIP     10.xxx.xx.xxx    <none>        9080/TCP             6m
   kubernetes      ClusterIP     10.xxx.xx.xxx    <none>        443/TCP              30m
   productpage     ClusterIP     10.xxx.xx.xxx    <none>        9080/TCP             6m
   ratings         ClusterIP     10.xxx.xx.xxx    <none>        9080/TCP             6m
   reviews         ClusterIP     10.xxx.xx.xxx    <none>        9080/TCP             6m
   ```
   {: screen}

   ```
   kubectl get pods
   ```
   {: pre}

   ```
   NAME                                        READY     STATUS    RESTARTS   AGE
   details-v1-1520924117-48z17                 1/1       Running   0          6m
   productpage-v1-560495357-jk1lz              1/1       Running   0          6m
   ratings-v1-734492171-rnr5l                  1/1       Running   0          6m
   reviews-v1-874083890-f0qf0                  1/1       Running   0          6m
   reviews-v2-1343845940-b34q5                 1/1       Running   0          6m
   reviews-v3-1813607990-8ch52                 1/1       Running   0          6m
   ```
   {: screen}

3. To verify the app deployment, either set up a URL for a standard cluster or get the public IP address of a worker node for a free cluster.

    * For standard clusters:

      1. Expose the BookInfo app by creating an Ingress gateway. The gateway allows Istio features, such as monitoring and route rules, to be applied to traffic entering the cluster.

          ```
          kubectl create -f samples/bookinfo/kube/bookinfo-gateway.yaml
          ```
          {: pre}

      2. Get the IBM **Ingress subdomain** and **Ingress secret** for your cluster. The subdomain and secret are pre-registered for your cluster and are used as a unique public URL for the BookInfo app.

          ```
          bx cs cluster-get <cluster_name_or_ID>
          ```
          {: pre}

      3. Create the following resource YAML file for the IBM Ingress ALB. Replace <Ingress_subdomain> and <Ingress_secret> with the values that you found in the previous step.

          ```
          apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            name: myingress
            annotations:
              ingress.bluemix.net/istio-services: "enabled=true serviceName=productpage istioServiceNamespace=default istioServiceName=gateway"
          spec:
            tls:
            - hosts:
              - <Ingress_subdomain>
            secretName: <Ingress_secret>
            rules:
            - host: <Ingress_subdomain>
              http:
                paths:
                - path: /productpage
                  backend:
                    serviceName: productpage
                    servicePort: 9080
                - path: /login
                  backend:
                    serviceName: productpage
                    servicePort: 9080
                - path: /logout
                  backend:
                    serviceName: productpage
                    servicePort: 9080
                - path: /api/v1/products.*
                  backend:
                    serviceName: productpage
                    servicePort: 9080
          ```
          {: pre}

          The [annotation](cs_annotations.html#istio-annotations) in this resource, `ingress.bluemix.net/istio-services`, enables the cluster ALB to route HTTPS requests to the Istio Ingress gateway for the BookInfo app. The Istio Ingress gateway allows the requests to be routed to the BookInfo productpage service based on the specified paths: `/productpage`, `/login`, `/logout`, and `/api/v1/products.*`.

      4. Save the Ingress resource file in the `samples/bookinfo/kube` folder.

      5. Create the Ingress resource for your cluster ALB.

          ```
          kubectl apply -f samples/bookinfo/kube/myingress.yaml
          ```
          {: pre}

      5. In a browser, go to `https://<Ingress_subdomain>/productpage` to view the BookInfo web page.

      6. Try refreshing the page several times. Different versions of the reviews section round robin through red stars, black stars, and no stars.

    * For free clusters:

      1. Get the public IP address of any worker node in your cluster.

         ```
         bx cs workers <cluster_name_or_ID>
         ```
         {: pre}

      2. Create a `GATEWAY_URL` environment variable that uses the public IP address of the worker node.

         ```
         export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingress -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
         ```
         {: pre}

      3. Curl the `GATEWAY_URL` variable to check that the BookInfo app is running. A `200` response means that the BookInfo app is running properly with Istio.

         ```
         curl -I http://$GATEWAY_URL/productpage
         ```
         {: pre}

      4. In a browser, go to `http://$GATEWAY_URL/productpage` to view the BookInfo web page.

      5. Try refreshing the page several times. Different versions of the reviews section round robin through red stars, black stars, and no stars.

Good work! You successfully deployed the BookInfo sample app with Istio Envoy sidecars. Next, you can clean up your resources or continue on with more tutorials to explore Istio further.

## Cleanup
{: #istio_tutorial_cleanup}

If you're finished working with Istio and don't want to [continue exploring](#istio_tutorial_whatsnext), then you can clean up the Istio resources in your cluster.
{:shortdesc}

1. Delete all BookInfo services, pods, and deployments in the cluster.

   ```
   samples/bookinfo/kube/cleanup.sh
   ```
   {: pre}

2. Uninstall Istio.

   ```
   kubectl delete -f install/kubernetes/istio.yaml
   ```
   {: pre}

## What's next?
{: #istio_tutorial_whatsnext}

To explore Istio further, you can find more guides in the [Istio documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/).

* [Intelligent Routing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/guides/intelligent-routing.html): This example shows how to route traffic to a specific version of BookInfo's reviews and ratings microservices by using Istio's traffic management capabilities.

* [In-Depth Telemetry ![External link icon](../icons/launch-glyph.svg "External link icon")](https://istio.io/docs/guides/telemetry.html): This example includes how to get uniform metrics, logs, and traces across BookInfo's microservices by using Istio Mixer and the Envoy proxy.
