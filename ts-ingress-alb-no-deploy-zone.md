---

copyright:
  years: 2014, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Classic clusters: Why are no ALBs deployed in a zone?
{: #cs_subnet_limit}
{: support}

Supported infrastructure provider
:   Classic


When you have a multizone classic cluster and run `ibmcloud ks ingress alb ls --cluster <cluster>`, no ALB is deployed in a zone. For example, if you have worker nodes in 3 zones, you might see an output similar to the following in which a public ALB did not deploy to the third zone.
{: tsSymptoms}

```txt
ALB ID                                            Enabled    Status     Type      ALB IP           Zone    Build                          ALB VLAN ID   NLB Version
private-cr96039a75fddb4ad1a09ced6699c88888-alb1   false      disabled   private   -                dal10   ingress:1.1.2_2507_iks   2294021       -
private-cr96039a75fddb4ad1a09ced6699c88888-alb2   false      disabled   private   -                dal12   ingress:1.1.2_2507_iks   2234947       -
private-cr96039a75fddb4ad1a09ced6699c88888-alb3   false      disabled   private   -                dal13   ingress:1.1.2_2507_iks   2234943       -
public-cr96039a75fddb4ad1a09ced6699c88888-alb1    true       enabled    public    169.xx.xxx.xxx   dal10   ingress:1.1.2_2507_iks   2294019       -
public-cr96039a75fddb4ad1a09ced6699c88888-alb2    true       enabled    public    169.xx.xxx.xxx   dal12   ingress:1.1.2_2507_iks   2234945       -
```
{: screen}


In standard clusters, the first time that you create a cluster in a zone, a public VLAN and a private VLAN in that zone are automatically provisioned for you in your IBM Cloud infrastructure account.
{: tsCauses}

In that zone, 1 public portable subnet is requested on the public VLAN that you specify and 1 private portable subnet is requested on the private VLAN that you specify. For {{site.data.keyword.containerlong_notm}}, VLANs have a limit of 40 subnets. If the cluster's VLAN in a zone already reached that limit, the **Ingress Subdomain** fails to provision and the public Ingress ALB for that zone fails to provision.

To view how many subnets a VLAN has:
1. From the [IBM Cloud infrastructure console](https://cloud.ibm.com/classic?), select **Network** > **IP Management** > **VLANs**.
2. Click the **VLAN Number** of the VLAN that you used to create your cluster. Review the **Subnets** section to see whether 40 or more subnets exist.


Option 1: If you need a new VLAN, order one by [contacting {{site.data.keyword.cloud_notm}} support](/docs/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans).
{: tsResolve}

Then, [create a cluster](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_create) that uses this new VLAN.

Option 2: If you have another VLAN that is available, you can [set up VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning) in your existing cluster. After, you can add new worker nodes to the cluster that use the other VLAN with available subnets. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_vlan_spanning_get).

Option 3: If you are not using all the subnets in the VLAN, you can reuse subnets on the VLAN by adding them to your cluster.
1. Check that the subnet that you want to use is available.
    The infrastructure account that you use might be shared across multiple {{site.data.keyword.cloud_notm}} accounts. In this case, even if you run the `ibmcloud ks subnets` command to see subnets with **Bound Clusters**, you can see information only for your clusters. Check with the infrastructure account owner to make sure that the subnets are available and not in use by any other account or team.
    {: note}

2. Use the [`ibmcloud ks cluster subnet add` command](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_subnet_add) to make an existing subnet available to your cluster.

3. Verify that the subnet was successfully created and added to your cluster. The subnet CIDR is listed in the **Subnet VLANs** section.
    ```sh
    ibmcloud ks cluster get --cluster <cluster_name> --show-resources
    ```
    {: pre}

    In this example output, a second subnet was added to the `2234945` public VLAN:
    ```txt
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

4. Verify that the portable IP addresses from the subnet that you added are used for the ALBs in your cluster. It might take several minutes for the services to use the portable IP addresses from the new subnet.
    * **No Ingress subdomain**: Run `ibmcloud ks cluster get --cluster <cluster>` to verify that the **Ingress Subdomain** is populated.
    * **An ALB does not deploy in a zone**: Run `ibmcloud ks ingress alb ls --cluster <cluster>` to verify that the missing ALB is deployed.






