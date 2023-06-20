---

copyright:
  years: 2022, 2023
lastupdated: "2023-06-20"

keywords: ingress, expose apps, ingress resource, ALB, domain

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Setting up Ingress
{: #managed-ingress-setup}

Create an Ingress resource to configure your Ingress components, define rules for routing requests, and specify the path to your app services. A separate Ingress resource is required for each namespace that contains an app or service that you want to expose.
{: shortdesc}

## Before you begin
{: #managed-ingress-steps-before}

Follow these preparation steps before you begin.
{: shortdesc}

1. Make sure that you have the correct permissions to set up Ingress. The following [{{site.data.keyword.cloud_notm}} IAM roles](/docs/containers?topic=containers-users#checking-perms) are required:
    - **Administrator** platform access role for the cluster
    - **Manager** service access role in all namespaces

1. Determine whether you want to use the IBM-provided Ingress subdomain. If you do not want to use the provided subdomain, you must create and register your own [custom domain](#ingress-custom-domain). 

    A custom domain is required to expose apps over private ALBs.
    {: important}

1. If you are exposing apps over private ALBs, you must enable each private ALB in the CLI. To get the ALB ID, run `ibmcloud ks ingress alb ls --cluster CLUSTER`.

   [Classic clusters]{: tag-classic-inf} For more information and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).
    ```sh
    ibmcloud ks ingress alb enable classic --alb <alb_id> --cluster <cluster_name> 
    ```
    {: pre}

   [VPC clusters]{: tag-vpc} For more information and command options, see the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_alb_configure_vpc_gen2).
    ```sh
    ibmcloud ks ingress alb enable vpc-gen2 --alb <alb_id> --cluster <cluster_name> 
    ```
    {: pre}

1. Make sure that your cluster includes at least two worker nodes per zone to ensure high availability and to apply periodic updates. If you have only one worker node in a zone, the ALB can't receive automatic updates. For more information, see [Worker node requirements for ALBs](/docs/containers-managed-ingress-about#managed-ingress-albs-reqs).

1. If you are using a classic cluster, enable a [Virtual Router Function (VRF)](/docs/account?topic=account-vrf-service-endpoint#vrf) for your IBM Cloud infrastructure account. To enable VRF, see [Enabling VRF](/docs/account?topic=account-vrf-service-endpoint#vrf). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you can't or don't want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). When a VRF or VLAN spanning is enabled, the ALB can route packets to various subnets in the account.

1. If you are using a VPC cluster, ensure that traffic requests that are routed by Ingress to node ports on your worker nodes are permitted in [VPC security groups](/docs/openshift?topic=openshift-vpc-security-group).

1. Note that if you create and delete a cluster with the same or similar name 5 times or more within 7 days, such as for automation or testing purposes, you might reach the [Let's Encrypt Duplicate Certificate rate limit](/docs/containers?topic=containers-cs_rate_limit). To ensure that the Ingress subdomain and certificate are correctly registered, the first 24 characters of the clusters' names must be different.

1. If you restrict network traffic to edge worker nodes, ensure that at least two [edge worker nodes](/docs/containers?topic=containers-edge) are enabled in each zone so that ALBs deploy uniformly.

If a zone fails, you might see intermittent failures in requests to the Ingress ALB in that zone.
{: note}

## Setup steps
{: #managed-ingress-steps}

Follow the steps to set up Ingress.
{: shortdesc}

### Step 1: Create a `ClusterIP` service
{: #managed-ingress-steps-clusterip}

A `ClusterIP` service is required to make your app reachable from within the cluster so that external requests can be forwarded to the app pod. To be included in Ingress load balancing, the names of the `ClusterIP` services that expose your apps must be unique across all namespaces in your cluster.
{: shortdesc}

For each app deployment that you want to expose, create a Kubernetes `ClusterIP` service. Your app must be exposed by a Kubernetes service to be included in the Ingress load balancing.

```sh
kubectl expose deploy <app_deployment_name> --name my-app-svc --port <app_port> -n <namespace>
```
{: pre}
    

### Step 2: Set up TLS termination with TLS certificates and Kubernetes secrets
{: #managed-ingress-steps-tls}

Your TLS certificate must be stored as a Kubernetes secret in each namespace where your apps exist.
{: shortdesc}

* To use the IBM-provided Ingress subdomain, see [Setting up TLS secrets for the IBM-provided Ingress subdomain](/docs/containers?topic=containers-secrets#tls-default).

* To use a custom domain, see [Setting up TLS secrets for custom subdomains](/docs/containers?topic=containers-secrets#tls-custom).

### Step 3: Create the Ingress resource
{: #managed-ingress-steps-resource}

Create the Ingress resource to define the routing rules that the Ingress controller uses to route traffic to your app service.
{: shortdesc}

1. Create the Ingress resource in a YAML file. 

    The format of the Ingress resource definition varies based on your cluster's Kubernetes version, because API version `networking.k8s.io/v1beta1` is unsupported in Kubernetes cluster versions 1.22+.
    {: note}

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: my-ingress-resource
      annotations:
        kubernetes.io/ingress.class: <ingress_class>
    spec:
      tls:
      - hosts:
        - <domain_name>
        secretName: <tls_secret_name>
      rules:
      - host: HOSTNAME
        http:
          paths:
          - path: <app_path_1>
            pathType: Prefix
            backend:
              service:
                name: <app_service_1>
                port:
                  number: 80
          - path: <app_path_2>
            pathType: Prefix
            backend:
              service:
                name: <app_service_2>
                port:
                  number: 80

    ```
    {: codeblock}

    `annotations`
    :   `kubernetes.io/ingress.class`: Specify the Ingress class to apply. The IBM-provided Ingress classes are `"public-iks-k8s-nginx"` for public ALBs and `"private-iks-k8s-nginx"` for private ALBs. 
    :    For configurations in which another component manages your Ingress ALBs, such as if Ingress is deployed as part of a Helm chart, don't specify this annotation. Instead, find the Ingress class for your configuration, and specify that class in a `spec.ingressClassName: <class_name>` field. You must also specify this custom class in an [`IngressClass`](#ingress-custom-domain) resource and a `ibm-ingress-deploy-config` configmap. To customize routing for Ingress, you can add [Kubernetes NGINX annotations](/docs/containers?topic=containers-comm-ingress-annotations) (`nginx.ingress.kubernetes.io/<annotation>`). Custom {{site.data.keyword.containerlong_notm}} annotations (`ingress.bluemix.net/<annotation>`) are not supported.

    `tls.hosts`
    :   To use TLS, replace `<domain>` with the IBM-provided Ingress subdomain or your custom domain.

    `tls.secretName`
    :   Replace `<tls_secret_name>` with the name of the Kubernetes secret where your [TLS certificate](#managed-ingress-steps-tls) is stored.

    `host`
    :   Replace `<domain>` with the IBM-provided Ingress subdomain or your custom domain.

    `path`
    :   Replace `<app_path>` with a slash or the path that your app is listening on. The path is appended to the specified Ingress domain to create a unique route to your app. When you enter this route into a web browser, network traffic is routed to the ALB. The ALB looks up the associated service and sends network traffic to the service. The service then forwards the traffic to the pods where the app runs.


    `pathType`
    :   The URL path matching method. Supported values are `ImplementationSpecific`, `Exact`, or `Prefix`. For more information about and examples of each path type, see the [community Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types){: external}.


    `service.name`
    :   Replace `app1_service` and `app2_service`, and so on, with the name of the services you created to expose your apps. Make sure that the apps you specify are in the same namespace.

    `service.name`
    :   Replace `<app1_service>` and `<app2_service>`, and so on, with the name of the services you created to expose your apps. Make sure that the apps you specify are in the same namespace.


    `service.port.number`
    :   The port that your service listens to. Use the same port that you defined when you created the Kubernetes service for your app.


2. Apply the Ingress resource to your cluster. Ensure that the resource deploys into the same namespace as the app services that you specified in the resource.
    ```sh
    kubectl apply -f community-ingress-resource.yaml -n <namespace>
    ```
    {: pre}

### Step 4: Verify your Ingress setup
{: #managed-ingress-setup-verify}

1. List your ALBs and copy the IP address (classic) or hostname (VPC) for one ALB that runs the Kubernetes Ingress image. In the output, choose an ALB that has a **Build** in the format `<community_version>_<ibm_build>_iks`.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster>
    ```
    {: pre}

2. Use the ALB's IP address (classic) or hostname (VPC), the app path, and your domain to verify that you can successfully send traffic to your app through this ALB.

    ```sh
    curl http://<ALB_IP>/<app_path> -H "Host: <ingress_subdomain>"
    ```
    {: pre}

    For example, to send a request to an app called `myapp` by using a default Ingress subdomain, run the following command.

    ```sh
    curl http://169.X.X.X/myapp -H "Host: mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud"
    ```
    {: pre}

Having trouble connecting to your app through Ingress? Try [Troubleshooting Ingress](/docs/containers?topic=containers-ingress-debug). You can check the health and status of your Ingress components by running `ibmcloud ks ingress status-report get -c <cluster_name_or_ID>`.
{: tip}

## Custom domains with Ingress
{: #ingress-custom-domain}

If you do not want to use the IBM-provided Ingress subdomain, you can use your own custom domain that you specify in your Ingress resource. Note that apps exposed with Ingress over private ALBs require a custom domain. 
{: shortdesc}

### Creating custom domains for public ALBs
{: #ingress-custom-domain-public}

Follow the steps to create a custom domain for public ALBs.
{: shortdesc}

1. Create a custom domain. To register your custom domain, work with your Domain Name Service (DNS) provider or [{{site.data.keyword.cloud_notm}} DNS](/docs/dns?topic=dns-getting-started). If the apps that you want Ingress to expose are in different namespaces in one cluster, register the custom domain as a wildcard domain, such as `*.custom_domain.net`. Note that domains are limited to 130 characters or fewer in Kubernetes version 1.20 or later.

2. Define an alias for your custom domain by specifying the IBM-provided subdomain as a Canonical Name record (CNAME). To find the IBM-provided Ingress domain, run `ibmcloud ks cluster get --cluster <cluster_name>` and look for the **Ingress subdomain** field.

    Specifying the IBM-provided subdomain as a CNAME is required for automatic health checks to remove any failing IPs from the DNS response, and to ensure that your custom domain updates when you add or remove ALBs. 
    {: note}



### Creating custom domains for private ALBs
{: #ingress-custom-domain-private}

Follow the steps to create a custom domain for private ALBs. Note that custom domains are required to use Ingress with private ALBs.
{: shortdesc}

If you have a classic cluster with only a private VLAN, you must first configure your own [DNS service that is available on your private network](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.
{: note}

1. Create a custom domain through your DNS service provider. Note that Ingress URLs must be 130 characters or fewer.

2. Map your custom domain to the private ALBs by adding their IP addresses as A records (classic clusters) or their VPC hostname as a CNAME (VPC clusters). To find the ALB IP addresses (classic) or hostname (VPC), run `ibmcloud ks ingress alb ls -c <cluster_name_or_ID>`.


