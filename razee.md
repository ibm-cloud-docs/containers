# Automating and Monitoring app deployments with Razee

## Overview of Razee visibility components
You can visualize deployment information for your Kubernetes resources across locations and environments by using the Razee visibility package. The Razee visibility package provides five components that are deployed to your cluster and that help 

### Watch Keeper

The Watch Keeper retrieves configuration information for Kubernetes resources that are deployed in your cluster. To monitor a resource, you must add the `razee/watch-resource` label to your Kubernetes resource definition. You can decide what information you want the Watch Keeper to retrieve by choosing between the following information detail levels: 
- `Lite`: Retrieves the `metadata` and `status` section of your Kubernetes resource configuration. 
- `Detail`: Retrieves all configuration data of a Kubernetes resource, but leaves out environment variables and the `data` section of config maps and secrets.
- `Debug`: Retrieves all configuration data of a Kubernetes resource, including environment variables and the `data` section of config maps and secrets. 

After you add the label, data is immediately sent to the Razeedash API based on the detail level that you chose. Then, your resource is scanned once every hour. In addition, the Watch Keeper adds a Kubernetes event watcher to your resource so that the Watch Keeper is notified by Kubernetes when the configuration of your resource changes. 

### Razeedash API

The Razeedash API is a service that is set up in your cluster and that receives Kubernetes resource configurations and resource definitions from the Watch Keeper. Data that is sent to the Razeedash API are automatically stored in a MongoDB that is included in your Razee visibility package. 

### MiniMongo

MiniMongo is a MongoDB database deployment that is included in the Razee visbility package and that is deployed as a stateful set in your cluster. Data that is stored in a PVC is stored on the worker node's secondary local disk and is deleted when you remove the cluster. 

