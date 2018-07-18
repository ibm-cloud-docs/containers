.html#planning_worker_nodes). 

### Do I use multiple clusters, or just add more workers to an existing cluster?
The number of clusters that you create depends on your workload, company policies and regulations, and what you want to do with the computing resources. You can also review security information about this decision in [Container isolation and security](cs_secure.html#container).

**Multiple clusters**: You need to set up [a global load balancer](cs_clusters.html#multiple_clusters) and copy and apply the same configuration YAML files in each to balance workloads across the clusters. Therefore, multiple clusters are generally more complex to manage, but can help you achieve important goals such as the following.
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
  <dd>Everyone likes choices, right? With {{site.data.keyword.containershort_notm}}, you have [a mix of machine types](cs_clusters.html#planning_worker_nodes) that you can deploy: from bare metal for intensive workloads to virtual machines for rapid scaling. Use labels or namespaces to organize deployments to your machines. When you create a deployment, limit it so that your app's pod only deploys on machines with the right mix of resources. For example, you might want to limit a database application to a bare metal machine with a significant amount of local disk storage like the `md1c.28x512.4x4tb`.</dd>
<dt>Set up multiple namespaces when you have multiple teams and projects that share the cluster.</dt>
  <dd><p>Namespaces are kind of like a cluster within the cluster. They are a way to divide up cluster resources by using [resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) and [default limits ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/memory-default-namespace/). When you make new namespaces, be sure to set up proper [RBAC policies](cs_users.html#rbac) to control access. For more information, see [Share a cluster with namespaces ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/namespaces/) in the Kubernetes documentation.</p>
  <p>If you have a small cluster, a couple dozen users, and resources that are similar (such as different versions of the same software), you probably don't need multiple namespaces. You can use labels instead.</p></dd>
<dt>Organize your Kubernetes objects with labels</dt>
<dd><p>[Attach labels to objects in Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/), such as pods or nodes, to organize and select your resources. By default, {{site.data.keyword.containershort}} applies some labels, including `arch`, `os`, `region`, `zone`, and `machine-type`.</p>
<p>Example use cases for labels include [limiting network traffic to edge worker nodes](cs_edge.html), [deploying an app to a GPU machine](cs_app.html#gpu_app), and [restricting your app workloads![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) to run on nodes that meet certain machine type or SSD capabilities, such as bare metal worker nodes. To see what labels are already applied to an object, use the <code>kubectl get</code> command with the <code>--show-labels</code> flag. For example:</p>
<p><pre class="pre"><code>kubectl get node &lt;node_ID&gt; --show-labels</code></pre></p></dd>

</dl>

## Making your resources highly available
{: #ha}

While no system is entirely failsafe, you can take steps to increase your the high availability of your apps and services in {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Review more information about making resources highly available.
* [Reduce potential points of failure](cs_ha.html#ha).
* [Create multizone clusters](cs_clusters_planning.html#ha_clusters).
* [Plan highly available deployments](cs_app.html#highly_available_apps) that use features such as replica sets and pod anti-affinity across multizones.
* [Run containers that are based on images in a cloud-based public registry](cs_images.html#planning).
* [Plan data storage](cs_storage.html#persistent). Especially for multizone clusters, consider using a cloud service such as [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) or [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).
* For multizone clusters, enable [LoadBalancer service](cs_loadbalancer.html#multi_zone_config) or the Ingress [multizone load balancer](cs_ingress.html#ingress) to expose your apps publicly.

## Setting up service discovery
{: #service_discovery}

Each of your pods in your Kubernetes cluster has an IP address. But when you deploy an app to your cluster, you don't want to rely on the pod IP address for service discovery and networking. Pods are removed and replaced frequently and dynamically. Instead, use a Kubernetes service, which represents a group of pods and provides a stable entry point through the service's virtual IP address, called its `cluster IP`. For more information, see the Kubernetes documentation on [Services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/#discovering-services).
{:shortdesc}



### How can I make sure that my services are connected to the right deployments and ready to go?
For most services, add a selector to your service `.yaml` file so that it applies to pods that run your apps by that label. Many times when your app first starts up, you don't want it to process requests right away. Add a readiness probe to your deployment so that traffic is only sent to a pod that is considered ready. For an example of a deployment with a service that uses labels and sets a readiness probe, check out this [nginx yaml](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml).

Sometimes, you don't want the service to use a label. For example, you might have an external database or want to point the service to another service in a different namespace within the cluster. When this happens, you have to manually add an endpoints object and link it to the service.


### How do I control network traffic among the services that run in my cluster?
By default, pods can communicate with other pods in the cluster, but you can block traffic to certain pods or namespaces with network policies. Additionally, if you expose your app externally by using a NodePort, LoadBalancer, or Ingress service, you might want to set up advanced network policies to block traffic. In {{site.data.keyword.containershort_notm}}, you can use Calico to manage Kubernetes and Calico [network policies to control traffic](cs_network_policy.html#network_policies).

If you have a variety of microservices that run across platforms for which you need to connect, manage, and secure network traffic, consider using a service mesh tool such as [Istio](cs_tutorials_istio.html#istio_tutorial).

You can also [set up edge nodes](cs_edge.html#edge) to increase the security and isolation of your cluster by restricting the networking workload to select worker nodes.

### How can I expose my services on the Internet?
You can create three types of services for external networking: NodePort, LoadBalancer, and Ingress. For more information, see [Planning networking services](cs_network_planning.html#planning).

## Configuring your containerized app deployments
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

But you don't want to stop there. If the node that your pod runs on goes down, then your pod goes down with it and isn't rescheduled. Instead, use a [Deployment ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to support pod rescheduling, replica sets, and rolling updates. A basic deployment is almost as easy to make as a pod. Instead of defining the container in the `spec` by itself, however, you specify `replicas` and a `template` in the deployment `spec`. The template has its own `spec` for the containers within it, such as follows.

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

### But what if I want my deployment to use variables? How do I add these to the YAML?
To add variable information to your deployments instead of hard-coding the data into the YAML file, you can use a [configmap ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/) or a [secret ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/secret/). 

To consume a configmap or secret, you need to mount it to the pod. The configmap or secret is combined with the pod just before the pod is run. You can reuse a deployment spec and image across many apps, but then swap out the customized configmaps and secrets. Secrets in particular can take up a lot of storage on the local node, so plan accordingly.

Both are basically key-value pairs, but you use them for different situations. 

<dl>
<dt>Configmap</dt>
<dd>Provide non-sensitive configuration information for workloads that are specified in a deployment. You can use configmaps in three main ways.
<ul><li><strong>Filesystem</strong>: You can mount an entire file or a set of variables to a pod. A file is created for each entry based on the key name contents of the file that are set to the value.</li>
<li><strong>Environment variable</strong>: Dynamically set the environment variable for a container spec.</li>
<li><strong>Command-line argument</strong>: Set the command-line argument that is used in a container spec.</li></ul></dd>

<dt>Secret</dt>
<dd>Provide sensitive information to your workloads, such as follows. Note that other users of the cluster might have access to the secret, so be sure that you know the secret information can be shared with those users.
<ul><li><strong>Personally identifiable information (PII)</strong>: Store sensitive information such as email addresses or other types of information that are required for company compliance or government regulation in secrets.</li>
<li><strong>Credentials</strong>: Put credentials such as passwords, keys, and tokens in a secret to reduce the risk of accidental exposure.</li>
</dl>




</staging>
