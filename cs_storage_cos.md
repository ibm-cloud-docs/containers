---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Storing data on IBM Cloud Object Storage
{: #object_storage}

## Creating your object storage service instance
{: #create_cos_service}

Before you can start using {{site.data.keyword.cos_full_notm}} in your cluster, you must provision an {{site.data.keyword.cos_full_notm}} service instance in your account. 
{: shortdesc}

1. Deploy an {{site.data.keyword.cos_full_notm}} service instance.
   1.  Open the [{{site.data.keyword.cos_full_notm}} catalog page](https://console.bluemix.net/catalog/services/cloud-object-storage).
   2.  Enter a name for your service instance, such as `cos-backup`, and select the same resource group that your cluster is in. To view the resource group of your cluster, run `[bxcs] cluster-get --cluster <cluster_name_or_ID>`.   
   3.  Review the [plan options ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) for pricing information and select a plan. 
   4.  Click **Create**. The service details page opens. 
2. {: #service_credentials}Retrieve the {{site.data.keyword.cos_full_notm}} service credentials.
   1.  In the navigation on the service details page, click **Service Credentials**.
   2.  Click **New credential**. A dialog box displays. 
   3.  Enter a name for your credentials.
   4.  From the **Role** drop-down, select `Writer` or `Manager`. When you select `Reader`, then you cannot use the credentials to create buckets in {{site.data.keyword.cos_full_notm}} and write data to it. 
   5.  Optional: In **Add Inline Configuration Parameters (Optional)**, enter `{"HMAC":true}` to create additional HMAC credentials for the {{site.data.keyword.cos_full_notm}} service. HMAC authentication adds an extra layer of security to the OAuth2 authentication by preventing the misuse of expired or randomly created OAuth2 tokens. 
   6.  Click **Add**. Your new credentials are listed in the **Service Credentials** table.
   7.  Click **View credentials**. 
   8.  Make note of the **apikey** to use OAuth2 tokens to authenticate with the {{site.data.keyword.cos_full_notm}} service. For HMAC authentication, in the **cos_hmac_keys** section, note the **access_key_id** and the **secret_access_key**. 
3. [Store your service credentials in a Kubernetes secret inside the cluster](#create_cos_secret) to enable access to your {{site.data.keyword.cos_full_notm}} service instance. 

## Creating a secret for the object storage service credentials
{: #create_cos_secret}

To access your {{site.data.keyword.cos_full_notm}} service instance to read and write data, you must securely store the service credentials in a Kubernetes secret. The {{site.data.keyword.cos_full_notm}} plug-in uses these credentials for every read or write operation to your bucket. 
{: shortdesc}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

1. Retrieve the **apikey**, or the **access_key_id** and the **secret_access_key** of your [{{site.data.keyword.cos_full_notm}} service credentials](#service_credentials). 

2. Get the **GUID** of your {{site.data.keyword.cos_full_notm}} service instance. 
   ```
   ibmcloud resource service-instance <service_name> | grep GUID
   ```
   {: pre}
  
3. Encode the {{site.data.keyword.cos_full_notm}} **GUID** and the **apikey**, or the **access_key_id** and **secret_access_key** that you retrieved earlier to base64 and note all the base64 encoded values. Repeat this command for each parameter to retrieve the base 64 encoded value. 
   ```
   echo -n "<key_value>" | base64
   ```
   {: pre}
   
4. Create a configuration file to define your Kubernetes secret.

   **Example for using the API key:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     api-key: <base64_apikey> 
     service-instance-id: <base64_guid> 
   ```
   {: codeblock}
   
   **Example for using HMAC authentication:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     access-key: <base64_access_key_id> 
     secret-key: <base64_secret_access_key> 
     service-instance-id: <base64_guid> 
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
   <td>Enter a name for your {{site.data.keyword.cos_full_notm}} secret. </td>
   </tr>
   <tr>
   <td><code>metadata.namespace</code></td>
   <td>Specify the namespace where you want to create the secret. The secret must be created in the same namespace where you want to create your PVC and the pod that accesses your {{site.data.keyword.cos_full_notm}} service instance.  </td>
   </tr>
   <tr>
   <td><code>data.api-key</code></td>
   <td>Enter the API key that you retrieved from your {{site.data.keyword.cos_full_notm}} service credentials earlier. The API key must be base64 encoded. If you want to use HMAC authentication, specify the <code>data/access-key</code> and <code>data/secret-key</code> instead.  </td>
   </tr>
   <tr>
   <td><code>data.access-key</code></td>
   <td>Enter the access key ID that you retrieved from your {{site.data.keyword.cos_full_notm}} service credentials earlier. The access key ID must be base64 encoded. If you want to use OAuth2 authentication, specify the <code>data/api-key</code> instead.  </td>
   </tr>
   <tr>
   <td><code>data.secret-key</code></td>
   <td>Enter the secret access key that you retrieved from your {{site.data.keyword.cos_full_notm}} service credentials earlier. The secret access key must be base64 encoded. If you want to use OAuth2 authentication, specify the <code>data/api-key</code> instead.</td>
   </tr>
   <tr>
   <td><code>data.service-instance-id</code></td>
   <td>Enter the GUID of your {{site.data.keyword.cos_full_notm}} service instance that you retrieved earlier. The GUID must be base64 encoded. </td>
   </tr>
   </tbody>
   </table>
     
5. Create the secret in your cluster. 
   ```
   kubectl apply -f filepath/secret.yaml
   ```
   {: pre}
   
6. Verify that the secret is created in your namespace. 
   ```
   kubectl get secret
   ```
   {: pre}
   
7. [Install the {{site.data.keyword.cos_full_notm}} plug-in](#install_cos), or if you already installed the plug-in, [decide on the configuration]( #configure_cos) for your {{site.data.keyword.cos_full_notm}} bucket. 

## Installing the IBM Cloud Object Storage plug-in
{: #install_cos}

Install the {{site.data.keyword.cos_full_notm}} plug-in with a Helm chart to set up pre-defined storage classes for {{site.data.keyword.cos_full_notm}}. You can use these storage classes to create a PVC to provision {{site.data.keyword.cos_full_notm}} for your apps.
{: shortdesc}

Looking for instructions for how to update or remove the {{site.data.keyword.cos_full_notm}} plug-in? See [Updating the plug-in](#update_cos_plugin) and [Removing the plug-in](#remove_cos_plugin). 
{: tip}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

1. Make sure that your worker node applies the latest patch for your minor version. 
   1. List the current patch version of your worker nodes. 
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}
      
      Example output: 
      ```
      OK
      ID                                                  Public IP        Private IP     Machine Type           State    Status   Zone    Version   
      kube-dal10-crb1a23b456789ac1b20b2nc1e12b345ab-w26   169.xx.xxx.xxx    10.xxx.xx.xxx   b2c.4x16.encrypted     normal   Ready    dal10   1.9.10_1523* 
      ```
      {: screen}
      
      If your worker node does not apply the latest patch version, you see an asterisk (`*`) in the **Version** column of your CLI output. 
      
   2. Review the [version changelog](cs_versions_changelog.html#changelog) to find the changes that are included in the latest patch version. 
   
   3. Apply the latest patch version by reloading your worker node. Follow the instructions in the [ibmcloud ks worker-reload command](cs_cli_reference.html#cs_worker_reload) to gracefully reschedule any running pods on your worker node before you reload your worker node.

2. Follow the [instructions](cs_integrations.html#helm) to install the Helm client on your local machine, install the Helm server (tiller) in your cluster, and add the {{site.data.keyword.Bluemix_notm}} Helm chart repository to the cluster where you want to use the {{site.data.keyword.cos_full_notm}} plug-in.

    **Important:** If you use Helm version 2.9 or higher, make sure that you installed tiller with a [service account](cs_integrations.html#helm). 
    
3. Add the {{site.data.keyword.Bluemix_notm}} Helm repo to your cluster. 
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}
   
4. Update the Helm repo to retrieve the latest version of all Helm charts in this repo.
   ```
   helm repo update
   ```
   {: pre}
   
5. Download the Helm charts and unpack the charts in your current directory. 
   ```
   helm fetch --untar ibm/ibmcloud-object-storage-plugin
   ```
   {: pre}

6. If you use macOS or a Linux distribution, install the {{site.data.keyword.cos_full_notm}} Helm plug-in `ibmc`. The plug-in is used to automatically retrieve your cluster location and to set the API endpoint for your {{site.data.keyword.cos_full_notm}} buckets in your storage classes. If you use Windows as your operating system, continue with the next step. 
   1. Install the Helm plug-in. 
      ```
      helm plugin install ibmcloud-object-storage-plugin/helm-ibmc
      ```
      {: pre}
      
      Example output: 
      ```
      Installed plugin: ibmc
      ```
      {: screen}
    
   2. Verify that the `ibmc` plug-in is installed successfully. 
      ```
      helm ibmc --help
      ```
      {: pre}
   
      Example output: 
      ```
      Install or upgrade Helm charts in IBM K8S Service

      Available Commands:
       helm ibmc install [CHART] [flags]              Install a Helm chart
       helm ibmc upgrade [RELEASE] [CHART] [flags]    Upgrades the release to a new version of the Helm chart

      Available Flags:
       --verbos                      (Optional) Verbosity intensifies... ...
       -f, --values valueFiles       (Optional) specify values in a YAML file (can specify multiple) (default [])
       -h, --help                    (Optional) This text.
       -u, --update                  (Optional) Update this plugin to the latest version

      Example Usage:
       helm ibmc install ibm/ibmcloud-object-storage-plugin -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
      ```
      {: screen}
   
7. Optional: Limit the {{site.data.keyword.cos_full_notm}} plug-in to access only the Kubernetes secrets that hold your {{site.data.keyword.cos_full_notm}} service credentials. By default, the plug-in is authorized to access all Kubernetes secrets in your cluster. 
   1. [Create your {{site.data.keyword.cos_full_notm}} service instance](#create_cos_service). 
   2. [Store your {{site.data.keyword.cos_full_notm}} service credentials in a Kubernetes secret](#create_cos_secret).
   3. Navigate to the `templates` directory and list available files.  
      ```
      cd ibmcloud-object-storage-plugin/templates && ls
      ```
      {: pre}
   
   4. Open the `provisioner-sa.yaml` file and look for the `ibmcloud-object-storage-secret-reader` ClusterRole definition. 
   6. Add the name of the secret that you created earlier to the list of secrets that the plug-in is authorized to access in the `resourceNames` section. 
      ```
      kind: ClusterRole
      apiVersion: rbac.authorization.k8s.io/v1beta1
      metadata:
        name: ibmcloud-object-storage-secret-reader
      rules:
      - apiGroups: [""]
        resources: ["secrets"]
        resourceNames: ["<secret_name1>","<secret_name2>"]
        verbs: ["get"]
      ```
      {: codeblock}
   7. Save your changes. 
   
8. Install the {{site.data.keyword.cos_full_notm}} plug-in. When you install the plug-in, pre-defined storage classes are added to your cluster. 

   - **For macOS and Linux:**
     - If you skipped the previous step, install without a limitation to specific Kubernetes secrets.
       ```
       helm ibmc install ibm/ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
       ```
       {: pre}
       
     - If you completed the previous step, install with a limitation to specific Kubernetes secrets. 
       ```
       helm ibmc install ./ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
       ```
       {: pre}
     
   - **For Windows:**
     1. Retrieve the zone where your cluster is deployed and store the zone in an environment variable. 
        ```
        export DC_NAME=$(kubectl get cm cluster-info -n kube-system -o jsonpath='{.data.cluster-config\.json}' | grep datacenter | awk -F ': ' '{print $2}' | sed 's/\"//g' |sed 's/,//g')
        ```
        {: pre}
        
     2. Verify that the environment variable is set. 
        ```
        printenv
        ```
        {: pre}
        
     3. Install the Helm chart. 
        - If you skipped the previous step, install without a limitation to specific Kubernetes secrets.
          ```
          helm install ibm/ibmcloud-object-storage-plugin --set dcname="$DC_NAME" --name ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
          ```
          {: pre}
          
        - If you completed the previous step, install with a limitation to specific Kubernetes secrets.
          ```
          helm install ./ibmcloud-object-storage-plugin --set dcname="$DC_NAME" --name ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
          ```
          {: pre}
         
   Example output: 
   ```
   Installing the Helm chart
   DC: dal10  Chart: ibm/ibmcloud-object-storage-plugin
   NAME:   mewing-duck
   LAST DEPLOYED: Mon Jul 30 13:12:59 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1/Pod(related)
   NAME                                             READY  STATUS             RESTARTS  AGE
   ibmcloud-object-storage-driver-hzqp9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-jtdb9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-tl42l             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-plugin-7d87fbcbcc-wgsn8  0/1    ContainerCreating  0         1s

   ==> v1beta1/StorageClass
   NAME                                  PROVISIONER       AGE
   ibmc-s3fs-cold-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-cold-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-cross-region      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-regional          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-cross-region       ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-cross-region  ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-regional      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-regional           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-cross-region          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-regional              ibm.io/ibmc-s3fs  1s

   ==> v1/ServiceAccount
   NAME                            SECRETS  AGE
   ibmcloud-object-storage-driver  1        1s
   ibmcloud-object-storage-plugin  1        1s

   ==> v1beta1/ClusterRole
   NAME                                   AGE
   ibmcloud-object-storage-secret-reader  1s
   ibmcloud-object-storage-plugin         1s

   ==> v1beta1/ClusterRoleBinding
   NAME                                   AGE
   ibmcloud-object-storage-plugin         1s
   ibmcloud-object-storage-secret-reader  1s

   ==> v1beta1/DaemonSet
   NAME                            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-object-storage-driver  3        3        0      3           0          <none>         1s

   ==> v1beta1/Deployment
   NAME                            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-object-storage-plugin  1        1        1           0          1s

   NOTES:
   Thank you for installing: ibmcloud-object-storage-plugin.   Your release is named: mewing-duck

   Please refer Chart README.md file for creating a sample PVC.
   Please refer Chart RELEASE.md to see the release details/fixes.
   ```
   {: screen}
   
8. Verify that the plug-in is installed correctly. 
   ```
   kubectl get pod -n kube-system -o wide | grep object
   ```
   {: pre}
   
   Example output: 
   ```
   ibmcloud-object-storage-driver-9n8g8                              1/1       Running   0          2m
   ibmcloud-object-storage-plugin-7c774d484b-pcnnx                   1/1       Running   0          2m
   ```
   {: screen}
      
   The installation is successful when you see one `ibmcloud-object-storage-plugin` pod and one or more `ibmcloud-object-storage-driver` pods. The number of `ibmcloud-object-storage-driver` pods equals the number of worker nodes in your cluster. All pods must be in a `Running` state for the plug-in to function properly. If the pods fail, run `kubectl describe pod -n kube-system <pod_name>` to find the root cause for the failure. 
   
9. Verify that the storage classes are created successfully. 
   ```
   kubectl get storageclass | grep s3
   ```
   {: pre}
      
   Example output:
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

10. Repeat the steps for all clusters where you want to access {{site.data.keyword.cos_full_notm}} buckets.
      
### Updating the IBM Cloud Object Storage plug-in
{: #update_cos_plugin}

You can upgrade the existing {{site.data.keyword.cos_full_notm}} plug-in to the latest version.
{: shortdesc}

1. Update the Helm repo to retrieve the latest version of all Helm charts in this repo.
   ```
   helm repo update
   ```
   {: pre}

2. Download to latest Helm chart to your local machine and unzip the package to review the `release.md` file to find the latest release information.
   ```
   helm fetch --untar ibm/ibmcloud-object-storage-plugin
   ```
   
3. Find the installation name of your helm chart.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}
   
   Example output: 
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}
   
4. Upgrade the {{site.data.keyword.cos_full_notm}} plug-in to the latest version.
   ```   
   helm ibmc upgrade <helm_chart_name> ibm/ibmcloud-object-storage-plugin --force --recreate-pods -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

5. Verify that the `ibmcloud-object-storage-plugin` is successfully upgraded.  
   ```
   kubectl rollout status deployment/ibmcloud-object-storage-plugin -n kube-system
   ```
   {: pre}
   
   The upgrade of the plug-in is successful when you see `deployment "ibmcloud-object-storage-plugin" successfully rolled out` in your CLI output. 
   
6. Verify that the `ibmcloud-object-storage-driver` is successfully upgraded. 
   ```
   kubectl rollout status ds/ibmcloud-object-storage-driver -n kube-system
   ```
   {: pre}
   
   The upgrade is successful when you see `daemon set "ibmcloud-object-storage-driver" successfully rolled out` in your CLI output. 
   
7. Verify that the {{site.data.keyword.cos_full_notm}} pods are in a `Running` state. 
   ```
   kubectl get pods -n kube-system -o wide | grep object-storage
   ```
   {: pre}
   
  
### Removing the IBM Cloud Object Storage plug-in
{: #remove_cos_plugin}

If you do not want to provision and use {{site.data.keyword.cos_full_notm}} in your cluster, you can uninstall the helm charts.

**Note:** Removing the plug-in does not remove existing PVCs, PVs, or data. When you remove the plug-in, all the related pods and daemon sets are removed from your cluster. You cannot provision new {{site.data.keyword.cos_full_notm}} for your cluster or use existing PVCs and PVs after you remove the plug-in, unless you configure your app to use the {{site.data.keyword.cos_full_notm}} API directly. 

Before you begin:

- [Target your CLI to the cluster](cs_cli_install.html#cs_cli_configure).
- Make sure that you do not have any PVCs or PVs in your cluster that use {{site.data.keyword.cos_full_notm}}. To list all pods that mount a specific PVC, run `kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"`. 

To remove the plug-in:

1. Find the installation name of your helm chart.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}
   
   Example output:
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}
   
2. Delete the {{site.data.keyword.cos_full_notm}} plug-in by removing the Helm chart.
   ```
   helm delete --purge <helm_chart_name>
   ```
   {: pre}
   
3. Verify that the {{site.data.keyword.cos_full_notm}} pods are removed.
   ```
   kubectl get pod -n kube-system | grep object-storage
   ```
   {: pre}
   
   The removal of the pods is successful if no pods are displayed in your CLI output.

4. Verify that the storage classes are removed.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}
   
   The removal of the storage classes is successful if no storage classes are displayed in your CLI output.
   
5. If you use macOS or a Linux distribution, remove the `ibmc` Helm plug-in. If you use Windows, this step is not required. 
   1. Remove the `ibmc` plug-in. 
      ```
      rm -rf ~/.helm/plugins/helm-ibmc
      ```
      {: pre}
   
   2. Verify that the `ibmc` plug-in is removed. 
      ```
      helm plugin list
      ```
      {: pre}
   
      Example output: 
     ```
     NAME	VERSION	DESCRIPTION
     ```
     {: screen}
   
     The `ibmc` plug-in is removed successfully if the `ibmc` plug-in is not listed in your CLI output. 

   
## Deciding on the object storage configuration
{: #configure_cos}

{{site.data.keyword.containerlong_notm}} provides pre-defined storage classes that you can use to create buckets with a specific configuration.

1. List available storage classes in {{site.data.keyword.containerlong_notm}}.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}
   
   Example output: 
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}
   
2. Choose a storage class that fits your data access requirements. The storage class determines the [pricing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) for storage capacity, read and write operations, and outbound bandwidth for a bucket. The option that is right for you is based on how frequently data is read and written to your service instance. 
   - **Standard**: This option is used for hot data that is accessed frequently. Common use cases are web or mobile apps. 
   - **Vault**: This option is used for workloads or cool data that are accessed infrequently, such as once a month or less. Common use cases are archives, short-term data retention, digital asset preservation, tape replacement, and disaster recovery. 
   - **Cold**: This option is used for cold data that is rarely accessed (every 90 days or less), or inactive data. Common use cases are archives, long-term backups, historical data that you keep for compliance, or workloads and apps that are rarely accessed. 
   - **Flex**: This option is used for workloads and data that do not follow a specific usage pattern, or that are too huge to determine or predict a usage pattern. **Tip:** Check out this [blog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/03/interconnect-2017-changing-rules-storage/) to learn how the Flex storage class works compared to traditional storage tiers.   
   
3. Decide on the level of resiliency for the data that is stored in your bucket. 
   - **Cross-region**: With this option, your data is stored across three regions within a geolocation for highest availability. If you have workloads that are distributed across regions, requests are routed to the nearest regional endpoint. The API endpoint for the geolocation is automatically set by the `ibmc` Helm plug-in that you installed earlier based on the location that your cluster is in. For example, if your cluster is in `US South`, then your storage classes are configured to use the `US GEO` API endpoint for your buckets. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information.  
   - **Regional**: With this option, your data is replicated across multiple zones within one region. If you have workloads that are located in the same region, you see lower latency and better performance than in a cross-regional setup. The regional endpoint is automatically set by the `ibm` Helm plug-in that you installed earlier based on the location that your cluster is in. For example, if your cluster is in `US South`, then your storage classes were configured to use `US South` as the regional endpoint for your buckets. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information.
   
4. Review the detailed {{site.data.keyword.cos_full_notm}} bucket configuration for a storage class. 
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}
   
   Example output: 
   ```
   Name:                  ibmc-s3fs-standard-cross-region
   IsDefaultClass:        No
   Annotations:           <none>
   Provisioner:           ibm.io/ibmc-s3fs
   Parameters:            ibm.io/chunk-size-mb=16,ibm.io/curl-debug=false,ibm.io/debug-level=warn,ibm.io/iam-endpoint=https://iam.bluemix.net,ibm.io/kernel-cache=true,ibm.io/multireq-max=20,ibm.io/object-store-endpoint=https://s3-api.dal-us-geo.objectstorage.service.networklayer.com,ibm.io/object-store-storage-class=us-standard,ibm.io/parallel-count=2,ibm.io/s3fs-fuse-retry-count=5,ibm.io/stat-cache-size=100000,ibm.io/tls-cipher-suite=AESGCM
   AllowVolumeExpansion:  <unset>
   MountOptions:          <none>
   ReclaimPolicy:         Delete
   VolumeBindingMode:     Immediate
   Events:                <none>
   ```
   {: screen}
   
   <table>
   <caption>Understanding the storage class details</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
   </thead>
   <tbody>
   <tr>
   <td><code>ibm.io/chunk-size-mb</code></td>
   <td>The size of a data chunk that is read from or written to {{site.data.keyword.cos_full_notm}} in megabytes. Storage classes with <code>perf</code> in their name are set up with 52 megabyte. Storage classes without <code>perf</code> in their name use 16 megabyte chunks. For example, if you want to read a file that is 1GB, the plug-in reads this file in multiple 16 or 52 megabyte chunks. </td>
   </tr>
   <tr>
   <td><code>ibm.io/curl-debug</code></td>
   <td>Enable the logging of requests that are sent to the {{site.data.keyword.cos_full_notm}} service instance. If enabled, logs are sent to `syslog` and you can [forward the logs to an external logging server](cs_health.html#logging). By default, all storage classes are set to <strong>false</strong> to disable this logging feature. </td>
   </tr>
   <tr>
   <td><code>ibm.io/debug-level</code></td>
   <td>The logging level that is set by the {{site.data.keyword.cos_full_notm}} plug-in. All storage classes are set up with the <strong>WARN</strong> logging level. </td>
   </tr>
   <tr>
   <td><code>ibm.io/iam-endpoint</code></td>
   <td>The API endpoint for Identity and Access Management (IAM). </td>
   </tr>
   <tr>
   <td><code>ibm.io/kernel-cache</code></td>
   <td>Enable or disable the kernel buffer cache for the volume mount point. If enabled, data that is read from {{site.data.keyword.cos_full_notm}} is stored in the kernel cache to ensure fast read access to your data. If disabled, data is not cached and always read from {{site.data.keyword.cos_full_notm}}. Kernel cache is enabled for <code>standard</code> and <code>flex</code> storage classes, and disabled for <code>cold</code> and <code>vault</code> storage classes. </td>
   </tr>
   <tr>
   <td><code>ibm.io/multireq-max</code></td>
   <td>The maximum number of parallel requests that can be sent to the {{site.data.keyword.cos_full_notm}} service instance to list files in a single directory. All storage classes are set up with a maximum of 20 parallel requests.  </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-endpoint</code></td>
   <td>The API endpoint to use to access the bucket in your {{site.data.keyword.cos_full_notm}} service instance. The endpoint is automatically set based on the region of your cluster. </br></br><strong>Note: </strong> If you want to access an existing bucket that is located in a different region than the one where your cluster is in, you must create a [custom storage class](cs_storage_basics.html#customized_storageclass) and use the API endpoint for your bucket. </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-storage-class</code></td>
   <td>The name of the storage class. </td>
   </tr>
   <tr>
   <td><code>ibm.io/parallel-count</code></td>
   <td>The maximum number of parallel requests that can be sent to the {{site.data.keyword.cos_full_notm}} service instance for a single read or write operation. Storage classes with <code>perf</code> in their name are set up with a maximum of 20 parallel requests. Storage classes without <code>perf</code> are set up with 2 parallel requests by default.  </td>
   </tr>
   <tr>
   <td><code>ibm.io/s3fs-fuse-retry-count</code></td>
   <td>The maximum number of retries for a read or write operation before the operation is considered unsuccessful. All storage classes are set up with a maximum of 5 retries.  </td>
   </tr>
   <tr>
   <td><code>ibm.io/stat-cache-size</code></td>
   <td>The maximum number of records that are kept in the {{site.data.keyword.cos_full_notm}} metadata cache. Every record can take up to 0.5 kilobytes. All storage classes set the maximum number of records to 100000 by default. </td>
   </tr>
   <tr>
   <td><code>ibm.io/tls-cipher-suite</code></td>
   <td>The TLS cipher suite that must be used when a connection to {{site.data.keyword.cos_full_notm}} is established via the HTTPS endpoint. The value for the cipher suite must follow the [OpenSSL format ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html). All storage classes use the <strong>AESGCM</strong> cipher suite by default.  </td>
   </tr>
   </tbody>
   </table>
   
   For more information about each storage class, see the [storage class reference](#storageclass_reference). If you want to change any of the pre-set values, create your own [customized storage class](cs_storage_basics.html#customized_storageclass). 
   {: tip}
   
5. Decide on a name for your bucket. The name of a bucket must be unique in {{site.data.keyword.cos_full_notm}}. You can also choose to automatically create a name for your bucket by the {{site.data.keyword.cos_full_notm}} plug-in. To organize data in a bucket, you can create subdirectories. 

   **Note:** The storage class that you chose earlier determines the pricing for the entire bucket. You cannot define different storage classes for subdirectories. If you want to store data with different access requirements, consider creating multiple buckets by using multiple PVCs. 
   
6. Choose if you want to keep your data and the bucket after the cluster or the persistent volume claim (PVC) is deleted. When you delete the PVC, the PV is always deleted. You can choose if you want to also automatically delete the data and the bucket when you delete the PVC. Your {{site.data.keyword.cos_full_notm}} service instance is independent from the retention policy that you select for your data and is never removed when you delete a PVC.

Now that you decided on the configuration that you want, you are ready to [create a PVC](#add_cos) to provision {{site.data.keyword.cos_full_notm}}. 

## Adding object storage to apps
{: #add_cos}

Create a persistent volume claim (PVC) to provision {{site.data.keyword.cos_full_notm}} for your cluster. 
{: shortdesc}

Depending on the settings that you choose in your PVC, you can provision {{site.data.keyword.cos_full_notm}} in the following ways: 
- [Dynamic provisioning](cs_storage_basics.html#dynamic_provisioning): When you create the PVC, the matching persistent volume (PV) and the bucket in your {{site.data.keyword.cos_full_notm}} service instance are automatically created. 
- [Static provisioning](cs_storage_basics.html#static_provisioning): You can reference an existing bucket in your {{site.data.keyword.cos_full_notm}} service instance in your PVC. When you create the PVC, only the matching PV is automatically created and linked to your existing bucket in {{site.data.keyword.cos_full_notm}}.

Before you begin: 
- [Create and prepare your {{site.data.keyword.cos_full_notm}} service instance](#create_cos_service).
- [Create a secret to store your {{site.data.keyword.cos_full_notm}} service credentials](#create_cos_secret).
- [Decide on the configuration for your {{site.data.keyword.cos_full_notm}}](#configure_cos).

To add {{site.data.keyword.cos_full_notm}} to your cluster: 

1. Create a configuration file to define your persistent volume claim (PVC).
   ```
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <pvc_name>
     namespace: <namespace>
     annotations:
       volume.beta.kubernetes.io/storage-class: "<storage_class>"
       ibm.io/auto-create-bucket: "<true_or_false>"
       ibm.io/auto-delete-bucket: "<true_or_false>"
       ibm.io/bucket: "<bucket_name>"
       ibm.io/object-path: "<bucket_subdirectory>" 
       ibm.io/secret-name: "<secret_name>"
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 8Gi # Enter a fictitious value
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
   <td>Enter the name of the PVC.</td>
   </tr>
   <tr>
   <td><code>metadata.namespace</code></td>
   <td>Enter the namespace where you want to create the PVC. The PVC must be created in the same namespace where you created the Kubernetes secret for your {{site.data.keyword.cos_full_notm}} service credentials and where you want to run your pod. </td>
   </tr>
   <tr>
   <td><code>volume.beta.kubernetes.io/storage-class</code></td>
   <td>Choose between the following options: <ul><li>If <code>ibm.io/auto-create-bucket</code> is set to <strong>true</strong>: Enter the storage class that you want to use for your new bucket. </li><li>If <code>ibm.io/auto-create-bucket</code> is set to <strong>false</strong>: Enter the storage class that you used to create your existing bucket. </br></br>If you manually created the bucket in your {{site.data.keyword.cos_full_notm}} service instance or you cannot remember the storage class that you used, find your service instance in the {{site.data.keyword.Bluemix}} dashboard and review the <strong>Class</strong> and <strong>Location</strong> of your existing bucket. Then, use the appropriate [storage class](#storageclass_reference). </br></br><strong>Note: </strong> The {{site.data.keyword.cos_full_notm}} API endpoint that is set in your storage class is based on the region that your cluster is in. If you want to access a bucket that is located in a different region than the one where your cluster is in, you must create a [custom storage class](cs_storage_basics.html#customized_storageclass) and use the appropriate API endpoint for your bucket. </li></ul>  </td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-create-bucket</code></td>
   <td>Choose between the following options: <ul><li><strong>true</strong>: When you create the PVC, the PV and the bucket in your {{site.data.keyword.cos_full_notm}} service instance are automatically created. Choose this option to create a new bucket in your {{site.data.keyword.cos_full_notm}} service instance. </li><li><strong>false</strong>: Choose this option if you want to access data in an existing bucket. When you create the PVC, the PV is automatically created and linked to the bucket that you specify in <code>ibm.io/bucket</code>.</td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-delete-bucket</code></td>
   <td>Choose between the following options: <ul><li><strong>true</strong>: Your data, the bucket, and the PV is automatically removed when you delete the PVC. Your {{site.data.keyword.cos_full_notm}} service instance remains and is not deleted. If you choose to set this option to <strong>true</strong>, then you must set <code>ibm.io/auto-create-bucket: true</code> and <code>ibm.io/bucket: ""</code> so that your bucket is automatically created with a name with the format <code>tmp-s3fs-xxxx</code>. </li><li><strong>false</strong>: When you delete the PVC, the PV is deleted automatically, but your data and the bucket in your {{site.data.keyword.cos_full_notm}} service instance remain. To access your data, you must create a new PVC with the name of your existing bucket. </li></ul> 
   <tr>
   <td><code>ibm.io/bucket</code></td>
   <td>Choose between the following options: <ul><li>If <code>ibm.io/auto-create-bucket</code> is set to <strong>true</strong>: Enter the name of the bucket that you want to create in {{site.data.keyword.cos_full_notm}}. If in addition <code>ibm.io/auto-delete-bucket</code> is set to <strong>true</strong>, you must leave this field blank to automatically assign your bucket a name with the format <code>tmp-s3fs-xxxx</code>. The name must be unique in {{site.data.keyword.cos_full_notm}}. </li><li>If <code>ibm.io/auto-create-bucket</code> is set to <strong>false</strong>: Enter the name of the existing bucket that you want to access in the cluster. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-path</code></td>
   <td>Optional: Enter the name of the existing subdirectory in your bucket that you want to mount. Use this option if you want to mount a subdirectory only and not the entire bucket. To mount a subdirectory, you must set <code>ibm.io/auto-create-bucket: "false"</code> and provide the name of the bucket in <code>ibm.io/bucket</code>. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/secret-name</code></td>
   <td>Enter the name of the secret that holds the {{site.data.keyword.cos_full_notm}} credentials that you created earlier. </td>
   </tr>
   <tr>
   <td><code>resources.requests.storage</code></td>
   <td>A fictitious size for your {{site.data.keyword.cos_full_notm}} bucket in gigabytes. The size is required by Kubernetes, but not respected in {{site.data.keyword.cos_full_notm}}. You can enter any size that you want. The actual space that you use in {{site.data.keyword.cos_full_notm}} might be different and is billed based on the [pricing table ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api). </td>
   </tr>
   </tbody>
   </table>

2. Create the PVC. 
   ```
   kubectl apply -f filepath/pvc.yaml
   ```
   {: pre}
   
3. Verify that your PVC is created and bound to the PV. 
   ```
   kubectl get pvc
   ```
   {: pre}
   
   Example output: 
   ```
   NAME                  STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                     AGE
   s3fs-test-pvc         Bound     pvc-b38b30f9-1234-11e8-ad2b-t910456jbe12   8Gi        RWO            ibmc-s3fs-standard-cross-region  1h
   ```
   {: screen}
   
4. Optional: If you plan to access your data with a non-root user, or added files to an existing {{site.data.keyword.cos_full_notm}} bucket by using the GUI or the API directly, make sure that the [files have the correct permission](cs_troubleshoot_storage.html#cos_nonroot_access) assigned so that your app can successfully read and update the files as needed. 
   
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
            securityContext:
              runAsUser: <non_root_user>
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
    <td>A label for the deployment.</td>
      </tr>
      <tr>
        <td><code>spec.selector.matchLabels.app</code> <br/> <code>spec.template.metadata.labels.app</code></td>
        <td>A label for your app.</td>
      </tr>
    <tr>
    <td><code>template.metadata.labels.app</code></td>
    <td>A label for the deployment.</td>
      </tr>
    <tr>
    <td><code>spec.containers.image</code></td>
    <td>The name of the image that you want to use. To list available images in your {{site.data.keyword.registryshort_notm}} account, run `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec.containers.name</code></td>
    <td>The name of the container that you want to deploy to your cluster.</td>
    </tr>
    <tr>
    <td><code>spec.containers.securityContext.runAsUser</code></td>
    <td>Optional: To run the app with a non-root user, specify the [security context ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for your pod by defining the non-root user without setting the `fsGroup` in your deployment YAML at the same time. Setting `fsGroup` triggers the {{site.data.keyword.cos_full_notm}} plug-in to update the group permissions for all files in a bucket when the pod is deployed. Updating the permissions is a write operation and impacts performance. Depending on how many files you have, updating the permissions might prevent your pod from coming up and getting into a <code>Running</code> state. </td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.mountPath</code></td>
    <td>The absolute path of the directory to where the volume is mounted inside the container.</td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.name</code></td>
    <td>The name of the volume to mount to your pod.</td>
    </tr>
    <tr>
    <td><code>volumes.name</code></td>
    <td>The name of the volume to mount to your pod. Typically this name is the same as <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes.persistentVolumeClaim.claimName</code></td>
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
     
7. Verify that you can write data to your {{site.data.keyword.cos_full_notm}} service instance. 
   1. Log in to the pod that mounts your PV. 
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}
       
   2. Navigate to your volume mount path that you defined in your app deployment. 
   3. Create a text file. 
      ```
      echo "This is a test" > test.txt 
      ```
      {: pre}
       
   4. From the {{site.data.keyword.Bluemix}} dashboard, navigate to your {{site.data.keyword.cos_full_notm}} service instance. 
   5. From the menu, select **Buckets**. 
   6. Open your bucket, and verify that you can see the `test.txt` that you created. 
   

## Using object storage in a stateful set
{: #cos_statefulset}

If you have a stateful app such as a database, you can create stateful sets that use {{site.data.keyword.cos_full_notm}} to store your app's data. Alternatively, you can use an {{site.data.keyword.Bluemix_notm}} database-as-a-service, such as {{site.data.keyword.cloudant_short_notm}} and store your data in the cloud.

Before you begin: 
- [Create and prepare your {{site.data.keyword.cos_full_notm}} service instance](#create_cos_service).
- [Create a secret to store your {{site.data.keyword.cos_full_notm}} service credentials](#create_cos_secret).
- [Decide on the configuration for your {{site.data.keyword.cos_full_notm}}](#configure_cos).

To deploy a stateful set that uses object storage:

1. Create a configuration file for your stateful set and the service that you use to expose the stateful set. The following examples show how to deploy nginx as a stateful set with 3 replicas with each replica using a separate bucket, or with all replicas sharing the same bucket.

   **Example to create a stateful set with 3 replicas, with each replica using a separate bucket**: 
   ```
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx-v01
     namespace: default
     labels:
       app: nginx-v01 # must match spec.template.metadata.labels and spec.selector.matchLabels in stateful set YAML
   spec:
     ports:
     - port: 80
       name: web
     clusterIP: None
     selector:
       app: nginx-v01 # must match spec.template.metadata.labels and spec.selector.matchLabels in stateful set YAML
   ---
   apiVersion: apps/v1
   kind: StatefulSet
   metadata:
     name: web-v01
     namespace: default
   spec:
     selector:
       matchLabels:
         app: nginx-v01 # must match spec.template.metadata.labels in stateful set YAML and metadata.labels in service YAML
     serviceName: "nginx-v01"
     replicas: 3 
     template:
       metadata:
         labels:
           app: nginx-v01 # must match spec.selector.matchLabels in stateful set YAML and metadata.labels in service YAML
       spec:
         terminationGracePeriodSeconds: 10
         containers:
         - name: nginx
           image: k8s.gcr.io/nginx-slim:0.8
           ports:
           - containerPort: 80
             name: web
           volumeMounts:
           - name: mypvc
             mountPath: /usr/share/nginx/html
     volumeClaimTemplates:
     - metadata:
         name: mypvc
         annotations:
           ibm.io/auto-create-bucket: "true"
           ibm.io/auto-delete-bucket: "true"
           ibm.io/bucket: ""
           ibm.io/secret-name: mysecret 
           volume.beta.kubernetes.io/storage-class: ibmc-s3fs-standard-perf-cross-region 
           volume.beta.kubernetes.io/storage-provisioner: ibm.io/ibmc-s3fs
       spec:
         accessModes: [ "ReadWriteOnce" ]
         storageClassName: "ibmc-s3fs-standard-perf-cross-region"
         resources:
           requests:
             storage: 1Gi
   ```
   {: codeblock}

   **Example to create a stateful set with 3 replicas that all share the same bucket `mybucket`**: 
   ```
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx-v01
     namespace: default
     labels:
       app: nginx-v01 # must match spec.template.metadata.labels and spec.selector.matchLabels in stateful set YAML
   spec:
     ports:
     - port: 80
       name: web
     clusterIP: None
     selector:
       app: nginx-v01 # must match spec.template.metadata.labels and spec.selector.matchLabels in stateful set YAML
   --- 
   apiVersion: apps/v1
   kind: StatefulSet
   metadata:
     name: web-v01
     namespace: default
   spec:
     selector:
       matchLabels:
         app: nginx-v01 # must match spec.template.metadata.labels in stateful set YAML and metadata.labels in service YAML
     serviceName: "nginx-v01"
     replicas: 3 
     template:
       metadata:
         labels:
           app: nginx-v01 # must match spec.selector.matchLabels in stateful set YAML and metadata.labels in service YAML
       spec:
         terminationGracePeriodSeconds: 10
         containers:
         - name: nginx
           image: k8s.gcr.io/nginx-slim:0.8
           ports:
           - containerPort: 80
             name: web
           volumeMounts:
           - name: mypvc
             mountPath: /usr/share/nginx/html
     volumeClaimTemplates:
     - metadata:
         name: mypvc
         annotations:
           ibm.io/auto-create-bucket: "false"
           ibm.io/auto-delete-bucket: "false"
           ibm.io/bucket: mybucket
           ibm.io/secret-name: mysecret
           volume.beta.kubernetes.io/storage-class: ibmc-s3fs-standard-perf-cross-region 
           volume.beta.kubernetes.io/storage-provisioner: ibm.io/ibmc-s3fs
       spec:
         accessModes: [ "ReadOnlyMany" ]
         storageClassName: "ibmc-s3fs-standard-perf-cross-region"
         resources:
           requests:
             storage: 1Gi
   ```
   {: codeblock}
   
   
   <table>
    <caption>Understanding the stateful set YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the stateful set YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td style="text-align:left"><code>metadata.name</code></td>
    <td style="text-align:left">Enter a name for your stateful set. The name that you enter is used to create the name for your PVC in the format: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.serviceName</code></td>
    <td style="text-align:left">Enter the name of the service that you want to use to expose your stateful set. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.replicas</code></td>
    <td style="text-align:left">Enter the number of replicas for your stateful set. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.selector.matchLabels</code></td>
    <td style="text-align:left">Enter all labels that you want to include in your stateful set and your PVC. Labels that you include in the <code>volumeClaimTemplates</code> of your stateful set are not recognized by Kubernetes. Instead, you must define these labels in the <code>spec.selector.matchLabels</code> and <code>spec.template.metadata.labels</code> section of your stateful set YAML. To make sure that all your stateful set replicas are included into the load balancing of your service, include the same label that you used in the <code>spec.selector</code> section of your service YAML. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.template.metadata.labels</code></td>
    <td style="text-align:left">Enter the same labels that you added to the <code>spec.selector.matchLabels</code> section of your stateful set YAML. </td>
    </tr>
    <tr>
    <td><code>spec.template.spec.</code></br><code>terminationGracePeriodSeconds</code></td>
    <td>Enter the number of seconds to give the <code>kubelet</code> to gracefully terminate the pod that runs your stateful set replica. For more information, see [Delete Pods ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/run-application/force-delete-stateful-set-pod/#delete-pods). </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.</code></br><code>metadata.name</code></td>
    <td style="text-align:left">Enter a name for your volume. Use the same name that you defined in the <code>spec.containers.volumeMount.name</code> section. The name that you enter here is used to create the name for your PVC in the format: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>. </td>
    </tr>
    <tr>
    <td><code>spec.volumeClaimTemplates.metadata</code></br><code>annotions.ibm.io/auto-create-bucket</code></td>
    <td>Choose between the following options: <ul><li><strong>true: </strong>Choose this option to automatically create a bucket for each stateful set replica. </li><li><strong>false: </strong>Choose this option if you want to share an existing bucket across your stateful set replicas. Make sure to define the name of the bucket in the <code>spec.volumeClaimTemplates.metadata.annotions.ibm.io/bucket</code> section of your stateful set YAML.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec.volumeClaimTemplates.metadata</code></br><code>annotions.ibm.io/auto-delete-bucket</code></td>
    <td>Choose between the following options: <ul><li><strong>true: </strong>Your data, the bucket, and the PV is automatically removed when you delete the PVC. Your {{site.data.keyword.cos_full_notm}} service instance remains and is not deleted. If you choose to set this option to true, then you must set <code>ibm.io/auto-create-bucket: true</code> and <code>ibm.io/bucket: ""</code> so that your bucket is automatically created with a name with the format <code>tmp-s3fs-xxxx</code>. </li><li><strong>false: </strong>When you delete the PVC, the PV is deleted automatically, but your data and the bucket in your {{site.data.keyword.cos_full_notm}} service instance remain. To access your data, you must create a new PVC with the name of your existing bucket.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec.volumeClaimTemplates.metadata</code></br><code>annotions.ibm.io/bucket</code></td>
    <td>Choose between the following options: <ul><li><strong>If <code>ibm.io/auto-create-bucket</code> is set to true: </strong>Enter the name of the bucket that you want to create in {{site.data.keyword.cos_full_notm}}. If in addition <code>ibm.io/auto-delete-bucket</code> is set to <strong>true</strong>, you must leave this field blank to automatically assign your bucket a name with the format tmp-s3fs-xxxx. The name must be unique in {{site.data.keyword.cos_full_notm}}.</li><li><strong>If <code>ibm.io/auto-create-bucket</code> is set to false: </strong>Enter the name of the existing bucket that you want to access in the cluster.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec.volumeClaimTemplates.metadata</code></br><code>annotions.ibm.io/secret-name</code></td>
    <td>Enter the name of the secret that holds the {{site.data.keyword.cos_full_notm}} credentials that you created earlier.</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.metadata.</code></br><code>annotations.volume.beta.</code></br><code>kubernetes.io/storage-class</code></td>
    <td style="text-align:left">Enter the storage class that you want to use. Choose between the following options: <ul><li><strong>If <code>ibm.io/auto-create-bucket</code> is set to true: </strong>Enter the storage class that you want to use for your new bucket.</li><li><strong>If <code>ibm.io/auto-create-bucket</code> is set to false: </strong>Enter the storage class that you used to create your existing bucket. </li></ul></br>  To list existing storage classes, run <code>kubectl get storageclasses | grep s3</code>. If you do not specify a storage class, the PVC is created with the default storage class that is set in your cluster. Make sure that the default storage class uses the <code>ibm.io/ibmc-s3fs</code> provisioner so that your stateful set is provisioned with object storage.</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.</code></br><code>spec.storageClassName</code></td>
    <td>Enter the same storage class that you entered in the <code>spec.volumeClaimTemplates.metadata.annotations.volume.beta.kubernetes.io/storage-class</code> section of your stateful set YAML.  </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.spec.</code></br><code>resource.requests.storage</code></td>
    <td>Enter a fictitious size for your {{site.data.keyword.cos_full_notm}} bucket in gigabytes. The size is required by Kubernetes, but not respected in {{site.data.keyword.cos_full_notm}}. You can enter any size that you want. The actual space that you use in {{site.data.keyword.cos_full_notm}} might be different and is billed based on the [pricing table ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api).</td>
    </tr>
    </tbody></table>

    
## Backing up and restoring data
{: #backup_restore}

{{site.data.keyword.cos_full_notm}} is set up to provide high durability for your data so that your data is protected from being lost. You can find the SLA in the [{{site.data.keyword.cos_full_notm}} service terms ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-7857-03).
{: shortdesc}

**Important:** {{site.data.keyword.cos_full_notm}} does not provide a version history for your data. If you need to maintain and access older versions of your data, you must set up your app to manage the history of data or implement alternative backup solutions. For example, you might want to store your {{site.data.keyword.cos_full_notm}} data in your on-prem database or use tapes to archive your data. 

## Storage class reference
{: #storageclass_reference}

### Standard
{: #standard}

<table>
<caption>Object storage class: standard</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-s3fs-standard-cross-region</code></br><code>ibmc-s3fs-standard-perf-cross-region</code></br><code>ibmc-s3fs-standard-regional</code></br><code>ibmc-s3fs-standard-perf-regional</code></td>
</tr>
<tr>
<td>Default resiliency endpoint</td>
<td>The resiliency endpoint is automatically set based on the location that your cluster is in. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information. </td>
</tr>
<tr>
<td>Chunk size</td>
<td>Storage classes without `perf`: 16 MB</br>Storage classes with `perf`: 52 MB</td>
</tr>
<tr>
<td>Kernel cache</td>
<td>Enabled</td>
</tr>
<tr>
<td>Billing</td>
<td>Monthly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Vault
{: #Vault}

<table>
<caption>Object storage class: vault</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-s3fs-vault-cross-region</code></br><code>ibmc-s3fs-vault-regional</code></td>
</tr>
<tr>
<td>Default resiliency endpoint</td>
<td>The resiliency endpoint is automatically set based on the location that your cluster is in. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information. </td>
</tr>
<tr>
<td>Chunk size</td>
<td>16 MB</td>
</tr>
<tr>
<td>Kernel cache</td>
<td>Disabled</td>
</tr>
<tr>
<td>Billing</td>
<td>Monthly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Cold
{: #cold}

<table>
<caption>Object storage class: cold</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-s3fs-flex-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-flex-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Default resiliency endpoint</td>
<td>The resiliency endpoint is automatically set based on the location that your cluster is in. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information. </td>
</tr>
<tr>
<td>Chunk size</td>
<td>16 MB</td>
</tr>
<tr>
<td>Kernel cache</td>
<td>Disabled</td>
</tr>
<tr>
<td>Billing</td>
<td>Monthly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Flex
{: #flex}

<table>
<caption>Object storage class: flex</caption>
<thead>
<th>Characteristics</th>
<th>Setting</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-s3fs-cold-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-cold-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Default resiliency endpoint</td>
<td>The resiliency endpoint is automatically set based on the location that your cluster is in. See [Regions and endpoints](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) for more information. </td>
</tr>
<tr>
<td>Chunk size</td>
<td>Storage classes without `perf`: 16 MB</br>Storage classes with `perf`: 52 MB</td>
</tr>
<tr>
<td>Kernel cache</td>
<td>Enabled</td>
</tr>
<tr>
<td>Billing</td>
<td>Monthly</td>
</tr>
<tr>
<td>Pricing</td>
<td>[Pricing ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>
