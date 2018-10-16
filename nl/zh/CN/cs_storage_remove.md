---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 从集群中除去持久性存储器
{: #cleanup}

在集群中设置持久性存储器时，有三个主要组件：Kubernetes 持久性卷申领 (PVC)（用于请求存储器）、Kubernetes 持久性卷 (PV)（安装到 pod，并在 PVC 中进行描述）和 IBM Cloud Infrastructure (SoftLayer) 实例（例如，NFS 文件存储器或块存储器）。根据创建方式，您可能需要分别删除所有三个组件。
{:shortdesc}

## 清除持久性存储器
{: #storage_remove}

了解删除选项：

**我已删除集群。还必须删除其他任何内容才能除去持久性存储器吗？**</br>
视情况而定。删除集群时，会删除 PVC 和 PV。但是，您可选择是否除去 IBM Cloud Infrastructure (SoftLayer) 中的关联存储器实例。如果选择不除去，那么存储器实例仍然存在。此外，如果删除的是状态为运行状况不佳的集群，那么即使选择除去存储器，存储器也仍然可能存在。请遵循指示信息，尤其是在 IBM Cloud Infrastructure (SoftLayer) 中[删除存储器实例](#sl_delete_storage)的步骤。

**可以通过删除 PVC 来除去所有存储器吗？**</br>
有时可以。如果[动态创建持久性存储器](cs_storage_basics.html#dynamic_provisioning)，并且选择其名称中不含 `retain` 的存储类，那么删除 PVC 时，会同时删除 PV 和 IBM Cloud Infrastructure (SoftLayer) 存储器实例。

在其他所有情况下，请遵循指示信息来检查 PVC、PV 和物理存储设备的状态，并根据需要单独进行删除。 

**删除存储器后，我还需要为该存储器付费吗？**</br>
这取决于删除的内容和计费类型。如果删除 PVC 和 PV，但未删除 IBM Cloud Infrastructure (SoftLayer) 帐户中的实例，那么该实例仍然存在，因此您仍需要为此付费。必须删除所有内容才能避免继续付费。此外，在 PVC 中指定 `billingType` 时，可以选择 `hourly` 或 `monthly`。如果选择 `monthly`，那么将按月对实例收费。删除实例后，您仍需为该月的剩余时间付费。


**重要信息**：
* 清除持久性存储器时，将删除其中存储的所有数据。如果需要数据的副本，请备份[文件存储器](cs_storage_file.html#backup_restore)或[块存储器](cs_storage_block.html#backup_restore)。
* 如果使用的是 {{site.data.keyword.Bluemix_dedicated}} 帐户，那么必须通过[开具支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)来请求卷删除。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)。

要清除持久数据，请执行以下操作：

1.  列出集群中的 PVC，并记下 PVC 的 **NAME**、**STORAGECLASS** 以及绑定到该 PVC 并显示为 **VOLUME** 的 PV 的名称。
    ```
    kubectl get pvc
    ```
    {: pre}

    输出示例：
    ```
    NAME                  STATUS    VOLUME                                     CAPACITY   ACCESSMODES   STORAGECLASS            AGE
    claim1-block-bronze   Bound     pvc-06886b77-102b-11e8-968a-f6612bb731fb   20Gi       RWO           ibmc-block-bronze       78d
    claim-file-bronze     Bound     pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356c   4Gi        RWX           ibmc-file-bronze-retain 105d
    claim-file-silve      Bound     pvc-1efef0ba-0c48-11e8-968a-f6612bb731fb   24Gi       RWX           ibmc-file-silver        83d
    ```
    {: screen}
    
2. 查看存储类的 **ReclaimPolicy** 和 **billingType**。 
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}
   
   如果回收策略显示为 `Delete`，那么在除去 PVC 时会除去 PV 和物理存储器。如果回收策略显示 `Retain`，或者供应的是不使用存储类的存储器，那么在除去该 PVC 时不会除去 PV 和物理存储器。您必须分别除去 PVC、PV 和物理存储器。 
   
   **重要信息：**如果存储器是按月收费的，那么即使在结算周期结束之前除去了存储器，也仍会按整月收费。 
   
3. 除去安装了 PVC 的所有 pod。 
   1. 列出安装了 PVC 的所有 pod。
      ```
      kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
      ```
      {: pre}
    
      输出示例：
    ```
      blockdepl-12345-prz7b:	claim1-block-bronze  
      ```
      {: screen}
    
      如果 CLI 输出中未返回任何 pod，说明没有使用该 PVC 的 pod。 
    
   2. 除去使用该 PVC 的 pod。如果 pod 是部署的一部分，请除去该部署。
      ```
      kubectl delete pod <pod_name>
      ```
      {: pre}
      
   3. 验证 pod 是否已除去。
      ```
            kubectl get pods
            ```
      {: pre}
   
4. 除去 PVC。 
   ```
   kubectl delete pvc <pvc_name>
   ```
   {: pre}
   
5. 复查 PV 的阶段状态。使用先前检索到的显示为 **VOLUME** 的 PV 的名称。 
   ```
   kubectl get pv <pv_name>
   ```
   {: pre}
   
   除去 PVC 时，会释放绑定到该 PVC 的 PV。根据供应存储器的方式，如果 PV 是自动删除的，那么该 PV 会进入 `Deleting` 状态，或者如果必须手动删除 PV，那么该 PV 会进入 `Released` 状态。 
   
   **注**：对于自动删除的 PV，在删除之前，阶段状态可能会短暂地显示为 `Released`。几分钟后重新运行该命令以查看该 PV 是否已除去。
   
6. 如果 PV 未删除，请手动除去该 PV。 
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}
   
7. 验证 PV 是否已除去。 
   ```
    kubectl get pv
    ```
   {: pre}
   
8. {: #sl_delete_storage}列出 PV 指向的物理存储器实例，并记下物理存储器实例的 **id**。 

   **文件存储器：** 
   ```
   ibmcloud sl file volume-list --columns id  --columns notes | grep <pv_name>
   ```
   {: pre}
   **块存储器：**
   ```
   ibmcloud sl block volume-list --columns id --columns notes | grep <pv_name>
   ```
   {: pre}
     
   如果已除去集群，而无法检索 PV 的名称，请将 `grep <pv_name>` 替换为 `grep <cluster_id>` 以列出与集群关联的所有存储设备。
   {: tip}
     
   输出示例： 
   ```
   id         notes   
   12345678   ibmcloud-block-storage-plugin-7566ccb8d-44nff:us-south:aa1a11a1a11b2b2bb22b22222c3c3333:Performance:mypvc:pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356z 
   ```
   {: screen}
     
   了解 **Notes** 字段信息：
   *  **`:`**：冒号 (`:`) 用于分隔信息。
   *  **`ibmcloud-block-storage-plugin-7566ccb8d-44nff`**：集群使用的存储器插件。
   *  **`us-south`**：集群所在的区域。
   *  **`aa1a11a1a11b2b2bb22b22222c3c3333`**：与存储器实例关联的集群标识。
   *  **`Performance`**：文件存储器或块存储器的类型：`Endurance` 或 `Performance`。
   *  **`mypvc`**：与存储器实例关联的 PVC 的名称。
   *  **`pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356z`**：与存储器实例关联的 PV。
     
9. 除去物理存储器实例。 
   
   **文件存储器：**
   ```
   ibmcloud sl file volume-cancel <filestorage_id>
   ```
   {: pre}
   
   **块存储器：**
   ```
   ibmcloud sl block volume-cancel <blockstorage_id>
   ```
   {: pre}
     
9. 验证物理存储器实例是否已除去。此过程可能需要几分钟时间。 

   **文件存储器：** 
   ```
   ibmcloud sl file volume-list 
   ```
   {: pre}
   **块存储器：**
   ```
   ibmcloud sl block volume-list 
   ```
   {: pre}
 
