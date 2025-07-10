---

copyright: 
  years: 2025, 2025
lastupdated: "2025-07-10"


keywords: kubernetes, help, network,

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Checking the status of Network components
{: #network-status}
{: support}

[Virtual Private Cloud]{: tag-vpc}

## Getting the status and message
{: #check_status}

To check the overall health and health state of your cluster's components:
{: shortdesc}

```sh
ibmcloud ks ks cluster health issues --cluster <CLUSTER_ID>
```
{: pre}

The state of the Network components are reported in a **Cluster Status** where you can see the status of your Kubernetes Cluster components.

Example output


```sh
Retrieving health issues for cluster <CLUSTER_ID>
OK
ID         Component   Severity   Description
NHC010     Network     Error      Exceeded security group rules related quota.
ERRADRUH   Ingress     Warning    One or more ALB pod is not in running state (ERRADRUH).
ERRAHCF    Ingress     Warning    The ALB is unable to respond to health requests (ERRAHCF).
```
{: screen}



## Network statuses
{: #network_status}

The Network Status reflects the overall health of the Network components.
{: shortdesc}

| Network status | Description |
|--- | --- |
| `error` | There is an error in one of the Network components.|
| `warning` | The given Network component might not function properly.|
{: caption="Network statuses" caption-side="bottom"}


## Network messages
{: #network_message}

The Network message provides information about if any components are unhealthy. Each status and message is described in the following tables.
{: shortdesc}

|Network message|Description|
|--- |--- |
| `The IAM token exchange request failed.` | For more information, see [Why does the IAM token exchange request failed report in Network status, and show an NHC009 error.?](/docs/containers?topic=containers-ts-network-nhc009).|
| `Exceeded security group rules related quota.` | For more information, see [Why does exceeded security group rules related quota report in Network status, and show an NHC010 error.?](/docs/containers?topic=containers-ts-network-nhc010).|
| `Exceeded security group related quota.` | For more information, see [Why does Exceeded security group related quota report in Network status, and show an NHC011 error.?](/docs/containers?topic=containers-ts-network-nhc011).|
{: caption="Network messages" caption-side="bottom"}
