---

copyright:
  years: 2014, 2018
lastupdated: "2018-07-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Planning highly available persistent storage

## Non-persistent data storage options
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


## Persistent data storage options for high availability
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


## Adding storage in multizone clusters

ou can create dynamic storage by following the same instructions to [create persistent storage in single-zone clusters](#create). By default, the zone in which your PV is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones. If you add new zones to the cluster and submit a new PVC, the new zone is automatically added to the round-robin scheduling.
{:shortdesc}

**Can I share data across zones by using persistent storage?**

No, NFS file or block persistent storage is not shared across zones. If you want to share data across zones, use a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

**I don't need to share data across zones, but I want persistent storage in each zone. How can I set up persistent storage in each zone?**

If you dynamically provision NFS and block storage in a cluster that spans multiple zones, the storage is provisioned in only 1 zone that is selected on a round-robin basis. To provision persistent storage in all zones of your multizone cluster, repeat the steps to [provision dynamic storage](#create) for each zone. For example, if your cluster spans zones `dal10`, `dal12`, and `dal13`, the first time that you dynamically provision persistent storage might provision the storage in `dal10`. Create two more PVCs to cover `dal12` and `dal13`.

**What if I want to specify the zone that the PV is created in?**

You can choose to provision a PV in a specific zone, for example to set up storage for a pod that resides only in that zone. To do so, you must customize a storage class and apply its corresponding PVC in that zone. The specification in the PVC prevents it from being included in the default round-robin scheduling.

