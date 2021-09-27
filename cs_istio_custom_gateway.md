---

copyright:
  years: 2014, 2021
lastupdated: "2021-09-27"

keywords: kubernetes, iks, envoy, sidecar, mesh, bookinfo

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}
  


# Deploying custom Istio gateways
{: #istio-custom-gateway}

Create an `IstioOperator` (IOP) custom resource that defines your own ingress and egress gateways for Istio-managed app traffic.
{: shortdesc}

By default, one `istio-ingressgateway` deployment is created in the `istio-system` namespace of your cluster. This deployment is exposed as a public load balancer service with an externally accessible IP address. You can then define ports for your Istio-managed apps in a `Gateway` resource, which configures the `istio-ingressgateway` load balancer to listen for inbound HTTP/TCP traffic to those ports. Additionally, one `istio-egressgateway` is created by default and is exposed as a load balancer service to managing outbound traffic from your Istio-managed apps.

However, you might want to create additional ingress or egress gateway deployments beyond these default gateways. For example, you might create additional gateways to run alongside the default gateways or to run in place of the default gateways for the following reasons:
* Separate traffic flows between certain workloads or namespaces
* Create an ingress gateway for private network traffic
* Modify a gateway with customizations, such as gateway pod node affinity, minimum replicas, and zone-specific load balancers
* Control gateway version updates independently of automatic version updates that are rolled out for all components of the managed Istio add-on

## Considerations
{: #considerations}

Before you begin, review the following considerations for using custom gateways.
{: shortdesc}

* The managed Istio add-on does not manage or reconcile any custom gateways that you create. You are responsible for creating, managing, and maintaining these resources.
* If you use a custom `IstioOperator` (IOP) resource and plan to enable version 1.8 of the add-on or update your add-on from an unsupported version to 1.8, you must first remove the `revision` field from the resource so that the custom gateways use version 1.8 of `istiod`. After you update your Istio add-on, update the `tag` for any custom gateways to 1.8.
* If you need to debug your custom ingress or egress gateway setups, check the logs for the `addon-istio-operator` (Istio version 1.10 or later) or `managed-istio-operator` (Istio version 1.19 or earlier) pod by running `kubectl logs -n ibm-operators -l name=managed-istio-operator`. The Istio operator validates and reconciles any custom Istio operator (IOP) changes that you make. Additionally, ensure that the `istio-global-proxy-accessLogFile` option in the [`managed-istio-custom` configmap](/docs/containers?topic=containers-istio#customize) is set to `"/dev/stdout"`. Envoy proxies print access information to their standard output, which you can view by running `kubectl logs` commands for the Envoy containers.

## Creating a custom ingress gateway for public traffic
{: #custom-ingress-gateway-public}

Use an `IstioOperator` (IOP) to create a custom ingress gateway deployment and public load balancer service in a `custom-gateways` namespace.
{: shortdesc}

1. [Install the Istio add-on](/docs/containers?topic=containers-istio#istio_install).

2. Create a namespace for the custom ingress gateway.
    ```
    kubectl create namespace custom-gateways
    ```
    {: pre}

3. Create a YAML file that is named `custom-ingress-iop.yaml` for an `IstioOperator` (IOP) resource. To force the custom gateway pods to run a specific version of managed Istio, specify the version in the `tag` field. For more information, see [Controlling custom gateway updates and versions](#custom-gateway-version).
    ```yaml
    apiVersion: install.istio.io/v1alpha1
    kind: IstioOperator
    metadata:
      namespace: ibm-operators
      name: custom-ingressgateway-iop
    spec:
      profile: empty
      hub: icr.io/ext/istio
      # tag: 1.10.3
      components:
        ingressGateways:
          - name: custom-ingressgateway
            label:
              istio: custom-ingressgateway
            namespace: custom-gateways
            enabled: true
            k8s:
              serviceAnnotations:
                service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: public
    ```
    {: codeblock}

4. Create the `IstioOperator` (IOP) resource in your cluster. The managed Istio operator in the `ibm-operators` namespace uses the IOP resource to deploy and expose the ingress gateway in the `custom-gateways` namespace with a public load balancer service.
    ```
    kubectl apply -f ./custom-ingress-iop.yaml
    ```
    {: pre}

5. Verify that the ingress gateway deployment and service are created in the `custom-gateways` namespace.
    ```
    kubectl get deploy,svc -n custom-gateways
    ```
    {: pre}

    Example output
    ```
    NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/custom-ingressgateway   1/1     1            1           4m53s

    NAME                            TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                                                                                                                                      AGE
    service/custom-ingressgateway   LoadBalancer   172.21.98.120   52.117.68.222   15020:32656/TCP,80:30576/TCP,443:32689/TCP,15029:31885/TCP,15030:30198/TCP,15031:32637/TCP,15032:30869/TCP,31400:30310/TCP,15443:31698/TCP   4m53s
    ```
    {: screen}

6. In the output for the `service/custom-ingressgateway` load balancer, note the IP address (classic clusters) or hostname (VPC clusters) in the `EXTERNAL-IP` column.

You can now specify the name of this ingress gateway load balancer, `custom-ingressgateway`, in a `Gateway` resource that defines the port for your Istio-managed app. Then, you can specify the name of the `Gateway` in a `VirtualService` resource that defines the paths for the microservices in your service mesh. For an example of using a `Gateway` and `VirtualService` with your custom gateway load balancer, try the [BookInfo sample app](#custom-gateway-bookinfo).

### Set up the BookInfo sample
{: #custom-gateway-bookinfo}

Deploy the [BookInfo sample application for Istio](https://istio.io/latest/docs/examples/bookinfo/){: external} to test access to your custom ingress gateway load balancer.
{: shortdesc}

1. Create a `bookinfo` namespace and label the namespace for [automatic sidecar injection](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/){: external}.
    ```
    kubectl create namespace bookinfo
    kubectl label namespace bookinfo istio-injection=enabled
    ```
    {: pre}

2. Deploy the BookInfo sample app. Replace `<version>` with the major.minor version that your managed Istio add-on runs, which you can find by running `ibmcloud ks cluster addon ls -c <cluster_name_or_ID>`.
    ```
    kubectl apply -n bookinfo -f https://raw.githubusercontent.com/istio/istio/release-<version>/samples/bookinfo/platform/kube/bookinfo.yaml
    ```
    {: pre}

2. Ensure that the BookInfo microservices and their corresponding pods are deployed.
    ```
    kubectl get svc -n bookinfo
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
    kubectl get pods -n bookinfo
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

4. Create a YAML file that is called `bookinfo-custom-gateway.yaml` to define `Gateway` and `VirtualService` resources. Note that the `Gateway` resource specifies `custom-ingressgateway` for the name of the custom ingress load balancer that you previously created, and the `VirtualService` resource specifies `bookinfo-gateway` for the name of the `Gateway` resource.
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: Gateway
    metadata:
      name: bookinfo-gateway
    spec:
      selector:
        istio: custom-ingressgateway
      servers:
      - port:
          number: 80
          name: http
          protocol: HTTP
        hosts:
        - "*"
    ---
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: bookinfo
    spec:
      hosts:
      - "*"
      gateways:
      - bookinfo-gateway
      http:
      - match:
        - uri:
            exact: /productpage
        - uri:
            prefix: /static
        - uri:
            exact: /login
        - uri:
            exact: /logout
        - uri:
            prefix: /api/v1/products
        route:
        - destination:
            host: productpage
            port:
              number: 9080
    ```
    {: codeblock}

4. Create the `Gateway` and `VirtualService` resources in your cluster.
    ```
    kubectl apply -f bookinfo-custom-gateway.yaml -n bookinfo
    ```
    {: pre}

5. Using the IP address (classic) or hostname (VPC) that you found for the `service/custom-ingressgateway` load balancer in the previous section, open the product page for the BookInfo app in a browser.
    ```
    http://<IP_OR_HOSTNAME>/productpage
    ```
    {: codeblock}

Your custom ingress gateway load balancer now uses the port in the `Gateway` resource and the microservice paths in the `VirtualService` resource to route traffic to the BookInfo app. Next, you can optionally [create a DNS record for the custom gateway load balancer](#custom-gateway-bookinfo-dns).

### Exposing BookInfo by using an IBM-provided subdomain with TLS
{: #custom-gateway-bookinfo-dns}

Create an IBM-provided subdomain to register the IP address (classic) or hostname (VPC) of the custom gateway load balancer with a DNS record. The TLS certificate that is generated for the subdomain enables HTTPS connections to the BookInfo app.
{: shortdesc}

1. Register the IP address or hostname of the custom gateway load balancer by creating a DNS subdomain. Specify the `custom-gateway` namespace for the TLS secrets.
    * <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic clusters
        ```
        ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP> --secret-namespace custom-gateways
        ```
        {: pre}

    * <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC clusters
        ```
        ibmcloud ks nlb-dns create vpc-gen2 -c <cluster_name_or_ID> --lb-host <LB_hostname> --secret-namespace custom-gateways
        ```
        {: pre}

2. Verify that the subdomain is created.
    ```
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output for classic clusters
    ```
    Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
    ```
    {: screen}

    Example output for VPC clusters
    ```
    Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
    ```
    {: screen}

2. Get the name of the secret for your subdomain.
    ```
    kubectl get secret -n custom-gateways
    ```
    {: pre}

    Example output
    ```
    mycluster-af23f234rwr3asdfasdf-002   kubernetes.io/tls                     2      15m
    ```
    {: screen}

3. In the `bookinfo-custom-gateway.yaml` that you created in the previous section, modify the `bookinfo-gateway` `Gateway` resource by adding an HTTPS port 443 and a TLS section that specifies your subdomain's secret.
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: Gateway
    metadata:
      name: bookinfo-gateway
    spec:
      selector:
        istio: custom-ingressgateway
      servers:
      - port:
          number: 443
          name: https
          protocol: HTTPS
        tls:
          mode: SIMPLE
          credentialName: mycluster-af23f234rwr3asdfasdf-002 # secret name
        hosts:
        - "*"
    ---
    ...
    ```
    {: codeblock}

4. Create the modified `Gateway` resource in your cluster.
    ```
    kubectl apply -f bookinfo-custom-gateway.yaml -n bookinfo
    ```
    {: pre}

5. In a web browser, open the BookInfo product page. Ensure that you use HTTPS for the subdomain that you found in step 2.
    ```
    https://<subdomain>/productpage
    ```
    {: codeblock}


## Creating a custom ingress gateway for private network traffic
{: #custom-ingress-gateway-private}

To create a custom ingress gateway deployment and expose it with a private load balancer service, follow the steps in [Creating a custom ingress gateway for public traffic](#custom-ingress-gateway-public). When you create the IOP in step 3, specify the `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private` annotation, instead of `public`.
{: shortdesc}

Note the following considerations:
* If your classic cluster is connected to private VLANs only, or if your VPC cluster has only the private cloud service endpoint enabled, a private load balancer is created by default when you apply the IOP.
* For classic clusters only, you cannot use the `ibmcloud ks nlb-dns create classic` to create a DNS record and IBM-provided subdomain for the IP address of the custom gateway load balancer.


## Controlling custom gateway updates and versions
{: #custom-gateway-version}

Manually update and control the managed Istio version of custom ingress gateways.
{: shortdesc}

{{site.data.keyword.cloud_notm}} keeps all your Istio components up-to-date by automatically rolling out patch updates to the most recent version of Istio that is supported by {{site.data.keyword.containerlong_notm}}. For example, when patch version 1.10.3 is released, all ingress gateway pods are automatically updated to this latest patch version. Patch versions are completed by using the rolling update strategy to avoid downtime for your apps. However, you might want to prevent automatic updates of custom gateway pods, such as if you want to test for any potential regressions with the latest patch version.

To manage updates for your custom ingress gateways, you might use the following rollout strategy:
1. [Create a custom ingress gateway IOPs](#custom-ingress-gateway-public). In the `tag` field, specify a patch version that is the same or earlier than the control plane version. You can find the control plane version by running `istioctl version`.
2. When a new [patch version is released](/docs/containers?topic=containers-istio-changelog) for the managed Istio add-on, edit the IOP YAML file for one custom gateway to use the latest patch version, and re-apply the IOP in your cluster.
3. After the custom gateway's pods are updated to the latest patch, test any changes to the custom gateway.
4. When you are satisfied with the changes, modify the configurations for the rest of your custom gateways to update them to the latest patch.

Do not set the tag to a version that is later than your Istio add-on's control plane version.
{: note}

Update your custom gateway pods as soon as possible after a version is released. Custom gateways that run earlier versions can be exposed to security vulnerabilities.
{: important}


## Additional gateway customizations
{: custom-gateway-options}

Custom ingress gateways can be configured with additional customizations, including deploying the gateway load balancer to a specific zone, specifying the minimum number of gateway pod replicas, scheduling custom gateway pods onto [edge nodes](/docs/containers?topic=containers-edge), adding `preStop` lifecycle hooks for graceful shutdowns, and specifying anti-affinity and worker node affinity.
{: shortdesc}

Review examples of these additional customizations in the following IOP YAML file.
```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: ibm-operators
  name: custom-ingressgateway-iop
spec:
  profile: empty
  hub: icr.io/ext/istio
  # tag: 1.10.3 # Force the gateway to a specific managed Istio version
  components:
    ingressGateways:
      - name: custom-ingressgateway
        label:
          istio: custom-ingressgateway
        namespace: custom-gateways
        enabled: true
        k8s:
          serviceAnnotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: public
            service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12" # Deploy the load balancer to a specific zone in your cluster
          hpaSpec: # Specify the minimum number of pod replicas
            minReplicas: 2
          tolerations: # Schedule the custom gateway pods onto edge nodes
          - key: dedicated
            value: edge
          overlays:
            - kind: Deployment
              name: custom-ingressgateway
              patches:
                - path: spec.template.spec.containers.[name:istio-proxy].lifecycle # Add lifecycle hooks for graceful shutdowns
                  value:
                    preStop:
                      exec:
                        command: ["sleep", "25"]
                - path: spec.template.spec.affinity # Specify pod anti-affinity and worker node affinity
                  value:
                    podAntiAffinity:
                      preferredDuringSchedulingIgnoredDuringExecution:
                        - podAffinityTerm:
                            labelSelector:
                              matchExpressions:
                                - key: app
                                  operator: In
                                  values:
                                    - custom-ingressgateway
                            topologyKey: kubernetes.io/hostname
                          weight: 100
                    nodeAffinity:
                      preferredDuringSchedulingIgnoredDuringExecution:
                        - preference:
                            matchExpressions:
                              - key: dedicated
                                operator: In
                                values:
                                  - edge
                          weight: 100

```
{: codeblock}


## Creating a custom egress gateway
{: #custom-egress-gateway}

In version 1.8 and later of the managed Istio add-on, you can create custom egress gateways. Egress gateways serve as the exit point for all outbound traffic from apps in the service mesh to external destinations.
{: shortdesc}

For example, to create a custom egress gateway, you can apply the following YAML file for an IOP in your cluster.
```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: ibm-operators
  name: custom-egressgateway-iop
spec:
  profile: empty
  hub: icr.io/ext/istio
  # tag: 1.10.3 # Force the Gateway to a specific version
  components:
    egressGateways:
      - name: custom-egressgateway
        label:
          istio: custom-egressgateway
        namespace: custom-gateways
        enabled: true
```
{: codeblock}

For more information about configuring and using custom egress gateways, see the [Istio open-source documentation](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/){: external}.
{: tip}


## Disabling the default gateways
{: #disable-default-gateways}

If you do not need the default `istio-ingressgateway` or `istio-egressgateway` deployments after you create custom gateways, you can optionally disable them.
{: shortdesc}

If you want you apps to be accessible to clients, ensure that at least one gateway load balancer is enabled and configured to route traffic to your apps. If you disable the default gateway load balancers in all zones, your app is no longer exposed and cannot be accessed externally.
{: note}

1. Edit the `managed-istio-custom` configmap resource.
    ```
    kubectl edit cm managed-istio-custom -n ibm-operators
    ```
    {: pre}

2. Disable the default ingress gateways by setting the `istio-ingressgateway-public-1|2|3-enabled` fields to `"false"`.
    ```
    istio-ingressgateway-public-1-enabled: "false"
    istio-ingressgateway-public-2-enabled: "false"
    istio-ingressgateway-public-3-enabled: "false"
    ```
    {: codeblock}

3. To disable the default egress gateway, add the `istio-egressgateway-public-1-enabled: "false"` field.
    ```
    istio-egressgateway-public-1-enabled: "false"
    ```
    {: codeblock}

4. Save and close the configuration file.

5. Verify that the default gateway services are removed.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}