You can choose to use your own MongoDB deployment or use an IBM Cloud service, such as [Databases for MongoDB](https://cloud.ibm.com/docs/services/databases-for-mongodb?topic=databases-for-mongodb-about). 

### Razeedash

Razeedash is the Razeedash console that you can use to access and visualize the data that is retrieved for your Kubernetes resources.


## Visualizing deployment information with Razee 

1. Deploy the Razee visibility package in your cluster. The package includes the Kubernetes deployment and related Kubernetes resources for the Watch Keeper, Razeedash API, miniMongo, and the Razeedash console.  
   ```
   kubectl apply -f ???
   ```
   
2. Verify that the components of the Razee visibility package are successfully set up in your cluster. 
   ```
   kubectl get pods -n razee | grep ???
   ```
   
3. Add the `razee/watch-resource` label to the **labels** section of all Kubernetes resources that you want to monitor. For example, if you want to monitor a Kubernetes deployment, use the following command. After you add the label to your deployment, the Watch Keeper automatically scans your resource and sends data to the Razeedash API. Then, your resource is scanned once every hour. In addition, the Watch Keeper adds a Kubernetes event watcher to your resource so that the Watch Keeper is notified by Kubernetes when the configuration of your resource changes. 
   ```
   kubectl edit deployment <deployment_name>
   ```
   
   Example YAML file: 
   ```
   apiVersion: extensions/v1beta1
   kind: Deployment
   metadata:
     annotations:
       deployment.kubernetes.io/revision: "1"
       kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"myapp"},"name":"expandpvc","namespace":"default"},"spec":{"selector":{"matchLabels":{"app":"myapp"}},"template":{"metadata":{"labels":{"app":"myapp"}},"spec":{"containers":[{"image":"nginx","name":"expandpvc","volumeMounts":[{"mountPath":"/test","name":"myvol"}]}],"volumes":[{"name":"myvol","persistentVolumeClaim":{"claimName":"expandpvc"}}]}}}}
     creationTimestamp: "2019-04-30T15:31:24Z"
     generation: 1
     labels:
       app: myapp
       razee/watch-resource: "Lite"
   ...
   ```

4. Open the Razeedash console to ???


## Using Razeedash to find deployment issues


## Using your own MongoDB deployment with Razee

tbd


# Automating deployments to multiple clusters, environments, and clouds with Razee 

## Overview of Razee deployment components

### Remote Resource

The Remote Resource is a custom Kubernetes resource definition that you can use to define an external source where the Kubernetes YAML files are stored that you want to deploy to your cluster. Rather than manually applying these YAML files in each cluster, environment, or across cloud providers every time an update is made, you can define the location of your YAML file and let Razee automatically download and apply the YAML file in each cluster.  

Kubernetes 


### Step 1: Setting up the Razee deployment components in your cluster

1. Create the custom Kubernetes resource definitions, the `razee` namespace, service accounts, config maps, RBAC roles and role bindings, and deploy the components of the Razee deployment package.
   ```
   kubectl apply -f https://github.com/razee-io/kapitan-delta/releases/download/0.0.5/resource.yaml
   ```
   
   Example output: 
   ```
   namespace/razee created
   serviceaccount/kapitan-sa created
   clusterrole.rbac.authorization.k8s.io/cluster-admin configured
   clusterrolebinding.rbac.authorization.k8s.io/kapitan-rb created
   configmap/kapitan-delta-resource-uris created
   deployment.apps/kapitan-delta created
   ```
   
2. Verify that the components of the Razee deployment package are deployed successfully. You must see one pod per component and each pod must be in a `Running` state. 
   ```
   kubectl get pods -n razee
   ```
      
   Example output: 
   ```
   NAME                                           READY   STATUS    RESTARTS   AGE
   featureflagsetld-controller-d544fbbcf-nb7x8    1/1     Running   0          24h
   kapitan-delta-5945ddd8bf-nm5vt                 1/1     Running   0          24h
   managedset-controller-766cc6d596-fgrs8         1/1     Running   0          24h
   mustachetemplate-controller-5d579bb846-dcn2c   1/1     Running   0          24h
   remoteresources3-controller-69d4f5f7d-bxngs    1/1     Running   0          24h
   ```
   
### Step 2: Using a remote resource to specify your YAML file's source repository

1. Create a remote resource and include the information of the remote location where your YAML files are stored. You can create one remote resource for your cluster, or use one remote resource per Kubernetes namespace, for example if you use namespaces to separate teams, or environments. If the YAML file that is stored in your remote location does not specify a namespace, the resource is automatically deployed in the same namespace as your remote resource. 

   **Example for using an IBM Cloud Object Storage service instance**: 

   ```
   apiVersion: "kapitan.razee.io/v1alpha1"
   kind: RemoteResourceS3
   metadata:
     name: <remote_resource_name>
     namespace: <namespace>
   spec:
     auth:
       hmac:
         access_key_id: <cos_access_key_ID>
         secret_access_key: <cos_secret_access_key>
     requests:
       - options:
           url: https://<cos_bucket_public_url>/<bucket_name>/<file_name>
   ```
   
   **Example for using a URL**: 
   
   <table>
   <thead>
   </thead>
   <tbody>
   </tbody>
   </thead>
   </table>
   
   
2. Create your remote resource in the cluster. 
   ```
   kubectl apply -f remoteresource.yaml
   ```
   
3. Verify that the remote resource is created successfully. After the remote resource is created, the remote resource establishes a connection to the remote location, downloads the specified file, and applies the file to the cluster. Then, the remote resource waits to be reinforced by Kubernetes to start this process all over again.

   **Remote Resource**: 
   ```
   kubectl describe rrs <remote_resource_name> -n <namespace>
   ```

   **Remote Resource S3**: 
   ```
   kubectl describe rrs3 <remote_resource_name> -n <namespace>
   ```
   
   Example output: 
   ```
   Name:         mys3remoteresource
   Namespace:    razee
   Labels:       <none>
   Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"kapitan.razee.io/v1alpha1","kind":"RemoteResourceS3","metadata":{"annotations":{},"name":"mys3remoteresource","namespace":"...
   API Version:  kapitan.razee.io/v1alpha1
   Kind:         RemoteResourceS3
   Metadata:
     Creation Timestamp:  2019-05-14T18:47:26Z
     Finalizers:
       children.downloads.kapitan.razee.io
     Generation:        1
     Resource Version:  37572078
     Self Link:         /apis/kapitan.razee.io/v1alpha1/namespaces/razee/remoteresourcess3/mys3remoteresource
     UID:               b81caa1f-7678-11e9-8e55-26f9979820ea
   Spec:
     Auth:
       Hmac:
         Access Key Id:      <cos_access_key_ID>
         Secret Access Key:  <cos_secret_access_key:>
     Requests:
       Options:
         URL:  <cos_url_to_file>
   Status:
     Children:
       / Apis / Apps / V 1 / Namespaces / Razee / Deployments / Perfpvc:
      Kapitan . Razee . Io / Reconcile:  true
   Events:                                  <none>
   ```
   
4. Verify that the Kubernetes resource is created or updated. For example to verify a deployment, run the following command. 
   ```
   kubectl describe deployment <deployment_name> -n <namespace>
   ```
   
5. Change the configuration of your YAML file. For example, if you have a deployment, you can change or add a label to the `metadata` section of your YAML file. 

6. Wait about 2 minutes for the change to be applied to your Kubernetes resource. Then, verify that your Kubernetes resource is updated. 
   ```
   kubectl describe deployment <deployment_name> -n <namespace>
   ```
   
7. Optional: To remove a Kubernetes resource, remove the source repository's URL where your YAML file is stored from the remote resource. 
  
### Step 3: Managing multiple versions of your YAML file with a mustach template

1. 
   ```
   apiVersion: "kapitan.razee.io/v1alpha1"
   kind: MustacheTemplate
   metadata:
     name: demo-mustachetemplate
     namespace: razee
   spec:
     env:
     - name: sample-app-version
       value: "3.0"
     templates:
     - apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         labels:
           billingType: "monthly"
           region: us-south
           zone: dal13
           razeetest: "{{sample-app-version}}"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
         storageClassName: ibmc-file-silver
   ```




