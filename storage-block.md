---

copyright: 
  years: 2014, 2025
lastupdated: "2025-10-06"


keywords: kubernetes, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# Setting up {{site.data.keyword.blockstorageshort}}
{: #block_storage}

{{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} is persistent, high-performance iSCSI storage that you can add to your apps by using Kubernetes persistent volumes (PVs). You can choose between predefined storage tiers with GB sizes and IOPS that meet the requirements of your workloads. To find out whether {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} is the correct storage option for you, see [Choosing a storage solution](/docs/containers?topic=containers-storage-plan).
{: shortdesc}

Keep in mind the following requirements when you use the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in.
{: important}

{{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in is available only for standard {{site.data.keyword.containerlong_notm}} clusters that are provisioned on classic infrastructure.  If you have a VPC cluster, see [Setting up {{site.data.keyword.blockstorageshort}}](/docs/containers?topic=containers-storage-block-vpc-sc-ref).


If your cluster can't access the public network, such as a private cluster behind a firewall or a cluster with only the private cloud service endpoint enabled, make sure that you installed the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in version 1.3.0 or later to connect to your {{site.data.keyword.blockstorageshort}} instance over the private network.


{{site.data.keyword.blockstorageshort}} instances are specific to a single-campus multizone region. If you have a multizone cluster, consider [multizone persistent storage options](/docs/containers?topic=containers-storage-plan).

[Classic infrastructure]{: tag-classic-inf}


The steps on this page apply to classic clusters only. On VPC clusters, the {{site.data.keyword.block_storage_is_short}} cluster add-on is installed by default. For more information, see [Setting up Setting up {{site.data.keyword.block_storage_is_short}}](/docs/containers?topic=containers-vpc-block).
{: important}



## Quick start for {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}}
{: #block_qs}

In this quick start guide, you create a 24Gi silver tier {{site.data.keyword.blockstorageshort}} volume in your cluster by creating a PVC to dynamically provision the volume. Then, you create an app deployment that mounts your PVC.
{: shortdesc}

First time using {{site.data.keyword.blockstorageshort}} in your cluster? Come back here after you have the [installed the {{site.data.keyword.blockstorageshort}} plug-in](#install_block).
{: important}

1. Save the following persistent volume claim (PVC) configuration to a file called `pvc.yaml`.

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: block-storage-pvc
      labels:
        billingType: "hourly"
        region: us-east
        zone: wdc07
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 45Gi
      storageClassName: ibmc-block-silver
    ```
    {: codeblock}

1. Apply the configuration to your cluster to create the PVC.

    ```sh
    kubectl apply -f pvc.yaml
    ```
    {: pre}
    
1. Wait until your PVC is in the `Bound` status. You can check the status by running the following command.
    ```sh
    kubectl get pvc
    ```
    {: pre}

1. After your PVC is `Bound`, create an app deployment that uses your PVC. Save the following deployment configuration to a file called `deployment.yaml`.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-deployment
      labels:
        app: my-app
    spec:
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - image: nginx # Use the nginx image, or your own containerized app image.
            name: my-container
            command: ["/bin/sh"]
            args: ["-c", "while true; do date \"+%Y-%m-%d %H:%M:%S\"; sleep 3600; done"] # This app prints the timestamp, then sleeps.
            workingDir: /home
            imagePullPolicy: Always
            ports: 
              - containerPort: 80
            volumeMounts:
            - name: my-volume
              mountPath: /mount-path
          volumes:
          - name: my-volume
            persistentVolumeClaim:
              claimName: block-storage-pvc
    ```
    {: codeblock}

1. Create the deployment in your cluster.

    ```sh
    kubectl apply -f deployment.yaml
    ```
    {: pre}
    
1. Wait until the deployment is `Ready`. Check the status of the deployment by running the following command.
    ```sh
    kubectl get deployments
    ```
    {: pre}
    
    Example output
    ```sh
    NAME            READY   UP-TO-DATE   AVAILABLE   AGE
    my-deployment   1/1     1            1           3m19s
    ```
    {: screen}
    
1. List your pods and verify the `my-deployment` pod is running.
    ```sh
    kubectl get pods
    ```
    {: pre}
    
    Example output
    ```sh
    NAME                            READY   STATUS    RESTARTS   AGE
    my-deployment-ccdf87dfb-vzn95   1/1     Running   0          5m27s
    ```
    {: pre}
    
    
1. Get the pods logs to verify the timestamp is written.
    ```sh
    kubectl logs
    ```
    {: pre}
    
    Example output
    ```sh
    2022-01-21 14:18:59
    ```
    {: pre}
    
You've successfully created a deployment that uses {{site.data.keyword.blockstorageshort}}! For more information, see the following links.

* [Installing the {{site.data.keyword.blockstorageshort}} plug-in](#install_block)
* [Adding {{site.data.keyword.blockstorageshort}} to apps](#add_block).
* [Storage class reference](#block_storageclass_reference).
* [Customizing storage classes](#block_custom_storageclass).



## Installing the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in in your cluster
{: #install_block}

Install the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in with a Helm chart to set up pre-defined storage classes for {{site.data.keyword.blockstorageshort}}. You can use these storage classes to create a PVC to provision {{site.data.keyword.blockstorageshort}} for your apps.
{: shortdesc}

Classic clusters that run {{site.data.keyword.containerlong_notm}} version 1.24 or later do not need to install the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in. The driver and plug-in are installed on these clusters by default.
{: tip}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Make sure that your worker node applies the latest patch for your minor version to run your worker node with the latest security settings. The patch version also ensures that the root password on the worker node is renewed. 

    If you did not apply updates or reload your worker node within the last 90 days, your root password on the worker node expires and the installation of the storage plug-in might fail. 
    {: note}

    1. List the current patch version of your worker nodes.
        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Example output
        ```sh
        OK
        ID                                                  Public IP        Private IP     Machine Type           State    Status   Zone    Version
        kube-dal10-crb1a23b456789ac1b20b2nc1e12b345ab-w26   169.xx.xxx.xxx    10.xxx.xx.xxx   b3c.4x16.encrypted     normal   Ready    dal10   1.33_1523*
        ```
        {: screen}

        If your worker node does not apply the latest patch version, you see an asterisk (`*`) in the **Version** column of your CLI output.

    2. Review the [Kubernetes version information](/docs/containers?topic=containers-cs_versions) to find the latest changes.

    3. Apply the latest patch version by reloading your worker node. Follow the instructions in the [ibmcloud ks worker reload command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) to safely reschedule any running pods on your worker node before you reload your worker node. Note that during the reload, your worker node machine is updated with the latest image and data is deleted if not [stored outside the worker node](/docs/containers?topic=containers-storage-plan).

1. [Follow the instructions](/docs/containers?topic=containers-helm#install_v3) to install the Helm version 3 client on your local machine.


1. Add the {{site.data.keyword.cloud_notm}} Helm chart repository to the cluster where you want to use the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in.

    If you enabled [VRF](/docs/account?topic=account-vrf-service-endpoint&interface=ui) and [service endpoints](/docs/account?topic=account-vrf-service-endpoint#service-endpoint) in your {{site.data.keyword.cloud_notm}} account, you can use the private {{site.data.keyword.cloud_notm}} Helm repository to keep your image pull traffic on the private network. If you can't enable VRF or service endpoints in your account, use the public registry domain: `helm repo add iks-charts https://icr.io/helm/iks-charts`.
    {: note}

    ```sh
    helm repo add iks-charts https://icr.io/helm/iks-charts
    ```
    {: pre}

1. Update the Helm repo to retrieve the latest version of all Helm charts in this repo.

    ```sh
    helm repo update
    ```
    {: pre}

1. Install the {{site.data.keyword.cloud_notm}} {{site.data.keyword.blockstorageshort}} plug-in and give your installation a name, for example: `block-storage-plugin`. When you install the plug-in, pre-defined block storage classes are added to your cluster.

    ```sh
    helm install <name> iks-charts/ibmcloud-block-storage-plugin -n <namespace>
    ```
    {: pre}

    Example output

    ```sh
    NAME:   <name>
    LAST DEPLOYED: Wed Apr 18 10:02:55 2018
    NAMESPACE: default
    STATUS: DEPLOYED

    RESOURCES:
    ==> v1beta1/DaemonSet
    NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
    ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

    ==> v1beta1/Deployment
    NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
    ibmcloud-block-storage-plugin  1        0        0           0          0s

    ==> v1/StorageClass
    NAME                      PROVISIONER        AGE
    ibmc-block-bronze         ibm.io/ibmc-block  0s
    ibmc-block-custom         ibm.io/ibmc-block  0s
    ibmc-block-gold           ibm.io/ibmc-block  0s
    ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
    ibmc-block-retain-custom  ibm.io/ibmc-block  0s
    ibmc-block-retain-gold    ibm.io/ibmc-block  0s
    ibmc-block-retain-silver  ibm.io/ibmc-block  0s
    ibmc-block-silver         ibm.io/ibmc-block  0s

    ==> v1/ServiceAccount
    NAME                           SECRETS  AGE
    ibmcloud-block-storage-plugin  1        0s

    ==> v1beta1/ClusterRole
    NAME                           AGE
    ibmcloud-block-storage-plugin  0s

    ==> v1beta1/ClusterRoleBinding
    NAME                           AGE
    ibmcloud-block-storage-plugin  0s

    NOTES:
    Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: <name>
    ```
    {: screen}

1. Verify the installation.

    ```sh
    kubectl get pod -n <namespace> | grep block
    ```
    {: pre}

    Example output
    
    ```sh
    ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
    ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
    ```
    {: screen}

    The installation is successful when you see one `ibmcloud-block-storage-plugin` pod and one or more `ibmcloud-block-storage-driver` pods. The number of `ibmcloud-block-storage-driver` pods equals the number of worker nodes in your cluster. All pods must be in a **Running** state.

1. Verify the storage classes for {{site.data.keyword.blockstorageshort}} were added to your cluster.

    ```sh
    kubectl get sc | grep block
    ```
    {: pre}

    Example output
    
    ```sh
    ibmc-block-bronze                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-custom                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-gold                        ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-retain-bronze               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-custom               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-gold                 ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-silver               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-silver                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ```
    {: screen}

1. Repeat these steps for every cluster where you want to provision block storage.

You can now continue to [create a PVC](#add_block) to provision block storage for your app.


### Updating the {{site.data.keyword.cloud_notm}} Block Storage plug-in
{: #update_block}

You can upgrade the existing {{site.data.keyword.cloud_notm}} Block Storage plug-in to the latest version.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Update the Helm repo to retrieve the latest version of all Helm charts in this repo.

    ```sh
    helm repo update
    ```
    {: pre}

2. Optional: Download the latest Helm chart to your local machine. Then, extract the package and review the `release.md` file to find the latest release information.

    ```sh
    helm pull iks-charts/ibmcloud-block-storage-plugin --untar
    ```
    {: pre}

3. Find the release name and namespace of the block storage Helm chart that you installed in your cluster.

    ```sh
    helm ls -A
    ```
    {: pre}

    Example output
    
    ```sh
    NAME            NAMESPACE   REVISION    UPDATED                             STATUS      CHART                                   APP VERSION
    block-plugin    default     1           2022-01-21 09:02:46.11622 -0500 EST deployed        bmcloud-block-storage-plugin-v2.1.5
    ```
    {: screen}

4. Upgrade the {{site.data.keyword.cloud_notm}} Block Storage plug-in to the latest version. Include the release name and the namespace that you retrieved earlier.

    ```sh
    helm upgrade RELEASE-NAME iks-charts/ibmcloud-block-storage-plugin -n NAMESPACE
    ```
    {: pre}

5. Optional: When you update the plug-in, the `default` storage class is unset. If you want to set the default storage class to a storage class of your choice, run the following command.

    ```sh
    kubectl patch storageclass STORAGECLASS -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```
    {: pre}

### Removing the {{site.data.keyword.cloud_notm}} Block Storage plug-in
{: #rm_block}

If you don't want to provision and use {{site.data.keyword.cloud_notm}} Block Storage in your cluster, you can uninstall the Helm chart.
{: shortdesc}

Removing the plug-in does not remove existing PVCs, PVs, or data. When you remove the plug-in, all the related pods and daemon sets are removed from your cluster. You can't provision new block storage for your cluster or use existing block storage PVCs and PVs after you remove the plug-in.
{: important}

Before you begin:
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
- Make sure that you don't have any PVCs or PVs in your cluster that use block storage.

To remove the plug-in:

1. Find the release name and the namespace of the block storage Helm chart that you installed in your cluster.

    ```sh
    helm ls -A
    ```
    {: pre}

    Example output
    
    ```sh
    NAME            NAMESPACE   REVISION    UPDATED                             STATUS   CHART                                  APP VERSION
    block-plugin    default     1           2022-01-21 09:02:46.11622 -0500 EST deployed    ibmcloud-block-storage-plugin-v2.1.5
    ```
    {: screen}

2. Delete the {{site.data.keyword.cloud_notm}} Block Storage plug-in.

    ```sh
    helm uninstall NAME -n kube-system
    ```
    {: pre}

3. Verify that the block storage pods are removed.

    ```sh
    kubectl get pods -n kube-system | grep block
    ```
    {: pre}

    The removal of the pods is successful if no pods are displayed in your CLI output.

4. Verify that the block storage classes are removed. The removal of the storage classes is successful if no storage classes are displayed in your CLI output.

    ```sh
    kubectl get sc | grep block
    ```
    {: pre}

    






## Deciding on the block storage configuration
{: #block_predefined_storageclass}

{{site.data.keyword.containerlong_notm}} provides pre-defined storage classes for block storage that you can use to provision block storage with a specific configuration.
{: shortdesc}

Every storage class specifies the type of block storage that you provision, including available size, IOPS, file system, and the retention policy.  

Make sure to choose your storage configuration carefully to have enough capacity to store your data. After you provision a specific type of storage by using a storage class, you can't change the type or retention policy for the storage device. However, you can [change the size and the IOPS](#block_change_storage_configuration) if you want to increase your storage capacity and performance. To change the type and retention policy for your storage, you must create a new storage instance and copy the data from the old storage instance to your new one.
{: important}

1. List available storage classes in {{site.data.keyword.containerlong}}.

    ```sh
    kubectl get sc | grep block
    ```
    {: pre}

    Example output

    ```sh
    ibmc-block-bronze                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-custom                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-gold                        ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ibmc-block-retain-bronze               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-custom               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-gold                 ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-retain-silver               ibm.io/ibmc-block   Retain          Immediate           true                   148m
    ibmc-block-silver                      ibm.io/ibmc-block   Delete          Immediate           true                   148m
    ```
    {: screen}

2. Review the configuration of a storage class.

    ```sh
    kubectl describe storageclass STORAGECLASS
    ```
    {: pre}

    For more information about each storage class, see the [storage class reference](#block_storageclass_reference). If you don't find what you are looking for, consider creating your own customized storage class. To get started, check out the [customized storage class samples](#block_custom_storageclass).
    {: tip}

3. Choose the type of block storage that you want to provision.
    - **Bronze, silver, and gold storage classes:** These storage classes provision Endurance storage. With Endurance storage, you can choose the size of the storage in gigabytes at predefined IOPS tiers.
    - **Custom storage class:** This storage class provisions Performance storage. With performance storage, you have more control over the size of the storage and the IOPS.

4. Choose the size and IOPS for your block storage. The size and the number of IOPS define the total number of IOPS (input/ output operations per second) that serves as an indicator for how fast your storage is. The more total IOPS your storage has, the faster it processes read and write operations.
    - **Bronze, silver, and gold storage classes:** These storage classes come with a fixed number of IOPS per gigabyte and are provisioned on SSD hard disks. The total number of IOPS depends on the size of the storage that you choose. You can select any whole number of gigabyte within the allowed size range, such as 20 Gi, 256 Gi, or 11854 Gi. To determine the total number of IOPS, you must multiply the IOPS with the selected size. For example, if you select a 1000Gi block storage size in the silver storage class that comes with 4 IOPS per GB, your storage has a total of 4000 IOPS.  
       
        | Storage class | IOPS per gigabyte | Size range in gigabytes |
        | --- | --- | --- | 
        | Bronze | 2 IOPS/GB | 20-12000 Gi |
        | Silver | 4 IOPS/GB | 20-12000 Gi|
        | Gold | 10 IOPS/GB | 20-4000 Gi |
        {: caption="Table of storage class size ranges and IOPS per gigabyte"}

    - **Custom storage class:** When you choose this storage class, you have more control over the size and IOPS that you want. For the size, you can select any whole number of gigabytes within the allowed size range. The size that you choose determines the IOPS range that is available to you. You can choose an IOPS that is a multiple of 100 within the specified range. The IOPS that you choose is static and does not scale with the size of the storage. For example, if you choose 40Gi with 100 IOPS, your total IOPS remains 100. The IOPS to gigabyte ratio also determines the type of hard disk that is provisioned for you. For example, if you are using 500Gi at 100 IOPS, your IOPS to gigabyte ratio is 0.2. Storage with a ratio of less than or equal to 0.3 is provisioned on SATA hard disks. If your ratio is greater than 0.3, then your storage is provisioned on SSD hard disks.

        | Size range in gigabytes | IOPS range in multiples of 100 | 
        | --- | --- |
        | 20-39 Gi | 100-1000 IOPS | 
        | 40-79 Gi | 100-2000 IOPS |
        | 80-99 Gi | 100-4000 IOPS | 
        | 100-499 Gi  |100-6000 IOPS | 
        | 500-999 Gi | 100-10000 IOPS |
        | 1000-1999 Gi | 100-20000 IOPS |
        | 2000-2999 Gi | 200-40000 IOPS |
        | 3000-3999 Gi | 200-48000 IOPS |
        | 4000-7999 Gi | 300-48000 IOPS |
        | 8000-9999 Gi | 500-48000 IOPS |
        | 10000-12000 Gi | 1000-48000 IOPS |
        {: caption="Table class size ranges and IOPS}
            

5. Choose if you want to keep your data after the cluster or the persistent volume claim (PVC) is deleted.
    - If you want to keep your data, then choose a `retain` storage class. When you delete the PVC, only the PVC is deleted. The PV, the physical storage device in your IBM Cloud infrastructure account, and your data still exist. To reclaim the storage and use it in your cluster again, you must remove the PV and follow the steps for [using existing block storage](#existing_block).
    - If you want the PV, the data, and your physical block storage device to be deleted when you delete the PVC, choose a storage class without `retain`.

6. Choose if you want to be billed hourly or monthly. The default setting is hourly billing.



## Setting up encryption for {{site.data.keyword.blockstorageshort}}
{: #block_encryption_setup}

You can set up encryption for {{site.data.keyword.blockstorageshort}} by using {{site.data.keyword.keymanagementservicelong_notm}}.
{: shortdesc}

The following example explains how to create a service ID with the required access roles for {{site.data.keyword.keymanagementserviceshort}} and your cluster. The credentials of this service ID are used to enable encryption for your {{site.data.keyword.blockstorageshort}} volumes.

You can enable encryption by creating a Kubernetes secret that uses your personal API key as long as you have the **Reader** service access role for your {{site.data.keyword.keymanagementserviceshort}} instance as well as the **Viewer** platform access role and the **Writer** service access role for your cluster.
{: tip}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Make sure that you are assigned the Editor platform access role and the Writer service access role for {{site.data.keyword.keymanagementserviceshort}} so that you can create your own root key that you use to encrypt your {{site.data.keyword.blockstorageshort}} instance. You can review your IAM access roles in the [IAM console](https://cloud.ibm.com/iam){: external}. For more information about IAM roles, see [IAM access](/docs/account?topic=account-userroles).
2. If you don't have a {{site.data.keyword.keymanagementserviceshort}} instance, [provision one](/docs/key-protect?topic=key-protect-provision).
3. [Create a root key](/docs/key-protect?topic=key-protect-create-root-keys). By default, the root key is created without an expiration date.
4. Create an IAM service ID. Replace `<service_ID_name>` with the name that you want to assign to your service ID. This service ID is used to access your {{site.data.keyword.keymanagementserviceshort}} instance from your {{site.data.keyword.blockstorageshort}} volume.

    ```sh
    ibmcloud iam service-id-create <service_ID_name>
    ```
    {: pre}

    Example output

    ```sh
    OK
    Service ID test-id is created successfully

    ID            ServiceId-a1a11111-bb11-1111-a11b-1111111a11ba   
    Name          test-id   
    Description      
    CRN           crn:v1:bluemix:public:iam-identity::a/1a1111aa2b11111aaa1a1111aa2aa111::serviceid:ServiceId-a1a11111-bb11-1111-a11b-1111111a11bb   
    Version       1-bb11aa11a0aa1a11a011a1aaaa11a1bb   
    Locked        false
    ```
    {: screen}

5. Create an API key for your service ID. Replace `<api-key-name>` with a name for your API key and replace `<service_ID_name>` with the name of the service ID that you created. Be sure to save your API key as it can't be retrieved later. This API key is stored in a Kubernetes secret in your cluster in a later step.

    ```sh
    ibmcloud iam service-api-key-create <api_key_name> <service_ID_name>
    ```
    {: pre}

6. Retrieve a list of IAM-enabled services in your account and note the name of the {{site.data.keyword.keymanagementserviceshort}} instance that you created.

    ```sh
    ibmcloud resource service-instances
    ```
    {: pre}

7. Retrieve the GUID of your {{site.data.keyword.keymanagementserviceshort}} instance. The ID is used to create an IAM service policy for your service ID.

    ```sh
    ibmcloud resource service-instance "<instance_name>" | grep GUID
    ```
    {: pre}

8. [Create an IAM service policy](/docs/cli?topic=cli-ibmcloud_commands_iam#ibmcloud_iam_service_policy_create) to grant your service ID access to your {{site.data.keyword.keymanagementserviceshort}} instance. The following command grants your service ID `Reader` access to your {{site.data.keyword.keymanagementserviceshort}} instance. The Reader access role is the minimum service access role that your service ID must have to retrieve {{site.data.keyword.keymanagementserviceshort}} keys. For more information, see [Managing user access for {{site.data.keyword.keymanagementserviceshort}}](/docs/key-protect?topic=key-protect-manage-access).

    ```sh
    ibmcloud iam service-policy-create <service_ID_name> --roles Reader --service-name kms --service-instance <service_instance_GUID>
    ```
    {: pre}

9. Create another IAM service access policy to give your service ID access to your cluster. The following command grants the **Viewer** platform access role and the **Writer** service access role to your service ID for your cluster. You can retrieve your cluster ID by running `ibmcloud ks cluster get <cluster_name>`.

    ```sh
    ibmcloud iam service-policy-create <service_ID_name> --roles Writer,Viewer --service-name containers-kubernetes --service-instance <cluster_ID>
    ```
    {: pre}

10. If you already have the `ibmcloud-block-storage-plugin` Helm chart installed, you must remove the Helm chart and install a new version.

    If you installed the plug-in without using Helm, you must manually remove the block storage plug-in deployment and all associated resources before installing a new version.
    {: note}

    ```sh
    helm uninstall <name> <namespace>
    ```
    {: pre}

11. Install the `ibmcloud-block-storage-plugin` Helm chart.

    ```sh
    helm install <name> iks-charts/ibmcloud-block-storage-plugin
    ```
    {: pre}

12. Create an `ibm-block-secrets` namespace.

    ```sh
    kubectl create ns ibm-block-secrets
    ```
    {: pre}

13. Create a role binding in the `ibm-block-secrets` namespace for the block storage plug-in.

    ```sh
    kubectl create rolebinding ibmcloud-block-storage-plugin-byok --clusterrole=ibmcloud-block-storage-plugin-byok --serviceaccount=kube-system:ibmcloud-block-storage-plugin --group system:nodes --namespace=ibm-block-secrets
    ```
    {: pre}

14. Create a Kubernetes secret named `secret.yaml` and that includes the credentials to access your root key in your {{site.data.keyword.keymanagementserviceshort}} service instance.
    1. Create a configuration file for the secret.
        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
          labels:
            kmsConfig: kpc-secretLabel
          name: <secret_name> # Enter a name for your secret. Example: my_secret
          namespace: <namespace> # Enter the name of the namespace where you want to create the secret. The secret must be in same namespace where your app is deployed. Example: default
        stringData:
        config: |-
            {
                "api_key":"<service_id_api_key>", # Enter the API key for the service ID that you created. Example: "AA1aAAaA1a21AAaA1aAAaAa-AA-1AAaaA1aA1aAaaaAA"
                "iam_endpoint":"https://iam.cloud.ibm.com",
                "key_protect_endpoint":"https://<region>.kms.cloud.ibm.com", # Example: "https://us-east.kms.cloud.ibm.com"
                "root_key_crn":"<rook_key_crn>", # Example: "crn:v1:bluemix:public:kms:<region>:a/1ab011ab2b11111aaa1a1111aa1aa111:11aa111a-1111-11a1-a111-a11a111aa111:key:11a11111-1a1a-111a-111a-11111a1a1aa1",
                "version":""
            }
        type: ibm.io/kms-config
        ```
        {: codeblock}

        `stringData.config.key_protect_endpoint`
        :   Enter the regional endpoint of your {{site.data.keyword.keymanagementserviceshort}} instance. For a list of Key Protect endpoints, see [Regions and endpoints](/docs/key-protect?topic=key-protect-regions).
        
        `stringData.config.root_key_crn`
        :   Enter the CRN of the root key that you created. To retrieve your root key CRN, complete the following steps.
            1. Navigate to the resource list in the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/resources){: external}.
            2. Click **Services**, then click your {{site.data.keyword.keymanagementserviceshort}} instance.
            3. Find your root key on the **Actions Menu**, then click **View CRN**.
            4. Click the **Copy** button to copy the CRN.

    1. Create the secret in your cluster.

        ```sh
        kubectl apply -f secret.yaml
        ```
        {: pre}

    1. Verify that your secret was created.

        ```sh
        kubectl get secrets
        ```
        {: pre}

15. Choose between the following options to create a {{site.data.keyword.blockstorageshort}} instance that encrypts data with your root key.

    * [Create your own storage class that references your {{site.data.keyword.keymanagementserviceshort}} secret](#encrypt_custom_sc).
    * [Define the secret in a PVC and use one of the provided storage classes](#pvc_encrypt_label).


### Encrypting volume data by using your own storage class
{: #encrypt_custom_sc}

You can deploy apps that use encrypted volumes by first creating your own storage class.
{: shortdesc}

The following steps explain how to create a custom, encrypted storage class that you can use to create multiple encrypted block storage instances with the same configuration. If you want to create an encrypted PVC by using one of the IBM-provided storage classes, you can do this by [referencing the {{site.data.keyword.keymanagementserviceshort}} credentials directly in your PVC](#pvc_encrypt_label).

1. [Decide on a storage configuration](/docs/containers?topic=containers-block_storage#block_predefined_storageclass).

1. Create your own storage class that provisions an encrypted block storage instance by using one of the {{site.data.keyword.IBM_notm}}-provided storage classes as the basis. You can retrieve the details a storage class by running `kubectl get sc <storageclass_name> -o yaml`. The following example is based on the `ibmc-block-retain-bronze` storage class.
    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: <name> # Enter the name of the storage class. Example: my_custom_storageclass
    parameters:
      billingType: hourly
      classVersion: "2"
      fsType: ext4
      iopsPerGB: "2"
      sizeRange: '[20-12000]Gi'
      type: Endurance
      encrypted: "true" # Enter "true" to enable encryption.
      encryptionKeySecret: <secret_name> # # #nter the name of the secret that you created earlier.Example: my_secret 
      encryptionKeyNamespace: <namespace> # # #nter the namespace where you created your secret. Example: default
    provisioner: ibm.io/ibmc-block
    reclaimPolicy: Delete
    volumeBindingMode: Immediate
    ```
    {: codeblock}

1. Create the storage class in your cluster.

    ```sh
    kubectl apply -f storageclass.yaml
    ```
    {: pre}

1. [Add {{site.data.keyword.blockstorageshort}} to your app by using your own storage class to create a PVC](#add_block).

1. [Verify the encryption of your {{site.data.keyword.blockstorageshort}} volumes](#block_encrypt).

### Create a PVC that references your {{site.data.keyword.blockstorageshort}} secret
{: #pvc_encrypt_label}

You can provision encrypted {{site.data.keyword.blockstorageshort}} by creating a PVC that specifies the Kubernetes secret that holds your {{site.data.keyword.keymanagementserviceshort}} credentials.
{: shortdesc}

The following steps show how you can reference your {{site.data.keyword.keymanagementserviceshort}} credentials in your PVC to create an encrypted {{site.data.keyword.blockstorageshort}} instance. To create multiple encrypted volumes without specifying the {{site.data.keyword.keymanagementserviceshort}} credentials in each PVC, you can [create a custom, encrypted storage class](#encrypt_custom_sc).

1. Review the provided [{{site.data.keyword.blockstorageshort}} storage classes](#block_storageclass_reference) to determine which storage class best meets your app requirements. If the provided storage classes don't meet your app requirements, you can create your own [customized storage class](#block_custom_storageclass).

2. Create a PVC configuration file that is named `pvc.yaml` and that references the Kubernetes secret where you stored the {{site.data.keyword.keymanagementserviceshort}} service credentials. To create this secret, see [Setting up encryption for {{site.data.keyword.blockstorageshort}}](#block_encryption_setup).

    ```yaml
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: <pvc_name> # Enter a name for your PVC.
      annotations:
      volume.beta.kubernetes.io/storage-class: "<storage_class>" # Enter a storage class. To see a list of storageclasses run `kubectl get storageclasses`.
      labels:
        encrypted: "true"
        encryptionKeyNamespace: <namespace> # Enter the namespace where your secret was created.
        encryptionKeySecret: <secret_name> # Enter the name of the secret you created.
    spec:
      accessModes:
        - ReadWriteOnce
        resources:
        requests:
            storage: 20Gi
    ```
    {: codeblock}

3. Create the PVC in your cluster.

    ```sh
    kubectl apply -f pvc.yaml
    ```
    {: pre}

4. Check the status of your PVC.

    ```sh
    kubectl get pvc
    ```
    {: pre}

5. Wait for your PVC to bind, then [create a deployment that uses your PVC](#add_block).

6. [Verify the encryption of your {{site.data.keyword.blockstorageshort}} volumes](#block_encrypt).


### Verifying the encryption of your {{site.data.keyword.blockstorageshort}} volumes
{: #block_encrypt}

You can verify the encryption of your volumes by checking the volume mount path.
{: shortdesc}

1. Log in to your app pod. Replace `<pod_name>` with the name of the pod that mounts your encrypted {{site.data.keyword.blockstorageshort}} volume.

    ```sh
    kubectl exec <pod_name> -it bash
    ```
    {: pre}

2. List the file system of your pod.

    ```sh
    df -h
    ```
    {: pre}

3. Review the file system path for your encrypted {{site.data.keyword.blockstorageshort}} volume.

    * Encrypted volumes have a path structure of `/dev/mapper/<pvc-ID_encrypted>`. In this example, the encrypted volume is mounted to the `/test` file path in the pod.

        ```sh
        Filesystem                                            Size  Used Avail Use% Mounted on
        overlay                                                98G  8.2G   85G   9% /
        tmpfs                                                  64M     0   64M   0% /dev
        tmpfs                                                 2.0G     0  2.0G   0% /sys/fs/cgroup
        /dev/mapper/pvc-a011a111-1111-1111-111a-aaa1a1111a11_encrypted   20G   45M   20G   1% /test
        ```
        {: screen}

    * Unencrypted volumes have a path structure of `dev/mapper/<random_string>`.

        ```sh
        Filesystem                                     Size  Used Avail Use% Mounted on
        overlay                                         98G   16G   78G  17% /
        tmpfs                                           64M     0   64M   0% /dev
        tmpfs                                          7.9G     0  7.9G   0% /sys/fs/cgroup
        /dev/mapper/3600a09803830476e733f4e477370716e   24G   45M   24G   1% /test
        ```
        {: screen}

Removing your Kubernetes secret doesn't revoke access to the volume data. If you created a pod-only deployment, you must delete the pod. If you created a deployment, you must delete the deployment.
{: note}


## Adding block storage to apps
{: #add_block}

Create a persistent volume claim (PVC) to dynamically provision block storage for your cluster. Dynamic provisioning automatically creates the matching persistent volume (PV) and orders the actual storage device in your IBM Cloud infrastructure account.
{: shortdesc}

Block storage comes with a `ReadWriteOnce` access mode. You can mount it to only one pod on one worker node in the cluster at a time.
{: note}

Before you begin:
- If you have a firewall, [allow egress access](/docs/containers?topic=containers-firewall#vyatta_firewall) for the IBM Cloud infrastructure IP ranges of the zones that your clusters are in so that you can create PVCs.
- Install the [{{site.data.keyword.cloud_notm}} block storage plug-in](#install_block).
- [Decide on a pre-defined storage class](#block_predefined_storageclass) or create a [customized storage class](#block_custom_storageclass).

Looking to deploy block storage in a stateful set? For more information, see [Using block storage in a stateful set](#block_statefulset).
{: tip}

To add block storage:

1. Create a configuration file to define your persistent volume claim (PVC) and save the configuration as a `.yaml` file.

    -  **Example for bronze, silver, gold storage classes**:
        The following `.yaml` file creates a claim that is named `block-storage-pvc` of the `"ibmc-block-silver"` storage class, billed hourly, with a gigabyte size of `24Gi`.

        ```yaml
        apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
          name: block-storage-pvc
          labels:
            billingType: "hourly"
            region: us-south
            zone: dal13
        spec:
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 24Gi
          storageClassName: ibmc-block-silver
        ```
        {: codeblock}

    -  **Example for using your own storage class**:
        The following `.yaml` file creates a claim that is named `block-storage-pvc` of the storage class `ibmc-block-retain-custom`, billed hourly, with a gigabyte size of `45Gi` and IOPS of `"300"`.

        ```yaml
        apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
          name: block-storage-pvc
          labels:
            billingType: "hourly"
            region: us-south
            zone: dal13
        spec:
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 45Gi
              iops: "300"
          storageClassName: ibmc-block-retain-custom
        ```
        {: codeblock}


        `name`
        :   Enter the name of the PVC.

        `billingType`
        :   In the metadata labels section, specify the frequency for which your storage bill is calculated, "monthly" or "hourly". The default is "hourly".

        `region`
        :   In the metadata labels section, specify the region where you want to provision your block storage. If you specify the region, you must also specify a zone. If you don't specify a region, or the specified region is not found, the storage is created in the same region as your cluster. This option is supported only with the IBM Cloud Block Storage plug-in version 1.0.1 or higher. For older plug-in versions, if you have a multizone cluster, the zone in which your storage is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones. To specify the zone for your storage, you can create a [customized storage class](#block_multizone_yaml) first. Then, create a PVC with your customized storage class.

        `zone`
        :   In the metadata labels section, specify the zone where you want to provision your block storage. If you specify the zone, you must also specify a region. If you don't specify a zone or the specified zone is not found in a multizone cluster, the zone is selected on a round-robin basis. This option is supported only with the IBM Cloud Block Storage plug-in version 1.0.1 or higher. For older plug-in versions, if you have a multizone cluster, the zone in which your storage is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones. To specify the zone for your storage, you can create a [customized storage class](#block_multizone_yaml) first. Then, create a PVC with your customized storage class.

        `storage`
        :   In the spec resources requests section, enter the size of the block storage, in gigabytes (Gi). After your storage is provisioned, you can't change the size of your block storage. Make sure to specify a size that matches the amount of data that you want to store. 

        `iops`
        :   This option is available for your own custom storage classes only (`ibmc-block-custom / ibmc-block-retain-custom`). In the spec resources requests section, specify the total IOPS for the storage, selecting a multiple of 100 within the allowable range. If you choose an IOPS other than one that is listed, the IOPS is rounded up.

        `storageClassName`
        :   In the spec section, enter the name of the storage class that you want to use to provision block storage. You can choose to use one of the [IBM-provided storage classes](#block_storageclass_reference) or [create your own storage class](#block_custom_storageclass). If you don't specify a storage class, the PV is created with the default storage class `ibmc-file-bronze`.

    If you want to use a customized storage class, create your PVC with the corresponding storage class name, a valid IOPS, and size. 
    {: tip}

2. Create the PVC.

    ```sh
    kubectl apply -f block-storage.yaml
    ```
    {: pre}

3. Verify that your PVC is created and bound to the PV. This process can take a few minutes.

    ```sh
    kubectl get pvc
    ```
    {: pre}

    Example output
    ```sh
    NAME                STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
    block-storage-pvc              Bound    pvc-1aa1aaaa-11a1-48d1-ab11-11b11111f3bc   45Gi       RWO            ibmc-block-silver   150m
    ```
    {: screen}

4. To mount the PV to your deployment, create a configuration `.yaml` file and specify the PVC that binds the PV. {: #block_app_volume_mount}

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

    
    `app`
    :   In the metadata, enter a label for the deployment.
    
    `matchLabels.app` and `labels.app`
    :   In the spec selector and in the template metadata, enter a label for your app.
    
    `image`
    :   The name of the container image that you want to use. To list available images in your {{site.data.keyword.registrylong_notm}} account, run `ibmcloud cr image-list`.
    
    `name`
    :   The name of the container that you want to deploy to your cluster.
    
    `mountPath`
    :   In the container volume mounts section, enter the absolute path of the directory to where the volume is mounted inside the container. Data written to the mount path is stored under the root directory in your physical block storage instance. If you want to share a volume between different apps, you can specify [volume sub paths](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath){: external} for each of your apps. 
    
    `name`
    :   In the container volume mounts section, enter the name of the volume to mount to your pod.
    
    `name`
    :   In the volumes section, enter the name of the volume to mount to your pod. Typically this name is the same as `volumeMounts/name`.
    
    `claimName`
    :   In the volumes persistent volume claim section, enter the name of the PVC that binds the PV that you want to use. 


5. Create the deployment.

    ```sh
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

6. Verify that the PV is successfully mounted.

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
        ClaimName:    block-storage-pvc
        ReadOnly:    false
    ```
    {: screen}





## Using existing block storage in your cluster
{: #existing_block}

If you have an existing physical storage device that you want to use in your cluster, you can manually create the PV and PVC to statically provision the storage.
{: shortdesc}

Before you can start to mount your existing storage to an app, you must retrieve all necessary information for your PV.  

### Retrieving the information of your existing block storage
{: #existing-block-1}

1. Retrieve or generate an API key for your IBM Cloud infrastructure account.
    1. Log in to the [IBM Cloud infrastructure portal](https://cloud.ibm.com/classic){: external}.
    2. Select **Account**, then **Users**, and then **User List**.
    3. Find your user ID.
    4. In the **API KEY** column, click **Generate** to generate an API key or **View** to view your existing API key.
2. Retrieve the API username for your IBM Cloud infrastructure account.
    1. From the **User List** menu, select your user ID.
    2. In the **API Access Information** section, find your **API Username**.
3. Log in to the IBM Cloud infrastructure CLI plug-in.

    ```sh
    ibmcloud sl init
    ```
    {: pre}

4. Choose to authenticate by using the username and API key for your IBM Cloud infrastructure account.
5. Enter the username and API key that you retrieved in the previous steps.
6. List available block storage devices.

    ```sh
    ibmcloud sl block volume-list
    ```
    {: pre}

    Example output

    ```sh
    id          username              datacenter   storage_type                capacity_gb   bytes_used   lunId   
    11111111    IBM01AAA1111111-1     wdc07        endurance_block_storage     45            -            2      
    ```
    {: screen}

7. Retrieve the volume details. Replace `<volume_ID>` with the ID of the Block storage volume that you retrieved in step 6.

    ```sh
    ibmcloud sl block volume-detail <volume_ID>
    ```
    {: pre}

    Example output

    ```sh
    ID                         11111111 
    User name                  IBM01AAA1111111-1   
    Type                       endurance_block_storage   
    Capacity (GB)              45   
    LUN Id                     2   
    IOPs                       100   
    Datacenter                 wdc07   
    Target IP                  10.XXX.XX.XXX  
    # of Active Transactions   0   
    Replicant Count            0 
    ```
    {: screen}

8. Make a note of the `ID`, `Capacity`, `LUN Id`, the `Datacenter`, and `Target IP` of the volume that you want to mount to your cluster. **Note:** To mount existing storage to a cluster, you must have a worker node in the same zone as your storage. To verify the zone of your worker node, run `ibmcloud ks worker ls --cluster <cluster_name_or_ID>`.

### Creating a persistent volume (PV) and a matching persistent volume claim (PVC)
{: #existing-block-2}

1. **Optional**: If you have storage that you provisioned with a `retain` storage class, when you remove the PVC, the PV and the physical storage device are not removed. To reuse the storage in your cluster, you must remove the PV first. List existing PVs and look for the PV that belongs to your persistent storage. The PV is in a `released` state.

    ```sh
    kubectl get pv
    ```
    {: pre}

2. Remove the PV.

    ```sh
    kubectl delete pv <pv_name>
    ```
    {: pre}

3. Verify the PV is removed.

    ```sh
    kubectl get pv
    ```
    {: pre}

4. Create a configuration file for your PV. Include the parameters you retrieved earlier.

    ```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: "block-storage-pv" # Enter a name for your PV. For example, my-static-pv.
      labels:
         failure-domain.beta.kubernetes.io/region: "<region>" # Example us-east.
         failure-domain.beta.kubernetes.io/zone: "<zone>" # Example: wdc04. See /docs/containers?topic=containers-regions-and-zones#zones-sz
    spec:
      capacity:
        storage: "<storage>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>" # Enter ext or xfs
        options:
          "Lun": "<Lun_ID>"
          "TargetPortal": "<TargetPortal>"
          "VolumeID": "<VolumeID>"
          "volumeName": "block-storage-pv" # Enter the same value as your PV name from metadata.name
    ```
    {: codeblock}

    `name`
    :   Give your PV a name. For example, `block-storage-pv`. Note that you must also enter this value in `spec.FlexVolume.options` as the `volumeName`.
    
    `labels`
    :   Enter the region and the zone that you retrieved earlier. You must have at least one worker node in the same region and zone as your persistent storage to mount the storage in your cluster. To retrieve your volume details, run `ibmcloud sl block volume-list` to get the volume ID, then run `ibmcloud sl block volume-detail <volume_ID>` to get the details of your volume.
    
    `region`
    :   Enter the region where your block storage is located. Note that your cluster and block storage must be in the same region. To find your cluster location, run `ibmcloud ks cluster ls`. For more information about the available regions and zones, see [regions and zones](/docs/containers?topic=containers-regions-and-zones#zones-sz). For example, `us-east`.
    
    `zone`
    :   Enter the zone where your storage volume is located. To retrieve your volume details, run `ibmcloud sl block volume-list` to get the volume ID, then run `ibmcloud sl block volume-detail <volume_ID>` to get the details of your volume. Note that to attach block storage to your cluster, you must have a worker node available in the same zone as the volume that you want to attach. To find the zones of your worker nodes, run `ibmcloud ks worker ls -c <cluster>`. For example, `wdc04`.
    
    `storage`
    :   Enter the storage size of the existing block storage volume that you want to attach to your cluster. The storage size must be written in gigabytes, for example, 20Gi (20 GB) or 1000Gi (1 TB). To retrieve your volume details, run `ibmcloud sl block volume-list` to get the volume ID, and then run `ibmcloud sl block volume-detail <volume_ID>` to get the details of your volume.
    
    `fsType`
    :   Enter the file system type that is configured for your existing block storage. Choose between `ext4` or `xfs`. If you don't specify this option, the PV defaults to `ext4`. When the wrong `fsType` is defined, then the PV creation succeeds, but the mounting of the PV to a pod fails. To retrieve your volume details, run `ibmcloud sl block volume-list` to get the volume ID, then run `ibmcloud sl block volume-detail <volume_ID>` to get the details of your volume.
    
    `Lun`
    :   Enter the LUN ID of your block storage volume. To retrieve your volume details, run `ibmcloud sl block volume-list` to get the volume ID, then run `ibmcloud sl block volume-detail <volume_ID>` to get the details of your volume.
    
    `TargetPortal`
    :   Enter the IP address of your block storage. To retrieve the `TargetPortal` parameter, run `ibmcloud sl block volume-list` to get the volume ID, then run `ibmcloud sl block volume-detail <volume_ID>` and make a note of the `Target IP` in the output.
    
    `VolumeId`
    :   Enter the ID of your block storage. To retrieve your volume details, run `ibmcloud sl block volume-list`.
    
    `volumeName`
    :   Enter the same value as your PV name. For example, `block-storage-pv`.

5. Create the PV in your cluster.

    ```sh
    kubectl apply -f pv.yaml
    ```
    {: pre}

6. Verify that the PV is created.

    ```sh
    kubectl get pv
    ```
    {: pre}

7. Create another configuration file to create your PVC. In order for the PVC to match the PV that you created earlier, you must choose the same value for `storage` and `accessMode`. The `storage-class` field must be an empty string. If any of these fields don't match the PV, then a new PV is created automatically instead.

    ```yaml
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: block-storage-pvc
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: "20Gi"
      storageClassName: ""
    ```
    {: codeblock}

8. Create your PVC.

    ```sh
    kubectl apply -f static-pvc.yaml
    ```
    {: pre}

9. Verify that your PVC is created and bound to the PV that you created earlier. This process can take a few minutes.

    ```sh
    kubectl describe pvc static-pvc
    ```
    {: pre}

    Example output

    ```sh
    Name:          static-pvc
    Namespace:     default
    StorageClass:  
    Status:        Bound
    ```
    {: screen} 

10. **Optional** Save the following example pod configuration as a file called `pod.yaml`.
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: block-storage
      labels:
        app: block-storage
    spec:
      containers:
        - name: block-storage
          image: nginx
          command: ["/bin/sh"]
          args: ["-c", "while true; do date \"+%Y-%m-%d %H:%M:%S\"; sleep 3600; done"]
          workingDir: /home
          imagePullPolicy: Always
          ports:
            - containerPort: 80
          volumeMounts:
            - name: block-storage-pv
              mountPath: /home
      volumes:
        - name: block-storage-pv
          persistentVolumeClaim:
            claimName: block-storage-pvc
    ```
    {: pre}
    
11. Create the pod in your cluster.
    ```sh
    kubectl create -f pod.yaml
    ```
    {: pre}
    
12. After the pod is in `Running` status, get the logs.
    ```sh
    kubectl logs
    ```
    {: pre}
    
    Example output
    ```sh
    2022-01-21 16:11:00
    ```
    {: pre}
    
You successfully created a PV and bound it to a PVC. Then, you deployed and app that uses block storage. Cluster users can now [mount the PVC](#block_app_volume_mount) to their deployments and start reading from and writing to the persistent volume.
    

## Using block storage in a stateful set
{: #block_statefulset}

If you have a stateful app such as a database, you can create stateful sets that use block storage to store your app's data. Alternatively, you can use an {{site.data.keyword.cloud_notm}} database-as-a-service and store your data in the cloud.
{: shortdesc}

What do I need to be aware of when adding block storage to a stateful set?
:   To add storage to a stateful set, you specify your storage configuration in the `volumeClaimTemplates` section of your stateful set YAML. The `volumeClaimTemplates` is the basis for your PVC and can include the storage class and the size or IOPS of your block storage that you want to provision. However, if you want to include labels in your `volumeClaimTemplates`, Kubernetes does not include these labels when creating the PVC. Instead, you must add the labels directly to your stateful set.

You can't deploy two stateful sets at the same time. If you try to create a stateful set before a different one is fully deployed, then the deployment of your stateful set might lead to unexpected results.
{: important}


How can I create my stateful set in a specific zone?
:   In a multizone cluster, you can specify the zone and region where you want to create your stateful set in the `spec.selector.matchLabels` and `spec.template.metadata.labels` section of your stateful set YAML. Alternatively, you can add those labels to a [customized storage class](#block_custom_storageclass) and use this storage class in the `volumeClaimTemplates` section of your stateful set.

Can I delay binding of a PV to my stateful pod until the pod is ready?
:   Yes, you can [create your own storage class](#topology_yaml) for your PVC that includes the [`volumeBindingMode: WaitForFirstConsumer`](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode){: external} field.

What options do I have to add block storage to a stateful set?
:   If you want to automatically create your PVC when you create the stateful set, use [dynamic provisioning](#block_dynamic_statefulset). You can also choose to [pre-provision your PVCs or use existing PVCs](#block_static_statefulset) with your stateful set.  

### Creating the PVC by using dynamic provisioning when you create a stateful set
{: #block_dynamic_statefulset}

Use this option if you want to automatically create the PVC when you create the stateful set.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

Complete the following steps to verify that all existing stateful sets in your cluster are fully deployed. If a stateful set is still being deployed, you can't start creating your stateful set. You must wait until all stateful sets in your cluster are fully deployed to avoid unexpected results.

1. List existing stateful sets in your cluster.

    ```sh
    kubectl get statefulset --all-namespaces
    ```
    {: pre}

    Example output

    ```sh
    NAME              DESIRED   CURRENT   AGE
    mystatefulset     3         3         6s
    ```
    {: screen}

1. View the **Pods Status** of each stateful set to ensure that the deployment of the stateful set is finished. 

    ```sh
    kubectl describe statefulset <statefulset_name>
    ```
    {: pre}

    Example output

    ```sh
    Name:               nginx
    Namespace:          default
    CreationTimestamp:  Fri, 05 Oct 2022 13:22:41 -0400
    Selector:           app=nginx,billingType=hourly,region=us-south,zone=dal10
    Labels:             app=nginx
    billingType=hourly
    region=us-south
    zone=dal10
    Annotations: kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"apps/v1","kind":"StatefulSet","metadata":{"annotations":{},"name":"nginx","namespace":"default"},"spec":{"podManagementPolicy":"Par..."
    Replicas:           3 desired | 3 total
    Pods Status:        0 Running / 3 Waiting / 0 Succeeded / 0 Failed
    Pod Template:
    Labels:  app=nginx
    billingType=hourly
    region=us-south
    zone=dal10
    ...
    ```
    {: screen}

    A stateful set is fully deployed when the number of replicas that you find in the **Replicas** section of your CLI output equals the number of **Running** pods in the **Pods Status** section. If a stateful set is not fully deployed yet, wait until the deployment is finished before you proceed.

1. Create a configuration file for your stateful set and the service that you use to expose the stateful set.
    The following example shows how to deploy NGINX as a stateful set with three replicas. For each replica, a 20 gigabyte block storage device is provisioned based on the specifications that are defined in the `ibmc-block-retain-bronze` storage class. All storage devices are provisioned in the `dal10` zone. Because block storage can't be accessed from other zones, all replicas of the stateful set are also deployed onto worker nodes that are located in `dal10`.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
     name: nginx
     labels:
    app: nginx
    spec:
    ports:
    - port: 80
        name: web
    clusterIP: None
    selector:
        app: nginx
    ---
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: nginx
    spec:
      serviceName: "nginx"
      replicas: 3
      podManagementPolicy: Parallel
      selector:
        matchLabels:
        app: nginx
        billingType: "hourly"
        region: "us-south" # Enter the region where your cluster is located.
        zone: "dal10"
    template:
      metadata:
      labels:
          app: nginx
          billingType: "hourly"
          region: "us-south"
          zone: "dal10"
      spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: myvol
        mountPath: /usr/share/nginx/html
    volumeClaimTemplates:
    - metadata:
        name: myvol
        spec:
        accessModes:
        - ReadWriteOnce
        resources:
            requests:
            storage: 20Gi
            iops: "300" #required only for performance storage
        storageClassName: ibmc-block-retain-bronze
    ```
    {: codeblock}

    The following example shows how to deploy NGINX as a stateful set with three replicas. The stateful set does not specify the region and zone where the block storage is created. Instead, the stateful set uses an anti-affinity rule to ensure that the pods are spread across worker nodes and zones. By defining `topologykey: failure-domain.beta.kubernetes.io/zone`, the Kubernetes scheduler can't schedule a pod on a worker node if the worker node is in the same zone as a pod that has the `app: nginx` label. For each stateful set pod, two PVCs are created as defined in the `volumeClaimTemplates` section, but the creation of the block storage instances is delayed until a stateful set pod that uses the storage is scheduled. This setup is referred to as [topology-aware volume scheduling](https://kubernetes.io/blog/2018/10/11/topology-aware-volume-provisioning-in-kubernetes/){: external}.

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: ibmc-block-bronze-delayed
    parameters:
      billingType: hourly
      classVersion: "2"
      fsType: ext4
      iopsPerGB: "2"
      sizeRange: '[20-12000]Gi'
      type: Endurance
    provisioner: ibm.io/ibmc-block
    reclaimPolicy: Delete
    volumeBindingMode: WaitForFirstConsumer
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      ports:
      - port: 80
        name: web
      clusterIP: None
      selector:
        app: nginx
    ---
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: web
    spec:
      serviceName: "nginx"
      replicas: 3
      podManagementPolicy: "Parallel"
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
              - weight: 100
                podAffinityTerm:
                  labelSelector:
                    matchExpressions:
                    - key: app
                      operator: In
                      values:
                      - nginx
                  topologyKey: failure-domain.beta.kubernetes.io/zone
          containers:
          - name: nginx
            image: k8s.gcr.io/nginx-slim:0.8
            ports:
            - containerPort: 80
              name: web
            volumeMounts:
            - name: myvol1
              mountPath: /usr/share/nginx/html
            - name: myvol2
              mountPath: /tmp1
      volumeClaimTemplates:
      - metadata:
          name: myvol1
        spec:
          accessModes:
          - ReadWriteOnce # access mode
          resources:
            requests:
              storage: 20Gi
          storageClassName: ibmc-block-bronze-delayed
      - metadata:
          name: myvol2
        spec:
          accessModes:
          - ReadWriteOnce # access mode
          resources:
            requests:
              storage: 20Gi
          storageClassName: ibmc-block-bronze-delayed
    ```
    {: codeblock}

    `name`
    :   Enter a name for your stateful set. The name that you enter is used to create the name for your PVC in the format: `<volume_name>-<statefulset_name>-<replica_number>`. 
    
    `serviceName`
    :   Enter the name of the service that you want to use to expose your stateful set.
    
    `replicas`
    :   Enter the number of replicas for your stateful set.
    
    `podManagementPolicy`
    :   Enter the pod management policy that you want to use for your stateful set.
        - **OrderedReady**: With this option, stateful set replicas are deployed one after another. For example, if you specified three replicas, then Kubernetes creates the PVC for your first replica, waits until the PVC is bound, deploys the stateful set replica, and mounts the PVC to the replica. After the deployment is finished, the second replica is deployed. For more information about this option, see [`OrderedReady` Pod Management](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#orderedready-pod-management){: external}
        - **Parallel**: With this option, the deployment of all stateful set replicas is started at the same time. If your app supports parallel deployment of replicas, then use this option to save deployment time for your PVCs and stateful set replicas. 
    
    `matchLabels`
    :   In the spec selector section, enter all labels that you want to include in your stateful set and your PVC. Labels that you include in the `volumeClaimTemplates` of your stateful set are not recognized by Kubernetes. Sample labels that you might want to include are: 
        - **region** and **zone**: If you want all your stateful set replicas and PVCs to be created in one specific zone, add both labels. You can also specify the zone and region in the storage class that you use. If you don't specify a zone and region and you have a multizone cluster, the zone in which your storage is provisioned is selected on a round-robin basis to balance volume requests evenly across all zones.
        - **`billingType`**: Enter the billing type that you want to use for your PVCs. Choose between `hourly` or `monthly`. If you don't specify this label, all PVCs are created with an hourly billing type.
    
    `labels`
    :   In the spec template metadata section, enter the same labels that you added to the `spec.selector.matchLabels` section. 
    
    `affinity`
    :   In the spec template spec section, specify your anti-affinity rule to ensure that your stateful set pods are distributed across worker nodes and zones. The example shows an anti-affinity rule where the stateful set pod prefers not to be scheduled on a worker node where a pod runs that has the `app: nginx` label. The `topologykey: failure-domain.beta.kubernetes.io/zone` restricts this anti-affinity rule even more and prevents the pod to be scheduled on a worker node if the worker node is in the same zone as a pod that has the `app: nginx` label. By using this anti-affinity rule, you can achieve anti-affinity across worker nodes and zones. 
    
    `name`
    :   In the spec volume claim templates metadata section, enter a name for your volume. Use the same name that you defined in the `spec.containers.volumeMount.name` section. The name that you enter here is used to create the name for your PVC in the format: `<volume_name>-<statefulset_name>-<replica_number>`. 
    
    `storage`
    :   In the spec volume claim templates spec resources requests section, enter the size of the block storage in gigabytes (Gi).
    
    `iops`
    :   In the spec volume claim templates spec resources requests section, if you want to provision [performance storage](#block_predefined_storageclass), enter the number of IOPS. If you use an endurance storage class and specify a number of IOPS, the number of IOPS is ignored. Instead, the IOPS that is specified in your storage class is used.
    
    `storageClassName`
    :   In the spec volume claim templates spec section, enter the storage class that you want to use. To list existing storage classes, run `kubectl get sc | grep block`. If you don't specify a storage class, the PVC is created with the default storage class that is set in your cluster. Make sure that the default storage class uses the `ibm.io/ibmc-block` provisioner so that your stateful set is provisioned with block storage.

1. Create your stateful set.

    ```sh
    kubectl apply -f statefulset.yaml
    ```
    {: pre}

1. Wait for your stateful set to be deployed.

    ```sh
    kubectl describe statefulset <statefulset_name>
    ```
    {: pre}

    To see the current status of your PVCs, run `kubectl get pvc`. The name of your PVC is formatted as `<volume_name>-<statefulset_name>-<replica_number>`.
    {: tip}

### Static provisioning by using existing PVCs with a stateful set
{: #block_static_statefulset}

You can pre-provision your PVCs before creating your stateful set or use existing PVCs with your stateful set.
{: shortdesc}

When you [dynamically provision your PVCs when creating the stateful set](#block_dynamic_statefulset), the name of the PVC is assigned based on the values that you used in the stateful set YAML file. In order for the stateful set to use existing PVCs, the name of your PVCs must match the name that would automatically be created when using dynamic provisioning.

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. If you want to pre-provision the PVC for your stateful set before you create the stateful set, follow steps 1-3 in [Adding block storage to apps](#add_block) to create a PVC for each stateful set replica. Make sure that you create your PVC with a name that follows the following format: `<volume_name>-<statefulset_name>-<replica_number>`.

    `volume_name`
    :   Use the name that you want to specify in the `spec.volumeClaimTemplates.metadata.name` section of your stateful set, such as `nginxvol`.
    
    `statefulset_name`
    :   Use the name that you want to specify in the `metadata.name` section of your stateful set, such as `nginx_statefulset`.
    
    `replica_number`
    :    Enter the number of your replica, starting with 0.

    For example, if you must create three stateful set replicas, create three PVCs with the following names: `nginxvol-nginx_statefulset-0`, `nginxvol-nginx_statefulset-1`, and `nginxvol-nginx_statefulset-2`.  

    Looking to create a PVC and PV for an existing storage device? Create your PVC and PV by using [static provisioning](#existing_block).

1. Follow the steps in [Dynamic provisioning: Creating the PVC when you create a stateful set](#block_dynamic_statefulset) to create your stateful set. The name of your PVC follows the format `<volume_name>-<statefulset_name>-<replica_number>`. Make sure to use the following values from your PVC name in the stateful set specification:
    `spec.volumeClaimTemplates.metadata.name`
    :   Enter the `<volume_name>` of your PVC name.
    
    `metadata.name`
    :   Enter the `<statefulset_name>` of your PVC name.
    
    `spec.replicas`
    :   Enter the number of replicas that you want to create for your stateful set. The number of replicas must equal the number of PVCs that you created earlier.

    If your PVCs are in different zones, don't include a region or zone label in your stateful set.
    {: note}

1. Verify that the PVCs are used in your stateful set replica pods by listing the pods in your cluster. Identify the pods that belong to your stateful set.

    ```sh
    kubectl get pods
    ```
    {: pre}

1. Verify that your existing PVC is mounted to your stateful set replica. Review the **`ClaimName`** in the **`Volumes`** section of your CLI output.

    ```sh
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Example output

    ```sh
    Name:           nginx-0
    Namespace:      default
    Node:           10.xxx.xx.xxx/10.xxx.xx.xxx
    Start Time:     Fri, 05 Oct 2022 13:24:59 -0400
    ...
    Volumes:
    myvol:
      Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
      ClaimName:  myvol-nginx-0
    ...
    ```
    {: screen}



## Changing the size and IOPS of your existing storage device
{: #block_change_storage_configuration}

If you want to increase storage capacity or performance, you can modify your existing volume.
{: shortdesc}

For questions about billing and to find the steps for how to use the {{site.data.keyword.cloud_notm}} console to modify your storage, see [Expanding Block Storage capacity](/docs/BlockStorage?topic=BlockStorage-expandingcapacity#expandingcapacity) and [Adjusting IOPS](/docs/BlockStorage?topic=BlockStorage-adjustingIOPS). Updates that you make from the console are not reflected in the persistent volume (PV). To add this information to the PV, run `kubectl patch pv <pv_name>` and manually update the size and IOPS in the **Labels** and **Annotation** section of your PV.
{: tip}


1. List the PVCs in your cluster and note the name of the associated PV from the **VOLUME** column.

    ```sh
    kubectl get pvc
    ```
    {: pre}

    Example output

    ```sh
    NAME             STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
    myvol            Bound     pvc-01ac123a-123b-12c3-abcd-0a1234cb12d3   20Gi       RWO            ibmc-block-bronze    147d
    ```
    {: screen}

1. If you want to change the IOPS and the size for your block storage, edit the IOPS in the `metadata.labels.IOPS` section of your PV first. You can increase or decrease the IOPS value. Make sure that you enter an IOPS that is supported for the storage type that you have. For example, if you have endurance block storage with 4 IOPS, you can change the IOPS to either 2 or 10. For more supported IOPS values, see [Deciding on your block storage configuration](/docs/containers?topic=containers-block_storage#block_predefined_storageclass).

    ```sh
    kubectl edit pv <pv_name>
    ```
    {: pre}

    To change the IOPS from the CLI, you must also change the size of your block storage. If you want to change only the IOPS, but not the size, you must [request the IOPS change from the console](/docs/BlockStorage?topic=BlockStorage-adjustingIOPS).
    {: note}

1. Edit the PVC and add the new size in the `spec.resources.requests.storage` section of your PVC. You can change to a greater size only up to the maximum capacity that is set by your storage class. You can't downsize your existing storage. To see available sizes for your storage class, see [Deciding on the block storage configuration](/docs/containers?topic=containers-block_storage#block_predefined_storageclass).

    ```sh
    kubectl edit pvc <pvc_name>
    ```
    {: pre}

1. Verify that the volume expansion is requested. The volume expansion is successfully requested when you see a `FileSystemResizePending` message in the **Conditions** section of your CLI output.

    ```sh
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Conditions:
    Type                      Status  LastProbeTime                     LastTransitionTime                Reason  Message
    ----                      ------  -----------------                 ------------------                ------  -------
    FileSystemResizePending   True    Mon, 01 Jan 0001 00:00:00 +0000   Thu, 25 Apr 2022 15:52:49 -0400           Waiting for user to (re-)start a pod to finish file system resize of volume on node.
    ```
    {: screen}

1. List all the pods that mount the PVC. If your PVC is mounted by a pod, the volume expansion is automatically processed. If your PVC is not mounted by a pod, you must mount the PVC to a pod so that the volume expansion can be processed.

    ```sh
    kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
    ```
    {: pre}

    Mounted pods are returned in the format: `<pod_name>: <pvc_name>`.

1. If your PVC is not mounted by a pod, [create a pod or deployment and mount the PVC](/docs/containers?topic=containers-block_storage#add_block). If your PVC is mounted by a pod, continue with the next step.

1. Verify that the size and IOPS are changed in the **Labels** section of your CLI output. This process might take a few minutes to complete.

    ```sh
    kubectl describe pv <pv_name>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Labels:       CapacityGb=50
    Datacenter=dal10
    IOPS=500
    ```
    {: screen}
    
1. Log in to the pod that mounts the PVC.
    ```sh
    kubectl exec <pod-name> -it -- bash
    ```
    {: pre}

1. Run the following command to use host binaries.
    ```sh
    chroot /host
    ```
    {: pre}

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
{: #block_backup_restore}

Block storage is provisioned into the same location as the worker nodes in your cluster. The storage is hosted on clustered servers by IBM to provide availability in case a server goes down. However, block storage is not backed up automatically and might be inaccessible if the entire location fails. To protect your data from being lost or damaged, you can set up periodic backups that you can use to restore your data when needed.
{: shortdesc}

Review the following backup and restore options for your block storage:

### Setting up periodic snapshots
{: #block-snaps}

You can [set up periodic snapshots for your block storage](/docs/BlockStorage?topic=BlockStorage-snapshots#snapshots), which is a read-only image that captures the state of the instance at a point in time.
{: shortdesc}


To store the snapshot, you must request snapshot space on your block storage. Snapshots are stored on the existing storage instance within the same zone. You can restore data from a snapshot if a user accidentally removes important data from the volume. \n  \n **To create a snapshot for your volume, complete the following steps.

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Log in to the `ibmcloud sl` CLI. 

    ```sh
    ibmcloud sl init
    ```
    {: pre}

1. List existing PVs in your cluster.

    ```sh
    kubectl get pv
    ```
    {: pre}

1. Get the details for the PV for which you want to create snapshot space and note the volume ID, the size, and the IOPS. The size and IOPS are shown in the **Labels** section of your CLI output.

    ```sh
    kubectl describe pv <pv_name>
    ```
    {: pre}

1. To find the volume ID, review the `ibm.io/network-storage-id` annotation of your CLI output.

1. Create the snapshot size for your existing volume with the parameters that you retrieved in the previous step.

    ```sh
    ibmcloud sl block snapshot-order <volume_ID> --size <size> --tier <iops>
    ```
    {: pre}
    
1. Wait for the snapshot size to create. The snapshot size is successfully provisioned when the **Snapshot Size (GB)** in your CLI output changes from 0 to the size that you ordered.

    ```sh
    ibmcloud sl block volume-detail <volume_ID>
    ```
    {: pre}

1. Create the snapshot for your volume and note the ID of the snapshot that is created for you. 

    ```sh
    ibmcloud sl block snapshot-create <volume_ID>
    ```
    {: pre}
    
1. Verify that the snapshot is created successfully.

    ```sh
    ibmcloud sl block snapshot-list <volume_ID>
    ```
    {: pre}

1. Set the snapshot schedule. For more information on the options available for your snapshot schedule, refer to the [CLI documentation](/docs/cli?topic=cli-sl-block-storage#sl_block_snapshot_enable). 

    ```sh
    ibmcloud sl block snapshot-enable VOLUME_ID <OPTIONS>
    ```

1. To restore data from a snapshot to an existing volume, run the following command.

    ```sh
    ibmcloud sl block snapshot-restore <volume_ID> <snapshot_ID>
    ```
    {: pre}

### Replicating snapshots to another zone
{: #block-replicate}

To protect your data from a zone failure, you can [replicate snapshots](/docs/BlockStorage?topic=BlockStorage-replication#replication) to a block storage instance that is set up in another zone.
{: shortdesc}

Data can be replicated from the primary storage to the backup storage only. You can't mount a replicated block storage instance to a cluster. When your primary storage fails, you can manually set your replicated backup storage to be the primary one. Then, you can mount it to your cluster. After your primary storage is restored, you can restore the data from the backup storage.


### Duplicating storage
{: #block-dupe}

You can [duplicate your block storage instance](/docs/BlockStorage?topic=BlockStorage-duplicatevolume#duplicatevolume) in the same zone as the original storage instance.
{: shortdesc}

A duplicate has the same data as the original storage instance at the point in time that you create the duplicate. Unlike replicas, use the duplicate as an independent storage instance from the original. To duplicate, first set up snapshots for the volume.


### Backing up data to {{site.data.keyword.cos_full}}
{: #block-cos-backup}

You can use the [**ibm-backup-restore**](/docs/containers?topic=containers-utilities#backup-restore-pvc) Helm chart to spin up a backup and restore pod in your cluster.
{: shortdesc}

This pod contains a script to run a one-time or periodic backup for any persistent volume claim (PVC) in your cluster. Data is stored in your {{site.data.keyword.cos_full}} instance that you set up in a zone.

Block storage is mounted with an RWO access mode. This access allows only one pod to be mounted to the block storage at a time. To back up your data, you must unmount the app pod from the storage, mount it to your backup pod, back up the data, and remount the storage to your app pod.
{: note}

To make your data even more highly available and protect your app from a zone failure, set up a second {{site.data.keyword.cos_short}} instance and replicate data across zones. If you need to restore data from your {{site.data.keyword.cos_short}} instance, use the restore pod that is provided with the Helm chart.


### Copying data to and from pods and containers
{: #block-cp}

You can use the `kubectl cp` [command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cp){: external} to copy files and directories to and from pods or specific containers in your cluster.
{: shortdesc}

[Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster) 

When you run the `kubectl cp` command, if you don't specify a container with `-c`, the command uses the first available container in the pod.

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



## Storage class reference
{: #block_storageclass_reference}



### Bronze
{: #bronze-block}

Name
:   `ibmc-block-bronze`
:   `ibmc-block-retain-bronze`

Type
:   Endurance storage

File system
:   `ext4`

IOPS per gigabyte
:   2

Size range in gigabytes
:   20-12000 Gi

Hard disk
:   SSD

Reclaim policy
:   `ibmc-block-bronze`: Delete
:   `ibmc-block-retain-bronze`: Retain


### Silver
{: #silver-block}

Name
:   `ibmc-block-silver`
:   `ibmc-block-retain-silver`

Type
:   Endurance storage

File system
:   `ext4`

IOPS per gigabyte
:   4

Size range in gigabytes
:   20-12000 Gi

Hard disk
:   SSD

Reclaim policy
:   `ibmc-block-silver`: Delete
:   `ibmc-block-retain-silver`: Retain

### Gold
{: #gold-block}

Name
:   `ibmc-block-gold`
:   `ibmc-block-retain-gold`

Type
:   Endurance storage

File system
:   `ext4`

IOPS per gigabyte
:   10

Size range in gigabytes
:   20-4000 Gi

Hard disk
:   SSD

Reclaim policy
:   `ibmc-block-gold`: Delete
:   `ibmc-block-retain-gold`: Retain

### Custom
{: #custom-block}


Name
:   `ibmc-block-custom`
:   `ibmc-block-retain-custom`

Type
:   Performance
File system
:   `ext4`

IOPS and size
:   **Size range in gigabytes / IOPS range in multiples of 100**
    - 20-39 Gi / 100-1000 IOPS
    - 40-79 Gi / 100-2000 IOPS
    - 80-99 Gi / 100-4000 IOPS
    - 100-499 Gi / 100-6000 IOPS
    - 500-999 Gi / 100-10000 IOPS
    - 1000-1999 Gi / 100-20000 IOPS
    - 2000-2999 Gi / 200-40000 IOPS
    - 3000-3999 Gi / 200-48000 IOPS
    - 4000-7999 Gi / 300-48000 IOPS
    - 8000-9999 Gi / 500-48000 IOPS
    - 10000-12000 Gi / 1000-48000 IOPS

Hard disk
:   The IOPS to gigabyte ratio determines the type of hard disk that is provisioned. To determine your IOPS to gigabyte ratio, you divide the IOPS by the size of your storage.
:   Example: You chose 500Gi of storage with 100 IOPS. Your ratio is 0.2 (100 IOPS/500Gi).
:   **Overview of hard disk types per ratio:**
    - Less than or equal to 0.3: SATA
    - Greater than 0.3: SSD

Reclaim policy
:   `ibmc-block-custom`: Delete
:   `ibmc-block-retain-custom`: Retain




## Sample customized storage classes
{: #block_custom_storageclass}

You can create a customized storage class and use the storage class in your PVC.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} provides [pre-defined storage classes](#block_storageclass_reference) to provision block storage with a particular tier and configuration. Sometimes, you might want to provision storage with a different configuration that is not covered in the pre-defined storage classes. You can use the examples in this topic to find sample customized storage classes.

To create your customized storage class, see [Customizing a storage class](#block_custom_storageclass). Then, [use your customized storage class in your PVC](#add_block).

### Creating topology-aware storage
{: #topology_yaml}

To use block storage in a multizone cluster, your pod must be scheduled in the same zone as your block storage instance so that you can read and write to the volume. Before topology-aware volume scheduling was introduced by Kubernetes, the dynamic provisioning of your storage automatically created the block storage instance when a PVC was created. Then, when you created your pod, the Kubernetes scheduler tried to deploy the pod to the same data center as your block storage instance.
{: shortdesc}

Creating the block storage instance without knowing the constraints of the pod can lead to unwanted results. For example, your pod might not be able to be scheduled to the same worker node as your storage because the worker node has insufficient resources or the worker node is tainted and does not allow the pod to be scheduled. With topology-aware volume scheduling, the block storage instance is delayed until the first pod that uses the storage is created.

To use topology-aware volume scheduling, make sure that you installed the {{site.data.keyword.cloud_notm}} Block Storage plug-in version 1.2.0 or later.
{: note}

The following examples show how to create storage classes that delay the creation of the block storage instance until the first pod that uses this storage is ready to be scheduled. To delay the creation, you must include the `volumeBindingMode: WaitForFirstConsumer` option. If you don't include this option, the `volumeBindingMode` is automatically set to `Immediate` and the block storage instance is created when you create the PVC.

Example for Endurance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-bronze-delayed
  parameters:
    billingType: hourly
    classVersion: "2"
    fsType: ext4
    iopsPerGB: "2"
    sizeRange: '[20-12000]Gi'
    type: Endurance
  provisioner: ibm.io/ibmc-block
  reclaimPolicy: Delete
  volumeBindingMode: WaitForFirstConsumer
```
{: codeblock}

Example for Performance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-performance-storageclass
  labels:
  kubernetes.io/cluster-service: "true"
  provisioner: ibm.io/ibmc-block
  parameters:
    billingType: "hourly"
    classVersion: "2"
    sizeIOPSRange: |-
    "[20-39]Gi:[100-1000]"
    "[40-79]Gi:[100-2000]"
    "[80-99]Gi:[100-4000]"
    "[100-499]Gi:[100-6000]"
    "[500-999]Gi:[100-10000]"
    "[1000-1999]Gi:[100-20000]"
    "[2000-2999]Gi:[200-40000]"
    "[3000-3999]Gi:[200-48000]"
    "[4000-7999]Gi:[300-48000]"
    "[8000-9999]Gi:[500-48000]"
    "[10000-12000]Gi:[1000-48000]"
    type: "Performance"
  reclaimPolicy: Delete
  volumeBindingMode: WaitForFirstConsumer
```
{: codeblock}

### Specifying the zone and region
{: #block_multizone_yaml}

If you want to create your block storage in a specific zone, you can specify the zone and region in a customized storage class.
{: shortdesc}

Use the customized storage class if you use the {{site.data.keyword.cloud_notm}} Block Storage plug-in version 1.0.0 or if you want to [statically provision block storage](#existing_block) in a specific zone. In all other cases, [specify the zone directly in your PVC](#add_block).
{: note}

The following `.yaml` file customizes a storage class that is based on the `ibm-block-silver` non-retaining storage class: the `type` is `"Endurance"`, the `iopsPerGB` is `4`, the `sizeRange` is `"[20-12000]Gi"`, and the `reclaimPolicy` is set to `"Delete"`. The zone is specified as `dal12`. To use a different storage class as your base, see the [storage class reference](#block_storageclass_reference).

Create the storage class in the same region and zone as your cluster and worker nodes. To get the region of your cluster, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>` and look for the region prefix in the **Master URL**, such as `eu-de` in `https://c2.eu-de.containers.cloud.ibm.com:11111`. To get the zone of your worker node, run `ibmcloud ks worker ls --cluster <cluster_name_or_ID>`.

Example for Endurance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  region: "us-south"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}


Example for Performance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
    name: ibmc-block-performance-storageclass
labels:
  kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  region: "us-south"
  type: "Performance"
  sizeIOPSRange: |-
  "[20-39]Gi:[100-1000]"
  "[40-79]Gi:[100-2000]"
  "[80-99]Gi:[100-4000]"
  "[100-499]Gi:[100-6000]"
  "[500-999]Gi:[100-10000]"
  "[1000-1999]Gi:[100-20000]"
  "[2000-2999]Gi:[200-40000]"
  "[3000-3999]Gi:[200-48000]"
  "[4000-7999]Gi:[300-48000]"
  "[8000-9999]Gi:[500-48000]"
  "[10000-12000]Gi:[1000-48000]"
reclaimPolicy: "Delete"
```
{: codeblock}

### Mounting block storage with an `XFS` file system
{: #xfs}

The following examples create a storage class that provisions block storage with an `XFS` file system.
{: shortdesc}

Example for Endurance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-custom-xfs
labels:
  addonmanager.kubernetes.io/mode: Reconcile
provisioner: ibm.io/ibmc-block
parameters:
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
  fsType: "xfs"
reclaimPolicy: "Delete"
```
{: codeblock}


Example for Performance block storage.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-custom-xfs
  labels:
    addonmanager.kubernetes.io/mode: Reconcile
provisioner: ibm.io/ibmc-block
parameters:
  classVersion: "2"
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
```
{: codeblock}


## Removing persistent storage from a cluster
{: #cleanup_block}

When you set up persistent storage in your cluster, you have three main components: the Kubernetes persistent volume claim (PVC) that requests storage, the Kubernetes persistent volume (PV) that is mounted to a pod and described in the PVC, and the IBM Cloud infrastructure instance, such as classic file or block storage. Depending on how you created your storage, you might need to delete all three components separately. 
{: shortdesc}


### Understanding your storage removal options
{: #storage_delete_options_block}

Removing persistent storage from your {{site.data.keyword.cloud_notm}} account varies depending on how you provisioned the storage and what components you already removed.
{: shortdesc}

Is my persistent storage deleted when I delete my cluster?
:   During cluster deletion, you have the option to remove your persistent storage. However, depending on how your storage was provisioned, the removal of your storage might not include all storage components. If you dynamically provisioned storage with a storage class that sets `reclaimPolicy: Delete`, your PVC, PV, and the storage instance are automatically deleted when you delete the cluster. For storage that was statically provisioned or storage that you provisioned with a storage class that sets `reclaimPolicy: Retain`, the PVC and the PV are removed when you delete the cluster, but your storage instance and your data remain. You are still charged for your storage instance. Also, if you deleted your cluster in an unhealthy state, the storage might still exist even if you chose to remove it.

How do I delete the storage when I want to keep my cluster?
:   When you dynamically provisioned the storage with a storage class that sets `reclaimPolicy: Delete`, you can remove the PVC to start the deletion process of your persistent storage. Your PVC, PV, and storage instance are automatically removed. For storage that was statically provisioned or storage that you provisioned with a storage class that sets `reclaimPolicy: Retain`, you must manually remove the PVC, PV, and the storage instance to avoid further charges.

How does the billing stop after I delete my storage?
:   Depending on what storage components you delete and when, the billing cycle might not stop immediately. If you delete the PVC and PV, but not the storage instance in your {{site.data.keyword.cloud_notm}} account, that instance still exists and you are charged for it.

If you delete the PVC, PV, and the storage instance, the billing cycle stops depending on the `billingType` that you chose when you provisioned your storage and how you chose to delete the storage.

- When you manually cancel the persistent storage instance from the {{site.data.keyword.cloud_notm}} console or the CLI, billing stops as follows:
    - **Hourly storage**: Billing stops immediately. After your storage is canceled, you might still see your storage instance in the console for up to 72 hours.
    - **Monthly storage**: You can choose between immediate cancellation or cancellation on the anniversary date. In both cases, you are billed until the end of the current billing cycle, and billing stops for the next billing cycle. After your storage is canceled, you might still see your storage instance in the console or the CLI for up to 72 hours.
    - **Immediate cancellation**: Choose this option to immediately remove your storage. Neither you nor your users can use the storage anymore or recover the data.
    - **Anniversary date**: Choose this option to cancel your storage on the next anniversary date. Your storage instances remain active until the next anniversary date and you can continue to use them until this date, such as to give your team time to make backups of your data.

- When you dynamically provisioned the storage with a storage class that sets `reclaimPolicy: Delete` and you choose to remove the PVC, the PV and the storage instance are immediately removed. For hourly billed storage, billing stops immediately. For monthly billed storage, you are still charged for the remainder of the month. After your storage is removed and billing stops, you might still see your storage instance in the console or the CLI for up to 72 hours.

What do I need to be aware of before I delete persistent storage?
:   When you clean up persistent storage, you delete all the data that is stored in it. If you need a copy of the data, make a backup.

I deleted my storage instance. Why can I still see my instance?
:   After you remove persistent storage, it can take up to 72 hours for the removal to be fully processed and for the storage to disappear from your {{site.data.keyword.cloud_notm}} console or CLI.




### Cleaning up persistent storage
{: #storage_remove_block}


Remove the PVC, PV, and the storage instance from your {{site.data.keyword.cloud_notm}} account to avoid further charges for your persistent storage.
{: shortdesc}

Before you begin:
- Make sure that you backed up any data that you want to keep.
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

To clean up persistent data:

1. List the PVCs in your cluster and note the **`NAME`** of the PVC, the **`STORAGECLASS`**, and the name of the PV that is bound to the PVC and shown as **`VOLUME`**.

    ```sh
    kubectl get pvc
    ```
    {: pre}

    Example output
    
    ```sh
    NAME                  STATUS    VOLUME                                     CAPACITY   ACCESSMODES   STORAGECLASS            AGE
    claim1   Bound     pvc-06886b77-102b-11e8-968a-f6612bb731fb   20Gi       RWO           class       78d
    claim2     Bound     pvc-457a2b96-fafc-11e7-8ff9-b6c8f770356c   4Gi        RWX           class 105d
    claim3      Bound     pvc-1efef0ba-0c48-11e8-968a-f6612bb731fb   24Gi       RWX           class        83d
    ```
    {: screen}

1. Review the **`ReclaimPolicy`** and **`billingType`** for the storage class.

    ```sh
    kubectl describe storageclass <storageclass_name>
    ```
    {: pre}

    If the reclaim policy says `Delete`, your PV and the physical storage are removed when you remove the PVC. If the reclaim policy says `Retain`, or if you provisioned your storage without a storage class, then your PV and physical storage are not removed when you remove the PVC. You must remove the PVC, PV, and the physical storage separately.

    If your storage is charged monthly, you still get charged for the entire month, even if you remove the storage before the end of the billing cycle.
    {: important}

1. Remove any pods that mount the PVC. List the pods that mount the PVC. If no pod is returned in your CLI output, you don't have a pod that uses the PVC.

    ```sh
    kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
    ```
    {: pre}

    Example output

    ```sh
    depl-12345-prz7b:    claim1
    ```
    {: screen}

1. Remove the pod that uses the PVC. If the pod is part of a deployment, remove the deployment.

    ```sh
    kubectl delete pod <pod_name>
    ```
    {: pre}

1. Verify that the pod is removed.

    ```sh
    kubectl get pods
    ```
    {: pre}

1. Remove the PVC.

    ```sh
    kubectl delete pvc <pvc_name>
    ```
    {: pre}

1. Review the status of your PV. Use the name of the PV that you retrieved earlier as **`VOLUME`**. When you remove the PVC, the PV that is bound to the PVC is released. Depending on how you provisioned your storage, your PV goes into a `Deleting` state if the PV is deleted automatically, or into a `Released` state, if you must manually delete the PV. **Note**: For PVs that are automatically deleted, the status might briefly say `Released` before it is deleted. Rerun the command after a few minutes to see whether the PV is removed.

    ```sh
    kubectl get pv <pv_name>
    ```
    {: pre}

1. If your PV is not deleted, manually remove the PV.

    ```sh
    kubectl delete pv <pv_name>
    ```
    {: pre}

1. Verify that the PV is removed.

    ```sh
    kubectl get pv
    ```
    {: pre}
    
1. List the physical storage instance that your PV pointed to and note the **`id`** of the physical storage instance. {: #sl_delete_storage}

    ```sh
    ibmcloud sl block volume-list --columns id --columns notes | grep <pv_name>
    ```
    {: pre}

    Example output

    ```sh
    12345678   {"plugin":"ibmcloud-block-storage-plugin-689df949d6-4n9qg","region":"us-south","cluster":"aa1a11a1a11b2b2bb22b22222c3c3333","type":"Endurance","ns":"default","pvc":"block-storage-pvc","pv":"pvc-d979977d-d79d-77d9-9d7d-d7d97ddd99d7","storageclass":"ibmc-block-silver","reclaim":"Delete"}
    ```
    {: screen}

    Understanding the **Notes** field information:
    
    `"plugin":"ibm-file-plugin-5b55b7b77b-55bb7"`
    :   The storage plug-in that the cluster uses.
    
    `"region":"us-south"`
    : The region that your cluster is in.
    
    `"cluster":"aa1a11a1a11b2b2bb22b22222c3c3333"`
    :   The cluster ID that is associated with the storage instance.
    
    `"type":"Endurance"`
    :   The type of file or block storage, either `Endurance` or `Performance`.
    
    `"ns":"default"`
    :   The namespace that the storage instance is deployed to.
    
    `"pvc":"block-storage-pvc"`
    :   The name of the PVC that is associated with the storage instance.
    
    `"pv":"pvc-d979977d-d79d-77d9-9d7d-d7d97ddd99d7"`
    :   The PV that is associated with the storage instance.
   
    `"storageclass":"ibmc-file-gold"`
    :   The type of storage class: bronze, silver, gold, or custom.

1. Remove the physical storage instance.

    ```sh
    ibmcloud sl block volume-cancel <classic_block_id>
    ```
    {: pre}

1. Verify that the physical storage instance is removed.

The deletion process might take up to 72 hours to complete.
{: important}

```sh
ibmcloud sl block volume-list
```
{: pre}

## Setting up monitoring for `limited` connectivity PVs
{: #storage-block-vpc-limited-monitoring}

When you create a pod and PVC that use {{site.data.keyword.blockstorageshort}}, 2 target ports are assigned to the underlying persistent volume (PV) where the storage is mounted. Multiple target ports allow for failover in case one port goes down.

In previous versions of the {{site.data.keyword.blockstorageshort}} driver, the inability to find 2 target ports when mounting a PV during rollout caused deployment failure.

However, sometimes, such as during IaaS maintenance windows, you might want your pods to deploy successfully with only 1 target port available on the persistent volume. 

Beginning in version `2.4.12` of the {{site.data.keyword.blockstorageshort}} driver, pods will deploy successfully even if only 1 target port can be assigned by the PV. In addition to this behavior change, PVs now include a new label to indicate the network availability where a label of `healthy` means 2 targets ports were assigned and `limited` means only 1 target port could be assigned during mounting.

To monitor for instances where pod connectivity to {{site.data.keyword.blockstorageshort}} is limited, you can set up a custom alert that looks for the `limited` label. Then, configure the alert threshold to `>0`.

1. From the {{site.data.keyword.monitoringlong_notm}} dashboard, select **New alert** > **Metric**.

1. Select **Prom query** and enter `kube_persistentvolume_labels{label_ibm_io_pv_connectivity_status='limited'}`. 

1. Set the threshold to `>0` and set the severity you want to use for this alert.

1. Select your notification channel and save the alert.


## Assigning trusted profiles to block storage
{: #block-classic-trusted-profile}

You can use trusted profiles to grant different IBM Cloud identities access to resources in your account, including your storage solutions. Trusted profiles centralize access control, eliminate the need for long-lived API keys, and allow you to scope permissions to the exact minimum required for a specific task. For more information, see [Configuring a trusted profile for storage components](/docs/containers?topic=containers-configure-trusted-profile&interface=ui).
