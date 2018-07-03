---

copyright:
  years: 2014, 2018
lastupdated: "2018-07-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Storing data on {{site.data.keyword.filestorage_full}}



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

