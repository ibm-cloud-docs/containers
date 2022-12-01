---

copyright:
  years: 2022
lastupdated: "2022-12-01"

keywords: kubernetes, help, network, connectivity

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# After upgrading my classic cluster to version 1.21, I'm finding connectivity issues
{: #ts-network-classic121}

There is a known issue with classic Kubernetes 1.21 clusters that have public and private service endpoint, but don't have VRF enabled.
{: shortdesc}

You upgraded your classic cluster to Kubernetes 1.21 and are finding connectivity issues such as connecting to the Kubernetes console, fetching logs from pods, or running the {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool.
{: tsSymptoms}

In Kubernetes version 1.21, Konnectivity replaces OpenVPN as the network proxy that is used to secure the communication of the Kubernetes API server master to worker nodes in the cluster.
{: tsCauses}

However, when using Konnectivity, a problem exists with masters to cluster nodes communication when all the following conditions are met.

- You are updating an existing classic cluster to Kubernetes version 1.21 or are deploying a new classic cluster.
- The cluster has both private and public service endpoints enabled.
- Service endpoints or VRF are not enabled in the account.

To determine if VRF and service endpoints are enabled in your account, run `ibmcloud account show`. Look for the following output.

```sh
VRF Enabled:                        true   
Service Endpoint Enabled:           true 
```
{: screen}


To determine if your classic cluster has both public and private service endpoint enabled, run `ibmcloud ks cluster get -c <cluster_id>`. Look for output similar to:

```sh
Public Service Endpoint URL:    https://c105.<REGION>.containers.cloud.ibm.com:<port> 
Private Service Endpoint URL:   https://c105.private.<REGION>.containers.cloud.ibm.com:<port> 
```
{: screen}

If your cluster meets these conditions, delay updating to version 1.21 until you can [enable service endpoints and VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui#vrf) for the account. If you are updating your VPC clusters or classic clusters that have only public service endpoints enabled, there is no issue updating to 1.21. If you have questions about this issue, please open a support ticket and reference this announcement.
{: tsResolve}

Do not create classic clusters with only a private service endpoint enabled unless you have both VRF and the Service Endpoint enabled.
{: important}





