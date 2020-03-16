---

copyright:
  years: 2014, 2020
lastupdated: "2020-03-16"

keywords: kubernetes, iks, firewall, ips

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


# VPC: Opening required ports and IP addresses in your firewall
{: #vpc-firewall}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> This firewall information is specific to VPC clusters. For firewall information for classic clusters, see [Opening required ports and IP addresses in your firewall for classic clusters](/docs/containers?topic=containers-firewall).
{: note}

Review these situations in which you might need to open specific ports and IP addresses in your firewalls for your {{site.data.keyword.containerlong}} clusters.
{:shortdesc}

* [Corporate firewalls](#vpc-corporate): If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, you must allow access to run `ibmcloud`, `ibmcloud ks`, `ibmcloud cr`, `kubectl`, and `calicoctl` commands from your local system.
* [Access control lists](#firewall_acls): If you use ACLs on your VPC subnets to act as a firewall to restrict all worker node egress, you must allow your worker nodes to access the resources that are required for the cluster to function.
* [Security groups](#security_groups): If you use use non-default security groups that are applied at the level of the VPC, you must allow traffic requests that are routed to node ports on your worker nodes.
* [Other services or network firewalls](#vpc-whitelist_workers): To allow your cluster to access services that run inside or outside {{site.data.keyword.cloud_notm}} or in on-premises networks and that are protected by a firewall, you must add the IP addresses of your worker nodes in that firewall.

<br />


## Opening ports in a corporate firewall
{: #vpc-corporate}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, you must allow access to run [`ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands](#vpc-firewall_bx), [`kubectl` commands](#vpc-firewall_kubectl), and [`calicoctl` commands](#vpc-firewall_calicoctl) from your local system.
{: shortdesc}

### Running `ibmcloud`, `ibmcloud ks`, and `ibmcloud cr` commands from behind a firewall
{: #vpc-firewall_bx}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `ibmcloud`, `ibmcloud ks` and `ibmcloud cr` commands, you must allow TCP access for {{site.data.keyword.cloud_notm}}, {{site.data.keyword.containerlong_notm}}, and {{site.data.keyword.registrylong_notm}}.
{:shortdesc}

1. Allow access to `cloud.ibm.com` on port 443 in your firewall.
2. Verify your connection by logging in to {{site.data.keyword.cloud_notm}} through this API endpoint.
  ```
  ibmcloud login -a https://cloud.ibm.com/
  ```
  {: pre}
3. Allow access to `containers.cloud.ibm.com` on port 443 in your firewall.
4. Verify your connection. If access is configured correctly, ships are displayed in the output.
   ```
   curl https://containers.cloud.ibm.com/v1/
   ```
   {: pre}

   Example output:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}
5. Allow access to the [{{site.data.keyword.registrylong_notm}} regions](/docs/Registry?topic=registry-registry_overview#registry_regions) that you plan to use on port 443 and 4443 in your firewall. The global registry stores IBM-provided public images, and regional registries store your own private or public images. If your firewall is IP-based, you can see which IP addresses are opened when you allow access to the {{site.data.keyword.registryshort_notm}} regional service endpoints by reviewing [this table](/docs/containers?topic=containers-firewall#firewall_registry).
  * Global registry: `icr.io`
  * AP North: `jp.icr.io`
  * AP South: `au.icr.io`
  * EU Central: `de.icr.io`
  * UK South: `uk.icr.io`
  * US East, US South: `us.icr.io`

6. Verify your connection. The following is an example for the US East and US South regional registry. If access is configured correctly, a message of the day is returned in the output.
   ```
   curl https://us.icr.io/api/v1/messages
   ```
   {: pre}

</br>

### Running `kubectl` commands from behind a firewall
{: #vpc-firewall_kubectl}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `kubectl` commands, you must allow TCP access for the cluster.
{:shortdesc}

When a cluster is created, the port in the service endpoint URLs is randomly assigned from within 20000-32767. You can either choose to open port range 20000-32767 for any cluster that might get created or you can choose to allow access for a specific existing cluster.

Before you begin, allow access to [run `ibmcloud ks` commands](#vpc-firewall_bx).

To allow access for a specific cluster:

1. Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated account, include the `--sso` option.

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. If the cluster is in a resource group other than `default`, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have at least the [**Viewer** role](/docs/containers?topic=containers-users#platform) for the resource group.
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

4. Get the name of your cluster.

   ```
   ibmcloud ks cluster ls
   ```
   {: pre}

5. Retrieve the service endpoint URLs for your cluster.
 * If only the **Public Service Endpoint URL** is populated, get this URL. Your authorized cluster users can access the master through this endpoint on the public network.
 * If only the **Private Service Endpoint URL** is populated, get this URL. Your authorized cluster users can access the master through this endpoint on the private network.
 * If both the **Public Service Endpoint URL** and **Private Service Endpoint URL** are populated, get both URLs. Your authorized cluster users can access the master through the public endpoint on the public network or the private endpoint on the private network.

  ```
  ibmcloud ks cluster get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  ...
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  ...
  ```
  {: screen}

6. Allow access to the service endpoint URLs and ports that you got in the previous step. If your firewall is IP-based, you can see which IP addresses are opened when you allow access to the service endpoint URLs by reviewing [this table](/docs/containers?topic=containers-firewall#master_ips).

7. Verify your connection.
  * If the public service endpoint is enabled:
    ```
    curl --insecure <public_service_endpoint_URL>/version
    ```
    {: pre}

    Example command:
    ```
    curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
    ```
    {: pre}

    Example output:
    ```
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
  * If the private service endpoint is enabled, you must be in your {{site.data.keyword.cloud_notm}} private network or connect to the private network through a VPN connection to verify your connection to the master. **Note**: You must [expose the master endpoint through a private load balancer](/docs/containers?topic=containers-access_cluster#access_private_se) so that users can access the master through a VPN or {{site.data.keyword.BluDirectLink}} connection.
    ```
    curl --insecure <private_service_endpoint_URL>/version
    ```
    {: pre}

    Example command:
    ```
    curl --insecure https://c3-private.<region>.containers.cloud.ibm.com:31142/version
    ```
    {: pre}

    Example output:
    ```
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

8. Optional: Repeat these steps for each cluster that you need to expose.

</br>

### Running `calicoctl` commands from behind a firewall
{: #vpc-firewall_calicoctl}

If corporate network policies prevent access from your local system to public endpoints via proxies or firewalls, to run `calicoctl` commands, you must allow TCP access for the Calico commands.
{:shortdesc}

Before you begin, allow access to run [`ibmcloud` commands](#vpc-firewall_bx) and [`kubectl` commands](#vpc-firewall_kubectl).

1. Retrieve the IP address from the master URL that you used to allow the [`kubectl` commands](#vpc-firewall_kubectl).

2. Get the port for etcd.

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. Allow access for the Calico policies via the master URL IP address and the etcd port.

<br />


## Allowing the cluster to access resources through ACLs
{: #firewall_acls}

You can use access control lists (ACLs) on your VPC subnets to act as a firewall to restrict worker node ingress and egress. However, you must allow your worker nodes to access the resources that are required for the cluster to function by following the steps in [Creating access control lists (ACLs) to control traffic to and from your cluster](/docs/containers?topic=containers-vpc-network-policy#acls).
{: shortdesc}



<br />


## Allowing the cluster to access resources through Calico policies
{: #firewall_calico}

Although Calico policies are supported in VPC clusters, you can remain VPC-native by using [VPC ACLs](/docs/containers?topic=containers-vpc-network-policy#acls) for your subnets instead. However, if you create multiple clusters that use the same subnets in one VPC, you cannot use ACLs to control traffic between the clusters because they share the same subnets. You can use [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers) to isolate your clusters on the private network.
{: shortdesc}

<br />


## Opening required ports in VPC security groups
{: #security_groups}

If you use non-default security groups that are applied at the level of the VPC, incoming traffic requests to apps in your cluster are denied by default. You must modify the security group rules to allow traffic requests that are routed to node ports on your worker nodes.
{: shortdesc}

[VPC security groups](/docs/vpc?topic=vpc-using-security-groups) are applied to the network interface of a single virtual server to filter traffic at the hypervisor level. Because the worker nodes of your VPC cluster exist in a service account and are not listed in the VPC infrastructure dashboard, you cannot attach a security group to your individual worker nodes instances. However, you can use security groups at the level of the VPC. If you create a non-default security group for a VPC, you must include an inbound rule that allows incoming TCP traffic to ports `30000 - 32767`.



When you modify a security group to allow incoming TCP traffic to ports `30000 - 32767`, you can choose to allow traffic from any source, or only from the VPC subnets that your cluster is connected. If you choose to allow traffic from only your cluster's VPC subnets, your traffic rule provides more restrictive security, because incoming traffic is only permitted from your VPC load balancers that are on these subnets. However, any time that you add a VPC subnet to your cluster, you must create a new rule that allows incoming traffic from that subnet's CIDR.
{: note}

### Opening security group ports in the console
{: #security_groups_ui}

1. From the [Virtual private cloud dashboard](https://cloud.ibm.com/vpc-ext/network/vpcs){: external}, click the name of the VPC that your cluster is in.
2. In the **Address prefixes** section, copy the **IP Range**. If your cluster is multizone, copy the range for each subnet.
3. From the [Security groups for VPC page](https://cloud.ibm.com/vpc-ext/network/securityGroups){: external}, click the security group for your VPC.
4. In the **Inbound rules** section, click **New rule**. The **TCP** protocol is pre-selected.
5. Type `30000` for the **Port min** and `32767` for the **Port max**.
6. For the **Source Type**, select **CIDR block** and paste one IP range that you previously copied.
7. Click **Save**.
8. If your cluster is multizone, repeat steps 4 - 7 for each IP range that you copied in step 2.

### Opening security group ports from the CLI
{: #security_groups_cli}

1. Install the `infrastructure-service` plug-in. The prefix for running commands is `ibmcloud is`.
    ```
    ibmcloud plugin install infrastructure-service
    ```
    {: pre}

2. Target Generation 1 of VPC compute.
   ```
   ibmcloud is target --gen 1
   ```
   {: pre}

3. List your security groups. For your **VPC**, if only the default security group with a randomly generated name is listed, inbound traffic to the node ports on the worker is already allowed. If you have another security group, note its ID.
  ```
  ibmcloud is security-groups
  ```
  {: pre}
  Example output with only the default security group of a randomly generated name, `preppy-swimmer-island-green-refreshment`:
  ```
  ID                                     Name                                       Rules   Network interfaces         Created                     VPC                      Resource group
  1a111a1a-a111-11a1-a111-111111111111   preppy-swimmer-island-green-refreshment    4       -                          2019-08-12T13:24:45-04:00   <vpc_name>(bbbb222b-.)   c3c33cccc33c333ccc3c33cc3c333cc3
  ```
  {: screen}

4. List the VPC subnets for your cluster. You can find the ID of the VPC that your cluster is in by running `ibmcloud ks cluster get -c <cluster_name_or_ID>` and checking the **VPCs** field. If you have a multizone cluster, run this command to get the subnet for each zone. In the output, note the **IPv4 CIDR Block**.
  ```
  ibmcloud ks subnets --provider vpc-classic --vpc-id <VPC_ID> --zone <VPC_zone>
  ```
  {: pre}
  Example output:
  ```
  Name                   ID                                     Public Gateway Name   Public Gateway ID   IPv4 CIDR Block   Available IPv4 Addresses
  mycluster-us-south-1   5f5787a4-f560-471b-b6ce-20067ac93439   -                     -                   10.240.0.0/24     183
  ```
  {: screen}

5. For each security group that you found in step 3, add a rule to allow inbound TCP traffic on ports 30000-32767. If you have a multizone cluster, you must run this command for each subnet that you found step 4.
  ```
  ibmcloud is security-group-rule-add <security_group_ID> inbound tcp --port-min 30000 --port-max 32767 --remote <VPC_subnet_CIDR>
  ```
  {: pre}

<br />


## Whitelisting your cluster in other services' firewalls or in on-premises firewalls
{: #vpc-whitelist_workers}

If you want to access services that run inside or outside {{site.data.keyword.cloud_notm}} or on-premises and that are protected by a firewall, you can add the IP addresses of your worker nodes in that firewall to allow outbound network traffic to your cluster. For example, you might want to read data from an {{site.data.keyword.cloud_notm}} database that is protected by a firewall, or whitelist your worker node subnets in an on-premises firewall to allow network traffic from your cluster.
{:shortdesc}

1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

2. Get the worker node subnets or the worker node IP addresses.
  * **Worker node subnets**: If you anticipate changing the number of worker nodes in your cluster frequently, such as if you enable the [cluster autoscaler](/docs/containers?topic=containers-ca#ca), you might not want to update your firewall for each new worker node. Instead, you can whitelist the VLAN subnets that the cluster uses. Keep in mind that the VLAN subnet might be shared by worker nodes in other clusters.
    <p class="note">The **primary public subnets** that {{site.data.keyword.containerlong_notm}} provisions for your cluster come with 14 available IP addresses, and can be shared by other clusters on the same VLAN. When you have more than 14 worker nodes, another subnet is ordered, so the subnets that you need to whitelist can change. To reduce the frequency of change, create worker pools with worker node flavors of higher CPU and memory resources so that you don't need to add worker nodes as often.</p>
    1. List the worker nodes in your cluster.
      ```
      ibmcloud ks worker ls --cluster <cluster_name_or_ID>
      ```
      {: pre}

    2. From the output of the previous step, note all the unique network IDs (first three octets) of the **Public IP** for the worker nodes in your cluster. If you want to whitelist a private-only cluster, note the **Private IP** instead. In the following output, the unique network IDs are `169.xx.178` and `169.xx.210`.
        ```
        ID                                                  Public IP        Private IP     Machine Type        State    Status   Zone    Version
        kube-dal10-crb2f60e9735254ac8b20b9c1e38b649a5-w31   169.xx.178.101   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal10   1.16.8
        kube-dal10-crb2f60e9735254ac8b20b9c1e38b649a5-w34   169.xx.178.102   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal10   1.16.8
        kube-dal12-crb2f60e9735254ac8b20b9c1e38b649a5-w32   169.xx.210.101   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal12   1.16.8
        kube-dal12-crb2f60e9735254ac8b20b9c1e38b649a5-w33   169.xx.210.102   10.xxx.xx.xxx   b3c.4x16.encrypted   normal   Ready    dal12   1.16.8
        ```
        {: screen}
    3.  List the VLAN subnets for each unique network ID.
        ```
        ibmcloud sl subnet list | grep -e <networkID1> -e <networkID2>
        ```
        {: pre}

        Example output:
        ```
        ID        identifier       type                 network_space   datacenter   vlan_id   IPs   hardware   virtual_servers
        1234567   169.xx.210.xxx   ADDITIONAL_PRIMARY   PUBLIC          dal12        1122334   16    0          5
        7654321   169.xx.178.xxx   ADDITIONAL_PRIMARY   PUBLIC          dal10        4332211   16    0          6
        ```
        {: screen}
    4.  Retrieve the subnet address. In the output, find the number of **IPs**. Then, raise `2` to the power of `n` equal to the number of IPs. For example, if the number of IPs is `16`, then `2` is raised to the power of `4` (`n`) to equal `16`. Now get the subnet CIDR by subtracting the value of `n` from `32` bits. For example, when `n` equals `4`, then the CIDR is `28` (from the equation `32 - 4 = 28`). Combine the **identifier** mask with the CIDR value to get the full subnet address. In the previous output, the subnet addresses are:
        *   `169.xx.210.xxx/28`
        *   `169.xx.178.xxx/28`
  * **Individual worker node IP addresses**: If you have a small number of worker nodes that run only one app and do not need to scale, or if you want to whitelist only one worker node, list all the worker nodes in your cluster and note the **Public IP** addresses. If your worker nodes are connected to a private network only and you want to connect to {{site.data.keyword.cloud_notm}} services by using the private service endpoint, note the **Private IP** addresses instead. Only these worker nodes are whitelisted. If you delete the worker nodes or add worker nodes to the cluster, you must update your firewall accordingly.
    ```
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}
4.  Add the subnet CIDR or IP addresses to your service's firewall for outbound traffic or your on-premises firewall for inbound traffic.
5.  Repeat these steps for each cluster that you want to whitelist.

