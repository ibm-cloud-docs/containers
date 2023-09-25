---

copyright:
  years: 2022, 2023
lastupdated: "2023-09-25"

keywords: kubernetes, help

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why can't I enable the add-on for LinuxONE worker nodes?
{: #ts-addon-s390x-enabled}
{: support}

[Virtual Private Cloud]{: tag-vpc} 

When you try to enable an add-on on a cluster with LinuxONE worker nodes, the process does not complete. 
{: tsSymptoms}


When you [check the status](/docs/containers?topic=containers-debug_addons) of the add-on, the **HEALTH STATUS** is **Addon Not Ready**. In the following example, the add-on `alb-oauth-proxy` does not support LinuxONE worker nodes.
{: tsCauses}

```sh
Name                   Version   Health State   Health Status   
alb-oauth-proxy        2.0.0     critical       Addon Not Ready (alb-oauth_proxy not Running). For more info: http://ibm.biz/addon-state (H1502)
  
```
{: screen}


The `H1502` status code indicates that the add-on cannot be enabled on LinuxONE (`s390x` architecture) worker nodes. Check the [Supported cluster add-on versions](/docs/containers?topic=containers-supported-cluster-addon-versions) for the list of add-ons supported on LinuxONE worker nodes.
{: tsResolve}


