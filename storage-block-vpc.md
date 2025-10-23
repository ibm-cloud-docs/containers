---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-23"


keywords: containers, block storage, deploy apps

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# Setting up {{site.data.keyword.block_storage_is_short}}
{: #vpc-block}

[{{site.data.keyword.block_storage_is_short}}](/docs/vpc?topic=vpc-block-storage-about) provides hypervisor-mounted, high-performance data storage for your virtual server instances that you can provision within a VPC.
{: shortdesc}

You can choose between predefined storage tiers with GB sizes and IOPS that meet the requirements of your workloads. To find out if {{site.data.keyword.block_storage_is_short}} is the right storage option for you, see [Choosing a storage solution](/docs/containers?topic=containers-storage-plan). For pricing information, see [Pricing for {{site.data.keyword.block_storage_is_short}}](https://cloud.ibm.com/infrastructure/provision/vs){: external}.

The {{site.data.keyword.block_storage_is_short}} cluster add-on is enabled by default on VPC clusters.


## Quick start for {{site.data.keyword.cloud_notm}} {{site.data.keyword.block_storage_is_short}}
{: #vpc_block_qs}

In this quick start guide, you create a 10Gi 5IOPS tier {{site.data.keyword.block_storage_is_short}} volume in your cluster by creating a PVC to dynamically provision the volume. Then, you create an app deployment that mounts your PVC.
{: shortdesc}

Before you begin, choose from the [available generation 2 storage classes](/docs/containers?topic=containers-storage-block-vpc-sc-ref).

Your {{site.data.keyword.block_storage_is_short}} volumes can be mounted by multiple pods as long as those pods are scheduled on the same node.
{: note}

1. Create a file for your PVC and name it `pvc.yaml`.

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: my-pvc
    spec:
      storageClassName: ibmc-vpc-block-5iops-tier
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
    ```
    {: codeblock}

    Example using the `ibmc-vpc-block-sdp` storage class:

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: my-pvc
    spec:
      storageClassName: ibmc-vpc-block-sdp
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
    ```
    {: codeblock}

2. Create the PVC in your cluster.

    ```sh
    kubectl apply -f pvc.yaml
    ```
    {: pre}

3. After your PVC is bound, create an app deployment that uses your PVC. Create a file for your deployment and name it `deployment.yaml`.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: my-deployment
        labels:
          app: my-app
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - image: ngnix # Your containerized app image.
            name: my-container
            volumeMounts:
            - name: my-volume
              mountPath: /mount-path
          volumes:
          - name: my-volume
            persistentVolumeClaim:
              claimName: my-pvc
    ```
    {: codeblock}

4. Create the deployment in your cluster.

    ```sh
    kubectl apply -f deployment.yaml
    ```
    {: pre}

For more information, see the following links.

* [Adding {{site.data.keyword.block_storage_is_short}} to apps](#vpc-block-add).  
* [Storage class reference](/docs/containers?topic=containers-storage-block-vpc-sc-ref).  
* [Customizing the default storage settings](#vpc-customize-default).  

## Adding {{site.data.keyword.block_storage_is_short}} to your apps
{: #vpc-block-add}

Choose your {{site.data.keyword.block_storage_is_short}} profile and create a persistent volume claim to dynamically provision {{site.data.keyword.block_storage_is_short}} for your cluster. Dynamic provisioning automatically creates the matching persistent volume and orders the physical storage device in your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

1. Decide on the [{{site.data.keyword.block_storage_is_short}} profile](/docs/vpc?topic=vpc-block-storage-profiles) that best meets the capacity and performance requirements that you want.

2. Select the corresponding storage class for your {{site.data.keyword.block_storage_is_short}} profile.

    All IBM pre-defined storage classes set up {{site.data.keyword.block_storage_is_short}} with an `ext4` file system by default. If you want to use a different file system, such as `xfs` or `ext3`, [create a customized storage class](#vpc-customize-storage-class).
    {: note}
    
    - 10 IOPS/GB: `ibmc-vpc-block-10iops-tier` or `ibmc-vpc-block-retain-10iops-tier`  
    - 5 IOPS/GB: `ibmc-vpc-block-5iops-tier` or `ibmc-vpc-block-retain-5iops-tier`  
    - 3 IOPS/GB: `ibmc-vpc-block-general-purpose` or `ibmc-vpc-block-retain-general-purpose` 
    - Custom: `ibmc-vpc-block-custom` or `ibmc-vpc-block-retain-custom`  

3. Decide on your {{site.data.keyword.block_storage_is_short}} configuration.
    1. Choose a size for your storage. Make sure that the size is supported by the {{site.data.keyword.block_storage_is_short}} profile that you chose.
    2. Choose if you want to keep your data after the cluster or the persistent volume claim (PVC) is deleted.
        - If you want to keep your data, then choose a `retain` storage class. When you delete the PVC, only the PVC is deleted. The persistent volume (PV), the physical storage device in your {{site.data.keyword.cloud_notm}} account, and your data still exist. To reclaim the storage and use it in your cluster again, you must remove the PV and follow the steps for using existing {{site.data.keyword.block_storage_is_short}}.
        - If you want the PV, the data, and your physical {{site.data.keyword.block_storage_is_short}} device to be deleted when you delete the PVC, choose a storage class without `retain`.

4. Create a configuration file to define your persistent volume claim and save the configuration as a YAML file.

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name> # Enter a name for your PVC.
    spec:
      accessModes:
      - <access-mode> # ReadWriteOnce or ReadWriteOncePod
      resources:
        requests:
          storage: 10Gi # Enter the size. Make sure that the size is supported in the profile that you chose.
      storageClassName: <storage_class> # Enter the storage class name that you selected earlier.
    ```
    {: codeblock}

5. Create the PVC in your cluster.

    ```sh
    kubectl apply -f pvc.yaml
    ```
    {: pre}

6. Verify that your PVC is created and bound to the PV. This process can take a few minutes.

    ```sh
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Example output
    
    ```sh
    Name:          mypvv
    Namespace:     default
    StorageClass:  ibmc-vpc-block-5iops-tier
    Status:        Bound
    Volume:        
    Labels:        <none>
    Annotations:   kubectl.kubernetes.io/last-applied-configuration: {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{},"name":"csi-block-pvc-good","namespace":"default"},"spec":{...
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

    ```yaml
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


    `labels.app`
    :   In the metadata section, enter a label for the deployment. 
    
    `matchLabels.app` and `labels.app`
    :   In the spec selector and template metadata sections, enter a label for your app.
    
    `image`
    :   Specify the name of the container image that you want to use. To list available images in your {{site.data.keyword.registrylong_notm}} account, run `ibmcloud cr image-list`.
    
    `name`
    :   Specify the name of the container that you want to deploy in your pod.
    
    `mountPath`
    :   In the container volume mounts section, specify the absolute path of the directory to where the PVC is mounted inside the container.
    
    `name`
    :   In the container volume mounts section, enter the name of the volume to mount to your pod. You can enter any name that you want. 
    
    `name`
    :   In the volumes section, enter the name of the volume to mount to your pod. Typically this name is the same as `volumeMounts.name`.
    
    `claimName`
    :   In the volumes persistent volume claim section, enter the name of the PVC that you created earlier.


8. Create the deployment in your cluster.

    ```sh
    kubectl apply -f deployment.yaml
    ```
    {: pre}

9. Verify that the PVC is successfully mounted to your app. It might take a few minutes for your pods to get into a **Running** state.

    During the deployment of your app, you might see intermittent `Unable to mount volumes` errors in the **Events** section of your CLI output. The {{site.data.keyword.block_storage_is_short}} cluster add-on automatically retries mounting the storage to your apps. Wait a few more minutes for the storage to mount to your app.
    {: tip}

    ```sh
    kubectl describe deployment <deployment_name>
    ```
    {: pre}

    Example output
    
    ```sh
    ...
    Volumes:
    myvol:
        Type:    PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName:    mypvc
        ReadOnly:    false
    ```
    {: screen}


## Using an existing {{site.data.keyword.block_storage_is_short}} instance
{: #vpc-block-static}

If you have an existing physical {{site.data.keyword.block_storage_is_short}} device that you want to use in your cluster, you can manually create the PV and PVC to statically provision the storage.
{: shortdesc}


You can attach a volume to one worker node only. Make sure that the volume is in the same zone as the worker node for the attachment to succeed.
{: note}

1. Determine the volume that you want to attach to a worker node in your VPC cluster. Note the **volume ID**.

    ```sh
    ibmcloud is volumes
    ```
    {: pre}

2. List the details of your volume. Note the **Size**, **Zone**, and **IOPS**. These values are used to create your PV.

    ```sh
    ibmcloud is volume <volume_id>
    ```
    {: pre}

3. Retrieve a list of worker nodes in your VPC cluster. Note the **Zone** of the worker node that is in the same zone as your storage volume.

    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

4. Optional: If you provisioned your physical {{site.data.keyword.block_storage_is_short}} instance by using a `retain` storage class, the PV and the physical storage is not removed when you remove the PVC. To use your physical {{site.data.keyword.block_storage_is_short}} device in your cluster, you must remove the existing PV first.  

    1. List the PVs in your cluster and look for the PV that belongs to your {{site.data.keyword.block_storage_is_short}} device. The PV is in a `released` state.
    
        ```sh
        kubectl get pv
        ```
        {: pre}

    2. Remove the PV.
    
        ```sh
        kubectl delete pv <pv_name>
        ```
        {: pre}

5. Create a configuration file for your PV. Include the **ID**, **Size**, **Zone**, and **IOPS** that you retrieved earlier.

    ```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: <pv_name> # Example: my-persistent-volume
    spec:
      accessModes:
      - ReadWriteOnce
      capacity:
        storage: <vpc_block_storage_size> # Example: 20Gi
      csi:
        driver: vpc.block.csi.ibm.io
        fsType: ext4
        volumeAttributes:
          iops: "<vpc_block_storage_iops>" # Example: "3000"
          volumeId: <vpc_block_storage_ID> # Example: a1a11a1a-a111-1111-1a11-1111a11a1a11
          zone: "<vpc_block_zone>" # Example: "eu-de-3"
          region: "<vpc_block_region>"
        volumeHandle: <vpc_block_storage_ID>
      nodeAffinity:
        required:
          nodeSelectorTerms:
          - matchExpressions:
            - key: failure-domain.beta.kubernetes.io/zone
              operator: In
              values:
              - <worker_node_zone> # Example: eu-de-3
            - key: failure-domain.beta.kubernetes.io/region
              operator: In
              values:
              - <worker_node_region> # Example: eu-de
            - key: kubernetes.io/hostname
              operator: In
              values:
              - <worker_node_primary_IP>
      persistentVolumeReclaimPolicy: Retain
      storageClassName: ""
      volumeMode: Filesystem
    ```
    {: codeblock}

    `name`
    :   In the metadata section, enter a name for your PV.
    
    `storage`
    :   In the spec capacity section, enter the size of your {{site.data.keyword.block_storage_is_short}} volume in gigabytes (Gi) that you retrieved earlier. For example, if the size of your device is 100 GB, enter `100Gi`.
    
    `iops`
    :   In the spec CSI volume attributes section, enter the Max IOPS of the {{site.data.keyword.block_storage_is_short}} volume that you retrieved earlier.
    
    `zone`
    :   In the spec CSI volume attributes section, enter the VPC block zone that matches the location that you retrieved earlier. For example, if your location is `Washington DC-1`, then use `us-east-1` as your zone. To list available zones, run `ibmcloud is zones`. To find an overview of available VPC zones and locations, see [Creating a VPC in a different region](/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region). Please mention "region" parameter when "zone" is specified.

    `region`
    :   The region of the worker node where you want to attach storage.
    
    `worker_node_primary_IP`
    :   The primary IP of the worker node where you want to attach storage. You can find the primary IP of your worker node by running `ibmcloud ks worker ls`.
    
    `volumeId` and `spec.csi.volumeHandle`
    :   In the spec CSI volume attributes section, enter the ID of the {{site.data.keyword.block_storage_is_short}} volume that you retrieved earlier.
    
    `storageClassName`
    :   For the spec storage class name, enter an empty string.
    
    `matchExpressions`
    :   In the spec node affinity section, enter the node selector terms to match the zone. For the key, enter `failure-domain.beta.kubernetes.io/zone`. For the value, enter the zone of your worker node where you want to attach storage.
    
    `matchExpressions`
    :   In the spec node affinity section, enter the node selector terms to match the region. For the key, enter `failure-domain.beta.kubernetes.io/region`. For the value, enter the region of the worker node where you want to attach storage. 

6. Create the PV in your cluster.

    ```sh
    kubectl apply -f pv.yaml
    ```
    {: pre}

7. Verify that the PV is created in your cluster.

    ```sh
    kubectl get pv
    ```
    {: pre}

8. Create another configuration file for your PVC. In order for the PVC to match the PV that you created earlier, you must choose the same value for the storage size and access mode. In your storage class field, enter an empty string value to match your PV. If any of these fields don't match the PV, then a new PV and a {{site.data.keyword.block_storage_is_short}} instance are created automatically via dynamic provisioning.

    ```yaml
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

9. Create your PVC.

    ```sh
    kubectl apply -f pvc.yaml
    ```
    {: pre}

10. Verify that your PVC is created and bound to the PV that you created earlier. This process can take a few minutes.

    ```sh
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

11. Create a deployment or a pod that uses your PVC.

    ```yaml
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
          nodeSelector:
            kubernetes.io/hostname: "<worker_node_primary_IP>"
    ```
    {: codeblock}
    

## Updating the {{site.data.keyword.block_storage_is_short}} cluster add-on
{: #vpc-addon-update}

You can update the {{site.data.keyword.block_storage_is_short}} cluster add-on by using the `addon update` command.
{: shortdesc}


Before updating the add-on review the [change log](/docs/containers?topic=containers-cl-add-ons-vpc-block-csi-driver).
{: tip}

Before you update to a `5.x` release from a previous release, you must not have any volume snapshots in `failure` state. For more information, see [Why can't I delete my Block Storage for VPC volume snapshot resources?](/docs/containers?topic=containers-ts-storage-volumesnapshotdelete).
{: important}

1. Check to see if an update is available. If an update is available, the plug-in version is flagged with an asterisk and the latest version is shown. Note the latest version as this value is used later.

    ```sh
    ibmcloud ks cluster addons --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output
    
    ```sh
    Name                   Version                 Health State   Health Status   
    vpc-block-csi-driver   1.0.0* (2.0.0 latest)   normal         Addon Ready
    ```
    {: screen}


1. Update the add-on. Note that the update commands are different depending on the version that you have installed.

    [5.0 and later]{: tag-blue} Run the `addon update` command.

    ```sh
    ibmcloud ks cluster addon update vpc-block-csi-driver --cluster CLUSTER [-f] [-q] [--version VERSION] [-y]
    ```
    {: pre}

    [All versions before version 5.0]{: tag-red} Disable and enable the add-on.

    ```sh
    ibmcloud ks cluster addon disable vpc-block-csi-driver --cluster CLUSTER [-f] [-q]
    ```
    {: pre}

    ```sh
    ibmcloud ks cluster addon enable vpc-block-csi-driver --cluster CLUSTER [-f] [-q] [--version VERSION] [-y]
    ```
    {: pre}

1. Verify that the add-on is in the `Addon Ready` state. The add-on might take a few minutes to become ready.

    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output
    
    ```sh
    Name                   Version   Health State   Health Status   
    vpc-block-csi-driver   2.0.0     normal         Addon Ready
    ```
    {: screen}
    
    
    
    If you use a default storage class other than the `ibmc-vpc-block-10iops-tier` storage class you must change the default storage class settings in the `addon-vpc-block-csi-driver-configmap` ConfigMap. For more information, see [Changing the default storage class](/docs/containers?topic=containers-vpc-block#vpc-block-default-edit).
    {: important}
    
1. If you created your own storage classes based on the default {{site.data.keyword.block_storage_is_short}} storage classes, you must re-create those storage classes to update the parameters. For more information, see [Recreating your own storage classes after updating to version 4.2](#recreate-sc-42).
    


### Re-creating your own storage classes after updating to version 4.2
{: #recreate-sc-42}



With version 4.2, the default parameters for storage classes has changed. The `sizeRange` or `iopsRange` parameters are no longer used. If you created any of your own storage classes that use these parameters, you must edit your own storage classes to remove these parameters. To change the parameters in your own storage classes, you must delete and re-create them. Previously, `sizeRange` and `iopsRange` were provided each storage class as reference information. With version 4.2, these references have been removed. Now, for information about block storage profiles, sizes, and IOPs, see the [block storage profiles](/docs/vpc?topic=vpc-block-storage-profiles&interface=ui) reference.
{: important}


1. To find the details of your own storage classes, run the following command.

    ```sh
    kubectl describe sc STORAGECLASS
    ```
    {: pre}

1. If the storage class uses the `sizeRange` or `iopsRange`, get the storage class YAML and save it to a file.
    ```sh
    kubectl get sc STORAGECLASS -o yaml
    ```
    {: pre}
    
1. In the file that you saved from the output of the previous command, remove the `sizeRange` or `iopsRange` parameters.

1. Delete the storage class from your cluster.
    ```sh
    kubectl delete sc STORAGECLASS
    ```
    {: pre}
    
1. Recreate the storage class in your cluster by using the file you created earlier.
    ```sh
    kubectl apply -f custom-storage-class.yaml
    ```
    {: pre}
        


## Setting up encryption for {{site.data.keyword.block_storage_is_short}}
{: #vpc-block-encryption}

Use a key management service (KMS) provider, such as {{site.data.keyword.keymanagementservicelong}}, to create a private root key that you use in your {{site.data.keyword.block_storage_is_short}} instance to encrypt data as it is written to the storage. After you create the private root key, create your own storage class or a Kubernetes secret with your root key and then use this storage class or secret to provision your {{site.data.keyword.block_storage_is_short}} instance.
{: shortdesc}

Enabling encryption for {{site.data.keyword.block_storage_is_short}} impacts performance by approximately 20%. However, the exact impact depends on your worker node and storage volume configuration. Consider allowing for performance impacts when enabling encryption.
{: note}

1. Create an instance of the KMS provider that you want to use.
    - [{{site.data.keyword.keymanagementserviceshort}}](/docs/key-protect?topic=key-protect-provision#provision).
    - [{{site.data.keyword.hscrypto}}](https://cloud.ibm.com/catalog/services/hyper-protect-crypto-services){: external}.

1. Create a root key in your KMS instance.
    - [{{site.data.keyword.keymanagementserviceshort}} root key](/docs/key-protect?topic=key-protect-create-root-keys#create-root-keys).
    - [{{site.data.keyword.hscrypto}} root key](/docs/hs-crypto?topic=hs-crypto-create-root-keys). By default, the root key is created without an expiration date.

1. [Set up service to service authorization](/docs/account?topic=account-serviceauth). Authorize {{site.data.keyword.block_storage_is_short}} to access {{site.data.keyword.keymanagementservicelong}}. Make sure to give {{site.data.keyword.block_storage_is_short}} at least `Reader` access to your KMS instance.
    

1. [Decide if you want to store the {{site.data.keyword.keymanagementserviceshort}} root key CRN in a customized storage class or in a Kubernetes secret](/docs/containers?topic=containers-vpc-block#vpc-customize-default). Then, follow the steps to create a customized storage class or a Kubernetes secret.

    Example customized storage class.
    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: <storage_class_name> # Enter a name for your storage class.
    provisioner: vpc.block.csi.ibm.io
    parameters:
      profile: "5iops-tier"
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


    `encrypted`
    :   In the parameters, enter `true` to create a storage class that sets up encryption for your {{site.data.keyword.block_storage_is_short}} volumes. If you set this option to `true`, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in `parameters.encryptionKey`.

    `encryptionKey`
    :   In the parameters, enter the root key CRN that you retrieved earlier.

    Example Kubernetes secret.
    ```yaml
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

    `name`
    :   Enter a name for your secret.

    `namespace`
    :   Enter the namespace where you want to create your secret.

    `encrypted`
    :   In the parameters, enter `true` to set up encryption for your {{site.data.keyword.block_storage_is_short}} volumes. 

    `encryptionKey`
    :   In the parameters, enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your {{site.data.keyword.block_storage_is_short}} volume. To use your root key CRN in a secret, you must first convert it to base64 by running `echo  -n "<root_key_CRN>" | base64`. 


6. Follow steps 4-9 in [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision {{site.data.keyword.block_storage_is_short}} that is configured for encryption with your {{site.data.keyword.keymanagementserviceshort}} root key. Then, mount this storage to an app pod.

    Your app might take a few minutes to mount the storage and get into a **Running** state.
    {: note}

7. Verify that your data is encrypted. List your {{site.data.keyword.block_storage_is_short}} volumes and note the **ID** of the instance that you created. The storage instance **Name** equals the name of the PV that was automatically created when you created the PVC.
    
    ```sh
    ibmcloud is vols
    ```
    {: pre}

    Example output
    
    ```sh
    ID                                     Name                                       Status      Capacity   IOPS   Profile           Attachment type   Created                     Zone         Resource group
    a395b603-74bf-4703-8fcb-b68e0b4d6960   pvc-479d590f-ca72-4df2-a30a-0941fceeca42   available   10         3000   5iops-tier        data              2019-08-17T12:29:18-05:00   us-south-1   a8a12accd63b437bbd6d58fb6a462ca7
    ```
    {: screen}

8. Using the volume **ID**, list the details for your {{site.data.keyword.block_storage_is_short}} instance to ensure that your {{site.data.keyword.keymanagementserviceshort}} root key is stored in the storage instance. You can find the root key in the **Encryption key** field of your CLI output.

    ```sh
    ibmcloud is vol <volume_ID>
    ```
    {: codeblock}

    Example output
    
    ```sh
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

You can change some default PVC settings by using a customized storage class or a Kubernetes secret to create {{site.data.keyword.block_storage_is_short}} with your customized settings.
{: shortdesc}

What is the benefit of using a secret and specifying my parameters in a customized storage class?
:   As a cluster admin, [create a customized storage class](#vpc-customize-storage-class) when you want all the PVCs that your cluster users create to be provisioned with a specific configuration and you don't want to enable your cluster users to override the default configuration.
:   However, when multiple configurations are required and you don't want to create a customized storage class for every possible PVC configuration, you can create one customized storage class with the default PVC settings and a reference to a generic [Kubernetes secret](#vpc-block-storageclass-secret). If your cluster users must override the default settings of your customized storage class, they can do so by creating a Kubernetes secret that holds their custom settings.

When you want to set up encryption for your {{site.data.keyword.block_storage_is_short}} instance, you can also use a Kubernetes secret if you want to encode the {{site.data.keyword.keymanagementserviceshort}} root key CRN to base64 instead of providing the key directly in the customized storage class.



### Changing the default storage class
{: #vpc-block-default-edit}

With version 4.2 the {{site.data.keyword.block_storage_is_short}} cluster add-on sets the default storage class to the `ibmc-vpc-block-10iops-tier` class. If you have a default storage class other than `ibmc-vpc-block-10iops-tier` and your PVCs use the default storage class, this can result in multiple default storage classes which can cause PVC creation failures. To use a default storage class other than `ibmc-vpc-block-10iops-tier`, you can update the `addon-vpc-block-csi-driver-configmap` to change the `IsStorageClassDefault` to false.
{: important}

The default storage class for the {{site.data.keyword.block_storage_is_short}} cluster add-on is the `ibmc-vpc-block-10iops-tier` storage class.

1. Edit the `addon-vpc-block-csi-driver-configmap`
    ```sh
    kubectl edit cm addon-vpc-block-csi-driver-configmap -n kube-system
    ```
    {: pre}
    
2. Change the `IsStorageClassDefault` setting to `false`.

3. Save and exit.

4. Wait 15 minutes and verify the change by getting the details of the `ibmc-vpc-block-10iops-tier` storage class.
    ```sh
    kubectl get sc ibmc-vpc-block-10iops-tier -o yaml
    ```
    {: pre}
    


### Creating your own storage class
{: #vpc-customize-storage-class}

Create your own customized storage class with the preferred settings for your {{site.data.keyword.block_storage_is_short}} instance. By using the SDP profile, you can specify the capacity, and the maximum throughput limit.
{: shortdesc}

SSD defined performance profiles (SDP) are available in Dallas, Frankfurt, London, Madrid, Osaka, Sao Paulo, Sydney, Tokyo, Toronto, and Washington, D.C. Snapshot creation for SSD defined performance profiles is available in Dallas, Frankfurt, Tokyo, and Washington, D.C.
{: note}

You might create your own storage class if you want to:
* Set a custom IOPs value.
* Set up {{site.data.keyword.block_storage_is_short}} with a file system type other than `ext4`.
* Set up encryption.
* Set up SSD defined performance.

Before you begin
- Review the [Storage class reference](/docs/containers?topic=containers-storage-block-vpc-sc-ref) to determine the `profile` that you want to use for your storage class.

- You can also review the [custom profiles](/docs/vpc?topic=vpc-block-storage-profiles#custom) if you want to specify custom IOPs for your {{site.data.keyword.block_storage_is_short}}.

- If you want to use an SSD defined performance (SDP) profile, [review the capacity range and IOPs details](/docs/vpc?topic=vpc-block-storage-profiles&interface=ui#defined-performance-profile). Note that when using an SSD defined performance, the capacity of the volume is determine by the IOPs and throughput that you specify. 

- You can use an existing storage class as a starting point for creating your own class. Save the details of an existing storage class by using the `kubectl get sc <storageclass> -o yaml` command.

- To keep costs low, you can initially provision a PVC with low capacity, minimum IOPS, and minimum throughput using the `ibmc-vpc-block-sdp` storage class, which has a minimum of 3000 IOPS and 1000 Throughput (Mbps). After provisioning, you can access the PVC and adjust the [IOPS](/docs/vpc?topic=vpc-adjusting-volume-iops&interface=ui) and [throughput](/docs/vpc?topic=vpc-adjusting-volume-throughput&interface=ui) as needs are better defined.

To create a custom storage class:

1. Create a customized storage class configuration file in the following format.

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: <storage_class_name>
    provisioner: vpc.block.csi.ibm.io
    parameters:
      profile: "<profile>" # general-purpose, sdp, 5iops-tier, 10iops-tier, or custom
      csi.storage.k8s.io/fstype: "<file_system_type>" # xfs, ext3, or ext4
      billingType: "hourly"
      encrypted: "<encrypted_true_false>"
      encryptionKey: "<encryption_key>"
      resourceGroup: ""
      zone: "<zone>"
      region: "<region>"
      tags: "<tags>"
      generation: "gc"
      throughput: "<throughput>" # Example: 2000
      classVersion: "1"
      iops: "<iops>" # Only specify this parameter if you are using a "custom" profile.
    allowVolumeExpansion: (true|false) # Select true or false. Only supported on version 3.0.1 and later
    volumeBindingMode: <volume_binding_mode>
      # csi.storage.k8s.io/provisioner-secret-name: # Uncomment and add secret parameters to enforce encryption. 
      # csi.storage.k8s.io/provisioner-secret-namespace: 
    reclaimPolicy: "<reclaim_policy>"
    ```
    {: codeblock}

    `name`
    :   Enter a name for your storage class.
    
    `profile`
    :   Enter the profile that you selected in the previous step. Choose `general-purpose`, `sdp`, `5iops-tier`, `10iops-tier`, or custom use a custom IOPs value. To find supported storage sizes for a specific profile, see [Tiered IOPS profile](/docs/vpc?topic=vpc-block-storage-profiles). Any PVC that uses this storage class must specify a size value that is within this range.
        
    `csi.storage.k8s.io/fstype`
    :   In the parameters, enter the file system for your {{site.data.keyword.block_storage_is_short}} instance. Choose `xfs`, `ext3`, or `ext4`. If you want to modify the ownership or permissions of your volume you must specify the `csi.storage.k8s.io/fstype` in your own storage class and your PVC must have `ReadWriteOnce` as the `accessMode`. The {{site.data.keyword.block_storage_is_short}} driver uses the `ReadWriteOnceWithFSType` `fsGroupPolicy`. For more information, see [CSI driver documentation](https://kubernetes-csi.github.io/docs/support-fsgroup.html#csi-driver-fsgroup-support){: external}.

    `encrypted`
    :   In the parameters, enter `true` to create a storage class that sets up encryption for your {{site.data.keyword.block_storage_is_short}} volume. If you set this option to `true`, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in `parameterencryptionKey`. For more information about encrypting your data, see [Setting up encryption for your {{site.data.keyword.block_storage_is_short}}](#vpc-block-encryption).

    `encryptionKey`
    :   If you entered `true` for `parameters.encrypted`, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your {{site.data.keyword.block_storage_is_short}} volume. For more information about encrypting your data, see [Setting up encryption for your {{site.data.keyword.block_storage_is_short}}](#vpc-block-encryption).

    `zone`
    :   In the parameters, enter the VPC zone where you want to create the {{site.data.keyword.block_storage_is_short}} instance. Make sure that you use a zone that your worker nodes are connected to. To list VPC zones that your worker nodes use, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>` and look at the **Worker Zones** field in your CLI output. If you don't specify a zone, one of the worker node zones is automatically selected for your {{site.data.keyword.block_storage_is_short}} instance.

    `region`
    :   The region of the worker node where you want to attach storage.

    `tags`
    :   In the parameters, enter a space-separated list of tags to apply to your {{site.data.keyword.block_storage_is_short}} instance. Tags can help you find instances more easily or group your instances based on common characteristics, such as the app or the environment that it is used for. 

    `iops`
    :   If you entered `custom` or `sdp` for the `profile`, enter a value for the IOPs that you want your {{site.data.keyword.block_storage_is_short}} to use. Refer to the [{{site.data.keyword.block_storage_is_short}} custom IOPs profile](/docs/vpc?topic=vpc-block-storage-profiles#custom) table for a list of supported IOPs ranges by volume size.

    `throughput`
    :   Enter this value is you are using an `sdp` profile. For more information, see the [IOPs and throughput details for the SDP profile](/docs/vpc?topic=vpc-block-storage-profiles&interface=ui#defined-performance-profile)

    `reclaimPolicy`
    :   Enter the reclaim policy for your storage class. If you want to keep the PV, the physical storage device and your data when you remove the PVC, enter `Retain`. If you want to delete the PV, the physical storage device and your data when you remove the PVC, enter `Delete`.

    `allowVolumeExpansion`
    :   Enter the volume expansion policy for your storage class. If you want to allow volume expansion, enter `true`. If you don't want to allow volume expansion, enter `false`.

    `volumeBindingMode`
    :   Choose if you want to delay the creation of the {{site.data.keyword.block_storage_is_short}} instance until the first pod that uses this storage is ready to be scheduled. To delay the creation, enter `WaitForFirstConsumer`. To create the instance when you create the PVC, enter `Immediate`.

    Example storage class selection:

    If you provision a 9.6TB PVC using the `ibmc-vpc-block-5iops-tier` storage class, the maximum IOPS is 48,000 and the maximum throughput is 6144 Mbps. However, with the `ibmc-vpc-block-sdp-max-bandwidth` storage class, the maximum IOPS is 64,000 and maximum throughput is 8192 Mbps. 

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: ibmc-vpc-block-sdp-max-bandwidth
    provisioner: vpc.block.csi.ibm.io
    parameters:
      profile: "sdp" # general-purpose, sdp, 5iops-tier, 10iops-tier, or custom
      csi.storage.k8s.io/fstype: "ext4" # xfs, ext3, or ext4
      billingType: "hourly"
      encrypted: "false"
      encryptionKey: ""
      resourceGroup: ""
      zone: "us-east"
      region: "tor01"
      tags: "tag"
      generation: "gc"
      throughput: "8192" # Example: 2000
      classVersion: "1"
      iops: "64000" # Only specify this parameter if you are using a "custom" profile.
    allowVolumeExpansion: true # Select true or false. Only supported on version 3.0.1 and later
    volumeBindingMode: Immediate
    reclaimPolicy: "Delete"
    ```
    {: codeblock}

3. Create the customized storage class in your cluster.

    ```sh
    kubectl apply -f custom-storageclass.yaml
    ```
    {: pre}

4. Verify that your storage class is available in the cluster.

    ```sh
    kubectl get sc
    ```
    {: pre}

    Example output
    
    ```sh
    NAME                                    PROVISIONER            AGE
    <custom-storageclass>             vpc.block.csi.ibm.io   4m26s
    ```
    {: screen}

5. Follow the steps in [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision {{site.data.keyword.block_storage_is_short}}. Then, mount this storage to a sample app.

6. **Optional**: [Verify your {{site.data.keyword.block_storage_is_short}} file system type](#vpc-block-fs-verify).

### Verifying your {{site.data.keyword.block_storage_is_short}} file system
{: #vpc-block-fs-verify}

You can create a customized storage class to provision {{site.data.keyword.block_storage_is_short}} with a different file system, such as `xfs` or `ext3`. By default, all {{site.data.keyword.block_storage_is_short}} instances are provisioned with an `ext4` file system.
{: shortdesc}

1. Follow the steps to [create a customized storage class](#vpc-customize-storage-class) with the file system that you want to use.

2. Follow steps 4-9 in [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) to create a PVC with your customized storage class to provision {{site.data.keyword.block_storage_is_short}} with a different file system. Then, mount this storage to an app pod.

    Your app might take a few minutes to mount the storage and get into a **Running** state.
    {: note}

3. Verify that your storage is mounted with the correct file system. List the pods in your cluster and note the **Name** of the pod that you used to mount your storage.
    
    ```sh
    kubectl get pods
    ```
    {: pre}

4. Log in to your pod.

    ```sh
    kubectl exec <pod_name> -it bash
    ```
    {: pre}

5. List the mount paths inside your pod.
  
    ```sh
    mount | grep /dev/xvdg
    ```
    {: pre}

    Example output for `xfs`.
    
    ```sh
    /dev/xvdg on /test type xfs (rw,relatime,attr2,inode64,noquota)
    ```
    {: pre}

6. Exit your pod.

    ```sh
    exit
    ```
    {: pre}


### Updating the `VolumeAttachLimit`
{: #vpc-block-volume-attach-limit}

In versions `5.2` and later of the {{site.data.keyword.block_storage_is_short}} cluster add-on, you can edit the maximum number of volumes that can be attached to each node by editing the configmap. The default value is `12`.

Your account must be approved to use this feature.
{: important}

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Edit the configmap. Replace `VALUE` with the volume attachment limit that you want to set.
    ```sh
    kubectl patch configmap/addon-vpc-block-csi-driver-configmap \       
    -n kube-system \
    --type merge \
    -p '{"data":{"VolumeAttachmentLimit":"VALUE"}}'
    ```
    {: pre}

1. Wait for the `ibm-vpc-block-csi-node` pods in the `kube-system` namespace to restart. Verify that the pods have restarted.
    ```sh
    kubectl get pods -n kube-system -w| grep block-csi
    ```
    {: pre}

1. You can now attach volumes to your worker nodes by using dynamic provisioning or by manually creating the attachments. For more information, see [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) or [Using an existing {{site.data.keyword.block_storage_is_short}} instance](#vpc-block-static).



### Storing your custom PVC settings in a Kubernetes secret
{: #vpc-block-storageclass-secret}

Specify your PVC settings in a Kubernetes secret and reference this secret in a customized storage class. Then, use the customized storage class to create a PVC with the custom parameters that you set in your secret.
{: shortdesc}

What options do I have to use the Kubernetes secret?
:   As a cluster admin, you can choose if you want to allow each cluster user to override the default settings of a storage class, or if you want to create one secret that everyone in your cluster must use and that enforces base64 encoding for your {{site.data.keyword.keymanagementserviceshort}} root key CRN.

[Every user can customize the default settings](#customize-with-secret)  
:   In this scenario, the cluster admin creates one customized storage class with the default PVC settings and a reference to a generic Kubernetes secret. Cluster users can override the default settings of the storage class by creating a Kubernetes secret with the PVC settings that they want. In order for the customized settings in the secret to get applied to your {{site.data.keyword.block_storage_is_short}} instance, you must create a PVC with the same name as your Kubernetes secret.

[Enforce base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key](#static-secret)  
:   In this scenario, you create one customized storage class with the default PVC settings and a reference to a static Kubernetes secret that overrides or enhances the default settings of the customized storage class. Your cluster users can't override the default settings by creating their own Kubernetes secret. Instead, cluster users must provision {{site.data.keyword.block_storage_is_short}} with the configuration that you chose in your customized storage class and secret. The benefit of using this method over creating a [customized storage class](#vpc-customize-storage-class) only is that you can enforce base64 encoding for the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance when you want to encrypt the data in your {{site.data.keyword.block_storage_is_short}} instance.  

What do I need to be aware of before I start using the Kubernetes secret for my PVC settings?
:   Some PVC settings, such as the `reclaimPolicy`, `fstype`, or the `volumeBindingMode` can't be set in the Kubernetes secret and must be set in the storage class. As the cluster admin, if you want to enable your cluster users to override your default settings, you must ensure that you set up enough customized storage classes that reference a generic Kubernetes secret so that your users can provision {{site.data.keyword.block_storage_is_short}} with different `reclaimPolicy`, `fstype`, and `volumeBindingMode` settings.

### Enabling every user to customize the default PVC settings
{: #customize-with-secret}

1. As the cluster admin, follow the steps to [create a customized storage class](#vpc-customize-storage-class). In the customized storage class YAML file, reference the Kubernetes secret in the `metadata.parameters` section as follows. Make sure to add the code as-is and not to change variables names.

    ```sh
    csi.storage.k8s.io/provisioner-secret-name: ${pvc.name}
    csi.storage.k8s.io/provisioner-secret-namespace: ${pvc.namespace}
    ```
    {: codeblock}

2. As the cluster user, create a Kubernetes secret that customizes the default settings of the storage class.
    ```yaml
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

    `name`
    :   Enter a name for your Kubernetes secret. 
    
    `namespace`
    :   Enter the namespace where you want to create your secret. To reference the secret in your PVC, the PVC must be created in the same namespace. 
    
    `iops`
    :   In the string data section, enter the range of IOPS that you want to allow for your {{site.data.keyword.block_storage_is_short}} instance. The range that you enter must match the {{site.data.keyword.block_storage_is_short}} tier that you plan to use. 
    
    `zone`
    :   In the string data section, enter the VPC zone where you want to create the {{site.data.keyword.block_storage_is_short}} instance. Make sure that you use a zone that your worker nodes are connected to. To list VPC zones that your worker nodes use, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>` and look at the **Worker Zones** field in your CLI output. If you don't specify a zone, one of the worker node zones is automatically selected for your {{site.data.keyword.block_storage_is_short}} instance.
    
    `tags`
    :   In the string data section, enter a comma-separated list of tags to use when the PVC is created. Tags can help you find your storage instance after it is created.
    
    `resourceGroup`
    :   In the string data section, enter the resource group ID that you want your {{site.data.keyword.block_storage_is_short}} instance to get access to. If you don't enter a resource group, the instance is automatically authorized to access resources of the resource group that your cluster belongs to. 
    
    `encrypted`
    :   In the string data section, enter `true` to create a secret that sets up encryption for {{site.data.keyword.block_storage_is_short}} volumes. If you set this option to `true`, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in `parameters.encryptionKey`. For more information about encrypting your data, see [Setting up encryption](#vpc-block-encryption) for your {{site.data.keyword.block_storage_is_short}}.
    
    
    `encryptionKey`
    :   In the data section, if you entered `true` for `parameters.encrypted`, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your {{site.data.keyword.block_storage_is_short}} volumes. To use your root key CRN in a secret, you must first convert it to base64 by running `echo  -n "<root_key_CRN>" | base64`. For more information about encrypting your data, see [Setting up encryption for your {{site.data.keyword.block_storage_is_short}}](#vpc-block-encryption).

3. Create your Kubernetes secret.

    ```sh
    kubectl apply -f secret.yaml
    ```
    {: pre}

4. Follow the steps in [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) to create a PVC with your custom settings. Make sure to create the PVC with the customized storage class that the cluster admin created and use the same name for your PVC that you used for your secret. Using the same name for the secret and the PVC triggers the storage provider to apply the settings of the secret in your PVC.

### Enforcing base64 encoding for the {{site.data.keyword.keymanagementserviceshort}} root key CRN
{: #static-secret}

1. As the cluster admin, create a Kubernetes secret that includes the base64 encoded value for your {{site.data.keyword.keymanagementserviceshort}} root key CRN. To retrieve the root key CRN, see [Setting up encryption for your {{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block#vpc-block-encryption).

    ```yaml
    apiVersion: v1
    kind: Secret
    type: vpc.block.csi.ibm.io
    metadata:
      name: <secret_name>
      namespace: <namespace_name>
    stringData:
      encrypted: <true_or_false>
      resourceGroup: "<resource_group>"
    data:
      encryptionKey: <encryption_key>
    ```
    {: codeblock}

    `name`
    :   Enter a name for your Kubernetes secret. 
    
    `namespace`
    :   Enter the namespace where you want to create your secret. To reference the secret in your PVC, the PVC must be created in the same namespace.
    
    `encrypted`
    :   In the string data section, enter `true` to create a secret that sets up encryption for {{site.data.keyword.block_storage_is_short}} volumes. If you set this option to `true`, you must provide the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use in `parameters.encryptionKey`. For more information about encrypting your data, see [Setting up encryption](#vpc-block-encryption) for your {{site.data.keyword.block_storage_is_short}}.
      
    `encryptionKey`
    :   In the data section, if you entered `true`for `parameters.encrypted`, then enter the root key CRN of your {{site.data.keyword.keymanagementserviceshort}} service instance that you want to use to encrypt your {{site.data.keyword.block_storage_is_short}} volume. To use your root key CRN in a secret, you must first convert it to base 64 by running `echo  -n "<root_key_CRN>" | base64`. For more information about encrypting your data, see [Setting up encryption for your {{site.data.keyword.block_storage_is_short}}](#vpc-block-encryption).

2. Create the Kubernetes secret.

    ```sh
    kubectl apply -f secret.yaml
    ```
    {: pre}

3. Follow the steps to [create a customized storage class](#vpc-customize-storage-class). In the customized storage class YAML file, reference the Kubernetes secret in the `metadata.parameters` section as follows. Make sure to enter the name of the Kubernetes secret that you created earlier and the namespace where you created the secret.

    ```sh
    csi.storage.k8s.io/provisioner-secret-name: <secret_name>
    csi.storage.k8s.io/provisioner-secret-namespace: <secret_namespace>
    ```
    {: codeblock}

4. As the cluster user, follow the steps in [Adding {{site.data.keyword.block_storage_is_short}} to your apps](#vpc-block-add) to create a PVC from your customized storage class.




## Setting up volume expansion
{: #vpc-block-volume-expand}


To provision volumes that support expansion, you must use storage class that has `allowVolumeExpansion` set to `true`. 
{: shortdesc}


You can only expand volumes that are mounted by an app pod.
{: note}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
1. If you are not using version `4.2` or later of the add-on, [update the {{site.data.keyword.block_storage_is_short}} cluster add-on in your cluster](#vpc-addon-update).

1. [Create a PVC](#vpc_block_qs) that uses a storage class that supports volume expansion.

1. [Deploy an app](#vpc_block_qs) that uses your PVC. When you create your app, make a note of the `mountPath` that you specify.

1. After your PVC is mounted by an app pod, you can expand your volume by editing the value of the `spec.resources.requests.storage` field in your PVC. To expand your volume, edit your PVC and increase the value in the `spec.resources.requests.storage` field.
    ```sh
    kubectl edit pvc <pvc-name>
    ```
    {: pre}
    
    Example
    
    ```yaml
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
    ```
    {: codeblock}
    
1. Save and close the PVC.

1. **Optional:** Verify that your volume is expanded. Get the details of your PVC and make a note of the PV name.
    
    ```sh
    kubectl get pvc <pvc-name>
    ```
    {: pre}

1. Describe your PV and make a note of the volume ID.

    ```sh
    kubectl describe PV
    ```
    {: pre}

1. Get the details of your {{site.data.keyword.block_storage_is_short}} volume and verify the capacity.

    ```sh
    ibmcloud is vol <volume-ID>
    ```
    {: pre}

### Manually expanding volumes before add-on version 4.2
{: #expanding-existing-volumes}

Complete the following steps to manually expand your existing {{site.data.keyword.block_storage_is_short}} volumes that were created before version 4.2 of the add-on.
{: shortdesc}

You can only expand volumes that are mounted by an app pod.
{: note}

1. Get the details of your app and make a note of the PVC name and `mountPath`.

    ```sh
    kubectl get pod <pod-name> -n <pod-namespace> -o yaml
    ```
    {: pre}

1. Get the details of your PVC and make a note of the PV name.

    ```sh
    kubectl get pvc
    ```
    {: pre}

1. Describe your PV and get the `volumeId`.

    ```sh
    kubectl describe pv `pv-name` | grep volumeId 
    ```
    {: pre}
    
    Example output for a volume ID of `r011-a1aaa1f1-3aaa-4a73-84aa-0aa32e11a1a1`.
    
    ```sh
    volumeId=r011-a1aaa1f1-3aaa-4a73-84aa-0aa32e11a1a1
    ```
    {: screen}

1. Resize the volume by using a PATCH request. The following example resizes a volume to 250 GiB.

    ```sh
    curl -sS -X PATCH -H "Authorization: <iam_token>" "https://<region>.iaas.cloud.ibm.com/v1/volumes/<volumeId>?generation=2&version=2020-06-16" -d '{"capacity":250}'
    ```
    {: pre}
    
    `<iam_token>`
    :   Your IAM token. To retrieve your IAM token, run `ibmcloud iam oauth-tokens`.
    
    `<region>`
    : The region your cluster is in, for example `us-south`.
    
    `<volumeId>`
    :   The volume ID that you retrieved earlier. For example `r011-a1aaa1f1-3aaa-4a73-84aa-0aa32e11a1a1`.
    
    `<capacity>`
    :   The increased capacity in GiB, for example `250`.

1. Log in to your app pod.

    ```sh
    kubectl exec <pod-name> -it -- bash
    ```
    {: pre}

1. Run the following command to use host binaries.
    ```sh
    chroot /host
    ```
    {: pre}

1. Get the file system details and make a note of the `Filesystem` path that you want to update. You can also `grep` for the mount path as specified in your application pod. `df -h | grep <mount-path>`.

    ```sh
    df -h
    ```
    {: pre}

    Example output

    ```sh
    Filesystem      Size  Used Avail Use% Mounted on
    overlay          98G   64G   29G  70% /
    tmpfs            64M     0   64M   0% /dev
    tmpfs            32G     0   32G   0% /sys/fs/cgroup
    shm              64M     0   64M   0% /dev/shm
    /dev/vda2        98G   64G   29G  70% /etc/hosts
    /dev/vdg        9.8G   37M  9.8G   1% /mount-path # Note the Filesystem path that corresponds to the mountPath that you specified in your app.
    tmpfs            32G   40K   32G   1% /run/secrets/kubernetes.io/serviceaccount
    tmpfs            32G     0   32G   0% /proc/acpi
    tmpfs            32G     0   32G   0% /proc/scsi
    tmpfs            32G     0   32G   0% /sys/firmware
    ```
    {: screen}

1. Resize the file system.

    ```sh
    sudo resize2fs <filesystem-path>
    ```
    {: pre}

    Example command
    
    ```sh
    sudo resize2fs /dev/vdg
    ```
    {: pre}

1. Verify the file system is resized.

    ```sh
    df -h
    ```
    {: pre}


## Backing up and restoring data
{: #vpc-block-backup-restore}

Data on {{site.data.keyword.block_storage_is_short}} is secured across redundant fault zones in your region. To manually back up your data, use the Kubernetes `kubectl cp` command.
{: shortdesc}

You can use the `kubectl cp` [command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cp){: external} to copy files and directories to and from pods or specific containers in your cluster

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

To back up or restore data, choose between the following options:

Copy data from your local machine to a pod in your cluster.

```sh
kubectl cp <local_filepath>/<filename> <namespace>/<pod>:<pod_filepath>
```
{: pre}

Copy data from a pod in your cluster to your local machine.

```sh
kubectl cp <namespace>/<pod>:<pod_filepath>/<filename> <local_filepath>/<filename>
```
{: pre}

Copy data from your local machine to a specific container that runs in a pod in your cluster.

```sh
kubectl cp <local_filepath>/<filename> <namespace>/<pod>:<pod_filepath> -c CONTAINER
```
{: pre}





## Understanding volume request capacity
{: #vpc-block-volume-capacity}

The VPC Block CSI Driver calculates the volume capacity by using the following formula.

- If value is provided in `Gi`: rBytes(requestedBytes) = X * 1024^3

- If value is provided in `G`: rBytes(requestedBytes) = X * 10^9

The requested value is equal to `(((rBytes+ GiB - 1) / GiB) * GiB) / GiB`.

For example:
- If a value of `20Gi` is provided, applying the above formula, the volume that is created is `20GB`.
- If a value of `20G` is provided, the volume that is created is `19GB`.

Sometimes, the capacity of the volume that is created is less than the requested value. Note that billing applies for the volume that gets created, not the requested volume.


## Assigning trusted profiles to block storage
{: #block-vpc-trusted-profile}

Due to a known issue, updates to user tags on VPC Block Storage volumes might not be displayed when a trusted profile is implemented. This issue is not present in clusters that do not use trusted profiles. 
{: important}

You can use trusted profiles to grant different IBM Cloud identities access to resources in your account, including your storage solutions. Trusted profiles centralize access control, eliminate the need for long-lived API keys, and allow you to scope permissions to the exact minimum required for a specific task. For more information, see [Configuring a trusted profile for storage components](/docs/containers?topic=containers-configure-trusted-profile&interface=ui).
