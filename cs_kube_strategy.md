.
9.  **Disposability**: Design your app to be disposable, with minimal startup, graceful shutdown, and toleration for abrupt process terminations. Remember, containers, pods, and even worker nodes are meant to be disposable, so plan your app accordingly.
10.  **Dev-to-prod parity**: Set up a [continuous integration](https://www.ibm.com/cloud/garage/content/code/practice_continuous_integration/) and [continuous development](https://www.ibm.com/cloud/garage/content/deliver/practice_continuous_delivery/) pipeline for your app, with minimal difference between the app in development and the app in prod.
11.  **Logs**: Treat logs as event streams: the outer or hosting environment processes and routes log files. **Important**: In {{site.data.keyword.containerlong_notm}}, logs are not turned on by default. To enable, see [Configuring log forwarding](/docs/containers/cs_health.html#configuring).
12.  **Admin processes**: Keep any one-time admin scripts with the app as a [Kubernetes Job object ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) to ensure that the admin scripts run with the same environment as the app itself. For orchestration of larger packages that you want to run in your Kubernetes clusters, consider using a package manager such as [Helm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://helm.sh/).

### I already have an app. How can I migrate it to {{site.data.keyword.containerlong_notm}}?
You can take some general steps to containerize your app as follows.

1.  Use the [Twelve-Factor App ![External link icon](../icons/launch-glyph.svg "External link icon")](https://12factor.net/) as a guide for isolating dependencies, separating processes into separate services, and reducing the statefulness of your app as much as possible.
2.  Find an appropriate base image to use. You can use publicly available images from [Docker Hub ![External link icon](../icons/launch-glyph.svg "External link icon")](https://hub.docker.com/), [public IBM images](/docs/services/RegistryImages/index.html#ibm_images), or build and manage your own in your private {{site.data.keyword.registryshort_notm}}.
3.  Add to your Docker image only what is necessary to run the app.
4.  Instead of relying on local storage, plan to use persistent storage or cloud database-as-a-service solutions to back up your app's data.
5.  Over time, refactor your app processes into microservices.

For more, see the following tutorials:
*  [Migrating an app from Cloud Foundry to a cluster](/docs/containers/cs_tutorials_cf.html#cf_tutorial)
*  [Moving a VM based app to Kubernetes](/docs/tutorials/vm-to-containers-and-kubernetes.html#moving-a-vm-based-app-to-kubernetes)



Continue with the following topics for more considerations when you move workloads, such as Kubernetes environments, high availability, service discovery, and deployments.

## Sizing your Kubernetes cluster to support your workload
{: #sizing}

Figuring out how many worker nodes you need in your cluster to support your workload is not an exact science. You might need to test different configurations and adapt. Good thing that you are using {{site.data.keyword.containerlong_notm}}, where you can add and remove worker nodes in response to your workload demands.
{: shortdesc}

To get started on sizing your cluster, ask yourself the following questions.

### How many resources does my app require?
First, let's begin with your existing or project workload usage.

1.  Calculate your workload's average CPU and memory usage. For example, you might view the Task Manager on a Windows machine, or run the `top` command on a Mac or Linux. You might also use a metrics service and run reports to calculate workload usage.
2.  Anticipate the number of requests that your workload must serve so that you can decide how many app replicas you want to handle the workload. For example, you might design an app instance to handle 1000 requests per minute and anticipate that your workload must serve 10000 requests per minute. If so, you might decide to make 12 app replicas, with 10 to handle the anticipated amount and an extra 2 for surge capacity.

### What else besides my app might use resources in the cluster?

Now let's add some other features that you might use.



1.  Consider if your app pulls large or many images, which can take up local storage on the worker node.
2.  Decide if you want to [integrate services](/docs/containers/cs_integrations.html#integrations) into your cluster, such as [Helm](/docs/containers/cs_integrations.html#helm) or [Prometheus ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus). These integrated services and add-ons spin up pods that consume cluster resources.

### What type of availability do I want my workload to have?
Don't forget that you want your workload to be up as much as possible!

1.  Plan out your strategy for [highly avaiable clusters](/docs/containers/cs_clusters_planning.html#ha_clusters), such as deciding between single or multizone clusters.
2.  Review [highly available deployments](/docs/containers/cs_app.html#highly_available_apps) to help decide how you can make your app available.

### How many worker nodes do I need to handle my workload?
Now that you have a good idea of what your workload looks like, let's map the estimated usage onto your available cluster configurations.

1.  Estimate the max worker node capacity, which depends on what type of cluster you have. You don't want to max out worker node capacity in case a surge or other temporary event happens.
    *  **Single zone clusters**: Plan to have at least 3 worker nodes in your cluster. Further, you want 1 extra node's worth of CPU and memory capacity available within the cluster.
    *  **Multizone clusters**: Plan to have at least 2 worker nodes per zone, so 6 nodes across 3 zones in total. Additionally, plan for the total capacity of your cluster to be at least 150% of your total workload's required capacity, so that if 1 zone goes down, you have resources available to maintain the workkload.
2.  Align the app size and worker node capacity with one of the [available worker node flavors](/docs/containers/cs_clusters_planning.html#shared_dedicated_node). To see available flavors in a zone, run `ibmcloud ks machine-types <zone>`.
    *  **Larger vs. smaller worker node flavors**: Larger nodes can be more cost efficient than smaller nodes, particularly for workloads that are designed to gain efficiency when they process on a high-performance machine. However, if a large worker node goes down, you need to be sure that your cluster has enough capacity to gracefully reschedule all the workload pods onto other worker nodes in the cluster. Smaller worker can help you scale more gracefully.
    *  **Replicas of your app**: To determine the number of worker nodes that you want, you can also consider how many replicas of your app that you want to run. For example, if you know that your workload requires 32 CPU cores, and you plan to run 16 replicas of your app, each replica pod needs 2 CPU cores. If you want to run only one app pod per worker node, you can order an appropriate number of worker nodes for your cluster type to support this configuration.

## Structuring your Kubernetes environment
{: #kube_env}

Your {{site.data.keyword.containerlong_notm}} is linked to one IBM Cloud infrastructure (SoftLayer) portfolio only. Within your account, you can create clusters that are composed of a master and various worker nodes. IBM manages the master, and you can create a mix of worker pools that pool together individual machines of the same flavor, or memory and CPU specs. Within the cluster, you can further organize resources by using namespaces and labels. Choose the right mix of cluster, machine types, and organization strategies so that you can make sure that your teams and workloads get the resources that they need.
{:shortdesc}

### What type of cluster and machine types should I get?



**Types of worker nodes**: In general, your intensive workloads are more suited to run on bare metal physical machines, whereas for cost-effective testing and development work, you might choose shared hardware virtual machines. Virtual machines also offer different isolation levels. [Check out the machine isolation and flavors that are available](/docs/containers/cs_clusters_planning.html#planning_worker_nodes).



### Do I use multiple clusters, or just add more workers to an existing cluster?
The number of clusters that you create depends on your workload, company policies and regulations, and what you want to do with the computing resources. You can also review security information about this decision in [Container isolation and security](/docs/containers/cs_secure.html#container).

**Multiple clusters**: You need to set up [a global load balancer](/docs/containers/cs_clusters_planning.html#multiple_clusters) and copy and apply the same configuration YAML files in each to balance workloads across the clusters. Therefore, multiple clusters are generally more complex to manage, but can help you achieve important goals such as the following.
*  Comply with security policies that require you to isolate workloads.
*  Test how your app runs in a different version of Kubernetes or other cluster software such as Calico.
*  Create a cluster with your app in another region for higher performance for users in that geographical area.
*  Configure user access on the cluster-instance level instead of customizing and managing multiple RBAC policies to control access within a cluster at the namespace level.

**Fewer or single clusters**: Fewer clusters can help you to reduce operational overhead and per-cluster costs for fixed resources. Instead of making more clusters, you can add worker pools for different machine types of computing resources available for the app and service components that you want to use. When you develop the app, the resources it uses are in the same zone, or otherwise closely connected in a multizone, so that you can make assumptions about latency, bandwidth, or correlated failures. However, it becomes even more important for you to organize your cluster by using namespaces, resource quotas, and labels.



### How can I set up my resources within the cluster?

<dl>
<dt>Consider your worker node capacity.</dt>
  <dd>To get the most out of your worker node's performance, consider the following:
  <ul><li><strong>Keep up your core strength</strong>: Each machine has a certain number of cores. Depending on your app's workload, set a limit for the number of pods per core, such as 10.</li>
  <li><strong>Avoid node overload</strong>: Similarly, just because a node can contain more than 100 pods doesn't mean that you want it to. Depending on your app's workload, set a limit for the number of pods per node, such as 40.</li>
  <li><strong>Don't tap out your cluster bandwidth</strong>: Keep in mind that network bandwidth on scaling virtual machines is around 1000 Mbps. If you need hundreds of worker nodes in a cluster, split it up into multiple clusters with fewer nodes, or order bare metal nodes.</li>
  <li><strong>Sorting out your services</strong>: Plan out how many services that you need for your workload before you deploy. Networking and port forwarding rules are put into iptables. If you anticipate a larger number of services, such as more than 5,000 services, split up the cluster into multiple clusters.</li></ul></dd>
<dt>Provision different types of machines for a mix of computing resources.</dt>
  <dd>Everyone likes choices, right? With {{site.data.keyword.containerlong_notm}}, you have [a mix of machine types](/docs/containers/cs_clusters_planning.html#planning_worker_nodes) that you can deploy: from bare metal for intensive workloads to virtual machines for rapid scaling. Use labels or namespaces to organize deployments to your machines. When you create a deployment, limit it so that your app's pod only deploys on machines with the right mix of resources. For example, you might want to limit a database application to a bare metal machine with a significant amount of local disk storage like the `md1c.28x512.4x4tb`.</dd>
<dt>Set up multiple namespaces when you have multiple teams and projects that share the cluster.</dt>
  <dd><p>Namespaces are kind of like a cluster within the cluster. They are a way to divide up cluster resources by using [resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) and [default limits ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/memory-default-namespace/). When you make new namespaces, be sure to set up proper [RBAC policies](/docs/containers/cs_users.html#rbac) to control access. For more information, see [Share a cluster with namespaces ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/namespaces/) in the Kubernetes documentation.</p>
  <p>If you have a small cluster, a couple dozen users, and resources that are similar (such as different versions of the same software), you probably don't need multiple namespaces. You can use labels instead.</p></dd>
<dt>Set resource quotas so that users in your cluster must use resource requests and limits</dt>
<dd>To ensure that every team has the necessary resources to deploy services and run apps in the cluster, you must set up [resource quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/) for every namespace. Resource quotas determine the deployment constraints for a namespace, such as the number of Kubernetes resources that you can deploy, and the amount of CPU and memory that can be consumed by those resources. After you set a quota, users must include resource requests and limits in their deployments.</dd>
<dt>Organize your Kubernetes objects with labels</dt>
<dd><p>[Attach labels to objects in Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/), such as pods or nodes, to organize and select your resources. By default, {{site.data.keyword.containerlong}} applies some labels, including `arch`, `os`, `region`, `zone`, and `machine-type`.</p>
<p>Example use cases for labels include [limiting network traffic to edge worker nodes](/docs/containers/cs_edge.html), [deploying an app to a GPU machine](/docs/containers/cs_app.html#gpu_app), and [restricting your app workloads![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) to run on nodes that meet certain machine type or SSD capabilities, such as bare metal worker nodes. To see what labels are already applied to an object, use the <code>kubectl get</code> command with the <code>--show-labels</code> flag. For example:</p>
<p><pre class="pre"><code>kubectl get node &lt;node_ID&gt; --show-labels</code></pre></p></dd>

</dl>



## Making your resources highly available
{: #kube_ha}

While no system is entirely failsafe, you can take steps to increase your the high availability of your apps and services in {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Review more information about making resources highly available.
* [Reduce potential points of failure](/docs/containers/cs_ha.html#ha).
* [Create multizone clusters](/docs/containers/cs_clusters_planning.html#ha_clusters).
* [Plan highly available deployments](/docs/containers/cs_app.html#highly_available_apps) that use features such as replica sets and pod anti-affinity across multizones.
* [Run containers that are based on images in a cloud-based public registry](/docs/containers/cs_images.html).
* [Plan data storage](/docs/containers/cs_storage_planning.html#persistent_storage_overview). Especially for multizone clusters, consider using a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).
* For multizone clusters, enable a [load balancer service](/docs/containers/cs_loadbalancer.html#multi_zone_config) or the Ingress [multizone load balancer](/docs/containers/cs_ingress.html#ingress) to expose your apps publicly.

## Setting up service discovery
{: #service_discovery}

Each of your pods in your Kubernetes cluster has an IP address. But when you deploy an app to your cluster, you don't want to rely on the pod IP address for service discovery and networking. Pods are removed and replaced frequently and dynamically. Instead, use a Kubernetes service, which represents a group of pods and provides a stable entry point through the service's virtual IP address, called its `cluster IP`. For more information, see the Kubernetes documentation on [Services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/#discovering-services).
{:shortdesc}



### How can I make sure that my services are connected to the right deployments and ready to go?
For most services, add a selector to your service `.yaml` file so that it applies to pods that run your apps by that label. Many times when your app first starts up, you don't want it to process requests right away. Add a readiness probe to your deployment so that traffic is only sent to a pod that is considered ready. For an example of a deployment with a service that uses labels and sets a readiness probe, check out this [nginx yaml](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml).

Sometimes, you don't want the service to use a label. For example, you might have an external database or want to point the service to another service in a different namespace within the cluster. When this happens, you have to manually add an endpoints object and link it to the service.


### How do I control network traffic among the services that run in my cluster?
By default, pods can communicate with other pods in the cluster, but you can block traffic to certain pods or namespaces with network policies. Additionally, if you expose your app externally by using a NodePort, load balancer, or Ingress service, you might want to set up advanced network policies to block traffic. In {{site.data.keyword.containerlong_notm}}, you can use Calico to manage Kubernetes and Calico [network policies to control traffic](/docs/containers/cs_network_policy.html#network_policies).

If you have a variety of microservices that run across platforms for which you need to connect, manage, and secure network traffic, consider using a service mesh tool such as [Istio](/docs/containers/cs_tutorials_istio.html#istio_tutorial).

You can also [set up edge nodes](/docs/containers/cs_edge.html#edge) to increase the security and isolation of your cluster by restricting the networking workload to select worker nodes.



### How can I expose my services on the Internet?
You can create three types of services for external networking: NodePort, LoadBalancer, and Ingress. For more information, see [Planning networking services](/docs/containers/cs_network_planning.html#external).



## Deploying app workloads to clusters
{: #deployments}

With Kubernetes, you declare many types of objects in YAML configuration files such as pods, deployments, and jobs. These objects describe things like what containerized apps are running, what resources they use, and what policies manage their behavior for restarting, updating, replicating, and more. [Configuration best practices ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/overview/)

### I thought that I needed to put my app in a container. Now what's all this stuff about pods?
A [pod ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/pod/) is the smallest deployable unit that Kubernetes can manage. You put your container (or a group of containers) into a pod and use the pod configuration file to tell the pod how to run the container and share resources with other pods. Whatever you put in a pod runs in a shared context, which means that they work in sync on the same virtual or physical machine.

**What to put in a container**: As you think about your application's components, consider whether they have significantly different resource requirements for things like CPU and memory. Could some components run at a best effort, where going down for a little while to divert resources to other areas is acceptable? Is another component customer-facing, so it's critical for it to stay up? Split them up into separate containers. You can always deploy them to the same pod so that they run together in sync.

**What to put in a pod**: The containers for your app don't always have to be in the same pod. In fact, if you have a component that is stateful and difficult to scale, such as a database service, put it in a different pod that you can schedule on a worker node with more resources to handle the workload. If your containers work can work correctly if they run on different worker nodes, then use multiple pods. If they need to be on the same machine and scale together, group the containers into the same pod.

### So if I can just use a pod, why do I need all these different types of objects?
Creating a pod YAML file is easy. You can write one with just a few lines as follows.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```
{: codeblock}

But you don't want to stop there. If the node that your pod runs on goes down, then your pod goes down with it and isn't rescheduled. Instead, use a [deployment ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to support pod rescheduling, replica sets, and rolling updates. A basic deployment is almost as easy to make as a pod. Instead of defining the container in the `spec` by itself, however, you specify `replicas` and a `template` in the deployment `spec`. The template has its own `spec` for the containers within it, such as follows.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  template:
    metadata:
      name: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```
{: codeblock}

You can keep adding features, such as pod anti-affinity or resource limits, all in the same YAML file.

For a more detailed explanation of different features that you can add to your deployment, take a look at [Making your app deployment YAML file](/docs/containers/cs_app.html#app_yaml).
{: tip}

### How can I organize my deployments to make them easier to update and manage?
{: #organize}

Now that you have a good idea of what to include in your deployment, you might wonder how are you going to manage all these different YAML files? Not to mention the objects that they create in your Kubernetes environment!

A few tips for organizing deployment YAML files:
*  Use a version-control system, such as Git.
*  Group closely related Kubernetes objects within a single YAML file. For example, if you are creating a `deployment`, you might also add the `service` file to the YAML. Separate objects with `---` such as follows:
    ```yaml
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
    ...
    ---
    apiVersion: v1
    kind: Service
    metadata:
    ...
    ```
    {: codeblock}
*  You can use the `kubectl apply -f` command to apply to an entire directory, not just a single file.

Within the YAML file, you can use labels or annotations as metadata to manage your deployments.

**Labels**: [Labels ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) are `key:value` pairs that can be attached to Kubernetes objects such as pods and deployments. They can be whatever you want, and are useful for selecting objects based on the label information. Labels provide the foundation for grouping objects. Some ideas for labels:
* `app: nginx`
* `version: v1`
* `env: dev`

**Annotations**: [Annotations ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) are similar to labels in that they are also `key:value` pairs. They are better for non-identifying information that can be leveraged by tools or libraries, such as holding extra information about where an object came from, how to use the object, pointers to related tracking repos, or a policy about the object. You don't select objects based on annotations.

### What else can I do to prepare my app for deployment?
Many things! See [Preparing your containerized app to run in clusters](/docs/containers/cs_app.html#plan_apps). The topic includes information about:
*  The kinds of apps you can run in Kubernetes, including tips for stateful and statless apps.
*  Migrating apps to Kubernetes.
*  Sizing your cluster based on your workload requirements.
*  Setting up additional app resources such as IBM services, storage, logging, and monitoring.
*  Using variables within your deploymnet.
*  Controlling access to your app.







</staging>
