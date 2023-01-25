---

copyright:
  years: 2014, 2023
lastupdated: "2023-01-25"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Classic clusters: Why does enabling Ingress ALBs result in subnet errors?
{: #cs_alb_subnet}
{: support}

[Classic infrastructure]{: tag-classic-inf}



When you try to enable an Ingress ALB by running the `ibmcloud ks ingress alb enable` command, you see the following error:
{: tsSymptoms}

```sh
No valid subnets found for the specified zone. Verify that a subnet exists on the VLAN in the zone that you specify by running 'ibmcloud ks subnets'. Note: If the problem persists, verify that your ALBs and worker nodes are on the same VLANs by following the steps in this troubleshooting doc: <https://ibm.biz/alb-vlan-ts>
```
{: screen}

However, you ran `ibmcloud ks ks subnets` and verified that one or more subnets are available on the VLAN in the zone where the ALB exists.


Your ALBs and your worker nodes might not exist on the same VLANs.
{: tsCauses}

This can occur when you delete worker nodes on the VLANs that the ALBs were also originally created on, and then create new worker nodes on new VLANs.


Move your ALBs to the same VLANs that your worker nodes exist on by following the steps in [Moving ALBs across VLANs](/docs/containers?topic=containers-ingress-alb-manage#migrate-alb-vlan).
{: tsResolve}






