---

copyright:
  years: 2014, 2021
lastupdated: "2021-08-13"

keywords: kubernetes, nginx, iks multiple ingress controllers, byo controller

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
{:audio: .audio}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: .ph data-hd-programlang='c#'}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: #curl .ph data-hd-programlang='curl'}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: .external target="_blank"}
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
{:middle: .ph data-hd-position='middle'}
{:navgroup: .navgroup}
{:new_window: target="_blank"}
{:node: .ph data-hd-programlang='node'}
{:note: .note}
{:objectc: .ph data-hd-programlang='Objective C'}
{:objectc: data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: .ph data-hd-programlang='PHP'}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:right: .ph data-hd-position='right'}
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
{:step: data-tutorial-type='step'} 
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:terraform: .ph data-hd-interface='terraform'}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:topicgroup: .topicgroup}
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

 


# Bringing your own Ingress controller
{: #ingress-user_managed}

Bring your own Ingress controller to run on {{site.data.keyword.cloud_notm}} and leverage an IBM-provided hostname and TLS certificate.
{: shortdesc}

In {{site.data.keyword.containerlong_notm}}, application load balancers (ALBs) are created for you by default. Two types of images are supported for ALBs: the {{site.data.keyword.containerlong_notm}} custom implementation of the NGINX Ingress controller, and the community Kubernetes implementation of the NGINX Ingress controller. However, depending on what your app requires, you might want to configure your own custom Ingress controller instead of using the IBM-provided ALBs. For example, you might want to use the Istio `ingressgateway` load balancer service to control traffic for your cluster. When you bring your own Ingress controller, you are responsible for supplying the controller image, maintaining the controller, updating the controller, and any security-related updates to keep your Ingress controller free from vulnerabilities.

Looking to use the community Kubernetes implementation of the NGINX Ingress controller? As of 24 August 2020, {{site.data.keyword.containerlong_notm}} supports the Kubernetes Ingress image for ALBs in your cluster. You can [change your ALBs from the {{site.data.keyword.containerlong_notm}} Ingress image to the Kubernetes Ingress image](/docs/containers?topic=containers-ingress-types).
{: tip}

If you choose to bring your own Ingress controller, IBM does not provide support for your Ingress deployment. You are responsible for configuring, updating, and managing your Ingress system. The following sections help you get started, but you are responsible for any changes that you must make to the steps.
{: important}

## Classic clusters: Exposing your Ingress controller by creating an NLB and a hostname
{: #user_managed_nlb}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a network load balancer (NLB) to expose your custom Ingress controller deployment, and then create a hostname for the NLB IP address.
{: shortdesc}

In classic clusters, bringing your own Ingress controller is supported only for providing public external access to your apps and is not supported for providing private external access.
{: note}

1. Get the configuration file for your Ingress controller ready. For example, you can use the [cloud-generic NGINX community Ingress controller](https://github.com/kubernetes/ingress-nginx/blob/main/deploy/static/provider/cloud/deploy.yaml){: external}. If you use the community controller, edit the `deploy.yaml` file by following these steps.
  1. Replace all instances of `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Replace all instances of the `app.kubernetes.io/name: ingress-nginx` and `app.kubernetes.io/instance: ingress-nginx` labels with one `app: ingress-nginx` label.

2. Deploy your own Ingress controller. For example, to use the cloud-generic NGINX community Ingress controller, run the following command.
    ```
    kubectl apply -f deploy.yaml -n kube-system
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
       - name: http
         protocol: TCP
         port: 80
       - name: https
         protocol: TCP
         port: 443
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
    kubectl get svc ingress-nginx -n kube-system
    ```
    {: pre}

    In the following example output, the **EXTERNAL-IP** is `168.1.1.1`.
    ```
    NAME             TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    ingress-nginx    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
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
        ibmcloud ks nlb-dns add --cluster <cluster> --ip <load_balancer_IP> --nlb-host <Ingress_subdomain>
        ```
        {: pre}

      5. If you do not plan to continue to use IBM-provided ALBs concurrently with your custom Ingress controller:
          1. Get the ID of the ALBs.
            ```
            ibmcloud ks ingress alb ls --cluster <cluster-name>
            ```
            {: pre}

          2. Disable each ALB.
            ```
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

      6. Verify that your load balancer is now registered with the Ingress subdomain.
        ```
        ibmcloud ks nlb-dns ls -c <cluster>
        ```
        {: pre}
7. Deploy any other resources that are required by your custom Ingress controller, such as the configmap. If you used the cloud-generic NGINX community Ingress controller in step 1, you can skip this step because the resources are already included in the `deploy.yaml` file.

8. Create Ingress resources for your apps. You can use the Kubernetes documentation to create [an Ingress resource file](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external} and use [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/){: external}.
  <p class="important">If you continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, create separate Ingress resources for your ALBs and custom controller. In the [Ingress resource that you create to apply to the IBM ALBs only](/docs/containers?topic=containers-ingress-types#alb-comm-create), you must add the annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

9. Access your app by using the subdomain you configured in step 6 and the path that your app listens on that you specified in the Ingress resource file.
  ```
  https://<host_name>/<app_path>
  ```
  {: codeblock}

## VPC clusters: Exposing your Ingress controller by creating a VPC load balancer and subdomain
{: #user_managed_vpc}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Expose your custom Ingress controller deployment to the public or to the private network by setting up a Kubernetes `LoadBalancer` service in your cluster. A VPC load balancer which routes requests to your app is automatically created for you in your VPC outside of your cluster.
{: shortdesc}

1. Get the configuration file for your Ingress controller ready. For example, you can use the [cloud-generic NGINX community Ingress controller]( https://github.com/kubernetes/ingress-nginx/blob/main/deploy/static/provider/cloud/deploy.yaml){: external}. If you use the community controller, edit the `deploy.yaml` file by following these steps.
  1. Replace all instances of `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Replace all instances of the `app.kubernetes.io/name: ingress-nginx` and `app.kubernetes.io/instance: ingress-nginx` labels with one `app: ingress-nginx` label.
  3. Remove the `LimitRange` object.

2. Deploy your own Ingress controller. For example, to use the cloud-generic NGINX community Ingress controller, run the following command.
    ```
    kubectl apply -f deploy.yaml -n kube-system
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
       - name: http
         protocol: TCP
         port: 80
       - name: https
         protocol: TCP
         port: 443
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
  kubectl describe svc ingress-nginx -n kube-system
  ```
  {: pre}

  In the following example output, the **LoadBalancer Ingress** hostname is `1234abcd-us-south.lb.appdomain.cloud`:
  ```
  Name:                     ingress-nginx
  Namespace:                kube-system
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
        ibmcloud ks nlb-dns create vpc-gen2 --cluster <cluster_name_or_id> --lb-host <vpc_lb_hostname> --type (public|private)
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

      3. If you do not plan to continue to use IBM-provided ALBs concurrently with your custom Ingress controller:
          1. Get the ID of the ALBs.
            ```
            ibmcloud ks ingress alb ls --cluster <cluster-name>
            ```
            {: pre}

          2. Disable each ALB.
            ```
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

      4. Verify that your VPC load balancer hostname is now registered with the Ingress subdomain.
        ```
        ibmcloud ks nlb-dns ls -c <cluster>
        ```
        {: pre}

7. Deploy any other resources that are required by your custom Ingress controller, such as the configmap. If you used the cloud-generic NGINX community Ingress controller in step 1, you can skip this step because the resources are already included in the `deploy.yaml` file.

8. Create Ingress resources for your apps. You can use the Kubernetes documentation to create [an Ingress resource file](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external} and use [annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/){: external}.
  <p class="tip">If you continue to use IBM-provided ALBs concurrently with your custom Ingress controller in one cluster, you can create separate Ingress resources for your IBM ALBs and custom controller. In the [Ingress resource that you create to apply to the IBM ALBs only](/docs/containers?topic=containers-ingress-types#alb-comm-create), add the annotation <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

9. Access your app by using the subdomain you configured in step 6 and the path that your app listens on that you specified in the Ingress resource file. If you created a subdomain for a private VPC load balancer, you must be [connected to your private VPC network](/docs/vpc?topic=vpc-vpn-onprem-example) to test access to your subdomain.
  ```
  https://<load_balancer_subdomain>/<app_path>
  ```
  {: codeblock}
