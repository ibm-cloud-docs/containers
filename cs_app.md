---

copyright:
  years: 2014, 2019
lastupdated: "2019-01-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}




# Deploying apps in clusters
{: #app}

You can use Kubernetes techniques in {{site.data.keyword.containerlong}} to deploy apps in containers and ensure that those apps are up and running at all times. For example, you can perform rolling updates and rollbacks without downtime for your users.
{: shortdesc}

Learn the general steps for deploying apps by clicking an area of the following image. Want to learn the basics first? Try out the [deploying apps tutorial](/docs/containers/cs_tutorials_apps.html#cs_apps_tutorial).

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="Basic deployment process"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Install the CLIs." title="Install the CLIs." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Create a configuration file for your app. Review the best practices from Kubernetes." title="Create a configuration file for your app. Review the best practices from Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="Option 1: Run configuration files from the Kubernetes CLI." title="Option 1: Run configuration files from the Kubernetes CLI." shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="Option 2: Start the Kubernetes dashboard locally and run configuration files." title="Option 2: Start the Kubernetes dashboard locally and run configuration files." shape="rect" coords="544, 141, 728, 204" />
</map>

<br />


## Planning to run apps in clusters
{: #plan_apps}

Before you deploy an app to an {{site.data.keyword.containerlong_notm}} cluster, decide how you want to set up your app so that your app can be accessed properly and be integrated with other services in {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

### What type of Kubernetes objects can I make for my app?
{: #object}

When you prepare your app YAML file, you have many options to increase the app's availability, performance, and security. For example, instead of a single pod, you can use a Kubernetes controller object to manage your workload, such as a replica set, job, or daemon set. For more information about pods and controllers, view the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/). A deployment that manages a replica set of pods is a common use case for an app.
{: shortdesc}

For example, a `kind: Deployment` object is a good choice to deploy an app pod because with it, you can specify a replica set for more availability for your pods.

The following table describes why you might create different types of Kubernetes workload objects.

| Object | Description |
| --- | --- |
| [`Pod` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/pod/) | A pod is the smallest deployable unit for your workloads, and can hold a single or multiple containers. Similar to containers, pods are designed to be disposable and are often used for unit testing of app features. To avoid downtime for your app, consider deploying pods with a Kubernetes controller, such as a deployment. A deployment helps you to manage multiple pods, replicas, pod scaling, rollouts, and more. |
| [`ReplicaSet` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) | A replica set makes sure that multiple replicas of your pod are running, and reschedules a pod if the pod goes down. You might create a replica set to test how pod scheduling works, but to manage app updates, rollouts, and scaling, create a deployment instead. |
| [`Deployment` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) | A deployment is a controller that manages a pod or [replica set ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) of pod templates. You can create pods or replica sets without a deployment to test app features. For a production-level setup, use deployments to manage app updates, rollouts, and scaling. |
| [`StatefulSet` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) | Similar to deployments, a stateful set is a controller that manages a replica set of pods. Unlike deployments, a stateful set ensures that your pod has a unique network identity that maintains its state across rescheduling. When you want to run workloads in the cloud, try to design your app to be stateless so that your service instances are independent from each other and can fail without a service interruption. However, some apps, such as databases, must be stateless. For those cases, consider to create a stateful set and use [file](/docs/containers/cs_storage_file.html#file_statefulset), [block](/docs/containers/cs_storage_block.html#block_statefulset), or [object](/docs/containers/cs_storage_cos.html#cos_statefulset) storage as the persistent storage for your stateful set. |
| [`DaemonSet` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) | Use a daemonset when you must run the same pod on every worker node in your cluster. Pods that are managed by a daemonset are automatically scheduled when a worker node is added to a cluster. Typical use cases include log collectors, such as `logstash` or `prometheus`, that collect logs from every worker node to provide insight into the health of a cluster or an app. |
| [`Job` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) | A job ensures that one or more pods run successfully to completion. You might use a job for queues or batch jobs to support parallel processing of separate but related work items, such as a certain number of frames to render, emails to send, and files to convert. To schedule a job to run at certain times, use a [Cron Job ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).|
{: caption="Types of Kubernetes workload objects that you can create." caption-side="top"}

### How can I add capabilities to my Kubernetes app configuration?
See [Specifying your app requirements in your YAML file](#app_yaml) for descriptions of what you might include in a deployment. The example includes:
* [Replica sets](#replicaset)
* [Labels](#label)
* [Affinity](#affinity)
* [Image policies](#image)
* [Ports](#port)
* [Resource requests and limits](#resourcereq)
* [Liveness and readiness probes](#probe)
* [Services](#service) to expose the app service on a port
* [Configmaps](#configmap) to set container environment variables
* [Secrets](#secret) to set container environment variables
* [Persistent volumes](#pv) that are mounted to the container for storage

### What if I want my Kubernetes app configuration to use variables? How do I add these to the YAML?
{: #variables}

To add variable information to your deployments instead of hard-coding the data into the YAML file, you can use a Kubernetes [`ConfigMap` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/) or [`Secret` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/) object.
{: shortdesc}

To consume a configmap or secret, you need to mount it to the pod. The configmap or secret is combined with the pod just before the pod is run. You can reuse a deployment spec and image across many apps, but then swap out the customized configmaps and secrets. Secrets in particular can take up a lot of storage on the local node, so plan accordingly.

Both resources define key-value pairs, but you use them for different situations.

<dl>
<dt>Configmap</dt>
<dd>Provide non-sensitive configuration information for workloads that are specified in a deployment. You can use configmaps in three main ways.
<ul><li><strong>Filesystem</strong>: You can mount an entire file or a set of variables to a pod. A file is created for each entry based on the key name contents of the file that are set to the value.</li>
<li><strong>Environment variable</strong>: Dynamically set the environment variable for a container spec.</li>
<li><strong>Command-line argument</strong>: Set the command-line argument that is used in a container spec.</li></ul></dd>

<dt>Secret</dt>
<dd>Provide sensitive information to your workloads, such as follows. Note that other users of the cluster might have access to the secret, so be sure that you know the secret information can be shared with those users.
<ul><li><strong>Personally identifiable information (PII)</strong>: Store sensitive information such as email addresses or other types of information that are required for company compliance or government regulation in secrets.</li>
<li><strong>Credentials</strong>: Put credentials such as passwords, keys, and tokens in a secret to reduce the risk of accidental exposure. For example, when you [bind a service](/docs/containers/cs_integrations.html#adding_cluster) to your cluster, the credentials are stored in a secret.</li></ul></dd>
</dl>

Want to make your secrets even more secured? Ask your cluster admin to [enable {{site.data.keyword.keymanagementservicefull}}](/docs/containers/cs_encrypt.html#keyprotect) in your cluster to encrypt new and existing secrets.
{: tip}

### How can I add IBM services to my app, such as Watson?
See [Adding services to apps](/docs/containers/cs_integrations.html#adding_app).

### How can I make sure that my app has the right resources?
When you [specify your app YAML file](#app_yaml), you can add Kubernetes functionalities to your app configuration that help your app get the right resources. In particular, [set resource limits and requests ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for each container that is defined in your YAML file.
{: shortdesc}

Additionally, your cluster admin might set up resource controls that can affect your app deployment, such as the following.
*  [Resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
*  [Pod priority](/docs/containers/cs_pod_priority.html#pod_priority)

### How can I access my app?
You can access your app privately within the cluster by [using a `clusterIP` service](/docs/containers/cs_network_cluster.html#in-cluster).
{: shortdesc}

If you want to expose your app publicly, you have different options that depend on your cluster type.
*  **Free cluster**: You can expose your app by using a [NodePort service](/docs/containers/cs_nodeport.html#nodeport).
*  **Standard cluster**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers/cs_network_planning.html#planning).
*  **Cluster that is made private by using Calico**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers/cs_network_planning.html#private_both_vlans). You also must use a Calico preDNAT network policy to block the public node ports.
*  **Private VLAN-only standard cluster**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers/cs_network_planning.html#private_vlan). You also must open the port for the service's private IP address in your firewall.

### After I deploy my app, how can I monitor its health?
You can set up {{site.data.keyword.Bluemix_notm}} [logging and monitoring](/docs/containers/cs_health.html#health) for your cluster. You might also choose to integrate with a third-party [logging or monitoring service](/docs/containers/cs_integrations.html#health_services).
{: shortdesc}

### How can I keep my app up-to-date?
If you want to dynamically add and remove apps in response to workload usage, see [Scaling apps](/docs/containers/cs_app.html#app_scaling).
{: shortdesc}

If you want to manage updates to your app, see [Managing rolling deployments](/docs/containers/cs_app.html#app_rolling).

### How can I control who has access to my app deployments?
The account and cluster admins can control access on many different levels: the cluster, Kubernetes namespace, pod, and container.
{: shortdesc}

With {{site.data.keyword.Bluemix_notm}} IAM, you can assign permissions to individual users, groups, or service accounts at the cluster-instance level.  You can scope cluster access down further by restricting users to particular namespaces within the cluster. For more information, see [Assigning cluster access](/docs/containers/cs_users.html#users).

To control access at the pod level, you can [configure pod security policies with Kubernetes RBAC](/docs/containers/cs_psp.html#psp).

Within the app deployment YAML, you can set the security context for a pod or container. For more information, review the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/).

<br />


## Planning highly available deployments
{: #highly_available_apps}

The more widely you distribute your setup across multiple worker nodes and clusters, the less likely your users are to experience downtime with your app.
{: shortdesc}

Review the following potential app setups that are ordered with increasing degrees of availability.

![Stages of high availability for an app](images/cs_app_ha_roadmap-mz.png)

1.  A deployment with n+2 pods that are managed by a replica set in a single node in a single zone cluster.
2.  A deployment with n+2 pods that are managed by a replica set and spread across multiple nodes (anti-affinity) in a single zone cluster.
3.  A deployment with n+2 pods that are managed by a replica set and spread across multiple nodes (anti-affinity) in a multizone cluster across zones.

You can also [connect multiple clusters in different regions with a global load balancer](/docs/containers/cs_clusters_planning.html#multiple_clusters) to increase the high availability.

### Increasing the availability of your app
{: #increase_availability}

Consider the following options to increase availability of your app.
{: shortdesc}

<dl>
  <dt>Use deployments and replica sets to deploy your app and its dependencies</dt>
    <dd><p>A deployment is a Kubernetes resource that you can use to declare all of the components of your app and its dependencies. With deployments, you don't have to write down all of the steps and instead can focus on your app.</p>
    <p>When you deploy more than one pod, a replica set is automatically created for your deployments that monitors the pods and assures that the desired number of pods is up and running at all times. When a pod goes down, the replica set replaces the unresponsive pod with a new one.</p>
    <p>You can use a deployment to define update strategies for your app including the number of pods that you want to add during a rolling update and the number of pods that can be unavailable at a time. When you perform a rolling update, the deployment checks whether or not the revision is working and stops the rollout when failures are detected.</p>
    <p>With deployments you can concurrently deploy multiple revisions with different flags. For example, you can test a deployment first before you decide to push it to production.</p>
    <p>Deployments allow you to keep track of any deployed revisions. You can use this history to roll back to a previous version if you encounter that your updates are not working as expected.</p></dd>
  <dt>Include enough replicas for your app's workload, plus two</dt>
    <dd>To make your app even more highly available and more resilient to failure, consider including extra replicas than the minimum to handle the expected workload. Extra replicas can handle the workload in case a pod crashes and the replica set has not yet recovered the crashed pod. For protection against two simultaneous failures, include two extra replicas. This setup is an N+2 pattern, where N is the number of replicas to handle the incoming workload and +2 is an extra two replicas. As long as your cluster has enough space, you can have as many pods as you want.</dd>
  <dt>Spread pods across multiple nodes (anti-affinity)</dt>
    <dd><p>When you create your deployment, each pod can be deployed to the same worker node. This is known as affinity, or co-location. To protect your app against worker node failure, you can configure your deployment to spread your pods across multiple worker nodes by using the <em>podAntiAffinity</em> option with your standard clusters. You can define two types of pod anti-affinity: preferred or required.
      <p>For more information, see the Kubernetes documentation on <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(Opens in a new tab or window)">Assigning Pods to Nodes</a>.</p>
      <p>For an example of affinity in an app deployment, see [Making your app deployment YAML file](#app_yaml).</p>
      </dd>
    </dd>
<dt>Distribute pods across multiple zones or regions</dt>
  <dd><p>To protect your app from a zone failure, you can create multiple clusters in separate zones or add zones to a worker pool in a multizone cluster. Multizone clusters are available only in [certain metro areas](/docs/containers/cs_regions.html#zones), such as Dallas. If you create multiple clusters in separate zones, you must [set up a global load balancer](/docs/containers/cs_clusters_planning.html#multiple_clusters).</p>
  <p>When you use a replica set and specify pod anti-affinity, Kubernetes spreads your app pods across the nodes. If your nodes are in multiple zones, the pods are spread across the zones, increasing the availability of your app. If you want to limit your apps to run only in one zone, you can configure pod affinity, or create and label a worker pool in one zone. For more information, see [High availability for multizone clusters](/docs/containers/cs_clusters_planning.html#ha_clusters).</p>
  <p><strong>In a multizone cluster deployment, are my app pods distributed evenly across the nodes?</strong></p>
  <p>The pods are evenly distributed across zones, but not always across nodes. For example, if you have a cluster with 1 node in each of 3 zones and deploy a replica set of 6 pods, then each node gets 2 pods. However, if you have a cluster with 2 nodes in each of 3 zones and deploy a replica set of 6 pods, each zone has 2 pods scheduled, and might schedule 1 pod per node or might not. For more control over scheduling, you can [set pod affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node).</p>
  <p><strong>If a zone goes down, how are pods rescheduled onto the remaining nodes in the other zones?</strong></br>It depends on your scheduling policy that you used in the deployment. If you included [node-specific pod affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature), your pods are not rescheduled. If you did not, pods are created on available worker nodes in other zones, but they might not be balanced. For example, the 2 pods might be spread across the 2 available nodes, or they might both be scheduled onto 1 node with available capacity. Similarly, when the unavailable zone returns, pods are not automatically deleted and rebalanced across nodes. If you want the pods to be rebalanced across zones after the zone is back up, consider using the [Kubernetes descheduler ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/descheduler).</p>
  <p><strong>Tip</strong>: In multizone clusters, try to keep your worker node capacity at 50% per zone so that you have enough capacity left to protect your cluster against a zonal failure.</p>
  <p><strong>What if I want to spread my app across regions?</strong></br>To protect your app from a region failure, create a second cluster in another region, [set up a global load balancer](/docs/containers/cs_clusters_planning.html#multiple_clusters) to connect your clusters, and use a deployment YAML to deploy a duplicate replica set with [pod anti-affinity ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) for your app.</p>
  <p><strong>What if my apps need persistent storage?</strong></p>
  <p>Use a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).</p></dd>
</dl>

## Specifying your app requirements in your YAML file
{: #app_yaml}

In Kubernetes, you describe your app in a YAML file that declares the desired configuration of the Kubernetes object. The Kubernetes API server then processes the YAML file and stores the configuration and desired state of the object in the etcd data store. The Kubernetes scheduler schedules your workloads onto the worker nodes within your cluster, taking into account the specification in your YAML file, any cluster policies that the admin sets, and available cluster capacity.
{: shortdesc}

Review a copy of the [complete YAML file](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml). Then, review the following sections to understand how you can enhance your app deployment.

* [Replica sets](#replicaset)
* [Labels](#label)
* [Affinity](#affinity)
* [Image policies](#image)
* [Ports](#port)
* [Resource requests and limits](#resourcereq)
* [Liveness and readiness probes](#probe)
* [Services](#service) to expose the app service on a port
* [Configmaps](#configmap) to set container environment variables
* [Secrets](#secret) to set container environment variables
* [Persistent volumes](#pv) that are mounted to the container for storage
* [Next steps](#nextsteps)
* [Complete example YAML](#yaml-example)

<dl>
<dt>Basic deployment metadata</dt>
  <dd><p>Use the appropriate API version for the [kind of Kubernetes object](#object) that you deploy. The API version determines the supported features for the Kubernetes object that are available to you. The name that you give in the metadata is the object's name, not its label. You use the name when interacting with your object, such as `kubectl get deployment <name>`.</p>
  <p><pre class="codeblock"><code>apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: wasliberty</code></pre></p></dd>

<dt id="replicaset">Replica set</dt>
  <dd><p>To increase the availability of your app, you can specify a replica set in your deployment. In a replica set, you define how many instances of your app that you want to deploy. Replica sets are managed and monitored by your Kubernetes deployment. If one app instance goes down, Kubernetes automatically spins up a new instance of your app to maintain the specified number of app instances.</p>
  <p><pre class="codeblock"><code>spec:
  replicas: 3</pre></code></p></dd>

<dt id="label">Labels</dt>
  <dd><p>With labels, you can mark different types of resources in your cluster with the same `key: value` pair. Then, you can specify the selector to match the label so that you can build upon these other resources. If you plan to expose your app publicly, you must use a label that matches the selector that you specify in the service. In the example, the deployment spec uses the template that matches the label `app: wasliberty.`</p>
  <p>You can retrieve objects that are labeled in your cluster, such as to see `staging` or `production` components. For example, list all resources with an `env: production` label across all namespaces in the cluster. Note that you need access to all namespaces to run this command.<pre class="pre"><code>kubectl get all -l env=production --all-namespaces</code></pre></p>
  <ul><li>For more information about labels, see the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/).</li>
  <li>For a more detailed example, see [Deploying apps to specific worker nodes by using labels](/docs/containers/cs_app.html#node_affinity).</li></ul>
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
  <li><strong>Worker node affinity</strong>: You can configure your deployment to run on only certain worker nodes, such as bare metal. For more information, see [Deploying apps to specific worker nodes by using labels](/docs/containers/cs_app.html#node_affinity).</li></ul>
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
  <dd><p>Select a container port to open the app's services on. To see which port needs to be opened, refer to your app specs or Dockerfile. The port is accessible from the private network, but not from a public network connection. To expose the app publicly, you must create a NodePort, load balancer, or Ingress service. You use this same port number when you [create a `Service` object](#service).</p>
  <p><pre class="codeblock"><code>ports:
- containerPort: 9080</pre></code></p></dd>

<dt id="resourcereq">Resource requests and limits</dt>
  <dd><p>As a cluster admin, you can make sure that teams that share a cluster don't take up more than their fair share of compute resources (memory and CPU) by creating a [ResourceQuota object ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) for each Kubernetes namespace in the cluster. If the cluster admin sets a compute resource quota, then each container within the deployment template must specify resource requests and limits for memory and CPU, otherwise the pod creation fails.</p>
  <p><ol><li>Check if a resource quota is set for a namespace.<pre class="pre"><code>kubectl get quota --namespace=<namespace></code></pre></li>
  <li>See what the quota limits are.<pre class="pre"><code>kubectl describe quota <quota_name> --namespace=<namespace></code></pre></li></ol></p>
  <p>Even if no resource quota is set, you can include resource requests and limits in your deployment to improve the management of worker node resources.</p><p class="note">If a container exceeds its limit, the container might be restarted or fail. If a container exceeds a request, its pod might be evicted if the worker node runs out of that resource that is exceeded. For troubleshooting information, see [Pods repeatedly fail to restart or are unexpectedly removed](/docs/containers/cs_troubleshoot_clusters.html#pods_fail).</p>
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

<dt id="service">Exposing the app service</dt>
  <dd><p>You can create a service that exposes your app. In the `spec` section, make sure to match the `port` and label values with the ones that you used in the deployment. The service exposes objects that match the label, such as `app: wasliberty` in the following example.</p>
  <ul><li>By default, a service uses [ClusterIP ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/), which makes the service accessible only within the cluster but not outside the cluster.</li>
  <li>You can create a NodePort, load balancer, or Ingress service to expose the app publicly. These services have two IPs, one external and one internal. When traffic is received on the external IP, it is forwarded to the internal cluster IP. Then, from the internal cluster IP, the traffic is routed to the container IP of the app.</li>
  <li>The example uses `NodePort` to expose the service outside the cluster. For information about how to set up external access, see [Choosing a NodePort, load balancer, or Ingress service](/docs/containers/cs_network_planning.html#external).</li></ul>
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
<p><pre class="codeblock"><code>apiVersion: apps/v1beta1
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
  <li>For more information, see [Understanding when to use secrets](/docs/containers/cs_encrypt.html#secrets).</li></ul></p>
  <p><pre class="codeblock"><code>apiVersion: apps/v1beta1
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
<dd><p>Persistent volumes (PVs) interface with physical storage to provide persistent data storage for your container workloads. The following example shows how you can add persistent storage to your app. To provision persistent storage, you create a persistent volume claim (PVC) to describe the type and size of file storage that you want to have. After creating the PVC, the persistent volume and the physical storage is automatically created by using [dynamic provisioning](/docs/containers/cs_storage_basics.html#dynamic_provisioning). By referencing the PVC in your deployment YAML, the storage is automatically mounted to your app pod. When the container in your pod writes data to the `/test` mount path directory, data is stored on the NFS file storage instance.</p><ul><li>For more information, see [Understanding Kubernetes storage basics](/docs/containers/cs_storage_basics.html#kube_concepts).</li><li>For options on other types of storage that you can provision, see [Planning highly available persistent storage](/docs/containers/cs_storage_planning.html#storage_planning).</li></ul>
<p><pre class="codeblock"><code>apiVersion: apps/v1beta1
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
<li>[Deploy an app from the Kubernetes dashboard](/docs/containers/cs_app.html#app_ui).</li>
<li>[Deploy an app from the CLI](/docs/containers/cs_app.html#app_cli).</li></ul></dd>

</dl>

### Complete example deployment YAML
{: #yaml-example}

The following is a copy of the deployment YAML that is [discussed section-by-section previously](#app_yaml). You can also [download the YAML from GitHub](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy_wasliberty.yaml).
{: shortdesc}

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
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


## Launching the Kubernetes dashboard
{: #cli_dashboard}

Open a Kubernetes dashboard on your local system to view information about a cluster and its worker nodes. [In the {{site.data.keyword.Bluemix_notm}} console](#db_gui), you can access the dashboard with a convenient one-click button. [With the CLI](#db_cli), you can access the dashboard or use the steps in an automation process such as for a CI/CD pipeline.
{:shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? For clusters that run Kubernetes version 1.12 or later, your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).
* [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

You can use the default port or set your own port to launch the Kubernetes dashboard for a cluster.

**Launching the Kubernetes dashboard from the {{site.data.keyword.Bluemix_notm}} console**
{: #db_gui}

1.  Log in to the [{{site.data.keyword.Bluemix_notm}} console](https://cloud.ibm.com/).
2.  From the menu bar, select the account that you want to use.
3.  From the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon"), click **Kubernetes**.
4.  On the **Clusters** page, click the cluster that you want to access.
5.  From the cluster detail page, click the **Kubernetes Dashboard** button.

</br>
</br>

**Launching the Kubernetes dashboard from the CLI**
{: #db_cli}

1.  Get your credentials for Kubernetes.

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  Copy the **id-token** value that is shown in the output.

3.  Set the proxy with the default port number.

    ```
    kubectl proxy
    ```
    {: pre}

    Example output:

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  Sign in to the dashboard.

  1.  In your browser, navigate to the following URL:

      ```
      http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
      ```
      {: codeblock}

  2.  In the sign-on page, select the **Token** authentication method.

  3.  Then, paste the **id-token** value that you previously copied into the **Token** field and click **SIGN IN**.

When you are done with the Kubernetes dashboard, use `CTRL+C` to exit the `proxy` command. After you exit, the Kubernetes dashboard is no longer available. Run the `proxy` command to restart the Kubernetes dashboard.

[Next, you can run a configuration file from the dashboard.](#app_ui)

<br />


## Deploying apps with the Kubernetes dashboard
{: #app_ui}

When you deploy an app to your cluster by using the Kubernetes dashboard, a deployment resource automatically creates, updates, and manages the pods in your cluster. For more information about using the dashboard, see [the Kubernetes docs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/).
{:shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? For clusters that run Kubernetes version 1.12 or later, your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin:

-   [Install the required CLIs](/docs/containers/cs_cli_install.html#cs_cli_install).
-   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

To deploy your app:

1.  Open the Kubernetes [dashboard](#cli_dashboard) and click **+ Create**.
2.  Enter your app details in one of two ways.
  * Select **Specify app details below** and enter the details.
  * Select **Upload a YAML or JSON file** to upload your app [configuration file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

  Need help with your configuration file? Check out this [example YAML file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). In this example, a container is deployed from the **ibmliberty** image in the US-South region. Learn more about [securing your personal information](cs_secure.html#pi) when you work with Kubernetes resources.
  {: tip}

3.  Verify that you successfully deployed your app in one of the following ways.
  * In the Kubernetes dashboard, click **Deployments**. A list of successful deployments is displayed.
  * If your app is [publicly available](/docs/containers/cs_network_planning.html#public_access), navigate to the cluster overview page in your {{site.data.keyword.containerlong}} dashboard. Copy the subdomain, which is located in the cluster summary section and paste it into a browser to view your app.

<br />


## Deploying apps with the CLI
{: #app_cli}

After a cluster is created, you can deploy an app into that cluster by using the Kubernetes CLI.
{:shortdesc}

Before you begin:

-   Install the required [CLIs](/docs/containers/cs_cli_install.html#cs_cli_install).
-   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

To deploy your app:

1.  Create a configuration file based on [Kubernetes best practices ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/overview/). Generally, a configuration file contains configuration details for each of the resources you are creating in Kubernetes. Your script might include one or more of the following sections:

    -   [Deployment ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Defines the creation of pods and replica sets. A pod includes an individual containerized app and replica sets control multiple instances of pods.

    -   [Service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/): Provides front-end access to pods by using a worker node or load balancer public IP address, or a public Ingress route.

    -   [Ingress ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Specifies a type of load balancer that provides routes to access your app publicly.

    Learn more about [securing your personal information](cs_secure.html#pi) when you work with Kubernetes resources.

2.  Run the configuration file in a cluster's context.

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  If you made your app publicly available by using a nodeport service, a load balancer service, or Ingress, verify that you can access the app.

<br />


## Deploying apps to specific worker nodes by using labels
{: #node_affinity}

When you deploy an app, the app pods indiscriminately deploy to various worker nodes in your cluster. In some cases, you might want to restrict the worker nodes that the app pods to deploy to. For example, you might want app pods to only deploy to worker nodes in a certain worker pool because those worker nodes are on bare metal machines. To designate the worker nodes that app pods must deploy to, add an affinity rule to your app deployment.
{:shortdesc}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

1. Get the name of the worker pool that you want to deploy app pods to.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {:pre}

    These steps use a worker pool name as an example. To deploy app pods to certain worker nodes based on another factor, get that value instead. For example, to deploy app pods only to worker nodes on a specific VLAN, get the VLAN ID by running `ibmcloud ks vlans --zone <zone>`.
    {: tip}

2. [Add an affinity rule ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) for the worker pool name to the app deployment.

    Example yaml:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    In the **affinity** section of the example yaml, `workerPool` is the `key` and `<worker_pool_name>` is the `value`.

3. Apply the updated deployment configuration file.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. Verify that the app pods deployed to the correct worker nodes.

    1. List the pods in your cluster.
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        Example output:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. In the output, identify a pod for your app. Note the **NODE** private IP address of the worker node that the pod is on.

        In the above example output, the app pod `cf-py-d7b7d94db-vp8pq` is on a worker node with the IP address `10.176.48.78`.

    3. List the worker nodes in the worker pool that you designated in your app deployment.

        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        Example output:

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        If you created an app affinity rule based on another factor, get that value instead. For example, to verify that the app pod deployed to a worker nodes on a specific VLAN, view the VLAN that the worker node is on by running `ibmcloud ks worker-get --cluster <cluster_name_or_ID> --worker <worker_ID>`.
        {: tip}

    4. In the output, verify that the worker node with the private IP address that you identified in the previous step is deployed in this worker pool.

<br />


## Deploying an app on a GPU machine
{: #gpu_app}

If you have a [bare metal graphics processing unit (GPU) machine type](/docs/containers/cs_clusters_planning.html#shared_dedicated_node), you can schedule mathematically intensive workloads onto the worker node. For example, you might run a 3D app that uses the Compute Unified Device Architecture (CUDA) platform to share the processing load across the GPU and CPU to increase performance.
{:shortdesc}

In the following steps, you learn how to deploy workloads that require the GPU. You can also [deploy apps](#app_ui) that don't need to process their workloads across both the GPU and CPU. After, you might find it useful to play around with mathematically intensive workloads such as the [TensorFlow ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.tensorflow.org/) machine learning framework with [this Kubernetes demo ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/pachyderm/pachyderm/tree/master/examples/ml/tensorflow).

Before you begin:
* [Create a bare metal GPU machine type](/docs/containers/cs_clusters.html#clusters_cli). Note that this process can take more than 1 business day to complete.
* Your cluster master and GPU worker node must run Kubernetes version 1.10 or later.

To execute a workload on a GPU machine:
1.  Create a YAML file. In this example, a `Job` YAML manages batch-like workloads by making a short-lived pod that runs until the command that it is scheduled to complete successfully terminates.

    For GPU workloads, you must always provide the `resources: limits: nvidia.com/gpu` field in the YAML specification.
    {: note}

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>YAML components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td>Metadata and label names</td>
    <td>Give a name and a label for the job, and use the same name in both the file's metadata and the `spec template` metadata. For example, `nvidia-smi`.</td>
    </tr>
    <tr>
    <td><code>containers.image</code></td>
    <td>Provide the image that the container is a running instance of. In this example, the value is set to use the DockerHub CUDA image:<code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>containers.command</code></td>
    <td>Specify a command to run in the container. In this example, the <code>[ "/usr/test/nvidia-smi" ]</code>command refers to a binary that is on the GPU machine, so you must also set up a volume mount.</td>
    </tr>
    <tr>
    <td><code>containers.imagePullPolicy</code></td>
    <td>To pull a new image only if the image is not currently on the worker node, specify <code>IfNotPresent</code>.</td>
    </tr>
    <tr>
    <td><code>resources.limits</code></td>
    <td>For GPU machines, you must specify the resource limit. The Kubernetes [Device Plug-in![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) sets the default resource request to match the limit.
    <ul><li>You must specify the key as <code>nvidia.com/gpu</code>.</li>
    <li>Enter the whole number of GPUs that you request, such as <code>2</code>. <strong>Note</strong>: Container pods do not share GPUs and GPUs cannot be overcommitted. For example, if you have only 1 `mg1c.16x128` machine, then you have only 2 GPUs in that machine and can specify a maximum of `2`.</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>Name the volume that is mounted onto the container, such as <code>nvidia0</code>. Specify the <code>mountPath</code> on the container for the volume. In this example, the path <code>/usr/test</code> matches the path used in the job container command.</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>Name the job volume, such as <code>nvidia0</code>. In the GPU worker node's <code>hostPath</code>, specify the volume's <code>path</code> on the host, in this example, <code>/usr/bin</code>. The container <code>mountPath</code> is mapped to the host volume <code>path</code>, which gives this job access to the NVIDIA binaries on the GPU worker node for the container command to run.</td>
    </tr>
    </tbody></table>

2.  Apply the YAML file. For example:

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  Check the job pod by filtering your pods by the `nvidia-sim` label. Verify that the **STATUS** is **Completed**.

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    Example output:
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  Describe the pod to see how the GPU device plug-in scheduled the pod.
    * In the `Limits` and `Requests` fields, see that the resource limit that you specified matches the request that the device plug-in automatically set.
    * In the events, verify that the pod is assigned to your GPU worker node.

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    Example output:
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  To verify that the job used the GPU to compute its workload, you can check the logs. The `[ "/usr/test/nvidia-smi" ]` command from the job queried the GPU device state on the GPU worker node.

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    Example output:
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    In this example, you see that both GPUs were used to execute the job because both the GPUs were scheduled in the worker node. If the limit is set to 1, only 1 GPU is shown.

## Scaling apps
{: #app_scaling}

With Kubernetes, you can enable [horizontal pod autoscaling ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) to automatically increase or decrease the number of instances of your apps based on CPU.
{:shortdesc}

Looking for information about scaling Cloud Foundry applications? Check out [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). Want to scale your worker nodes instead of your pods? Check out the [cluster autoscaler preview (beta)](/docs/containers/cs_cluster_scaling.html#ca).
{: tip}

Before you begin:
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).
- Heapster monitoring must be deployed in the cluster that you want to autoscale.

Steps:

1.  Deploy your app to a cluster from the CLI. When you deploy your app, you must request CPU.

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>Command components for kubectl run</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command&apos;s components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>The application that you want to deploy.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>The required CPU for the container, which is specified in milli-cores. As an example, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>When true, creates an external service.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>The port where your app is available externally.</td>
    </tr></tbody></table>

    For more complex deployments, you might need to create a [configuration file](#app_cli).
    {: tip}

2.  Create an autoscaler and define your policy. For more information about working with the `kubectl autoscale` command, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>Command components for kubectl autoscale</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command&apos;s components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>The average CPU utilization that is maintained by the Horizontal Pod Autoscaler, which is specified as a percentage.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>The minimum number of deployed pods that are used to maintain the specified CPU utilization percentage.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>The maximum number of deployed pods that are used to maintain the specified CPU utilization percentage.</td>
    </tr>
    </tbody></table>


<br />


## Managing rolling deployments to update your apps
{: #app_rolling}

You can manage the rollout of your app changes in an automated and controlled fashion for workloads with a pod template such as deployments. If your rollout isn't going according to plan, you can roll back your deployment to the previous revision.
{:shortdesc}

Want to prevent downtime during your rolling update? Be sure to specify a [readiness probe in your deployment](#probe) so that the rollout proceeds to the next app pod after the most recently updated pod is ready.
{: tip}

Before you begin, create a [deployment](#app_cli).

1.  [Roll out ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) a change. For example, you might want to change the image that you used in your initial deployment.

    1.  Get the deployment name.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Get the pod name.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Get the name of the container that is running in the pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Set the new image for the deployment to use.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    When you run the commands, the change is immediately applied and logged in the roll-out history.

2.  Check the status of your deployment.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Roll back a change.
    1.  View the roll-out history for the deployment and identify the revision number of your last deployment.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Tip:** To see the details for a specific revision, include the revision number.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Roll back to the previous version, or specify a revision. To roll back to the previous version, use the following command.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

