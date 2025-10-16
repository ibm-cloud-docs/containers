---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-16"


keywords: kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# IBM Cloud storage utilities
{: #utilities}

## Classic: Installing the IBM Cloud Block Storage Attacher plug-in (beta)
{: #block_storage_attacher}

Use the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in to attach raw, unformatted, and unmounted block storage to a classic worker node in your cluster.  
{: shortdesc}

The {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in is available for classic worker nodes only. If you want to attach raw, unformatted block storage to a VPC worker node, see [Adding raw {{site.data.keyword.block_storage_is_short}} worker nodes](#vpc_api_attach).
{: note}

For example, you want to store your data with a software-defined storage solution (SDS), such as [Portworx](/docs/containers?topic=containers-storage_portworx_about), but you don't want to use classic bare metal worker nodes that are optimized for SDS usage and that come with extra local disks. To add local disks to your classic non-SDS worker node, you must manually create your block storage devices in your {{site.data.keyword.cloud_notm}} infrastructure account and use the {{site.data.keyword.cloud_notm}} Block Volume Attacher to attach the storage to your non-SDS worker node.

The {{site.data.keyword.cloud_notm}} Block Volume Attacher plug-in creates pods on every worker node in your cluster as part of a daemon set and sets up a Kubernetes storage class that you later use to attach the block storage device to your non-SDS worker node.

Looking for instructions for how to update or remove the {{site.data.keyword.cloud_notm}} Block Volume Attacher plug-in? See [Updating the plug-in](#update_block_attacher) and [Removing the plug-in](#remove_block_attacher).
{: tip}

1. [Follow the instructions](/docs/containers?topic=containers-helm#install_v3) to install the Helm client version 3 on your local machine.

2. Update the Helm repo to retrieve the latest version of all Helm charts in this repo.

    ```sh
    helm repo update
    ```
    {: pre}

3. Install the {{site.data.keyword.cloud_notm}} Block Volume Attacher plug-in. When you install the plug-in, pre-defined block storage classes are added to your cluster.


    ```sh
    helm install block-attacher iks-charts/ibm-block-storage-attacher --namespace kube-system
    ```
    {: pre}

    Example output

    ```sh
    NAME:   block-volume-attacher
    LAST DEPLOYED: Thu Sep 13 22:48:18 2018
    NAMESPACE: default
    STATUS: DEPLOYED

    RESOURCES:
    ==> v1beta1/ClusterRoleBinding
    NAME                             AGE
    ibmcloud-block-storage-attacher  1s

    ==> v1beta1/DaemonSet
    NAME                             DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
    ibmcloud-block-storage-attacher  0        0        0      0           0          <none>         1s

    ==> v1/StorageClass
    NAME                 PROVISIONER                AGE
    ibmc-block-attacher  ibm.io/ibmc-blockattacher  1s

    ==> v1/ServiceAccount
    NAME                             SECRETS  AGE
    ibmcloud-block-storage-attacher  1        1s

    ==> v1beta1/ClusterRole
    NAME                             AGE
    ibmcloud-block-storage-attacher  1s

    NOTES:
    Thank you for installing: ibmcloud-block-storage-attacher.   Your release is named: block-volume-attacher

    Please refer Chart README.md file for attaching a block storage
    Please refer Chart RELEASE.md to see the release details/fixes
    ```
    {: screen}

4. Verify that the {{site.data.keyword.cloud_notm}} Block Volume Attacher daemon set is installed successfully.
    ```sh
    kubectl get pod -n kube-system -o wide | grep attacher
    ```
    {: pre}

    Example output

    ```sh
    ibmcloud-block-storage-attacher-z7cv6           1/1       Running            0          19m
    ```
    {: screen}

    The installation is successful when you see one or more **ibmcloud-block-storage-attacher** pods. The number of pods equals the number of worker nodes in your cluster. All pods must be in a **Running** state.

5. Verify that the storage class for the {{site.data.keyword.cloud_notm}} Block Volume Attacher is created successfully.

    ```sh
    kubectl get sc | grep attacher
    ```
    {: pre}

    Example output
    
    ```sh
    ibmc-block-attacher       ibm.io/ibmc-blockattacher   11m
    ```
    {: screen}

### Updating the IBM Cloud Block Storage Attacher plug-in
{: #update_block_attacher}

You can upgrade the existing {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in to the latest version.
{: shortdesc}

1. Update the Helm repo to retrieve the latest version of all helm charts in this repo.

    ```sh
    helm repo update
    ```
    {: pre}

2. Optional: Download the latest Helm chart to your local machine. Then, extract the package and review the `release.md` file to find the latest release information.

    ```sh
    helm pull iks-charts/ibmcloud-block-storage-plugin
    ```
    {: pre}

3. Find the name of the Helm chart for the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in.

    ```sh
    helm ls -A
    ```
    {: pre}

    Example output
    
    ```sh
    <helm_chart_name>    1           Wed Aug  1 14:55:15 2022    DEPLOYED    ibm-block-storage-attacher-1.0.0    default
    ```
    {: screen}

4. Upgrade the {{site.data.keyword.cloud_notm}} Block Storage Attacher to latest.

    ```sh
    helm upgrade --force --recreate-pods <helm_chart_name> ibm-block-storage-attacher
    ```
    {: pre}

### Removing the IBM Cloud Block Volume Attacher plug-in
{: #remove_block_attacher}

If you don't want to provision and use the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in in your cluster, you can uninstall the Helm chart.
{: shortdesc}

1. Find the name of the Helm chart for the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in.

    ```sh
    helm list | grep ibm-block-storage-attacher
    ```
    {: pre}

    Example output
    
    ```sh
    <helm_chart_name>    1           Wed Aug  1 14:55:15 2022    DEPLOYED    ibm-block-storage-attacher-1.0.0    default
    ```
    {: screen}

2. Delete the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in by removing the Helm chart.

    ```sh
    helm uninstall <helm_chart_name> -n <namespace>
    ```
    {: pre}

3. Verify that the {{site.data.keyword.cloud_notm}} Block Storage Attacher plug-in pods are removed.

    ```sh
    kubectl get pod -n kube-system -o wide | grep attacher
    ```
    {: pre}

    The removal of the pods is successful if no pods are displayed in your CLI output.

4. Verify that the {{site.data.keyword.cloud_notm}} Block Storage Attacher storage class is removed.

    ```sh
    kubectl get sc | grep attacher
    ```
    {: pre}

The removal of the storage class is successful if no storage class is displayed in your CLI output.

    



## Classic: Manually adding block storage to specific worker nodes
{: #manual_block}

Use this option if you want to add different block storage configurations, add block storage to a subset of worker nodes only, or to have more control over the provisioning process.
{: shortdesc}

The instructions in this topic are available for classic worker nodes only. If you want to attach raw, unformatted block storage to a VPC worker node, see [Adding raw {{site.data.keyword.block_storage_is_short}} to worker nodes](#vpc_api_attach).
{: note}

1. List the worker nodes in your cluster and note the private IP address and the zone of the non-SDS worker nodes where you want to add a block storage device.

    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Review step 3 and 4 in [Deciding on your block storage configuration](/docs/containers?topic=containers-block_storage#block_predefined_storageclass) to choose the type, size, and number of IOPS for the block storage device that you want to add to your non-SDS worker node.    

3. Create the block storage device in the same zone that your non-SDS worker node is in.

    Example for provisioning 20 GB endurance block storage with two IOPS per GB.
    
    ```sh
    ibmcloud sl block volume-order --storage-type endurance --size 20 --tier 2 --os-type LINUX --datacenter dal10
    ```
    {: pre}

    Example for provisioning 20 GB performance block storage with 100 IOPS.
    
    ```sh
    ibmcloud sl block volume-order --storage-type performance --size 20 --iops 100 --os-type LINUX --datacenter dal10
    ```
    {: pre}

4. Verify that the block storage device is created and note the `id` of the volume. **Note:** If you don't see your block storage device immediately, wait a few minutes. Then, run this command again.

    ```sh
    ibmcloud sl block volume-list
    ```
    {: pre}

    Example output
    
    ```sh
    id         username          datacenter   storage_type                capacity_gb   bytes_used   ip_addr         lunId   active_transactions   
    123456789  IBM02SL1234567-8  dal10        performance_block_storage   20            -            161.12.34.123   0       0   
    ```
    {: screen}

5. Review the details for your volume and note the `Target IP` and `LUN Id`.

    ```sh
    ibmcloud sl block volume-detail <volume_ID>
    ```
    {: pre}

    Example output
    
    ```sh
    NAME                       Value   
    ID                         1234567890   
    User name                  IBM123A4567890-1   
    Type                       performance_block_storage   
    Capacity (GB)              20   
    LUN Id                     0   
    IOPS                       100   
    Datacenter                 dal10   
    Target IP                  161.12.34.123   
    # of Active Transactions   0   
    Replicant Count            0
    ```
    {: screen}

6. Authorize the non-SDS worker node to access the block storage device. Replace `<volume_ID>` with the volume ID of your block storage device that you retrieved earlier, and `<private_worker_IP>` with the private IP address of the non-SDS worker node where you want to attach the device.

    ```sh
    ibmcloud sl block access-authorize <volume_ID> -p <private_worker_IP>
    ```
    {: pre}

    Example output
    
    ```sh
    The IP address 123456789 was authorized to access <volume_ID>.
    ```
    {: screen}

7. Verify that your non-SDS worker node is successfully authorized and note the `host_iqn`, `username`, and `password`.
    ```sh
    ibmcloud sl block access-list <volume_ID>
    ```
    {: pre}

    Example output
    
    ```sh
    ID          name                 type   private_ip_address   source_subnet   host_iqn                                      username   password           allowed_host_id   
    123456789   <private_worker_IP>  IP     <private_worker_IP>  -               iqn.2018-09.com.ibm:ibm02su1543159-i106288771   IBM02SU1543159-I106288771   R6lqLBj9al6e2lbp   1146581   
    ```
    {: screen}

    The authorization is successful when the **`host_iqn`**, **`username`**, and **`password`** are assigned.

8. [Attach the block storage devices to your worker nodes](#attach_block).




## Classic: Attaching raw block storage to non-SDS worker nodes
{: #attach_block}

To attach the block storage device to a non-SDS worker node, you must create a persistent volume (PV) with the {{site.data.keyword.cloud_notm}} Block Volume Attacher storage class and the details of your block storage device.
{: shortdesc}

The instructions in this topic are available for classic worker nodes only. If you want to attach raw, unformatted block storage to a VPC worker node, see [Adding raw {{site.data.keyword.block_storage_is_short}} to worker nodes](#vpc_api_attach).
{: note}

- Make sure that you [manually](#manual_block) added raw, unformatted, and unmounted block storage to your non-SDS worker nodes.
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
- Install the [block storage attacher plug-in](#block_storage_attacher).


1. Prepare the PV creation.  
    - If you used the `mkpvyaml` container, run the following command.
        1. Open the `pv-<cluster_name>.yaml` file.
        
            ```sh
            nano pv-<cluster_name>.yaml
            ```
            {: pre}

        2. Review the configuration for your PVs.

    - If you manually added block storage:**
        1. Create a `pv.yaml` file. The following command creates the file with the `nano` editor.
        
            ```sh
            nano pv.yaml
            ```
            {: pre}

        2. Add the details of your block storage device to the PV.
        
            ```yaml
            apiVersion: v1
            kind: PersistentVolume
            metadata:
              name: <pv_name>
              annotations:
                ibm.io/iqn: "<IQN_hostname>"
                ibm.io/username: "<username>"
                ibm.io/password: "<password>"
                ibm.io/targetip: "<targetIP>"
                ibm.io/lunid: "<lunID>"
                ibm.io/nodeip: "<private_worker_IP>"
                ibm.io/volID: "<volume_ID>"
            spec:
              capacity:
                storage: <size>
              accessModes:
                - ReadWriteOnce
              hostPath:
                  path: /
              storageClassName: ibmc-block-attacher
            ```
            {: codeblock}

        `metadata.name`
        :   Enter a name for your PV.
        
        `ibm.io/iqn`
        :   Enter the IQN hostname that you retrieved earlier.
        
        `ibm.io/username`
        :   Enter the IBM Cloud infrastructure username that you retrieved earlier.
        
        `ibm.io/password`
        :   Enter the IBM Cloud infrastructure password that you retrieved earlier. 
        
        `ibm.io/targetip`
        :   Enter the target IP that you retrieved earlier.
        
        `ibm.io/lunid`
        :   Enter the LUN ID of your block storage device that you retrieved earlier.
        
        `ibm.io/nodeip`
        :   Enter the private IP address of the worker node where you want to attach the block storage device and that you authorized earlier to access your block storage device.
        
        `ibm.io/volID`
        :   Enter the ID of the block storage volume that you retrieved earlier.
        
        `storage`
        :   Enter the size of the block storage device that you created earlier. For example, if your block storage device is 20 gigabytes, enter `20Gi`.
        
2. Create the PV to attach the block storage device to your non-SDS worker node.
    - If you used the `mkpvyaml` container, run the following command.
   
        ```sh
        kubectl apply -f pv-<cluster_name>.yaml
        ```
        {: pre}

    - If you manually added block storage, run the following command.
    
        ```sh
        kubectl apply -f pv.yaml
        ```
        {: pre}

3. Verify that the block storage is successfully attached to your worker node.

    ```sh
    kubectl describe pv <pv_name>
    ```
    {: pre}

    Example output
    
    ```sh
    NAME:            kube-wdc07-cr398f790bc285496dbeb8e9137bc6409a-w1-pv1
    Labels:          <none>
    Annotations:     ibm.io/attachstatus=attached
                    ibm.io/dm=/dev/dm-1
                    ibm.io/iqn=iqn.2018-09.com.ibm:ibm02su1543159-i106288771
                    ibm.io/lunid=0
                    ibm.io/mpath=3600a09803830445455244c4a38754c66
                    ibm.io/nodeip=10.176.48.67
                    ibm.io/password=R6lqLBj9al6e2lbp
                    ibm.io/targetip=161.26.98.114
                    ibm.io/username=IBM02SU1543159-I106288771
                    kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"PersistentVolume","metadata":{"annotations":{"ibm.io/iqn":"iqn.2018-09.com.ibm:ibm02su1543159-i106288771","ibm.io/lunid":"0"...
    Finalizers:      []
    StorageClass:    ibmc-block-attacher
    Status:          Available
    Claim:           
    Reclaim Policy:  Retain
    Access Modes:    RWO
    Capacity:        20Gi
    Node Affinity:   <none>
    Message:         
    Source:
        Type:          HostPath (bare host directory volume)
        Path:          /
        HostPathType:  
    Events:            <none>
    ```
    {: screen}

    The block storage device is successfully attached when the **ibm.io/dm** is set to a device ID, such as `/dev/dm/1`, and you can see **ibm.io/attachstatus=attached** in the **Annotations** section of your CLI output.

If you want to detach a volume, delete the PV. Detached volumes are still authorized to be accessed by a specific worker node and are attached again when you create a new PV with the {{site.data.keyword.cloud_notm}} Block Volume Attacher storage class to attach a different volume to the same worker node. To avoid attaching the old detached volume again, unauthorize the worker node to access the detached volume by using the `ibmcloud sl block access-revoke` command. Detaching the volume does not remove the volume from your IBM Cloud infrastructure account. To cancel the billing for your volume, you must manually [remove the storage from your IBM Cloud infrastructure account](/docs/containers?topic=containers-block_storage#cleanup_block).
{: note}





## VPC: Adding raw {{site.data.keyword.block_storage_is_short}} to VPC worker nodes by using the API
{: #vpc_api_attach}

You can use the {{site.data.keyword.containershort_notm}} API to attach and detach raw, unformatted [{{site.data.keyword.blockstorageshort}}](https://cloud.ibm.com/apidocs/kubernetes/containers-v1-v2){: external} to a worker node in your VPC cluster.
{: shortdesc}

You can attach a volume to one worker node only. Make sure that the volume is in the same zone as the worker node for the attachment to succeed.
{: note}

You can also attach, detach, and list the volume attachments of your worker nodes by using the CLI. For more information, see the [storage CLI reference](/docs/containers?topic=containers-kubernetes-service-cli#cs_storage).
{: tip}

The instructions in this topic are available for VPC worker nodes only. If you want to attach raw, unformatted block storage to a classic worker node, you must install the [{{site.data.keyword.cloud_notm}} Block Storage attacher plug-in](#block_storage_attacher).
{: note}

Before you begin:

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)


1. Check which region and zone your VPC worker node is in.
    ```sh
    ibmcloud ks worker ls -c <cluster_name>
    ```
    {: pre}

2. Decide on the [{{site.data.keyword.blockstorageshort}} profile](/docs/vpc?topic=vpc-block-storage-profiles) that best meets the capacity and performance requirements that you have.

3. [Provision a {{site.data.keyword.blockstorageshort}} volume](/docs/vpc?topic=vpc-creating-block-storage){: external}. The volume that you provision must be in the same resource group, region, and zone as the worker node.

4. Retrieve your IAM token.

    ```sh
    ibmcloud iam oauth-tokens
    ```
    {: pre}

5. Retrieve the ID of the worker node that you want to attach to the {{site.data.keyword.blockstorageshort}} instance. Make sure to select a worker node that is located in the same zone as your {{site.data.keyword.blockstorageshort}} volume.

    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

6. Use a `POST` request to attach your {{site.data.keyword.blockstorageshort}} volume to the worker node.

    Example request
    
    ```sh
    curl -X POST "https://containers.cloud.ibm.com/global/v2/storage/createAttachment" -H  "accept: application/json" -H  "Authorization: <IAM_token>" -H  "X-Auth-Resource-Group-ID: <resource_group>" -H  "Content-Type: application/json" -d "{  \"cluster\": \"<cluster_name_or_ID>\",  \"volumeID\": \"<volume_ID>\",  \"worker\": \"<worker_ID>\"}"
    ```
    {: pre}

    `IAM_token`
    :   The IAM OAuth token for your current session. You can retrieve this value by running `ibmcloud iam oauth-tokens`.
    
    `cluster_name_or_ID`
    :   The unique ID or the name that is assigned to your cluster. You can retrieve this ID by running `ibmcloud ks cluster ls`.
    
    `worker_ID`
    :   The unique ID that is assigned to the worker node where you want to attach your volume. You can retrieve this value by running `ibmcloud ks worker ls -c <cluster_name>`.
    
    `volume_ID`
    :   The unique ID that is assigned to your {{site.data.keyword.blockstorageshort}} volume. You can retrieve a list of your {{site.data.keyword.blockstorageshort}} volumes by running `ibmcloud is volumes`.


    Example response.
    ```sh
    {
        "id": "0111-1aaa11a1-aa1a-111a-111b-1111a1dad1bc",
    "volume": {
        "name": "my-vol",
        "id": "r001-11aa0d59-a1aa-1a11-11ca-ba2bc11e01aa"
    },
    "device": {
        "id": ""
    },
    "name": "volume-attachment",
    "status": "attaching",
    "type": "data"
    }
    ```
    {: screen}

7. Verify the attachment by [reviewing existing volume attachments for a VPC worker node](#vpc_api_get_worker).

### Detaching raw and unformatted {{site.data.keyword.blockstorageshort}} from a worker node in a VPC cluster by using the API
{: #vpc_api_detach}

You can use a `DELETE` request to detach storage from a VPC worker node.
{: shortdesc}

Detaching storage from your VPC cluster does not remove your {{site.data.keyword.blockstorageshort}} volume or the data that is stored in the volume. You continue to get billed until [you manually delete the volume](/docs/vpc?topic=vpc-managing-block-storage).
{: important}

1. Identify the storage volume that you want to remove and note the volume ID.

    ```sh
    ibmcloud is volumes
    ```
    {: pre}

2. Get details about the volume. This command returns the worker node ID and attachment ID. Note the worker node ID. In the following command this ID is returned as "Instance name".

    ```sh
    ibmcloud is volume <volume_ID>
    ```
    {: pre}

3. Retrieve a list of your PVs. This command returns a list of your PVs that you can then you use to determine which PVC uses the volume that you want to remove.

    ```sh
    kubectl get pv
    ```
    {: pre}

4. Describe the PV that uses the volume. If you don't know which PV uses the volume that you want to remove, you can run the `describe pv` command on each PV in your cluster. Note the PVC that uses the PV.

    ```sh
    kubectl describe pv <pv_name>
    ```
    {: pre}

5. Check to see if your storage volume is in use by a pod. The following command shows the pods that mount the volume and the associated PVC. If no pod is returned, the storage is not in use.

    ```sh
    kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
    ```
    {: pre}

6. If the pod your volume is using is part of a deployment, delete the deployment. If your pod does not belong to a deployment, delete the pod.

    ```sh
    kubectl delete deployment <deployment_name>
    ```
    {: pre}

    ```sh
    kubectl delete pod <pod_name>
    ```
    {: pre}

7. Delete the PVC and PV.

    ```sh
    kubectl delete pvc <pvc_name>
    ```
    {: pre}

    ```sh
    kubectl delete pv <pv_name>
    ```
    {: pre}

8. Retrieve your IAM token.

    ```sh
    ibmcloud iam oauth-tokens
    ```
    {: pre}

9. Detach storage by using a `POST` request.

    Example request
    
    ```sh
    curl -X POST "https://containers.cloud.ibm.com/global/v2/storage/deleteAttachment" -H  "accept: application/json" -H  "Authorization: <IAM_token>" -H  "X-Auth-Resource-Group-ID: <resource_group>" -H  "Content-Type: application/json" -d "{  \"cluster\": \"<cluster_name_or_ID\",  \"volumeAttachmentID\": \"<volume_attachment_ID>\",  \"volumeID\": \"<volume_ID>\",  \"worker\": \"<worker_ID>\"}"
    ```
    {: pre}

    `IAM_token`
    :   The IAM OAuth token for your current session. You can retrieve this value by running `ibmcloud iam oauth-tokens`.

    `cluster_name_or_ID`
    :   The unique ID or name that is assigned to your cluster. You can retrieve this ID by running `ibmcloud ks cluster ls`.
    
    `worker_ID`
    :   The unique ID that is assigned to the worker node where you want to attach your volume. You can retrieve this value by running `ibmcloud ks worker ls -c <cluster_name>`.
    
    `volume_ID`
    :   The unique ID that is assigned to your {{site.data.keyword.blockstorageshort}} volume. You can retrieve a list of your {{site.data.keyword.blockstorageshort}} volumes by running `ibmcloud is volumes`.
    
    `volume_attachment_ID`
    :   The unique ID that is assigned to your volume attachment. You can retrieve this ID by running `ibmcloud is volume <volume_ID>`.


### Reviewing volume attachment details for a VPC worker node by using the API
{: #vpc_api_get_worker}

You can use a `GET` request to retrieve volume attachment details for a VPC worker node.
{: shortdesc}

1. Retrieve your IAM token.

    ```sh
    ibmcloud iam oauth-tokens
    ```
    {: pre}

2. Retrieve the ID of the resource group where your cluster is deployed.

    ```sh
    ibmcloud ks cluster get <cluster_name_or_ID> | grep "Resource Group ID"
    ```
    {: pre}

3. Retrieve the ID of the worker node for which you want to see volume attachment details. Make sure to select a worker node that is located in the same zone as your {{site.data.keyword.blockstorageshort}} instance.

    ```sh
    ibmcloud ks worker ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Review a list of existing volume attachments on a worker node.

    ```sh
    curl -X GET "https://containers.cloud.ibm.com/v2/storage/getAttachments?cluster=<cluster_ID>&worker=<worker_ID>" --header "X-Auth-Resource-Group-ID: <resource_group_ID>" --header "Authorization: <IAM_token>"
    ```
    {: codeblock}

5. Retrieve the details for a specific attachment.

    ```sh
    curl -X GET "https://containers.cloud.ibm.com/v2/storage/getAttachment?cluster=<cluster_ID>&worker=<worker_ID>&volumeAttachmentID=<volume_attachment_ID>" --header "X-Auth-Resource-Group-ID: <resource_group_ID>" --header "Authorization: <IAM_token>"
    ```
    {: codeblock}

    `IAM_token`
    :   The IAM OAuth token for your current session. You can retrieve this value by running `ibmcloud iam oauth-tokens`.
    
    `cluster_ID`
    :   The unique ID that is assigned to your cluster. You can retrieve this ID by running `ibmcloud ks cluster ls`.
    
    `worker_ID`
    :   The unique ID that is assigned to the worker node where you want to attach your volume. You can retrieve this value by running `ibmcloud ks worker ls -c <cluster_name>`.
    
    `volume_ID`
    :   The unique ID that is assigned to your {{site.data.keyword.blockstorageshort}} volume. You can retrieve a list of your {{site.data.keyword.blockstorageshort}} volumes by running `ibmcloud is volumes`.
    
    `volume_attachment_ID`
    :   The unique ID that is assigned to your volume attachment. You can retrieve this ID by running `ibmcloud is volume <volume_ID>`.




## VPC: Attaching raw {{site.data.keyword.block_storage_is_short}} to VPC worker nodes by using the CLI
{: #vpc_cli_attach}

You can use the {{site.data.keyword.containershort_notm}} CLI to attach and detach raw, unformatted {{site.data.keyword.blockstorageshort}} to a worker node in your VPC cluster.
{: shortdesc}

You can attach a volume to one worker node only. Make sure that the volume is in the same zone as the worker node for the attachment to succeed.
{: note}

The instructions in this topic are available for VPC worker nodes only. If you want to attach raw, unformatted block storage to a classic worker node, you must install the [{{site.data.keyword.cloud_notm}} Block Storage attacher plug-in](#block_storage_attacher).
{: note}

Before you begin:

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. List your storage volumes and note the ID of the volume that you want to attach.

    ```sh
    ibmcloud is vols
    ```
    {: pre}

1. List the worker nodes in your cluster and note the ID of the worker node where you want to attach your volume.

    ```sh
    ibmcloud ks worker ls -c <cluster_name_or_ID>
    ```
    {: pre}

1. Attach your {{site.data.keyword.blockstorageshort}} to your VPC worker node.

    ```sh
    ibmcloud ks storage attachment create --cluster <cluster_name_or_ID> --volume <volume> --worker <worker_ID>
    ```
    {: pre}

### Removing raw {{site.data.keyword.block_storage_is_short}} from VPC worker nodes by using the CLI
{: #storage-util-rm-vpc-cli}


You can remove storage from your worker node by using the `ibmcloud ks storage attachment rm` command.
{: shortdesc}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. List your storage volumes and note the ID of the volume that you want to remove.
    ```sh
    ibmcloud is vols
    ```
    {: pre}

1. Get the details of your volume such as the `worker-id` where the volume is attached. The `worker-id` is listed as the **Instance name** in the **Volume Attachment Instance Reference** section of the command output.

    ```sh
    ibmcloud is vol <volume-ID>
    ```
    {: pre}

    Example output

    ```sh                                      
    Volume Attachment Instance Reference   Attachment type   Instance ID                                 Instance name                                        Auto delete   Attachment ID                               Attachment name      
                                        data              0727_e18c10d7-7f18-48aa-b5ef-5ed163e54198   kube-bsaucubd07dhl66e4tgg-cluster-default-00000a19   false         0727-3bfe90b0-dc2d-498a-946b-8837a5dad7bc   volume-attachment
    ```
    {: screen}

1. List the storage attachments on a worker node in your cluster and make a note of the attachment ID that your want to remove.

    ```sh
    ibmcloud ks storage attachment ls -c <cluster> --worker <worker-id>
    ```
    {: pre}

    Example output:
    ```sh
    Listing volume attachments...
    OK
    ID                                          Name                Status     Type   Volume ID                                   Volume Name                          Worker ID   
    0111-1a111aaa-1111-1111-111a-aaa1a1a11a11   volume-attachment   attached   boot   a001-f11ed1e1-1aa1-11dc-b11d-a0dc111b1111  dissuade-anointer-errand-handbrake   kube-aa1111aa11aaaaa11aa1-cluster-name-default-00000110
    ```
    {: screen}

1. Remove the storage attachment.

    ```sh
    ibmcloud ks storage attachment rm --attachment <attachment-ID> -c <cluster> --worker <worker-ID>
    ```
    {: pre}

1. Verify that your storage was removed from the worker node.

    ```sh
    ibmcloud ks storage attachment ls -c <cluster-ID> --worker <worker-id>
    ```
    {: pre}


## Backing up and restoring PVC data for file and block storage
{: #ibmcloud-backup-restore}





With the {{site.data.keyword.cloud_notm}} Backup Restore Helm chart, you can create a one-time or scheduled backup for data that is stored in a file storage or block storage persistent volume claim (PVC). Your data is stored in an {{site.data.keyword.cos_full_notm}} service instance that you create and own. You can use existing backups in your {{site.data.keyword.cos_full_notm}} service instance to restore data to a PVC in your cluster.
{: shortdesc}

What happens when I install the Helm chart?
:   When you install the Helm chart, a Kubernetes pod is created in your cluster that performs a one-time or periodic backup of your PVC data, or restores data from {{site.data.keyword.cos_full_notm}} to a PVC. You configure your backup or restore in the `values.yaml` file that is provided with the Helm chart or by setting options in the `helm install` command.

What limitations do I need to be aware of?
:   If you want to back up or restore data of a block storage PVC, your PVC must not be mounted to an app. Block storage is mounted with a RWO access mode. This access allows only one pod to be mounted to the block storage at a time. To back up or restore your data, you must remove the pod that uses the storage to unmount the PVC. After the backup or restoring of data is finished, you can re-create your pod and mount the backed up or restored PVC.

What do I need before I get started?
:   To back up or restore data to {{site.data.keyword.cos_full_notm}}, you must [set up an {{site.data.keyword.cos_full_notm}} service instance, create service credentials to access the service, and create a bucket that can hold your data](#backup_restore_setup_object_storage).  

### Setting up an {{site.data.keyword.cos_full_notm}} service instance
{: #backup_restore_setup_object_storage}

Create and configure an {{site.data.keyword.cos_full_notm}} service instance to serve as the repository for the data that you want to back up.
{: shortdesc}

1. Create an [{{site.data.keyword.cos_full_notm}} service instance](/docs/containers?topic=containers-storage-cos-understand#create_cos_service) that uses HMAC credentials.
2. Store your [{{site.data.keyword.cos_full_notm}} credentials in a Kubernetes secret](/docs/containers?topic=containers-storage-cos-understand#create_cos_secret).
3. Create your first {{site.data.keyword.cos_full_notm}} bucket.
    1. In the navigation on the service details page, click **Buckets**.
    2. Click **Create bucket**. A dialog box is displayed.
    3. Enter a unique name for your bucket. The name must be unique within {{site.data.keyword.cos_full_notm}} across all regions and across all {{site.data.keyword.cloud_notm}} accounts.
    4. From the **Resiliency** list, select the level of availability that you want for your data. For more information, see [{{site.data.keyword.cos_full_notm}} regions and endpoints](/docs/cloud-object-storage?topic=cloud-object-storage-endpoints). For VPC clusters, make a note of the direct endpoint. For example: `s3.direct.us.cloud-object-storage.appdomain.cloud`.
    5. Change the **Location** to the region where you want to store your data. Keep in mind that your data might not be allowed to be stored in every region due to legal reasons.  
    6. Click **Create**.
4. Retrieve the {{site.data.keyword.cos_full_notm}} host name for your bucket.
    1. Click your bucket name that you created in the previous step.
    2. In the navigation on the service details page, click **Buckets** > **Configuration**.
    3. Note the public URL that you can use to access the data in your bucket.

For more information about configuring your service instance, see the [{{site.data.keyword.cos_full_notm}}](/docs/cloud-object-storage?topic=cloud-object-storage-getting-started-cloud-object-storage) documentation.

### Using {{site.data.keyword.cos_full_notm}} to back up and restore PVC data
{: #backup-restore-pvc}

You can use the {{site.data.keyword.cloud_notm}} Backup Restore Helm chart to back up data in a file storage or block storage PVC to {{site.data.keyword.cos_full_notm}}, or restore data from {{site.data.keyword.cos_full_notm}} to a PVC in your cluster.
{: shortdesc}

Before you begin:
- Make sure that you have a PVC that you can back up or restore data to. For more information about how to create a PVC, see [Adding file storage to apps](/docs/containers?topic=containers-file_storage#add_file) and [Adding block storage to apps](/docs/containers?topic=containers-block_storage#add_block).
- If you want to back up a block storage PVC, make sure that your PVC is not mounted to an app. Block storage is mounted with a RWO access mode. This access allows only one pod to be mounted to the block storage at a time. To back up your data, you must remove the app pod that mounts the storage. To check whether a pod is mounted to your PVC, run the following command.

    ```sh
    kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
    ```
    {: pre}

- [Retrieve your {{site.data.keyword.cos_full_notm}} service credentials, the bucket name, and the bucket hostname](#backup_restore_setup_object_storage).
- [Follow the instructions](/docs/containers?topic=containers-helm#install_v3) to install the Helm client on your local machine and set up the {{site.data.keyword.cloud_notm}} Helm chart repositories.
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

You can deploy the `ibm-storage-backup` pod or the `ibm-storage-restore` pod by either editing and applying the `values.yaml` file of the Helm chart, or by running the `helm install` command from the CLI.
{: note}

To back up or restore a PVC by editing the `values.yaml` file:

1. Download the latest Helm chart version to your local machine.

    ```sh
    helm fetch --untar iks-charts/ibmcloud-backup-restore
    ```
    {: pre}

2. Open the `values.yaml` file in the `nano` command line editor.
    ```sh
    nano ibmcloud-backup-restore/values.yaml
    ```
    {: pre}

3. Configure your Helm chart to back up or restore PVC data. You can configure the backup for more than one PVC.

    Example to create a backup pod by configuring the `values.yaml` file:

    ```yaml
    image:
        repository: icr.io/iks-charts/ibmcloud-backup-restore
    pullPolicy: Always
    tag: latest
    ACCESS_KEY_ID: # Example: 10110abab1111bbb111aa1aaa111b1a1
    SECRET_ACCESS_KEY: # Example: a1aba11aaa11b11b11aa1111a1111ba111111111a0b1b11a
    ENDPOINT: # Example: s3.us-east.cloud-object-storage.appdomain.cloud
    BUCKET_NAME: # Example: my-bucket
    BACKUP_NAME: # Example: my_backup
    PVC_NAMES:
        - # Example: my_pvc
    - # Optional example: my_pvc2
    CHART_TYPE: # Example: backup or restore
    BACKUP_TYPE: # Example: incremental
    SCHEDULE_TYPE: # Example: periodic
    SCHEDULE_INFO: # Example: weekly
    ```
    {: codeblock}

    `ACCESS_KEY_ID`
    :   Enter the access key ID of the {{site.data.keyword.cos_full_notm}} service credentials that you retrieved earlier.
    
    `SECRET_ACCESS_KEY`
    :   Enter the secret access key of the {{site.data.keyword.cos_full_notm}} service credentials that you retrieved earlier.
    
    `ENDPOINT`
    :   Enter the public {{site.data.keyword.cos_full_notm}} s3 API endpoint for your bucket that you retrieved earlier.
    
    `BUCKET_NAME`
    :   **Backup**: Enter the name of the {{site.data.keyword.cos_full_notm}} bucket that you created earlier. You use this bucket to store PVC data when you perform a backup. **Restore**: Enter the name of the {{site.data.keyword.cos_full_notm}} bucket where your backup is stored.
    
    `BACKUP_NAME`
    :   **Backup**: Enter the name of the backup that you want to create in {{site.data.keyword.cos_full_notm}}. **Restore**: Enter the name of the backup that you created with the {{site.data.keyword.cloud_notm}} Backup Restore Helm chart in {{site.data.keyword.cos_full_notm}}. If you have multiple full backups in your {{site.data.keyword.cos_full_notm}} service instance, the PVC is restored with the data of the last full backup. If you have incremental backups, the PVC is restored with the data of the last full backup, including all incremental backups up to the day where you start the restore.
    
    `PVC_NAMES`
    :   **Backup**: Enter the name of the PVC that you want to back up. If you want to back up multiple PVCs, add each PVC to the list of PVCs. To list available PVCs in your cluster that you can back up, run `kubectl get pvc`. **Restore**: Enter the name of the PVC to which you want to restore data from {{site.data.keyword.cos_full_notm}}. You can restore data to one PVC at a time only. To list available PVCs in your cluster that you can restore data to, run `kubectl get pvc`.
    
    `CHART_TYPE`
    :   Enter the name of the chart type that you want to deploy. Enter `backup` to deploy the backup chart. Enter `restore` to deploy the restore chart.
    
    `BACKUP_TYPE`
    :   Required only for backups. Enter `full` to create a full backup, or `incremental` if you want to back up only new or changed files. If you choose `incremental`, you must specify the `SCHEDULING_INFO` and `SCHEDULING_TYPE` option. If you don't specify the `BACKUP_TYPE` option, a full backup is created by default. 
    
    `SCHEDULE_TYPE`
    :   Required only for backups. Enter `periodic` to create scheduled backups, or leave this option empty to create a one-time backup. If you want to create periodic backups, you must define the backup interval in the `SCHEDULE_INFO` option.
    
    `SCHEDULE_INFO`
    :   Required only for backups. If you want to create periodic backups, you must decide on the backup schedule. Choose between `hourly`, `daily`, or `weekly`. If you set this option, you must set `SCHEDULE_TYPE` to `periodic`.
    
4. Save and close the `values.yaml` file.

5. Install the Helm chart with your custom settings in the `values.yaml` file. When you install the Helm chart and you configure a backup or restore, an `ibm-storage-backup` or an `ibm-storage-restore` pod is deployed to your cluster. The backup pod backs up the data from your PVC to {{site.data.keyword.cos_full_notm}} and the restore pod restores data to a PVC. Replace `<release_name>` with a name for your Helm chart. Be sure to install the backup and restore pods in the same zone as the PVC that you want to back up or restore.

    * Install the Helm chart by using the `helm install` command.
    
        ```sh
        helm install <release_name> ./ibmcloud-backup-restore -n <namespace>
        ```
        {: pre}

        Example output for backup:

        ```sh
        NAME: <release_name>
        LAST DEPLOYED: Mon Jan 20 09:17:02 2020
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        NOTES:
        Thank you for installing: ibmcloud-backup-restore.   Your release is named: <release_name>

        Please refer Chart README.md file for creating a sample PVC
        Please refer Chart RELEASE.md to see the release details/fixes
        ```
        {: screen}

    * Optional: Install the Helm chart by setting options in the `helm install` command. You can name your release by specifying the `--name` parameter.
        ```sh
        helm install <release_name> --set ACCESS_KEY_ID=<access_key_ID> --set SECRET_ACCESS_KEY=<secret_access_key> --set ENDPOINT=<public_bucket_endpoint> --set BUCKET_NAME=<bucket_name> --set BACKUP_NAME=<backup_name> --set PVC_NAMES[0]=<pvc_name1> --set PVC_NAMES[1]=<pvc_name2> --set CHART_TYPE=backup --set BACKUP_TYPE=<backup_type> --set SCHEDULE_TYPE=<schedule_type> --set SCHEDULE_INFO=<schedule_info> ./ibmcloud-backup-restore
        ```
        {: pre}

6. Verify that your data backup or restore completed successfully.

    **Backup**:
    1. Verify that the `ibm-storage-backup` pod has a status of **Running**.
        ```sh
        kubectl get pods -A | grep backup
        ```
        {: pre}

        Example output
        
        ```sh
        ibm-storage-backup                        1/1     Running             0          64m
        ```
        {: screen}

    2. Review the logs of the `ibm-storage-backup` pod to make sure that your backup was successful. When you see the `... backup completed` message in the logs, your backup completed successfully.

        ```sh
        kubectl logs ibm-storage-backup
        ```
        {: pre}

        Example output for daily backups.

        ```sh
        [2019-04-18 16:01:51,157] [utilities : 151] [INFO] *****************Start logging to ./Backup.log
        [2019-04-18 16:01:51,158] [backup : 48] [INFO] Starting backup:
        [2019-04-18 16:01:51,158] [configureOS : 66] [INFO] Configuring duplicity with IBM CloudObjectStorage i.e s3.
        [2019-04-18 16:01:51,158] [backup : 62] [INFO] Configuration done!!!
        [2019-04-18 16:01:51,158] [backup : 78] [INFO] Got all required input from config file!!
        [2019-04-18 16:01:52,366] [backup : 119] [WARNING] Incremental backup was not created
        [2019-04-18 16:01:52,366] [backup : 120] [INFO] duplicity  --no-encryption incremental /myvol s3://s3.us-south.cloud-object-storage.appdomain.cloud/mybucket/helm-backup command failed due to Fatal Error: Unable to start incremental backup.  Old signatures not found and incremental specified

        [2019-04-18 16:01:52,367] [backup : 121] [INFO] A full backup is required before incremental backups can begin. Creating a one-time full backup and will run incremental backups for scheduled backups.
        [2019-04-18 16:01:54,357] [backup : 129] [INFO] Full backup completed
        [2019-04-18 16:01:54,357] [backup : 130] [INFO] Local and Remote metadata are synchronized, no sync needed.
        Last full backup date: none
        --------------[ Backup Statistics ]--------------
        StartTime 1555603313.31 (Thu Apr 18 16:01:53 2019)
        EndTime 1555603313.32 (Thu Apr 18 16:01:53 2019)
        ElapsedTime 0.01 (0.01 seconds)
        SourceFiles 3
        SourceFileSize 20495 (20.0 KB)
        NewFiles 3
        NewFileSize 20495 (20.0 KB)
        DeletedFiles 0
        ChangedFiles 0
        ChangedFileSize 0 (0 bytes)
        ChangedDeltaSize 0 (0 bytes)
        DeltaEntries 3
        RawDeltaSize 15 (15 bytes)
        TotalDestinationSizeChange 183 (183 bytes)
        Errors 0
        -------------------------------------------------

        [2019-04-18 16:01:54,357] [backup : 162] [INFO] Scheduling backup as per configurations, please don't stop this program or run this in background !!!
        [2019-04-18 16:01:54,358] [backup : 166] [INFO] Schedule info is: ['daily']
        [2019-04-18 16:01:54,358] [backup : 172] [INFO] Scheduled for daily!!!
        ```
        {: screen}

7. Verify that your data is successfully backed up or restored.
    * **Backup**:
        1. Find your {{site.data.keyword.cos_full_notm}} service instance in the [{{site.data.keyword.cloud_notm}} resource list](https://cloud.ibm.com/resources).
        2. From the navigation, select **Buckets** and click the bucket that you used in your backup configuration. Your backup is displayed as an object in your bucket.
        3. Review the compressed files. You can download the `*.gz` file, extract the file, and verify the backed-up data.

    * **Restore**:
        1. Create a `deployment.yaml` file with a pod that mounts the PVC that contains your restored data. The following example deploys an `nginx` pod that mounts the PVC on the `/test` mount directory.
            ```yaml
              apiVersion: apps/v1
              kind: Deployment
              metadata:
                name: restore
                labels:
                app: nginx
              spec:
                selector:
                  matchLabels:
                    app: nginx
                template:
                  metadata:
                    labels:
                      app: nginx
                  spec:
                    containers:
                      - image: nginx
                        name: nginx
                        volumeMounts:
                        - name: my-volume # Example: my_volume
                          mountPath: /test # Example: /test
                    volumes:
                    - name: my-volume # Example: my_volume
                      persistentVolumeClaim:
                        claimName: my-actual-pvc-name # Example: my_pvc
            ```
            {: codeblock}

            `spec.containers.image`
            :   The name of the image that you want to use. To list available images in your {{site.data.keyword.registrylong_notm}} account, run `ibmcloud cr image-list`.
            
            `spec.containers.name`
            :   The name of the container that you want to deploy to your cluster.
            
            `spec.containers.volumeMounts.mountPath`
            :   The absolute path of the directory to where the volume is mounted inside the container. Data that is written to the mount path is stored under the root directory in your physical block storage instance. If you want to share a volume between different apps, you can specify [volume sub paths](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath){: external} for each of your apps.
            
            `spec.containers.volumeMounts.name`
            :   The name of the volume to mount to your pod.
            
            `volumes.name`
            :   The name of the volume to mount to your pod. Typically this name is the same as `volumeMounts/name`
            
            `volumes.persistentVolumeClaim.claimName`
            :   The name of the PVC that binds the PV that you want to use.

        2. Create the deployment.
        
            ```sh
            kubectl apply -f deployment.yaml
            ```
            {: pre}

        3. Verify that your pod has a status of **Running**.

            If you find that your `ibm-storage-restore` pod does not reach a **Completed** or **CrashLoopBackOff** status, restoring your data might have failed. Run `kubectl logs ibm-storage-restore` to find the root cause for the failure.
            {: tip}

            ```sh
            kubectl get pods | grep restore
            ```
            {: pre}

            Example output
            
            ```sh
            restore-7dfc6f4c78-wkcqp                  1/1     Running             0          3m54s
            ```
            {: screen}

        4. Log in to your pod.
        
            ```sh
            kubectl exec <pod_name> -it bash
            ```
            {: pre}

        5. Navigate to the mount directory that you specified in your deployment YAML.
        
            ```sh
            cd <mount_directory>
            ```
            {: pre}

        6. List the files in your mount directory to verify that all your data is restored to the mount directory.
        
            ```sh
            ls
            ```
            {: pre}

        7. Delete the Helm chart installation from your cluster. This step is required if you restored data to a block storage PVC. Block storage is mounted with a RWO access mode. This access allows only one pod to be mounted to the block storage at a time. Because the `ibm-storage-restore` pod already mounts the PVC, you must remove the pod to release the PVC so that you can mount the PVC to a different pod in your cluster.
        
            ```sh
            helm uninstall <release_name> -n <namespace>
            ```
            {: pre}

        8. You successfully restored your backup. You can now mount the PVC that binds the PV to any other pod in your cluster to access the restored files. If the container data that was backed up included a non-root user, you must add non-root permissions to your new container. For more information, see [Adding non-root user access to volumes](/docs/containers?topic=containers-cs_storage_nonroot).


## Setting up {{site.data.keyword.mon_full_notm}} for storage volumes
{: #monitor_storage}

Set up alerts in {{site.data.keyword.mon_full_notm}} for your workloads that are using storage volumes. For more information see, [Alerts](/docs/monitoring?topic=monitoring-monitoring).
{: shortdesc}

When a storage volume is down, your app pods that are using storage have a low file system I/O, have network errors, or crash which causes the replica count to go down. You can set up alerts in {{site.data.keyword.mon_full_notm}} to get notified if the file system operations for your app drop under a specific threshold, if network errors occur, or if your app pods don't reach a `Ready` state.

1. From the [console](https://cloud.ibm.com/containers/cluster-management/clusters){: external}, select the cluster where you want to set up alerts for your storage volumes.

2. In the **Monitoring** section, click **Connect** to connect an existing {{site.data.keyword.mon_full_notm}} instance to your cluster. If you don't have an instance, click **Create an instance** to create one. For more information about how to set up an {{site.data.keyword.mon_full_notm}} instance, see [Provisioning an instance](/docs/monitoring?topic=monitoring-provision).

3. Click the **Launch** button to open the {{site.data.keyword.mon_full_notm}} dashboard.

4. Create file system utilization alerts for an app that runs in your cluster.
    1. From the {{site.data.keyword.mon_full_notm}} console, click **Overview** > **Workloads**.
    2. Select the **Namespace** where your app is deployed. Find your app, click the arrow icon on your app, and select **Kubernetes Pod overview**.
    3. In the **File System Utilization** section, review the **File I/O Bandwidth by Pod** tile.
    4. Review the file I/O bandwidth from the last day or week time window to determine the average bandwidth. You can use the average bandwidth as a threshold to set an alert for when the file I/O bandwidth is less than the average for a certain amount of time. For example, if the average file I/O bandwidth for your app is 300B/s, you can create an alert for when the network utilization remains less than 300B/s for a certain amount of time.
    5. In the **File I/O Bandwidth by Pod** tile, create an alert by clicking the **Options** menu and then **Create alert**.
    6. Open the **Notification** section of the alert menu and create or select an alert notification channel.
    7. Save your alert.
    8. Repeat these steps for all the apps that are deployed in your cluster.
    9. Test the alert that you created by editing the threshold that you configured to manually trigger the alert. For example, if you set a file system utilization alert to trigger when the utilization is less than 300B/s for 5 minutes, increase the threshold to be greater than the current utilization of your app for 5 minutes and select the `at least once` option.
    10. Verify that the alert is triggered after 5 minutes. Once you have verified the alert, reset the values to the values you configured earlier.

5. Create a network utilization alert for an app that runs in your cluster.
    1. From the {{site.data.keyword.mon_full_notm}} console, click **Overview** > **Workloads**.
    2. Select the **Namespace** where your app is deployed. Find your app, click the arrow icon on your app, and select **Kubernetes Pod overview**.
    3. In the **Network Utilization** section, review the **Network Request Count by Pod** tile.
    4. Review the average network request count by pod from the last 1 day or 1 week time window to determine the threshold.
    5. In the **Network Request Count by Pod** tile, create an alert by clicking the **Options** menu and then **Create alert**. Set the alert parameters based on the threshold that you observed. For example, if the network utilization remains under the threshold for a certain amount of time, then the alert is triggered.
    6. Open the **Notification** section of the alert menu and create or select an alert notification channel.
    7. Save your alert.
    8. Repeat these steps for all the apps that are deployed in your cluster.
    9. Test the alert that you created by editing the threshold that you configured to manually trigger the alert. For example, if you set an alert for when the number of network requests by pod is less than 3/s for 5 minutes, edit your alert threshold to be less than the threshold that you observed for 5 minutes and select the `at least once` option.
    10. Verify that the alert is triggered after 5 minutes. Once you have verified the alert, reset the values to the values you configured earlier.

6. Create a pod availability alert for an app that runs in your cluster.
    1. From the {{site.data.keyword.mon_full_notm}} console, click **Overview** > **Workloads**.
    2. Select the **Namespace** where your app is deployed. Find your app, click the arrow icon on your app, and select **Kubernetes Pod overview**.
    3. In the **Pod Health** section, review the **Pod Availability** tile.
    4. Review the average pod availability from the last 1 day or 1 week time window to determine the threshold.
    5. Review your app configuration file for the number of requested replicas. You can use this number as a threshold for sending alerts when the number of available pods is fewer than your requested number of replicas for your app. If you requested 3 replicas of your app, you can set an alert for when the number of available pods stays fewer than the requested replica count for a certain time duration, for example, a 30 minute duration. In this example, when the pod availability remains fewer than the 3 requested replicas, the alert is triggered.
    6. In the **Pod Availability** tile, create an alert by clicking the **Options** menu and then **Create alert**. Set the alert parameters based on the threshold that you observed and your requested app replicas.
    7. Open the **Notification** section of the alert menu and create or select an alert notification channel.
    8. Save your alert.
    9. Repeat these steps for all the apps that are deployed in your cluster.
    10. Test the alert that you created by editing the threshold that you configured to manually trigger the alert. For example, if you set a pod availability alert for when the number of available pods is less than 3 for 5 minutes, edit your alert threshold to be less than 4 pods for 5 minutes and select the `at least once` option.
    11. Verify that the alert is triggered after 5 minutes. Once you have verified the alert, reset the values to the values you configured earlier.

### Troubleshooting persistent storage when an {{site.data.keyword.mon_full_notm}} alert is triggered
{: #monitor_storage_ts}


When an alert is triggered, review the alert details in {{site.data.keyword.mon_full_notm}} and review troubleshooting guides for persistent storage, apps, worker nodes, and clusters to find the root cause of the alert. The alerts that you set up might not be related to a storage volume issue, but to issues that occurred within your app, on the worker node, or in the cluster.
{: shortdesc}


* [Troubleshooting persistent storage volumes](/docs/containers?topic=containers-debug_storage_file).
* [Troubleshooting worker nodes](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload).
* [Troubleshooting apps](/docs/containers?topic=containers-debug_apps).
* [Troubleshooting clusters](/docs/containers?topic=containers-debug_clusters).
* [Open a support case](/docs/account?topic=account-using-avatar).
