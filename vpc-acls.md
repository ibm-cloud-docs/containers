---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-24"


keywords: containers, kubernetes, firewall, acl, acls, access control list, rules, security group

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Controlling traffic with ACLs
{: #vpc-acls}

With the introduction of Secure by Default networking, it is no longer recommended to change the default network ACLs. Instead, you can manage networking by using VPC security groups.
{: important}


For more information about Secure by Default, review the following links.
- [Understanding Secure by Default](/docs/containers?topic=containers-vpc-security-group-reference).
- [Managing outbound traffic protection in VPC clusters](/docs/containers?topic=containers-sbd-allow-outbound).

If your cluster was created at version 1.29 and earlier, review the following links.
- [Understanding VPC security groups in version 1.29 and earlier](/docs/containers?topic=containers-vpc-security-group).
- [Enabling secure by default for clusters created at 1.29 and earlier](/docs/containers?topic=containers-vpc-sbd-enable-existing).



## Overview of ACLs
{: #acls-overview}

If you create custom ACLs, only network traffic that is specified in the ACL rules is permitted to and from your VPC subnets. All other traffic that is not specified in the ACLs, such as cluster integrations with third-party services, is blocked for the subnets.
{: important}

Level of application
:   Virtual Private Cloud subnet

Default behavior
:   When you create a VPC, a default ACL is created in the format `allow-all-network-acl-<VPC_ID>` for the VPC. The ACL includes an inbound rule and an outbound rule that allow all traffic to and from your subnets. Any subnet that you create in the VPC is attached to this ACL by default. ACL rules are applied in a particular order. When you allow traffic in one direction by creating an inbound or outbound rule, you must also create a rule for responses in the opposite direction because responses are not automatically permitted.

Use case
:   If you want to specify which traffic is permitted to the worker nodes on your VPC subnets, you can create a custom ACL for each subnet in the VPC. For example, you can create the following set of ACL rules to block most inbound and outbound network traffic of a cluster, while allowing communication that is necessary for the cluster to function.

Required traffic for clusters
:   If you use custom ACLs, you must allow outbound traffic from all subnets to the following endpoints.
:   - [VPC service endpoints](/docs/vpc?topic=vpc-service-endpoints-for-vpc)
:   - [VPC IaaS endpoints](/docs/vpc?topic=vpc-service-endpoints-for-vpc#infrastructure-as-a-service-iaas-endpoints)
:   - [VPC metadata service IPs](https://cloud.ibm.com/apidocs/vpc-metadata#endpoint-url-metadata)

Limitations
:   If you create multiple clusters that use the same subnets in one VPC, you can't use ACLs to control traffic between the clusters because they share the same subnets. You can use [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers) to isolate your clusters on the private network.
