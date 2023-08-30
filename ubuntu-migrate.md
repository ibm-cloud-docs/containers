---

copyright:
  years: 2022, 2023
lastupdated: "2023-08-30"

keywords: ubuntu, operating system, migrate, ubuntu version, worker nodes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Migrating to a new Ubuntu version
{: #ubuntu-migrate}

To migrate your worker nodes to a new Ubuntu version, you must provision a new worker pool, add worker nodes to the new pool, then remove the original worker pool.
{: shortdesc}

`UBUNTU_20_64` is the default operating system for all supported {{site.data.keyword.containerlong_notm}} cluster versions. Creating clusters with `UBUNTU_18_64` is no longer supported. To avoid disruptions to your workload, migrate your worker nodes to `UBUNTU_20_64` as soon as possible.
{: note}

With the release of `UBUNTU_20_64`, some worker node flavors are deprecated. If you have worker nodes with these flavors, you must provision worker nodes with a new flavor during the migration process. The deprecated flavors are: `mb3c.4x32, mb3c.16x64, ms3c.4x32.1.9tb.ssd, ms3c.16x64.1.9tb.ssd, ms3c.28x256.3.8tb.ssd, ms3c.28x512.4x3.8tb.ssd, mr3c.28x512, md3c.16x64.4x4tb, md3c.28x512.4x4tb, mg3c.16x128, mg3c.28x256`.
{: important}

## Prerequisites
{: #ubuntu-migrate-prereqs}

1. Review your worker pool operating systems to determine which pools you need to migrate.
    ```sh
    ibmcloud ks worker-pools -c CLUSTER
    ```
    {: pre}

1. For the worker pools that you want to migrate, review the details of the worker pool.
    ```sh
    ibmcloud ks worker-pool get --cluster CLUSTER --worker-pool WORKER-POOL --output json
    ```
    {: pre}

1. In the output, note the zone and either the private and public VLAN ID for Classic clusters or the subnet ID for VPC clusters. Also note any custom labels that you are using. The default worker pool label is `ibm-cloud.kubernetes.io`. Any labels other than `ibm-cloud.kubernetes.io` are custom labels that you should add to your new worker pool.

## Migration steps
{: #ubuntu-migrate-steps}

Migrate your worker nodes to use Ubuntu 20. These steps apply to all supported cluster versions.
{: shortdesc}


1. In your cluster, create a new worker pool for the Ubuntu 20 worker nodes. Include the `--operating-system=UBUNTU_20_64` option. Make sure that the number of nodes specified with the `--size-per-zone` option matches the number of Ubuntu 18 worker nodes that you are replacing. Also, be sure to include the custom labels that you retrieved earlier.

    **For classic clusters**. See the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_create) for command details.

    ```sh
    ibmcloud ks worker-pool create classic --name NAME --cluster CLUSTER --flavor FLAVOR --operating-system UBUNTU_20_64 --size-per-zone WORKERS-PER-ZONE --label LABEL --label LABEL
    ```
    {: pre}

    **For VPC clusters**. See the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_pool_create_vpc_gen2) for command details.

    ```sh
    ibmcloud ks worker-pool create vpc-gen2 --name NAME --cluster CLUSTER --flavor FLAVOR --operating-system UBUNTU_20_64 --size-per-zone WORKERS-PER-ZONE --label LABEL --label LABEL
    ```
    {: pre}

1. Verify that the worker pool is created.

    ```sh
    ibmcloud ks worker-pool ls --cluster CLUSTER
    ```
    {: pre}

1. Prepare to add a zone to your worker pool. When you add a zone, the number of worker nodes you specified with the `--size-per-zone` option are added to the zone. These worker nodes run the Ubuntu 20 operating system. 

    **Classic and VPC clusters**: If possible, use the same Classic VLAN or VPC subnet for the new zone as you are using for the Ubuntu 18 worker pool.
    {: important}

    If you need to use a different Classic VLAN or VPC Subnet for these new nodes, note that switching your worker nodes to a different Classic VLAN or VPC subnet can have significant effects your workload and cluster functionality. For example, you might experience the following.
        - In Classic clusters: Classic LoadBalancers might not work because the LoadBalancer IPs are specific to a single VLAN, and traffic can only be routed to the LoadBalancer if there is a worker node in the cluster on that VLAN that the LoadBalancer IP can be placed on.
        - In Classic or VPC Clusters: Problems with the network connections to and from workers in the new Classic VLANs or VPC subnets if you have any Security Groups, Network ACLs, Firewall/Gateway rules, Custom routing, coreDNS configurations, and so on, that are specific to the old VLANs, VPC subnets, or cluster worker IP addresses or subnets.

1. Add the zone to your worker pool that you retrieved earlier. When you add a zone, the worker nodes that are defined in your worker pool are provisioned in the zone and considered for future workload scheduling.
    * Classic clusters:
        ```sh
        ibmcloud ks zone add classic --zone ZONE --cluster CLUSTER --worker-pool WORKER-POOL --private-vlan PRIVATE-VLAN-ID --public-vlan PUBLIC-VLAN-ID
        ```
        {: pre}

    * VPC clusters:
        ```sh
        ibmcloud ks zone add vpc-gen2 --zone ZONE --cluster CLUSTER --worker-pool WORKER-POOL --subnet-id VPC-SUBNET-ID
        ```
        {: pre}


1. Verify that worker nodes are available in your new worker pool. In the output, find the listing for the new worker pool and check the number in the **Workers** column.
    ```sh
    ibmcloud ks worker-pool ls --cluster <cluster_name_or-ID>
    ```
    {: pre}

1. **Classic clusters**: If you created your worker pool in a new VLAN, move your ALBs to the new VLAN. For more information, see [Moving ALBs across VLANs in classic clusters](/docs/containers?topic=containers-ingress-alb-manage#migrate-alb-vlan).

## Removing your old worker pools
{: #ubuntu-migrate-removal}

Before you remove your Ubuntu 18 worker pools, consider scaling them down   and keeping them for several days before you remove them. This way, you can scale the worker pool back up if your workload experiences disruptions during the migration process. When you determine that your workload is stable and functions normally, you can remove the Ubuntu 18 worker pool.
{: important}


1. List your worker pools and note the name of the worker pool you want to remove.
    ```sh
    ibmcloud ks worker-pool ls --cluster CLUSTER
    ```
    {: pre}

1. Run the command to remove the worker pool.
    ```sh
    ibmcloud ks worker-pool rm --worker-pool WORKER-POOL --cluster CLUSTER
    ```
    {: pre}



