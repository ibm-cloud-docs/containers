---

copyright: 
  years: 2014, 2023
lastupdated: "2023-06-26"

keywords: kubernetes, clusters, worker nodes, worker pools

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Preparing to create clusters
{: #clusters}


Create a cluster in {{site.data.keyword.containerlong}}.
{: shortdesc}

After [getting started](/docs/containers?topic=containers-getting-started), you might want to create a cluster that is customized to your use case and different public and private cloud environments. Consider the following steps to create the correct cluster each time.

1. [Prepare your account to create clusters](/docs/containers?topic=containers-clusters#cluster_prepare). This step includes creating a billable account, setting up an API key with infrastructure permissions, making sure that you have Administrator access in {{site.data.keyword.cloud_notm}} IAM, planning resource groups, and setting up account networking.
2. [Decide on your cluster setup](/docs/containers?topic=containers-clusters#prepare_cluster_level). This step includes planning cluster network and HA setup, estimating costs, and if applicable, allowing network traffic through a firewall.
3. Create your [VPC Gen2](/docs/containers?topic=containers-cluster-create-vpc-gen2) or [classic](/docs/containers?topic=containers-cluster-create-classic) cluster by following the steps in the {{site.data.keyword.cloud_notm}} console or CLI.


## Preparing to create clusters at the account level
{: #cluster_prepare}

Prepare your {{site.data.keyword.cloud_notm}} account for {{site.data.keyword.containerlong_notm}}. After the account administrator makes these preparations, you might not need to change them each time that you create a cluster. However, each time that you create a cluster, you still want to verify that the current account-level state is what you need it to be.
{: shortdesc}

1. [Create or upgrade your account to a billable account ({{site.data.keyword.cloud_notm}} Pay-As-You-Go or Subscription)](https://cloud.ibm.com/registration).

2. [Set up an API key for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-access-creds) in the region and resource groups where you want to create clusters. Assign the API key with the [required service and infrastructure permissions to create clusters](/docs/containers?topic=containers-access_reference#cluster_create_permissions).
    Are you the account owner? You already have the necessary permissions! When you create a cluster, the API key for that region and resource group is set with your credentials.
    {: tip}

3. Verify that you as a user (not just the API key) have the required permissions to create clusters.
    1. From the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external} menu bar, click **Manage > Access (IAM)**.
    2. Click the **Users** page, and then from the table, select yourself.
    3. From the **Access policies** tab, confirm that you [have the required permissions to create clusters](/docs/containers?topic=containers-access_reference#cluster_create_permissions). Make sure that your account administrator does not assign you the **Administrator** platform access role at the same time as scoping the access policy to a namespace.

4. If your account uses multiple resource groups, figure out your account's strategy for [managing resource groups](/docs/containers?topic=containers-access-overview#resource_groups).
    * The cluster is created in the resource group that you target when you log in to {{site.data.keyword.cloud_notm}}. If you don't target a resource group, the default resource group is automatically targeted.
    * If you want to create a cluster in a different resource group than the default, you need at least the **Viewer** role for the resource group. If you don't have any role for the resource group, your cluster is created in the default resource group.
    * You can't change a cluster's resource group.
    * If you need to use the `ibmcloud ks cluster service bind` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_service_bind) to [integrate with an {{site.data.keyword.cloud_notm}} service](/docs/containers?topic=containers-service-binding#bind-services), that service must be in the same resource group as the cluster. Services that don't use resource groups like {{site.data.keyword.registrylong_notm}} or that don't need service binding like {{site.data.keyword.la_full_notm}} work even if the cluster is in a different resource group.
    * Consider giving clusters unique names across resource groups and regions in your account to avoid naming conflicts. You can't rename a cluster.

5. **Classic clusters only**: Consider [creating a reservation](/docs/containers?topic=containers-reservations) to lock in a discount over 1 or 3 year terms for your worker nodes. After you create the cluster, add worker pools that use the reserved instances. Typical savings range between 30-50% compared to regular worker node costs.

6. **Standard clusters**: Set up your IBM Cloud infrastructure networking to allow worker-to-master and user-to-master communication. Your cluster network setup varies with the infrastructure provider that you choose (classic or VPC). For more information, see [Planning your cluster network setup](/docs/containers?topic=containers-plan_clusters).
    * **VPC clusters only**: Your VPC clusters are created with a public and a private cloud service endpoint by default. **Optional**: If you want your VPC clusters to communicate with classic clusters over the private network interface, you can choose to set up classic infrastructure access from the VPC that your cluster is in. Note that you can set up classic infrastructure access for only one VPC per region and [Virtual Routing and Forwarding (VRF)](/docs/account?topic=account-vrf-service-endpoint#vrf) is required in your {{site.data.keyword.cloud_notm}} account. For more information, see [Setting up access to your Classic Infrastructure from VPC](/docs/vpc?topic=vpc-setting-up-access-to-classic-infrastructure).

    * **Classic clusters only, VRF and service endpoint enabled accounts**: You must set up your account to use VRF and service endpoints to support scenarios such as running internet-facing workloads and extending your on-premises data center. After you set up the account, your VPC and classic clusters are created with a public and a private cloud service endpoint by default.
        1. Enable [VRF](/docs/account?topic=account-vrf-service-endpoint#vrf) in your IBM Cloud infrastructure account. To check whether a VRF is already enabled, use the `ibmcloud account show` command.
        2. [Enable your {{site.data.keyword.cloud_notm}} account to use service endpoints](/docs/account?topic=account-vrf-service-endpoint#service-endpoint).

    * **Classic clusters only, Non-VRF and non-service endpoint accounts**: If you don't set up your account to use VRF and service endpoints, you can create only classic clusters that use VLAN spanning to communicate with each other on the public and private network.
        * To use the public cloud service endpoint only (run internet-facing workloads), enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning) for your IBM Cloud infrastructure account so that your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-access-creds#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
        * To use a gateway appliance (extend your on-premises data center), enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning) for your IBM Cloud infrastructure account so that your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-access-creds#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).
            1. Configure a gateway appliance to connect your cluster to the on-premises network. For example, you might choose to set up a [Virtual Router Appliance](/docs/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) or a [Fortigate Security Appliance](/docs/vmwaresolutions/services?topic=vmwaresolutions-fsa_considerations) to act as your firewall to allow required network traffic and to block unwanted network traffic.
            2. [Open up the required private IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) for each region so that the master and the worker nodes can communicate and for the {{site.data.keyword.cloud_notm}} services that you plan to use.






## Deciding on your cluster setup
{: #prepare_cluster_level}
{: help}
{: support}

After you set up your account to create clusters, decide on the setup for your cluster. You must make these decisions every time that you create a cluster. Review the following decision tree image for more information, such as comparisons of Kubernetes and {{site.data.keyword.redhat_openshift_notm}}, and VPC and classic infrastructure.
{: shortdesc}



## Next steps
{: #next_steps}

When the cluster is up and running, you can check out the following cluster administration tasks:
- If you created the cluster in a multizone capable zone, [spread worker nodes by adding a zone to your cluster](/docs/containers?topic=containers-add_workers).
- [Deploy an app in your cluster.](/docs/containers?topic=containers-deploy_app#app_cli)
- [Set up your own private registry in {{site.data.keyword.cloud_notm}} to store and share Docker images with other users.](/docs/Registry?topic=Registry-getting-started)
- [Set up the cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) to automatically add or remove worker nodes from your worker pools based on your workload resource requests.
- Control who can create pods in your cluster with [pod security policies](/docs/containers?topic=containers-psp).
- Enable the [Istio](/docs/containers?topic=containers-istio) managed add-on to extend your cluster capabilities.

Then, you can check out the following network configuration steps for your cluster setup:
* Classic clusters:
    * Isolate networking workloads to edge worker nodes [in classic clusters without a gateway](/docs/containers?topic=containers-edge).
    * Expose your apps with [public networking services](/docs/containers?topic=containers-cs_network_planning#public_access) or [private networking services](/docs/containers?topic=containers-cs_network_planning#private_access).
    * Connect your cluster with services in private networks outside of your {{site.data.keyword.cloud_notm}} account by setting up [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl) or the [strongSwan IPSec VPN service](/docs/containers?topic=containers-vpn).
    * Create Calico host network policies to isolate your cluster on the [public network](/docs/containers?topic=containers-network_policies#isolate_workers_public) and on the [private network](/docs/containers?topic=containers-network_policies#isolate_workers).
    * If you use a gateway appliance, such as a Virtual Router Appliance (VRA), [open up the required ports and IP addresses](/docs/containers?topic=containers-firewall#firewall_inbound) in the public firewall to permit inbound traffic to networking services. If you also have a firewall on the private network, [allow communication between worker nodes and let your cluster access infrastructure resources over the private network](/docs/containers?topic=containers-firewall#firewall_private).
* VPC clusters:
    * Expose your apps with [public networking services](/docs/containers?topic=containers-cs_network_planning#public_access) or [private networking services](/docs/containers?topic=containers-cs_network_planning#private_access).
    * Connect your cluster with services in private networks outside of your {{site.data.keyword.cloud_notm}} account or with resources in other VPCs by [setting up the {{site.data.keyword.vpc_short}} VPN](/docs/containers?topic=containers-vpc-vpnaas).
    * [Add rules to the security group for your worker nodes](/docs/containers?topic=containers-vpc-network-policy) to control ingress and egress traffic to your VPC subnets.

