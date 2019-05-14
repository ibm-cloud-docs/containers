# Automating and Monitoring app deployments with Razee

## Overview of Razee visibility components
You can visualize deployment information for your Kubernetes resources across locations and environments by using the Razee visibility package. 

### Watch Keeper

The Watch Keeper retrieves configuration information for Kubernetes resources that are deployed in your cluster. To monitor a resource, you must add the `razee/watch-resource` label to your Kubernetes resource definition. You can decide what information you want the Watch Keeper to retrieve by choosing between the following information detail levels: 
- `Lite`: 
- `Detail`: 
- `Debug`: 

After you add the label, data is immediately sent to the Razeedash API based on the detail level that you chose. Then, your resource is scanned once every hour. In addition, the Watch Keeper adds a Kubernetes event watcher to your resource so that the Watch Keeper is notified by Kubernetes when the configuration of your resource changes. 

### Razeedash API

The Razeedash API is a service that is set up in your cluster and that receives Kubernetes resource configurations and resource definitions from the Watch Keeper. Data that is sent to the Razeedash API are automatically stored in a MongoDB that is included in your Razee visibility package. 

### MiniMongo

MiniMongo is a MongoDB database deployment that is included in the Razee visbility package and that is deployed as a stateful set in your cluster. Data that is stored in a PVC is stored on the worker node's secondary local disk and is deleted when you remove the cluster. 

You can choose to use your own MongoDB deployment or use an IBM Cloud service, such as [Databases for MongoDB](https://cloud.ibm.com/docs/services/databases-for-mongodb?topic=databases-for-mongodb-about). 

### Razeedash

Razeedash is the Razeedash console that you can use to access and visualize the data that is retrieved for your Kubernetes resources.


## Visualizing deployment information with Razee 

1. Deploy the Razee Watch Keeper, Razeedash API, and Razeedash dashboard in your cluster. 
   ```
   kubectl apply -f ???
   ```
   
2. Verify that the components are successfully set up in your cluster. 
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


### Step 1: Rolling out code from an external source

You can use the Razee `RemoteResource` component to automatically create Kubernetes YAML files that are stored in a remote location, such as GitHub or Cloud Object Storage. 
