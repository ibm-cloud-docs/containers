---

copyright:
  years: 2014, 2020
lastupdated: "2020-03-17"

keywords: kubernetes, nginx, iks multiple ingress controllers, byo controller

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


# Bringing your own Ingress controller
{: #ingress-user_managed}

Bring your own Ingress controller to run on {{site.data.keyword.cloud_notm}} and leverage an IBM-provided hostname and TLS certificate.
{: shortdesc}

In {{site.data.keyword.containerlong_notm}}, IBM-provided application load balancers (ALBs) are based on a custom implementation of the NGINX Ingress controller. However, depending on what your app requires, you might want to configure your own custom Ingress controller instead of using the IBM-provided ALBs. For example, you might want to use the Istio `ingressgateway` load balancer service to control traffic for your cluster. When you bring your own Ingress controller, you are responsible for supplying the controller image, maintaining the controller, updating the controller, and any security-related updates to keep your Ingress controller free from vulnerabilities.

## Classic clusters: Exposing your Ingress controller by creating an NLB and a hostname
{: #user_managed_nlb}

Create a network load balancer (NLB) to expose your custom Ingress controller deployment, and then create a hostname for the NLB IP address.
{: shortdesc}

In classic clusters, bringing your own Ingress controller is supported only for providing public external access to your apps and is not supported for providing private external access.
{: note}

1. Get the configuration file for your Ingress controller ready. For example, you can use the [cloud-generic NGINX community Ingress controller](https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml){: external}. If you use the community controller, edit the `mandatory.yaml` file by following these steps.
  1. Replace all instances of `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Replace all instances of the `app.kubernetes.io/name: ingress-nginx` and `app.kubernetes.io/part-of: ingress-nginx` labels with one `app: ingress-nginx` label.

2. Deploy your own Ingress controller. For example, to use the cloud-generic NGINX community Ingress controller, run the following command.
    ```
    kubectl apply -f mandatory.yaml -n kube-system
    ```
    {: pre}

3. Define a load balancer service to expose your custom Ingress deployment.
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: ingress-nginx
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
         port: 80
      externalTrafficPolicy: Cluster
    ```
    {: codeblock}

4. Create the service in your cluster.
  ```
  kubectl apply -f ingress-nginx.yaml -n kube-system
  ```
  {: pre}

5. Get the **EXTERNAL-IP** address for the load balancer.
    ```
    kubectl get ingress-nginx -n kube-system
    ```
    {: pre}

    In the following example output, the **EXTERNAL-IP** is `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Register the load balancer IP address by creating a new DNS hostname or by using the existing Ingress subdomain for your cluster. If you plan to continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, you must create a new DNS hostname.
  * Create a new DNS hostname:
      1. Register the NLB IP address with a DNS hostname.
        ```
        ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <LB_IP>
        ```
        {: pre}
      2. Verify that the hostname is created.
        ```
        ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
        ```
        {: pre}

        Example output:
        ```
        Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
        mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
        ```
        {: screen}
      3. Optional: [Enable health checks on the hostname by creating a health monitor](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).
  * Use the existing Ingress subdomain for your cluster:
      1. Get the Ingress subdomain for your cluster.
        ```
        ibmcloud ks cluster get -c <cluster> | grep Ingress
        ```
        {: pre}

      2. Get the existing ALB IP addresses that are registered by default with the Ingress subdomain. In the output, look for the **IP(s)** that are registered for the Ingress subdomain for your cluster.
        ```
        ibmcloud ks nlb-dns ls -c <cluster>
        ```
        {: pre}

        Example output:
        ```
        Hostname                                                                               IP(s)                       Health Monitor   SSL Cert Status   SSL Cert Secret Name                               Secret Namespace
        mycluster-35366fb2d3d90fd50548180f69e7d12a-0000.us-south.containers.appdomain.cloud    169.XX.XX.X,169.XX.XXX.XX   enabled          created           mycluster                                          default
        ```
        {: screen}

      3. Remove the ALB IP addresses from the subdomain. If you have a multizone cluster, run this command for each ALB IP address.
        ```
        ibmcloud ks nlb-dns rm classic --cluster <cluster> --ip <ALB_IP> --nlb-host <Ingress_subdomain>
        ```
        {: pre}

      4. Add the IP address for your load balancer to the subdomain.
        ```
        ibmcloud ks nlb-dns add classic --cluster <cluster> --ip <load_balancer_IP> --nlb-host <Ingress_subdomain>
        ```
        {: pre}

      5. Get the ID of the ALB.
        ```
        ibmcloud ks albs --cluster <cluster-name>
        ```
        {: pre}

      6. Disable the ALB.
        ```
        ibmcloud ks alb configure classic --alb-id <alb-id> --disable
        ```
        {: pre}

      7. Verify that your load balancer is now registered with the Ingress subdomain.
        ```
        ibmcloud ks nlb-dns ls -c <cluster>
        ```
        {: pre}
7. Deploy any other resources that are required by your custom Ingress controller, such as the configmap. If you used the cloud-generic NGINX community Ingress controller in step 1, you can skip this step because the resources are already included in the `mandatory.yaml` file.

8. Create Ingress resources for your apps. You can use the Kubernetes documentation to create [an Ingress resource file](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external} and use [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/){: external}.
  <p class="tip">If you continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, you can create separate Ingress resources for your ALBs and custom controller. In the [Ingress resource that you create to apply to the IBM ALBs only](/docs/containers?topic=containers-ingress#ingress_expose_public), add the annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

9. Access your app by using the subdomain you configured in step 6 and the path that your app listens on that you specified in the Ingress resource file.
  ```
  https://<host_name>/<app_path>
  ```
  {: codeblock}

## VPC clusters: Exposing your Ingress controller by creating a VPC load balancer and subdomain
{: #user_managed_vpc}

Expose your custom Ingress controller deployment to the public or to the private network by setting up a Kubernetes `LoadBalancer` service in your cluster. A VPC load balancer which routes requests to your app is automatically created for you in your VPC outside of your cluster.
{: shortdesc}

1. Get the configuration file for your Ingress controller ready. For example, you can use the [cloud-generic NGINX community Ingress controller](https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml){: external}. If you use the community controller, edit the `mandatory.yaml` file by following these steps.
  1. Replace all instances of `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Replace all instances of the `app.kubernetes.io/name: ingress-nginx` and `app.kubernetes.io/part-of: ingress-nginx` labels with one `app: ingress-nginx` label.

2. Deploy your own Ingress controller. For example, to use the cloud-generic NGINX community Ingress controller, run the following command.
    ```
    kubectl apply -f mandatory.yaml -n kube-system
    ```
    {: pre}

3. Define a Kubernetes `LoadBalancer` service to expose your custom Ingress deployment.
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: ingress-nginx
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
         port: 80
    ```
    {: codeblock}

4. Create the Kubernetes `LoadBalancer` service in your cluster.
    ```
    kubectl apply -f ingress-nginx.yaml -n kube-system
    ```
    {: pre}

5. Verify that the Kubernetes `LoadBalancer` service is created successfully in your cluster. When the service is created, copy the hostname that is assigned by the VPC load balancer in the **LoadBalancer Ingress** field.

  **The VPC load balancer takes a few minutes to provision in your VPC.** You cannot access the hostname of your Kubernetes `LoadBalancer` service until the VPC load balancer is fully provisioned.
  {: note}
  ```
  kubectl describe svc myloadbalancer
  ```
  {: pre}

  In the following example output, the **LoadBalancer Ingress** hostname is `1234abcd-us-south.lb.appdomain.cloud`:
  ```
  Name:                     myloadbalancer
  Namespace:                default
  Labels:                   <none>
  Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                              {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{"service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type":"public"},...
                            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: public
  Selector:                 run=webserver
  Type:                     LoadBalancer
  IP:                       172.21.106.166
  LoadBalancer Ingress:     1234abcd-us-south.lb.appdomain.cloud
  Port:                     <unset>  8080/TCP
  TargetPort:               8080/TCP
  NodePort:                 <unset>  30532/TCP
  Endpoints:
  Session Affinity:         None
  External Traffic Policy:  Cluster
  Events:
    Type    Reason                Age   From                Message
    ----    ------                ----  ----                -------
    Normal  EnsuringLoadBalancer  52s   service-controller  Ensuring load balancer
    Normal  EnsuredLoadBalancer   35s   service-controller  Ensured load balancer
  ```
  {: screen}

6. To register the VPC load balancer hostname, create a new DNS subdomain or use the existing Ingress subdomain for your cluster. If you plan to continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, you must create a new DNS subdomain.
  * Create a new DNS subdomain:
      1. Create a DNS entry for the VPC load balancer hostname by creating a subdomain with an SSL certificate.
        ```
        ibmcloud ks nlb-dns create vpc-classic --cluster <cluster_name_or_id> --lb-host <vpc_lb_hostname> --type (public|private)
        ```
        {: pre}

      2. Verify that the subdomain is created.
        ```
        ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
        ```
        {: pre}

        Example output:
        ```
        Subdomain                                                                               Load Balancer Hostname                        Health Monitor   SSL Cert Status           SSL Cert Secret Name
        mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud     ["1234abcd-us-south.lb.appdomain.cloud"]      None             created                   <certificate>
        ```
        {: screen}
  * Use the existing Ingress subdomain for your cluster:
      1. Get the Ingress subdomain.
        ```
        ibmcloud ks cluster get -c <cluster> | grep Ingress
        ```
        {: pre}

      2. Register the VPC load balancer hostname with your Ingress subdomain. This command replaces the ALB hostname that was previously registered with your VPC load balancer hostname.
        ```
        ibmcloud ks nlb-dns replace --cluster <cluster> --nlb-subdomain <Ingress_subdomain> --lb-host <VPC_lb_hostname>
        ```
        {: pre}

      3. Verify that your VPC load balancer hostname is now registered with the Ingress subdomain.
        ```
        ibmcloud ks nlb-dns ls -c <cluster>
        ```
        {: pre}

7. Deploy any other resources that are required by your custom Ingress controller, such as the configmap. If you used the cloud-generic NGINX community Ingress controller in step 1, you can skip this step because the resources are already included in the `mandatory.yaml` file.

8. Create Ingress resources for your apps. You can use the Kubernetes documentation to create [an Ingress resource file](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external} and use [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/){: external}.
  <p class="tip">If you continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, you can create separate Ingress resources for your IBM ALBs and custom controller. In the [Ingress resource that you create to apply to the IBM ALBs only](/docs/containers?topic=containers-ingress#ingress_expose_public), add the annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

9. Access your app by using the subdomain you configured in step 6 and the path that your app listens on that you specified in the Ingress resource file. If you created a subdomain for a private VPC load balancer, you must be [connected to your private VPC network](/docs/vpc-on-classic-network?topic=vpc-on-classic-network---using-vpn-with-your-vpc) to test access to your subdomain.
  ```
  https://<load_balancer_subdomain>/<app_path>
  ```
  {: codeblock}



