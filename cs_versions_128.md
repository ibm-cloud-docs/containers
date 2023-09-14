---

copyright: 
  years: 2023, 2023
lastupdated: "2023-09-14"

keywords: kubernetes, containers, 128, version 128, 128 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.28 version information and update actions
{: #cs_versions_128}



Version 1.28 is not yet available, but you can review information about expected changes included in the update.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}




## Networking changes for VPC clusters
{: #networking_128}

In version 1.27 and earlier, VPC clusters pull images from the IBM Cloud Container Registry through a private cloud service endpoint for the Container Registry. For version 1.28 and later, this network path is updated so that images are pulled through a VPE gateway instead of a private service endpoint. This change affects all clusters in a VPC; when you create or update a single cluster in a VPC to version 1.28, all clusters in that VPC, regardless of their version, have their network path updated. Depending on the setup of your security groups, network ACLs, and network policies, you may need to make changes to ensure that your workers continue to successfully pull container images after updating to version 1.28. 
{: shortdesc} 

With the network path updates in version 1.28, creating or updating a VPC cluster to run at version 1.28 adds a new VPE gateway to your VPC. This VPE gateway is specifically used for pulling images from the IBM Cloud Container Registry and is assigned one IP address for each zone in the VPC that has at least one cluster worker. DNS entries are added to the entire VPC that resolve all `icr.io` domain names to the new VPE gateway IP addresses. Depending on how you have configured your network security components, you may need to take action to ensure that connections to the new VPE are allowed. 


### What do I need to do?
{: #networking_steps}

The steps you need to take to ensure that your VPC cluster worker nodes continue pulling images from the Container Registry depend on your network security setup. 
{: shortdesc}

- If you use the default network rules for all security groups, network ACLs, and network policies, you do not need to take any action. 
- If you have a customized network security setup that blocks certain TCP connections within the VPC, you must take additional actions before updating to or creating a new cluster at version 1.28. Make the adjustments in the following sections to ensure that connections to the new VPE Gateway for Registry are allowed.

Regardless of whether or not you need to take additional steps, if you keep other clusters in the VPC that do not run version 1.28 you must run a cluster master refresh on those clusters. This ensures that the correct updates are applied to the non-1.28 clusters so that traffic to the new VPE is allowed. 
{: important}

### I have custom security groups. What do I change?
{: #networking_steps_sg}

The necessary allow rules are automatically added to the IBM-managed `kube-<cluster_ID>` cluster security group when you update to or create a cluster at version 1.28. However, if you created a VPC cluster that does **NOT** use the `kube-<cluster_ID>` cluster security group rules, you must make sure that the following security group rules are implemented to allow traffice to the VPE gateway for registry. If the rules are not already implemented in your custom setup, [add them](/docs/containers?topic=containers-vpc-security-group&interface=cli#security_groups_cli). Each of these rules must be created for each zone in the VPC and must specify the entire VPC address prefix range for the zone as the destination CIDR. To find the VPC address prefix range for each zone in the VPC, run `ibmcloud is vpc-address-prefixes <vpc_name_or_id>`.

Add the following rules to your custom security group.

| Rule type | Protocol | Destination IP or CIDR | Destination Port |
|---|---|---|---|---|
| Outbound | TCP | Entire VPC address prefix range | 443 |
| Outbound | TCP | Entire VPC address prefix range | 4443 |
{: caption="Outbound security group rules to add for version 1.28" caption-side="bottom"}

To make these rules more restrictive, you can set the destination to the security group used by the VPE Gateway or you can specify the exact VPE Gateway reserved IP address. Note that these IP addresses can change if all cluster workers in a VPC are removed. 

### I have custom ACLs. What do I change?
{: #networking_steps_acl}

If VPC networks ACLs that apply to your cluster workers have been customized to only allow certain egress and ingress traffic, make sure that the following ACL rules, or equivalent rules, are implemented to allow connections to and from the VPE Gateway for Registry. If the rules are not already implemented, [add them](/docs/containers?topic=containers-vpc-acls&interface=ui). Each of these rules must be created for each zone in the VPC and must specify the entire VPC address prefix range for the zone as the source (for outbound rules) or destination (for inbound rules) CIDR. To find the VPC address prefix range for each zone in the VPC, run `ibmcloud is vpc-address-prefixes <vpc_name_or_id>`. The priority for each rule should be higher than any rule that would otherwise deny this traffic, such as a rule that denies all traffic.

Add the following rules to your custom ACLs.

| Rule type | Protocol | Source IP or CIDR | Source Port | Destination IP or CIDR | Destination Port  |
|---|---|---|---|---|---|---|
| Outbound/Allow | TCP | Entire VPC address prefix range | Any | Entire VPC address prefix range | 443 |
| Outbound/Allow | TCP | Entire VPC address prefix range | Any | Entire VPC address prefix range | 4443 |
| Inbound/Allow | TCP | Entire VPC address prefix range | 443 | Entire VPC address prefix range | Any |
| Inbound/Allow | TCP | Entire VPC address prefix range | 4443 | Entire VPC address prefix range | Any |
{: caption="Outbound and inbound ACL rules to add for version 1.28" caption-side="bottom"}

### I have custom network policies. What do I change?
{: #networking_steps_policy}

If you use Calico policies to restrict outbound connections from cluster workers, you must add the following policy rule to allow connections to the VPE Gateway for Registry. This policy must be created for each zone in the VPC and must specify the entire VPC address prefix range for the zone as the destination CIDR. To find the VPC address prefix range for each zone in the VPC, run `ibmcloud is vpc-address-prefixes <vpc_name_or_id>`.

```yaml
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: allow-vpe-gateway-registry
spec:
  egress:
  - action: Allow
    destination:
      nets:
      - <entire-vpc-address-prefix-range> # example: 10.245.0.0/16
      ports:
      - 443
      - 4443
    protocol: TCP
    source: {}
  order: 500
  selector: ibm.role == 'worker_private'
  types:
  - Egress
```

