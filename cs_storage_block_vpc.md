
---

copyright:
  years: 2014, 2019
lastupdated: "2019-09-24"

keywords: kubernetes, iks, vpc

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}

# Storing data on VPC Block Storage
{: #vpc-block}

[{{site.data.keyword.cloud_notm}} Block Storage for Virtual Private Cloud (VPC)](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-about) provides hypervisor-mounted, high-performance data storage for your virtual server instances that you can provision within a VPC.
{: shortdsc}

You can choose between predefined storage tiers with GB sizes and IOPS that meet the requirements of your workloads. To find out if VPC Block Storage is the right storage option for you, see [Choosing a storage solution](/docs/containers?topic=containers-storage_planning#choose_storage_solution). For pricing information, see [Pricing for Block Storage for VPC](/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-block-storage-for-vpc).

VPC Block Storage is available only for standard clusters that are provisioned on VPC infrastructure and that have all subnets configured with a public gateway. To use block storage in a cluster with classic {{site.data.keyword.cloud_notm}} infrastructure, see [Storing data on classic {{site.data.keyword.cloud_notm}} Block Storage](/docs/containers?topic=containers-block_storage). VPC Block Storage is a single zone storage solution. If you have a multizone cluster, consider using one of the [multizone persistent storage options](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
{: important}

## Installing the VPC Block Storage add-on
{: #vpc-block-addon}

Use an [{{site.data.keyword.cloud_notm}} managed add-on](/docs/containers?topic=containers-managed-addons) to install the VPC Block Storage plug-in in your cluster. The add-on automatically installs the plug-in drivers and a set of pre-defined storage classes that you can use to provision VPC Block Storage in your cluster.
{: shortdesc}

Before you install the VPC Block Storage add-on, make sure that your cluster's VPC subnets are configued with a public gateway. For more information, see step 12 in [Creating a VPC and subnet](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-using-the-ibm-cloud-console#creating-a-vpc-and-subnet).
{: important}

1. Verify that your cluster runs the minimum required Kubernetes version for the VPC Block Storage plug-in.
   1. List the **Minimum Kubernetes version** for the **vpc-block-csi-driver** add-on.
      ```
      ibmcloud ks addon-versions --addon vpc-block-csi-driver
      ```
      {: pre}

      Example output:
      ```
      OK
      Name                    Version           Minimum Kubernetes version   
      vpc-block-csi-driver    0.0.1 (default)   1.14
      ```
      {: screen}

   2. Make sure that your cluster runs the minimum required or a higher version of Kubernetes.
      ```
      ibmcloud ks cluster ls
      ```
      {: pre}

   3. If your cluster does not meet the minimum Kubernetes version requirement, [update your cluster](/docs/containers?topic=containers-update).

2. List the add-ons that are installed in your cluster to verify that the **vpc-block-csi-driver** add-on is not yet enabled.
   ```
   ibmcloud ks cluster addons --cluster <cluster_name_or_ID>
   ```
   {: pre}

   If the VPC Block Storage add-on is displayed in your CLI output, the add-on is already installed in your cluster.

3. If the add-on is not installed, enable the add-on in your cluster.
   ```
   ibmcloud ks cluster addon enable vpc-block-csi-driver --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Example output:
   ```
   OK
   ```
   {: screen}

4. Verify that the VPC Block Storage add-on is successfully installed.
   ```
   kubectl get pod -n kube-system | grep vpc
   ```
   {: pre}

   Example output:
   ```
   ibm-vpc-block-csi-controller-0                        3/3     Running   0          79s
   ibm-vpc-block-csi-node-pvpnf                          2/2     Running   0          78s
   ```
   {: screen}

   The installation is successful when you see one `ibm-vpc-block-csi-controller` and one or more `ibm-vpc-block-csi-node` pods. The number of `ibm-vpc-block-csi-node` pods equals the number of worker nodes in your cluster.

5. Verify that the VPC Block Storage storage classes are created in your cluster.
   ```
   kubectl get storageclasses | grep vpc
   ```
   {: pre}

   Example output:
   ```
   ibmc-vpc-block-10iops-tier              vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-5iops-tier               vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-custom                   vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-general-purpose          vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-retain-10iops-tier       vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-retain-5iops-tier        vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-retain-custom            vpc.block.csi.ibm.io   72m
   ibmc-vpc-block-retain-general-purpose   vpc.block.csi.ibm.io   72m
   ```
   {: screen}

## Adding VPC Block Storage to your apps
{: #vpc-block-add}

Choose your VPC Block Storage profile and create a persistent volume claim to dynamically provision VPC Block Storage for your cluster. Dynamic provisioning automatically creates the matching persistent volume and orders the physical storage device in your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

1. Decide on the [VPC Block Storage profile](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-getting-started#determine-storage-requirements) that best meets the capacity and performance requirements that you want.

2. Select the corresponding storage class for your VPC Block Storage profile.

   All IBM pre-defined storage classes set up VPC Block Storage with an `ext4` file system by default. If you want to use a different file system, such as `xfs` or `ext3`, [create a customized storage class](#vpc-block-xfs).
   {: note}

   <table>
   <caption>Overview of VPC Block Storage profiles</caption>
   <thead>
     <th>VPC Block Storage profile</th>
     <th>Corresponding storage class</th>
   </thead>
   <tbody>
   <tr>
    <td> 10 IOPS/GB </td>
    <td> <code>ibmc-vpc-block-10iops-tier</code></br><code>ibmc-vpc-block-retain-10iops-tier</code></td>
    </tr>
    <tr>
   <td>5 IOPS/GB </td>
   <td><code>ibmc-vpc-block-5iops-tier</code></br><code>ibmc-vpc-block-retain-5iops-tier</code></td>
   </tr>
   <tr>
   <td>3 IOPS/GB </td>
   <td><code>ibmc-vpc-block-general-purpose</code></br><code>ibmc-vpc-block-retain-general-purpose</code></td>
   </tr>
   <tr>
   <td> Custom </td>
   <td> <code>ibmc-vpc-block-custom</code></br><code>ibmc-vpc-block-retain-custom</code></td>
   </tr>
   </tbody>
   </table>

3. Decide on your VPC Block Storage configuration.
   1. Choose a size for your storage. Make sure that the size is supported by the VPC Block Storage profile that you chose.
   2. Choose if you want to keep your data after the cluster or the persistent volume claim (PVC) is deleted.
      - If you want to keep your data, then choose a `retain` storage class. When you delete the PVC, only the PVC is deleted. The persistent volume (PV), the physical storage device in your {{site.data.keyword.cloud_notm}} account, and your data still exist. To reclaim the storage and use it in your cluster again, you must remove the PV and follow the steps for using existing VPC Block Storage.
      - If you want the PV, the data, and your physical VPC Block Storage device to be deleted when you delete the PVC, choose a storage class without `retain`.

4. Create a configuration file to define your persistent volume claim and save the configuration as a YAML file.
   ```
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: <pvc_name>
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: <size>
     storageClassName: <storage_class>
   ```
   {: codeblock}

   <table>
   <caption>Understanding the YAML file components</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
   </thead>
   <tbody>
   <tr>
   <td><code>metadata.name</code></td>
   <td>Enter a name for your PVC.</td>
   </tr>
   <tr>
   <td><code>spec.accessMode</code></td>
   <td>VPC Block Storage supports a `ReadWriteOnce` access mode only. You can mount the PVC to one pod on one worker node in the cluster at a time.</td>
   </tr>
   <tr>
   <td><code>spec.resources.requests.storage</code></td>
   <td>Enter the size of the VPC Block Storage, in gigabytes (Gi). Make sure that the size is supported in the VPC Block Storage profile that you chose. For example, if you want 10 gigabyte of VPC Block Storage, enter `10Gi`.  </td>
   </tr>
   <tr>
   <td><code>spec.storageClassName</code></td>
   <td>Enter the storage class name that you selected earlier.</td>
   </tr>
   </tbody>
   </table>

5. Create the PVC in your cluster.
   ```
   kubectl apply -f pvc.yaml
   ```
   {: pre}

6. Verify that your PVC is created and bound to the PV. This process can take a few minutes.
   ```
   kubectl describe pvc <pvc_name>
   ```
   {: pre}

   Example output:
   ```
   Name:          mypvv
   Namespace:     default
   StorageClass:  ibmc-vpc-block-5iops-tier
   Status:        Bound
   Volume:        
   Labels:        <none>
   Annotations:   kubectl.kubernetes.io/last-applied-configuration:
                 {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{},"name":"csi-block-pvc-good","namespace":"default"},"spec":{...
               volume.beta.kubernetes.io/storage-provisioner: vpc.block.csi.ibm.io
   Finalizers:    [kubernetes.io/pvc-protection]
   Capacity: 10Gi   
   Access Modes:  
   VolumeMode:    Filesystem
   Events:
     Type       Reason                Age               From                         Message
     ----       ------                ----              ----                         -------
     Normal     ExternalProvisioning  9s (x3 over 18s)  persistentvolume-controller  waiting for a volume to be created, either by external provisioner "vpc.block.csi.ibm.io" or manually created by system administrator
   Mounted By:  <none>
   ```
   {: screen}

7. Create a deployment configuration file for your app and mount the PVC to your app.
   ```
   apiVersion: apps/v1
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
   <td><code>metadata.labels.app</code></td>
   <td>Enter a label for the deployment.</td>
   </tr>
   <tr>
   <td><code>spec.selector.matchLabels.app</code> <br/> <code>spec.template.metadata.labels.app</code></td>
   <td>Enter a label for your app.</td>
   </tr>
   <tr>
   <td><code>spec.containers.image</code></td>
   <td>Specify the name of the image that you want to use. To list available images in your {{site.data.keyword.registryshort_notm}} account, run `ibmcloud cr image-list`.</td>
   </tr>
   <tr>
   <td><code>spec.containers.name</code></td>
   <td>Specify the name of the container that you want to deploy in your pod.</td>
   </tr>
   <tr>
   <td><code>spec.containers.volumeMounts.mountPath</code></td>
   <td>Specify the absolute path of the directory to where the PVC is mounted inside the container.  </td>
   </tr>
   <tr>
   <td><code>spec.containers.volumeMounts.name</code></td>
   <td>Enter the name of the volume to mount to your pod. You can enter any name that you want. </td>
   </tr>
   <tr>
   <td><code>volumes.name</code></td>
   <td>Enter the name of the volume to mount to your pod. Typically this name is the same as <code>volumeMounts.name</code>.</td>
   </tr>
   <tr>
   <td><code>volumes.persistentVolumeClaim.claimName</code></td>
   <td>Enter the name of the PVC that you created earlier. </td>
   </tr>
   </tbody></table>

8. Create the deployment in your cluster.
   ```
   kubectl apply -f deployment.yaml
   ```
   {: pre}

9. Verify that the PVC is successfully mounted to your app. It might take a few minutes for your pods to get into a **Running** state.

   During the deployment of your app, you might see intermittent `Unable to mount volumes` errors in the **Events** section of your CLI output. The VPC Block Storage add-on automatically retries mounting the storage to your apps. Wait a few more minutes for the storage to mount to your app.
   {: tip}

   ```
   kubectl describe deployment <deployment_name>
   ```
   {: pre}

   Example output:
   ```
   ...
   Volumes:
   myvol:
     Type:    PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
     ClaimName:    mypvc
     ReadOnly:    false
   ```
   {: screen}

## Using an existing VPC Block Storage instance
{: #vpc-block-static}

If you have an existing physical VPC Block Storage device that you want to use in your cluster, you can manually create the PV and PVC to [statically provision](/docs/containers?topic=containers-kube_concepts#static_provisioning) the storage.
{: shortdesc}

1. From the [VPC Block Storage dashboard ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/vpc/storage/storageVolumes){: new_window}, select the VPC Block Storage device that you want to add to your cluster.
2. From the volumes details page, note the **ID**, **Size**, **Location**, and **Max IOPS** of your VPC Block Storage device.
3. Optional: If you provisioned your physical VPC Block Storage instance by using a `retain` VPC Block Storage class, the PV and the physical storage is not removed when you remove the PVC. To use your physical VPC Block Storage device in your cluster, you must remove the existing PV first.  
   1. List the PVs in your cluster and look for the PV that belongs to your VPC Block Storage device. The PV is in a `released` state.
      ```
      kubectl get pv
      ```
      {: pre}

   2. Remove the PV.
      ```
      kubectl delete pv <pv_name>
      ```
      {: pre}

4. Create a configuration file for your PV. Include the **ID**, **Size**, **Location**, and **Max IOPS** that you retrieved earlier.
   ```
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: <pv_name>
   spec:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: <vpc_block_storage_size>
     csi:
       driver: vpc.block.csi.ibm.io
       fsType: ext4
       volumeAttributes:
         iops: "<vpc_block_storage_iops>"
         volumeId: <vpc_block_storage_ID>
         zone: "<vpc_block_location>"
       volumeHandle: <vpc_block_storage_ID>
     persistentVolumeReclaimPolicy: Retain
     storageClassName: ""
     volumeMode: Filesystem
   ```
   {: codeblock}

   <table>
   <caption>Understanding the YAML file components</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
   </thead>
   <tbody>
   <tr>
   <td><code>metadata.name</code></td>
   <td>Enter a name for your PV. </td>
   </tr>
   <tr>
      <td><code>spec.capacity.storage</code></td>
   <td>Enter the size of your VPC Block Storage volume in gigabytes (Gi) that you retrieved earlier. For example, if the size of your device is 100 GB, enter <code>100Gi</code>.  </td>
   </tr>
   <tr>
   <td><code>spec.csi.volumeAttributes.iops</code></td>
   <td>Enter the Max IOPS of the VPC Block Storage volume that you retrieved earlier.</td>
   </tr>
   <tr>
   <td><code>spec.csi.volumeAttributes.zone</code></td>
   <td>Enter the VPC block zone that matches the location that you retrieved earlier. For example, if your location is **Washington DC-1**, then use `us-east-1` as your zone. To list available zones, run `ibmcloud is zone`. To find an overview of available VPC zones and locations, see [Creating a VPC in a different region](/docs/vpc-on-classic?topic=vpc-on-classic-creating-a-vpc-in-a-different-region).</td>
   </tr>
   <tr>
   <td><code>spec.csi.volumeAttributes.volumeId</code></br><code>spec.csi.volumeHandle</code></td>
   <td>Enter the ID of the VPC Block Storage volume that you retrieved earlier. </td>
   </tr>
   <tr>
   <td><code>spec.storageClassName</code></td>
   <td>For the storage class name, enter an empty string.</td>
   </tr>
   </tbody>
   </table>

5. Create the PV in your cluster.
   ```
   kubectl apply -f pv.yaml
   ```
   {: pre}

6. Verify that the PV is created in your cluster.
   ```
   kubectl get pv
   ```
   {: pre}

7. Create another configuration file for your PVC. In order for the PVC to match the PV that you created earlier, you must choose the same value for the storage size and access mode. In your storage class field, enter an empty string value to match your PV. If any of these fields do not match the PV, then a new PV and VPC Block Storage instance are created automatically via dynamic provisioning.
   ```
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: <pvc_name>
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: <vpc_block_storage_size>
     storageClassName: ""
   ```
   {: codeblock}

8. Create your PVC.
   ```
   kubectl apply -f pvc.yaml
   ```
   {: pre}

9. Verify that your PVC is created and bound to the PV that you created earlier. This process can take a few minutes.
   ```
   kubectl describe pvc <pvc_name>
   ```
   {: pre}

## Creating VPC Block Storage with a different file system
{: #vpc-block-xfs}

You can create a customized storage class to provision VPC Block Storage with a different file system, such as `xfs` or `ext3`. By default, all VPC Block Storage instances are provisioned with an `ext4` file system.
{: shortdesc}

1. Follow the steps to [create a customized storage class](#vpc-customize-storage-class) with the file system that you want to use.

   Example storage class: 
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: <storage_class_name>
   parameters:
     billingType: hourly
     classVersion: "1"
     csi.storage.k8s.io/fstype: <file_system_type>
     encrypted: "false"
     encryptionKey: ""
     generation: gc
     profile: general-purpose
     resourceGroup: ""
     sizeRange: '[10-2000]GiB'
     tags: ""
     zone: ""
   provisioner: vpc.block.csi.ibm.io
   reclaimPolicy: Delete
   volumeBindingMode: Immediate
   ```
   {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Enter a name for your storage class.</td>
    </tr>
    <tr>
    <td><code>parameters.cs.storage.k8s.io/fstype</code></td>
    <td>Enter the file system for your VPC Block Storage instance. Choose `xfs` or `ext3`.</td>
    </tr>
    </tbody>
    </table>

2. Follow step 4-9 in [Adding VPC Block Storage to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision VPC Block Storage with a different file system. Then, mount this storage to a sample app.

   Your app might take a few minutes to mount the storage and get into a **Running** state.
   {: note}

6. Verify that your storage is mounted with the correct file system.
   1. List the pods in your cluster and note the **Name** of the pod that you used to mount your storage.
      ```
      kubectl get pod
      ```
      {: pre}

   2. Log in to your pod.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   3. List the mount paths inside your pod.  
      ```
      mount | grep /dev/xvdg
      ```
      {: pre}

      Example output for `xfs`:
      ```
      /dev/xvdg on /test type xfs (rw,relatime,attr2,inode64,noquota)
      ```
      {: pre}

   4. Exit your pod.
      ```
      exit
      ```
      {: pre}

## Setting up encryption for your VPC Block Storage
{: #vpc-block-encryption}

Use {{site.data.keyword.keymanagementservicelong}} to create a private root key that you use in your VPC Block Storage instance to encrypt data as it is written to the storage. After you create the private root key, create a custom storage class or a Kubernetes secret with your root key and then use this storage class or secret to provision your VPC Block Storage instance.
{: shortdesc}

1.  [Create a {{site.data.keyword.keymanagementserviceshort}} service instance](/docs/services/key-protect?topic=key-protect-provision#provision).

2.  [Create a root key](/docs/services/key-protect?topic=key-protect-create-root-keys#create-root-keys). By default, the root key is created without an expiration date.

3. Retrieve the service CRN for your root key.
   1. From the {{site.data.keyword.keymanagementserviceshort}} details page, select the **Manage** tab to find the list of your keys.
   2. Find the root key that you created and from the actions menu, click **View CRN**.
   3. Note the CRN of your root key.

4. Authorize VPC Block Storage to access {{site.data.keyword.keymanagementservicelong}}.
   1. From the {{site.data.keyword.cloud_notm}} menu, select **Manage** > **Access (IAM)**.
   2. From the menu, select **Authorizations**.
   3. Click **Create**.
   4. Select **Cloud Block Storage** as your source service.
   5. Select **Key Protect** as your target service.
   6. Select the **Reader** service access role and click **Authorize**.

5. [Decide if you want to store the {{site.data.keyword.keymanagementserviceshort}} root key CRN in a customized storage class or in a Kubernetes secret](/docs/containers?topic=containers-vpc-block#vpc-customize-default). Then, follow the steps to create a customized storage class or a Kubernetes secret. 

   **Example customized storage class**: 
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: <storage_class_name>
   provisioner: vpc.block.csi.ibm.io
   parameters:
     profile: "5iops-tier"
     sizeRange: "[10-2000]GiB"
     csi.storage.k8s.io/fstype: "ext4"
     billingType: "hourly"
     encrypted: "true"
     encryptionKey: "<encryption_key>"
     resourceGroup: ""
     zone: ""
     tags: ""
     generation: "gc"
     classVersion: "1"
   reclaimPolicy: "Delete"
   ```
   {: codeblock}
   
   <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Enter a name for your storage class.</td>
    </tr>
    <tr>
    <td><code>parameters.encrypted</code></td>
    <td>Enter <strong>true</strong> to create a storage class that sets up encryption for VPC Block Storage. If you set this option to <strong>true</strong>, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in <code>parameters.encryptionKey</code>.</td>
    </tr>
    <tr>
    <td><code>parameters.encryptionKey</code></td>
    <td>Enter the root key CRN that you retrieved earlier.</td>
    </tr>
    </tbody>
    </table>

    **Example Kubernetes secret**: 
    ```
    apiVersion: v1
    kind: Secret
    type: vpc.block.csi.ibm.io
    metadata:
      name: <secret_name>
      namespace: <namespace_name>
    stringData:
      encrypted: <true_or_false>
    data
      encryptionKey: <encryption_key>
    ```
    {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Enter a name for your secret.</td>
    </tr>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Enter the namespace where you want to create your secret.</td>
    </tr>
    <tr>
    <td><code>parameters.encrypted</code></td>
    <td>Enter <strong>true</strong> set up encryption for VPC Block Storage. </td>
    </tr>
    <tr>
    <td><code>parameters.encryptionKey</code></td>
    <td>Enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your VPC Block Storage. To use your root key CRN in a secret, you must first convert it to base64 by running `echo  -n "<root_key_CRN>" | base64`. </td>
    </tr>
    </tbody>
    </table>

6. Follow step 4-9 in [Adding VPC Block Storage to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision VPC Block Storage that is configured for encryption with your {{site.data.keyword.keymanagementserviceshort}} root key. Then, mount this storage to a sample app.

    Your app might take a few minutes to mount the storage and get into a **Running** state.
    {: note}

7. Verify that your data is encrypted.
   1. List your VPC Block Storage volumes and note the **ID** of the VPC Block Storage instance that you created. The storage instance **Name** equals the name of the PV that was automatically created when you created the PVC.
      ```
      ibmcloud is vols
      ```
      {: pre}

      Example output:
      ```
      ID                                     Name                                       Status      Capacity   IOPS   Profile           Attachment type   Created                     Zone         Resource group
      a395b603-74bf-4703-8fcb-b68e0b4d6960   pvc-479d590f-ca72-4df2-a30a-0941fceeca42   available   10         3000   5iops-tier        data              2019-08-17T12:29:18-05:00   us-south-1   a8a12accd63b437bbd6d58fb6a462ca7
      ```
      {: screen}

   2. Using the volume **ID**, list the details for your VPC Block Storage instance to ensure that your {{site.data.keyword.keymanagementserviceshort}} root key is stored in the storage instance. You can find the root key in the **Encryption key** field of your CLI output.
      ```
      ibmcloud is vol <volume_ID>
      ```
      {: codeblock}

      Example output:
      ```
      ID                                     a395b603-74bf-4703-8fcb-b68e0b4d6960   
      Name                                   pvc-479d590f-ca72-4df2-a30a-0941fceeca42   
      Status                                 available   
      Capacity                               10   
      IOPS                                   3000   
      Profile                                5iops-tier   
      Encryption key                         crn:v1:bluemix:public:kms:us-south:a/6ef045fd2b43266cfe8e6388dd2ec098:53369322-958b-421c-911a-c9ae8d5156d1:key:47a985d1-5f5e-4477-93fc-12ce9bae343f   
      Encryption                             user_managed   
      Resource group                         a8a12accd63b437bbd6d58fb6a462ca7
      Created                                2019-08-17T12:29:18-05:00
      Zone                                   us-south-1   
      Volume Attachment Instance Reference
      ```
      {: screen}


## Customizing the default storage settings
{: #vpc-customize-default}

You can change some of the default PVC settings by using a customized storage class or a Kubernetes secret to create VPC Block Storage with your customized settings.
{: shortdesc}

**What is the benefit of using a secret and specifying my parameters in a customized storage class?**</br>
As a cluster admin, [create a customized storage class](#vpc-customize-storage-class) when you want all of the PVCs that your cluster users create to be provisioned with a specific configuration and you don't want to enable your cluster users to override the default configuration. 

However, when multiple configurations are required and you don't want to create a customized storage class for every possible PVC configuration, you can create one customized storage class with the default PVC settings and a reference to a generic [Kubernetes secret](#vpc-block-storageclass-secret). If your cluster users must override the default settings of your customized storage class, they can do so by creating a Kubernetes secret that holds their custom settings. 

When you want to set up encryption for your VPC Block Storage instance, you can also use a Kubernetes secret if you want to encode the {{site.data.keyword.keymanagementserviceshort}} root key CRN to base64 instead of providing the key directly in the customized storage class.  


### Customizing a storage class
{: #vpc-customize-storage-class}

Use one of the IBM-provided storage classes as a basis to create your own customized storage class with the preferred settings for your VPC Block Storage.
{: shortdesc}

1. Review step 1 and 2 in [Adding VPC Block Storage to your apps](#vpc-block-add) to find the pre-defined storage class that best meets the performance and capacity requirements of your app. This storage class is used as the basis to create your own customized storage class.
2. Retrieve the YAML file for the storage class that you want to use as the basis to create your own customized storage class. For example, the following command retrieves the YAML file for the `ibmc-vpc-block-5iops-tier` storage class.
   ```
   kubectl get storageclass ibmc-vpc-block-5iops-tier -o yaml
   ```
   {: pre}

   Example output:
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     annotations:
       armada-service: addon-vpc-block-csi-driver
       kubectl.kubernetes.io/last-applied-configuration: |
         {"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{"armada-service":"addon-vpc-block-csi-driver","version":"0.0.1_57"},"labels":{"addonmanager.kubernetes.io/mode":"Reconcile","app":"ibm-vpc-block-csi-driver"},"name":"ibmc-vpc-block-5iops-tier"},"parameters":{"billingType":"hourly","classVersion":"1","csi.storage.k8s.io/fstype":"ext4","encrypted":"false","encryptionKey":"","generation":"gc","profile":"5iops-tier","resourceGroup":"","sizeRange":"[10-2000]GiB","tags":"","zone":""},"provisioner":"vpc.block.csi.ibm.io","reclaimPolicy":"Delete"}
       version: 0.0.1_57
     creationTimestamp: "2019-08-02T20:29:29Z"
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
       app: ibm-vpc-block-csi-driver
     name: ibmc-vpc-block-5iops-tier
     resourceVersion: "458548"
     selfLink: /apis/storage.k8s.io/v1/storageclasses/ibmc-vpc-block-5iops-tier
     uid: 94a920c6-cfda-4a57-9332-1f9b78881d50
   parameters:
     billingType: hourly
     classVersion: "1"
     csi.storage.k8s.io/fstype: ext4
     encrypted: "false"
     encryptionKey: ""
     generation: gc
     profile: 5iops-tier
     resourceGroup: ""
     sizeRange: '[10-2000]GiB'
     tags: ""
     zone: ""
   provisioner: vpc.block.csi.ibm.io
   reclaimPolicy: Delete
   volumeBindingMode: Immediate
   ```
   {: screen}

3. Create a customized storage class YAML file that is based on the YAML file that you retrieved. You can streamline your YAML file by removing all of the information from the `metadata` section, except for the `name`.
   ```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: <storage_class_name>
   provisioner: vpc.block.csi.ibm.io
   parameters:
     profile: "5iops-tier"
     sizeRange: "<size_range>"
     csi.storage.k8s.io/fstype: "<file_system_type>"
     billingType: "hourly"
     encrypted: "<encrypted_true_false>"
     encryptionKey: "<encryption_key>"
     resourceGroup: ""
     zone: "<zone>"
     tags: "<tags>"
     generation: "gc"
     classVersion: "1"
   reclaimPolicy: "<reclaim_policy>"
   volumeBindingMode: <volume_binding_mode>
   ```
   {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
        <tr>
           <td><code>metadata.name</code></td>
           <td>Enter a name for your storage class.</td>
       </tr>
       <tr>
          <td><code>parameters.sizeRange</code></td>
          <td>Enter the size range for your storage in gigabytes (GiB), such as <code>[10-2000]GiB</code>. The size range must match the VPC Block Storage profile that you specify in <code>parameters.profile</code>. To find supported storage sizes for a specific profile, see [Tiered IOPs profiles](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-profiles). Any PVC that uses this storage class must specify a size value that is within this range. </td>
       </tr>
       <tr>
          <td><code>parameters.csi.storage.k8s.io/fstype</code></td>
          <td>Enter the file system for your VPC Block Storage instance. Choose `xfs`, `ext3`, or `ext4`. The default value is `ext4` and is used if you do not specify a file system.</td>
       </tr>
       <tr>
          <td><code>parameters.encrypted</code></td>
          <td>Enter <strong>true</strong> to create a storage class that sets up encryption for VPC Block Storage. If you set this option to <strong>true</strong>, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in <code>parameters.encryptionKey</code>. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       <tr>
          <td><code>parameters.encryptionKey</code></td>
          <td>If you entered <strong>true</strong> for <code>parameters.encrypted</code>, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your VPC Block Storage. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       </tr>
       <tr>
          <td><code>parameters.zone</code></td>
          <td>Enter the VPC zone where you want to create the VPC Block Storage instance. Make sure that you use a zone that your worker nodes are connected to. To list VPC zones that your worker nodes use, run <code>ibmcloud ks cluster-get --cluster <cluster_name_or_ID></code> and look at the <strong>Worker Zones</strong> field in your CLI output. If you do not specify a zone, one of the worker node zones is automatically selected for your VPC Block Storage instance.</td>
       </tr>
       <tr>
          <td><code>parameters.tags</code></td>
          <td>Enter a comma-separated list of tags to apply to your VPC Block Storage instance. Tags can help you find VPC Block Storage instances more easily or group your instances based on common characteristics, such as the app or the environment that it is used for. </td>
       </tr>
       <tr>
          <td><code>reclaimPolicy</code></td>
          <td>Enter the reclaim policy for your storage class. If you want to keep the PV, the physical storage device and your data when you remove the PVC, enter `Retain`. If you want to delete the PV, the physical storage device and your data when you remove the PVC, enter `Delete`.</td>
       </tr>
       <tr>
          <td><code>volumeBindingMode</code></td>
          <td>Choose if you want to delay the creation of the VPC Block Storage instance until the first pod that uses this storage is ready to be scheduled. To delay the creation, enter `WaitForFirstConsumer`. To create the VPC Block Storage instance when you create the PVC, enter `Immediate`.</td>
       </tr>
   </tbody>
   </table>

4. Create the customized storage class in your cluster.
   ```
   kubectl apply -f custom_storageclass.yaml
   ```
   {: pre}

5. Verify that your storage class is available in the cluster.
   ```
   kubectl get storageclasses
   ```
   {: pre}

   Example output:
   ```
   NAME                                    PROVISIONER            AGE
   ibmc-vpc-block-10iops-tier              vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-5iops-tier               vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-custom                   vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-general-purpose          vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-retain-10iops-tier       vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-retain-5iops-tier        vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-retain-custom            vpc.block.csi.ibm.io   4d21h
   ibmc-vpc-block-retain-general-purpose   vpc.block.csi.ibm.io   4d21h
   custom_storageclass                     vpc.block.csi.ibm.io   4m26s
   ```
   {: screen}
   
6. Follow the steps in [Adding VPC Block Storage to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision VPC Block Storage. Then, mount this storage to a sample app.

### Storing your custom PVC settings in a Kubernetes secret
{: #vpc-block-storageclass-secret}

Specify your PVC settings in a Kubernetes secret and reference this secret in a customized storage class. Then, use the customized storage class to create a PVC with the custom parameters that you set in your secret. 
{: shortdesc}

**What options do I have to use the Kubernetes secret?** </br>
As a cluster admin, you can choose if you want to allow each cluster user to override the default settings of a storage class, or if you want to create one secret that everyone in your cluster must use and that enforces base64 encoding for your {{site.data.keyword.keymanagementserviceshort}} root key CRN.

- **[Every user can customize the default settings](#customize-with-secret)**: In this scenario, the cluster admin creates one customized storage class with the default PVC settings and a reference to a generic Kubernetes secret. Cluster users can override the default settings of the storage class by creating a Kubernetes secret with the desired PVC settings. In order for the customized settings in the secret to get applied to your VPC Block Storage, you must create a PVC with the same name as your Kubernetes secret. 

- **[Enforce base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key](#static-secret)**: In this scenario, you create one customized storage class with the default PVC settings and a reference to a static Kubernetes secret that overrides or enhances the default settings of the customized storage class. Your cluster users cannot override the default settings by creating their own Kubernetes secret. Instead, cluster users must provision VPC Block Storage with the configuration that you chose in your customized storage class and secret. The benefit of using this method over creating a [customized storage class](#vpc-customize-storage-class) only is that you can enforce base64 encoding for the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance when you want to encrypt the data in your VPC Block Storage instance.  

**What do I need to be aware of before I start using the Kubernetes secret for my PVC settings?** </br>
Some of the PVC settings, such as the `reclaimPolicy` or the `volumeBindingMode` cannot be set in the Kubernetes secret and must be set in the storage class. As the cluster admin, if you want to enable your cluster users to override your default settings, you must ensure that you set up enough customized storage classes that reference a generic Kubernetes secret so that your users can provision VPC Block Storage with different `reclaimPolicy` and `volumeBindingMode` settings. 

#### Enabling every user to customize the default PVC settings
{: #customize-with-secret}

1. As the cluster admin, follow the steps to [create a customized storage class](#vpc-customize-storage-class). In the customized storage class YAML file, reference the Kubernetes secret in the `metadata.annotation` section as follows. Make sure to add the code as-is and not to change variables names. 
   ```
   csi.storage.k8s.io/provisioner-secret-name: ${pvc.name}
   csi.storage.k8s.io/provisioner-secret-namespace: ${pvc.namespace}
   ```
   {: codeblock} 
   
2. As the cluster user, create a Kubernetes secret that customizes the default settings of the storage class. 
   ```
   apiVersion: v1
   kind: Secret
   type: vpc.block.csi.ibm.io
   metadata:
     name: <secret_name>
     namespace: <namespace_name>
   stringData:
     iops: "<IOPS_value>"
     zone: "<zone>"
     tags: "<tags>"
     encrypted: <true_or_false>
     resourceGroup: "<resource_group>"
   data
     encryptionKey: <encryption_key>
   ```
   {: codeblock}
     
    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
        <tr>
           <td><code>metadata.name</code></td>
           <td>Enter a name for your Kubernetes secret. </td>
       </tr>
       <tr>
           <td><code>metadata.namespace</code></td>
           <td>Enter the namespace where you want to create your secret. To reference the secret in your PVC, the PVC must be created in the same namespace. </td>
       </tr>
       <tr>
          <td><code>stringData.iops</code></td>
          <td>Enter the range of IOPS that you want to allow for your VPC Block Storage instance. The range that you enter must match with the VPC Block Storage tier that you plan to use. </td>
       </tr>
       <tr>
          <td><code>stringData.zone</code></td>
          <td>Enter the VPC zone where you want to create the VPC Block Storage instance. Make sure that you use a zone that your worker nodes are connected to. To list VPC zones that your worker nodes use, run `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` and look at the <strong>Worker Zones</strong> field in your CLI output. If you do not specify a zone, one of the worker node zones is automatically selected for your VPC Block Storage instance.</td>
       </tr>
       <tr>
          <td><code>stringData.tags</code></td>
          <td>Enter a comma-separated list of tags to use when the PVC is created. Tags can help you find your storage instance more easily after it is created.</td>
       </tr>
       <tr>
          <td><code>stringData.resourceGroup</code></td>
          <td>Enter the resource group that you want your VPC Block Storage to get access to. If you do not enter a resource group, the VPC Block Storage instance is automatically authorized to access resources of the resource group that your cluster belongs to. </td>
       </tr>
       <tr>
          <td><code>stringData.encrypted</code></td>
          <td>Enter <strong>true</strong> to create a secret that sets up encryption for VPC Block Storage. If you set this option to <strong>true</strong>, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in <code>parameters.encryptionKey</code>. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       <tr>
          <td><code>data.encryptionKey</code></td>
          <td>If you entered <strong>true</strong> for <code>parameters.encrypted</code>, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your VPC Block Storage. To use your root key CRN in a secret, you must first convert it to base64 by running `echo  -n "<root_key_CRN>" | base64`. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       </tbody>
       </table>
   
3. Create your Kubernetes secret.
   ```
   kubectl apply -f secret.yaml
   ```
   {: pre}
   
4. Follow the steps in [Adding VPC Block Storage to your apps](#vpc-block-add) to create a PVC with your custom settings. Make sure to create the PVC with the customized storage class that the cluster admin created and use the same name for your PVC that you used for your secret. Using the same name for the secret and the PVC triggers the storage provider to apply the settings of the secret in your PVC. 


#### Enforcing base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key CRN
{: #static-secret}

1. As the cluster admin, create a Kubernetes secret that includes the base64 encoded value for your {{site.data.keyword.keymanagementserviceshort}} root key CRN. To retrieve the root key CRN, see [Setting up encryption for your VPC Block Storage](/docs/containers?topic=containers-vpc-block#vpc-block-encryption). 
   ```
   apiVersion: v1
   kind: Secret
   type: vpc.block.csi.ibm.io
   metadata:
     name: <secret_name>
     namespace: <namespace_name>
   stringData:
     encrypted: <true_or_false>
     resourceGroup: "<resource_group>"
   data
     encryptionKey: <encryption_key>
   ```
   {: codeblock}
     
    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
        <tr>
           <td><code>metadata.name</code></td>
           <td>Enter a name for your Kubernetes secret. </td>
       </tr>
       <tr>
           <td><code>metadata.namespace</code></td>
           <td>Enter the namespace where you want to create your secret. To reference the secret in your PVC, the PVC must be created in the same namespace. </td>
       </tr>
       <tr>
          <td><code>stringData.encrypted</code></td>
          <td>Enter <strong>true</strong> to create a secret that sets up encryption for VPC Block Storage. If you set this option to <strong>true</strong>, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in <code>parameters.encryptionKey</code>. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       <tr>
          <td><code>data.encryptionKey</code></td>
          <td>If you entered <strong>true</strong> for <code>parameters.encrypted</code>, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your VPC Block Storage. To use your root key CRN in a secret, you must first convert it to base 64 by running `echo  -n "<root_key_CRN>" | base64`. For more information about encrypting your data, see [Setting up encryption for your VPC Block Storage](#vpc-block-encryption).</td>
       </tr>
       </tbody>
       </table>
   
2. Create the Kubernetes secret.
   ```
   kubectl apply -f secret.yaml
   ```
   {: pre}

3. Follow the steps to [create a customized storage class](#vpc-customize-storage-class). In the customized storage class YAML file, reference the Kubernetes secret in the `metadata.annotation` section as follows. Make sure to enter the name of the Kubernetes secret that you created earlier and the namespace where you created the secret. 
   ```
   csi.storage.k8s.io/provisioner-secret-name: <secret_name>
   csi.storage.k8s.io/provisioner-secret-namespace: <secret_namespace>
   ```
   {: codeblock} 
   
4. As the cluster user, follow the steps in [Adding VPC Block Storage to your apps](#vpc-block-add) to create a PVC from your customized storage class. 
 
## Backing up and restoring data
{: #vpc-block-backup-restore}

Data that is stored on VPC Block Storage Block is secured across redundant fault zones in your region. To manually back up your data, use the Kubernetes `kubectl cp` command.
{: shortdesc}

You can use the `kubectl cp` [command![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) to copy files and directories to and from pods or specific containers in your cluster

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To back up or restore data, choose between the following options:

- Copy data from your local machine to a pod in your cluster:
  ```
  kubectl cp <local_filepath>/<filename> <namespace>/<pod>:<pod_filepath>
  ```
  {: pre}

- Copy data from a pod in your cluster to your local machine:
  ```
  kubectl cp <namespace>/<pod>:<pod_filepath>/<filename> <local_filepath>/<filename>
  ```
  {: pre}

- Copy data from your local machine to a specific container that runs in a pod in your cluster:
  ```
  kubectl cp <local_filepath>/<filename> <namespace>/<pod>:<pod_filepath> -c <container>
  ```
  {: pre}

## Storage class reference
{: #vpc-block-reference}

| Characteristics | Setting|
|:-----------------|:-----------------|
| Name | <code>ibmc-vpc-block-10iops-tier</code></br><code>ibmc-vpc-block-retain-10iops-tier</code>|
| File system | `ext4` |
| Corresponding VPC Block Storage tier | [10 IOPS/GB](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-profiles#tiers) |
| Billing | Hourly |
| Pricing | [Pricing information](/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-block-storage-for-vpc)|
{: class="simple-tab-table"}
{: caption="VPC Block Storage class: 10 IOPS-tier" caption-side="top"}
{: #vpc-block-10iops}
{: tab-title="10 IOPS-tier"}
{: tab-group="VPC block storage class"}

| Characteristics | Setting|
|:-----------------|:-----------------|
| Name | <code>ibmc-vpc-block-5iops-tier</code></br><code>ibmc-vpc-block-retain-5iops-tier</code>|
| File system | `ext4` |
| Corresponding VPC Block Storage tier | [5 IOPS/GB](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-profiles#tiers) |
| Billing | Hourly |
| Pricing | [Pricing information](/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-block-storage-for-vpc)|
{: class="simple-tab-table"}
{: caption="VPC Block Storage class: 5 IOPS-tier" caption-side="top"}
{: #vpc-block-5iops}
{: tab-title="5 IOPS-tier"}
{: tab-group="VPC block storage class"}

| Characteristics | Setting|
|:-----------------|:-----------------|
| Name | <code>ibmc-vpc-block-custom</code></br><code>ibmc-vpc-block-retain-custom</code>|
| File system | `ext4` |
| Corresponding VPC Block Storage tier | [Custom](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-profiles#custom) |
| Billing | Hourly |
| Pricing | [Pricing information](/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-block-storage-for-vpc)|
{: class="simple-tab-table"}
{: caption="VPC Block Storage class: custom" caption-side="top"}
{: #vpc-block-custom}
{: tab-title="Custom"}
{: tab-group="VPC block storage class"}

| Characteristics | Setting|
|:-----------------|:-----------------|
| Name | <code>ibmc-vpc-block-general-purpose</code></br><code>ibmc-vpc-block-retain-general-purpose</code>|
| File system | `ext4` |
| Corresponding VPC Block Storage tier | [3 IOPS/GB](/docs/vpc-on-classic-block-storage?topic=vpc-on-classic-block-storage-block-storage-profiles#tiers) |
| Billing | Hourly |
| Pricing | [Pricing information](/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-block-storage-for-vpc)|
{: class="simple-tab-table"}
{: caption="VPC Block Storage class: 3 IOPS-tier" caption-side="top"}
{: #vpc-block-3iops}
{: tab-title="General purpose"}
{: tab-group="VPC block storage class"}




