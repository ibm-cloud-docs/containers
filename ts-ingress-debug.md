---

copyright:
  years: 2014, 2026
lastupdated: "2026-06-29"


keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Debugging Ingress
{: #ingress-debug}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


You exposed your app by creating an Ingress resource for your app in your cluster. However, when you try to connect to your app through the Ingress subdomain or the ALBs' IP addresses, the connection fails or times out.
{: tsSymptoms}


The steps in the following sections can help you debug your Ingress setup.
{: tsResolve}

Before you begin, ensure you have the following [{{site.data.keyword.cloud_notm}} IAM access policies](/docs/containers?topic=containers-iam-platform-access-roles) for {{site.data.keyword.containerlong_notm}}:
    - **Editor** or **Administrator** platform access role for the cluster
    - **Writer** or **Manager** service access role

## Step 1: Check your app deployment
{: #app-debug-ingress}

Before you debug Ingress, first check out [Debugging app deployments](/docs/containers?topic=containers-debug_apps).
{: shortdesc}

Ingress issues are often caused by underlying issues in your app deployment or in the `ClusterIP` service that exposes your app. For example, your app label and service selector might not match, or your app and service target ports might not match.

## Step 2: Check for error messages in your Ingress deployment and the ALB pod logs
{: #errors}

Start by checking for error messages in the Ingress resource deployment events and ALB pod logs. These error messages can help you find the root causes for failures and further debug your Ingress setup in the next sections.
{: shortdesc}

1. Check your Ingress resource deployment and look for warnings or error messages.
    ```sh
    kubectl describe ingress <myingress>
    ```
    {: pre}

    In the **Events** section of the output, you might see warning messages about invalid values in your Ingress resource or in certain annotations that you used. For **Ingress-NGINX** based ALBs, check the [Ingress resource configuration documentation](/docs/containers?topic=containers-managed-ingress-setup) or the [annotations documentation](/docs/containers?topic=containers-comm-ingress-annotations). For **Traefik** based ALBs check the [Ingress resource configuration documentation](/docs/containers?topic=containers-managed-traefik-ingress-setup) or the [Ingress Controller configuration documentation](/docs/containers?topic=containers-traefik-ingress-customization).

    ```sh
    NAME:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xxx,169.xx.xxx.xxx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
        Host                                             Path  Backends
        ----                                             ----  --------
        mycluster-<hash>-0000.us-south.containers.appdomain.cloud
        /tea      myservice1:80 (<none>)
        /coffee   myservice2:80 (<none>)
    Annotations:
        custom-port:        protocol=http port=7490; protocol=https port=4431
        location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
        Type     Reason             Age   From                                                            Message
        ----     ------             ----  ----                                                            -------
        Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
        Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
        Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
        Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
        Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
        Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation can't use ports 7481 - 7490
        Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

2. Check the status of your ALB pods. {: #check_pods}
    1. Get the ALB pods that are running in your cluster.
        ```sh
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Make sure that all pods are running by checking the **STATUS** column.

    3. If a pod does not have a `Running` status, you can disable and re-enable the ALB. In the following commands, replace `<ALB_ID>` with the ID of the pod's ALB. For example, if the pod that is not running has the name `public-crb2f60e9735254ac8b20b9c1e38b649a5-alb1-5d6d86fbbc-kxj6z`, the ALB ID is `public-crb2f60e9735254ac8b20b9c1e38b649a5-alb1`.
        * Classic clusters:
            ```sh
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

            ```sh
            ibmcloud ks ingress alb enable classic --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

        * VPC clusters:
            ```sh
            ibmcloud ks ingress alb disable --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

            ```sh
            ibmcloud ks ingress alb enable vpc-gen2 --alb <ALB_ID> -c <cluster_name_or_ID>
            ```
            {: pre}

3. Check the logs for your ALB.
    1. Get the IDs of the ALB pods that are running in your cluster.
        ```sh
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    1. For Ingress-NGINX based ALBs, get the logs for the `nginx-ingress` container on each ALB pod. For Traefik based ALBs get the logs for the `traefik` container on each ALB pod.
        ```sh
        kubectl logs <ingress_pod_ID> <nginx-ingress/traefik> -n kube-system
        ```
        {: pre}

    1. Look for error messages in the ALB logs.

## Step 3: Ping the ALB subdomain and public IP addresses
{: #ping}

Check the availability of your Ingress subdomain and ALBs' public IP addresses. Additionally, ensure that the IBM NS1 can access your ALBs to health check them.
{: shortdesc}

1. Get the IP addresses (classic) or hostname (VPC) that your public ALBs are listening on.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a classic multizone cluster with worker nodes in `dal10` and `dal13`:

    ```sh
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-cr24a9f2caf6554648836337d240064935-alb1   false     disabled   private   -               dal13   ingress:1.1.2_2507_iks   2294021       -
    private-cr24a9f2caf6554648836337d240064935-alb2   false     disabled   private   -               dal10   ingress:1.1.2_2507_iks   2234947       -
    public-cr24a9f2caf6554648836337d240064935-alb1    true      enabled    public    169.62.196.238  dal13   ingress:1.1.2_2507_iks   2294019       -
    public-cr24a9f2caf6554648836337d240064935-alb2    true      enabled    public    169.46.52.222   dal10   ingress:1.1.2_2507_iks   2234945       -
    ```
    {: screen}

    * If a public ALB has no IP address (classic) or hostname (VPC), see [Ingress ALB does not deploy in a zone](/docs/containers?topic=containers-cs_subnet_limit).

2. Verify that your ALB IP addresses are reachable by the ALB health check.
    
    * **Classic**: If you use Calico pre-DNAT network policies or another custom firewall to block incoming traffic to your cluster, you must allow inbound access on port 80 or 443 from the Kubernetes control plane and IBM NS1's IPv4 IP addresses to the IP addresses of your ALBs so that the Kubernetes control plane can check the health of your ALBs. For example, if you use Calico policies, [create a Calico pre-DNAT policy](/docs/containers?topic=containers-policy_tutorial#lesson3) to allow inbound access to your ALB IP addresses from [IBM NS1's source IP addresses](/docs/containers?topic=containers-firewall#firewall-ingress-domain-monitor) on port 80 and the [control plane subnets for the region where your cluster is located](https://github.com/IBM-Cloud/kube-samples/tree/master/control-plane-ips){: external}.
    
    * **VPC**: If you have a custom security group on the VPC LBaaS (LoadBalancer-as-a-Service) instances for the cluster ingress, ensure that the security group rules allow the necessary health-check traffic from the Kubernetes [control plane IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/control-plane-ips){: external} to port 443. 

3. Check the health of your ALB IPs (classic) or hostname (VPC).

    * Ping the IP address (classic) or hostname (VPC) of each public ALB to ensure that each ALB is able to successfully receive packets. If you are using private ALBs, you can ping their IP addresses (classic) or hostname (VPC) only from the private network.
        ```sh
        ping <ALB_IP>
        ```
        {: pre}

        * If the CLI returns a timeout and you have a custom firewall that is protecting your worker nodes, make sure that you allow ICMP in your firewall.
        * If you don't have a firewall or your firewall does not block the pings and the pings still timeout, [check the status of your ALB pods](#check_pods).

    * Multizone clusters only: You can use the MZLB health check to determine the status of your ALB IPs (classic) or hostname (VPC). The following HTTP cURL command uses the `albhealth` host, which is configured by {{site.data.keyword.containerlong_notm}} to return the `healthy` or `unhealthy` status for an ALB IP.
        ```sh
        curl -X GET http://<ALB_IP>/ -H "Host: albhealth.<ingress_subdomain>"
        ```
        {: pre}

        Example command:
        ```sh
        curl -X GET http://169.62.196.238/ -H "Host: albhealth.mycluster-<hash>-0000.us-south.containers.appdomain.cloud"
        ```
        {: pre}

        Example output
        ```sh
        healthy
        ```
        {: screen}

        If one or more of the IPs returns `unhealthy`, [check the status of your ALB pods](#check_pods).

4. Get the IBM-provided Ingress subdomain.
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

5. Ensure that the IPs (classic) or hostname (VPC) for each public ALB that you got in step 1 of this section are registered with your cluster's IBM-provided Ingress subdomain. For example, in a classic multizone cluster, the public ALB IP in each zone where you have worker nodes must be registered under the same subdomain.

    ```sh
    kubectl get ingress -o wide
    ```
    {: pre}

    Example output

    ```sh
    NAME                HOSTS                                                    ADDRESS                        PORTS     AGE
    myingressresource   mycluster-<hash>-0000.us-south.containers.appdomain.cloud      169.46.52.222,169.62.196.238   80        1h
    ```
    {: screen}

## Step 4: Check your domain mappings and Ingress resource configuration
{: #ts_ingress_config}

1. If you use a custom domain, verify that you used your DNS provider to map the custom domain to the IBM-provided subdomain or the ALB's public IP address. Note that using a CNAME is preferred because IBM provides automatic health checks on the IBM subdomain and removes any failing IPs from the DNS response.
    * **IBM-provided subdomain CNAME**: Check that your custom domain is mapped to the cluster's IBM-provided subdomain in the Canonical Name record (CNAME).
        ```sh
        host www.my-domain.com
        ```
        {: pre}

        Example output
        ```sh
        www.my-domain.com is an alias for mycluster-<hash>-0000.us-south.containers.appdomain.cloud
        mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.46.52.222
        mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.62.196.238
        ```
        {: screen}

    * **Public IP address A record**: Check that your custom domain is mapped to the ALB's portable public IP address in the A record. The IPs should match the public ALB IPs that you got in step 1 of the [previous section](#ping).
        ```sh
        host www.my-domain.com
        ```
        {: pre}

        Example output
        ```sh
        www.my-domain.com has address 169.46.52.222
        www.my-domain.com has address 169.62.196.238
        ```
        {: screen}

2. Check the Ingress resource configuration files for your cluster.
    ```sh
    kubectl get ingress -o yaml
    ```
    {: pre}

    1. Ensure that you define a host in only one Ingress resource. If one host is defined in multiple Ingress resources, the ALB might not forward traffic properly and you might experience errors.

    2. Check that the subdomain and TLS certificate are correct. To find the IBM provided Ingress subdomain and TLS certificate, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

    3. Make sure that your app listens on the same path that is configured in the **path** section of your Ingress. If your app is set up to listen on the root path, use `/` as the path. If incoming traffic to this path must be routed to a different path that your app listens on, use the [rewrite paths](/docs/containers?topic=containers-comm-ingress-annotations#alb-rewrite-paths) annotation for **Ingress-NGINX**. For **Traefik**, use the [`ReplacePath` middleware](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/replacepath/){: external}.

    4. Edit your resource configuration YAML as needed. When you close the editor, your changes are saved and automatically applied.
        ```sh
        kubectl edit ingress <myingressresource>
        ```
        {: pre}


## Removing an ALB from DNS for debugging on Classic
{: #one_alb}

If you can't access your app through a specific ALB IP, you can temporarily remove the ALB from production by disabling its DNS registration. Then, you can use the ALB's IP address to run debugging tests on that ALB.

For example, say you have a multizone cluster in 2 zones, and the 2 public ALBs have IP addresses `169.46.52.222` and `169.62.196.238`. Although the health check is returning healthy for the second zone's ALB, your app isn't directly reachable through it. You decide to remove that ALB's IP address, `169.62.196.238`, from production for debugging. The first zone's ALB IP, `169.46.52.222`, is registered with your domain and continues to route traffic while you debug the second zone's ALB.


1. Use the following command to remove the IP from the domain name. The update command fully replaces the registered IP addresses, so you have to define only the healthy IP addresses in the command:
    ```sh
    ibmcloud ks ingress domain update --cluster <cluster_name> --domain <cluster domain> --ip 169.46.52.222
    ```
    {: pre}

2. Verify that the ALB IP address is removed from the DNS registration for your domain by checking the IBM NS1 server. Note that the DNS registration might take a few minutes to update.
    ```sh
    host mycluster-<hash>-0000.us-south.containers.appdomain.cloud dns1.p02.nsone.net
    ```
    {: pre}

    Example output that confirms that only the healthy ALB IP, `169.46.52.222`, remains in the DNS registration and that the unhealthy ALB IP, `169.62.196.238`, has been removed:
    ```sh
    mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.46.52.222
    ```
    {: screen}

3. Now that the ALB IP has been removed from production, you can run debugging tests against your app through it. To test communication to your app through this IP, you can run the following cURL command, replacing the example values with your own values:
    ```sh
    curl -X GET --resolve mycluster-<hash>-0000.us-south.containers.appdomain.cloud:443:169.62.196.238 https://mycluster-<hash>-0000.us-south.containers.appdomain.cloud/
    ```
    {: pre}

    * If everything is configured correctly, you get back the expected response from your app.
    * If you get an error in response, there might be an error in your app or in a configuration that applies only to this specific ALB. Check your app code, your [Ingress resource configuration files](/docs/containers?topic=containers-managed-ingress-setup) for **Ingress-NGINX** or [Ingress Controller configuration documentation](/docs/containers?topic=containers-traefik-ingress-customization) for **Traefik**, or any other configurations you have applied to only this ALB.

4. After you finish debugging, restore the DNS registration of the ALB, using the following command:
    ```sh
    ibmcloud ks ingress domain update --cluster <cluster_name> --domain <cluster domain> --ip 169.46.52.222 --ip 169.62.196.238
    ```
    {: pre}

5. Verify that the ALB IP address has been restored in the DNS registration for your domain by checking the IBM NS1 server. Note that the DNS registration might take a few minutes to update.
    ```sh
    host mycluster-<hash>-0000.us-south.containers.appdomain.cloud dns1.p02.nsone.net
    ```
    {: pre}

    Example output

    ```sh
    mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.46.52.222
    mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.62.196.238
    ```
    {: screen}
