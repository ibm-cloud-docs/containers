---

copyright: 
  years: 2014, 2023
lastupdated: "2023-05-03"

keywords: portworx, kubernetes

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Preparing your cluster for Portworx
{: #storage-portworx-preparing}

If you want to build your Portworx storage layer on non-SDS worker nodes in your classic cluster must add raw, unformatted, and unmounted block storage to your worker nodes first. For VPC clusters, you can either attach storage before installing Portworx or allow Portworx to dynamically create Cloud Drives by using the {{site.data.keyword.block_storage_is_short}} driver during installation.
{: shortdesc}

Raw block storage can't be provisioned by using Kubernetes persistent volume claims (PVCs) as the block storage device is automatically formatted by {{site.data.keyword.containerlong_notm}}. Instead, you can use the {{site.data.keyword.cloud_notm}} Block Volume Attacher plug-in in classic clusters or the VPC console, CLI, or API in VPC clusters to add block storage to your worker nodes.

Portworx supports block storage only. Worker nodes that mount file or object storage can't be used for the Portworx storage layer.
{: note}

Keep in mind that the networking of non-SDS worker nodes in classic clusters is not optimized for Portworx and might not offer the performance benefits that your app requires.
{: note}

### Classic clusters
{: #px-create-classic-volumes}

1. [Install the {{site.data.keyword.cloud_notm}} Block Volume Attacher plug-in](/docs/containers?topic=containers-utilities#block_storage_attacher).
2. [Manually add block storage](/docs/containers?topic=containers-utilities#manual_block) to your worker nodes. For highly available data storage, Portworx requires at least 3 worker nodes with raw and unformatted block storage.
3. If you want to use [journal devices](https://docs.portworx.com/install-with-other/operate-and-maintain/performance-and-tuning/tuning/){: external}, choose from the following options.
    - Attach an additional disk to at least 3 worker nodes to use for the journal. [Manually add](/docs/containers?topic=containers-utilities#manual_block) a 3 GB block storage device to a worker node in your cluster and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
    - Select one of the block storage devices that you added earlier to use for the journal and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
    - Let Portworx automatically create a journal partition during installation.
4. If you want to use a specific device for the internal Portworx key value database (KVDB), choose from the following options.
    - Attach an additional disk to at least 3 worker nodes to use for key value database (KVDB). [Manually add](/docs/containers?topic=containers-utilities#manual_block) a 3 GB block storage device to at least 3 worker nodes in your cluster and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
    - Select one of the block storage devices that you added earlier and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
5. [Attach the block storage](/docs/containers?topic=containers-utilities#attach_block) to your worker nodes.
6. Continue with your Portworx setup by [Setting up a key-value store for Portworx metadata](#portworx_database).

### VPC clusters
{: #px-create-vpc-volumes}

1. Follow the [steps](/docs/containers?topic=containers-utilities#vpc_cli_attach) to create the {{site.data.keyword.block_storage_is_short}} instances and attach these to each worker node that you want to add to the Portworx storage layer. For highly available data storage, Portworx requires at least 3 worker nodes with raw and unformatted block storage.
2. If you want to use [journal devices](https://docs.portworx.com/install-with-other/operate-and-maintain/performance-and-tuning/tuning/){: external}, choose from the following options.
    - [Attach](/docs/containers?topic=containers-utilities#vpc_cli_attach) an additional 3 GB disk to at least 3 worker nodes in your cluster and find the device path. To find the device path after you attach the disk, log in to your worker node and run `lsblk` to list the devices on that node.
    - Select a device on a worker node where you want Portworx to create the journal.
3. If you want to use a specific device for the internal Portworx KVDB, choose from the following options.
    - Attach an additional disk to at least 3 worker nodes use for the KVDB. [Manually add](/docs/containers?topic=containers-utilities#manual_block) a 3 GB block storage device to at least 3 worker nodes in your cluster and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
    - Select one of the block storage devices that you added earlier to use for the KVDB and find the device path. To find the device path after attaching the disk, log in to your worker node and run `lsblk` to list the devices on that node.
4. Continue with your Portworx setup by [Setting up a key-value store for Portworx metadata](#portworx_database).





## Private only clusters: Copying the `ImagePullSecret` to the `kube-system` namespace from the Kubernetes dashboard
{: #vpc-image-pull-px}

To enable Portworx to pull container images from {{site.data.keyword.registryshort}} to the `kube-system` namespace in your cluster, you must copy the `all-icr-io` secret from the `default` namespace to the `kube-system` namespace. You must also add the `all-icr-io` secret to the default service account in the `kube-system` namespace.
{: shortdesc}


1. From the [**Cluster Overview** page](https://cloud.ibm.com/kubernetes/clusters){: external}, select the cluster where you want to install Portworx and open the **Kubernetes dashboard**.
2. In the Kubernetes dashboard, make sure the `default` namespace is selected.
3. In the **Config and Storage** section of the navigation, click **Secrets**. Then click the `all-icr-io` secret.
4. On the **Secret** page, click **Edit resource**.
5. In the **Edit a resource** window, copy the YAML configuration and then, click **Cancel**
6. In the namespace menu, select the `kube-system` namespace.
7. Click **Create new resource** and paste the YAML configuration that you copied earlier.
8. Edit the YAML to specify the `kube-system` namespace and remove the `resourceVersion` value. Review the following YAML configuration.
    ```yaml
    metadata:
       name: all-icr-io
       namespace: kube-system
       uid: aa111111-11a1-1a1a-11a1-a111a1111a11
       resourceVersion: ''
    ```
    {: screen}

9. Click **Upload**.
10. In the **Cluster** section of the navigation, click **Service Accounts**.
11. Select the `default` service account. Note that you might need to navigate to the next page.
12. Click **Edit resource** and add the `all-icr-io` secret, similar to the following example.
    ```yaml
    secrets:
       - name: default-token-l5hcm
       - name: all-icr-io
    ```
    {: screen}

13. Click **Update**
14. [Install Portworx in your cluster](#install_portworx)








