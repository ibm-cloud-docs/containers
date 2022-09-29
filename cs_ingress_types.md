---

copyright:
  years: 2014, 2022
lastupdated: "2022-09-29"

keywords: kubernetes, nginx, ingress controller

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Setting up Kubernetes Ingress
{: #ingress-types}

Expose multiple apps in your {{site.data.keyword.containerlong}} cluster by creating Ingress resources that are managed by IBM-provided application load balancers.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} supports only the Kubernetes Ingress image for the Ingress application load balancers (ALBs) in your cluster. The Kubernetes Ingress image is built on the community Kubernetes project's implementation of the NGINX Ingress controller. The previously supported {{site.data.keyword.containerlong_notm}} Ingress image, which was built on a custom implementation of the NGINX Ingress controller, is unsupported.
{: shortdesc}

**Clusters created on or after 01 December 2020**: Default application load balancers (ALBs) run the Kubernetes Ingress image in all new {{site.data.keyword.containerlong_notm}} clusters.

**Clusters created before 01 December 2020**:
* Existing clusters with ALBs that run the custom IBM Ingress image continue to operate as-is.
* Support for the custom IBM Ingress image ended on 02 June 2021.
* You must move to the new Kubernetes Ingress by migrating any existing Ingress setups. Your existing ALBs and other Ingress resources are not automatically migrated to the new Kubernetes Ingress image.
* Any ALBs with the unsupported image continue to run, but are not supported by IBM.

