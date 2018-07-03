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




# Storing data on IBM Block Storage for IBM Cloud


## Installing the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in in your cluster
{: #install_block}

Install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in with a Helm chart to set up pre-defined storage classes for block storage. You can use these storage classes to create a PVC to provision block storage for your apps.
{: shortdesc}

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster where you want to install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.

1. Install [Helm](cs_integrations.html#helm) on the cluster where you want to use the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.
2. Update the helm repo to retrieve the latest version of all helm charts in this repo.
   ```
   helm repo update
   ```
   {: pre}

3. Install the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in. When you install the plug-in, pre-defined block storage classes are added to your cluster.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   NAME:   bald-olm
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
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Verify that the installation was successful.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Example output:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   The installation is successful when you see one `ibmcloud-block-storage-plugin` pod and one or more `ibmcloud-block-storage-driver` pods. The number of `ibmcloud-block-storage-driver` equals the number of worker nodes in your cluster. All pods must be in a **Running** state.

5. Verify that the storage classes for block storage were added to your cluster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Example output:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Repeat these steps for every cluster where you want to provision block storage.

You can now continue to [create a PVC](#create) to provision block storage for your app.

<br />


### Updating the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in
You can upgrade the existing {{site.data.keyword.Bluemix_notm}} Block Storage plug-in to the latest version.
{: shortdesc}

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster.

1. Find the name of the block storage helm chart that you installed in your cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Upgrade the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in to the latest version.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Optional: When you update the plug-in, the `default` storage class is unset.  If you want to set the default storage class to a storage class of your choice, run the following command.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}

<br />


### Removing the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in
If you do not want to provision and use {{site.data.keyword.Bluemix_notm}} Block Storage for your cluster, you can uninstall the helm chart.
{: shortdesc}

**Note:** Removing the plug-in does not remove existing PVCs, PVs, or data. When you remove the plug-in, all the related pods and daemon sets are removed from your cluster. You cannot provision new block storage for your cluster or use existing block storage PVCs and PVs after you remove the plug-in.

Before you begin, [target your CLI](cs_cli_install.html#cs_cli_configure) to the cluster and make sure that you do not have any PVCs or PVs in your cluster that use block storage.

1. Find the name of the block storage helm chart that you installed in your cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Example output:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Delete the {{site.data.keyword.Bluemix_notm}} Block Storage plug-in.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Verify that the block storage pods are removed.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   The removal of the pods is successful if no pods are displayed in your CLI output.

4. Verify that the block storage storage classes are removed.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   The removal of the storage classes is successful if no storage classes are displayed in your CLI output.

<br />





