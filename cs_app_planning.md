 to increase the high availability.

### Increasing the availability of your app
{: #increase_availability}

Consider the following options to increase availability of your app.
{: shortdesc}

<dl>
  <dt>Use deployments and replica sets to deploy your app and its dependencies</dt>
    <dd><p>A deployment is a Kubernetes resource that you can use to declare all of the components of your app and its dependencies. With deployments, you don't have to write down all of the steps and instead can focus on your app.</p>
    <p>When you deploy more than one pod, a replica set is automatically created for your deployments that monitors the pods and assures that the specified number of pods is up and running at all times. When a pod goes down, the replica set replaces the unresponsive pod with a new one.</p>
    <p>You can use a deployment to define update strategies for your app including the number of pods that you want to add during a rolling update and the number of pods that can be unavailable at a time. When you perform a rolling update, the deployment checks whether or not the revision is working and stops the rollout when failures are detected.</p>
    <p>With deployments you can concurrently deploy multiple revisions with different flags. For example, you can test a deployment first before you decide to push it to production.</p>
    <p>Deployments allow you to keep track of any deployed revisions. You can use this history to roll back to a previous version if you encounter that your updates are not working as expected.</p></dd>
  <dt>Include enough replicas for your app's workload, plus two</dt>
    <dd>To make your app even more highly available and more resilient to failure, consider including extra replicas than the minimum to handle the expected workload. Extra replicas can handle the workload in case a pod crashes and the replica set has not yet recovered the crashed pod. For protection against two simultaneous failures, include two extra replicas. This setup is an N+2 pattern, where N is the number of replicas to handle the incoming workload and +2 is an extra two replicas. As long as your cluster has enough space, you can have as many pods as you want.</dd>
  <dt>Spread pods across multiple nodes (anti-affinity)</dt>
    <dd><p>When you create your deployment, each pod can be deployed to the same worker node. This is known as affinity, or co-location. To protect your app against worker node failure, you can configure your deployment to spread your pods across multiple worker nodes by using the <code>podAntiAffinity</code> option with your standard clusters. You can define two types of pod anti-affinity: preferred or required.
      <p>For more information, see the Kubernetes documentation on <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(Opens in a new tab or window)">Assigning Pods to Nodes</a>.</p>
      <p>For an example of affinity in an app deployment, see [Making your app deployment YAML file](#app_yaml).</p>
      </dd>
    </dd>
<dt>Distribute pods across multiple zones or regions</dt>
  <dd><p>To protect your app from a zone failure, you can create multiple clusters in separate zones or add zones to a worker pool in a multizone cluster. Multizone clusters are available only in [certain metro areas](/docs/containers?topic=containers-regions-and-zones#zones), such as Dallas. If you create multiple clusters in separate zones, you must [set up a global load balancer](/docs/containers?topic=containers-plan_clusters#multiple_clusters).</p>
  <p>When you use a replica set and specify pod anti-affinity, Kubernetes spreads your app pods across the nodes. If your nodes are in multiple zones, the pods are spread across the zones, increasing the availability of your app. If you want to limit your apps to run only in one zone, you can configure pod affinity, or create and label a worker pool in one zone. For more information, see [High availability for multizone clusters](/docs/containers?topic=containers-plan_clusters#ha_clusters).</p>
  <p><strong>In a multizone cluster deployment, are my app pods distributed evenly across the nodes?</strong></p>
  <p>The pods are evenly distributed across zones, but not always across nodes. For example, if you have a cluster with 1 node in each of 3 zones and deploy a replica set of 6 pods, then each node gets 2 pods. However, if you have a cluster with 2 nodes in each of 3 zones and deploy a replica set of 6 pods, each zone has 2 pods scheduled, and might schedule 1 pod per node or might not. For more control over scheduling, you can [set pod affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node).</p>
  <p><strong>If a zone goes down, how are pods rescheduled onto the remaining nodes in the other zones?</strong></br>It depends on your scheduling policy that you used in the deployment. If you included [node-specific pod affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature), your pods are not rescheduled. If you did not, pods are created on available worker nodes in other zones, but they might not be balanced. For example, the 2 pods might be spread across the 2 available nodes, or they might both be scheduled onto 1 node with available capacity. Similarly, when the unavailable zone returns, pods are not automatically deleted and rebalanced across nodes. If you want the pods to be rebalanced across zones after the zone is back up, consider using the [Kubernetes descheduler ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/descheduler).</p>
  <p><strong>Tip</strong>: In multizone clusters, try to keep your worker node capacity at 50% per zone so that you have enough capacity left to protect your cluster against a zonal failure.</p>
  <p><strong>What if I want to spread my app across regions?</strong></br>To protect your app from a region failure, create a second cluster in another region, [set up a global load balancer](/docs/containers?topic=containers-plan_clusters#multiple_clusters) to connect your clusters, and use a deployment YAML to deploy a duplicate replica set with [pod anti-affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) for your app.</p>
  <p><strong>What if my apps need persistent storage?</strong></p>
  <p>Use a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage?topic=cloud-object-storage-about).</p></dd>
</dl>

## Specifying your app requirements in your YAML file
{: #app_yaml}

In Kubernetes, you describe your app in a YAML file that declares the configuration of the Kubernetes object. The Kubernetes API server then processes the YAML file and stores the configuration and required state of the object in the etcd data store. The Kubernetes scheduler schedules your workloads onto the worker nodes within your cluster, taking into account the specification in your YAML file, any cluster policies that the admin sets, and available cluster capacity.
{: shortdesc}

Review a copy of the [complete YAML file](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml). Then, review the following sections to understand how you can enhance your app deployment.

* [Replica sets](#replicaset)
* [Labels](#label)
* [Affinity](#affinity)
* [Image policies](#image)
* [Ports](#port)
* [Resource requests and limits](#resourcereq)
* [Liveness and readiness probes](#probe)
* [Services](#app-service) to expose the app service on a port
* [Configmaps](#configmap) to set container environment variables
* [Secrets](#secret) to set container environment variables
* [Persistent volumes](#pv) that are mounted to the container for storage
* [Next steps](#nextsteps)
* [Complete example YAML](#yaml-example)

<dl>
<dt>Basic deployment metadata</dt>
  <dd><p>Use the appropriate API version for the [kind of Kubernetes object](#object) that you deploy. The API version determines the supported features for the Kubernetes object that are available to you. The name that you give in the metadata is the object's name, not its label. You use the name when interacting with your object, such as `kubectl get deployment <name>`.</p>
  <p><pre class="codeblock"><code>apiVersion: apps/v1
kind: Deployment
metadata:
  name: wasliberty</code></pre></p></dd>

<dt id="replicaset">Replica set</dt>
  <dd><p>To increase the availability of your app, you can specify a replica set in your deployment. In a replica set, you define how many instances of your app that you want to deploy. Replica sets are managed and monitored by your Kubernetes deployment. If one app instance goes down, Kubernetes automatically spins up a new instance of your app to maintain the specified number of app instances.</p>
  <p><pre class="codeblock"><code>spec:
  replicas: 3</pre></code></p></dd>

<dt id="label">Labels</dt>
  <dd><p>With [labels](/docs/containers?topic=containers-strategy#deploy_organize), you can mark different types of resources in your cluster with the same `key: value` pair. Then, you can specify the selector to match the label so that you can build upon these other resources. If you plan to expose your app publicly, you must use a label that matches the selector that you specify in the service. In the example, the deployment spec uses the template that matches the label `app: wasliberty.`</p>
  <p>You can retrieve objects that are labeled in your cluster, such as to see `staging` or `production` components. For example, list all resources with an `env: production` label across all namespaces in the cluster. Note that you need access to all namespaces to run this command.<pre class="pre"><code>kubectl get all -l env=production --all-namespaces</code></pre></p>
  <ul><li>For more information about labels, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/).</li>
  <li>For a more detailed example, see [Deploying apps to specific worker nodes by using labels](/docs/containers?topic=containers-app#node_affinity).</li></ul>
  <p><pre class="codeblock"><code>selector:
  matchLabels:
    app: wasliberty
template:
  metadata:
    labels:
      app: wasliberty</pre></code></p></dd>

<dt id="affinity">Affinity</dt>
  <dd><p>Specify affinity (co-location) when you want more control over which worker nodes the pods are scheduled on. Affinity only affects the pods at scheduling time. For example, to spread the deployment across worker nodes instead of allowing pods to schedule on the same node, use the <code>podAntiAffinity</code> option with your standard clusters. You can define two types of pod anti-affinity: preferred or required.</p>
  <p>For more information, see the Kubernetes documentation on <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(Opens in a new tab or window)">Assigning Pods to Nodes</a>.</p>
  <ul><li><strong>Required anti-affinity</strong>: You can only deploy the amount of replicas that you have worker nodes for. For example, if you have 3 worker nodes in your cluster but you define 5 replicas in your YAML file, then only 3 replicas deploy. Each replica lives on a different worker node. The leftover 2 replicas remain pending. If you add another worker node to your cluster, then one of the leftover replicas deploys to the new worker node automatically. If a worker node fails, the pod does not reschedule because the affinity policy is required. For an example YAML with required, see <a href="https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(Opens in a new tab or window)">Liberty app with required pod anti-affinity.</a></li>
  <li><strong>Preferred anti-affinity</strong>: You can deploy your pods to nodes with available capacity, which provides more flexibility for your workload. When possible, the pods are scheduled on different worker nodes. For example, if you have 3 worker nodes with enough capacity in your cluster, it can schedule the 5 replica pods across the nodes. However, if you add two more worker nodes to your cluster, the affinity rule does not force the 2 extra pods running on the existing nodes to reschedule onto the free node.</li>
  <li><strong>Worker node affinity</strong>: You can configure your deployment to run on only certain worker nodes, such as bare metal. For more information, see [Deploying apps to specific worker nodes by using labels](/docs/containers?topic=containers-app#node_affinity).</li></ul>
  <p>Example for preferred anti-affinity:</p>
  <p><pre class="codeblock"><code>spec:
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
          topologyKey: kubernetes.io/hostname</pre></code></p></dd>

<dt id="image">Container image</dt>
  <dd>
  <p>Specify the image that you want to use for your containers, the location of the image, and the image pull policy. If you do not specify an image tag, by default it pulls the image that is tagged `latest`.</p>
  <p>**Attention**: Avoid using the latest tag for production workloads. You might not have tested your workload with the latest image if you are using a public or shared repository, such as Docker Hub or {{site.data.keyword.registryshort_notm}}.</p>
  <p>For example, to list the tags of public IBM images:</p>
  <ol><li>Switch to the global registry region.<pre class="pre"><code>ibmcloud cr region-set global</code></pre></li>
  <li>List the IBM images.<pre class="pre"><code>ibmcloud cr images --include-ibm</code></pre></li></ol>
  <p>The default `imagePullPolicy` is set to `IfNotPresent`, which pulls the image only if it does not already exist locally. If you want the image to be pulled every time that the container starts, specify the `imagePullPolicy: Always`.</p>
  <p><pre class="codeblock"><code>containers:
- name: wasliberty
  image: registry.bluemix.net/ibmliberty:webProfile8
  imagePullPolicy: Always</pre></code></p></dd>

<dt id="port">Port for the app's service</dt>
  <dd><p>Select a container port to open the app's services on. To see which port needs to be opened, refer to your app specs or Dockerfile. The port is accessible from the private network, but not from a public network connection. To expose the app publicly, you must create a NodePort, load balancer, or Ingress service. You use this same port number when you [create a `Service` object](#app-service).</p>
  <p><pre class="codeblock"><code>ports:
- containerPort: 9080</pre></code></p></dd>

<dt id="resourcereq">Resource requests and limits</dt>
  <dd><p>As a cluster admin, you can make sure that teams that share a cluster don't take up more than their fair share of compute resources (memory and CPU) by creating a [<code>ResourceQuota</code> object ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) for each Kubernetes namespace in the cluster. If the cluster admin sets a compute resource quota, then each container within the deployment template must specify resource requests and limits for memory and CPU, otherwise the pod creation fails.</p>
  <p><ol><li>Check if a resource quota is set for a namespace.<pre class="pre"><code>kubectl get quota --namespace=<namespace></code></pre></li>
  <li>See what the quota limits are.<pre class="pre"><code>kubectl describe quota <quota_name> --namespace=<namespace></code></pre></li></ol></p>
  <p>Even if no resource quota is set, you can include resource requests and limits in your deployment to improve the management of worker node resources.</p><p class="note">If a container exceeds its limit, the container might be restarted or fail. If a container exceeds a request, its pod might be evicted if the worker node runs out of that resource that is exceeded. For troubleshooting information, see [Pods repeatedly fail to restart or are unexpectedly removed](/docs/containers?topic=containers-cs_troubleshoot_clusters#pods_fail).</p>
  <p>**Request**: The minimum amount of the resource that the scheduler reserves for the container to use. If the amount is equal to the limit, the request is guaranteed. If the amount is less than the limit, the request is still guaranteed, but the the scheduler can use the difference between the request and the limit to fulfill the resources of other containers.</p>
  <p>**Limit**: The maximum amount of the resource that the container can consume. If the total amount of resources that is used across the containers exceeds the amount available on the worker node, containers can be evicted to free up space. To prevent eviction, set the resource request equal to the limit of the container. If no limit is specified, the default is the worker node's capacity.</p>
  <p>For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/).</p>
  <p><pre class="codeblock"><code>resources:
  requests:
    memory: "512Mi"
    cpu: "500m"
  limits:
    memory: "1024Mi"
    cpu: "1000m"</pre></code></p></dd>

<dt id="probe">Liveness and readiness probes</dt>
  <dd><p>By default, Kubernetes sends traffic to your app pods after all containers in the pod start, and restarts containers when they crash. However, you can set health checks to improve the robustness of service traffic routing. For example, your app might have a startup delay. The app processes might begin before the entire app is completely ready, which can affect responses especially when scaling up across many instances. With health checks, you can let your system can know if your app is running and ready to receive requests. By setting these probes, you can also help prevent downtime when you perform a [rolling update](#app_rolling) of your app. You can set two types of health checks: liveness and readiness probes.</p>
  <p>**Liveness probe**: Set up a liveness probe to check if the container is running. If the probe fails, the container is restarted. If the container does not specify a liveness probe, the probe succeeds because it assumes that the container is alive when the container is in a **Running** status.</p>
  <p>**Readiness probe**: Set up a readiness probe to check if the container is ready to receive requests and external traffic. If the probe fails, the pod's IP address is removed as a usable IP address for services that match the pod, but the container is not restarted. Setting a readiness probe with an initial delay is especially important if your app takes a while to start up. Before the initial delay, the probe does not start, giving your container time to come up. If the container does not provide a readiness probe, the probe succeeds because it assumes that the container is alive when the container is in a **Running** status.</p>
  <p>You can set up the probes as commands, HTTP requests, or TCP sockets. The example uses HTTP requests. Give the liveness probe more time than the readiness probe. For more information, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/).</p>
  <p><pre class="codeblock"><code>livenessProbe:
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
  periodSeconds: 5</pre></code></p></dd>

<dt id="app-service">Exposing the app service</dt>
  <dd><p>You can create a service that exposes your app. In the `spec` section, make sure to match the `port` and label values with the ones that you used in the deployment. The service exposes objects that match the label, such as `app: wasliberty` in the following example.</p>
  <ul><li>By default, a service uses [`ClusterIP` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/), which makes the service accessible only within the cluster but not outside the cluster.</li>
  <li>You can create a NodePort, load balancer, or Ingress service to expose the app publicly. These services have two IPs, one external and one internal. When traffic is received on the external IP, it is forwarded to the internal cluster IP. Then, from the internal cluster IP, the traffic is routed to the container IP of the app.</li>
  <li>The example uses `NodePort` to expose the service outside the cluster. For information about how to set up external access, see [Choosing a NodePort, load balancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#external).</li></ul>
  <p><pre class="codeblock"><code>apiVersion: v1
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
    type: NodePort</pre></code></p></dd>

<dt id="configmap">Configmaps for container environment variables</dt>
<dd><p>Configmaps provide non-sensitive configuration information for your deployment workloads. The following example shows shows how you can reference values from your configmap as environment variables in the container spec section of your deployment YAML. By referencing values from your configmap, you can decouple this configuration information from your deployment to keep your containerized app portable.<ul><li>[Help me decide whether to use a Kubernetes `ConfigMap` or `Secret` object for variables](#variables).</li>
<li>For more ways to use configmaps, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).</li></ul></p>
<p><pre class="codeblock"><code>apiVersion: apps/v1
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
  LANGUAGE: en</pre></code></p></dd>

  <dt id="secret">Secrets for container environment variables</dt>
  <dd><p>Secrets provide sensitive configuration information such as passwords for your deployment workloads. The following example shows shows how you can reference values from your secret as environment variables in the container spec section of your deployment YAML. You can also mount the secret as a volume. By referencing values from your secret, you can decouple this configuration information from your deployment to keep your containerized app portable.<ul><li>[Help me decide whether to use a ConfigMap or Secret for variables](#variables).</li>
  <li>For more information, see [Understanding when to use secrets](/docs/containers?topic=containers-encryption#secrets).</li></ul></p>
  <p><pre class="codeblock"><code>apiVersion: apps/v1
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
    password: cGFzc3dvcmQ=</pre></code></p></dd>

<dt id="pv">Persistent volumes for container storage</dt>
<dd><p>Persistent volumes (PVs) interface with physical storage to provide persistent data storage for your container workloads. The following example shows how you can add persistent storage to your app. To provision persistent storage, you create a persistent volume claim (PVC) to describe the type and size of file storage that you want to have. After creating the PVC, the persistent volume and the physical storage is automatically created by using [dynamic provisioning](/docs/containers?topic=containers-kube_concepts#dynamic_provisioning). By referencing the PVC in your deployment YAML, the storage is automatically mounted to your app pod. When the container in your pod writes data to the `/test` mount path directory, data is stored on the NFS file storage instance.</p><ul><li>For more information, see [Understanding Kubernetes storage basics](/docs/containers?topic=containers-kube_concepts#kube_concepts).</li><li>For options on other types of storage that you can provision, see [Planning highly available persistent storage](/docs/containers?topic=containers-storage_planning#storage_planning).</li></ul>
<p><pre class="codeblock"><code>apiVersion: apps/v1
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
      storage: 24Gi</pre></code></p></dd>

<dt id="nextsteps">Ready to deploy an app?</dt>
<dd><ul><li>[Use a copy of the complete YAML as a template to get started](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml).</li>
<li>[Deploy an app from the Kubernetes dashboard](/docs/containers?topic=containers-app#app_ui).</li>
<li>[Deploy an app from the CLI](/docs/containers?topic=containers-app#app_cli).</li></ul></dd>

</dl>

### Complete example deployment YAML
{: #yaml-example}

The following is a copy of the deployment YAML that is [discussed section-by-section previously](#app_yaml). You can also [download the YAML from GitHub](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml).
{: shortdesc}

To apply the YAML:

```
kubectl apply -f file.yaml [-n <namespace>]
```
{: pre}

Example YAML:

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
        image: registry.bluemix.net/ibmliberty
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

<br />



</staging>
