---

copyright:
  years: 2014, 2018
lastupdated: "2018-06-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Saving data in your cluster
{: #storage}
You can persist data in {{site.data.keyword.containerlong}} to share data between app instances and to protect your data from being lost if a component in your Kubernetes cluster fails.


## Planning highly available storage
{: #planning}

In {{site.data.keyword.containerlong_notm}}, you can choose from several options to store your app data and share data across pods in your cluster. However, not all storage options offer the same level of persistence and availability in situations where a component in your cluster or a whole site fails.
{: shortdesc}


### Non-persistent data storage options
{: #non_persistent}

You can use non-persistent storage options if your data is not required to be persistently stored or if data does not need to be shared across app instances. Non-persistent storage options can also be used to unit-test your app components or try out new features.
{: shortdesc}

The following image shows available non-persistent data storage options in {{site.data.keyword.containerlong_notm}}. These options are available for free and standard clusters.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Non-persistent data storage options" width="500" style="width: 500px; border-style: none"/></p>

<table summary="The table shows non-persistent storage options. Rows are to be read from the left to right, with the number of the option in column one, the title of the option in column two, and a description in column three." style="width: 100%">
<caption>Non-persistent storage options</caption>
  <thead>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td>1. Inside the container or pod</td>
      <td>Containers and pods are, by design, short-lived and can fail unexpectedly. However, you can write data to the local file system of the container to store data throughout the lifecycle of the container. Data inside a container cannot be shared with other containers or pods and is lost when the container crashes or is removed. For more information, see [Storing data in a container](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. On the worker node</td>
    <td>Every worker node is set up with primary and secondary storage that is determined by the machine type that you select for your worker node. The primary storage is used to store data from the operating system and can be accessed by using a [Kubernetes <code>hostPath</code> volume ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath). The secondary storage is used to store data from the `kubelet` and the container runtime engine. You can access the secondary storage by using a [Kubernetes <code>emptyDir</code> volume ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>While <code>hostPath</code> volumes are used to mount files from the worker node file system to your pod, <code>emptyDir</code> creates an empty directory that is assigned to a pod in your cluster. All containers in that pod can read from and write to that volume. Because the volume is assigned to one specific pod, data cannot be shared with other pods in a replica set.<br/><br/><p>A <code>hostPath</code> or <code>emptyDir</code> volume and its data are removed when: <ul><li>The worker node is deleted.</li><li>The worker node is reloaded or updated.</li><li>The cluster is deleted.</li><li>The {{site.data.keyword.Bluemix_notm}} account reaches a suspended state. </li></ul></p><p>In addition, data in an <code>emptyDir</code> volume is removed when: <ul><li>The assigned pod is permanently deleted from the worker node.</li><li>The assigned pod is scheduled on another worker node.</li></ul></p><p><strong>Note:</strong> If the container inside the pod crashes, the data in the volume is still available on the worker node.</p></td>
    </tr>
    </tbody>
    </table>


### Persistent data storage options for high availability
{: #persistent}

The main challenge when you create highly available stateful apps is to persist data across multiple app instances in multiple locations, and to keep data in sync always. For highly available data, you want to make sure that you have a master database with multiple instances that are spread across multiple data centers or even multiple regions. This master database must continuously be replicated to keep a single source of truth. All instances in your cluster must read from and write to this master database. In case one instance of the master is down, other instances take over the workload so that you do not experience downtime for your apps.
{: shortdesc}

The following image shows the options that you have in {{site.data.keyword.containerlong_notm}} to make your data highly available in a standard cluster. The option that is right for you depends on the following factors:
  * **The type of app that you have:** For example, you might have an app that must store data on a file basis rather than inside a database.
  * **Legal requirements for where to store and route the data:** For example, you might be obligated to store and route data in the United States only and you cannot use a service that is located in Europe.
  * **Backup and restore options:** Every storage option comes with capabilities to back up and restore data. Check that available backup and restore options meet the requirements of your disaster recovery plan, such as the frequency of backups or the capabilities of storing data outside your primary data center.
  * **Global replication:** For high availability, you might want to set up multiple storage instances that are distributed and replicated across data centers worldwide.

<br/>
<img src="images/cs_storage_ha.png" alt="High availability options for persistent storage"/>


<table summary="The table shows persistent storage options. Rows are to be read from the left to right, with the number of the option in column one, the title of the otion in column two and a description in column three.">
<caption>Persistent storage options</caption>
  <thead>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS file storage or block storage</td>
  <td>With this option, you can persist app and container data by using Kubernetes persistent volumes. Volumes are hosted on Endurance and Performance [NFS-based file storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/file-storage/details) or [block storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage) that can be used for apps that store data on a file basis or as a block rather than in a database. Data that is saved in file and block storage is encrypted at rest.<p>{{site.data.keyword.containershort_notm}} provides predefined storage classes that define the range of sizes of the storage, IOPS, the delete policy, and the read and write permissions for the volume. To initiate a request for file storage or block storage, you must create a [persistent volume claim (PVC)](cs_storage.html#create). After you submit a PVC, {{site.data.keyword.containershort_notm}} dynamically provisions a persistent volume that is hosted on NFS-based file storage or block storage. [You can mount the PVC](cs_storage.html#app_volume_mount) as a volume to your deployment to allow the containers to read from and write to the volume. </p><p>Persistent volumes are provisioned in the data center where the worker node is located. With NFS, you can share data with pods in the same  cluster. With block storage, you can mount the PV to only 1 pod on 1 worker node in the cluster.  </p><p>By default, NFS storage and block storage are not backed up automatically. You can set up a periodic backup for your cluster by using the provided [backup and restore mechanisms](cs_storage.html#backup_restore). When a container crashes or a pod is removed from a worker node, the data is not removed and can still be accessed by other deployments that mount the volume.</p><p><strong>Note:</strong> You can choose to be billed for persistent NFS file share storage and block storage hourly or monthly. If you choose monthly, when you remove the persistent storage, you still pay the monthly charge for it, even if you used it only for a short amount of time.</p></td>
  </tr>
  <tr id="cloud-db-service">
    <td>2. Cloud database service</td>
    <td>With this option, you can persist data by using an {{site.data.keyword.Bluemix_notm}} database cloud service, such as [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). Data that is stored with this option can be accessed across clusters, locations, and regions. <p> You can choose to configure a single database instance that all your apps access, or to [set up multiple instances across data centers and replication](/docs/services/Cloudant/guides/active-active.html) between the instances for higher availability. In IBM Cloudant NoSQL database, data is not backed up automatically. You can use the provided [backup and restore mechanisms](/docs/services/Cloudant/guides/backup-cookbook.html) to protect your data from a site failure.</p> <p> To use a service in your cluster, you must [bind the {{site.data.keyword.Bluemix_notm}} service](cs_integrations.html#adding_app) to a namespace in your cluster. When you bind the service to the cluster, a Kubernetes secret is created. The Kubernetes secret holds confidential information about the service, such as the URL to the service, your user name, and password. You can mount the secret as a secret volume to your pod and access the service by using the credentials in the secret. By mounting the secret volume to other pods, you can also share data between pods. When a container crashes or a pod is removed from a worker node, the data is not removed and can still be accessed by other pods that mount the secret volume. <p>Most {{site.data.keyword.Bluemix_notm}} database services provide disk space for a small amount of data at no cost, so you can test its features.</p></td>
  </tr>
  <tr>
    <td>3. On-prem database</td>
    <td>If your data must be stored onsite for legal reasons, you can [set up a VPN connection](cs_vpn.html#vpn) to your on-prem database and use existing storage, backup, and replication mechanisms in your data center.</td>
  </tr>
  </tbody>
  </table>

{: caption="Table. Persistent data storage options for deployments in Kubernetes clusters" caption-side="top"}

<br />



## Using existing NFS file shares in clusters
{: #existing}

If you have existing NFS file shares in your IBM Cloud infrastructure (SoftLayer) account that you want to use, you can do so by creating a persistent volume (PV) for your existing storage.
{:shortdesc}

A persistent volume (PV) is a Kubernetes resource that represents an actual storage device that is provisioned in a data center. Persistent volumes abstract the details of how a specific storage type is provisioned by {{site.data.keyword.Bluemix_notm}} Storage. To mount a PV to your cluster, you must request persistent storage for your pod by creating a persistent volume claim (PVC). The following diagram illustrates the relationship between PVs and PVCs.

![Create persistent volumes and persistent volume claims](images/cs_cluster_pv_pvc.png)

As depicted in the diagram, to enable existing NFS storage, you must create PVs with a certain size and access mode and create a PVC that matches the PV specification. If the PV and PVC match, they are bound to each other. Only bound PVCs can be used by the cluster user to mount the volume to a deployment. This process is referred to as static provisioning of persistent storage.

Before you begin, make sure that you have an existing NFS file share that you can use to create your PV. For example, if you previously [created a PVC with a `retain` storage class policy](#create), you can use that retained data in the existing NFS file share for this new PVC.

**Note:** Static provisioning of persistent storage applies to existing NFS file shares only. If you do not have existing NFS file shares, cluster users can use the [dynamic provisioning](cs_storage.html#create) process to add PVs.

To create a PV and matching PVC, follow these steps.

1.  In your IBM Cloud infrastructure (SoftLayer) account, look up the ID and path of the NFS file share where you want to create your PV object. In addition, authorize the file storage to the subnets in the cluster. This authorization gives your cluster access to the storage.
    1.  Log in to your IBM Cloud infrastructure (SoftLayer) account.
    2.  Click **Storage**.
    3.  Click **File Storage** and from the **Actions** menu, select **Authorize Host**.
    4.  Select **Subnets**.
    5.  From the drop-down list, select the private VLAN subnet that your worker node is connected to. To find the subnet of your worker node, run `ibmcloud cs workers <cluster_name>` and compare the `Private IP` of your worker node with the subnet that you found in the drop-down list.
    6.  Click **Submit**.
    6.  Click the name of the file storage.
    7.  Note the **Mount Point** field. The field is displayed as `<server>:/<path>`.
2.  Create a storage configuration file for your PV. Include the server and path from the file storage **Mount Point** field.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908/data01"
    ```
    {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Enter the name of the PV object to create.</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Enter the storage size of the existing NFS file share. The storage size must be written in gigabytes, for example, 20Gi (20 GB) or 1000Gi (1 TB), and the size must match the size of the existing file share.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Access modes define the way that the PVC can be mounted to a worker node.<ul><li>ReadWriteOnce (RWO): The PV can be mounted to deployments in a single worker node only. Containers in deployments that are mounted to this PV can read from and write to the volume.</li><li>ReadOnlyMany (ROX): The PV can be mounted to deployments that are hosted on multiple worker nodes. Deployments that are mounted to this PV can read from the volume only.</li><li>ReadWriteMany (RWX): This PV can be mounted to deployments that are hosted on multiple worker nodes. Deployments that are mounted to this PV can read from and write to the volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Enter the NFS file share server ID.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Enter the path to the NFS file share where you want to create the PV object.</td>
    </tr>
    </tbody></table>

3.  Create the PV object in your cluster.

    ```
    kubectl apply -f deploy/kube-config/mypv.yaml
    ```
    {: pre}

4.  Verify that the PV is created.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Create another configuration file to create your PVC. In order for the PVC to match the PV object that you created earlier, you must choose the same value for `storage` and `accessMode`. The `storage-class` field must be empty. If any of these fields do not match the PV, then a new PV is created automatically instead.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  Create your PVC.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Verify that your PVC is created and bound to the PV object. This process can take a few minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Example output:

    ```
    Name: mypvc
    Namespace: default
    StorageClass:	""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


You successfully created a PV object and bound it to a PVC. Cluster users can now [mount the PVC](#app_volume_mount) to their deployments and start reading from and writing to the PV object.

<br />



## Using existing block storage in your cluster
{: #existing_block}

Before you begin, make sure that you have an existing block storage instance that you can use to create your PV. For example, if you previously [created a PVC with a `retain` storage class policy](#create), you can use that retained data in the existing block storage for this new PVC.

**Note**: Block storage is a `ReadWriteOnce` access mode device. You can mount it to only one pod on one worker node in the cluster at a time.

To create a PV and matching PVC, follow these steps.

1.  Retrieve or generate an API key for your IBM Cloud infrastructure (SoftLayer) account.
    1. Log in to the [IBM Cloud infrastructure (SoftLayer) portal ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.bluemix.com/).
    2. Select **Account**, then **Users**, and then **User List**.
    3. Find your user ID.
    4. In the **API KEY** column, click **Generate** to generate an API key or **View** to view your existing API key.
2.  Retrieve the API user name for your IBM Cloud infrastructure (SoftLayer) account.
    1. From the **User List** menu, select your user ID.
    2. In the **API Access Information** section, find your **API Username**.
3.  Log in to the IBM Cloud infrastructure CLI plug-in.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Choose to authenticate by using the user name and API key for your IBM Cloud infrastructure (SoftLayer) account.
5.  Enter the user name and API key that you retrieved in the previous steps.
6.  List available block storage devices.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Example output:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Note the `id`, `ip_addr`, `capacity_gb`, and `lunId` of the block storage device that you want to mount to your cluster.
8.  Create a configuration file for your PV. Include the block storage ID, IP address, the size, and lun ID that you retrieved in the previous step.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Enter the name of the PV that you want to create.</td>
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Enter the file system type that is configured for your existing block storage. Choose between <code>ext4</code> or <code>xfs</code>. If you do not specify this option, the PV defaults to <code>ext4</code>. When the wrong fsType is defined, then the PV creation succeeds, but the mounting of the PV to a pod fails. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Enter the storage size of the existing block storage that you retrieved in the previous step as <code>capacity-gb</code>. The storage size must be written in gigabytes, for example, 20Gi (20 GB) or 1000Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Enter the lun ID for your block storage that you retrieved in the previous step as <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Enter the IP address of your block storage that you retrieved in the previous step as <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Enter the ID of your block storage that you retrieved in the previous step as <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Enter a name for your volume.</td>
	    </tr>
    </tbody></table>

9.  Create the PV in your cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

10. Verify that the PV is created.
    ```
    kubectl get pv
    ```
    {: pre}

11. Create another configuration file to create your PVC. In order for the PVC to match the PV that you created earlier, you must choose the same value for `storage` and `accessMode`. The `storage-class` field must be empty. If any of these fields do not match the PV, then a new PV is created automatically instead.

     ```
     kind: PersistentVolumeClaim
     apiVersion: v1
     metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "20Gi"
     ```
     {: codeblock}

12.  Create your PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

13.  Verify that your PVC is created and bound to the PV that you created earlier. This process can take a few minutes.
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     Example output:

     ```
     Name: mypvc
     Namespace: default
     StorageClass:	""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

You successfully created a PV and bound it to a PVC. Cluster users can now [mount the PVC](#app_volume_mount) to their deployments and start reading from and writing to the PV.

<br />



## Adding NFS file storage or block storage to apps
{: #create}

Create a persistent volume claim (PVC) to provision NFS file storage or block storage for your cluster. Then, mount this claim to a persistent volume (PV) to ensure that data is available even if the pods crash or shut down.
{:shortdesc}

The NFS file storage and block storage that backs the PV is clustered by IBM in order to provide high availability for your data. The storage classes describe the types of storage offerings available and define aspects such as the data retention policy, size in gigabytes, and IOPS when you create your PV.

**Note**: Block storage is a `ReadWriteOnce` access mode device. You can mount it to only one pod on one worker node in the cluster at a time. NFS file storage is a `ReadWriteMany` access mode, so you can mount it to multiple pods across workers within the cluster.

Before you begin:
- If you have a firewall, [allow egress access](cs_firewall.html#pvc) for the IBM Cloud infrastructure (SoftLayer) IP ranges of the locations that your clusters are in so that you can create PVCs.
- If you want to mount block storage to your apps, you must install the [{{site.data.keyword.Bluemix_notm}} Storage plug-in for block storage](#install_block) first.

To add persistent storage:

1.  Review the available storage classes. {{site.data.keyword.containerlong}} provides pre-defined storage classes for NFS file storage and block storage so that the cluster admin does not have to create any storage classes. The `ibmc-file-bronze` storage class is the same as the `default` storage class. By default, file storage is provisioned with an `nfs` file system, and block storage is provisioned with an `ext4` file system. If you want to provision block storage with an `XFS` file system, [create your own custom storage class](#custom_storageclass).

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-retain-bronze      ibm.io/ibmc-file
    ibmc-file-retain-custom      ibm.io/ibmc-file
    ibmc-file-retain-gold        ibm.io/ibmc-file
    ibmc-file-retain-silver      ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

    **Tip:** If you want to change the default storage class, run `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` and replace `<storageclass>` with the name of the storage class.

2.  Decide if you want to keep your data and the NFS file share or block storage after you delete the PVC.
    - If you want to keep your data, then choose a `retain` storage class. When you delete the PVC, only the PVC is deleted. The PV still exists in the cluster and the data in it is saved, but it cannot be reused with another PVC. Also, the NFS file or block storage and your data still exist in your IBM Cloud infrastructure (SoftLayer) account. Later, to access this data in your cluster, create a PVC and a matching PV that refers to your existing [NFS file](#existing) or [block](#existing_block) storage. 
    - If you want the PV, the data, and your NFS file share or block storage to be deleted when you delete the PVC, choose a storage class without `retain`.

3.  **If you choose a bronze, silver, or gold storage class**: You get [Endurance storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage) that defines the IOPS per GB for each class. However, you can determine the total IOPS by choosing a size within the available range. You can select any whole number of gigabyte sizes within the allowed size range (such as 20 Gi, 256 Gi, 11854 Gi). For example, if you select a 1000Gi file share or block storage size in the silver storage class of 4 IOPS per GB, your volume has a total of 4000 IOPS. The more IOPS your PV has, the faster it processes input and output operations. The following table describes the IOPS per gigabyte and size range for each storage class.

    <table>
         <caption>Table of storage class size ranges and IOPS per gigabyte</caption>
         <thead>
         <th>Storage class</th>
         <th>IOPS per gigabyte</th>
         <th>Size range in gigabytes</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze (default)</td>
         <td>2 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Silver</td>
         <td>4 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Gold</td>
         <td>10 IOPS/GB</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>

    <p>**Example command to show the details of a storage class**:</p>

    <pre class="pre"><code>kubectl describe storageclasses ibmc-file-silver</code></pre>

4.  **If you choose the custom storage class**: You get [Performance storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/performance-storage) and have more control over choosing the combination of IOPS and size. For example, if you select a size of 40Gi for your PVC, you can choose IOPS that is a multiple of 100 that is in the range of 100 - 2000 IOPS. The IOPS that you choose is static and does not scale with the size of the storage. If you choose 40Gi with 100 IOPS, your total IOPS remains 100. The following table shows you what range of IOPS you can choose depending on the size that you select.

    <table>
         <caption>Table of custom storage class size ranges and IOPS</caption>
         <thead>
         <th>Size range in gigabytes</th>
         <th>IOPS range in multiples of 100</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

    <p>**Example command to show the details for a custom storage class**:</p>

    <pre class="pre"><code>kubectl describe storageclasses ibmc-file-retain-custom</code></pre>

5.  Decide if you want to be billed on an hourly or monthly basis. By default, you are billed monthly.

6.  Create a configuration file to define your PVC and save the configuration as a `.yaml` file.

    -  **Example for bronze, silver, gold storage classes**:
       The following `.yaml` file creates a claim that is named `mypvc` of the `"ibmc-file-silver"` storage class, billed `"hourly"`, with a gigabyte size of `24Gi`. If you want to create a PVC to mount block storage to your cluster, make sure to enter `ReadWriteOnce` in the `accessModes` section.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Example for custom storage classes**:
       The following `.yaml` file creates a claim that is named `mypvc` of the storage class `ibmc-file-retain-custom`, billed at the default of `"monthly"`, with a gigabyte size of `45Gi` and IOPS of `"300"`. If you want to create a PVC to mount block storage to your cluster, make sure to enter `ReadWriteOnce` in the `accessModes` section.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
        <caption>Understanding the YAML file components</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Enter the name of the PVC.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Specify the storage class for the PV:
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS per GB.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS per GB.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS per GB.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: Multiple values of IOPS available.</li>
          <li>ibmc-block-bronze / ibmc-block-retain-bronze : 2 IOPS per GB.</li>
          <li>ibmc-block-silver / ibmc-block-retain-silver: 4 IOPS per GB.</li>
          <li>ibmc-block-gold / ibmc-block-retain-gold: 10 IOPS per GB.</li>
          <li>ibmc-block-custom / ibmc-block-retain-custom: Multiple values of IOPS available.</li></ul>
          <p>If you do not specify a storage class, the PV is created with the default storage class.</p><p>**Tip:** If you want to change the default storage class, run <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> and replace <code>&lt;storageclass&gt;</code> with the name of the storage class.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Specify the frequency for which your storage bill is calculated, "monthly" or "hourly". The default is "monthly".</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Enter the size of the file storage, in gigabytes (Gi). Choose a whole number within the allowable size range. </br></br><strong>Note: </strong> After your storage is provisioned, you cannot change the size of your NFS file share or block storage. Make sure to specify a size that matches the amount of data that you want to store. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>This option is for custom storage classes only (`ibmc-file-custom / ibmc-file-retain-custom / ibmc-block-custom / ibmc-block-retain-custom`). Specify the total IOPS for the storage, selecting a multiple of 100 within the allowable range. To see all options, run `kubectl describe storageclasses <storageclass>`. If you choose an IOPS other than one that is listed, the IOPS is rounded up.</td>
        </tr>
        </tbody></table>

    If you want to use a customized storage class, create your PVC with the corresponding storage class name, a valid IOPS and size.   
    {: tip}

7.  Create the PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

8.  Verify that your PVC is created and bound to the PV. This process can take a few minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Example output:

    ```
    Name:		mypvc
    Namespace:	default
    StorageClass:	""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

9.  {: #app_volume_mount}To mount the PVC to your deployment, create a configuration `.yaml` file.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>A label for the deployment.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>A label for your app.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>A label for the deployment.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>The name of the image that you want to use. To list available images in your {{site.data.keyword.registryshort_notm}} account, run `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>The name of the container that you want to deploy to your cluster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>The absolute path of the directory to where the volume is mounted inside the container.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>The name of the volume to mount to your pod.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>The name of the volume to mount to your pod. Typically this name is the same as <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>The name of the PVC that you want to use as your volume. When you mount the volume to the pod, Kubernetes identifies the PV that is bound to the PVC and enables the user to read from and write to the PV.</td>
    </tr>
    </tbody></table>

10.  Create the deployment and mount the PVC.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

11.  Verify that the volume is successfully mounted.

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     The mount point is in the **Volume Mounts** field and the volume is in the **Volumes** field.

     ```
      Volume Mounts:
           /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
           /volumemount from myvol (rw)
     ...
     Volumes:
       myvol:
         Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
         ClaimName:	mypvc
         ReadOnly:	false
     ```
     {: screen}

{: #nonroot}
{: #enabling_root_permission}

**NFS permissions**: Looking for documentation on enabling NFS non-root permissions? See [Adding non-root user access to NFS file storage](cs_troubleshoot_storage.html#nonroot).

<br />


## Customizing a storage class for XFS block storage
{: #custom_storageclass}

The storage classes that are pre-defined by {{site.data.keyword.containerlong}} provision block storage with an `ext4` file system by default. You can create a customized storage class to provision block storage with an `XFS` file system.
{: shortdesc}

Before you begin:
- [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure).
- Install the [{{site.data.keyword.Bluemix_notm}} Storage plug-in for block storage](#install_block).

To create a customized storage class:
1. Create a yaml file for your customized storage class.
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
     fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
   ```
   {: codeblock}

   If you want to keep the data after you remove block storage from your cluster, change the `reclaimPolicy` to `Retain`.
   {: tip}

2. Create the storage class in your cluster.
   ```
   kubectl apply -f <filepath/xfs_storageclass.yaml>
   ```
   {: pre}

3. Verify that the customized storage class was created.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Provision [XFS block storage](#create) with your customized storage class.

<br />


## Changing the default NFS file storage version
{: #nfs_version}

The version of the NFS file storage determines the protocol that is used to communicate with the NFS file storage server. By default, all file storage instances are set up with NFS version 4. You can change your existing PV to an older NFS version if your app requires a specific version to properly function.
{: shortdesc}

To change the default NFS version, you can either create a new storage class to dynamically provision file storage in your cluster, or choose to change an existing PV that is mounted to your pod.

To apply the latest security updates and for a better performance, use the default NFS version and do not change to an older NFS version.
{: tip}

**To create a customized storage class with the desired NFS version:**
1. Create a yaml file for your customized storage class. Replace <nfs_version> with the NFS version that you want to use. For example, to provision NFS version 3.0, enter **3.0**.
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-file-mount
     #annotations:
     #  storageclass.beta.kubernetes.io/is-default-class: "true"
     labels:
       kubernetes.io/cluster-service: "true"
   provisioner: ibm.io/ibmc-file
   parameters:
     type: "Endurance"
     iopsPerGB: "2"
     sizeRange: "[1-12000]Gi"
     reclaimPolicy: "Delete"
     classVersion: "2"
     mountOptions: nfsvers=<nfs_version>
   ```
   {: codeblock}

   If you want to keep the data after you remove block storage from your cluster, change the `reclaimPolicy` to `Retain`.
   {: tip}

2. Create the storage class in your cluster.
   ```
   kubectl apply -f <filepath/nfsversion_storageclass.yaml>
   ```
   {: pre}

3. Verify that the customized storage class was created.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Provision [file storage](#create) with your customized storage class.

**To change your existing PV to use a different NFS version:**

1. Get the PV of the file storage where you want to change the NFS version and note the name of the PV.
   ```
   kubectl get pv
   ```
   {: pre}

2. Add an annotation to your PV. Replace `<version_number>` with the NFS version that you want to use. For example to change to NFS version 3.0, enter **3**.  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. Delete the pod that uses the file storage and re-create the pod.
   1. Save the pod yaml to your local machine.
      ```
      kubect get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. Delete the pod.
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. Re-create the pod.
      ```
      kubectl apply -f <filepath/pod.yaml>
      ```
      {: pre}

4. Wait for the pod to deploy.
   ```
   kubectl get pods
   ```
   {: pre}

   The pod is fully deployed when the status changes to `Running`.

5. Log in to your pod.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Verify that the file storage was mounted with the NFS version that you specified earlier.
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   Example output:
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />




## Installing the IBM Cloud infrastructure (SoftLayer) CLI
{: #slcli}

Install the IBM Cloud infrastructure (SoftLayer) CLI to interact with your infrastructure resources such as NFS file and block storage instances.
{: shortdesc}

Before you begin, [install Python 3.6](https://www.python.org/downloads/).

1.  View the [installation docs ![External link icon](../icons/launch-glyph.svg "External link icon")](http://softlayer-api-python-client.readthedocs.io/en/latest/install/).

    1.  Click the link in the **Download the tarball** or **Download the zipball** steps. Do not use the `curl` command.
    2.  Find the downloaded package, unzip it, and navigate into the directory.
    3.  Install the CLI.

        ```
        python3 setup.py install
        ```
        {: pre}

2.  Get your IBM Cloud infrastructure (SoftLayer) API user name and API key.

    1.  From the [{{site.data.keyword.Bluemix_notm}} console](https://console.bluemix.net/), expand the menu and select **Infrastructure**.
    2.  From your profile in the menu bar, select the infrastructure account that you want to use.
    3.  Select **Account** > **Users** > **User List**.
    4.  From the **Users** table, in the **API KEY** column, click **View**. If you do not see an API key, click **Generate**.
    5.  Copy the user name and API key in the pop-up window.

3.  Configure the CLI to connect to your IBM Cloud infrastructure (SoftLayer) account.

    1.  Configure the IBM Cloud infrastructure (SoftLayer) CLI.
        ```
        slcli setup
        ```
        {: pre}

    2.  Fill in the required information.

        * **Username**: Enter the IBM Cloud infrastructure (SoftLayer) API user name that you previously retrieved.
        * **API Key or Password**: Enter the IBM Cloud infrastructure (SoftLayer) API key that you previously retrieved.
        * **Endpoint (public|private|custom) [public]**: Enter `https://api.softlayer.com/rest/v3.1`.
        * **Timeout [0]**: Enter a value in seconds for the CLI to wait for a response from the API. A value of `0` sets the CLI to wait forever.

        **Example**:

        ```
        $ slcli setup
        Username []: 1234567_user.name@example.com
        API Key or Password []:
        Endpoint (public|private|custom) [public]: https://api.softlayer.com/rest/v3.1
        Timeout [0]: 6000
        :..............:..................................................................:
        :         name : value                                                            :
        :..............:..................................................................:
        :     Username : 1234567_user.name@example.com                                    :
        :      API Key : 1111aa1111bbb22222b2b3c33333c3c3cc44d4444444444dd4444eee55e5e5e5 :
        : Endpoint URL : https://api.softlayer.com/xmlrpc/v3.1/                           :
        :      Timeout : 6000                                                             :
        :..............:..................................................................:
        Are you sure you want to write settings to "/Users/name/.softlayer"? [Y/n]: Y
        Configuration Updated Successfully
        ```
        {: screen}

You are now ready to use the IBM Cloud infrastructure (SoftLayer) CLI.

## Installing the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in on your cluster
{: #install_block}

Install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in with a Helm chart to set up pre-defined storage classes for block storage. You can use these storage classes to create a PVC to provision block storage for your apps.
{: shortdesc}

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster where you want to install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.

1. Install [Helm](cs_integrations.html#helm) on the cluster where you want to use the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.
2. Update the helm repo to retrieve the latest version of all helm charts in this repo.
   ```
   helm repo update
   ```
   {: pre}

3. Install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in. When you install the plug-in, pre-defined block storage classes are added to your cluster.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Verify that the installation was successful.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Example output:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   The installation is successful when you see one `ibmcloud-block-storage-plugin` pod and one or more `ibmcloud-block-storage-driver` pods. The number of `ibmcloud-block-storage-driver` equals the number of worker nodes in your cluster. All pods must be in a **Running** state.

5. Verify that the storage classes for block storage were added to your cluster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Example output:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Repeat these steps for every cluster where you want to provision block storage.

You can now continue to [create a PVC](#create) to provision block storage for your app.

<br />


### Updating the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in
You can upgrade the existing {{site.data.keyword.Bluemix_notm}} Block Storage plug-in to the latest version.
{: shortdesc}

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster.

1. Find the name of the block storage helm chart that you installed in your cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Upgrade the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in to the latest version.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

<br />


### Removing the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in
If you do not want to provision and use {{site.data.keyword.Bluemix_notm}} Block Storage for your cluster, you can uninstall the helm chart.
{: shortdesc}

**Note:** Removing the plug-in does not remove existing PVCs, PVs, or data. When you remove the plug-in, all the related pods and daemon sets are removed from your cluster. You cannot provision new block storage for your cluster or use existing block storage PVCs and PVs after you remove the plug-in.

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster and make sure that you do not have any PVCs or PVs in your cluster that use block storage.

1. Find the name of the block storage helm chart that you installed in your cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Delete the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Verify that the block storage pods are removed.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   The removal of the pods is successful if no pods are displayed in your CLI output.

4. Verify that the block storage storage classes are removed.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   The removal of the storage classes is successful if no storage classes are displayed in your CLI output.

<br />



## Setting up backup and restore solutions for NFS file shares and block storage
{: #backup_restore}

File shares and block storage are provisioned into the same location as your cluster. The storage is hosted on clustered servers by {{site.data.keyword.IBM_notm}} to provide availability in case a server goes down. However, file shares and block storage are not backed up automatically and might be inaccessible if the entire location fails. To protect your data from being lost or damaged, you can set up periodic backups that you can use to restore your data when needed.
{: shortdesc}

Review the following backup and restore options for your NFS file shares and block storage:

<dl>
  <dt>Set up periodic snapshots</dt>
  <dd><p>You can set up periodic snapshots for your NFS file share or block storage, which is a read-only image that captures the state of the instance at a point in time. To store the snapshot, you must request snapshot space on your NFS file share or block storage. Snapshots are stored on the existing storage instance within the same location. You can restore data from a snapshot if a user accidentally removes important data from the volume. </br></br> <strong>To create a snapshot for your volume: </strong><ol><li>List existing PVs in your cluster. <pre class="pre"><code>kubectl get pv</code></pre></li><li>Get the details for the PV for which you want to create snapshot space and note the volume ID, the size and the IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> For file storage, the volume ID, the size and the IOPS can be found in the <strong>Labels</strong> section of your CLI output. For block storage, the size and IOPS are shown in the <strong>Labels</strong> section of your CLI output. To find the volume ID, review the <code>ibm.io/network-storage-id</code> annotation of your CLI output. </li><li>Create the snapshot size for your existing volume with the parameters that you retrieved in the previous step. <pre class="pre"><code>slcli file snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre><pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Wait for the snapshot size to create. <pre class="pre"><code>slcli file volume-detail &lt;volume_id&gt;</code></pre><pre class="pre"><code>slcli block volume-detail &lt;volume_id&gt;</code></pre>The snapshot size is successfully provisioned when the <strong>Snapshot Capacity (GB)</strong> in your CLI output changes from 0 to the size that you ordered. </li><li>Create the snapshot for your volume and note the ID of the snapshot that is created for you. <pre class="pre"><code>slcli file snapshot-create &lt;volume_id&gt;</code></pre><pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>Verify that the snapshot is created successfully. <pre class="pre"><code>slcli file volume-detail &lt;snapshot_id&gt;</code></pre><pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>To restore data from a snapshot to an existing volume: </strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></br>For more information, see:<ul><li>[NFS periodic snapshots](/docs/infrastructure/FileStorage/snapshots.html)</li><li>[Block periodic snapshots](/docs/infrastructure/BlockStorage/snapshots.html#snapshots)</li></ul></p></dd>
  <dt>Replicate snapshots to another location</dt>
 <dd><p>To protect your data from a location failure, you can [replicate snapshots](/docs/infrastructure/FileStorage/replication.html#working-with-replication) to an NFS file share or block storage instance that is set up in another location. Data can be replicated from the primary storage to the backup storage only. You cannot mount a replicated NFS file share or block storage instance to a cluster. When your primary storage fails, you can manually set your replicated backup storage to be the primary one. Then, you can mount it to your cluster. After your primary storage is restored, you can restore the data from the backup storage.</p>
 <p>For more information, see:<ul><li>[Replicate snapshots for NFS](/docs/infrastructure/FileStorage/replication.html#working-with-replication)</li><li>[Replicate snapshots for Block](/docs/infrastructure/BlockStorage/replication.html#working-with-replication)</li></ul></p></dd>
 <dt>Duplicate storage</dt>
 <dd><p>You can duplicate your NFS file share or block storage instance in the same location as the original storage instance. A duplicate has the same data as the original storage instance at the point in time that you create the duplicate. Unlike replicas, use the duplicate as an independent storage instance from the original. To duplicate, first set up snapshots for the volume.</p>
 <p>For more information, see:<ul><li>[NFS duplicate snapshots](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage)</li><li>[Block duplicate snapshots](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume)</li></ul></p></dd>
  <dt>Back up data to Object Storage</dt>
  <dd><p>You can use the [**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) to spin up a backup and restore pod in your cluster. This pod contains a script to run a one-time or periodic backup for any persistent volume claim (PVC) in your cluster. Data is stored in your {{site.data.keyword.objectstoragefull}} instance that you set up in a location.</p>
  <p>To make your data even more highly available and protect your app from a location failure, set up a second {{site.data.keyword.objectstoragefull}} instance and replicate data across locations. If you need to restore data from your {{site.data.keyword.objectstoragefull}} instance, use the restore script that is provided with the image.</p></dd>
<dt>Copy data to and from pods and containers</dt>
<dd><p>You can use the `kubectl cp` [command![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) to copy files and directories to and from pods or specific containers in your cluster.</p>
<p>Before you begin, [target your Kubernetes CLI](cs_cli_install.html#cs_cli_configure) to the cluster that you want to use. If you do not specify a container with <code>-c</code>, the command uses to the first available container in the pod.</p>
<p>You can use the command in various ways:</p>
<ul>
<li>Copy data from your local machine to a pod in your cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copy data from a pod in your cluster to your local machine: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copy data from a pod in your cluster to a specific container in another pod another: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

## Cleaning up persistent NFS file and block storage
{: #cleanup}

When you set up persistent storage in your cluster, you have three main components: the Kubernetes persistent volume claim (PVC) that requests storage, the Kubernetes persistent volume (PV) that is mounted to a pod and described in the PVC, and the IBM Cloud infrastructure (SoftLayer) instance, such as NFS file or block storage. Depending on how you created these, you might need to delete all three separately.
{:shortdesc}

Understanding your delete options:

<dl>
<dt>I deleted my cluster. Do I have to delete anything else to remove persistent storage?</dt>
<dd>It depends. When you delete a cluster, the PVC and PV are deleted. However, you choose whether to remove the associated storage instance in IBM Cloud infrastructure (SoftLayer). If you chose not to remove it, then the infrastructure resources still exists. Also, if you deleted your cluster in an unhealthy state, the storage might still exist even if you chose to remove it. Follow the instructions, particularly the step to [delete your storage instance](#sl_delete_storage) in IBM Cloud infrastructure (SoftLayer).</dd>
<dt>Can I delete the PVC to remove all my storage?</dt>
<dd>Sometimes. If you [create the persistent storage dynamically](#create) and select a storage class without `retain` in its name, then when you delete the PVC, the PV and the IBM Cloud infrastructure (SoftLayer) storage instance are also deleted.</dd>
<dt>When do I have to delete all three separately?</dt>
<dd><p>If you [create the persistent storage dynamically](#create) and select a `retain` storage class, then when you delete the PVC, neither the PV nor the IBM Cloud infrastructure (SoftLayer) storage instance is deleted. You can delete them separately.</p>
<p>If you use existing [NFS](#existing) or [block](#existing_block) storage, you always need to delete your IBM Cloud infrastructure (SoftLayer) storage instance separately. Additionally, if you use a `retain` storage class, then you also need to delete the PVC and PV separately.</p>
</dd>
<dt>Am I still charged for storage after I delete it?</dt>
<dd><p>It depends on what you delete and the billing type. If you delete the PVC and PV, but not the instance in your IBM Cloud infrastructure (SoftLayer) account, that instance still exists and you are charged for it. You must delete everything to avoid charges. Further, when you specify the `billingType` in the PVC, you can choose "hourly" or "monthly." If you chose "monthly," or did not specify a billing type, then your instance is billed monthly. When you delete it, you are charged for the remainder of the month.</p></dd>
</dl>

**Important**:
* When you clean up persistent storage, you delete all the data that is stored in it. If you need a copy of the data, [make a backup](#backup_restore).
* If you are using an {{site.data.keyword.Bluemix_dedicated}} account, you must request volume deletion by [opening a support ticket](/docs/get-support/howtogetsupport.html#getting-customer-support).

Before you begin:
* [Target your CLI](cs_cli_install.html#cs_cli_configure).
* [Install the IBM Cloud infrastructure (SoftLayer) CLI](#slcli).

To clean up persistent data:

1.  List the PVCs in your cluster, choose which one you want to remove, and note the PVC name in the **Name** field and the PV name in the **Volume** field.

    ```
    kubectl get pvc
    ```
    {: pre}

    Example output:
    ```
    NAME                  STATUS    VOLUME                                     CAPACITY   ACCESSMODES   STORAGECLASS        AGE
    claim1-block-bronze   Bound     pvc-06886b77-102b-11e8-968a-f6612bb731fb   20Gi       RWO           ibmc-block-bronze   78d
    doc-storage           Bound     pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356c   4Gi        RWX           ibmc-file-bronze    105d
    mypvc                 Bound     pvc-1efef0ba-0c48-11e8-968a-f6612bb731fb   24Gi       RWX           ibmc-file-silver    83d
    mystorage             Bound     pvc-da32c0c9-36a5-11e8-a667-9a086c6725a0   20Gi       RWX           ibmc-file-bronze    29d
    pvcnew                Bound     pvc-922eec22-0dcb-11e8-968a-f6612bb731fb   45Gi       RWX           ibmc-file-bronze    81d
    ```
    {: screen}

2.  Using the PV **Volume** name, describe the PV. Look at the **Reclaim Policy** field. **Note**: If the persistent storage was created dynamically and the reclaim policy is `Delete`, then when you remove the PVC, the PV that is bound to the PVC is removed. Further, the NFS file or block storage instance in your IBM Cloud infrastructure (SoftLayer) account is also removed. **After you complete Step 3 to delete the PVC, all data in the volume is removed**. If the reclaim policy is `Retain`, then you have to delete the PVC in **Step 3** and continue to **Step 4**.

    ```
    kubectl describe pv <pv_name>
    ```
    {: pre}

    Example output:
    ```
    Name:		pvc-1efef0ba-0c48-11e8-968a-f6612bb731fb
    ...
    StorageClass:	ibmc-file-silver
    Status:		Bound
    Claim:		default/mypvc
    Reclaim Policy:	Delete
    Access Modes:	RWX
    ...
    ```
    {: screen}

3.  Remove the PVC.

    1.  Using the PVC name that you previously retrieved, delete the persistent storage.

        ```
        kubectl delete pvc <pvc_name>
        ```
        {: pre}

    2.  Check that the PV that is bound to the PVC no longer exists when you list PVs. **Note**: Its **Status** might briefly say **Released** before it is deleted. Rerun the command to verify that it is removed.

        ```
        kubectl get pv
        ```
        {: pre}

    3.  **For clusters that run Kubernetes version 1.10 or later**: Your cluster has [Storage Object in Use Protection ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#storage-object-in-use-protection). If you try to delete a PVC that is is use by another pod or a PV that is bound to a PVC, the PVC or PV are marked for removal, but are not removed. Removal is postponed until the PVC or PV are no longer in active use. Therefore, you need to delete the pod that uses the PVC for the PVC to be removed.

        1.  List your pod that uses the PVC. Replace `<pvc_name>` with the name of your PVC.

            ```
            kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
            ```
            {: pre}

            In the example output, `mydeployment-1387492362-hmtfz` is the name of the pod.
            ```
            ...   
            mydeployment-1387492362-hmtfz:	<pvc_name>
            ...  
            ```
            {: screen}  

        2.  Delete the pod that uses the PVC.

            ```
            kubectl delete pod <pod_name>
            ```
            {: pre}

    4.  If you created the persistent storage from an existing [NFS](#existing) or [block](#existing_block) storage instance, continue to [delete the instance from IBM Cloud infrastructure (SoftLayer)](#sl_delete_storage).

4.  **If the reclaim policy is `Retain`**: When you remove the PVC, the PV that is bound to the PVC is released. Further, the NFS file or block storage instance in your IBM Cloud infrastructure (SoftLayer) account also remains. However, the PV cannot be used for another PVC because the data remains on the volume. To permanently delete the data take the following steps.

    1.  Using the PV name that you previously retrieve, delete the PV.

        ```
        kubectl delete pv <pv_name>
        ```
        {: pre}

    2.  Check that the PV no longer exists when you list PVs.

        ```
        kubectl get pv
        ```
        {: pre}

    3.  Continue to [delete the instance from IBM Cloud infrastructure (SoftLayer)](#sl_delete_storage).

5.  {: #sl_delete_storage}Remove the NFS file or block storage instances from your IBM Cloud infrastructure (SoftLayer) account.

    1.  Get your cluster ID.
        ```
        ibmcloud cs clusters
        ```
        {: pre}

    2.  List the storage volume instances in your IBM Cloud infrastructure (SoftLayer) account that are associated with the cluster ID.

        **For file storage**:
        ```
        slcli file volume-list --sortby billingItem --columns id,datacenter,notes,billingItem | grep orderItemId | grep <cluster-ID>
        ```
        {: pre}

        **For block storage**:
        ```
        slcli block volume-list --sortby billingItem --columns id,datacenter,notes,billingItem | grep orderItemId | grep <cluster-ID>
        ```
        {: pre}

    3.  From the [{{site.data.keyword.Bluemix_notm}} console](https://console.bluemix.net/) menu, select the **Infrastructure** portal. From the **Storage** menu, select **Block Storage** or **File Storage** for the storage volume instance that you want to remove.

    4.  In the table of storage instances, click the **Volume** name.

    5.  In the **Notes** field, verify that the volume is the one that you want to remove by using the cluster, PV, and PVC information. For example:

        ```
        ibm-file-plugin-662986742-vrv7s:us-south:aa1a11a1a11b2b2bb22b22222c3c3333:Endurance:mypvc:pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356z:delete
        ```
        {: screen}

        Understanding the **Notes** field information:
        *  **`:`**: A colon (`:`) separates information.
        *  **`ibm-file-plugin-662986742-vrv7s`**: The storage plug-in that the cluster uses.
        *  **`us-south`**: The region that your cluster is in.
        *  **`aa1a11a1a11b2b2bb22b22222c3c3333`**: The cluster ID that is associated with the storage instance.
        *  **`Endurance`**: The class of file or block storage that the volume is, either `Endurance` or `Performance`.
        *  **`mypvc`**: The PVC that is associated with the storage instance.
        *  **`pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356z`**: The PV that is associated with the storage instance.
        *  **`delete` (or `retain`)**: The reclaim policy for the PV.

    6.  Return to the file or block storage page. In the table, for the volume that you want to delete, select **Actions** > **Cancel**. In the pop-up window, select how you want to **Cancel**, then click **Continue**.
