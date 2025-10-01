---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-01"


keywords: kubernetes, allowlist, ips

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Opening required ports and IP addresses in allowlists
{: #vpc-firewall}

[Virtual Private Cloud]{: tag-vpc}

This allowlist information is specific to VPC clusters. For allowlist information for classic clusters, see [Opening required ports and IP addresses in your allowlist for classic clusters](/docs/containers?topic=containers-firewall).
{: note}

## Opening ports in a corporate allowlist
{: #vpc-corporate}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, you must allow access to run [`ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands](#vpc-firewall_bx), [`kubectl` commands](#vpc-firewall_kubectl), and [`calicoctl` commands](#vpc-firewall_calicoctl) from your local system.
{: shortdesc}

### Running `ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands from behind an allowlist
{: #vpc-firewall_bx}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `ibmcloud`, `ibmcloud ks` and `ibmcloud cr` commands, you must allow TCP access for {{site.data.keyword.cloud_notm}}, {{site.data.keyword.containerlong_notm}}, and {{site.data.keyword.registrylong_notm}}.
{: shortdesc}

1. Allow access to `cloud.ibm.com` on port 443 in your allowlist.
2. Verify your connection by logging in to {{site.data.keyword.cloud_notm}} through this API endpoint.
    ```sh
    ibmcloud login -a https://cloud.ibm.com/
    ```
    {: pre}

3. Allow access to `containers.cloud.ibm.com` on port 443 in your allowlist.
4. Verify your connection. If access is configured correctly, messages similar to the following are displayed in the output.
    ```sh
    curl https://containers.cloud.ibm.com/global/v1/versions 
    ```
    {: pre}
    
    Example output
    ```sh
    {"kubernetes":[{"major":1,"minor":19,"patch":16,"default":false,"end_of_service":""},{"major":1,"minor":20,"patch":13,"default":false,"end_of_service":""},{"major":1,"minor":21,"patch":7,"default":true,"end_of_service":""},{"major":1,"minor":22,"patch":4,"default":false,"end_of_service":""}],"openshift":[{"major":3,"minor":11,"patch":542,"default":false,"end_of_service":"2022-06-06T12:00:00+0000"},{"major":4,"minor":6,"patch":47,"default":false,"end_of_service":""},{"major":4,"minor":7,"patch":37,"default":false,"end_of_service":""},{"major":4,"minor":8,"patch":21,"default":true,"end_of_service":""}]}
    ```
    {: pre}


5. Allow access to the [{{site.data.keyword.registrylong_notm}} regions](/docs/Registry?topic=Registry-registry_overview#registry_regions) that you plan to use on port 443 in your allowlist. The global registry stores IBM-provided public images, and regional registries store your own private or public images. If your allowlist is IP-based, you can see which IP addresses are opened when you allow access to the {{site.data.keyword.registrylong_notm}} regional service endpoints by reviewing [this table](/docs/containers?topic=containers-firewall#firewall_registry).

6. Verify your connection. The following is an example for the US East and US South regional registry. If access is configured correctly, a message of the day is returned in the output. Note that if there are no messages, a `204` is returned.
    ```sh
    curl -i https://us.icr.io/api/v1/messages
    ```
    {: pre}

### Running `kubectl` commands from behind an allowlist
{: #vpc-firewall_kubectl}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `kubectl` commands, you must allow TCP access for the cluster.
{: shortdesc}

When a cluster is created, the port in the service endpoint URLs is randomly assigned from within 30000-32767. You can either choose to open port range 30000-32767 for any cluster that might get created or you can choose to allow access for a specific existing cluster.

Before you begin, allow access to [run `ibmcloud ks` commands](#vpc-firewall_bx).

To allow access for a specific cluster:

1. Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated account, include the `--sso` option.

    ```sh
    ibmcloud login [--sso]
    ```
    {: pre}

1. If the cluster is in a resource group other than `default`, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have at least the [**Viewer** role](/docs/containers?topic=containers-iam-platform-access-roles) for the resource group.
    ```sh
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

1. Get the name of your cluster.

    ```sh
    ibmcloud ks cluster ls
    ```
    {: pre}

1. Retrieve the service endpoint URLs for your cluster.
    * If only the **Private Service Endpoint URL** is populated, get this URL. Your authorized cluster users can access the master through this endpoint on the private network.
    * If both the **Public Service Endpoint URL** and **Private Service Endpoint URL** are populated, get both URLs. Your authorized cluster users can access the master through the public endpoint on the public network or the private endpoint on the private network.

    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
    Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
    ...
    ```
    {: screen}

1. Allow access to the service endpoint URLs and ports that you got in the previous step. If your allowlist is IP-based, you can see which IP addresses are opened when you allow access to the service endpoint URLs by reviewing [this table](/docs/containers?topic=containers-firewall#master_ips).

1. Verify your connection.
    * If the public cloud service endpoint is enabled:
        ```sh
        curl --insecure <public_service_endpoint_URL>/version
        ```
        {: pre}

        Example command
        ```sh
        curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
        ```
        {: pre}

        Example output
        ```json
        {
            "major": "1",
            "minor": "7+",
            "gitVersion": "v1.7.4-2+eb9172c211dc41",
            "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
            "gitTreeState": "clean",
            "buildDate": "2017-11-16T08:13:08Z",
            "goVersion": "go1.8.3",
            "compiler": "gc",
            "platform": "linux/amd64"
        }
        ```
        {: screen}

    * If only the private cloud service endpoint is enabled, you must be in your {{site.data.keyword.cloud_notm}} private network or connect to the private network through a VPN connection to verify your connection to the master. **Note**: You must [expose the master endpoint through a private load balancer](/docs/containers?topic=containers-access_cluster#access_private_se) so that users can access the master through a VPN or {{site.data.keyword.BluDirectLink}} connection.
        ```sh
        curl --insecure <private_service_endpoint_URL>/version
        ```
        {: pre}

        Example command
        ```sh
        curl --insecure https://c3-private.<region>.containers.cloud.ibm.com:31142/version
        ```
        {: pre}

        Example output
        ```json
        {
            "major": "1",
            "minor": "7+",
            "gitVersion": "v1.7.4-2+eb9172c211dc41",
            "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
            "gitTreeState": "clean",
            "buildDate": "2017-11-16T08:13:08Z",
            "goVersion": "go1.8.3",
            "compiler": "gc",
            "platform": "linux/amd64"
        }
        ```
        {: screen}

1. Optional: Repeat these steps for each cluster that you need to expose.

### Running `calicoctl` commands from behind an allowlist
{: #vpc-firewall_calicoctl}

If corporate network policies prevent access from your local system to public endpoints via proxies or allowlists, to run `calicoctl` commands, you must allow TCP access for the Calico commands.
{: shortdesc}

Before you begin, allow access to run [`ibmcloud` commands](#vpc-firewall_bx) and [`kubectl` commands](#vpc-firewall_kubectl).

1. Retrieve the IP address from the master URL that you used to allow the [`kubectl` commands](#vpc-firewall_kubectl).

2. Get the port for etcd.

    ```sh
    kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
    ```
    {: pre}

3. Allow access for the Calico policies via the master URL IP address and the etcd port.


## Allowing traffic from your cluster in other services' allowlists or in on-premises allowlists
{: #vpc-allowlist_workers}

Allow your worker nodes to communicate with services that are protected by allowlists.
{: shortdesc}

For example, you might have services that run inside or outside {{site.data.keyword.cloud_notm}}, or services that run on-premises, that are protected by an allowlist. You want to permit incoming network traffic to those services from your cluster. In your service's allowlist, you must add the external IP addresses of the public gateways on your cluster's VPC subnets.

If you want to permit egress from your allowlist-protected services to your cluster, you must add your worker nodes' private IP addresses or your cluster's VPC subnet CIDRs in your service's allowlist. Note that because worker nodes in VPC clusters have only private IP addresses, connections into the VPC cluster worker nodes can only originate from systems that are connected to your IBM Cloud private network.

Before you begin
1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
2. Install the `infrastructure-service` CLI plug-in. The prefix for running VPC infrastructure commands is `ibmcloud is`.
    ```sh
    ibmcloud plugin install infrastructure-service
    ```
    {: pre}

### Allowing ingress from a cluster to another service
{: #vpc-allowlist_workers_ingress}

To permit ingress from your cluster to another service, modify that service's allowlist or your on-premises allowlist.
{: shortdesc}

1. Get the **Worker Zones** and **VPCs** that your cluster is created in.
    ```sh
    ibmcloud ks cluster get -c <cluster>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Worker Zones:                   us-south-1, us-south-2, us-south-3
    Ingress Subdomain:              vpc-prod.us-south.containers.appdomain.cloud
    Ingress Secret:                 vpc-prod
    Creator:                        -
    Public Service Endpoint URL:    https://c2.us-south.containers.cloud.ibm.com:20267
    Private Service Endpoint URL:   https://c2.private.us-south.containers.cloud.ibm.com:20267
    Pull Secrets:                   enabled in the default namespace
    VPCs:                           ff537d43-a5a4-4b65-9627-17eddfa5237b
    ...
    ```
    {: screen}

2. For the worker zones and VPC that you found, ensure that you [enabled a public gateway on the VPC subnets in each worker zone](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#attach-public-gateway-cli).

3. List the public gateways for the subnets. In the output, for the zones and VPC that your cluster is in, note the gateway **Floating IP** addresses for the subnets.
    ```sh
    ibmcloud is public-gateways
    ```
    {: pre}

    Example output

    ```sh
    ID                                     Name                                       Status      Floating IP      VPC              Zone
    5d308ea5-9f32-43b3-aaae-194d5723a3e5   pgw-b9d45630-c053-11e9-b2f8-79328ce05e7e   available   169.XX.XXX.XX    test-vpc         us-south-1
    f8b95e43-a408-4dc8-a489-ed649fc4cfec   pgw-18a3ebb0-b539-11e9-9838-f3f4efa02374   available   169.XX.XXX.XX    prod             us-south-1
    2ba9a280-fffa-4b0c-bdca-7970f09f9b8a   pgw-73b62bc0-b53a-11e9-9838-f3f4efa02374   available   169.XX.XXX.XX    prod             us-south-2
    057ddef6-631f-4b22-89eb-1e99982a54fa   pgw-64c5cae0-0be2-11ea-8f26-e1565e79a36c   available   52.XX.XXX.XXX    prod             us-south-3
    ```
    {: screen}

4. Add the public gateway IP addresses to your service's allowlist or your on-premises allowlist for inbound traffic.
5. Repeat these steps for each cluster that you want to allow traffic to or from.

### Allowing egress to a cluster from another service
{: #vpc-allowlist_workers_egress}

To permit egress to your cluster from another service, modify that service's allowlist or your on-premises allowlist.
{: shortdesc}

1. Get the worker node subnets or the worker node IP addresses.
    * **Worker node subnet CIDRs**: If you anticipate changing the number of worker nodes in your cluster frequently, such as if you enable the [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-install-addon), you might not want to update your allowlist for each new worker node. Instead, you can add the VPC subnets that the cluster uses. Keep in mind that the VPC subnet might be shared by worker nodes in other clusters.
        1. Get the **Worker Zones** and **VPCs** that your cluster is created in.
            ```sh
            ibmcloud ks cluster get -c <cluster>
            ```
            {: pre}

            Example output
            ```sh
            ...
            Worker Zones:                   us-south-1, us-south-2, us-south-3
            Ingress Subdomain:              vpc-prod.us-south.containers.appdomain.cloud
            Ingress Secret:                 vpc-prod
            Creator:                        -
            Public Service Endpoint URL:    https://c2.us-south.containers.cloud.ibm.com:20267
            Private Service Endpoint URL:   https://c2.private.us-south.containers.cloud.ibm.com:20267
            Pull Secrets:                   enabled in the default namespace
            VPCs:                           ff537d43-a5a4-4b65-9627-17eddfa5237b
            ...
            ```
            {: screen}

        2. For the subnets in the zones and VPC that your cluster is in, note the **Subnet CIDR**.
            ```sh
            ibmcloud is subnets
            ```
            {: pre}

            Example output
            ```sh
            ID                                     Name             Status      Subnet CIDR        Addresses   ACL                                                          Public Gateway                             VPC              Zone
            5f5787a4-f560-471b-b6ce-20067ac93439   vpc-prod-dal1    available   10.240.0.0/24      183/256     allow-all-network-acl-ff537d43-a5a4-4b65-9627-17eddfa5237b   -                                          prod             us-south-1
            e3c19786-1c54-4248-86ca-e60aab74ed62   vpc-prod-dal2    available   10.240.64.0/24     183/256     allow-all-network-acl-ff537d43-a5a4-4b65-9627-17eddfa5237b   -                                          prod             us-south-2
            2930a068-51cc-4eca-807b-3f296d0891b4   vpc-prod-dal3    available   10.240.128.0/24    249/256     allow-all-network-acl-ff537d43-a5a4-4b65-9627-17eddfa5237b   -                                          prod             us-south-3
            ```
            {: screen}

    * **Individual worker node IP addresses**: If you have a small number of worker nodes that run only one app and don't need to scale, or if you want to add only one worker node, list all the worker nodes in your cluster and note the **Primary IP** addresses. Only these worker nodes are added. If you delete the worker nodes or add worker nodes to the cluster, you must update your allowlist accordingly.
        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

2. Add the subnet CIDRs or individual worker node IP addresses to your service's allowlist or your on-premises allowlist for outbound traffic.
3. Repeat these steps for each cluster that you want to allow traffic to or from.

## Opening ports in VPC Security Groups or VPC ACLs
{: #vpc-opening-ports}

If you set up [VPC security groups](/docs/containers?topic=containers-vpc-security-group) or [VPC access control lists (ACLs)](/docs/containers?topic=containers-vpc-acls) to secure your cluster network, ensure that you create the rules to allow the necessary traffic to communicate with other {{site.data.keyword.cloud_notm}} services. 

### Opening required ports in public allowlists
{: #vpc-firewall-public}


#### Optional: Allow incoming network traffic for Ingress subdomain monitoring 
{: #firewall-ingress-domain-monitor}

If you want to use the [Ingress domain health monitoring](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor) to monitor the health of your service endpoints, you must allow inbound access from the monitoring services.


By default, monitoring health requests are sent through HTTPS to port 443, therefore you must allowlist traffic from the below IP ranges targeted to port 443. If your health monitor is configured to use HTTP instead, allowlist traffic must be targeted to port 80. Additionally, if you use a custom TCP port, make sure to allow incoming traffic to that port.

For more information see the [IBM NS1 Connect Documentation about monitoring](https://www.ibm.com/docs/en/ns1-connect?topic=monitoring).

##### IBM NS1 Connect Monitoring IP Ranges
{: #firewall-ingress-domain-monitor-ns1}

 - `163.114.225.0/24`
 - `163.114.230.0/24`
 - `163.114.231.0/24`
