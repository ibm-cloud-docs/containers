s that your clusters are in so that you can create PVCs.


To add persistent storage:

1.  Review and decide on the storage class that you want to use. You can choose between the pre-defined storage classes or create a customized storage class. The `ibmc-file-bronze` storage class is the same as the `default` storage class. 
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
    - If you want to keep your data, then choose a `retain` storage class. When you delete the PVC, only the PVC is deleted. The PV still exists in the cluster and the data in it is saved, but it cannot be reused with another PVC. Also, the NFS file or block storage and your data still exist in your IBM Cloud infrastructure (SoftLayer) account. Later, to access this data in your cluster, create a PVC and a matching PV that refers to your existing [NFS file](#existing_file) storage. To remove the PV or storage instance, see [Cleaning up persistent NFS file and block storage](#cleanup).
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

**NFS permissions**: Looking for documentation on enabling NFS non-root and root permissions? See [Adding non-root user access to NFS file storage](cs_troubleshoot_storage.html#nonroot) or [Enabling root permission for NFS file storage](cs_troubleshoot_storage.html#root).

<br />



## Using existing file storag in clusters
{: #existing_file}

If you have existing NFS file shares in your IBM Cloud infrastructure (SoftLayer) account that you want to use, you can do so by creating a persistent volume (PV) for your existing storage.
{:shortdesc}

A persistent volume (PV) is a Kubernetes resource that represents an actual storage device that is provisioned in a data center. Persistent volumes abstract the details of how a specific storage type is provisioned by {{site.data.keyword.Bluemix_notm}} Storage. To mount a PV to your cluster, you must request persistent storage for your pod by creating a persistent volume claim (PVC). The following diagram illustrates the relationship between PVs and PVCs.

![Create persistent volumes and persistent volume claims](images/cs_cluster_pv_pvc.png)

As depicted in the diagram, to enable existing NFS storage, you must create PVs with a certain size and access mode and create a PVC that matches the PV specification. If the PV and PVC match, they are bound to each other. Only bound PVCs can be used by the cluster user to mount the volume to a deployment. This process is referred to as static provisioning of persistent storage.

Before you begin, make sure that you have an existing NFS file share that you can use to create your PV. For example, if you previously [created a PVC with a `retain` storage class policy](#add_file), you can use that retained data in the existing NFS file share for this new PVC.

**Note:** Static provisioning of persistent storage applies to existing NFS file shares only. If you do not have existing NFS file shares, cluster users can use the [dynamic provisioning](#add_file) process to add PVs.

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




## Setting up NFS and block persistent storage in multizone clusters
{: #storage_multizone}

You can provision persistent storage in each zone of a multizone cluster and use it in your app pods. However, persistent storage cannot be shared across multiple zones. To use persistent storage in a pod, the pod must run in the same zone where the persistent storage is provisioned.
{: shortdesc}

Looking to share data across zones? Try a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).
{: tip}

To use persistent storage in multizone clusters, you must label your multizone cluster's [existing PVs](#pv_multizone) for multizone use. Then, you can use [existing NFS or block persistent storage](#static_multizone) or [provision new storage instances dynamically](#dynamic_multizone) per zone in the multizone cluster.

### Updating persistent volumes in existing clusters for multizone
{: #pv_multizone}

If you updated your cluster from a single-zone to a multizone cluster and had existing persistent volumes (PVs), update the PVs for multizone use. The labels assure that pods that use this storage are deployed to the zone where the persistent storage exists.
{:shortdesc}

Use a script to find all the PVs in your cluster and apply the Kubernetes `failure-domain.beta.kubernetes.io/region` and `failure-domain.beta.kubernetes.io/zone` labels. If the PV already has the labels, the script does not overwrite the existing values.

Before you begin:
- [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure).
- Enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](cs_users.html#infra_access), or you can request the account owner to enable it. As an alternative to VLAN spanning, you can use a Virtual Router Function (VRF) if it is enabled in your IBM Cloud infrastructure (SoftLayer) account.

To update existing PVs:

1.  Apply the multizone labels to your PVs by running the script.  Replace <mycluster> with the name of your cluster. When prompted, confirm the update of your PVs.

    ```
    bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
    ```
    {: pre}

    **Example output**:

    ```
    Retrieving cluster storage...
    OK

    Name:			mycluster
    ID:			  myclusterID1234
    State:			normal
    ...
    Addons
    Name                   Enabled
    storage-watcher-pod    true
    basic-ingress-v2       true
    customer-storage-pod   true
    us-south
    kube-config-dal10-storage.yml
    storage.yml
    dal10\n
    The persistent volumes which do not have region and zone labels will be updated with REGION=
    us-south and ZONE=dal10. Are you sure to continue (y/n)?y
    persistentvolume "pvc-ID-123456" labeled
    persistentvolume "pvc-ID-789101" labeled
    ['failure-domain.beta.kubernetes.io/region' already has a value (us-south), and --overwrite is false, 'failure-domain.beta.kubernetes.io/zone' already has a value (dal10), and --overwrite is false]
    ['failure-domain.beta.kubernetes.io/region' already has a value (us-south), and --overwrite is false, 'failure-domain.beta.kubernetes.io/zone' already has a value (dal10), and --overwrite is false]
    \nSuccessfully applied labels to persistent volumes which did not have region and zone labels.
    ```
    {: screen}

2.  Verify that the labels were applied to your PVs.

    1.  Look in the output of the previous command for the IDs of PVs that were labeled.

        ```
        persistentvolume "pvc-ID-123456" labeled
        persistentvolume "pvc-ID-789101" labeled
        ```
        {: screen}

    2.  Review the region and zone labels for your PVs.

        ```
        kubectl describe pv pvc-ID-123456
        ```
        {: pre}

        **Example output**:
        ```
        Name:		pvc-ID-123456
        Labels:		CapacityGb=4
        		Datacenter=dal10
            ...
        		failure-domain.beta.kubernetes.io/region=us-south
        		failure-domain.beta.kubernetes.io/zone=dal10
            ...
        ```
        {: screen}


### Using existing file shares and block storage to create persistent storage for multizone clusters
{: #static_multizone}

To use existing file storage in a multizone cluster, the NFS storage must exist within the same region and zone as the worker node for which you want to create persistent storage. The provision process is similar to the [single-zone cluster process](#existing_file).
{:shortdesc}

Before you begin
-  [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure).
-  If a PV for your storage already exists, [add the zone and region label](#pv_multizone) to your PV.

To add existing file or block storage:

1.  Get the **Region Name** for your cluster.

    ```
    ibmcloud cs region
    ```
    {: pre}

2.  Retrieve the zone of your existing file or block storage instance.
    -  For file storage:
       ```
       ibmcloud sl file volume-list
       ```
       {: pre}

    -  For block storage:
       ```
       ibmcloud sl block volume-list
       ```
       {: pre}

    You can find the zone in the **datacenter** column of your CLI output.

3.  Create a storage configuration file for your PV . Under `labels`, add the region and zone for your cluster, such as `us-south` and `dal12`.
    - Example for file storage:
      ```
      apiVersion: v1
      kind: PersistentVolume
      metadata:
       name: mypv
       labels:
        failure-domain.beta.kubernetes.io/region: us-south
        failure-domain.beta.kubernetes.io/zone: dal12
      spec:
       capacity:
         storage: <storage_size>
       accessModes:
         - ReadWriteMany
       nfs:
         server: "<nfs_server>"
         path: "<nfs_path>"
      ```
      {: codeblock}

    - Example for block storage:
      ```
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: mypv
	labels:
         failure-domain.beta.kubernetes.io/region=us-south
         failure-domain.beta.kubernetes.io/zone=dal12
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

    To review how to retrieve other values for this configuration file, see adding [existing file storage](#existing_file).

4.  Proceed with the [steps for existing file storage](#existing_file) for single-zone clusters, replacing the configuration file with the one you created in the previous step.


### Creating persistent storage in multizone clusters
{: #dynamic_multizone}

You can create dynamic storage by following the same instructions to [create persistent storage in single-zone clusters](#add_file). By default, the zone in which your PV is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones. If you add new zones to the cluster and submit a new PVC, the new zone is automatically added to the round-robin scheduling.
{:shortdesc}

**Can I share data across zones by using persistent storage?**

No, NFS file or block persistent storage is not shared across zones. If you want to share data across zones, use a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

**I don't need to share data across zones, but I want persistent storage in each zone. How can I set up persistent storage in each zone?**

If you dynamically provision NFS and block storage in a cluster that spans multiple zones, the storage is provisioned in only 1 zone that is selected on a round-robin basis. To provision persistent storage in all zones of your multizone cluster, repeat the steps to [provision dynamic storage](#add_file) for each zone. For example, if your cluster spans zones `dal10`, `dal12`, and `dal13`, the first time that you dynamically provision persistent storage might provision the storage in `dal10`. Create two more PVCs to cover `dal12` and `dal13`.

**What if I want to specify the zone that the PV is created in?**

You can choose to provision a PV in a specific zone, for example to set up storage for a pod that resides only in that zone. To do so, you must customize a storage class and apply its corresponding PVC in that zone. The specification in the PVC prevents it from being included in the default round-robin scheduling.

The following instructions are provided if you want to specify a zone. If not, use the steps to [create persistent storage](#add_file).

Before you begin:

* [Target the Kubernetes CLI to the cluster](cs_cli_install.html#cs_cli_configure).
* Retrieve the cluster's zone in which you want to create the PV.

To specify the zone in which the PV is created in a multizone cluster:

1.  Complete the first five steps of [creating persistent storage](#add_file) to decide on retention policy (`reclaim`) and billing frequency, and to review the various storage class options that IBM provides.

2.  Customize a storage class and verify that it is successfully applied.

    1.  **Example customized storage class to specify a zone for multizone clusters**:
        The following `.yaml` file customizes a storage class that is based on the `ibm-flie-silver` non-retaining storage class: the `type` is `"Endurance"`, the `iopsPerGB` is `4`, the `sizeRange` is `"[20-12000]Gi"`, and the `reclaimPolicy` is set to `"Delete"`. You can review the previous information on `ibmc` storage classes to help you choose acceptable values for these fields. The zone is specified as `"dal12"`.</br>

        ```
        apiVersion: storage.k8s.io/v1beta1
        kind: StorageClass
        metadata:
          name: ibmc-file-silver-mycustom-storageclass
          labels:
            kubernetes.io/cluster-service: "true"
        provisioner: ibm.io/ibmc-file
        parameters:
          zone: "dal12"
          type: "Endurance"
          iopsPerGB: "4"
          sizeRange: "[20-12000]Gi"
        reclaimPolicy: "Delete"
        ```
        {: codeblock}

    2.  Create the customized storage class.

        ```
        kubectl apply -f <local_file_path>
        ```
        {: pre}

    3.  Verify that the customized storage class is created.

        ```
        kubectl get storageclasses
        NAME                                     TYPE
        ...
        ibmc-file-silver-mycustom-storageclass   ibm.io/ibmc-file
        ...
        ```
        {: pre}

3.  Create a PVC that uses this customized storage class and verify that it is successfully applied. If you do not customize your request, by default the PVC is provisioned in a zone that is scheduled in a round-robin approach to balance PVCs across zones in the cluster.</br></br>
    **Note:** After your storage is provisioned, you cannot change the size of your NFS file share or block storage. Make sure to specify a size that matches the amount of data that you want to store.

    1.  **Example PVC to specify a zone for multizone clusters**:
        The following `.yaml` file creates a claim that is named `mypvc` based on the customized storage class that is named `ibmc-file-silver-mycustom-storageclass`, billed `"hourly"`, with a gigabyte size of `24Gi`.

        ```
        apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
          name: mypvc
          labels:
            billingType: "hourly"
        spec:
          accessModes:
            - ReadWriteMany
          resources:
            requests:
              storage: 24Gi
          storageClassName: ibmc-file-silver-mycustom-storageclass
         ```
         {: codeblock}

    2.  Create the PVC.

        ```
        kubectl apply -f mypvc.yaml
        ```
        {: pre}

    3.  Verify that your persistent volume claim is created and bound to the persistent volume. This process can take a few minutes.

        ```
        kubectl describe pvc mypvc
        ```
        {: pre}

4.  [Mount the PVC to your deployment](#app_volume_mount).

<br />


## Changing the default NFS version
{: #nfs_version}

The version of the file storage determines the protocol that is used to communicate with the {{site.data.keyword.Bluemix_notm}} file storage server. By default, all file storage instances are set up with NFS version 4. You can change your existing PV to an older NFS version if your app requires a specific version to properly function.
{: shortdesc}

To change the default NFS version, you can either create a new storage class to dynamically provision file storage in your cluster, or choose to change an existing PV that is mounted to your pod.

**Important:** To apply the latest security updates and for a better performance, use the default NFS version and do not change to an older NFS version.

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

4. Provision [file storage](#add_file) with your customized storage class.

**To change your existing PV to use a different NFS version:**

1. Get the PV of the file storage where you want to change the NFS version and note the name of the PV.
   ```
   kubectl get pv
   ```
   {: pre}

2. Add an annotation to your PV. Replace `<version_number>` with the NFS version that you want to use. For example, to change to NFS version 3.0, enter **3**.  
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


</staging>
