---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-12"


keywords: portworx, kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Backing up and restoring apps and data with Portworx Backup
{: #storage_portworx_backup}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

Portworx Backup is a Portworx proprietary backup solution that is compatible with any {{site.data.keyword.containerlong_notm}} cluster. You can use Portworx Backup to back up and restore {{site.data.keyword.containerlong_notm}} resources, apps and data across multiple clusters. For more information on Portworx Backup, see [Understanding Portworx Backup](https://portworx.com/products/portworx-backup){: external}.
{: shortdesc}

To back up the data in your persistent volumes, you must have a storage class that supports snapshots in your cluster. Clusters with Portworx Enterprise have storage classes available that support snapshots by default. However, for clusters that don't have Portworx Enterprise, you must have a storage classes with snapshot support to back up your persistent volume data. The {{site.data.keyword.blockstorageshort}} driver, and the {{site.data.keyword.filestorage_short}} driver don't have storage classes that support snapshots. If you have workloads that use these drivers, you can use Portworx Backup to back up your apps, but not the data in the persistent volumes. For more information see [Backing up and restoring cluster data with Portworx Backup](#px-backup-and-restore).

Consider using Portworx Enterprise which provides options to have 3 replicas of your data in the cluster spread across multiple zones. In case of zonal storage failures, Portworx recommends using PX enterprise to get benefit of this feature. This helps ensure availability at data level in addition to application level availability.
{: tip}


Portworx Backup is not supported for {{site.data.keyword.satelliteshort}} clusters.
{: note}

## Installing Portworx Backup
{: #px-backup-install}

Before you begin:
- Make sure that your cluster meets the [minimum Portworx requirements](https://docs.portworx.com/portworx-enterprise/platform/prerequisites){: external}. 
- [Install or update the {{site.data.keyword.cloud_notm}} Block Storage plug-in in your cluster](/docs/containers?topic=containers-block_storage#install_block).
- Provision and attach 320Gi of block storage to your cluster. See [Setting {{site.data.keyword.cloud_notm}} Block Storage](/docs/containers?topic=containers-block_storage) or [Setting up Block Storage for VPC](/docs/containers?topic=containers-vpc-block).




1. Open the Portworx Backup service from the [{{site.data.keyword.cloud_notm}} catalog](https://cloud.ibm.com/catalog/services/px-backup-for-kubernetes){: external}.
2. Select the same location where the  cluster you want to install Portworx Backup on is located. You can find the location of your cluster from the {{site.data.keyword.containerlong_notm}} dashboard.
3. Enter the name for your Portworx Backup service in the **Service name** field.
4. Select the resource group where you want to create the Portworx Backup service.
5. In the **Tag** field, enter the name of the cluster where you want to install PX-Backup. After you complete the installation, you can't see the name of the cluster where you installed PX-Backup. To find the cluster more easily later, make sure that you enter the cluster name and any additional information as tags.
6. Enter your {{site.data.keyword.cloud_notm}} API key. After you enter the API key, the **Kubernetes or OpenShift cluster name** field appears. If you don't have an {{site.data.keyword.cloud_notm}} API key, see [Creating an API key](/docs/account?topic=account-userapikey&interface=ui#create_user_key) to create one.
7. In the **Kubernetes or OpenShift cluster name** field, select the cluster where you want to install PX-Backup.
8. Enter the name of the Kubernetes namespace where you want to install your Portworx Backup service components. Do not use the `kube-system` or `default` namespace. If the Kubernetes namespace that you enter does not already exist in your cluster, it is automatically created during the installation.
9. Select an existing storage class in your cluster to provision persistent volumes for the Portworx Backup service. The service uses this storage to store service metadata and is not used to back up your apps and data. [Your apps and data are backed up to an {{site.data.keyword.cos_full_notm}} service instance](#px-backup-storage).
10. Click **Create** to begin the Portworx Backup installation. The installation might take a few minutes to complete.
11. [Verify that your Portworx Backup service is installed correctly](#px-backup-verify).


## Verifying your Portworx Backup installation
{: #px-backup-verify}

Verify that Portworx Backup is correctly installed on your cluster.
{: shortdesc}

1. From the {{site.data.keyword.cloud_notm}} [Resource list](https://cloud.ibm.com/resources){: external}, find the Portworx Backup service that you created.
1. Review the **Status** column to see if the installation succeeded or failed. The status might take a few minutes to update.
1. If the status changes to **Active**, verify that the Portworx Backup pods, services and jobs are running in your cluster.
    1. From the {{site.data.keyword.cloud_notm}} [Resource list](https://cloud.ibm.com/resources){: external}, select the cluster where you installed PX-Backup.
    1. Open the Kubernetes dashboard.
    1. Select the namespace where you installed the Portworx Backup service components.
    1. Find the **Pods** table.
    1. Verify that the **Status** of all pods is **Running**.
    1. Click **Services**.
    1. Find the **px-backup-ui** service and verify that a URL is present in the **External Endpoints** column.
    1. Click **Jobs**.
    1. Find the **pxcentral-post-install-hook** job and verify that it is complete.

From the CLI

1. From the {{site.data.keyword.cloud_notm}} [Resource list](https://cloud.ibm.com/resources){: external}, find the Portworx Backup service you created.
2. Review the **Status** column to see if the installation succeeded or failed. The status might take a few minutes to update.
3. If the status changes to **Active**, verify that the Portworx Backup pods are running in your cluster.
    1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
    2. Run the command to verify that the installation has completed.
        ```sh
        kubectl get po -n <px_backup_namespace> -ljob-name=pxcentral-post-install-hook  -o wide | awk '{print $1   $3}' | grep -iv error
        ```
        {: pre}

        Example output
        ```sh
        NAMESTATUS
        pxcentral-post-install-hook-5b86qCompleted
        ```
        {: screen}


## Logging in to the Portworx Backup console
{: #px-backup-ui}

Access the Portworx Backup console through the URL supplied in the {{site.data.keyword.containerlong_notm}} dashboard for the cluster where you installed the service.
{: shortdesc}

For VPC clusters

1. From the {{site.data.keyword.cloud_notm}} [Resource list](https://cloud.ibm.com/resources){: external}, select the cluster where you installed PX-Backup.
1. Open the Kubernetes dashboard.
1. Select the namespace where you installed the Portworx Backup service components.
1. In the **Services** section, find the **px-backup-ui** service and locate the URL in the **Public Endpoints** column. Click this URL to open the Portworx Backup console.
1. Log in to the Portworx Backup console. If you are the first user to access the console, you must log in in with the username `admin` and the password `admin`. You are redirected to a registration page to set a unique username and password. Subsequent users must register a new account to access the console.


For public classic clusters

1. From the {{site.data.keyword.cloud_notm}} [Resource list](https://cloud.ibm.com/resources){: external}, select the cluster where you installed PX-Backup.
1. Open the Kubernetes dashboard.
1. Select the namespace where you installed the Portworx Backup service components.
1. In the **Services** section, find the **px-backup-ui** service and note the IP address and node port under **External Endpoints**.
1. Copy and paste the IP address and node port into your web browser to open the Portworx Backup console.
1. Log in to the Portworx Backup console. If you are the first user to access the console, you must log in in with the username `admin` and the password `admin`. You are redirected to a registration page to set a unique username and password. Subsequent users must register a new account to access the console.


For private classic clusters, [expose the **px-backup-ui** service on your private cluster to access the Portworx Backup console](/docs/containers?topic=containers-managed-ingress-setup).
{: note}

## Adding a backup location to your Portworx Backup service
{: #px-backup-storage}

Create an {{site.data.keyword.cos_full_notm}} instance and bucket, and add them as a backup location to your Portworx Backup service.
{: shortdesc}

Before you begin, [log in to the Portworx Backup console](#px-backup-ui). Note that if you are the first user to access the console, you must login in with the username `admin` and the password `admin`. You are redirected to a registration page to set a unique username and password. Subsequent users must register a new account to access the console.

1. [Create your {{site.data.keyword.cos_full_notm}} service instance](/docs/containers?topic=containers-storage-cos-understand#create_cos_service).
2. [Create service credentials for your {{site.data.keyword.cos_full_notm}} service instance](/docs/containers?topic=containers-storage-cos-understand#create_cos_secret). Be sure to enable HMAC authentication by clicking **Advanced Options** in the **Create credential** dialog box and switching the **Include HMAC Credential** parameter to **On**.
3. Expand your credentials in the service credentials table. Note the **`access_key_id`** and the **`secret_access_key`** in the **`cos_hmac_keys`** section.
4. [Create a storage bucket in your {{site.data.keyword.cos_full_notm}} instance](/docs/cloud-object-storage?topic=cloud-object-storage-getting-started-cloud-object-storage).
5. Click your bucket and note its location.
6. Open the bucket configuration page and note the endpoint that you must use to connect to your {{site.data.keyword.cos_full_notm}} instance.
    - If you installed Portworx Backup on a private classic cluster, note the **private** endpoint.
    - If you installed Portworx Backup on a private VPC cluster, note the **direct** endpoint.
    - For all other cluster types, note the **public** endpoint.
7. In the Portworx Backup console, click **Backups**.
8. Click **Settings>Cloud Settings**.
9. Create a cloud account to specify your {{site.data.keyword.cos_full_notm}} instance as the backup location where your data and apps are stored.
    1. For the cloud provider, choose **AWS / S3 Compliant Object Store**.
    2. Enter a name for your cloud account.
    3. Enter the **`access_key_id`** that you retrieved earlier.
    4. Enter the **`secret_access_key`** that you retrieved earlier.
    5. Click **Add+** and return to the **Cloud Settings** page.
10. In the **Backup Locations** section, add your {{site.data.keyword.cos_full_notm}} bucket as the backup location for your Portworx Backup service.
    1. Enter a name for your backup location.
    2. Select the cloud account that you created earlier.
    3. In the **Path/Bucket** field, enter the name of your bucket.
    4. In the **Region** field, enter the location of your bucket that you retrieved earlier.
    5. In the **Endpoint** field, enter the endpoint for your bucket that you retrieved earlier.
    6. Click **Add+** to create the backup location.

## Adding {{site.data.keyword.containerlong_notm}} clusters to your Portworx Backup service
{: #px-backup-cluster}

Add the {{site.data.keyword.containerlong_notm}} cluster that you want to back up with PX-Backup. You can select any cluster in your account, including the cluster where you installed PX-Backup.
{: shortdesc}

Before you begin:
- [Log in to the Portworx Backup console](#px-backup-ui).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

The `kubeconfig` in clusters with Portworx Backup expires after 24 hours. To prevent your cluster's `kubeconfig` file from expiring, set the context with your cluster using the `--admin` option.

`ibmcloud ks cluster config --cluster <cluster_name> --admin --endpoint private`
{: tip}

Adding a cluster:

1. In the Portworx Backup console, click **Backups**.
2. Click **Add Cluster**.
3. Enter the name of the cluster that you want to back up.
4. In the CLI, get the `kubeconfig` file output for your cluster. Make sure that you have set the context to your cluster with the `--admin` option to prevent the `kubeconfig` from expiring.
    ```sh
    kubectl config view --flatten --minify
    ```
    {: pre}

5. Copy the entire `kubeconfig` CLI output and paste it into the **`Kubeconfig`** field in the Portworx Backup console.
6. Select **Others** as your **Kubernetes Service**.
7. If the cluster that you want to add to the Portworx Backup service does not have Portworx installed in it, [you must install Stork onto the cluster](#px-backup-stork). If you installed Portworx Enterprise in your cluster, Stork is installed by default.
8. Click **Submit**. If your cluster is successfully added, you are redirected to the **Backups** page. Make sure that your cluster is listed.
9. [Back up data from your cluster](#px-backup-and-restore).
10. Repeat these steps to add more clusters to your Portworx Backup service.

## Installing Stork on a non-Portworx cluster
{: #px-backup-stork}

If a cluster that you want to back up with Portworx Backup does not have Portworx Enterprise installed on it, you must install Stork on to the cluster before adding it to your Portworx Backup service.
{: shortdesc}

1. From the **Add Cluster** page in the Portworx Backup console, copy the command to install Stork on a **Non-PX** cluster.
2. Open a text editor and paste the command.
3. Copy the URL in the command and enter it in to your web browser to open the YAML file for the Stork installation.
4. Copy and paste the entire YAML file into a new file in your text editor.
5. If the cluster you want to add is a private cluster, find the **image** field and replace `openstorage/stork:<version_number>` with `icr.io/ext/portworx/stork:<version_numer>`. To find the latest available version of Stork, see the [Stork releases](https://github.com/libopenstorage/stork/releases){: external}.
    ```sh
    - --health-monitor-interval=120
    - --webhook-controller=false
    image: openstore/stork:2.6.2
    imagePullPolicy:Always
    resources:
      requests:
         cpu: '0.1'
      name: stork
   serviceAccountName: stork-account  
    ```
    {: screen}

6. Save the file and run the command to apply the file to your cluster and install Stork.
    ```sh
    kubectl apply -f <file_name>.yaml
    ```
    {: pre}

7. Verify that Stork is successfully installed on your cluster and that all pods are running.
    ```sh
    kubectl get deployment -n kube-system | grep stork
    ```
    {: pre}

    Example output

    ```sh
    stork                3/3   3      3      7d20h
    ```
    {: screen}


## Creating a backup with the `kmpd` command
{: #px-kdmp}

1. [Install Portworx Backup in your cluster](#px-backup-install).
1. Edit the `kdmp-config` ConfigMap in the `kube-system` namespace of your cluster.
    ```sh
    kubectl edit cm kdmp-config -n kube-system
    ```
    {: pre}
    
1. Add the following parameter to the data section.
    ```sh
    BACKUP_TYPE: "Generic"
    ```
    {: pre}

1. Follow the [Portworx Backup documentation](https://docs.portworx.com/portworx-backup-on-prem/use-px-backup/backup-restore){: external} to create a backup.

## Backing up and restoring cluster data with PX-Backup
{: #px-backup-and-restore}


To back up data from your cluster or to restore data to your cluster, refer to the [Portworx Backup documentation](https://docs.portworx.com/portworx-backup-on-prem/use-px-backup/backup-restore){: external}.
{: shortdesc}

**Back up apps and data from your cluster to {{site.data.keyword.cos_full_notm}}**: 
You can back up an entire cluster namespace, single apps, and the data that is stored in your persistent volumes to the {{site.data.keyword.cos_full_notm}} service instance that you set up as your backup location. Note that to back up data in persistent volumes, you must have a CSI snapshot storage class in your cluster. Portworx Backup uses this storage class to first take a snapshot of your data and then sends this data to your {{site.data.keyword.cos_full_notm}} backup location. For more information, see the [Portworx Backup documentation](https://docs.portworx.com/portworx-backup-on-prem/use-px-backup/backup-restore){: external}.

**Restore any backup that you created to another cluster**: 
You can restore an entire namespace, your apps, or your data to any cluster that you added to the Portworx Backup service. Use this Portworx Backup capability if you want to migrate apps and data from one cluster to another. For more information, see the [Portworx Backup documentation](https://docs.portworx.com/portworx-backup-on-prem/use-px-backup/backup-restore){: external}.

### Upgrading PX-Backup
{: #px-backup-upgrade}

Follow the Portworx documentation to [upgrade PX-backup](https://docs.portworx.com/portworx-backup-on-prem/use-px-backup){: external}
{: shortdesc}
