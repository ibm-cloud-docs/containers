---

copyright:
  years: 2022, 2025
lastupdated: "2025-08-11"


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

Ubuntu 24 is the default operating system for all supported cluster versions. A worker pool's operating system does not automatically change when you upgrade a cluster.

## Ubuntu 24 limitations
{: #ubuntu-24-lim}

- For Ubuntu 24, the `/tmp` directory is a separate partition that has the `nosuid`, `noexec`, and `nodev` options set. If your apps install to and run scripts or binaries under the `/tmp` directory, they might fail. You can use the `/var/tmp` directory instead of the `/tmp` directory to run temporary scripts or binaries.

- The default `cgroup` implementation is `cgroup` v2. In Ubuntu 24, `cgroup` v1 is not supported. Review the [Kubernetes migration documentation for `cgroup` v2](https://kubernetes.io/docs/concepts/architecture/cgroups/#migrating-to-cgroup-v2){: external} and verify that your applications fully support `cgroup` v2. There are known issues with older versions of Java that might cause out of memory (OOM) issues for workloads.

- Note that with Ubuntu 24, NTP uses `timesyncd` and related commands might be updated.


## Migration steps
{: #ubuntu-migrate-steps}

Migrate your worker nodes to use Ubuntu 24. These steps apply to all supported cluster versions.
{: shortdesc}


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

1. Update each worker node in the worker pool.

    Make sure you have enough worker nodes to support your workload while you update or replace the relevant worker nodes. For more information, see [Updating VPC worker nodes](/docs/containers?topic=containers-update&interface=ui#vpc_worker_node) or [Updating classic worker nodes](/docs/containers?topic=containers-update&interface=ui#worker_node).
    {: tip}

    **Classic worker nodes.**
    ```sh
    ibmcloud ks worker update --cluster CLUSTER --worker WORKER1_ID [--worker WORKER2_ID] 
    ```
    {: pre}

    **VPC worker nodes.**
    ```sh
    ibmcloud ks worker replace --cluster CLUSTER --worker WORKER_ID --update
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

1. If you use the Object Storage plug-in, you must uninstall and reinstall it in your cluster after migrating to a new Ubuntu version. If you don't complete this step, then the Object Storage driver pods can't run in the cluster which leads to not being able to provision or mount volumes.

    1. [Follow the steps to uninstall the Object Storage plug-in](/docs/openshift?topic=openshift-storage_cos_install#remove_cos_plugin).

    1. [Reinstall the plug-in](/docs/openshift?topic=openshift-storage_cos_install#remove_cos_plugin).



    
