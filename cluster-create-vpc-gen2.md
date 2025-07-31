---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-31"


keywords: kubernetes, clusters, worker nodes, worker pools, vpc-gen2, containers, {{site.data.keyword.containerlong_notm}}

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Creating VPC clusters
{: #cluster-create-vpc-gen2}

[Virtual Private Cloud]{: tag-vpc} 

Use the {{site.data.keyword.cloud_notm}} CLI or the {{site.data.keyword.cloud_notm}} console to create a standard VPC cluster, and customize your cluster to meet the high availability and security requirements of your apps.
{: shortdesc}

## Prerequisites and notes
{: #cluster-create-vpc-prereq}

* If worker nodes must access public endpoints, attach a public gateway to each subnet in your VPC.

* A public network gateway is required when you want your cluster to access public endpoints, such as a public URL of another app or an {{site.data.keyword.cloud_notm}} service that supports public cloud service endpoints only. Make sure to review the [VPC networking basics](/docs/containers?topic=containers-plan_vpc_basics) to understand when a public network gateway is required and how you can set up your cluster to limit public access to one or more subnets only.

* Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. For more information, see [Managing encryption for the worker nodes in your cluster](/docs/containers?topic=containers-encryption).

* Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.



* If your VPC Clusters require access to Classic Infrastructure resources, you must [enable VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui#vrf) and [service endpoints](/docs/account?topic=account-vrf-service-endpoint&interface=ui#service-endpoint) in your account.

* If you want to create a cluster that runs on dedicated hardware, you must first use the CLI to [create a dedicated host pool](/docs/containers?topic=containers-dedicated-hosts#setup-dedicated-host-cli) in your account.





## Creating a VPC cluster in the console
{: #clusters_vpcg2_ui}
{: ui}

Create your VPC Kubernetes cluster by using the {{site.data.keyword.cloud_notm}} console. Follow the console instructions to make the following cluster configurations. To begin creating your cluster, navigate to the [console](https://cloud.ibm.com/containers/cluster-management/clusters){: external} and click **Create cluster**.
{: shortdesc}

Virtual Private Cloud
:   Select the existing **Virtual Private Cloud** (VPC) instance where you want to create you cluster. If you don't have a VPC, you can create one. 

Location
:   Review the **Worker Zones** and **Subnets** for your cluster. The zones are filtered based on the VPC that you selected, and include the VPC subnets that you previously created. Depending on the level of availability you want for your cluster, select one or more zones. By default, your cluster resources are spread across three zones for high availability.  You can [add zones to your cluster](/docs/containers?topic=containers-add-workers-vpc) later.

Version
:    Select your cluster version. By default, clusters are created with the default Kubernetes version, but you can specify a different [supported version](/docs/containers?topic=containers-cs_versions#cs_versions_available). 




Worker Pool
:    The cluster worker pool defines the number and type of worker nodes that run your workload. You can change your worker pool details at anytime.
:    - **Worker nodes per zone**: For high availability, at least 3 worker nodes per zone are recommended.
:    - **Flavor**: The flavor defines the architecture, amount of virtual CPU, memory, GPU, and disk space that is set up in each worker node and made available to the containers. Available bare metal and virtual machines types vary by the zone in which you deploy the cluster. For a list of available flavors, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors). 
     - When you choose a flavor in the console, you can filter available flavors by **Machine type**, **Architecture**, and **Operating System**. Available machine types are `shared` or `dedicated`. Note that the `dedicated` option is only available if you already have a [dedicated host pool](/docs/containers?topic=containers-dedicated-hosts#setup-dedicated-host-cli) in your account. For a list of the available operating systems and architectures by cluster version, see the [available versions](/docs/containers?topic=containers-cs_versions#cs_versions_available).
     
:    - **Encrypt local disk**: By default, [worker nodes feature AES 256-bit disk encryption](/docs/containers?topic=containers-security#workernodes). You can choose to turn off disk encryption when you create the cluster. If you enable encryption, each worker node in the worker pool then is encrypted by using the KMS provider credentials that you manage. Only the `default` worker pool's nodes are encrypted. After you create the cluster, if you create more worker pools, you must enable encryption in each pool separately. Each worker pool in your cluster can use the same KMS instance and root key, the same KMS instance with different root keys, or different instances.
:   - **Secondary Storage**: You can provision a secondary disk to your worker nodes, such as a `900gb.5iops-tier` block storage disk. When you add a secondary disk, that disk is used for the container runtime, while the primary disk is used for the operating system. Secondary disks are useful in scenarios where more container storage is needed, such as running pods with large images. Note that when using secondary storage, pods might not be able to use the full IOPS/bandwidth capabilities of the volumes because of the overlay file systems. Secondary disks are provisioned in your account and you can see them in VPC console. The charges for these disks are separate to the cost of each worker and show as a different line item on your bill. These secondary volumes also count toward the quota usage for the your account. If you plan to use secondary storage on nodes where Persistent Volumes could be attached it is highly recommended to use the 10-iops tiers or higher. This is because the storage bandwidth allocation for the nodes is shared between secondary storage volumes and any attached PVCs. When using 5-iops, tiers this can lead to degraded performance for pulling images or for pods writing to the storage. For more information on bandwidth allocation see [Bandwidth Allocation in Virtual Server Instances](https://www.ibm.com/products/tutorials/bandwidth-allocation-in-virtual-server-instances).{: external}
:   - **GPU**: If you plan to deploy AI, visual, or high-quality graphics workloads to your cluster, make sure you select a GPU worker node flavor.

Additional flavor types, including flavors with NVIDIA V100, A100, H100, and H200 GPUs are available for allowlisted accounts only. To request access to other allowlisted flavors, [request access to the allowlist](/docs/containers?topic=containers-allowlist-request).
{: note}


Worker pool encryption
:    Manage encryption of your worker nodes by enabling a key management service (KMS) provider at the worker pool level. Select your KMS instance and CRN.

Master service endpoint
:    Service endpoints provide communication to the master. You can choose to configure your cluster with a private service endpoint or both a public and a private cloud service endpoint. For more information about what setup is required to run internet-facing apps, or to keep your cluster private, see [Planning your cluster network setup](/docs/containers?topic=containers-plan_vpc_basics#vpc-pgw).





Outbound traffic protection  
:   The default behavior for clusters at version 1.30 and later is to allow only the necessary networking traffic for the cluster to function and disable all other outbound connections. If you have apps or services that require connection to the public Internet, such as GitHub repositories, Docker Hub, , note that you must either disable outbound traffic protection completely (so that all outbound traffic is allowed), or add security group rules to allow only the outbound traffic that you require.



Cluster encryption
:    Enable data encryption with a key management service (KMS) to encrypt secrets and other sensitive information in your cluster. You can also [enable KMS](/docs/containers?topic=containers-encryption-setup) later.

Ingress secrets management
:   [{{site.data.keyword.secrets-manager_full_notm}}](/docs/containers?topic=containers-secrets-mgr) centrally manages Ingress subdomain certificates and other secrets in your cluster. You can choose to register a {{site.data.keyword.secrets-manager_short}} instance to your cluster during the cluster create process. You can also specify a secret group that you can use to control access to the secrets in your cluster. Both of these options can be configured or changed after you have created the cluster.

VPC security groups
:   Provide up to four custom security groups to apply to all worker nodes on the VPC cluster instead of the default VPC security group. The default VPC security group will not be applied. For more information, see [Controlling traffic with VPC security groups](/docs/openshift?topic=openshift-vpc-security-group).


Cluster details
:   You can customize the unique **Cluster name** and any [tags](/docs/account?topic=account-tag) that you want to use to organize and identify your {{site.data.keyword.cloud_notm}} resources, such as the `team` or `billing department`.
:   Choose the **Resource group** to create your cluster in. A cluster can be created in only one resource group, and after the cluster is created, you can't change its resource group. To create clusters in a resource group other than the default, you must have at least the [**Viewer** role](/docs/containers?topic=containers-iam-platform-access-roles) for the resource group.

Observability integrations
:    You can enable additional observability integrations that you want to include on your cluster. Some integrations are automatically enabled if you have an existing platform instance of that integration. In this case, you cannot disable the integration. If you want to use an integration and you have only an existing application instance of that integration, the integration is disabled by default and you must manually enable it.
:    - [Logging]{: tag-dark-teal}: You can use {{site.data.keyword.logs_full_notm}} to manage operating system logs, application logs, and platform logs. If you want to enable this integration later, see [{{site.data.keyword.logs_full_notm}}](/docs/cloud-logs?topic=cloud-logs-about-cl).
:    - [Monitoring]{: tag-magenta} and [Workload Protection]{: tag-blue}: The monitoring service integration allows operational visibility into the performance and health of your applications, services, and platforms. If you disable this integration and want to enable it later, see [Monitoring cluster health](/docs/containers?topic=containers-health-monitor&interface=ui). The Security and Compliance Center Workload Protection integration finds and prioritizes software vulnerabilities, detects and responds to threats, and manages configurations, permissions, and compliance from source to run. For more information, see the Workload Protection [Getting Started](/docs/workload-protection?topic=workload-protection-getting-started) page.
    - Specify the **Configuration type** to use either new or existing instances of Monitoring and Workload Protection. If you use want to use existing instances of both Monitoring and Workload protection, the instances of each integration must be connected. In this case, specify either the Monitoring or Workload Protection instance you want to use; you cannot specify both instances, but both instances are used as long as they are connected. You can connect existing instances from the details page of either the [Monitoring](https://cloud.ibm.com/observability/monitoring){: external} or [Workload Protection](https://cloud.ibm.com/security-compliance){: external} instance. 




## Creating VPC clusters from the CLI
{: #cluster_vpcg2_cli}
{: cli}


* Make sure that you complete the prerequisites to [prepare your account](/docs/containers?topic=containers-clusters) and decide on your cluster setup.
* Install the {{site.data.keyword.cloud_notm}} CLI and the [{{site.data.keyword.containerlong_notm}} plug-in](/docs/containers?topic=containers-cli-install).
* Install the [VPC CLI plug-in](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli).


1. In your command line, log in to your {{site.data.keyword.cloud_notm}} account and target the {{site.data.keyword.cloud_notm}} region and resource group where you want to create your VPC cluster. For supported regions, see [Creating a VPC in a different region](/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region). Enter your {{site.data.keyword.cloud_notm}} credentials when prompted. If you have a federated ID, use the --sso option to log in.
    ```sh
    ibmcloud login -r <region> [-g <resource_group>] [--sso]
    ```
    {: pre}

2. [Create a VPC](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#create-a-vpc-cli) in the same region where you want to create the cluster.
    Do the clusters of worker nodes in your VPC need to send and receive information to and from IBM Cloud classic infrastructure? Follow the steps in [Creating VPC subnets for classic access](/docs/containers?topic=containers-vpc-subnets#ca_subnet_cli) to create a classic-enabled VPC and VPC subnets without the automatic default address prefixes.
    {: important}
    
3. [Create a subnet for your VPC](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#create-a-subnet-cli).
    * If you want to create a multizone cluster, repeat this step to create additional subnets in all the zones that you want to include in your cluster.
    * VPC subnets provide IP addresses for your worker nodes and load balancer services in the cluster, so [create a VPC subnet with enough IP addresses](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets), such as 256. You can't change the number of IPs that a VPC subnet has later.
    * Do not use the following reserved ranges: `172.16.0.0/16`, `172.18.0.0/16`, `172.19.0.0/16`, and `172.20.0.0/16`.
    * If worker nodes must access public endpoints, [attach a public gateway](/docs/vpc?topic=vpc-creating-vpc-resources-with-cli-and-api&interface=cli#attach-public-gateway-cli) to each subnet.
    * **Important**: Do not delete the subnets that you attach to your cluster during cluster creation or when you add worker nodes in a zone. If you delete a VPC subnet that your cluster used, any load balancers that use IP addresses from the subnet might experience issues, and you might be unable to create new load balancers.
    * For more information, see [Overview of VPC networking in {{site.data.keyword.containerlong_notm}}: Subnets](/docs/containers?topic=containers-vpc-subnets#vpc_basics_subnets).

4. Create the cluster in your VPC. You can use the `ibmcloud ks cluster create vpc-gen2` command to create a single zone cluster in your VPC with worker nodes that are connected to one VPC subnet only. If you want to create a multizone cluster, you can use the {{site.data.keyword.cloud_notm}} console, or [add more zones](/docs/containers?topic=containers-add-workers-vpc) to your cluster after the cluster is created. The cluster takes a few minutes to provision.
    ```sh
    ibmcloud ks cluster create vpc-gen2 --name <cluster_name> --zone <vpc_zone> --vpc-id <vpc_ID> --subnet-id <vpc_subnet_ID> --flavor <worker_flavor> [--version <major.minor.patch>][--workers <number_workers_per_zone>] [--sm-group GROUP] [--sm-instance INSTANCE]  [--pod-subnet] [--service-subnet] [--disable-public-service-endpoint] [[--kms-account-id <kms_account_ID>] --kms-instance <KMS_instance_ID> --crk <root_key_ID>] [--secondary-storage STORAGE] [--disable-outbound-traffic-protection] [--operating-system SYSTEM]

    ```
    {: pre}

    `--name <cluster_name>`
    :   Specify a name for your cluster. The name must start with a letter, can contain letters, numbers, periods (.), and hyphen (-), and must be 35 characters or fewer. Use a name that is unique across regions. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.

    `--zone <zone>`
    :   Specify the {{site.data.keyword.cloud_notm}} zone where you want to create your cluster. Make sure that you use a zone that matches the metro city location that you selected when you created your VPC and that you have an existing VPC subnet for that zone. For example, if you created your VPC in the Dallas metro city, your zone must be set to `us-south-1`, `us-south-2`, or `us-south-3`. To list available VPC cluster zones, run `ibmcloud ks zone ls --provider vpc-gen2`. Note that when you select a zone outside of your country, you might require legal authorization before data can be physically stored in a foreign country.

    `--vpc-id <vpc_ID>`
    :   Enter the ID of the VPC that you created earlier. To retrieve the ID of your VPC, run `ibmcloud ks vpcs`. 

    `--subnet-id <subnet_ID>`
    :   Enter the ID of the VPC subnet that you created earlier. When you create a VPC cluster from the CLI, you can initially create your cluster in one zone with one subnet only. To create a multizone cluster, [add more zones with the subnets](/docs/containers?topic=containers-add-workers-vpc) that you created earlier to your cluster after the cluster is created. To list the IDs of your subnets in all resource groups, run ` ibmcloud ks subnets --provider vpc-gen2 --vpc-id &lt,VPC_ID> --zone <subnet_zone> `.  

    `--flavor <worker_flavor>`
    :   Enter the worker node flavor that you want to use. The flavor determines the amount of virtual CPU, memory, and disk space that is set up in each worker node and made available to your apps. VPC worker nodes can be created as virtual machines on shared infrastructure only. Bare metal or software-defined storage machines are not supported. To view available flavors, first list available VPC zones with `ibmcloud ks zone ls --provider vpc-gen2`, and then use the zone to list supported flavors by running `ibmcloud ks flavors --zone <VPC_zone> --provider vpc-gen2`. After you create your cluster, you can add different flavors by adding a worker node or worker pool to the cluster.

    `--version <major.minor.patch>`
    :   The Kubernetes version for the cluster master node. To see available versions, run `ibmcloud ks versions`.
    
    `--workers <number>`
    :   Specify the number of worker nodes to include in the cluster. If you don't specify this option, a cluster with the minimum value of 1 is created.

    `--operating-system UBUNTU_20_64|UBUNTU_24_64`
:   Optional. The operating system of the worker nodes in your cluster. For a list of available operating systems by cluster version, see the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). If no option is specified, the default operating system that corresponds to the cluster version is used.


   `--cluster-security-group <group_ID>`
    :   Optional. Specify one or more security group IDs to apply to all workers on the cluster. For OpenShift version 4.15 and Kubernetes version 1.30 and later, these security groups are applied in addition to the IBM-managed `kube-clusterID` security group. For earlier cluster versions, specify the `--cluster-security-group cluster` option to apply the `kube-clusterID` security group. If no value is specified, a default set of security groups including `kube-clusterID` are applied. For more information, see [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group-manage).
    
    The security groups applied to a cluster cannot be changed once the cluster is created. You can [change the rules of the security groups](/docs/containers?topic=containers-vpc-security-group-manage) that are applied to the cluster, but you cannot add or remove security groups at the cluster level. If you apply the incorrect security groups at cluster create time, you must delete the cluster and create a new one. See [Adding VPC security groups to clusters and worker pools during create time](/docs/containers?topic=containers-vpc-security-group-manage) for more details before adding security groups to your cluster. 
    {: important}

    `--sm-group GROUP`
    :    Optional. The secret group ID of the {{site.data.keyword.secrets-manager_short}} instance where your secrets are persisted. To get a secret group ID, see the [{{site.data.keyword.secrets-manager_short}} CLI reference](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-secret-groups-cli). Use this option to specify a [secret group](/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-secret-groups-cli) that controls who on your team has access to cluster secrets. 

    `--sm-instance INSTANCE`
    :    Optional. The CRN of the {{site.data.keyword.secrets-manager_short}} instance. To get the CRN of an instance, run `ibmcloud ks ingress instance ls --cluster CLUSTER`. Include this option if you want to register a {{site.data.keyword.secrets-manager_short}} instance to the cluster.



    `--pod-subnet`
    :   In the first cluster that you create in a VPC, the default pod subnet is `172.17.0.0/18`. 
    :   In the second cluster that you create in that VPC, the default pod subnet is `172.17.64.0/18`. In each subsequent cluster, the pod subnet range is the next available, non-overlapping `/18` subnet. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.BluDirectLink}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your pods.
    :   You can specify the subnet size by including it in the `--pod-subnet` option. For example: `--pod-subnet 0.0.0.0/X` where `X` is the required pod subnet size. Then pod subnet is then automatically selected. When allocating the pod subnet automatically, the allocation will start from `172.17.0.0`, the biggest subnet is limited to `13`, and the smallest subnet size is limited to `23`. 
    :   When you choose a subnet size, consider the size of the cluster that you plan to create and the number of worker nodes that you might add in the future. The subnet must have a CIDR of at least `/23`, which provides enough pod IP addresses for a maximum of four worker nodes in a cluster. For larger clusters, use `/22` to have enough pod IP addresses for eight worker nodes, `/21` to have enough pod IP addresses for 16 worker nodes, and so on. Note that the pod and service subnets can't overlap. If you use custom-range subnets for your worker nodes, [you must ensure that your worker node subnets don't overlap with your cluster's pod subnet](/docs/containers?topic=containers-vpc-subnets#vpc-ip-range). The subnet that you choose must be within one of the following ranges: `172.17.0.0 - 172.17.255.255`, `172.21.0.0 - 172.31.255.255`, `192.168.0.0 - 192.168.255.255`, `198.18.0.0 - 198.19.255.255`.

    `--service-subnet`
    :   All services that are deployed to the cluster are assigned a private IP address in the 172.21.0.0/16 range by default. If you plan to connect your cluster to on-premises networks through {{site.data.keyword.dl_full_notm}} or a VPN service, you can avoid subnet conflicts by specifying a custom subnet CIDR that provides the private IP addresses for your services.
    The subnet must be specified in CIDR format with a size of at least `/24`, which allows a maximum of 255 services in the cluster, or larger. The subnet that you choose must be within one of the following ranges: `172.17.0.0 - 172.17.255.255`, `172.21.0.0 - 172.31.255.255`, `192.168.0.0 - 192.168.255.255`, `198.18.0.0 - 198.19.255.255`. Note that the pod and service subnets can't overlap.

    `--disable-public-service-endpoint`
    :   Include this option in your command to create your VPC cluster with a private cloud service endpoint only. If you don't include this option, your cluster is set up with a public and a private cloud service endpoint. The service endpoint determines how your Kubernetes master and the worker nodes communicate, how your cluster access other {{site.data.keyword.cloud_notm}} services and apps outside the cluster, and how your users connect to your cluster. For more information, see [Planning your cluster network setup](/docs/containers?topic=containers-plan_vpc_basics).
        

    `--kms-account-id <KMS_acount_ID>`
    :   Optional: Must be included if the `--kms-instance-id` and `--crk` options are provided and the KMS instance resides in an account different from the cluster's account, otherwise it can be omitted. Setting up encryption by using a KMS from a different account is available for allowlisted accounts only. To get added to the allowlist, [open a case](https://cloud.ibm.com/unifiedsupport/cases/form){: external} with support.


    `--kms-instance <KMS_instance_ID>`
    :   Optional: Include the ID of a key management service (KMS) instance to use to encrypt the local disk on the worker nodes in the `default` worker pool. To list available KMS instances, run `ibmcloud ks kms instance ls`. If you include this option, you must also include the `--crk` option. Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. See [Managing encryption](/docs/containers?topic=containers-encryption) for the worker nodes in your cluster.

    `--crk <root_key>`
    :   Optional: Include the ID of the root key in the KMS instance to use to encrypt the local disk on the worker nodes in the `default` worker pool. To list available root keys, run `ibmcloud ks kms crk ls --instance-id`. If you include this option, you must also include the `--kms-instance` option. Before you can use KMS encryption, you must create a KMS instance and set up the required service authorization in IAM. See [Managing encryption](/docs/containers?topic=containers-encryption) for the worker nodes in your cluster.

    `--secondary-storage STORAGE`
    :    Optional. The storage option for the flavor. For example, `900gb.5iops-tier`. When you add a secondary disk, that disk is used for the container runtime, while the primary disk is used for the operating system. To view the storage options for a flavor, run the `ibmcloud ks flavor get --flavor FLAVOR --zone ZONE --provider vpc-gen2` command. To view a list of VPC worker node flavors, see [VPC flavors](/docs/containers?topic=containers-vpc-flavors&interface=ui).

    `--disable-outbound-traffic-protection`  
    :   Optional.
    
5. Verify that the creation of the cluster was requested. It can take a few minutes for the worker node machines to be ordered, and for the cluster to be set up and provisioned in your account.
    ```sh
    ibmcloud ks cluster ls
    ```
    {: pre}

    When the provisioning of your Kubernetes master is completed, the state of your cluster changes to **normal**. After the Kubernetes master is ready, your worker nodes are set up.
    ```sh
    NAME         ID                                   State      Created          Workers    Zone      Version     Resource Group Name   Provider
    mycluster    aaf97a8843a29941b49a598f516da72101   normal   20170201162433   3          Dallas     1.32.7_1526      Default               vpc-gen2
    ```
    {: screen}

6. Check the status of the worker nodes.
    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    When the worker nodes are ready, the worker node **State** changes to `normal` and the **Status** changes to `Ready`. When the node **Status** changes to `Ready`, you can access the cluster. Note that even if the cluster is ready, some parts of the cluster that are used by other services, such as Ingress secrets or registry image pull secrets, might still be in process.
    ```sh
    ID                                                     Public IP        Private IP     Flavor              State    Status   Zone    Version
    kube-blrs3b1d0p0p2f7haq0g-mycluster-default-000001f7   169.xx.xxx.xxx  10.xxx.xx.xxx   b3c.4x16.encrypted  normal   Ready    dal10   1.32.7_1526
    ```
    {: screen}

    Every worker node is assigned a unique worker node ID and domain name that must not be changed manually after the cluster is created. If you change the ID or domain name, the Kubernetes master cannot manage your cluster.
    {: important}


## Example commands to create VPC clusters
{: #cluster_create_vpc}
{: cli}

Flavors with instance storage are available for allowlisted accounts. To get added to the allowlist, [open a case](https://cloud.ibm.com/unifiedsupport/cases/form){: external} with support.
{: note}



Example command to create a VPC cluster with 3 worker nodes in `us-east-1`.

```sh
ibmcloud ks cluster create vpc-gen2 --name my_cluster --version 1.32_openshift --zone us-east-1 --vpc-id VPC-ID --subnet-id VPC-SUBNET-ID --flavor bx2.4x16 --workers 3
```
{: pre}

Example command to create a VPC cluster with 3 worker nodes in `us-east-1` with a customer pod subnet and size.

```sh
ibmcloud ks cluster create vpc-gen2 --name my_cluster --version 1.32_openshift --zone us-east-1 --vpc-id VPC-ID --subnet-id VPC-SUBNET-ID --flavor bx2.4x16 --workers 3  -pod-subnet 0.0.0.0/15
```
{: pre}





Example command to add worker nodes by [adding a zone](/docs/containers?topic=containers-add-workers-vpc#vpc_add_zone) to a multizone VPC cluster.

```sh
ibmcloud ks zone add vpc-gen2 --zone ZONE --cluster <cluster_name_or_ID> --worker-pool WORKER-POOL --subnet-id SUBNET-ID
```
{: pre}



## Creating a VPC cluster with Terraform
{: #cluster_vpcg2_tf}
{: terraform}


Terraform on {{site.data.keyword.cloud_notm}} enables predictable and consistent provisioning of {{site.data.keyword.cloud_notm}} platform infrastructure and resources, including VPC clusters. To create a VPC cluster with Terraform, you first create a Terraform configuration file that declares the type of cluster resource you want to create. Then, you apply the Terraform configuration file. For more information on Terraform, see [About Terraform on {{site.data.keyword.cloud_notm}}](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-about).

**Before you begin:**
* [Install the Terraform CLI and the {{site.data.keyword.cloud_notm}} Provider plug-in](/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-setup_cli#tf_installation).
* Make sure you have an {{site.data.keyword.cloud_notm}} [API key](/docs/account?topic=account-userapikey&interface=ui#create_user_key). 


1. Create a Terraform provider file. Save the file in your Terraform directory. For more information, see the [Terraform IBM Cloud Provider documentation](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs){: external}. 

    Example Terraform provider file. 

    ```sh
    terraform {
    required_providers {
        ibm = {
        source = "IBM-Cloud/ibm"
        version = "1.53.0"
        }
    }
    }

    provider "ibm" {
    region = "us-south"
    ibmcloud_api_key = "<api-key>"
    }
    ```
    {: pre}

2. Create a Terraform configuration file for a VPC cluster. Save the file in your Terraform directory. For more information and cluster configuration options, see the [Terraform `ibm_container_cluster`](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs){: external} documentation. 

    Example Terraform configuration file. 
    ```sh
    resource "ibm_container_vpc_cluster" "cluster" {
    name              = "tf-vpc"
    vpc_id            = "<vpc_id>"
    flavor            = "bx2.16x64"
    worker_count      = "3"
    operating_system  = "UBUNTU_20_64"
    kube_version      = "1.28.2"
    resource_group_id = "<resource_group_id>"
    zones {
        subnet_id = "<subnet_id>"
        name      = "us-south-1"
        }
    }
    ```
    {: pre}

    `name`
    :   Required. The name of the cluster.

    `vpc_id`
    :   Required. The ID of the VPC that you want to use for your cluster. To list available VPCs, run `ibmcloud is vpcs`.

    `flavor`
    :   Required. The worker node flavor. The flavor determines the amount of memory, CPU, and disk space that is available to your worker nodes. For a list of available worker node flavors, run `ibmcloud ks flavors --zone <zone> --provider classic`, or see [Classic flavors](/docs/containers?topic=containers-classic-flavors). 

    `worker_count`
    :   The number of worker nodes that you want to add to the default worker pool. 
    
    `operating_system`
    :   The operating system of the worker nodes in the worker pool. For a list of supported operating systems by cluster version, see [Kubernetes version information](/docs/containers?topic=containers-cs_versions). 

    `kube_version`
    :   The Kubernetes version of your cluster. By default, clusters are created with the default Kubernetes version, but you can specify a different [supported version](/docs/containers?topic=containers-cs_versions#cs_versions_available). 
    
    `resource_group_id`
    :   The ID of the resource group. To see available resource groups, run `ibmcloud resource groups`. If no value is provided, the default resource group is used.

    `zones`
    :   A nested block that describes the zones of the VPC cluster's default worker pool.
    :   - `subnet_id`: Required. The ID of the VPC subnet that you want to use for your worker nodes. To find existing subnets, run `ibmcloud ks subnets --provider classic --zone <zone>`.
    :   - `name`: Required. The zone name for the default worker pool. To see available zones, run `ibmcloud ks zones --provider vpc-gen2`.



3. In the CLI, navigate to your Terraform directory.
    ```sh
    cd <terraform_directory>
    ```
    {: pre}

4. Run the commands to initialize and plan your Terraform actions. Review the plan output to make sure the correct actions are performed. 

    ```sh
    terraform init
    ```
    {: pre}

    ```sh
    terraform plan
    ```
    {: pre}

5. Apply the Terraform files to create the cluster. Then, navigate to the IBM Cloud console to check that the cluster is provisioning.
    ```sh
    terraform apply
    ```
    {: pre}
    
    
    
## Next steps for VPC clusters
{: #cluster-create-vpc-next-steps}

* [Add worker nodes](/docs/containers?topic=containers-add-workers-vpc&interface=cli).{: cli}

* Expose your apps with [public networking services](/docs/containers?topic=containers-cs_network_planning#public_access) or [private networking services](/docs/containers?topic=containers-cs_network_planning#private_access). If you have multiple public clusters with exposed apps, consider connecting them with a [global load balancer](/docs/containers?topic=containers-strategy) for high availability. 
* Connect your cluster with services in private networks outside of your {{site.data.keyword.cloud_notm}} account or with resources in other VPCs by [setting up the {{site.data.keyword.vpc_short}} VPN](/docs/containers?topic=containers-vpc-vpnaas).
* [Add rules to the security group for your worker nodes](/docs/containers?topic=containers-vpc-security-group-manage) to control ingress and egress traffic to your VPC subnets.
