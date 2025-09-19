---

copyright:
  years: 2014, 2025
lastupdated: "2025-09-19"


keywords: containers, {{site.data.keyword.containerlong_notm}}, node.js, js, java, .net, go, flask, react, python, swift, rails, ruby, spring boot, angular

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}







# Developing apps
{: #app}

Develop a configuration to deploy your app workload to {{site.data.keyword.containerlong}}. Because Kubernetes is an extensible container orchestration platform that does not mandate a specific language or app, you can run various workloads such as stateless, stateful, and data-processing apps that are written in the language of your choice.
{: shortdesc}

## Specifying your app requirements in your YAML file
{: #app_yaml}

In Kubernetes, you describe your app in a YAML file that declares the configuration of the Kubernetes object. The Kubernetes API server then processes the YAML file and stores the configuration and required state of the object in the etcd data store. The Kubernetes scheduler schedules your workloads onto the worker nodes within your cluster, taking into account the specification in your YAML file, any cluster policies that the admin sets, and available cluster capacity.
{: shortdesc}

Review a copy of the [complete YAML file](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml){: external}. Then, review the following sections to understand how you can enhance your app deployment.

Want more information about how Kubernetes objects work together for your deployment? Check out [Understanding Kubernetes objects for apps](/docs/containers?topic=containers-plan_deploy#kube-objects).
{: tip}

### Basic deployment metadata
{: #metadata}

Use the appropriate API version for the [kind of Kubernetes object](/docs/containers?topic=containers-plan_deploy#object) that you deploy. The API version determines the supported features for the Kubernetes object that are available to you. The name that you give in the metadata is the object's name, not its label. You use the name when interacting with your object, such as `kubectl get deployment <name>`.
{: shortdesc}

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wasliberty
```
{: codeblock}

### Replica set
{: #replicaset}

To increase the availability of your app, you can specify a replica set in your deployment. In a replica set, you define how many instances of your app that you want to deploy. Replica sets are managed and monitored by your Kubernetes deployment. If one app instance goes down, Kubernetes automatically spins up a new instance of your app to maintain the specified number of app instances.
{: shortdesc}

```yaml
spec:
  replicas: 3
```
{: codeblock}

### Labels
{: #label}

With [labels](/docs/containers?topic=containers-plan_deploy#deploy_organize), you can mark different types of resources in your cluster with the same `key: value` pair. Then, you can specify the selector to match the label so that you can build upon these other resources. If you plan to expose your app publicly, you must use a label that matches the selector that you specify in the service. In the example, the deployment spec uses the template that matches the label `app: wasliberty.`
{: shortdesc}

You can retrieve objects that are labeled in your cluster, such as to see `staging` or `production` components. For example, list all resources with an `env: production` label across all namespaces in the cluster. **Note:** You need access to all namespaces to run this command.

```sh
kubectl get all -l env=production --all-namespaces
```
{: pre}

* For more information about labels, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){: external}.
* [Apply labels to worker nodes](/docs/containers?topic=containers-worker-tag-label).
* For a more detailed example, see [Deploying apps to specific worker nodes by using labels](/docs/containers?topic=containers-deploy_app#node_affinity).

```yaml
selector:
  matchLabels:
    app: wasliberty
template:
  metadata:
    labels:
      app: wasliberty
```
{: codeblock}

### Affinity
{: #affinity}

Specify affinity (colocation) when you want more control over which worker nodes the pods are scheduled on. Affinity affects the pods only at scheduling time. For example, to spread the deployment across worker nodes instead of allowing pods to schedule on the same node, use the `podAntiAffinity` option with your standard clusters. You can define two types of pod anti-affinity: preferred or required.
{: shortdesc}

For more information, see the [Kubernetes documentation on Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external}.

Required anti-affinity
:   You can deploy only the number of replicas that you have worker nodes for. For example, if you have three worker nodes in your cluster but you define five replicas in your YAML file, then only three replicas deploy. Each replica lives on a different worker node. The leftover two replicas remain pending. If you add another worker node to your cluster, then one of the leftover replicas deploys to the new worker node automatically. If a worker node fails, the pod does not reschedule because the affinity policy is required. For an example YAML with required, see [Liberty app with required pod anti-affinity](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml){: external}.

Preferred anti-affinity
:   You can deploy your pods to nodes with available capacity, which provides more flexibility for your workload. When possible, the pods are scheduled on different worker nodes. For example, if you have three worker nodes with enough capacity in your cluster, it can schedule the five replica pods across the nodes. However, if you add two more worker nodes to your cluster, the affinity rule does not force the two extra pods that are running on the existing nodes to reschedule onto the available node.

Worker node affinity
:   You can configure your deployment to run on only certain worker nodes, such as bare metal. For more information, see [Deploying apps to specific worker nodes by using labels](/docs/containers?topic=containers-deploy_app#node_affinity).

Example for preferred anti-affinity
```yaml
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
              - wasliberty
          topologyKey: kubernetes.io/hostname
```
{: codeblock}

### Container image
{: #image}

Specify the image that you want to use for your containers, the location of the image, and the image pull policy. If you don't specify an image tag, by default it pulls the image that is tagged `latest`.
{: shortdesc}

Avoid using the latest tag for production workloads. You might not have tested your workload with the latest image if you are using a public or shared repository, such as Docker Hub or {{site.data.keyword.registrylong_notm}}.
{: important}

For example, to list the tags of public IBM images:
1. Switch to the global registry region.
    ```sh
    ibmcloud cr region-set global
    ```
    {: pre}

2. List the IBM images.
    ```sh
    ibmcloud cr images --include-ibm
    ```
    {: pre}

The default `imagePullPolicy` is set to `IfNotPresent`, which pulls the image only if it does not exist locally. If you want the image to be pulled every time that the container starts, specify the `imagePullPolicy: Always`.

```yaml
containers:
- name: wasliberty
  image: icr.io/ibm/liberty:webProfile8
  imagePullPolicy: Always
```
{: codeblock}

### Port for the app's service
{: #port}

Select a container port to open the app's services on. To see which port needs to be opened, refer to your app specs or Dockerfile. The port is accessible from the private network, but not from a public network connection. To expose the app publicly, you must create a NodePort, load balancer, or Ingress service. You use this same port number when you [create a `Service` object](#app-service).
{: shortdesc}

Port 25 is blocked for all services in {{site.data.keyword.cloud_notm}}.
{: note}

```yaml
ports:
- containerPort: 9080
```
{: codeblock}

### Resource requests and limits
{: #resourcereq}

Cluster administrators make sure that teams that share a cluster don't take up more than their fair share of compute resources (memory and CPU) by creating a [`ResourceQuota` object](https://kubernetes.io/docs/concepts/policy/resource-quotas/){: external} for each Kubernetes namespace in the cluster. If the cluster admin sets a compute resource quota, then each container within the deployment template must specify resource requests and limits for memory and CPU, otherwise the pod creation fails.
{: shortdesc}

1. Check whether a resource quota is set for a namespace.
    ```sh
    kubectl get quota --namespace=<namespace>
    ```
    {: pre}

2. See what the quota limits are.
    ```sh
    kubectl describe quota <quota_name> --namespace=<namespace>
    ```
    {: pre}

Even if no resource quota is set, you can include resource requests and limits in your deployment to improve the management of worker node resources.

If a container exceeds its limit, the container might be restarted or fail. If a container exceeds a request, its pod might be evicted if the worker node runs out of that resource that is exceeded. For more information about troubleshooting, see [Pods repeatedly fail to restart or are unexpectedly removed](/docs/containers?topic=containers-ts-app-pod-fail).
{: note}

Request
:   The minimum amount of the resource that the scheduler reserves for the container to use. If the amount is equal to the limit, the request is guaranteed. If the amount is less than the limit, the request is still guaranteed, but the scheduler can use the difference between the request and the limit to fulfill the resources of other containers.

Limit
:   The maximum amount of the resource that the container can consume. If the total amount of resources that is used across the containers exceeds the amount available on the worker node, containers can be evicted to free up space. To prevent eviction, set the resource request equal to the limit of the container. If no limit is specified, the default is the worker node's capacity.

For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/){: external}.

```yaml
resources:
  requests:
    memory: "512Mi"
    cpu: "500m"
  limits:
    memory: "1024Mi"
    cpu: "1000m"
```
{: codeblock}

### Liveness and readiness probes
{: #probe}

By default, Kubernetes sends traffic to your app pods after all containers in the pod start, and restarts containers when they crash. However, you can set health checks to improve the robustness of service traffic routing.
{: shortdesc}

For example, your app might have a startup delay. The app processes might begin before the entire app is completely ready, which can affect responses especially when scaling up across many instances. With health checks, you can let your system can know whether your app is running and ready to receive requests. By setting these probes, you can also help prevent downtime when you perform a [rolling update](/docs/containers?topic=containers-update_app#app_rolling) of your app. You can set two types of health checks: liveness and readiness probes.

Liveness probe
:   Set up a liveness probe to check whether the container is running. If the probe fails, the container is restarted. If the container does not specify a liveness probe, the probe succeeds because it assumes that the container is alive when the container is in a **Running** status.

Readiness probe
:   Set up a readiness probe to check whether the container is ready to receive requests and external traffic. If the probe fails, the pod's IP address is removed as a usable IP address for services that match the pod, but the container is not restarted. Setting a readiness probe with an initial delay is especially important if your app takes a while to start. Before the initial delay, the probe does not start, giving your container time to come up. If the container does not provide a readiness probe, the probe succeeds because it assumes that the container is alive when the container is in a **Running** status.

You can set up the probes as commands, HTTP requests, or TCP sockets. The example uses HTTP requests. Give the liveness probe more time than the readiness probe. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/){: external}.

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 9080
  initialDelaySeconds: 300
  periodSeconds: 15
readinessProbe:
  httpGet:
    path: /
    port: 9080
  initialDelaySeconds: 45
  periodSeconds: 5
```
{: codeblock}

### Pod Disruption Budget
{: #disruption-budget}

To increase your app's availability, you can control how your app reacts to [disruptions](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/){: external} based on the type of availability that you want with a `PodDisruptionBudget` object.
{: shortdesc}

A pod disruption budget can help you plan how your app behaves during voluntary disruptions, such as when you initiate a direct restart by updating the app deployment, or involuntary disruptions, such as a kernel panic.
`minAvailable`
:   You can specify the number or percentage of pods that must still be available after a disruption occurs.

`maxUnavailable`
:   You can specify the number or percentage of pods that can be unavailable after a disruption occurs. The example uses `maxUnavailable: 1`.

`selector`
:   Enter the label to select the set of pods that the `PodDisruptionBudget` applies to. Note that if you used this same label in other pod deployments, the pod applies to those as well.

For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/run-application/configure-pdb/){: external}.

```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: wasliberty
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: wasliberty
```
{: codeblock}

### Exposing the app service
{: #app-service}

You can create a service that exposes your app. In the `spec` section, make sure to match the `port` and label values with the ones that you used in the deployment. The service exposes objects that match the label, such as `app: wasliberty` in the following example.
{: shortdesc}

* By default, a service uses [`ClusterIP`](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/){: external}, which makes the service accessible only within the cluster but not outside the cluster.
* You can create a NodePort, load balancer, or Ingress service to expose the app publicly. These services have two IPs, one external and one internal. When traffic is received on the external IP, it is forwarded to the internal cluster IP. Then, from the internal cluster IP, the traffic is routed to the container IP of the app.
* The example uses `NodePort` to expose the service outside the cluster. For more information about how to set up external access, see [Choosing a NodePort, load balancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning).

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
  - port: 9080
  selector:
    app: wasliberty
    type: NodePort
```
{: codeblock}

If you have a requirement to deploy `hostNetwork` pods to listen on specific ports or to use a `hostPort` to expose your app pods on a specific port on the worker node, use a port in the `11000-11200` range. {{site.data.keyword.containerlong_notm}} designates the `11000-11200` port range on worker nodes for this purpose to avoid conflicts with local ports and other ports that {{site.data.keyword.containerlong_notm}} uses. Because `hostNetwork` pods and `hostPorts` refer to a particular worker node IP address, the pods are limited to run only on that worker node. If something unanticipated happens, such as the worker node being removed or running out of resources, your pod can't be rescheduled. If you want to expose a pod’s port on the worker node, consider using a [`NodePort` service](/docs/containers?topic=containers-nodeport) instead. For more information, see the [Kubernetes best practices documentation](https://kubernetes.io/docs/concepts/configuration/overview/#services){: external}.
{: important}

### Configmaps for container environment variables
{: #configmap}

Configmaps provide non-sensitive configuration information for your deployment workloads.
{: shortdesc}

The following example shows how you can reference values from your ConfigMap as environment variables in the container spec section of your deployment YAML. By referencing values from your ConfigMap, you can decouple this configuration information from your deployment to keep your containerized app portable.
* [Help me decide whether to use a Kubernetes `ConfigMap` or `Secret` object for variables](/docs/containers?topic=containers-plan_deploy#variables).
* For more ways to use configmaps, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){: external}.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    ...
    spec:
      ...
      containers:
      - name: wasliberty
        ...
        env:
          - name: VERSION
            valueFrom:
              configMapKeyRef:
                name: wasliberty
                key: VERSION
          - name: LANGUAGE
            valueFrom:
              configMapKeyRef:
                name: wasliberty
                key: LANGUAGE
        ...
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wasliberty
  labels:
    app: wasliberty
data:
  VERSION: "1.0"
  LANGUAGE: en
```
{: codeblock}

### Secrets for container environment variables
{: #secret}

Secrets provide sensitive configuration information such as passwords for your deployment workloads.
{: shortdesc}

The following example shows how you can reference values from your secret as environment variables in the container spec section of your deployment YAML. You can also mount the secret as a volume. By referencing values from your secret, you can decouple this configuration information from your deployment to keep your containerized app portable.
* [Help me decide whether to use a Kubernetes `ConfigMap` or `Secret` object for variables](/docs/containers?topic=containers-plan_deploy#variables).
* To create a secret, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/secret/){: external}.

For centralized management of all your secrets across clusters and injection at application runtime, try [{{site.data.keyword.secrets-manager_full_notm}}](/docs/secrets-manager?topic=secrets-manager-tutorial-kubernetes-secrets).
{: tip}

```yaml
apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: wasliberty
  spec:
    replicas: 3
    template:
      ...
      spec:
        ...
        containers:
        - name: wasliberty
          ...
          env:
          - name: username
            valueFrom:
              secretKeyRef:
                name: wasliberty
                key: username
          - name: password
            valueFrom:
              secretKeyRef:
                name: wasliberty
                key: password
          ...
  ---
  apiVersion: v1
  kind: Secret
  metadata:
    name: wasliberty
    labels:
      app: wasliberty
  type: Opaque
  data:
    username: dXNlcm5hbWU=
    password: cGFzc3dvcmQ=
```
{: codeblock}

### Persistent volumes for container storage
{: #pv}

Persistent volumes (PVs) interface with physical storage to provide persistent data storage for your container workloads.
{: shortdesc}

The following example shows how you can add persistent storage to your app. To provision persistent storage, you create a persistent volume claim (PVC) to describe the type and size of file storage that you want to have. After you create the PVC, the persistent volume and the physical storage are automatically created by using dynamic provisioning. By referencing the PVC in your deployment YAML, the storage is automatically mounted to your app pod. When the container in your pod writes data to the `/test` mount path directory, data is stored on the NFS file storage instance. For options on other types of storage that you can provision, see [Planning highly available persistent storage](/docs/containers?topic=containers-storage-plan).

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    ...
    spec:
      ...
      containers:
      - name: wasliberty
        ...
        volumeMounts:
        - name: pvmount
          mountPath: /test
      volumes:
      - name: pvmount
        persistentVolumeClaim:
          claimName: wasliberty
        ...
---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: wasliberty
  annotations:
    volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
  labels:
    billingType: "hourly"
    app: wasliberty
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 24Gi
```
{: codeblock}



## Complete example deployment YAML
{: #yaml-example}

The following example is a copy of the deployment YAML that is [discussed section-by-section previously](#app_yaml). You can also [download the YAML from GitHub](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml){: external}.
{: shortdesc}

To apply the YAML,

```sh
kubectl apply -f file.yaml [-n <namespace>]
```
{: pre}

Example YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  selector:
    matchLabels:
      app: wasliberty
  template:
    metadata:
      labels:
        app: wasliberty
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
                  - wasliberty
              topologyKey: kubernetes.io/hostname
      containers:
      - name: wasliberty
        image: icr.io/ibm/liberty:latest
        env:
          - name: VERSION
            valueFrom:
              configMapKeyRef:
                name: wasliberty
                key: VERSION
          - name: LANGUAGE
            valueFrom:
              configMapKeyRef:
                name: wasliberty
                key: LANGUAGE
          - name: username
            valueFrom:
              secretKeyRef:
                name: wasliberty
                key: username
          - name: password
            valueFrom:
              secretKeyRef:
                name: wasliberty
                key: password
        ports:
          - containerPort: 9080
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "1024Mi"
            cpu: "1000m"
        livenessProbe:
          httpGet:
            path: /
            port: 9080
          initialDelaySeconds: 300
          periodSeconds: 15
        readinessProbe:
          httpGet:
            path: /
            port: 9080
          initialDelaySeconds: 45
          periodSeconds: 5
        volumeMounts:
        - name: pvmount
          mountPath: /test
      volumes:
      - name: pvmount
        persistentVolumeClaim:
          claimName: wasliberty
---

apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: wasliberty
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: wasliberty
---

apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: wasliberty
  labels:
    app: wasliberty
data:
  VERSION: "1.0"
  LANGUAGE: en
---

apiVersion: v1
kind: Secret
metadata:
  name: wasliberty
  labels:
    app: wasliberty
type: Opaque
data:
  username: dXNlcm5hbWU=
  password: cGFzc3dvcmQ=
---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: wasliberty
  annotations:
    volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
  labels:
    billingType: "hourly"
    app: wasliberty
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 24Gi
```
{: codeblock}
