---

copyright:
  years: 2014, 2023
lastupdated: "2023-05-03"

keywords: kubernetes, local persistent storage

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Getting started with Portworx
{: #getting-started-with-portworx}

Review the following information to verify your Portworx installation and get started with adding highly available local persistent storage to your containerized apps.
{: shortdesc}



## Verifying your Portworx installation
{: #px-verify-installation-px}

Verify that your Portworx installation completed successfully and that all your local disks were recognized and added to the Portworx storage layer.
{: shortdesc}

Before you begin:
- Make sure that you [installed the latest version of the {{site.data.keyword.cloud_notm}} CLI and the {{site.data.keyword.containerlong_notm}} CLI plug-in](/docs/containers?topic=containers-cs_cli_install#cs_cli_upgrade).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To verify your installation:

1. From the [{{site.data.keyword.cloud_notm}} resource list](https://cloud.ibm.com/resources), find the Portworx service that you created.
2. Review the **Status** column to see if the installation succeeded or failed. The status might take a few minutes to update.
3. If the **Status** changes to `Provision failure`, follow the [instructions](/docs/containers?topic=containers-debug-portworx) to start troubleshooting why your installation failed.
4. If the **Status** changes to `Provisioned`, verify that your Portworx installation completed successfully and that all your local disks were recognized and added to the Portworx storage layer.
    1. List the Portworx pods in the `kube-system` namespace. The installation is successful when you see one or more `portworx`, `stork`, and `stork-scheduler` pods. The number of pods equals the number of worker nodes that are in your Portworx cluster. All pods must be in a `Running` state.
        ```sh
        kubectl get pods -n kube-system | grep 'portworx\|stork'
        ```
        {: pre}

        Example output
        ```sh
        portworx-594rw                          1/1       Running     0          20h
        portworx-rn6wk                          1/1       Running     0          20h
        portworx-rx9vf                          1/1       Running     0          20h
        stork-6b99cf5579-5q6x4                  1/1       Running     0          20h
        stork-6b99cf5579-slqlr                  1/1       Running     0          20h
        stork-6b99cf5579-vz9j4                  1/1       Running     0          20h
        stork-scheduler-7dd8799cc-bl75b         1/1       Running     0          20h
        stork-scheduler-7dd8799cc-j4rc9         1/1       Running     0          20h
        stork-scheduler-7dd8799cc-knjwt         1/1       Running     0          20h
        ```
        {: screen}

    2. Log in to one of your `portworx` pods and list the status of your Portworx cluster.
        ```sh
        kubectl exec <portworx_pod> -it -n kube-system -- /opt/pwx/bin/pxctl status
        ```
        {: pre}

        Example output
        ```sh
        Status: PX is operational
        License: Enterprise
        Node ID: 10.176.48.67
        IP: 10.176.48.67
        Local Storage Pool: 1 pool
        POOL    IO_PRIORITY    RAID_LEVEL    USABLE    USED    STATUS    ZONE    REGION
          0    LOW        raid0        20 GiB    3.0 GiB    Online    dal10    us-south
        Local Storage Devices: 1 device
        Device    Path                        Media Type        Size        Last-Scan
            0:1    /dev/mapper/3600a09803830445455244c4a38754c66    STORAGE_MEDIUM_MAGNETIC    20 GiB        17 Sep 18 20:36 UTC
                total                            -            20 GiB
        Cluster Summary
        Cluster ID: mycluster
            Cluster UUID: a0d287ba-be82-4aac-b81c-7e22ac49faf5
        Scheduler: kubernetes
        Nodes: 2 node(s) with storage (2 online), 1 node(s) without storage (1 online)
          IP        ID        StorageNode    Used    Capacity    Status    StorageStatus    Version        Kernel            OS
          10.184.58.11    10.184.58.11    Yes        3.0 GiB    20 GiB        Online    Up        1.5.0.0-bc1c580    4.4.0-133-generic    Ubuntu 18.04.5 LTS
          10.176.48.67    10.176.48.67    Yes        3.0 GiB    20 GiB        Online    Up (This node)    1.5.0.0-bc1c580    4.4.0-133-generic    Ubuntu 18.04.5 LTS
          10.176.48.83    10.176.48.83    No        0 B    0 B        Online    No Storage    1.5.0.0-bc1c580    4.4.0-133-generic    Ubuntu 18.04.5 LTS
        Global Storage Pool
          Total Used        :  6.0 GiB
          Total Capacity    :  40 GiB
        ```
        {: screen}

    3. Verify that all worker nodes that you wanted to include in your Portworx storage layer are included by reviewing the **StorageNode** column in the **Cluster Summary** section of your CLI output. Worker nodes that are in the storage layer are displayed with `Yes` in the **StorageNode** column.

        Because Portworx runs as a daemon set in your cluster, new worker nodes that you add to your cluster are automatically inspected for raw block storage and added to the Portworx data layer.
        {: note}

    4. Verify that each storage node is listed with the correct amount of raw block storage by reviewing the **Capacity** column in the **Cluster Summary** section of your CLI output.

    5. Review the Portworx I/O classification that was assigned to the disks that are part of the Portworx cluster. During the setup of your Portworx cluster, every disk is inspected to determine the performance profile of the device. The profile classification depends on how fast the network is that your worker node is connected to and the type of storage device that you have. Disks of SDS worker nodes are classified as `high`. If you manually attach disks to a virtual worker node, then these disks are classified as `low` due to the slower network speed that comes with virtual worker nodes.
        ```sh
        kubectl exec -it <portworx_pod> -n kube-system -- /opt/pwx/bin/pxctl cluster provision-status
        ```
        {: pre}

        Example output
        ```sh
        NODE        NODE STATUS    POOL    POOL STATUS    IO_PRIORITY    SIZE    AVAILABLE    USED    PROVISIONED    RESERVEFACTOR    ZONE    REGION        RACK
        10.184.58.11    Up        0    Online        LOW        20 GiB    17 GiB        3.0 GiB    0 B        0        dal12    us-south    default
        10.176.48.67    Up        0    Online        LOW        20 GiB    17 GiB        3.0 GiB    0 B        0        dal10    us-south    default
        10.176.48.83    Up        0    Online        HIGH        3.5 TiB    3.5 TiB        10 GiB    0 B        0        dal10    us-south    default
        ```
        {: screen}

## Creating a Portworx volume
{: #px-add-storage}

Start creating Portworx volumes by using [Kubernetes dynamic provisioning](/docs/containers?topic=containers-kube_concepts#dynamic_provisioning).
{: shortdesc}

1. List available storage classes in your cluster and check whether you can use an existing Portworx storage class that was set up during the Portworx installation. The pre-defined storage classes are optimized for database usage and to share data across pods.
    ```sh
    kubectl get storageclasses | grep portworx
    ```
    {: pre}

    To view the details of a storage class, run `kubectl describe storageclass <storageclass_name>`.
    {: tip}

1. If you don't want to use an existing storage class, create a customized storage class. For a full list of supported options that you can specify in your storage class, see [Using Dynamic Provisioning](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/create-pvcs/dynamic-provisioning/#using-dynamic-provisioning){: external}.

1. Create a configuration file for your storage class.

    ```yaml
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
    name: <storageclass_name>
    provisioner: kubernetes.io/portworx-volume
    parameters:
      repl: "<replication_factor>"
      secure: "<true_or_false>"
      priority_io: "<io_priority>"
      shared: "<true_or_false>"
    ```
    {: codeblock}

    `metadata.name`
    :    Enter a name for your storage class. 
    
    `parameters.repl`
    :    Enter the number of replicas for your data that you want to store across different worker nodes. Allowed numbers are `1`,`2`, or `3`. For example, if you enter `3`, then your data is replicated across three different worker nodes in your Portworx cluster. To store your data highly available, use a multizone cluster and replicate your data across three worker nodes in different zones. 
         You must have enough worker nodes to fulfill your replication requirement. For example, if you have two worker nodes, but you specify three replicas, then the creation of the PVC with this storage class fails.
         {: note}
         
    `parameters.secure`
    :    Specify whether you want to encrypt the data in your volume with {{site.data.keyword.keymanagementservicelong_notm}}. Choose between the following options: 
         - **true**: Enter `true` to enable encryption for your Portworx volumes. To encrypt volumes, you must have an {{site.data.keyword.keymanagementservicelong_notm}} service instance and a Kubernetes secret that holds your customer root key. For more information about how to set up encryption for Portworx volumes, see [Encrypting your Portworx volumes](/docs/containers?topic=containers-storage-portworx-encyrption). 
         - **false**: When you enter `false`, your Portworx volumes are not encrypted.

    :    If you don't specify this option, your Portworx volumes are not encrypted by default.
    :    You can choose to enable volume encryption in your PVC, even if you disabled encryption in your storage class. The setting that you make in the PVC take precedence over the settings in the storage class.  
    
    `parameters.priority_io`
    :    Enter the Portworx I/O priority that you want to request for your data. Available options are `high`, `medium`, and `low`. During the setup of your Portworx cluster, every disk is inspected to determine the performance profile of the device. The profile classification depends on the network bandwidth of your worker node and the type of storage device that you have. Disks of SDS worker nodes are classified as `high`. If you manually attach disks to a virtual worker node, then these disks are classified as `low` due to the slower network speed that comes with virtual worker nodes.
    :    When you create a PVC with a storage class, the number of replicas that you specify in `parameters/repl` takes precedence over the I/O priority. For example, when you specify three replicas that you want to store on high-speed disks, but you have only one worker node with a high-speed disk in your cluster, then your PVC creation still succeeds. Your data is replicated across both high and low speed disks. 
    
    `parameters.shared`
    :    Define whether you want to allow multiple pods to access the same volume. Choose between the following options: 
         - **True:** If you set this option to `true`, then you can access the same volume by multiple pods that are distributed across worker nodes in different zones. 
         - **False:** If you set this option to `false`, you can access the volume from multiple pods only if the pods are deployed onto the worker node that attaches the physical disk that backs the volume. If your pod is deployed onto a different worker node, the pod can't access the volume.

1. Create the storage class.
    ```sh
    kubectl apply -f storageclass.yaml
    ```
    {: pre}

1. Verify that the storage class is created.
    ```sh
    kubectl get storageclasses
    ```
    {: pre}

1. Create a persistent volume claim (PVC).
    1. Create a configuration file for your PVC.
        ```yaml
        kind: PersistentVolumeClaim
        apiVersion: v1
        metadata:
        name: mypvc
        spec:
          accessModes:
            - <access_mode>
          resources:
            requests:
              storage: <size>
          storageClassName: portworx-shared-sc
        ```
        {: codeblock}

        `metadata.name`
        :    Enter a name for your PVC, such as `mypvc`. 
        
        
        `spec.accessModes`
        :    Enter the [Kubernetes access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes){: external} that you want to use. 
        
        
        `resources.requests.storage`
        :    Enter the amount of storage in gigabytes that you want to assign from your Portworx cluster. For example, to assign 2 gigabytes from your Portworx cluster, enter `2Gi`. The amount of storage that you can specify is limited by the amount of storage that is available in your Portworx cluster. If you specified a replication factor in your storage class that is higher than 1, then the amount of storage that you specify in your PVC is reserved on multiple worker nodes.   
        
        
        `spec.storageClassName`
        :    Enter the name of the storage class that you chose or created earlier and that you want to use to provision your PV. The example YAML file uses the `portworx-shared-sc` storage class. 

    2. Create your PVC.
        ```sh
        kubectl apply -f pvc.yaml
        ```
        {: pre}

    3. Verify that your PVC is created and bound to a persistent volume (PV). This process might take a few minutes.
        ```sh
        kubectl get pvc
        ```
        {: pre}

## Mounting the volume to your app
{: #px-mount-pvc}

To access the storage from your app, you must mount the PVC to your app.
{: shortdesc}

1. Create a configuration file for a deployment that mounts the PVC.

    For tips on how to deploy a stateful set with Portworx, see [StatefulSets](https://docs.portworx.com/portworx-install-with-kubernetes/application-install-with-kubernetes/cassandra/){: external}. The Portworx documentation also includes examples for how to deploy [Cassandra](https://docs.portworx.com/portworx-install-with-kubernetes/application-install-with-kubernetes/cassandra/){: external}, [Kafka](https://docs.portworx.com/portworx-install-with-kubernetes/application-install-with-kubernetes/kafka-with-zookeeper/){: external}, [ElasticSearch with Kibana](https://docs.portworx.com/operations/operate-kubernetes/application-install-with-kubernetes/elastic-search-and-kibana/){: external}, and [WordPress with MySQL](https://docs.portworx.com/portworx-install-with-kubernetes/application-install-with-kubernetes/wordpress/){: external}.
    {: tip}

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
          schedulerName: stork
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
          securityContext:
            fsGroup: <group_ID>
    ```
    {: codeblock}
    
    To understand your yaml file components, see the following parameters and descriptions.
    
    `metadata.labels.app`
    :    A label for the deployment.
        
    `spec.selector.matchLabels.app` or `spec.template.metadata.labels.app`
    :    A label for your app.
        
   `template.metadata.labels.app`
    :    A label for the deployment.
        
   `spec.schedulerName`
    :    Use [Stork](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/stork/){: external} as the scheduler for your Portworx cluster. With Stork, you can co-locate pods with their data, provides seamless migration of pods in case of storage errors and makes it easier to create and restore snapshots of Portworx volumes. 
   
   `spec.containers.image`
    :    The name of the image that you want to use. To list available images in your {{site.data.keyword.registrylong_notm}} account, run `ibmcloud cr image-list`.
    
   `spec.containers.name`
    :    The name of the container that you want to deploy to your cluster.
    
   `spec.containers.securityContext.fsGroup`
    :    Optional: To access your storage with a non-root user, specify the [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/){: external} for your pod and define the set of users that you want to grant access in the `fsGroup` section on your deployment YAML. For more information, see [Accessing Portworx volumes with a non-root user](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/create-pvcs/access-via-non-root-users/){: external}. 
    
   `spec.containers.volumeMounts.mountPath`
    :    The absolute path of the directory to where the volume is mounted inside the container. If you want to share a volume between different apps, you can specify [volume sub paths](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath){: external} for each of your apps.
    
   `spec.containers.volumeMounts.name`
    :    The name of the volume to mount to your pod.
    
   `volumes.name`
    :    The name of the volume to mount to your pod. Typically this name is the same as `volumeMounts/name`.
    
   `volumes.persistentVolumeClaim.claimName`
    :    The name of the PVC that binds the PV that you want to use. 
    
2. Create your deployment.
    ```sh
    kubectl apply -f deployment.yaml
    ```
    {: pre}

3. Verify that the PV is successfully mounted to your app.
    ```sh
    kubectl describe deployment <deployment_name>
    ```
    {: pre}

    The mount point is in the **Volume Mounts** field and the volume is in the **Volumes** field.
    ```sh
    Volume Mounts:
            /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
            /volumemount from myvol (rw)
    ...
    Volumes:
        myvol:
        Type:    PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName:    mypvc
        ReadOnly:    false
    ```
    {: screen}

4. Verify that you can write data to your Portworx cluster.
    1. Log in to the pod that mounts your PV.
        ```sh
        kubectl exec <pod_name> -it -- bash
        ```
        {: pre}

    2. Navigate to your volume mount path that you defined in your app deployment.
    3. Create a text file.
        ```sh
        echo "This is a test" > test.txt
        ```
        {: pre}

    4. Read the file that you created.
        ```sh
        cat test.txt
        ```
        {: pre}


## Cleaning up your Portworx volumes and cluster
{: #portworx_cleanup_volumes}

Remove a [Portworx volume](#remove_pvc), a [storage node](#remove_storage_node_cluster), or the [entire Portworx cluster](#remove_storage_node_cluster) if you don't need it anymore.
{: shortdesc}

### Removing Portworx volumes from apps
{: #remove_pvc}

When you added storage from your Portworx cluster to your app, you have three main components: the Kubernetes persistent volume claim (PVC) that requested the storage, the Kubernetes persistent volume (PV) that is mounted to your pod and described in the PVC, and the Portworx volume that blocks space on the physical disks of your Portworx cluster. To remove storage from your app, you must remove all components.
{: shortdesc}

1. List the PVCs in your cluster and note the **NAME** of the PVC, and the name of the PV that is bound to the PVC and shown as **VOLUME**.
    ```sh
    kubectl get pvc
    ```
    {: pre}

    Example output

    ```sh
    NAME                  STATUS    VOLUME                                     CAPACITY   ACCESSMODES   STORAGECLASS            AGE
    px-pvc          Bound     pvc-06886b77-102b-11e8-968a-f6612bb731fb   20Gi       RWO           px-high                 78d
    ```
    {: screen}

2. Review the **`ReclaimPolicy`** for the storage class.
    ```sh
    kubectl describe storageclass <storageclass_name>
    ```
    {: pre}

    If the reclaim policy says `Delete`, your PV and the data on your physical storage in your Portworx cluster are removed when you remove the PVC. If the reclaim policy says `Retain`, or if you provisioned your storage without a storage class, then your PV and your data are not removed when you remove the PVC. You must remove the PVC, PV, and the data separately.

3. Remove any pods that mount the PVC.
    1. List the pods that mount the PVC.
        ```sh
        kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
        ```
        {: pre}

        Example output
        ```sh
        blockdepl-12345-prz7b:    claim1-block-bronze  
        ```
        {: screen}

        If no pod is returned in your CLI output, you don't have a pod that uses the PVC.

    2. Remove the pod that uses the PVC.

        If the pod is part of a deployment, remove the deployment.
        {: tip}

        ```sh
        kubectl delete pod <pod_name>
        ```
        {: pre}

    3. Verify that the pod is removed.
        ```sh
        kubectl get pods
        ```
        {: pre}

4. Remove the PVC.
    ```sh
    kubectl delete pvc <pvc_name>
    ```
    {: pre}

5. Review the status of your PV. Use the name of the PV that you retrieved earlier as **VOLUME**.
    ```sh
    kubectl get pv <pv_name>
    ```
    {: pre}

    When you remove the PVC, the PV that is bound to the PVC is released. Depending on how you provisioned your storage, your PV goes into a `Deleting` state if the PV is deleted automatically, or into a `Released` state, if you must manually delete the PV. **Note**: For PVs that are automatically deleted, the status might briefly say `Released` before it is deleted. Rerun the command after a few minutes to see whether the PV is removed.

6. If your PV is not deleted, manually remove the PV.
    ```sh
    kubectl delete pv <pv_name>
    ```
    {: pre}

7. Verify that the PV is removed.
    ```sh
    kubectl get pv
    ```
    {: pre}

8. Verify that your Portworx volume is removed. Log in to one of your Portworx pods in your cluster to list your volumes. To find available Portworx pods, run `kubectl get pods -n kube-system | grep portworx`.
    ```sh
    kubectl exec <portworx-pod>  -it -n kube-system -- /opt/pwx/bin/pxctl volume list
    ```
    {: pre}

9. If your Portworx volume is not removed, manually remove the volume.
    ```sh
    kubectl exec <portworx-pod>  -it -n kube-system -- /opt/pwx/bin/pxctl volume delete <volume_ID>
    ```
    {: pre}

### Removing a worker node from your Portworx cluster or the entire Portworx cluster
{: #remove_storage_node_cluster}

You can exclude worker nodes from your Portworx cluster or remove the entire Portworx cluster if you don't want to use Portworx anymore.
{: shortdesc}

Removing your Portworx cluster removes all the data from your Portworx cluster. Make sure to [create a snapshot for your data and save this snapshot to the cloud](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/create-snapshots/){: external}.
{: important}

- **Remove a worker node from the Portworx cluster:** If you want to remove a worker node that runs Portworx and stores data in your Portworx cluster,  you must migrate existing pods to remaining worker nodes and then uninstall Portworx from the node. For more information, see [Decommission a Portworx node in Kubernetes](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/uninstall/decommission-a-node/){: external}.
- **Remove the entire Portworx cluster:** When you remove a Portworx cluster, you can decide if you want to remove all your data at the same time. For more information, see [Uninstall from Kubernetes cluster](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/uninstall/uninstall/#delete-wipe-px-cluster-configuration){: external}.


## Getting help and support
{: #portworx_help_and_support}

Contact Portworx support by using one of the following methods.

- Sending an e-mail to `support@purestorage.com`.

- Calling `+1 (866) 244-7121` or `+1 (650) 729-4088` in the United States or one of the [International numbers](https://support.purestorage.com/Pure_Storage_Technical_Services/Technical_Services_Information/Contact_Us)

- Opening an issue in the [Portworx Service Portal](https://support.purestorage.com/Pure_Storage_Technical_Services/Technical_Services_Information/Contact_Us){: external}. If you don't have an account, see [Request access](https://purestorage.force.com/customers/CustomerAccessRequest){: external}

You can also [gather logging information](/docs/containers?topic=containers-portworx#portworx_logs) before opening a support ticket.
{: tip}


