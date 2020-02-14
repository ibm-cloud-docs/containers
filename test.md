## Debugging Ingress
{: #ingress-debug-roks4}
{: troubleshoot}
{: support}



You publicly exposed your app by creating an Ingress resource for your app in your cluster. However, when you try to connect to your app through the Ingress subdomain or the IP address of the Ingress controller's router, the connection fails or times out. The steps in the following sections can help you debug your Ingress setup.
{: shortdesc}

Before you begin, ensure you have the following [{{site.data.keyword.cloud_notm}} IAM access policies](/docs/containers?topic=containers-users#platform):
  - **Editor** or **Administrator** platform role for the cluster
  - **Writer** or **Manager** service role

### Step 1: Check your app deployment
{: #app-debug-ingress}

Ingress issues are often caused by underlying issues in your app deployment or in the `ClusterIP` service that exposes your app. For example, your app label and service selector might not match, or your app and service target ports might not match. Before you debug Ingress, first check out [Debugging app deployments](/docs/containers?topic=containers-cs_troubleshoot_app#debug_apps).
{: shortdesc}

### Step 2: Check for error messages in your Ingress deployment and the ALB pod logs
{: #errors}

Start by checking for error messages in the Ingress resource deployment events and ALB pod logs. These error messages can help you find the root causes for failures and further debug your Ingress setup in the next sections.
{: shortdesc}

1. Check your Ingress resource deployment and look for warning or error messages.
    ```
    oc describe ingress <ingress_resource_name>
    ```
    {: pre}

    In the **Events** section of the output, you might see warning messages about invalid values in your Ingress resource or in certain annotations that you used. Check the [Ingress resource configuration documentation](/docs/containers?topic=containers-ingress#public_inside_4). For annotations, note that the {{site.data.keyword.containerlong_notm}} annotations (`ingress.bluemix.net/<annotation>`) and NGINX annotations (`nginx.ingress.kubernetes.io/<annotation>`) are not supported for the router or the Ingress resource in OpenShift version 4.3 and later. If you want to customize routing rules for apps in a cluster that runs OpenShift version 4.3 or later, you can use [HAProxy annotations for the OpenShift router](https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html#route-specific-annotations){: external} that manages traffic for your app. These annotations are in the format `haproxy.router.openshift.io/<annotation>` or `router.openshift.io/<annotation>`. To add annotations to the router, run `oc edit svc router-default -n openshift-ingress`.

    ```
    Name:             myingress
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
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation.
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}
{: #check_pods}
2. Check the status of your Ingress operator pods. Ingress controllers are managed by the Ingress operator.
    1. Get the ALB pods that are running in your cluster.
        ```
        oc get pods -n openshift-ingress-operator
        ```
        {: pre}

    2. Make sure that all pods are running by checking the **STATUS** column.

    3. If a pod is not `Running`, you can delete the pod to restart it.
        ```

        ```
        {: pre}

3. Check the logs for your ALB.
    1.  Get the IDs of the ALB pods that are running in your cluster.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    3. Get the logs for the `nginx-ingress` container on each ALB pod.
        ```
        kubectl logs <ingress_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

    4. Look for error messages in the ALB logs.

### Step 3: Ping the ALB subdomain and public IP addresses
{: #ping}

Check the availability of your Ingress subdomain and ALBs' public IP addresses.
{: shortdesc}

1. Get the IP addresses that your public ALBs are listening on.
    ```
    ibmcloud ks alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output for a multizone cluster with worker nodes in `dal10` and `dal13`:

    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID   NLB Version
    private-cr24a9f2caf6554648836337d240064935-alb1   false     disabled   private   -               dal13   ingress:411/ingress-auth:315   2294021       -
    private-cr24a9f2caf6554648836337d240064935-alb2   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947       -
    public-cr24a9f2caf6554648836337d240064935-alb1    true      enabled    public    169.62.196.238  dal13   ingress:411/ingress-auth:315   2294019       -
    public-cr24a9f2caf6554648836337d240064935-alb2    true      enabled    public    169.46.52.222   dal10   ingress:411/ingress-auth:315   2234945       -
    ```
    {: screen}

    * If a public ALB has no IP address, see [Ingress ALB does not deploy in a zone](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress#cs_subnet_limit).

2. Check the health of your ALB IPs.

    * For single zone cluster and multizone clusters: Ping the IP address of each public ALB to ensure that each ALB is able to successfully receive packets. If you are using private ALBs, you can ping their IP addresses only from the private network.
        ```
        ping <ALB_IP>
        ```
        {: pre}

        * If the CLI returns a timeout and you have a custom firewall that is protecting your worker nodes, make sure that you allow ICMP in your [firewall](/docs/containers?topic=containers-cs_troubleshoot#cs_firewall).
        * If there is no firewall that is blocking the pings and the pings still run to timeout, [check the status of your ALB pods](#check_pods).

    * Multizone clusters only: You can use the MZLB health check to determine the status of your ALB IPs. For more information about the MZLB, see [Multizone load balancer (MZLB)](/docs/containers?topic=containers-ingress-about#ingress_components). The MZLB health check is available only for clusters that have the new Ingress subdomain in the format `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. If your cluster still uses the older format of `<cluster_name>.<region>.containers.mybluemix.net`, [convert your single zone cluster to multizone](/docs/containers?topic=containers-add_workers#add_zone). Your cluster is assigned a subdomain with the new format, but can also continue to use the older subdomain format. Alternatively, you can order a new cluster that is automatically assigned the new subdomain format.

    The following HTTP cURL command uses the `albhealth` host, which is configured by {{site.data.keyword.containerlong_notm}} to return the `healthy` or `unhealthy` status for an ALB IP.
        ```
        curl -X GET http://169.62.196.238/ -H "Host: albhealth.mycluster-<hash>-0000.us-south.containers.appdomain.cloud"
        ```
        {: pre}

        Example output:
        ```
        healthy
        ```
        {: screen}
        If one or more of the IPs returns `unhealthy`, [check the status of your ALB pods](#check_pods).

3. Get the IBM-provided Ingress subdomain.
    ```
    ibmcloud ks cluster get --cluster <cluster_name_or_ID> | grep Ingress
    ```
    {: pre}

    Example output:
    ```
    Ingress Subdomain:      mycluster-<hash>-0000.us-south.containers.appdomain.cloud
    Ingress Secret:         mycluster-<hash>-0000
    ```
    {: screen}

4. Ensure that the IPs for each public ALB that you got in step 2 of this section are registered with your cluster's IBM-provided Ingress subdomain. For example, in a multizone cluster, the public ALB IP in each zone where you have worker nodes must be registered under the same subdomain.

    ```
    kubectl get ingress -o wide
    ```
    {: pre}

    Example output:
    ```
    NAME                HOSTS                                                    ADDRESS                        PORTS     AGE
    myingressresource   mycluster-<hash>-0000.us-south.containers.appdomain.cloud      169.46.52.222,169.62.196.238   80        1h
    ```
    {: screen}

### Step 4: Check your domain mappings and Ingress resource configuration
{: #ts_ingress_config}

1. If you use a custom domain, verify that you used your DNS provider to map the custom domain to the IBM-provided subdomain or the ALB's public IP address. Note that using a CNAME is preferred because IBM provides automatic health checks on the IBM subdomain and removes any failing IPs from the DNS response.
    * IBM-provided subdomain: Check that your custom domain is mapped to the cluster's IBM-provided subdomain in the Canonical Name record (CNAME).
        ```
        host www.my-domain.com
        ```
        {: pre}

        Example output:
        ```
        www.my-domain.com is an alias for mycluster-<hash>-0000.us-south.containers.appdomain.cloud
        mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.46.52.222
        mycluster-<hash>-0000.us-south.containers.appdomain.cloud has address 169.62.196.238
        ```
        {: screen}

    * Public IP address: Check that your custom domain is mapped to the ALB's portable public IP address in the A record. The IPs should match the public ALB IPs that you got in step 1 of the [previous section](#ping).
        ```
        host www.my-domain.com
        ```
        {: pre}

        Example output:
        ```
        www.my-domain.com has address 169.46.52.222
        www.my-domain.com has address 169.62.196.238
        ```
        {: screen}

2. Check the Ingress resource configuration files for your cluster.
    ```
    kubectl get ingress -o yaml
    ```
    {: pre}

    1. Ensure that you define a host in only one Ingress resource. If one host is defined in multiple Ingress resources, the ALB might not forward traffic properly and you might experience errors.

    2. Check that the subdomain and TLS certificate are correct. To find the IBM provided Ingress subdomain and TLS certificate, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

    3.  Make sure that your app listens on the same path that is configured in the **path** section of your Ingress. If your app is set up to listen on the root path, use `/` as the path. If incoming traffic to this path must be routed to a different path that your app listens on, use the [rewrite paths](/docs/containers?topic=containers-ingress_annotation#rewrite-path) annotation.

    4. Edit your resource configuration YAML as needed. When you close the editor, your changes are saved and automatically applied.
        ```
        kubectl edit ingress <myingressresource>
        ```
        {: pre}
