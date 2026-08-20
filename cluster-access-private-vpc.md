---

copyright:
  years: 2014, 2026
lastupdated: "2026-08-20"

keywords: containers, clusters, access, private, endpoint, vpc, vpn, direct link

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Accessing VPC clusters through the private cloud service endpoint
{: #cluster-access-private-vpc}

For VPC clusters, the private service endpoint can be accessed from anywhere inside IBM Cloud, or from a client connected to the VPC private network through a VPN or {{site.data.keyword.dl_full_notm}} connection.
{: shortdesc}

## Before you begin
{: #access-private-vpc-prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install).
1. Set up one of the following connections to the VPC private network.
   - [Client-to-site VPN](/docs/vpc?topic=vpc-vpn-client-to-site-overview)
   - [Site-to-site VPN](/docs/vpc?topic=vpc-vpn-onprem-example)
   - [{{site.data.keyword.dl_full_notm}}](/docs/dl?topic=dl-get-started-with-ibm-cloud-dl)
1. Verify your cluster is healthy: `ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID`.

## Accessing a private VPC cluster from the CLI
{: #access-private-vpc-cli}

For regions other than `ca-mon`, `in-che`, and `in-mum`, the private service endpoint can be accessed from anywhere inside IBM Cloud, or from a client using a VPN to connect to IBM Cloud.

The private service endpoint URL for a cluster looks like `c<XXX>.private.<REGION>.containers.cloud.ibm.com:XXXXX`. Use the following command to get a kubeconfig that uses this private endpoint.

1. Download the kubeconfig for the cluster using the private endpoint.

   **Log in as admin**:
   ```sh
   ibmcloud ks cluster config -c CLUSTER_NAME_OR_ID --admin --endpoint private
   ```
   {: pre}

   
   **Log in as user**:
   ```sh
   ibmcloud ks cluster config -c CLUSTER_NAME_OR_ID --endpoint private
   ```
   {: pre}
   

   

1. Verify the connection.
   ```sh
   ibmcloud ks get nodes
   ```
   {: pre}

## Accessing through the Virtual Private Endpoint (VPE) gateway
{: #access-private-vpc-vpe}

VPC clusters also support access through a VPE gateway, which is available from inside the VPC or via a VPN into that specific VPC. See [Accessing VPC clusters through the Virtual Private Endpoint gateway](/docs/containers?topic=containers-cluster-access-vpe).
