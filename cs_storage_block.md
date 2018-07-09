s that your clusters are in so that you can create PVCs.
- Install the [{{site.data.keyword.Bluemix_notm}} block storage plug-in](#install_block).
- [Decide on a pre-defined storage class](#predefined_storageclass) or create a [customized storage class](#custom_storageclass). 

To add block storage:

1.  Create a configuration file to define your persistent volume claim (PVC) and save the configuration as a `.yaml` file.

    If you have a multizone cluster, the zone in which your storage is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones. To specify the zone for your storage, create a [customized storage class](#multizone_yaml) first. Then, follow these steps to provision storage by using your customized storage class.
    {: tip}

    -  **Example for bronze, silver, gold storage classes**:
       The following `.yaml` file creates a claim that is named `mypvc` of the `"ibmc-block-silver"` storage class, billed `"hourly"`, with a gigabyte size of `24Gi`. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Example for using the custom storage class**:
       The following `.yaml` file creates a claim that is named `mypvc` of the storage class `ibmc-block-retain-custom`, billed `"hourly"`, with a gigabyte size of `45Gi` and IOPS of `"300"`. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
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
        <td>The name of the storage class that you want to use to provision block storage. </br> If you do not specify a storage class, the PV is created with the default storage class <code>ibmc-file-bronze</code><p>**Tip:** If you want to change the default storage class, run <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> and replace <code>&lt;storageclass&gt;</code> with the name of the storage class.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Specify the frequency for which your storage bill is calculated, "monthly" or "hourly". The default is "hourly".</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Enter the size of the block storage, in gigabytes (Gi). </br></br><strong>Note: </strong> After your storage is provisioned, you cannot change the size of your block storage. Make sure to specify a size that matches the amount of data that you want to store. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>This option is available for the custom storage classes only (`ibmc-block-custom / ibmc-block-retain-custom`). Specify the total IOPS for the storage, selecting a multiple of 100 within the allowable range. If you choose an IOPS other than one that is listed, the IOPS is rounded up.</td>
        </tr>
        </tbody></table>

    If you want to use a customized storage class, create your PVC with the corresponding storage class name, a valid IOPS and size.   
    {: tip}

2.  Create the PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Verify that your PVC is created and bound to the PV. This process can take a few minutes.

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
      3m		3m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-block", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}To mount the PV to your deployment, create a configuration `.yaml` file and specify the PVC that binds the PV.

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
    <td>The name of the PVC that binds the PV that you want to use. </td>
    </tr>
    </tbody></table>

5.  Create the deployment.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  Verify that the PV is successfully mounted.

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
     
<br />



## Using existing block storage in your cluster
{: #existing_block}

Before you begin, make sure that you have an existing block storage instance that you can use to create your PV. For example, if you previously created a PVC with a `retain` storage class policy, you can use that retained data in the existing block storage for this new PVC.

### Step 1: Retrieving the information of your existing block storage

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

7.  Note the `id`, `ip_addr`, `capacity_gb`, the `datacenter`, and `lunId` of the block storage device that you want to mount to your cluster. **Note:** To mount existing storage to a cluster, you must have a worker node in the same zone as your storage. To verify the zone of your worker node, run `ibmcloud cs workers <cluster_name_or_ID>`. 

### Step 2: Creating a persistent volume (PV) and a matching persistent volume claim (PVC)

1.  Create a configuration file for your PV. Include the block storage ID, IP address, the size, the datacenter and lun ID that you retrieved earlier.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region=<region>
         failure-domain.beta.kubernetes.io/zone=<zone>
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
    <td><code>metadata/labels</code></td>
    <td>Enter the region and the zone that you retrieved earlier. You must have at least one worker node in the same region and zone as your persistent storage to mount the storage in your cluster. If a PV for your storage already exists, [add the zone and region label](#pv_multizone) to your PV. 
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Enter the file system type that is configured for your existing block storage. Choose between <code>ext4</code> or <code>xfs</code>. If you do not specify this option, the PV defaults to <code>ext4</code>. When the wrong fsType is defined, then the PV creation succeeds, but the mounting of the PV to a pod fails. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Enter the storage size of the existing block storage that you retrieved in the previous step as <code>capacity-gb</code>. The storage size must be written in gigabytes, for example, 20Gi (20 GB) or 1000Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Enter the lun ID for your block storage that you retrieved earlier as <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Enter the IP address of your block storage that you retrieved earlier as <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Enter the ID of your block storage that you retrieved earlier as <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Enter a name for your volume.</td>
	    </tr>
    </tbody></table>

2.  Create the PV in your cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

3. Verify that the PV is created.
    ```
    kubectl get pv
    ```
    {: pre}

4. Create another configuration file to create your PVC. In order for the PVC to match the PV that you created earlier, you must choose the same value for `storage` and `accessMode`. The `storage-class` field must be empty. If any of these fields do not match the PV, then a new PV is created automatically instead.

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

5.  Create your PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

6.  Verify that your PVC is created and bound to the PV that you created earlier. This process can take a few minutes.
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


## Storage class reference
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Block storage class: bronze</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Endurance storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>2</td>
</tr>
<tr>
<td>Size range in gigabytes</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Billing</td>
<td>Hourly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing info ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Silver
{: #silver}

<table>
<caption>Block storage class: silver</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Endurance storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>4</td>
</tr>
<tr>
<td>Size range in gigabytes</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Billing</td>
<td>Hourly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing info ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Block storage class: gold</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Endurance storage ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>10</td>
</tr>
<tr>
<td>Size range in gigabytes</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>Billing</td>
<td>Hourly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing info ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Custom
{: #custom}

<table>
<caption>Block storage class: custom</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Performance ![External link icon](../icons/launch-glyph.svg "External link icon")]()</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS and size</td>
<td><table><thead><th>Size range in gigabytes</th><th>IOPS range in multiples of 100</th></thead><tbody><tr><td>20-39 Gi</td><td>100-1000 IOPS</td></tr><tr><td>40-79 Gi</td><td>100-2000 IOPS</td></tr><tr><td>80-99 Gi</td><td>100-4000 IOPS</td></tr><tr><td>100-499 Gi</td><td>100-6000 IOPS</td></tr><tr><td>500-999 Gi</td><td>100-10000 IOPS</td></tr><tr><td>1000-1999 Gi</td><td>100-20000 IOPS</td></tr><tr><td>2000-2999 Gi</td><td>200-40000 IOPS</td></tr><tr><td>3000-3999 Gi</td><td>200-48000 IOPS</td></tr><tr><td>4000-7999 Gi</td><td>300-48000 IOPS</td></tr><tr><td>8000-9999 Gi</td><td>500-48000 IOPS</td></tr><tr><td>10000-12000 Gi</td><td>1000-48000 IOPS</td></tr></tbody></table></td>
</tr>
<tr>
<td>Billing</td>
<td>Monthly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing info ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Sample customized storage classes
{: #custom_storageclass}

### Specifying the zone for multizone clusters
{: #multizone_yaml}

The following `.yaml` file customizes a storage class that is based on the `ibm-block-silver` non-retaining storage class: the `type` is `"Endurance"`, the `iopsPerGB` is `4`, the `sizeRange` is `"[20-12000]Gi"`, and the `reclaimPolicy` is set to `"Delete"`. The zone is specified as `dal12`. You can review the previous information on `ibmc` storage classes to help you choose acceptable values for these </br>

To use a different storage class as your base, see the [storage class reference](#storageclass_reference). 

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Mounting block storage with an `XFS` file system
{: #xfs}

The following example creates a storage class that is named `ibmc-block-custom-xfs` and that provisions performance block storage with an `XFS` file system. 

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

<br />


## What needs a new home

The NFS file storage and block storage that backs the PV is clustered by IBM in order to provide high availability for your data. 


Before you begin:

* Retrieve the cluster's zone in which you want to create the PV. > must go into the custom storage class



</staging>
