---

copyright:
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why are certain packets dropped on the public VLAN?
{: #mangle-table}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} 

You find that your {{site.data.keyword.containerlong_notm}} workers are dropping certain invalid packets or ingress packets while on a public VLAN with private source addresses. For example, you create an application load balancer (ALB) for your cluster, but can't connect to it. You receive a message similar to `Unable to connect to <ALB>`. 
{: tsSymptoms}

For certain custom network configurations, for example, if you configure a VPN to allow ingress traffic to a public IKS LoadBalancer that comes from private source IP addresses, then you might find that your custom traffic drops and is no longer available. This action is caused by the Distributed Denial of Service (DDOS) rules that are set in a Kubernetes worker node mangle iptable.
{: tsCauses}

The mangle iptable includes the following the following rules.

```sh
 2488  214K DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID /* DDOS: Blocks RST flood and TCP XMAS Flood (w and w/o data) */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x00 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x03/0x03 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x06/0x06 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x05/0x05 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x11/0x01 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x30/0x20 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x11/0x01 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x18/0x08 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x3F /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x00 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x29 /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x2B /* DDOS: Invalid packets */
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp flags:0x3F/0x37 /* DDOS: Invalid packets */
    0     0 DROP       all  --  eth1   *       224.0.0.0/3          0.0.0.0/0            /* DDOS: Drop private source IPs */
21803 1744K DROP       all  --  eth1   *       169.254.0.0/16       0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       172.16.0.0/12        0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       192.0.2.0/24         0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       0.0.0.0/8            0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       240.0.0.0/5          0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       10.0.0.0/8           0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 DROP       all  --  eth1   *       192.168.0.0/16       0.0.0.0/0            /* DDOS: Drop private source IPs */
    0     0 ACCEPT     all  --  vethlocal *       127.0.0.0/8          0.0.0.0/0            /* DDOS: Accept local LB traffic */
    0     0 DROP       all  --  !lo    *       127.0.0.0/8          0.0.0.0/0            /* DDOS: Drop private source IPs */
```
{: screen}


To resolve this issue, [create a private load balancer](/docs/containers?topic=containers-cs_network_planning) to allow this traffic with the private source IP addresses. If that does not resolve the problem, or for some reason, you can't create a private load balancer, then create a daemonset that removes the rules that are causing the issue.
{: tsResolve}
