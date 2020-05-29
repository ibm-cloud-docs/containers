---

copyright:
  years: 2014, 2020
lastupdated: "2020-05-29"

keywords: kubernetes, iks, firewall, acl, acls, access control list, rules, security group

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


# VPC: Controlling traffic with VPC ACLs and network policies
{: #vpc-network-policy}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> This ACL information is specific to VPC clusters. For network policy information for classic clusters, see [Controlling traffic with network policies](/docs/containers?topic=containers-network_policies).
{: note}

<img src="images/icon-vpc-gen2.png" alt="VPC Generation 2 compute icon" width="30" style="width:30px; border-style: none"/> ACLs filter incoming and outgoing traffic for your cluster at the subnet level, such as traffic through the VPC load balancer. To control traffic within the cluster at the pod-to-pod level, you cannot use VPC security groups or ACLs. Instead, use [Calico](/docs/containers?topic=containers-network_policies) and [Kubernetes network policies](/docs/containers?topic=containers-vpc-network-policy#kubernetes_policies), which can control the pod-level network traffic that uses IP in IP encapsulation.
{: important}

If you have unique security requirements, you can control traffic to and from your cluster with VPC access control lists (ACLs) and traffic between pods in your cluster with Kubernetes network policies.
{: shortdesc}

<dl>
<dt>[VPC access control lists (ACLs)](#acls)</dt>
<dd>VPC ACLs specify rules that are applied at the level of each VPC subnet.<ul><li>By using inbound rules, you can allow or deny traffic from a source IP range with specified protocols and ports. The destination IP range is determined by the subnet that you attach the ACL to.</li><li>By using outbound rules, you can allow or deny traffic to a source IP range with specified protocols and ports. The source IP range is determined by the subnet that you attach the ACL to.</li></ul><p class="note">Although Calico policies are supported in VPC clusters, you can remain VPC-native by using VPC ACLs for your subnets instead. However, if you create multiple clusters that use the same subnets in one VPC, you cannot use ACLs to control traffic between the clusters because they share the same subnets. You can use [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers) to isolate your clusters on the private network.</p></dd>
<dt>[Kubernetes network policies ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)</dt>
<dd>Kubernetes network policies specify how pods can communicate with other pods and with external endpoints. As of Kubernetes version 1.8, both incoming and outgoing network traffic can be allowed or blocked based on protocol, port, and source or destination IP addresses. Traffic can also be filtered based on pod and namespace labels. Kubernetes network policies are applied by using `kubectl` commands or the Kubernetes APIs. When these policies are applied, they are automatically converted into Calico network policies. The Calico network plug-in in your cluster enforces these policies by setting up Linux Iptables rules on the Kubernetes worker nodes. Iptables rules serve as a firewall for the worker node to define the characteristics that the network traffic must meet to be forwarded to the targeted resource.</dd>
</dl>

You cannot attach worker nodes to [VPC security groups](/docs/vpc?topic=vpc-using-security-groups) because your worker nodes exist in a service account and are not listed in the VPC infrastructure dashboard. Although you cannot attach a security group to your worker nodes instances, you can create security groups at the level of the VPC. For more information, see [Opening required ports in VPC security groups](/docs/containers?topic=containers-vpc-firewall#security_groups).
{: note}

<br />


## Creating access control lists (ACLs) to control traffic to and from your VPC cluster
{: #acls}
{: help}
{: support}

Control inbound and outbound traffic to your cluster by creating and applying ACLs to each subnet that your cluster is attached to.
{: shortdesc}

When you create a VPC, a default ACL is created in the format `allow-all-network-acl-<VPC_ID>` for the VPC. The ACL includes an inbound rule and an outbound rule that allow all traffic to and from your subnets. Any subnet that you create in the VPC is attached to this ACL by default. If you want to specify which traffic is permitted to the worker nodes on your VPC subnets, you can create a custom ACL for each subnet in the VPC.

For example, you can create the following set of ACL rules to block most inbound and outbound network traffic of a cluster, while allowing communication that is necessary for the cluster to function.

When you use the following steps to create custom ACLs, only network traffic that is specified in the ACL rules is permitted to and from your VPC subnets. All other traffic that is not specified in the ACLs is blocked for the subnets, such as cluster integrations with third party services. If you must allow other traffic to or from your worker nodes, be sure to specify those rules where noted in the following steps. For more information about ACL rule requirements and limitations, see [Setting up network ACLs](/docs/vpc?topic=vpc-using-acls).
{: important}

### Creating ACLs in the console
{: #acls_ui}

ACL rules are applied to traffic in a specific order. If you want to add a rule after you complete these steps, ensure that you add the rule before the rules that deny all inbound and outbound traffic.
{: important}

1. Multizone clusters only: In the [Subnets for VPC dashboard](https://cloud.ibm.com/vpc-ext/network/subnets){: external}, note the **IP Range** of each subnet that your cluster is attached to.
2. In the [Access control lists for VPC dashboard](https://cloud.ibm.com/vpc-ext/network/acl){: external}, click **New access control list**.
3. Give your ACL a name and choose the VPC and resource group that your subnets are in.
4. In the **Rules** section, delete the default inbound rule and outbound rule that allow all inbound and outbound traffic.
5. In the **Inbound rules** section, create the following rules by clicking **New rule**.
    <p class="note">ACL rules are applied to traffic in a specific order. If you must create custom rules to allow other traffic to or from your worker nodes on this subnet, be sure to set the custom rules' **Priority** before the rule that denies all traffic. If you add a rule after the deny rule, your rule is ignored, because the packet matches the deny rule and is blocked and removed before it can reach your rule.</p>
    <table>
    <caption>Inbound rule</caption>
    <thead>
    <th>Rule purpose</th>
    <th>Allow/Deny</th>
    <th>Protocol</th>
    <th>Source Type</th>
    <th>Source IP or CIDR</th>
    <th>Source Port min</th>
    <th>Source Port max</th>
    <th>Destination Type</th>
    <th>Destination IP or CIDR</th>
    <th>Destination Port min</th>
    <th>Destination Port max</th>
    <th>Priority</th>
    </thead>
    <tbody>
    <tr>
    <td>Allow worker nodes to be created in your cluster.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>161.26.0.0/16</td>
    <td>-</td>    
    <td>-</td>
    <td>Any</td>
    <td>-</td>   
    <td>-</td>   
    <td>-</td>
    <td>Set to top</td>
    </tr>
    <tr>
    <td>Allow worker nodes to communicate with the cluster master through the private service endpoint and to communicate with other {{site.data.keyword.cloud_notm}} services that support private service endpoints, such as {{site.data.keyword.registrylong_notm}}.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>166.8.0.0/14</td>
    <td>-</td>    
    <td>-</td>
    <td>Any</td>
    <td>-</td>   
    <td>-</td>   
    <td>-</td>
    <td>After 1</td>
    </tr>
    <tr>
    <td>Multizone clusters: Allow worker nodes in one subnet to communicate with the worker nodes in all other subnets within the cluster. Create one rule for each subnet that you want to connect to.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>Other subnet's CIDR</td>
    <td>-</td>  
    <td>-</td>
    <td>Any</td>
    <td>-</td>   
    <td>-</td>   
    <td>-</td>
    <td>After 2</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>56501</td>
    <td>56501</td>
    <td>After 3</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 443.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>443</td>
    <td>443</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>After 4</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 8834.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>8834</td>
    <td>8834</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>After 5</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 10514.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>10514</td>
    <td>10514</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>After 6</td>
    </tr>
    <tr>
    <td>Deny all other traffic that does not match the previous rules.</td>
    <td>Deny</td>
    <td>ALL</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Set to bottom</td>
    </tr>
    </tbody>
    </table>

6. In the **Outbound rules** section, create the following rules by clicking **New rule**.
    <p class="important">ACL rules are applied to traffic in a specific order. If you must create custom rules to allow other traffic to or from your worker nodes on this subnet, be sure to set the custom rules' **Priority** before the rule that denies all traffic. If you add a rule after the deny rule, your rule is ignored, because the packet matches the deny rule and is blocked and removed before it can reach your rule.</p>
    <table>
    <caption>Inbound rule</caption>
    <thead>
    <th>Rule purpose</th>
    <th>Allow/Deny</th>
    <th>Protocol</th>
    <th>Source Type</th>
    <th>Source IP or CIDR</th>
    <th>Source Port min</th>
    <th>Source Port max</th>
    <th>Destination Type</th>
    <th>Destination IP or CIDR</th>
    <th>Destination Port min</th>
    <th>Destination Port max</th>
    <th>Priority</th>
    </thead>
    <tbody>
    <tr>
    <td>Allow worker nodes to be created in your cluster.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>Any</td>
    <td>-</td>    
    <td>-</td>
    <td>161.26.0.0/16</td>
    <td>-</td>   
    <td>-</td>   
    <td>-</td>
    <td>Set to top</td>
    </tr>
    <tr>
    <td>Allow worker nodes to communicate with the cluster master through the private service endpoint and to communicate with other {{site.data.keyword.cloud_notm}} services that support private service endpoints, such as {{site.data.keyword.registrylong_notm}}.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>Any</td>
    <td>-</td>    
    <td>-</td>
    <td>166.8.0.0/14</td>
    <td>-</td>   
    <td>-</td>   
    <td>-</td>
    <td>After 1</td>
    </tr>
    <tr>
    <td>Multizone clusters: Allow worker nodes in one subnet to communicate with the worker nodes in all other subnets within the cluster. Create one rule for each subnet that you want to connect to.</td>
    <td>Allow</td>
    <td>ALL</td>
    <td>IP or CIDR</td>
    <td>Any</td>
    <td>-</td>  
    <td>-</td>
    <td>Other subnet's CIDR</td>
    <td>-</td>
    <td>-</td>  
    <td>-</td>
    <td>After 2</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>56501</td>
    <td>56501</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>After 3</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 443.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>443</td>
    <td>443</td>
    <td>After 4</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 8834.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>8834</td>
    <td>8834</td>
    <td>After 5</td>
    </tr>
    <tr>
    <td>Optional: If you plan to expose apps by using load balancers or Ingress, allow traffic through VPC load balancers on port 10514.</td>
    <td>Allow</td>
    <td>TCP</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>10514</td>
    <td>10514</td>
    <td>After 6</td>
    </tr>
    <tr>
    <td>Deny all other traffic that does not match the previous rules.</td>
    <td>Deny</td>
    <td>ALL</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Any</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Set to bottom</td>
    </tr>
    </tbody>
    </table>

7. In the **Attach subnets** section, choose the name of the subnet for which you created this ACL.

8. Click **Create access control list**.

9. Multizone clusters: Repeat steps 2 - 8 to create an ACL for each subnet that your cluster is attached to.

### Creating ACLs from the CLI
{: #acls_cli}

ACL rules are applied to traffic in a specific order. If you want to add a rule after you complete these steps, ensure that you add the rule before the `deny-all-inbound` or `deny-all-outbound` rule. If you add a rule after these rules, your rule is ignored, because the packet matches the `deny-all-inbound` and `deny-all-outbound` rules and is blocked and removed before it can reach your rule. Create your rule in the proper order by including the `--before-rule-name deny-all-(inbound|outbound)` flag.
{: important}

1. Target the region of the VPC that your cluster is deployed to.
  ```
  ibmcloud target -r <region>
  ```
  {: pre}

2. List your VPC subnets. For each subnet that your cluster is attached to, get the **ID** and **Subnet CIDR**.
  <p class="tip">If you can't remember which subnets your cluster is attached to, you can run `ibmcloud ks worker get -c <cluster_name_or_ID> -w <worker_node_ID>` for one worker node in each zone of your cluster, and get the **ID** and **CIDR** of the subnet that the worker is attached to.</p>
  ```
  ibmcloud is subnets
  ```
  {: pre}

  Example output:
  ```
  ID                                          Name          Status      Subnet CIDR        Addresses   ACL                                                  Public Gateway                             VPC       Zone         Resource group
  0717-2224d664-d435-425e-b5ec-f324af2df445   mysubnet1     available   10.240.0.0/28      11/16       armored-never-chitchat-gangly-skylight-prototype     -                                          myvpc     us-south-1   default
  0717-1eff410a-a47e-4bc2-b4a3-5f742f320008   mysubnet2     available   10.240.1.0/24      251/256     armored-never-chitchat-gangly-skylight-prototype     pgw-ed8f6970-9b71-11ea-b94a-956de1af1ccd   myvpc     us-south-2   default
  ```
  {: screen}

3. For **each** subnet that you identified in the previous step, create a custom ACL with rules that limit inbound and outbound network traffic to only communication that is necessary for the cluster to function.

  1. Create an ACL. After you create the ACL, you can add rules to your ACL and apply the ACL to one subnet. Because the rules that you add to your ACL are specific to one subnet, consider naming the ACL in the format `<cluster>-<zone>-acl`, such as `mycluster-us-south-1-acl`, for easy identification. When you create the ACL, two rules are automatically created that allow all inbound and all outbound network traffic. In the output, note the ACL ID and the IDs of the two default rules.
    ```
    ibmcloud is network-acl-create <cluster>-<zone>-acl
    ```
    {: pre}

     Example output:
    ```
    Creating network ACL mycluster-us-south-1-acl under account Account as user user@email.com...

    ID        740b07cb-4e69-4ef2-b667-42ed27d8b29e
    Name      mycluster-us-south-1-acl
    Created   2019-09-18T15:09:45-05:00

    Rules

    inbound
    ID                                     Name                                                          Action   IPv*   Protocol   Source      Destination   Created
    e3caad9c-68b7-4a4a-8188-d239fbc724df   allow-all-inbound-rule-740b07cb-4e69-4ef2-b667-42ed27d8b29e   allow    ipv4   all        0.0.0.0/0   0.0.0.0/0     2019-09-18T15:09:45-05:00

    outbound
    ID                                     Name                                                           Action   IPv*   Protocol   Source      Destination   Created
    7043ac95-cc4e-42e9-a490-22177237f083   allow-all-outbound-rule-740b07cb-4e69-4ef2-b667-42ed27d8b29e   allow    ipv4   all        0.0.0.0/0   0.0.0.0/0     2019-09-18T15:09:45-05:00
    ```
    {: screen}

  2. Export the ACL ID as an environment variable.
    ```
    export ACL_ID=<acl_id>
    ```
    {: pre}

  3. Delete the default rules that allow all inbound and outbound traffic.
    ```
    ibmcloud is network-acl-rule-delete $acl_id <default_inbound_rule_ID> -f
    ```
    {: pre}
    ```
    ibmcloud is network-acl-rule-delete $acl_id <default_outbound_rule_ID> -f
    ```
    {: pre}

  4. Multizone clusters: Add rules to your ACL to allow worker nodes in one subnet to communicate with the worker nodes in all other subnets within the cluster. The subnet for which you create the ACL rule is defined as `0.0.0.0/0` and you use the CIDRs of the other subnets as your destination CIDR. Make sure to create one inbound and one outbound rule for each of the subnets that you want to connect to.
    ```
    ibmcloud is network-acl-rule-add $acl_id allow outbound all 0.0.0.0/0 <other_zone_subnet_CIDR> --name allow-workers-outbound
    ```
    {: pre}
    ```
    ibmcloud is network-acl-rule-add $acl_id allow inbound all <other_zone_subnet_CIDR> 0.0.0.0/0 --name allow-workers-inbound
    ```
    {: pre}

  5. Create rules to allow inbound traffic from and outbound traffic to the `161.26.0.0/16` and `166.8.0.0/14` {{site.data.keyword.cloud_notm}} private subnets. The `161.26.0.0/16` rules allow you to create worker nodes in your cluster. The `166.8.0.0/14` rules allow worker nodes to communicate with the cluster master through the private service endpoint and to communicate with other {{site.data.keyword.cloud_notm}} services that support private service endpoints, such as {{site.data.keyword.registrylong_notm}}.

    <p class="tip">Need to connect your worker nodes to {{site.data.keyword.cloud_notm}} services that support only public service endpoints? [Attach a public gateway to the subnet ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/clusters) so that worker nodes can connect to a public external endpoint. Then, create inbound and outbound rules to allow ingress from and egress to the services' public service endpoints.</p>

    ```
    ibmcloud is network-acl-rule-add $acl_id allow outbound all 0.0.0.0/0 161.26.0.0/16 --name allow-ibm-private-network-outbound1
    ibmcloud is network-acl-rule-add $acl_id allow outbound all 0.0.0.0/0 166.8.0.0/14 --name allow-ibm-private-network-outbound2
    ibmcloud is network-acl-rule-add $acl_id allow inbound all 161.26.0.0/16 0.0.0.0/0 --name allow-ibm-private-network-inbound1
    ibmcloud is network-acl-rule-add $acl_id allow inbound all 166.8.0.0/14 0.0.0.0/0 --name allow-ibm-private-network-inbound2
    ```
    {: pre}

  6. Optional: If you plan to expose apps by using load balancers or Ingress, create rules to allow inbound and outbound traffic through TCP ports `56501`, `443`, `8834`, and `10514`. For more information, see the [VPC load balancer documentation](/docs/vpc?topic=vpc-load-balancers#configuring-acls-for-use-with-load-balancers).

    ```
    ibmcloud is network-acl-rule-add $acl_id allow outbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-outbound1 --source-port-min 56501 --source-port-max 56501
    ibmcloud is network-acl-rule-add $acl_id allow outbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-outbound2 --destination-port-min 443 --destination-port-max 443
    ibmcloud is network-acl-rule-add $acl_id allow outbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-outbound3 --destination-port-min 8834 --destination-port-max 8834
    ibmcloud is network-acl-rule-add $acl_id allow outbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-outbound4 --destination-port-min 10514 --destination-port-max 10514
    ibmcloud is network-acl-rule-add $acl_id allow inbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-inbound1 --destination-port-min 56501 --destination-port-max 56501
    ibmcloud is network-acl-rule-add $acl_id allow inbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-inbound2 --source-port-min 443 --source-port-max 443
    ibmcloud is network-acl-rule-add $acl_id allow inbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-inbound3 --source-port-min 8834 --source-port-max 8834
    ibmcloud is network-acl-rule-add $acl_id allow inbound tcp 0.0.0.0/0 0.0.0.0/0 --name allow-lb-inbound4 --source-port-min 10514 --source-port-max 10514
    ```
    {: pre}

  7. Optional: If you must allow other traffic to or from your worker nodes on this subnet, add rules for that traffic.

    <p class="note">When you refer to the VPC subnet that your worker nodes are on, you must use `0.0.0.0/0`. For more tips on how to create your rule, see the [VPC CLI reference documentation](/docs/vpc-on-classic-network?topic=vpc-on-classic-vpc-reference#network-acls-section).</p>

    ```
    ibmcloud is network-acl-rule-add $acl_id <allow|deny> <inbound|outbound> <protocol> <source_CIDR> <destination_CIDR> --name <new_rule_name>
    ```
    {: pre}

    For example, say that you want your worker nodes to communicate with a subnet in your organization's network, `207.42.8.0/24`. Your worker nodes must be able to both send and receive information from devices or services on this subnet. You can create an outbound rule for traffic to and an inbound rule for traffic from your organization's subnet:
    ```
    ibmcloud is network-acl-rule-add $acl_id allow outbound all 0.0.0.0/0 207.42.8.0/24 --name corporate-network-outbound
    ibmcloud is network-acl-rule-add $acl_id allow inbound all 207.42.8.0/24 0.0.0.0/0 --name corporate-network-inbound
    ```
    {: screen}

  8. Create rules to deny all other egress from and ingress to worker nodes that is not permitted by the previous rules that you created. Because these rules are created last in the chain of rules, they deny an incoming or outgoing connection only if the connection does not match any other rule that is earlier in the rule chain.
    ```
    ibmcloud is network-acl-rule-add $acl_id deny outbound all 0.0.0.0/0 0.0.0.0/0 --name deny-all-outbound
    ibmcloud is network-acl-rule-add $acl_id deny inbound all 0.0.0.0/0 0.0.0.0/0 --name deny-all-inbound
    ```
    {: pre}

  9. Apply this ACL to the subnet. When you apply this ACL, the rules that you defined are immediately applied to the worker nodes on the subnet.
    ```
    ibmcloud is subnet-update <subnet_ID> --network-acl-id $acl_id
    ```
    {: pre}

    Example output:
    ```
    ID                  a1b2c3d4-f560-471b-b6ce-20067ac93439
    Name                vpctest-us-south-1
    IPv*                ipv4
    IPv4 CIDR           10.240.0.0/24
    IPv6 CIDR           -
    Address Available   244
    Address Total       256
    ACL                 vpctest-us-south-1-acl(b664769d-514c-407f-a9f3-d44d72706121)
    Gateway             pgw-18a3ebb0-b539-11e9-9838-f3f4efa02374(f8b95e43-a408-4dc8-a489-ed649fc4cfec)
    Created             2019-08-02T10:20:17-05:00
    Status              available
    Zone                us-south-1
    VPC                 myvpc(ff537d43-a5a4-4b65-9627-17eddfa5237b)
    ```
    {: screen}

  9. Repeat these steps for each subnet.

<br />


## Creating Kubernetes policies to control traffic between pods
{: #kubernetes_policies}

Kubernetes policies protect pods from internal network traffic. You can create simple Kubernetes network policies to isolate app microservices from each other within a namespace or across namespaces.
{: shortdesc}

For more information about how Kubernetes network policies control pod-to-pod traffic and for more example policies, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/){: external}.
{: tip}

### Isolate app services within a namespace
{: #vpc-services_one_ns}

The following scenario demonstrates how to manage traffic between app microservices within one namespace.

An Accounts team deploys multiple app services in one namespace, but they need isolation to permit only necessary communication between the microservices over the public network. For the app `Srv1`, the team has front end, back end, and database services. They label each service with the `app: Srv1` label and the `tier: frontend`, `tier: backend`, or `tier: db` label.

<img src="images/cs_network_policy_single_ns.png" width="200" alt="Use a network policy to manage cross-namespace traffic." style="width:200px; border-style: none"/>

The Accounts team wants to allow traffic from the front end to the back end, and from the back end to the database. They use labels in their network policies to designate which traffic flows are permitted between microservices.

First, they create a Kubernetes network policy that allows traffic from the front end to the back end:

```yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

The `spec.podSelector.matchLabels` section lists the labels for the Srv1 back-end service so that the policy applies only _to_ those pods. The `spec.ingress.from.podSelector.matchLabels` section lists the labels for the Srv1 front-end service so that ingress is permitted only _from_ those pods.

Then, they create a similar Kubernetes network policy that allows traffic from the back end to the database:

```yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

The `spec.podSelector.matchLabels` section lists the labels for the Srv1 database service so that the policy applies only _to_ those pods. The `spec.ingress.from.podSelector.matchLabels` section lists the labels for the Srv1 back-end service so that ingress is permitted only _from_ those pods.

Traffic can now flow from the front end to the back end, and from the back end to the database. The database can respond to the back end, and the back end can respond to the front end, but no reverse traffic connections can be established.

### Isolate app services between namespaces
{: #vpc-services_across_ns}

The following scenario demonstrates how to manage traffic between app microservices across multiple namespaces.

Services that are owned by different subteams need to communicate, but the services are deployed in different namespaces within the same cluster. The Accounts team deploys front end, back end, and database services for the app Srv1 in the accounts namespace. The Finance team deploys front end, back end, and database services for the app Srv2 in the finance namespace. Both teams label each service with the `app: Srv1` or `app: Srv2` label and the `tier: frontend`, `tier: backend`, or `tier: db` label. They also label the namespaces with the `usage: accounts` or `usage: finance` label.

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="Use a network policy to manage cross-namepsace traffic." style="width:475px; border-style: none"/>

The Finance team's Srv2 needs to call information from the Accounts team's Srv1 back end. So the Accounts team creates a Kubernetes network policy that uses labels to allow all traffic from the finance namespace to the Srv1 back end in the accounts namespace. The team also specifies the port 3111 to isolate access through that port only.

```yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

The `spec.podSelector.matchLabels` section lists the labels for the Srv1 back-end service so that the policy applies only _to_ those pods. The `spec.ingress.from.NamespaceSelector.matchLabels` section lists the label for the finance namespace so that ingress is permitted only _from_ services in that namespace.

Traffic can now flow from finance microservices to the accounts Srv1 back end. The accounts Srv1 back end can respond to finance microservices, but can't establish a reverse traffic connection.

In this example, all traffic from all microservices in the finance namespace is permitted. You can't allow traffic from specific app pods in another namespace because `podSelector` and `namespaceSelector` can't be combined.

