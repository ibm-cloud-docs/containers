---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-20"


keywords: containers, {{site.data.keyword.containerlong_notm}} kubernetes, ips, vlans, networking, public gateway

subcollection: containers


---


{{site.data.keyword.attribute-definition-list}}


# Configuring VPC subnets
{: #vpc-subnets}

[Virtual Private Cloud]{: tag-vpc}

Change the pool of available portable public or private IP addresses by adding subnets to your {{site.data.keyword.containerlong}} VPC cluster.
{: shortdesc}

The content on this page is specific to VPC clusters. For information about classic clusters, see [Configuring subnets and IP addresses for classic clusters](/docs/containers?topic=containers-subnets).
{: note}

## Overview of VPC networking in {{site.data.keyword.containerlong_notm}}
{: #vpc_basics}

Understand the basic concepts of VPC networking in {{site.data.keyword.containerlong_notm}} clusters.
{: shortdesc}

### Subnets
{: #vpc_basics_subnets}

Before you create a VPC cluster for the first time, you must [create a VPC subnet](https://cloud.ibm.com/infrastructure/provision/network){: external} in each zone where you want to deploy worker nodes. A VPC subnet is a specified private IP address range (CIDR block) and configures a group of worker nodes and pods as if they are attached to the same physical wire.
{: shortdesc}

When you create a cluster, you can specify only one existing VPC subnet for each zone. Each worker node that you add in a cluster is deployed with a private IP address from the VPC subnet in that zone. After the worker node is provisioned, the worker node IP address persists after a `reboot` operation, but the worker node IP address changes after `replace` and `update` operations.

Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
{: important}

#### How many IP addresses do I need for my VPC subnet?
{: #vpc-subnets-how-many}

When you [create your VPC subnet](https://cloud.ibm.com/infrastructure/provision/network){: external}, make sure to create a subnet with enough IP addresses for your cluster, such as 256. You can't change the number of IP addresses that a VPC subnet has later.

Keep in mind the following IP address reservations.
- 5 IP addresses are [reserved by VPC](/docs/vpc?topic=vpc-about-networking-for-vpc#addresses-reserved-by-the-system) from each subnet by default.
- 1 IP address from one subnet in each zone where your cluster has worker nodes is required for the [virtual private endpoints (VPE) gateway](#vpc_basics_vpe).
- 1 IP address is required per worker node in your cluster.
- 1 IP address is required each time that you update or replace a worker node. These IP addresses are eventually reclaimed and available for reuse.
- 2 IP addresses are used each time that you create a public or private load balancer. If you have a multizone cluster, these 2 IP addresses are spread across zones, so the subnet might not have an IP address reserved.
- Other networking resources that you set up for the cluster, such as a VPNaaS or LBaaS autoscaling, might require additional IP addresses or have other [service limitations](/docs/vpc?topic=vpc-limitations). For example, LBaaS autoscaling might scale up to 16 IP addresses per load balancer.

#### What IP ranges can I use for my VPC subnets?
{: #vpc-subnet-ranges}


The default IP address range for VPC subnets is 10.0.0.0 – 10.255.255.255. For a list of IP address ranges per VPC zone, see the [VPC default address prefixes](/docs/vpc?topic=vpc-configuring-address-prefixes). {: #vpc-ip-range}

If you need to create your cluster by using custom-range subnets, see the guidance for [custom address prefixes](/docs/vpc?topic=vpc-configuring-address-prefixes). However, if you use custom-range subnets for your worker nodes, you must ensure that the IP range for the worker node subnets don't overlap with your cluster's pod subnet. The pod subnet varies depending on your subnet choices during cluster creation and your cluster's infrastructure type:
* If you specified your own pod subnet in the `--pod-subnet` option during cluster creation, your pods are assigned IP addresses from this range.
* If you did not specify a custom pod subnet during cluster creation, your cluster uses the default pod subnet. In the first cluster that you create in a VPC, the default pod subnet is `172.17.0.0/18`. In the second cluster that you create in that VPC, the default pod subnet is `172.17.64.0/18`. In each subsequent cluster, the pod subnet range is the next available, non-overlapping `/18` subnet.

#### How do I create subnets for classic infrastructure access?
{: #create-subnets-how-to}

If you enable classic access when you create your VPC, [classic access default address prefixes](/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure#classic-access-default-address-prefixes) automatically determine the IP ranges of any subnets that you create. However, the default IP ranges for classic access VPC subnets conflict with the subnets for the {{site.data.keyword.containerlong_notm}} control plane. Instead, you must [create the VPC without the automatic default address prefixes, and then create your own address prefixes and subnets within those ranges for your cluster](#classic_access_subnets).

#### Can I specify subnets for pods and services in my cluster?
{: #specify-subnets}

If you plan to connect your cluster to on-premises networks through {{site.data.keyword.dl_full_notm}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your pods, and a custom subnet CIDR to provide the private IP addresses for services.

To specify custom pod and service subnets during cluster creation, use the `--pod-subnet` and `--service-subnet` options in the `ibmcloud ks cluster create` CLI command.

To see the pod and service subnets that your cluster uses, look for the `Pod Subnet` and `Service Subnet` fields in the output of `ibmcloud ks cluster get`.

#### Pods
{: #vpc_basics_subnets_pods}

Default range
: In the first cluster that you create in a VPC, the default pod subnet is `172.17.0.0/18`. In the second cluster that you create in that VPC, the default pod subnet is `172.17.64.0/18`. In each subsequent cluster, the pod subnet range is the next available, non-overlapping `/18` subnet.

Size requirements
:   When you specify a custom subnet, consider the size of the cluster that you plan to create and the number of worker nodes that you might add in the future. The subnet must have a CIDR of at least `/23`, which provides enough pod IPs for a maximum of four worker nodes in a cluster. For larger clusters, use `/22` to have enough pod IP addresses for eight worker nodes, `/21` to have enough pod IP addresses for 16 worker nodes, and so on.

:   For VPC clusters, you can specify the subnet size by including it in the `--pod-subnet` option. For example: `--pod-subnet 0.0.0.0/X` where `X` is the required pod subnet size. Then pod subnet is then automatically selected. When allocating the pod subnet automatically, the allocation will start from `172.17.0.0`, the biggest subnet is limited to `13`, and the smallest subnet size is limited to `23`. 

:   There is a global limit for worker nodes. [You can't exceed 500 worker nodes across all clusters in a region.](/docs/containers?topic=containers-limitations#tech_limits)


Range requirements
:   The pod and service subnets can't overlap each other, and the pod subnet can't overlap the VPC subnets for your worker nodes. The subnet that you choose must be within one of the following ranges.
    - `172.17.0.0 - 172.17.255.255`
    - `172.21.0.0 - 172.31.255.255`

    - `192.168.0.0 - 192.168.255.255`


    - `198.18.0.0 - 198.19.255.255`

#### Services
{: #vpc_basics_subnets_services}

Default range
:   All services that are deployed to the cluster are assigned a private IP address in the `172.21.0.0/16` range by default.

Size requirements
:   When you specify a custom subnet, the subnet must be specified in CIDR format with a size of at least `/24`, which allows a maximum of 255 services in the cluster, or larger.

Range requirements
:   The pod and service subnets can't overlap each other. The subnet that you choose must be within one of the following ranges.
    - `172.17.0.0 - 172.17.255.255`
    - `172.21.0.0 - 172.31.255.255`

    - `192.168.0.0 - 192.168.255.255`


    - `198.18.0.0 - 198.19.255.255`

### Public gateways
{: #vpc_basics_pgw}

A public gateway enables a subnet and all worker nodes that are attached to the subnet to establish outbound connections to the internet. If your worker nodes must access a public endpoint outside of the cluster, you can enable a [public gateway](/docs/vpc?topic=vpc-about-networking-for-vpc#public-gateway-for-external-connectivity) on the VPC subnets that worker nodes are deployed to.
{: shortdesc}

If an {{site.data.keyword.cloud_notm}} service does not support private cloud service endpoints, your worker nodes must be connected to a subnet that has a public gateway attached to it. The pods on those worker nodes can securely communicate with the services over the public network through the subnet's public gateway. Note that a public gateway is not required on your subnets to allow inbound network traffic from the internet to `LoadBalancer` services or ALBs.

Within one VPC, you can create only one public gateway per zone, but that public gateway can be attached to multiple subnets within the zone. For more information about public gateways, see the [Networking for VPC documentation](/docs/vpc?topic=vpc-about-networking-for-vpc#public-gateway-for-external-connectivity).

### Virtual private endpoints (VPE)
{: #vpc_basics_vpe}

Worker nodes can communicate with the Kubernetes master through the cluster's [virtual private endpoint (VPE)](/docs/vpc?topic=vpc-about-vpe).
{: shortdesc}

A VPE is a virtual IP address that is bound to an endpoint gateway. One VPE gateway resource is created per cluster in your VPC. One IP address from one subnet in each zone where your cluster has worker nodes is automatically used for the VPE gateway, and the worker nodes in this zone use this IP address to communicate with the Kubernetes master. To view the VPE gateway details for your cluster, open the [Virtual private endpoint gateways for VPC dashboard](https://cloud.ibm.com/infrastructure/network/endpointGateways){: external} and look for the VPE gateway in the format `iks-<cluster_ID>`.

Note that your worker nodes automatically use the VPE that is created by default in your VPC. However, if you enabled the [public cloud service endpoint for your cluster](/docs/containers?topic=containers-plan_vpc_basics#vpc-workeruser-master), worker-to-master traffic is established half over the public endpoint and half over the VPE for protection from potential outages of the public or private network.

Do not delete any IP addresses on your subnets that are used for VPEs.
{: important}

### Network segmentation
{: #vpc_basics_segmentation}

Network segmentation describes the approach to divide a network into multiple sub-networks. Apps that run in one sub-network can't see or access apps in another sub-network. For more information about network segmentation options for VPC subnets, see [this cluster security topic](/docs/containers?topic=containers-security#network_segmentation_vpc).
{: shortdesc}

Subnets provide a channel for connectivity among the worker nodes within the cluster. Additionally, any system that is connected to any of the private subnets in the same VPC can communicate with workers. For example, all subnets in one VPC can communicate through private layer 3 routing with a built-in VPC router.

If you have multiple clusters that must communicate with each other, you can create the clusters in the same VPC. However, if your clusters don't need to communicate, you can achieve better network segmentation by creating the clusters in separate VPCs. You can also create [access control lists (ACLs)](/docs/containers?topic=containers-vpc-acls&interface=ui) for your VPC subnets to mediate traffic on the private network. ACLs consist of inbound and outbound rules that define which ingress and egress is permitted for each VPC subnet.

### VPC networking limitations
{: #vpc_basics_limitations}

When you create VPC subnets for your clusters, keep in mind the following features and limitations.
{: shortdesc}

- The default CIDR size of each VPC subnet is `/24`, which can support up to 253 worker nodes. If you plan to deploy more than 250 worker nodes per zone in one cluster, consider creating a subnet of a larger size.
- After you create a VPC subnet, you can't resize it or change its IP range.
- Multiple clusters in the same VPC can share VPC subnets. However, custom pod and service subnets can't be shared between multiple clusters.
- VPC subnets are bound to a single-campus multizone region and can't span multiple zones or regions.
- After you create a subnet, you can't move it to a different zone, region, or VPC.
- If you have worker nodes that are attached to an existing subnet in a zone, you can't change the subnet for that zone in the cluster.
- The `172.16.0.0/16`, `172.18.0.0/16`, `172.19.0.0/16`, and `172.20.0.0/16` ranges are prohibited.
- Within one VPC, you can create only one public gateway per zone, but that public gateway can be attached to multiple subnets within the zone.
- The [classic access default address prefixes](/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure#classic-access-default-address-prefixes) conflict with the subnets for the {{site.data.keyword.containerlong_notm}} control plane. You must [create the VPC without the automatic default address prefixes, and then create your own address prefixes and subnets within those ranges for your cluster](#classic_access_subnets).




## Creating a VPC subnet and attaching a public gateway
{: #create_vpc_subnet}

Create a VPC subnet for your cluster and optionally attach a public gateway to the subnet.
{: shortdesc}

### Creating a VPC subnet in the console
{: #create_vpc_subnet_ui}
{: ui}

Use the {{site.data.keyword.cloud_notm}} console to create a VPC subnet for your cluster and optionally attach a public gateway to the subnet.
{: shortdesc}

1. From the [VPC subnet dashboard](https://cloud.ibm.com/vpc/network/subnets), click **Create**.
2. Enter a name for your subnet and select the name of the VPC that you created.
3. Select the location and zone where you want to create the subnet.
4. Specify the number of IP addresses to create.
    - VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so [create a VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256. You can't change the number of IPs that a VPC subnet has later.
    - If you enter a specific IP range, don't use the following reserved ranges: `172.16.0.0/16`, `172.18.0.0/16`, `172.19.0.0/16`, and `172.20.0.0/16`.
5. Choose if you want to attach a public network gateway to your subnet. A public network gateway is required when you want your cluster to access public endpoints, such as a public URL of another app, or an {{site.data.keyword.cloud_notm}} service that supports public cloud service endpoints only.
6. Click **Create subnet**.
7. Use the subnet to [create a cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2), [create a new worker pool](/docs/containers?topic=containers-add-workers-vpc#vpc_add_pool), or [add the subnet to an existing worker pool](/docs/containers?topic=containers-add-workers-vpc).>
    Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
    {: important}

### Creating a VPC subnet in the CLI
{: #create_vpc_subnet_cli}
{: cli}

Use the {{site.data.keyword.cloud_notm}} CLI to create a VPC subnet for your cluster and optionally attach a public gateway to the subnet.
{: shortdesc}

Before you begin

1. In your command line, log in to your {{site.data.keyword.cloud_notm}} account and target the {{site.data.keyword.cloud_notm}} region and resource group where you want to create your VPC cluster. For supported regions, see [Creating a VPC in a different region](/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region). The cluster's resource group can differ from the VPC resource group. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated ID, use the `--sso` option to log in.
    ```sh
    ibmcloud login -r <region> [-g <resource_group>] [--sso]
    ```
    {: pre}

2. [Create a VPC](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#create-a-vpc-cli) in the same region where you want to create the cluster.

To create a VPC subnet, follow these steps.

1. Get the ID of the VPC where you want to create the subnet.
    ```sh
    ibmcloud ks vpcs
    ```
    {: pre}

2. Create the subnet. For more information about the options in this command, see the [CLI reference](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#create-a-subnet-cli).
    ```sh
    ibmcloud is subnet-create <subnet_name> <vpc_id> --zone <vpc_zone> --ipv4-address-count <number_of_ip_address>
    ```
    {: pre}

    - VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so [create a VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256. You can't change the number of IPs that a VPC subnet has later.
    - Don't use the following reserved ranges: `172.16.0.0/16`, `172.18.0.0/16`, `172.19.0.0/16`, and `172.20.0.0/16`.

3. Check whether you have a public gateway in the zones where you want to create a cluster. Within one VPC, you can create only one public gateway per zone, but that public gateway can be attached to multiple subnets within the zone.
    ```sh
    ibmcloud is public-gateways
    ```
    {: pre}

    Example output

    ```sh
    ID                                     Name                                       VPC                          Zone         Floating IP                  Created                     Status      Resource group
    26426426-6065-4716-a90b-ac7ed7917c63   test-pgw                                   testvpc(36c8f522-.)          us-south-1   169.xx.xxx.xxx(26466378-.)   2019-09-20T16:27:32-05:00   available   -
    2ba2ba2b-fffa-4b0c-bdca-7970f09f9b8a   pgw-73b62bc0-b53a-11e9-9838-f3f4efa02374   team3(ff537d43-.)            us-south-2   169.xx.xxx.xxx(2ba9a280-.)   2019-08-02T10:30:29-05:00   available   -
    ```
    {: screen}

    - If you already have a public gateway in each zone, note the **ID**s of the public gateways.
    - If you don't have a public gateway in each zone, create a public gateway. Consider naming the public gateway in the format `<cluster>-<zone>-gateway`. In the output, note the public gateway's **ID**.
    
    ```sh
    ibmcloud is public-gateway-create <gateway_name> <VPC_ID> <zone>
    ```
    {: pre}

    Example output

    ```sh
    ID               26466378-6065-4716-a90b-ac7ed7917c63
    Name             mycluster-us-south-1-gateway
    Floating IP      169.xx.xx.xxx(26466378-6065-4716-a90b-ac7ed7917c63)
    Status           pending
    Created          2019-09-20T16:27:32-05:00
    Zone             us-south-1
    VPC              myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
    Resource group   -
    ```
    {: screen}

4. Using the IDs of the public gateway and the subnet, attach the public gateway to the subnet.
    ```sh
    ibmcloud is subnet-update <subnet_ID> --public-gateway-id <gateway_ID>
    ```
    {: pre}

    Example output

    ```sh
    ID                  91e946b4-7094-46d0-9223-5c2dea2e5023
    Name                mysubnet1
    IPv4 CIDR           10.240.xx.xx/24
    Address available   250
    Address total       256
    ACL                 allow-all-network-acl-36c8f522-4f0d-400c-8226-299f0b8198cf(585bc142-5392-45d4-afdd-d9b59ef2d906)
    Gateway             mycluster-us-south-1-gateway(26466378-6065-4716-a90b-ac7ed7917c63)
    Created             2019-08-21T09:43:11-05:00
    Status              available
    Zone                us-south-1
    VPC                 myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
    ```
    {: screen}


5. Use the subnet to [create a cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui), [create a new worker pool](/docs/containers?topic=containers-add-workers-vpc#vpc_add_pool), or [add the subnet to an existing worker pool](/docs/containers?topic=containers-add-workers-vpc#vpc_add_zone).
    Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
    {: important}


## Creating VPC subnets for classic access
{: #classic_access_subnets}

If you enable classic access when you create your VPC, [classic access default address prefixes](/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure#classic-access-default-address-prefixes) automatically determine the IP ranges of any subnets that you create. However, the default IP ranges for classic access VPC subnets conflict with the subnets for the {{site.data.keyword.containerlong_notm}} control plane. Instead, you must create the VPC without the automatic default address prefixes, and create your own address prefixes. Then, whenever you create subnets for your cluster, you create the subnets within the address prefix ranges that you created.
{: shortdesc}

### Creating VPC subnets for classic access in the console
{: #ca_subnet_ui}
{: ui}

1. Create a classic access VPC without default address prefixes.
    1. From the [Virtual Private Clouds dashboard](https://cloud.ibm.com/vpc/provision/vpc), click **Create**.
    2. Enter details for the name, resource group, and any tags.
    3. Select the checkbox for **Enable access to classic resources**, and clear the checkbox for **Create a default prefix for each zone**.
    4. Select the region for the VPC.
    5. Click **Create virtual private cloud**.
2. Create address prefixes in each zone.
    1. Click the name of your VPC to view its details.
    2. Click the **Address prefixes** tab and click **Create**.
    3. For each zone in which you plan to create subnets, create one or more address prefixes. The address prefixes must be within one of the following ranges: `10.0.0.0 - 10.255.255.255`, `172.17.0.0 - 172.17.255.255`, `172.21.0.0 - 172.31.255.255`, `192.168.0.0 - 192.168.255.255`.
3. Create subnets that use your address prefixes.
    1. From the [VPC subnet dashboard](https://cloud.ibm.com/vpc/network/subnets), click **Create**.
    2. Enter a name for your subnet and select the name of your classic access VPC.
    3. Select the location and zone where you want to create the subnet.
    4. Select the address prefix that you created for this zone.
    5. Specify the number of IP addresses to create. VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so [create a VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256. You can't change the number of IPs that a VPC subnet has later.
    6. Choose if you want to attach a public network gateway to your subnet. A public network gateway is required when you want your cluster to access public endpoints, such as a public URL of another app, or an {{site.data.keyword.cloud_notm}} service that supports public cloud service endpoints only.
    7. Click **Create subnet**.
4. Use the subnets to [create a cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2).
     Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
     {: important}

### Creating VPC subnets for classic access from the CLI
{: #ca_subnet_cli}
{: cli}

1. In your command line, log in to your {{site.data.keyword.cloud_notm}} account and target the {{site.data.keyword.cloud_notm}} region and resource group where you want to create your VPC cluster. For supported regions, see [Creating a VPC in a different region](/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region). The cluster's resource group can differ from the VPC resource group. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated ID, use the `--sso` option to log in.
    ```sh
    ibmcloud login -r <region> [-g <resource_group>] [--sso]
    ```
    {: pre}

2. Create a classic access VPC without default address prefixes. In the output, copy the VPC ID.
    ```sh
    ibmcloud is vpc-create <name> --classic-access --address-prefix-management manual
    ```
    {: pre}

3. For each zone in which you plan to create subnets, create one or more address prefixes. The address prefixes must be within one of the following ranges: `10.0.0.0 - 10.255.255.255`, `172.17.0.0 - 172.17.255.255`, `172.21.0.0 - 172.31.255.255`, `192.168.0.0 - 192.168.255.255`.
    ```sh
    ibmcloud is vpc-address-prefix-create <prefix_name> <vpc_id> <zone> <prefix_range>
    ```
    {: pre}

4. Create subnets in each zone that use your address prefixes. For more information about the options in this command, see the [CLI reference](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#create-a-subnet-cli). VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so [create a VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256. You can't change the number of IPs that a VPC subnet has later.
    ```sh
    ibmcloud is subnet-create <subnet_name> <vpc_id> --zone <vpc_zone> --ipv4-address-count <number_of_ip_address> --ipv4-cidr-block <prefix_range>
    ```
    {: pre}

5. Optional: Attach a public network gateway to your subnet. A public network gateway is required when you want your cluster to access public endpoints, such as a public URL of another app, or an {{site.data.keyword.cloud_notm}} service that supports public cloud service endpoints only.
    1. Create a public gateway in each zone. Consider naming the public gateway in the format `<cluster>-<zone>-gateway`. In the output, note the public gateway's **ID**.
        ```sh
        ibmcloud is public-gateway-create <gateway_name> <VPC_ID> <zone>
        ```
        {: pre}

        Example output
        ```sh
        ID               26466378-6065-4716-a90b-ac7ed7917c63
        Name             mycluster-us-south-1-gateway
        Floating IP      169.xx.xx.xxx(26466378-6065-4716-a90b-ac7ed7917c63)
        Status           pending
        Created          2019-09-20T16:27:32-05:00
        Zone             us-south-1
        VPC              myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
        Resource group   -
        ```
        {: screen}

    2. By using the IDs of the public gateway and the subnet, attach the public gateway to the subnet.
        ```sh
        ibmcloud is subnet-update <subnet_ID> --public-gateway-id <gateway_ID>
        ```
        {: pre}

        Example output
        ```sh
        ID                  91e946b4-7094-46d0-9223-5c2dea2e5023
        Name                mysubnet1
        IPv4 CIDR           10.240.xx.xx/24
        Address available   250
        Address total       256
        ACL                 allow-all-network-acl-36c8f522-4f0d-400c-8226-299f0b8198cf(585bc142-5392-45d4-afdd-d9b59ef2d906)
        Gateway             mycluster-us-south-1-gateway(26466378-6065-4716-a90b-ac7ed7917c63)
        Created             2019-08-21T09:43:11-05:00
        Status              available
        Zone                us-south-1
        VPC                 myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
        ```
        {: screen}

6. Use the subnets to [create a cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui).
    Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
    {: important}
    
 

## Restricting public network traffic to a subnet with a public gateway
{: #vpc-restrict-gateway}

Improve the security of your {{site.data.keyword.containerlong}} cluster by allowing fewer worker nodes to have external access through a VPC subnet public gateway.
{: shortdesc}


If pods on your worker nodes need to connect to a public external endpoint, you can attach a public gateway to the subnet that those worker nodes are on. For example, your VPC cluster can automatically connect to other [{{site.data.keyword.cloud_notm}} services that support private cloud service endpoints](/docs/account?topic=account-vrf-service-endpoint), such as {{site.data.keyword.registrylong_notm}}. However, if you need to access {{site.data.keyword.cloud_notm}} services that support only public cloud service endpoints, you can attach a public gateway to the subnet so that your pods can send requests over the public network.


You can isolate this network traffic in your cluster by attaching a public gateway to only one subnet in your cluster. Then, you can use app affinity to deploy app pods that require access to external endpoints to only the subnet with an attached public gateway.

In VPC clusters, a subnet is limited to one zone. When you attach a public gateway to only one subnet, and schedule app pods that require public access to only worker nodes on that subnet, these pods are isolated to one zone in your cluster.
{: note}

1. Target the region of the VPC that your cluster is deployed to.
    ```sh
    ibmcloud target -r <region>
    ```
    {: pre}

2. Check whether you have a public gateway in a zone where you have worker nodes. Within one VPC, you can create only one public gateway per zone, but that public gateway can be attached to multiple subnets within the zone.
    ```sh
    ibmcloud is public-gateways
    ```
    {: pre}

    Example output

    ```sh
    ID                                     Name                                       VPC                          Zone         Floating IP                  Created                     Status      Resource group
    26426426-6065-4716-a90b-ac7ed7917c63   test-pgw                                   testvpc(36c8f522-.)          us-south-1   169.xx.xxx.xxx(26466378-.)   2019-09-20T16:27:32-05:00   available   -
    2ba2ba2b-fffa-4b0c-bdca-7970f09f9b8a   pgw-73b62bc0-b53a-11e9-9838-f3f4efa02374   team3(ff537d43-.)            us-south-2   169.xx.xxx.xxx(2ba9a280-.)   2019-08-02T10:30:29-05:00   available   -
    ```
    {: screen}

    - If you already have a public gateway in a zone where you have workers and in the VPC that your cluster is in, note the gateway's **ID**.
    - If you don't have a public gateway in a zone where you have workers and in the VPC that your cluster is in, create a public gateway. Consider naming the public gateway in the format `<cluster>-<zone>-gateway`. In the output, note the public gateway's **ID**.
        ```sh
        ibmcloud is public-gateway-create <gateway_name> <VPC_ID> <zone>
        ```
        {: pre}

        Example output

        ```sh
        ID               26466378-6065-4716-a90b-ac7ed7917c63
        Name             mycluster-us-south-1-gateway
        Floating IP      169.xx.xx.xxx(26466378-6065-4716-a90b-ac7ed7917c63)
        Status           pending
        Created          2019-09-20T16:27:32-05:00
        Zone             us-south-1
        VPC              myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
        Resource group   -
        ```
        {: screen}

3. List the worker nodes in your cluster. For the zone where you enabled the public gateway, note the **Primary IP** of one worker node.
    ```sh
    ibmcloud ks worker ls -c <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ID                                                   Primary IP     Flavor   State    Status   Zone         Version
    kube-bl25g33d0if1cmfn0p8g-vpctest-default-000005ac   10.240.02.00   c2.2x4   normal   Ready    us-south-2   1.32.8
    kube-bl25g33d0if1cmfn0p8g-vpctest-default-00000623   10.240.01.00   c2.2x4   normal   Ready    us-south-1   1.32.8
    ```
    {: screen}

4. Describe the worker node. In the **Labels output**, note the subnet ID in the label `ibm-cloud.kubernetes.io/subnet-id`, such as `5f5787a4-f560-471b-b6ce-20067ac93439` in the following example.
    ```sh
    kubectl describe node <worker_primary_ip>
    ```
    {: pre}

    Example output

    ```sh
    NAME:               10.240.01.00
    Roles:              <none>
    Labels:             arch=amd64
    beta.kubernetes.io/arch=amd64
    beta.kubernetes.io/instance-type=c2.2x4
    beta.kubernetes.io/os=linux
    failure-domain.beta.kubernetes.io/region=us-south
    failure-domain.beta.kubernetes.io/zone=us-south-1
    ibm-cloud.kubernetes.io/ha-worker=true
    ibm-cloud.kubernetes.io/iaas-provider=gc
    ibm-cloud.kubernetes.io/internal-ip=10.240.0.77
    ibm-cloud.kubernetes.io/machine-type=c2.2x4
    ibm-cloud.kubernetes.io/os=UBUNTU_20_64
    ibm-cloud.kubernetes.io/region=us-south
    ibm-cloud.kubernetes.io/sgx-enabled=false
    ibm-cloud.kubernetes.io/subnet-id=5f5787a4-f560-471b-b6ce-20067ac93439
    ibm-cloud.kubernetes.io/worker-id=kube-bl25g33d0if1cmfn0p8g-vpcprod-default-00001093
    ibm-cloud.kubernetes.io/worker-pool-id=bl25g33d0if1cmfn0p8g-5aa474f
    ibm-cloud.kubernetes.io/worker-pool-name=default
    ibm-cloud.kubernetes.io/worker-version=1.15.3_1517
    ibm-cloud.kubernetes.io/zone=us-south-1
    kubernetes.io/arch=amd64
    kubernetes.io/hostname=10.240.0.77
    kubernetes.io/os=linux
    Annotations:        node.alpha.kubernetes.io/ttl: 0
    ...
    ```
    {: screen}

5. By using the IDs of the public gateway and the subnet, attach the public gateway to the subnet. The worker nodes that are deployed to this subnet in this zone now have access to external endpoints.
    ```sh
    ibmcloud is subnet-update <subnet_ID> --public-gateway-id <gateway_ID>
    ```
    {: pre}

    Example output

    ```sh
    ID                  91e946b4-7094-46d0-9223-5c2dea2e5023
    Name                mysubnet1
    IPv4 CIDR           10.240.xx.xx/24
    Address available   250
    Address total       256
    ACL                 allow-all-network-acl-36c8f522-4f0d-400c-8226-299f0b8198cf(585bc142-5392-45d4-afdd-d9b59ef2d906)
    Gateway             mycluster-us-south-1-gateway(26466378-6065-4716-a90b-ac7ed7917c63)
    Created             2019-08-21T09:43:11-05:00
    Status              available
    Zone                us-south-1
    VPC                 myvpc(36c8f522-4f0d-400c-8226-299f0b8198cf)
    ```
    {: screen}

6. In the deployment file for your app, [add an affinity rule](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} for the subnet ID label that you found in step 4.

    In the **affinity** section of this example YAML, `ibm-cloud.kubernetes.io/subnet-id` is the `key` and `<subnet_ID>` is the `value`.
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: ibm-cloud.kubernetes.io/subnet-id
                    operator: In
                    values:
                    - <subnet_ID>
    ...
    ```
    {: codeblock}

7. Apply the updated deployment configuration file.
    ```sh
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

8. Verify that the app pods deployed to the correct worker nodes.

    1. List the pods in your cluster. In the output, identify a pod for your app. Note the **NODE** private IP address of the worker node that the pod is on.
        ```sh
        kubectl get pods -o wide
        ```
        {: pre}

        In this example output, the app pod `cf-py-d7b7d94db-vp8pq` is on a worker node with the IP address `10.240.01.00`.
        ```sh
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.240.01.00
        ```
        {: screen}

    2. List the worker nodes in your cluster. In the output, look for the worker nodes in the zone where you attached the public gateway. Verify that the worker node with the private IP address that you identified in the previous step is deployed in this zone.

        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Example output
        ```sh
        ID                                                   Primary IP     Flavor   State    Status   Zone         Version
        kube-bl25g33d0if1cmfn0p8g-vpctest-default-000005ac   10.240.02.00   c2.2x4   normal   Ready    us-south-2   1.32.8
        kube-bl25g33d0if1cmfn0p8g-vpctest-default-00000623   10.240.01.00   c2.2x4   normal   Ready    us-south-1   1.32.8
        ```
        {: screen}

9. Optional: If you use [access control lists (ACLs)](/docs/containers?topic=containers-vpc-acls&interface=ui) to control your cluster network traffic, create inbound and outbound rules in this subnet's ACL to allow ingress from and egress to the external public endpoints that your pods must access.
