---

copyright:
  years: 2014, 2018
lastupdated: "2018-07-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Removing persistent storage from a cluster
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
