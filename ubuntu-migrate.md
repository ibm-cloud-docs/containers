---

copyright:
  years: 2022, 2024
lastupdated: "2024-09-19"


keywords: ubuntu, operating system, migrate, ubuntu version, worker nodes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Migrating to a new Ubuntu version
{: #ubuntu-migrate}

To migrate your worker nodes to a new Ubuntu version, run a command to specify the new version for a worker pool. Then, update the individual worker nodes in the pool.
{: shortdesc}

## Default operating system by cluster version
{: #ubuntu-default}

Ubuntu 20 is the default operating system for all clusters that run version 1.30 and earlier. Ubuntu 24 is the default operating system for clusters that run version 1.31. Clusters upgraded to version 1.31 continue to support worker nodes that run either Ubuntu 20 or 24. A worker pool's operating system does not automatically change when you upgrade a cluster.

## Ubuntu 24 limitations
{: #ubuntu-24-lim}

- Available for cluster versions 1.29 and later.
- Supported for virtual servers only. Cannot be used with bare metal servers. 
- Not available for GPU worker node flavors. 
- NTP uses `timesyncd`. Related commands might be updated.  
- The following add-ons and features are not supported. Do not migrate your worker nodes if you use these features:
    
    - Object storage plug-in
    - Portworx


## Migration steps
{: #ubuntu-migrate-steps}

Migrate your worker nodes to use Ubuntu 24. These steps apply to all supported cluster versions.
{: shortdesc}

For Ubuntu 24, the `/tmp` directory is a separate partition that has the `nosuid`, `noexec`, and `nodev` options set. If your apps install to and run scripts or binaries under the `/tmp` directory, they might fail. You can use the `/var/tmp` directory instead of the `/tmp` directory to run temporary scripts or binaries.
{: important}

1. Review your worker pool operating systems to determine which pools you need to migrate.
    ```sh
    ibmcloud ks worker-pools -c CLUSTER
    ```
    {: pre}

1. Specify the new Ubuntu version for the worker pool. 

    ```sh
    ibmcloud ks worker-pool operating-system set --cluster CLUSTER --worker-pool POOL --operating-system UBUNTU_24_64
    ```
    {: pre}

1. Update each worker node in the worker pool by running the [`ibmcloud ks worker update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) or [`ibmcloud ks worker replace`](h/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_replace) command. 

    Make sure you have enough worker nodes to support your workload while you update or replace the relevant worker nodes. For more information, see [Updating VPC worker nodes](/docs/containers?topic=containers-update&interface=ui#vpc_worker_node) or [Updating classic worker nodes](/docs/containers?topic=containers-update&interface=ui#worker_node).
    {: tip}

    ```sh
    ibmcloud ks worker update --cluster CLUSTER --worker WORKER1_ID [--worker WORKER2_ID] 
    ```
    {: pre}

    ```sh
    ibmcloud ks worker replace --cluster CLUSTER --worker WORKER_ID
    ```
    {: pre}

1. Get the details for your worker pool and workers. In the output, verify that your worker nodes run the new Ubuntu version.

    Get the details for a worker pool. 
    ```sh
    ibmcloud ks worker-pools -c CLUSTER
    ```
    {: pre}

    Get the details for a worker node. 
    ```sh
    ibmcloud ks worker get --cluster CLUSTER --worker WORKER_NODE_ID 
    ```
    {: pre}
