---

copyright:
  years: 2022, 2023
lastupdated: "2023-04-17"

keywords: ubuntu, operating system, migrate, ubuntu version, worker nodes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Migrating to a new Ubuntu version
{: #ubuntu-migrate}

To migrate your worker nodes to a new Ubuntu version, you must provision a new worker pool. Then, add worker nodes to the new pool and remove the original worker pool.
{: shortdesc}

At the end of February 2023, Ubuntu 20 becomes the default operating system for all supported {{site.data.keyword.containerlong_notm}} cluster versions. Ubuntu 18 becomes unsupported on 30 April 2023. To avoid disruptions to your workload, migrate your worker nodes from Ubuntu 18 to Ubuntu 20 as soon as possible.
{: note}

With the release of Ubuntu 20, some worker node flavors are deprecated. If you have worker nodes with these flavors, you must provision worker nodes with a new flavor during the migration process. The deprecated flavors are: `mb3c.4x32, mb3c.16x64, ms3c.4x32.1.9tb.ssd, ms3c.16x64.1.9tb.ssd, ms3c.28x256.3.8tb.ssd, ms3c.28x512.4x3.8tb.ssd, mr3c.28x512, md3c.16x64.4x4tb, md3c.28x512.4x4tb, mg3c.16x128, mg3c.28x256`.
{: important}

To find your worker node operating system, run the **`ibmcloud oc worker-pools -c CLUSTER`** command.
{: tip}

For more information about creating worker pools and adding worker nodes, see [Adding worker nodes in classic clusters](/docs/containers?topic=containers-add_workers) or [Adding worker nodes in VPC clusters](/docs/containers?topic=containers-add_workers#vpc_pools).

## Migration steps
{: #ubuntu-migrate-steps}

Migrate your worker nodes to use Ubuntu 20. These steps apply to all supported cluster versions.
{: shortdesc}

1. In your cluster, create a new worker pool for the Ubuntu 20 worker nodes. Include the `--operating-system=UBUNTU_20_64` option. Make sure that the number of nodes specified with the `--size-per-zone` option matches the number of Ubuntu 18 worker nodes that you are replacing.

    **For classic clusters**. See the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_create) for command details.

    ```sh
    ibmcloud ks worker-pool create classic --name <worker_pool_name> --cluster <cluster_name_or_ID> --flavor <flavor> --operating-system UBUNTU_20_64 --size-per-zone <number_of_workers_per_zone> 
    ```
    {: pre}

    **For VPC clusters**. See the [CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_pool_create_vpc_gen2) for command details.

    ```sh
    ibmcloud ks worker-pool create vpc-gen2 --name <worker_pool_name> --cluster <cluster_name_or_ID> --flavor <flavor> --operating-system UBUNTU_20_64 --size-per-zone <number_of_workers_per_zone> 
    ```
    {: pre}

1. Verify that the worker pool is created.

    ```sh
    ibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

1. Add a zone to your worker pool. When you add a zone, the number of worker nodes you specified with the `--size-per-zone` option are added to the zone. These worker nodes run the Ubuntu 20 operating system. 
    * [Adding a zone to a worker pool in a classic cluster](/docs/containers?topic=containers-add_workers#add_zone)
    * [Adding a zone to a worker pool in a VPC cluster](/docs/containers?topic=containers-add_workers#vpc_add_zone)

1. Verify that worker nodes are available in your new worker pool. In the output, find the listing for the new worker pool and check the number in the **Workers** column.
    ```sh
    ibmcloud ks worker-pool ls --cluster <cluster_name_or-ID>
    ```
    {: pre}

1. [Remove the worker pool](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_rm) that contains the Ubuntu 18 worker nodes. 

    Consider scaling down your Ubuntu 18 worker pool and keeping it for several days before you remove it. This way, you can scale the worker pool back up if your workload experiences disruptions during the migration process. When you have determined that your workload is stable and functions normally, you can remove the Ubuntu 18 worker pool.
    {: important}

    1. List your worker pools and note the name of the worker pool you want to remove.
        ```sh
        ibmcloud ks worker-pool ls --cluster <cluster_name>
        ```
        {: pre}

    1. Run the command to remove the worker pool.
        ```sh
        ibmcloud ks worker-pool rm --worker-pool <worker_pool_name> --cluster <cluster_name>
        ```
        {: pre}