Not ready to switch your ALBs to the Kubernetes Ingress image yet? The custom {{site.data.keyword.containerlong_notm}} Ingress image is available as an [open source project](https://github.com/IBM-Cloud/iks-ingress-controller/){: external}. Note that this project is not officially supported by {{site.data.keyword.cloud_notm}}. You are responsible for deploying, managing, and maintaining the Ingress controllers in your cluster.
{: tip}

If you use the [Kubernetes Ingress controller](https://github.com/kubernetes/ingress-nginx){: external}, Prometheus metrics are enabled by default, which might result in additional billing.

## Prerequisites
{: #config_prereqs}

Before you get started with Ingress, review the following prerequisites.
{: shortdesc}

- Classic clusters: Enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint#vrf) for your IBM Cloud infrastructure account. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint#vrf). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). When a VRF or VLAN spanning is enabled, the ALB can route packets to various subnets in the account.
- VPC clusters: Ensure that traffic requests that are routed by Ingress to node ports on your worker nodes are permitted in [VPC security groups](/docs/openshift?topic=openshift-vpc-security-group).
- Setting up Ingress requires the following [{{site.data.keyword.cloud_notm}} IAM roles](/docs/containers?topic=containers-users#checking-perms):
    - **Administrator** platform access role for the cluster
    - **Manager** service access role in all namespaces
- Ingress is available for standard clusters only and requires at least two worker nodes per zone to ensure high availability and to apply periodic updates. If you have only one worker node in a zone, the ALB can't receive automatic updates. When automatic updates are rolled out to ALB pods, the pod is reloaded. However, ALB pods have anti-affinity rules to ensure that only one pod is scheduled to each worker node for high availability. If you have only one ALB pod on one worker, the pod is not restarted so that traffic is not interrupted, and the ALB pod is updated to the latest version only when you delete the old pod manually so that an updated pod can be scheduled.
- If you restrict network traffic to edge worker nodes, ensure that at least two [edge worker nodes](/docs/containers?topic=containers-edge) are enabled in each zone so that ALBs deploy uniformly.
- To be included in Ingress load balancing, the names of the `ClusterIP` services that expose your apps must be unique across all namespaces in your cluster.
- If a zone fails, you might see intermittent failures in requests to the Ingress ALB in that zone.
- Note that if you create and delete a cluster with the same or similar name 5 times or more within 7 days, such as for automation or testing purposes, you might reach the [Let's Encrypt Duplicate Certificate rate limit](/docs/containers?topic=containers-cs_rate_limit). To ensure that the Ingress subdomain and certificate are correctly registered, the first 24 characters of the clusters' names must be different.

## Publicly exposing apps with ALBs that run the Kubernetes Ingress image
{: #alb-comm-create}

Create Ingress resources so that public ALBs that run the community Kubernetes Ingress image can route traffic to your apps.
{: shortdesc}

The following steps show you how to expose your apps with the Kubernetes Ingress setup. If you created your cluster on or after 01 December 2020, your ALBs run the Kubernetes Ingress image by default. However, if you created your cluster before 01 December 2020, your ALBs run the unsupported custom IBM Ingress image. In this case, you can use the following steps to create new ALBs that run the Kubernetes Ingress image, and run this new Kubernetes Ingress setup alongside your existing IBM Ingress setup. 
{: tip}

### Step 1: Create an app service and select a domain
{: #alb-comm-create-service-domain}

Start by creating a `ClusterIP` service for your app. Then, determine which type of Ingress domain you want to use.
{: shortdesc}

1. For each app deployment that you want to expose, create a Kubernetes `ClusterIP` service. Your app must be exposed by a Kubernetes service to be included in the Ingress load balancing.

    ```sh
    kubectl expose deploy <app_deployment_name> --name my-app-svc --port <app_port> -n <namespace>
    ```
    {: pre}
    
2. Choose a domain and set up TLS for your apps. You can use the IBM-provided domain, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`, or define a custom domain.

### Step 2: Set up the Ingress domain
{: #alb-com-setup-domain}

Complete the steps to use an IBM-provided or custom domain.
{: shortdesc}

#### To use the IBM-provided Ingress domain:
{: #alb-com-create-ibm-domain}

1. Get your cluster's Ingress subdomain and secret.

    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID> | grep Ingress
    ```
    {: pre}

    Example output

    ```sh
    Ingress Subdomain:      mycluster-<hash>-0000.us-south.containers.appdomain.cloud
    Ingress Secret:         mycluster-<hash>-0000
    ```
    {: screen}

2. If you want to use TLS and your apps are deployed in a namespace other than `default`, you must re-create the secret in the namespace where your apps exist. To find the CRN for the default Ingress secret, run `ibmcloud ks ingress secret get -c <cluster> --name <secret_name> --namespace default`. Alternatively, you can set the secret as the `defaultCertificate` in the [`ibm-ingress-deploy-config` ConfigMap](/docs/containers?topic=containers-comm-ingress-annotations#comm-customize-deploy).

    ```sh
    ibmcloud ks ingress secret create --cluster <cluster_name_or_ID> --cert-crn <CRN> --name <secret_name> --namespace <namespace>
    ```
    {: pre}

#### To use a custom domain:
{: #alb-comm-create-custom}


1. Create a custom domain. To register your custom domain, work with your Domain Name Service (DNS) provider or [{{site.data.keyword.cloud_notm}} DNS](/docs/dns?topic=dns-getting-started). If the apps that you want Ingress to expose are in different namespaces in one cluster, register the custom domain as a wildcard domain, such as `*.custom_domain.net`. Note that domains are limited to 130 characters or fewer in Kubernetes version 1.20 or later.

2. Define an alias for your custom domain by specifying the IBM-provided domain as a Canonical Name record (CNAME). To find the IBM-provided Ingress domain, run `ibmcloud ks cluster get --cluster <cluster_name>` and look for the **Ingress subdomain** field.

3. To use TLS termination, create a secret in the namespace where your apps exist that contains your own TLS certificate. For example, if a TLS certificate is stored in {{site.data.keyword.cloudcerts_long_notm}} that you want to use, you can import its associated secret into your cluster by running the following command.

    ```sh
    ibmcloud ks ingress secret create --name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn> [--namespace <namespace>]
    ```
    {: pre}

### Step 3: Create the Ingress resource
{: #alb-comm-create-ingress-resource}

Create the Ingress resource to define the routing rules that the Ingress controller uses to route traffic to your app service.
{: shortdesc}

1. Create an Ingress resource that is formatted for use with ALBs that run the Kubernetes Ingress image.
    1. Define an Ingress resource file that uses the IBM-provided domain or your custom domain to route incoming network traffic to the services that you created earlier. Note that the format of the Ingress resource definition varies based on your cluster's Kubernetes version, because API version `networking.k8s.io/v1beta1` is unsupported as of Kubernetes 1.22.

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: community-ingress-resource
      annotations:
        kubernetes.io/ingress.class: "public-iks-k8s-nginx"
    spec:
      tls:
      - hosts:
        - HOSTNAME
        secretName: SECRET_NAME
      rules:
      - host: HOSTNAME
        http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx
                port:
                  number: 80
          - path: /auth
            pathType: Prefix
            backend:
              service:
                name: nginx-auth
                port:
                  number: 80

    ```
    {: codeblock}

    `annotations`
    :   `kubernetes.io/ingress.class: "public-iks-k8s-nginx"`: Apply this Ingress resource to the public ALBs that run the Kubernetes Ingress image in your cluster. For configurations in which another component manages your Ingress ALBs, such as if Ingress is deployed as part of a Helm chart, don't specify this annotation. Instead, find the Ingress class for your configuration, and specify that class in a `spec.ingressClassName: <class_name>` field. You must also specify this custom class in an [`IngressClass`](#ingress-class-custom) resource and a `ibm-ingress-deploy-config` configmap. To customize routing for Ingress, you can add [Kubernetes NGINX annotations](/docs/containers?topic=containers-comm-ingress-annotations#annotations) (`nginx.ingress.kubernetes.io/<annotation>`). Custom {{site.data.keyword.containerlong_notm}} annotations (`ingress.bluemix.net/<annotation>`) are not supported.

    `tls.hosts`
    :   To use TLS, replace `<domain>` with the IBM-provided Ingress subdomain or your custom domain.

    `tls.secretName`
    :   Replace `<tls_secret_name>` with the name of the TLS secret for your domain.

    `host`
    :   Replace `domain` with the IBM-provided Ingress subdomain or your custom domain.

    `path`
    :   Replace `app_path` with a slash or the path that your app is listening on. The path is appended to the IBM-provided or your custom domain to create a unique route to your app. When you enter this route into a web browser, network traffic is routed to the ALB. The ALB looks up the associated service and sends network traffic to the service. The service then forwards the traffic to the pods where the app runs.

    Kubernetes 1.19 and later only: `pathType`
    :   The URL path matching method. Supported values are `ImplementationSpecific`, `Exact`, or `Prefix`. For more information about and examples of each path type, see the [community Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types){: external}.

    `service.name`
    :   Replace `app1_service` and `app2_service`, and so on, with the name of the services you created to expose your apps.

    `service.port.number`
    :   The port that your service listens to. Use the same port that you defined when you created the Kubernetes service for your app.

2. Create the Ingress resource for your cluster. Ensure that the resource deploys into the same namespace as the app services that you specified in the resource.
    ```sh
    kubectl apply -f community-ingress-resource.yaml -n <namespace>
    ```
    {: pre}

3. Clusters created before 01 December 2020 only: Verify that you have at least one ALB in each zone that runs the Kubernetes Ingress image. In the **Build** column of the output, look for versions in the `<community_version>_<ibm_build>_iks` Kubernetes Ingress format.

    ```sh
    ibmcloud ks alb ls -c <cluster_name_or_ID>
    ```
    {: pre}

4. If one ALB per zone runs the Kubernetes Ingress image, continue to the next step. If you don't have one ALB per zone that runs the Kubernetes Ingress image, create at least one in each zone.

    ```sh
    ibmcloud ks ingress alb create <classic|vpc-gen2> --cluster <cluster_name_or_ID> --type public --zone <zone> --vlan <VLAN_ID> --version 1.1.2_2507_iks
    ```
    {: pre}

5. Copy the IP address (classic) or hostname (VPC) for one ALB that runs the Kubernetes Ingress image. In the output, choose an ALB that has a **Build** in the format `<community_version>_<ibm_build>_iks`.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster>
    ```
    {: pre}

6. Use the ALB's IP address (classic) or hostname (VPC), the app path, and your domain to verify that you can successfully send traffic to your app through this ALB.

    ```sh
    curl http://<ALB_IP>/<app_path> -H "Host: <ingress_subdomain>"
    ```
    {: pre}

    For example, to send a request to "myapp" by using a default Ingress subdomain, run the following command.

    ```sh
    curl http://169.X.X.X/myapp -H "Host: mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud"
    ```
    {: pre}

Having trouble connecting to your app through Ingress? Try [Troubleshooting Ingress](/docs/containers?topic=containers-ingress-debug). You can check the health and status of your Ingress components by running `ibmcloud ks ingress status -c <cluster_name_or_ID>`.
{: tip}

## Privately exposing apps with ALBs that run the Kubernetes Ingress image
{: #alb-comm-create-private}

Create Ingress resources so that private ALBs that run the community Kubernetes Ingress image can route traffic to your apps.
{: shortdesc}

The following steps show you how to expose your apps with the Kubernetes Ingress setup. If you created your cluster on or after 01 December 2020, your ALBs run the Kubernetes Ingress image by default. However, if you created your cluster before 01 December 2020, your ALBs run the unsupported custom IBM Ingress image. In this case, you can use the following steps to create new ALBs that run the Kubernetes Ingress image, and run this new Kubernetes Ingress setup alongside your existing IBM Ingress setup.
{: tip}

1. For each app deployment that you want to expose, create a Kubernetes `ClusterIP` service. Your app must be exposed by a Kubernetes service to be included in the Ingress load balancing.

    ```sh
    kubectl expose deploy <app_deployment_name> --name my-app-svc --port <app_port> -n <namespace>
    ```
    {: pre}
    
2. Verify that you have at least one private ALB in each zone that runs the Kubernetes Ingress image. Look for ALBs with a **Type** of `private` and a **Build** version in the `<community_version>_<ibm_build>_iks` Kubernetes Ingress format.

    ```sh
    ibmcloud ks alb ls -c <cluster_name_or_ID>
    ```
    {: pre}

    * If at least one private ALB per zone runs the Kubernetes Ingress image, ensure that the ALBs have a **Status** of `enabled`. If they are disabled, run the following command to enable each ALB.

        ```sh
        ibmcloud ks ingress alb enable <classic|vpc-gen2> --alb <ALB_ID> -c <cluster_name_or_ID> --version 1.1.2_2507_iks
        ```
        {: pre}

    * If you don't have one private ALB per zone that runs the Kubernetes Ingress image, create at least one in each zone.

        ```sh
        ibmcloud ks ingress alb create <classic|vpc-gen2> --cluster <cluster_name_or_ID> --type private --zone <vpc_zone> --version 1.1.2_2507_iks
        ```
        {: pre}

3. Choose a domain and optionally set up TLS for your apps. When you configure the private ALBs, you must expose your apps by using a custom domain.

    1. Classic clusters with only a private VLAN: Configure your own [DNS service that is available on your private network](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.

    2. Create a custom domain through your DNS service provider. **Version 1.20 or later**: Note that Ingress URLs must be 130 characters or fewer.

    3. Map your custom domain to the private ALBs by adding their IP addresses as A records (classic clusters) or their VPC hostname as a CNAME (VPC clusters). To find the ALB IP addresses (classic) or hostname (VPC), run `ibmcloud ks ingress alb ls -c <cluster_name_or_ID>`.

    4. To use TLS termination, create a secret in the namespace where your apps exist that contains a TLS certificate for your custom domain. For example, if a TLS certificate is stored in {{site.data.keyword.cloudcerts_long_notm}} that you want to use, you can import its associated secret into your cluster by running the following command.

        ```sh
        ibmcloud ks ingress secret create --name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn> --namespace <namespace>
        ```
        {: pre}

4. Create an Ingress resource that is formatted for use with ALBs that run the Kubernetes Ingress image.

    1. Define an Ingress resource file that uses your custom domain to route incoming network traffic to the services that you created earlier. Note that the format of the Ingress resource definition varies based on your cluster's Kubernetes version, because API version `networking.k8s.io/v1beta1` is unsupported as of Kubernetes 1.22.

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: Ingress
        metadata:
        name: community-ingress-resource
        annotations:
            kubernetes.io/ingress.class: "private-iks-k8s-nginx"
        spec:
        tls:
        - hosts:
          - <domain>
          secretName: <tls_secret_name>
        rules:
        - host: <hostname>
            http:
            paths:
            - path: / <app_path_1>
                pathType: Prefix
                backend:
                service:
                  name: <servicename>
                  port:
                  number: 80
             - path: / <app_path_2>
                pathType: Prefix
                backend:
                service:
                  name: <servicename>
                  port:
                  number: 80
        ```
        {: codeblock}

        `annotations`
        :   `kubernetes.io/ingress.class: "public-iks-k8s-nginx"`: Apply this Ingress resource to the private ALBs that run the Kubernetes Ingress image in your cluster. For configurations in which another component manages your Ingress ALBs, such as if Ingress is deployed as part of a Helm chart, don't specify this annotation. Instead, find the Ingress class for your configuration, and specify that class in a `spec.ingressClassName: <class_name>` field. You must also specify this custom class in an [`IngressClass`](#ingress-class-custom) resource and a `ibm-ingress-deploy-config` ConfigMap. To customize routing for Ingress, you can add [Kubernetes NGINX annotations](/docs/containers?topic=containers-comm-ingress-annotations#annotations) (`nginx.ingress.kubernetes.io/<annotation>`). Custom {{site.data.keyword.containerlong_notm}} annotations (`ingress.bluemix.net/<annotation>`) are not supported.

        `tls.hosts`
        :   To use TLS, replace `domain` with your custom domain.

        `tls.secretName`
        :   Replace `tls_secret_name` with the name of the TLS secret for your domain.

        `host`
        :   Replace `domain` with your custom domain.

        `path`
        :   Replace `app_path` with a slash or the path that your app is listening on. The path is appended to your custom domain to create a unique route to your app. When you enter this route into a web browser, network traffic is routed to the ALB. The ALB looks up the associated service and sends network traffic to the service. The service then forwards the traffic to the pods where the app runs.

        Kubernetes 1.19 and later only: `pathType`
        The URL path matching method. Supported values are `ImplementationSpecific`, `Exact`, or `Prefix`. For more information about and examples of each path type, see the [community Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types){: external}.

        `service.name`
        :   Replace `app1_service` and `app2_service`, and so on, with the name of the services you created to expose your apps.

        `service.port.number`
        :   The port that your service listens to. Use the same port that you defined when you created the Kubernetes service for your app.

    2. Create the Ingress resource for your cluster. Ensure that the resource deploys into the same namespace as the app services that you specified in the resource.

        ```sh
        kubectl apply -f community-ingress-resource.yaml -n <namespace>
        ```
        {: pre}

5. Copy the IP address (classic) or hostname (VPC) for one private ALB that runs the Kubernetes Ingress image. In the output, choose a private ALB that has a **Build** in the format `<community_version>_<ibm_build>_iks`.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster>
    ```
    {: pre}

6. Ensure that you are connected to your private network, such as through a VPN.

7. Using the ALB's IP address (classic) or hostname (VPC), the app path, and your domain, verify that you can successfully send traffic to your app through this ALB.

    ```sh
    curl http://<ALB_IP>/<app_path> -H "Host: <ingress_subdomain>"
    ```
    {: pre}

    For example, to send a request to "myapp" in a classic cluster:

    ```sh
    curl http://10.X.X.X/myapp -H "Host: mycustomdomain.com"
    ```
    {: pre}


## Customizing the Ingress class
{: #ingress-class}

An Ingress class associates a class name with an Ingress controller type.
{: shortdesc}

An [`IngressClass` resource](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class){: external} associates a class name with an Ingress controller type. When you create Ingress resources to define routing for your apps, you specify the class name in the `spec.ingressClassName` field to apply the Ingress resource to the Ingress controllers that are associated with that class. Note that because the deprecated `kubernetes.io/ingress.class` annotation is still usable in Kubernetes 1.18 and later, classes that are specified in Ingress resources are applied in the following ways.
* If a class is specified either in the `spec.ingressClassName` field or in the deprecated `kubernetes.io/ingress.class` annotation, the class is applied.
* If both the `spec.ingressClassName` field and the `kubernetes.io/ingress.class`annotation are specified, the class in the annotation is used.
* If neither the `spec.ingressClassName` field nor the `kubernetes.io/ingress.class`annotation are specified, the default class is applied.

### Default Ingress classes for public and private ALBs
{: #ingress-class-default}

In {{site.data.keyword.containerlong_notm}} clusters that run Kubernetes version 1.18 or later, `IngressClass` resources are created by default for public and private ALBs.
{: shortdesc}

The default `IngressClass` resources for public ALBs `public-iks-k8s-nginx` and private ALBs `private-iks-k8s-nginx` are not automatically created for existing 1.18 clusters that were created before 01 December 2020. Instead, choose among the following options.
* **Manually create the resources**: To use the new Ingress class functionality instead, you can manually create the following `IngressClass` resources in your cluster and specify the `ingressClassName` field in your Ingress resources.
* **Use the annotation (deprecated)**: Until the annotation becomes unsupported, you can continue to use the `kubernetes.io/ingress.class` annotation in your Ingress resources to specify `public-iks-k8s-nginx` or `private-iks-k8s-nginx` classes.

#### Public ALBs
{: #ingress-class-default-public}

The following `IngressClass` is automatically created in the `kube-system` namespace to configure all public ALBs in your cluster with the `public-iks-k8s-nginx` class. To apply an Ingress resource that you create to the public ALBs in your cluster, specify `ingressClassName: "public-iks-k8s-nginx"` in the `spec` section of your Ingress resource.

The `IngressClass` for public ALBs, `public-iks-k8s-nginx`, is set as the default class in your cluster. If you don't specify an `ingressClassName` field (or the deprecated `kubernetes.io/ingress.class` annotation) in your Ingress resource, the resource is applied to the public ALBs in your cluster.
{: note}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: public-iks-k8s-nginx
  annotations:
    ingressclass.kubernetes.io/is-default-class: "true"
spec:
  controller: "k8s.io/ingress-nginx"
```
{: screen}

#### Private ALBs
{: #ingress-class-default-private}

The following `IngressClass` is automatically created in the `kube-system` namespace to configure all private ALBs in your cluster with the `private-iks-k8s-nginx` class. To apply an Ingress resource that you create to the private ALBs in your cluster, specify `ingressClassName: "private-iks-k8s-nginx"` in the `spec` section of your Ingress resource.

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: private-iks-k8s-nginx
spec:
  controller: "k8s.io/ingress-nginx"
```
{: screen}

### Custom Ingress classes
{: #ingress-class-custom}

You can configure your own classes by creating custom `IngressClass` resources and changing the ALB deployment.
{: shortdesc}

1. Create an `IngressClass` resource. If you want this class to be the default class for your cluster, include the `ingressclass.kubernetes.io/is-default-class: "true"` annotation so that any Ingress resources that don't specify an Ingress class use this class by default.
    For configurations in which another component manages your Ingress ALBs, such as if Ingress is deployed as part of a Helm chart, a class might already be created. In this case, you can continue to step 3.
    {: tip}

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: IngressClass
    metadata:
        name: <class_name>
    annotations:
      ingressclass.kubernetes.io/is-default-class: "true"
    spec:
      controller: "k8s.io/ingress-nginx"
    ```
    {: codeblock}

2. Deploy the `IngressClass` to your cluster.

    ```sh
    kubectl apply -f <class_name>.yaml
    ```
    {: pre}

3. If you want the Kubernetes Ingress ALBs in your cluster to process Ingress resources of this class, [specify the custom class in an `ibm-ingress-deploy-config` ConfigMap and update your ALBs to pick up the changes](/docs/containers?topic=containers-comm-ingress-annotations#comm-customize-deploy).

4. In your Ingress resources, specify the `ingressClassName: "<class_name>"` field in the `spec` section of your Ingress resource. Do not include the deprecated `kubernetes.io/ingress.class` annotation. Note that if you don't specify an Ingress class in an Ingress resource, then the default class is applied.



## Customizing routing and settings by using annotations and configmaps
{: #cm-annotations}

You can modify default ALB settings and add annotations to your Ingress resources.
{: shortdesc}

* To manage how requests are routed to your app, specify [Kubernetes NGINX annotations](/docs/containers?topic=containers-comm-ingress-annotations#annotations) (`nginx.ingress.kubernetes.io/<annotation>`) in your Ingress resources.
* To modify default Ingress settings, such as to enable source IP preservation or configure SSL protocols, [change the `ibm-k8s-controller-config` `ibm-ingress-deploy-config` ConfigMap resources](/docs/containers?topic=containers-comm-ingress-annotations) for your Ingress ALBs.

## Updating ALBs
{: #alb-update}

Choose the image type and image version for your ALBs, and keep the image version for your ALB pods up to date.
{: shortdesc}

### Choosing a supported image version
{: #alb-version-choose}

{{site.data.keyword.containerlong_notm}} supports only the Kubernetes Ingress image for the Ingress application load balancers (ALBs) in your cluster. The Kubernetes Ingress image is built on the community Kubernetes project's implementation of the NGINX Ingress controller. The previously supported {{site.data.keyword.containerlong_notm}} Ingress image, which was built on a custom implementation of the NGINX Ingress controller, is unsupported.
{: shortdesc}

**Clusters created on or after 01 December 2020**: Default application load balancers (ALBs) run the Kubernetes Ingress image in all new {{site.data.keyword.containerlong_notm}} clusters.

**Clusters created before 01 December 2020**:
* Existing clusters with ALBs that run the custom IBM Ingress image continue to operate as-is.
* Support for the custom IBM Ingress image ended on 02 June 2021.
* You must move to the new Kubernetes Ingress by migrating any existing Ingress setups. Your existing ALBs and other Ingress resources are not automatically migrated to the new Kubernetes Ingress image.
* Any ALBs with the unsupported image continue to run, but are not supported by IBM.

You can manage the versions of your ALBs in the following ways:
* When you create a new ALB, enable an ALB that was previously disabled, or manually update an ALB, you can specify an image version for your ALB in the `--version` flag.
* To specify a version other than the default, you must first disable automatic updates by running the `ibmcloud ks ingress alb autoupdate disable` command.
* If you omit the `--version` flag when you enable or update an existing ALB, the ALB runs the default version of the same image that the ALB previously ran: either the Kubernetes Ingress image or the {{site.data.keyword.containerlong_notm}} Ingress image.

To list the latest three versions that are supported for each type of image, run the following command.

```sh
ibmcloud ks ingress alb versions
```
{: pre}

Example output

```sh
Kubernetes Ingress versions
1.1.2_2507_iks (default)
1.2.1_2506_iks
0.35.0_1374_iks
```
{: screen}

The Kubernetes Ingress version follows the format `<community_version>_<ibm_build>_iks`. The IBM build number indicates the most recent build of the Kubernetes Ingress NGINX release that {{site.data.keyword.containerlong_notm}} released. For example, the version `1.1.2_2507_iks` indicates the most recent build of the `0.47.0` Ingress NGINX version. {{site.data.keyword.containerlong_notm}} might release builds of the community image version to address vulnerabilities.

For the changes that are in each version of the Ingress images, see the [Ingress version changelog](/docs/containers?topic=containers-cluster-add-ons-changelog).

### Managing automatic updates
{: #autoupdate}

Manage automatic updates of all Ingress ALB pods in a cluster.
{: shortdesc}

By default, automatic updates to Ingress ALBs are enabled. ALB pods are automatically updated by IBM when a new image version is available. If your ALBs run the Kubernetes Ingress image, your ALBs are automatically updated to the latest version of the Kubernetes Ingress NGINX image. For example, if your ALBs run version `1.2.1_2506_iks`, and the Kubernetes Ingress NGINX image `0.47.0` is released, your ALBs are automatically updated to the latest build of the latest community version, such as `1.1.2_2507_iks`.

You can disable or enable the automatic updates by running `ibmcloud ks ingress alb autoupdate disable -c <cluster_name_or_ID>` or `ibmcloud ks ingress alb autoupdate enable -c <cluster_name_or_ID>`.
{: tip}

If automatic updates for the Ingress ALB add-on are disabled and you want to update the add-on, you can force a one-time update of your ALB pods. Note that you can use this command to update your ALB image to a different version, but you can't use this command to change your ALB from one type of image to another. Your ALB continues to run the image that it previously ran: either the Kubernetes Ingress image or the {{site.data.keyword.containerlong_notm}} Ingress image. After you force a one-time update, automatic updates remain disabled.
* To update all ALB pods in the cluster, run the following command.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --version <image_version>
    ```
    {: pre}

* To update the ALB pods for one or more specific ALBs, run the following command.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --version <image_version> --alb <ALB_ID> [--alb <ALB_2_ID> ...]
    ```
    {: pre}

### Scheduling maintenance windows for automatic updates
{: #alb_scheduled_updates}

You can enable automatic updates of all Ingress ALB pods in a cluster by enabling [autoupdate](#autoupdate). If you enable autoupdate for your ALBs, you can further control and manage your ALB updates by creating a customized ConfigMap that specifies the time you want the updates to occur and the percentage of ALBs you want to update.  
{: shortdesc}

To set a time frame for automatic updates, you set the `updateStartTime` and `updateEndTime` keys in the deployment ConfigMap. Each key represents an assigned time in a 24 hour format (HH:MM). Note that this time is specified in coordinated universal time (UTC) rather than your local time. To specify a percentage of ALBs to update, you set the `updatePercentage` key as a whole number between 0 and 100.

**To manage your autoupdate settings with a customized ConfigMap:**

1. Create a YAML file for your ConfigMap. Specify the `updatePercentage`, `updateStartTime`, and `updateEndTime` fields as key-value pairs in the `data` field.

    The following example ConfigMap sets the autoupdate function to update 35% of ALB pods in your cluster between 20:34 and 23:59 UTC.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: ingress-deploy-config
        namespace: kube-system
    data:
        "updatePercentage": "35"
        "updateStartTime": "20:34"
        "updateEndTime": "23:59"
    ```
    {: codeblock}

2. Deploy the ConfigMap in your cluster. The new rules apply the next time an update takes place.

```sh
kubectl apply -f <filename>.yaml
```
{: pre}

### Reverting to an earlier version
{: #revert}

If your ALB pods were recently updated, but a custom configuration for your ALBs is affected by the latest image version build, you can use the `ibmcloud ks ingress alb update --version <image_version>` command to roll back ALB pods to an earlier, supported version.
{: shortdesc}

The image version that you change your ALB to must be a supported image version that is listed in the output of `ibmcloud ks ingress alb versions`. Note that you can use this command to change your ALB image to a different version, but you can't use this command to change your ALB from one type of image to another. After you force a one-time update, automatic updates to your ALBs are disabled.


## Scaling ALBs
{: #scale_albs}

When you create a standard cluster, one public and one private ALB is created in each zone where you have worker nodes. Each ALB can handle 32,768 connections per second. However, if you must process more than 32,768 connections per second, you can scale up your ALBs by increasing the number of ALB pod replicas or by creating more ALBs.
{: shortdesc}

### Increasing the number of ALB pod replicas
{: #alb_replicas}

By default, each ALB has 2 replicas. Scale up your ALB processing capabilities by increasing the number of ALB pods.
{: shortdesc}

By default, periodic Ingress version updates are automatically rolled out to your ALBs. If only one worker node exists in a zone in your cluster, and you set the number of ALB replicas to 1, this single ALB pod is deleted and a new pod is created whenever updates are applied. This process might cause traffic disruptions, even if you have worker nodes and ALB replicas in other zones. To prevent traffic disruptions, ensure that at least two worker nodes exist in each zone, and that two replicas exist for each ALB.
{: warning}

1. Get the IDs for your ALBs.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster_name_or_ID>
    ```
    {: pre}

2. Create a YAML file for an `ibm-ingress-deploy-config` ConfigMap. For each ALB, add `'{"replicas":<number_of_replicas>}'`. Example for increasing the number of ALB pods to 4 replicas.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-ingress-deploy-config
      namespace: kube-system
    data:
      <alb1-id>: '{"replicas":<number_of_replicas>}'
      <alb2-id>: '{"replicas":<number_of_replicas>}'
      ...
    ```
    {: codeblock}

3. Create the `ibm-ingress-deploy-config` ConfigMap in your cluster.

    ```sh
    kubectl create -f ibm-ingress-deploy-config.yaml
    ```
    {: pre}

4. To pick up the changes, update your ALBs. Note that it might take up to 5 minutes for the changes to be applied to your ALBs.

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID>
    ```
    {: pre}

5. Verify that the number of ALB pods that are `Ready` are increased to the number of replicas that you specified.

    ```sh
    kubectl get pods -n kube-system | grep alb
    ```
    {: pre}

### Creating more ALBs
{: #create_alb}

Scale up your ALB processing capabilities by creating more ALBs.
{: shortdesc}

For example, if you have worker nodes in `dal10`, a default public ALB exists in `dal10`. This default public ALB is deployed as two pods on two worker nodes in that zone. However, to handle more connections per second, you want to increase the number of ALBs in `dal10`. You can create a second public ALB in `dal10`. This ALB is also deployed as two pods on two worker nodes in `dal10`. All public ALBs in your cluster share the same IBM-assigned Ingress subdomain, so the IP address of the new ALB is automatically added to your Ingress subdomain. You don't need to change your Ingress resource files.

You can also use these steps to create more ALBs across zones in your cluster. When you create a multizone cluster, a default public ALB is created in each zone where you have worker nodes. However, default public ALBs are created in only up to three zones. If, for example, you later remove one of these original three zones and add workers in a different zone, a default public ALB is not created in that new zone. You can manually create an ALB to process connections in that new zone.
{: tip}

**Classic clusters:**

1. In each zone where you have worker nodes, create an ALB. For more information about this command's parameters, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create).

    ```sh
    ibmcloud ks ingress alb create --cluster <cluster_name_or_ID> --type <public_or_private> --zone <zone> --vlan <VLAN_ID> [--ip <IP_address>] [--version image_version]
    ```
    {: pre}

2. Verify that the ALBs that you created in each zone have a **Status** of `enabled` and that an **ALB IP** is assigned.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which new public ALBs with IDs of `public-crdf253b6025d64944ab99ed63bb4567b6-alb3` and `public-crdf253b6025d64944ab99ed63bb4567b6-alb4` are created in `dal10` and `dal12`.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021       -
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    169.49.28.09    dal12   ingress:1.1.2_2507_iks   2294019       -
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    169.50.35.62    dal10   ingress:1.1.2_2507_iks   2234945       -
    ```
    {: screen}

3. If you later decide to scale down your ALBs, you can disable an ALB. For example, you might want to disable an ALB to use less compute resources on your worker nodes. The ALB is disabled and does not route traffic in your cluster. You can re-enable an ALB at any time by running `ibmcloud ks ingress alb enable classic --alb <ALB_ID> -c <cluster_name_or_ID>`.

    ```sh
    ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
    ```
    {: pre}



**VPC clusters:**

1. In each zone where you have worker nodes, create an ALB. For more information about this command's parameters, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb-create-vpc-gen2).

    ```sh
    ibmcloud ks ingress alb create vpc-gen2 --cluster <cluster_name_or_ID> --type <public_or_private> --zone <vpc_zone> [--version image_version]
    ```
    {: pre}

2. Verify that the ALBs that you created in each zone have a **Status** of `enabled` and that a **Load Balancer Hostname** is assigned.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which new public ALBs with IDs of `public-crdf253b6025d64944ab99ed63bb4567b6-alb3` and `public-crdf253b6025d64944ab99ed63bb4567b6-alb4` are created in `us-south-1` and `us-south-2`.

    ```sh
    ALB ID                                            Enabled   Status     Type      Load Balancer Hostname                 Zone         Build
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -                                      us-south-2   ingress:1.1.2_2507_iks
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -                                      us-south-1   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-2   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-1   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-2   ingress:1.1.2_2507_iks
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    23f2dfb1-us-south.lb.appdomain.cloud   us-south-1   ingress:1.1.2_2507_iks
    ```
    {: screen}

3. If you later decide to scale down your ALBs, you can disable an ALB. For example, you might want to disable an ALB to use less compute resources on your worker nodes. The ALB is disabled and does not route traffic in your cluster.
    ```sh
    ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
    ```
    {: pre}




## Moving ALBs across VLANs
{: #migrate-alb-vlan}

The information in this topic is specific to classic clusters only.
{: note}

When you [change your worker node VLAN connections](/docs/containers?topic=containers-cs_network_cluster#change-vlans), the worker nodes are connected to the new VLAN and assigned new public or private IP addresses. However, ALBs can't automatically migrate to the new VLAN because they are assigned a stable, portable public or private IP address from a subnet that belongs to the old VLAN. When your worker nodes and ALBs are connected to different VLANs, the ALBs can't forward incoming network traffic to app pods to your worker nodes. To move your ALBs to a different VLAN, you must create an ALB on the new VLAN and disable the ALB on the old VLAN.
{: shortdesc}

Note that all public ALBs in your cluster share the same IBM-assigned Ingress subdomain. When you create new ALBs, you don't need to change your Ingress resource files.

1. Get the new public or private VLAN that you changed your worker node connections to in each zone.

    1. List the details for a worker in a zone.

        ```sh
        ibmcloud ks worker get --cluster <cluster_name_or_ID> --worker <worker_id>
        ```
        {: pre}

    2. In the output, note the **ID** for the public or the private VLAN.
        * To create public ALBs, note the public VLAN ID.
        * To create private ALBs, note the private VLAN ID.

    3. Repeat these steps for a worker in each zone so that you have the IDs for the new public or private VLAN in each zone.

2. In each zone, create an ALB on the new VLAN. For more information about this command's parameters, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_create).

    ```sh
    ibmcloud ks ingress alb create --cluster <cluster_name_or_ID> --type <public_or_private> --zone <zone> --vlan <VLAN_ID> [--ip <IP_address>] [--version image_version]
    ```
    {: pre}

3. Verify that the ALBs that you created on the new VLANs in each zone have a **Status** of `enabled` and that an **ALB IP** address is assigned.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which new public ALBs are created on VLAN `2294030` in `dal12` and `2234940` in `dal10`.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    true      enabled    public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    169.49.28.09    dal12   ingress:1.1.2_2507_iks   2294030
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    169.50.35.62    dal10   ingress:1.1.2_2507_iks   2234940
    ```
    {: screen}

4. Disable each ALB that is connected to the old VLANs.

    ```sh
    ibmcloud ks ingress alb disable --alb <old_ALB_ID> -c <cluster_name_or_ID>
    ```
    {: pre}

5. Verify that each ALB that is connected to the old VLANs has a **Status** of `disabled`. Only the ALBs that are connected to the new VLANs receive incoming network traffic and communicate with your app pods.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a cluster in which the default public ALBs on VLAN `2294019` in `dal12` and `2234945` in `dal10`: are disabled.

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal12   ingress:1.1.2_2507_iks   2294021
    private-crdf253b6025d64944ab99ed63bb4567b6-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    false     disabled   public    169.48.228.78   dal12   ingress:1.1.2_2507_iks   2294019
    public-crdf253b6025d64944ab99ed63bb4567b6-alb2    false     disabled   public    169.46.17.6     dal10   ingress:1.1.2_2507_iks   2234945
    public-crdf253b6025d64944ab99ed63bb4567b6-alb3    true      enabled    public    169.49.28.09    dal12   ingress:1.1.2_2507_iks   2294030
    public-crdf253b6025d64944ab99ed63bb4567b6-alb4    true      enabled    public    169.50.35.62    dal10   ingress:1.1.2_2507_iks   2234940
    ```
    {: screen}

6. Optional for public ALBs: Verify that the IP addresses of the new ALBs are listed under the IBM-provided Ingress subdomain for your cluster. You can find this subdomain by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

    ```sh
    nslookup <Ingress_subdomain>
    ```
    {: pre}

    Example output.

    ```sh
    Non-authoritative answer:
    Name:    mycluster-<hash>-0000.us-south.containers.appdomain.cloud
    Addresses:  169.49.28.09
            169.50.35.62
    ```
    {: screen}

7. Optional: If you no longer need the subnets on the old VLANs, you can [remove them](/docs/containers?topic=containers-subnets#remove-subnets).
