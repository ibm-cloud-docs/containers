---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-04"


keywords: kubernetes, lb2.0, nlb, health check, dns, hostname, subdomain, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Registering a DNS subdomain for an NLB 
{: #loadbalancer_hostname}

[Classic infrastructure]{: tag-classic-inf}

This content is specific to NLBs in classic clusters. For VPC clusters, see [Registering a VPC load balancer hostname with a DNS subdomain](/docs/containers?topic=containers-setup_vpc_alb#vpc_lb_dns).
{: note}

After you set up network load balancers (NLBs), you can create DNS entries for the NLB IPs by creating subdomains. You can also set up TCP/HTTP(S) monitors to health check the NLB IP addresses behind each subdomain.
{: shortdesc}

Subdomain
:   When you create a public NLB in a single-zone or multizone cluster, you can expose your app to the internet by creating a subdomain for the NLB IP address. Additionally, {{site.data.keyword.cloud_notm}} takes care of generating and maintaining the wildcard SSL certificate for the subdomain for you. In multizone clusters, you can create a subdomain and add the NLB IP address in each zone to that subdomain DNS entry. For example, if you deployed NLBs for your app in three zones in US-South, you can create the subdomain `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` for the three NLB IP addresses. When a user accesses your app subdomain, the client accesses one of these IPs at random, and the request is sent to that NLB.

You currently can't create subdomains for private NLBs.
{: note}

Health check monitor
:   Enable health checks on the NLB IP addresses behind a single subdomain to determine whether they are available or not. When you enable a monitor for your subdomain, the monitor health checks each NLB IP and keeps the DNS lookup results updated based on these health checks. For example, if your NLBs have IP addresses `1.1.1.1`, `2.2.2.2`, and `3.3.3.3`, a normal operation DNS lookup of your subdomain returns all 3 IPs, 1 of which the client accesses at random. If the NLB with IP address `3.3.3.3` becomes unavailable for any reason, such as due to zone failure, then the health check for that IP fails, the monitor removes the failed IP from the subdomain, and the DNS lookup returns only the healthy `1.1.1.1` and `2.2.2.2` IPs.

You can see all subdomains that are registered for NLB IPs in your cluster by running the following command.
```sh
ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
```
{: pre}

DNS microservice updates are asynchronous and might take several minutes to apply. Note that if you run an `ibmcloud ks nlb-dns` command and receive a 200 confirmation message, you might still have to wait for your changes to be implemented. To check the status of your subdomain, run `ibmcloud ks nlb-dns ls` and find the `Status` column in the output.
{: tip}


## Registering NLB IPs with a DNS subdomain
{: #loadbalancer_hostname_dns}

Expose your app to the public internet by creating a subdomain for the network load balancer (NLB) IP address.
{: shortdesc}

Before you begin:
* Review the following limitations.
    * You can't create subdomains for private NLBs.
    * You can register up to 128 subdomains. This limit can be lifted on request by opening a [support case](/docs/account?topic=account-using-avatar).
* [Create an NLB for your app in a single-zone cluster](/docs/containers?topic=containers-loadbalancer#lb_config) or [create NLBs in each zone of a multizone cluster](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

To create a subdomain for one or more NLB IP addresses:

1. Get the **EXTERNAL-IP** address for your NLB. If you have NLBs in each zone of a multizone cluster that expose one app, get the IPs for each NLB.
    ```sh
    kubectl get svc
    ```
    {: pre}

    In the following example output, the NLB **EXTERNAL-IPs** are `168.2.4.5` and `88.2.4.5`.
    ```sh
    NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
    lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
    lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
    ```
    {: screen}

2. Register the IP by creating a DNS subdomain. To specify multiple IP addresses, use multiple `--ip` options.
    ```sh
    ibmcloud ks nlb-dns create classic --cluster <cluster_name_or_id> --ip <NLB_IP> --ip <NLB2_IP> 
    ```
    {: pre}

3. Verify that the subdomain is created.
    ```sh
    ibmcloud ks nlb-dns ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output

    ```sh
    Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
    ```
    {: screen}

4. Optional: Set up a custom domain to point to the IBM-provided subdomain that you created in the previous step.
    * Register a custom domain by working with your Domain Name Service (DNS) provider.
    * Register a custom domain using [{{site.data.keyword.cloud_notm}} DNS](/docs/dns-svcs?topic=dns-svcs-getting-started).

    You can also register a custom domain by using the `service.kubernetes.io/ibm-load-balancer-cloud-provider-dns-name` annotation in your Load Balancer configuration.
    {: tip}


1. Define an alias for your custom domain by specifying the IBM-provided subdomain as a Canonical Name record (CNAME).

5. In a web browser, enter the URL to access your app through the subdomain that you created.

Next, you can [enable health checks on the subdomain by creating a health monitor](#loadbalancer_hostname_monitor).



## Understanding the subdomain format
{: #loadbalancer_hostname_format}

Subdomains for NLBs follow the format `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

For example, a subdomain that you create for an NLB might look like `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. The following table describes each component of the subdomain.

|NLB subdomain component|Description|
|----|----|
|`*`|The wildcard for the subdomain is registered by default for your cluster.|
|`<cluster_name>`|The name of your cluster. - If the cluster name is 26 characters or fewer and the cluster name is unique in this region, the entire cluster name is included and is not modified: `myclustername`.  \n - If the cluster name is 26 characters or fewer and there is an existing cluster of the same name in this region, the entire cluster name is included and a dash with six random characters is added: `myclustername-ABC123`.  \n - If the cluster name is 26 characters or greater and the cluster name is unique in this region, only the first 24 characters of the cluster name are used: `myveryverylongclusternam`.  \n - If the cluster name is 26 characters or greater and there is an existing cluster of the same name in this region, only the first 17 characters of the cluster name are used and a dash with six random characters is added: `myveryverylongclu-ABC123`.|
|`<globally_unique_account_HASH>`|A globally unique HASH is created for your {{site.data.keyword.cloud_notm}} account. All subdomains that you create for NLBs in clusters in your account use this globally unique HASH.|
|`0001`|Acts as a counter for each subdomain that you create.|
|`<region>`|The region that the cluster is created in.|
|`containers.appdomain.cloud`|The subdomain for {{site.data.keyword.containerlong_notm}} subdomains.|
{: caption="Understanding the NLB subdomain format" caption-side="bottom"}



## Enable health checks on a subdomain by creating a health monitor
{: #loadbalancer_hostname_monitor}

Enable health checks on the NLB IP addresses behind a single subdomain to determine whether they are available or not.
{: shortdesc}

If you use [Calico pre-DNAT network policies](/docs/containers?topic=containers-network_policies), [VPC security groups](/docs/containers?topic=containers-vpc-security-group-manage), [VPC access control lists (ACLs)](/docs/containers?topic=containers-vpc-acls), or another custom firewall solution to block incoming traffic to Ingress or router services, you must allow incoming traffic from the health monitoring endpoints. For more information, see the [documentation about allowing incoming network traffic for Ingress subdomain monitoring](/docs/containers?topic=containers-firewall#firewall-ingress-domain-monitor).
{: tip}

Before you begin, [register NLB IPs with a DNS subdomain](#loadbalancer_hostname_dns).

1. Get the name of your subdomain. In the output, note that the host has a monitor **Status** of `Unconfigured`.
    ```sh
    ibmcloud ks nlb-dns monitor ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output

    ```sh
    Hostname                                                                                   Status         Type    Port   Path
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
    ```
    {: screen}

2. Create a health check monitor for the subdomain. If you don't include a configuration parameter, the default value is used.
    ```sh
    ibmcloud ks nlb-dns monitor configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --type <type> --path <path> --timeout <timeout> --interval <interval> --port <port> --header <header>
    ```
    {: pre}

    `-c, --cluster <cluster_name_or_ID>`
    :   Required: The name or ID of the cluster where the subdomain is registered.

    `--nlb-host <host_name>`
    :   Required: The subdomain to enable a health check monitor for.

    `--enable`
    :   Include this option to enable a new health check monitor for a subdomain.

    `--type <type>`
    :   The protocol to use for the health check: `HTTP`, `HTTPS`, or `TCP`. Default: `HTTP`.

    `--path <path>`
    :   When `type` is `HTTPS`: The endpoint path to health check against. Default: `/`

    `--timeout <timeout>`
    :   The timeout, in seconds, before the IP is considered unreachable. The health check waits the number of seconds specified in the `interval` parameter before trying to reach the IP again. The value must be an integer in the range 1 - 60. Default: `5`

    `--interval <interval>`
    :   The interval, in seconds, between each health check. Short intervals might improve failover time, but increase load on the IPs. The value must be an integer in the range 60 - 300. Default: `60`. 

    `--port <port>`
    :   The port number to connect to for the health check. When `type` is `TCP`, this parameter is required. When `type` is `HTTP` or `HTTPS`, define the port only if you use a port other than 80 for HTTP or 443 for HTTPS. Default for TCP: `0`. Default for HTTP: `80`. Default for HTTPS: `443`.

    `--header <header>`
    :   Required when `type` is `HTTP` or `HTTPS`: HTTP request headers for the health check are limited to the Host header. This flag is valid only for type 'HTTP' or 'HTTPS'. This flag accepts values in the following format: '--header Header-Name=value'. When updating a monitor, the existing headers are replaced by the ones you specify. To delete all existing headers specify the flag with an empty value '--header ""'.


    Example command
    
    ```sh
    ibmcloud ks nlb-dns monitor configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --type HTTPS --path /alive --timeout 5 --interval 60 --header Host=example.com
    ```
    {: pre}

3. Verify that the health check monitor is configured with the correct settings.
    ```sh
    ibmcloud ks nlb-dns monitor get --cluster <cluster_name_or_id> --nlb-host <host_name>
    ```
    {: pre}

    Example output

    ```sh
    Status:           enabled

    Type:             https
    Method:           GET
    Path:             /alive
    Expected Codes:   2xx
    Port:             443
    Timeout:          5
    Interval:         60

    Headers:
    Host:      example.com
    ```
    {: screen}

4. View the health check status of your subdomain.
    ```sh
    ibmcloud ks nlb-dns monitor ls --cluster <cluster_name_or_id>
    ```
    {: pre}

    Example output

    ```sh
    Hostname                                                                                Status      Type    Port   Path
    mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     enabled     https   443    /alive
    ```
    {: screen}




### Updating and removing IPs and monitors from subdomains
{: #loadbalancer_hostname_delete}

You can add and remove NLB IP addresses from subdomains that you have generated. You can also disable and enable health check monitors for subdomains as needed.
{: shortdesc}

#### NLB IPs
{: #nlb-ips-remove-sd}

If you later add more NLBs in other zones of your cluster to expose the same app, you can add the NLB IPs to the existing subdomain.
```sh
ibmcloud ks nlb-dns add --cluster <cluster_name_or_id> --ip <NLB_IP> --ip <NLB2_IP> ... --nlb-host <host_name>
```
{: pre}

You can also remove IP addresses of NLBs that you no longer want to be registered with a subdomain. Note that you must run the following command for each IP address that you want to remove. If you remove all IPs from a subdomain, the subdomain still exists but no IPs are associated with it.
```sh
ibmcloud ks nlb-dns rm classic --cluster <cluster_name_or_id> --ip <ip> --nlb-host <host_name>
```
{: pre}



#### Health check monitors
{: #health-check-config-mon}

If you need to change your health monitor configuration, you can change specific settings. Include only the options for the settings that you want to change.
```sh
ibmcloud ks nlb-dns monitor configure --cluster <cluster_name_or_id> --nlb-host <host_name> --type <type> --path <path> --timeout <timeout> --interval <interval> --port <port> --header <header>
```
{: pre}

You can disable the health check monitor for a subdomain at any time by running the following command:
```sh
ibmcloud ks nlb-dns monitor disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

To re-enable a monitor for a subdomain, run the following command:
```sh
ibmcloud ks nlb-dns monitor enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
