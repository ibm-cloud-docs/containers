---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-30"

keywords: kubernetes, iks, node.js, js, java, .net, go, flask, react, python, swift, rails, ruby, spring boot, angular

subcollection: containers

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



# Deploying Kubernetes-native apps
{: #app}

After you [plan your Kubernetes app](/docs/containers?topic=containers-plan_apps), you can quickly deploy, scale, and manage updates for your app by using Kubernetes-native technology.
{:shortdesc}

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
| [`StatefulSet` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) | Similar to deployments, a stateful set is a controller that manages a replica set of pods. Unlike deployments, a stateful set ensures that your pod has a unique network identity that maintains its state across rescheduling. When you want to run workloads in the cloud, try to [design your app to be stateless](/docs/containers?topic=containers-strategy#cloud_workloads) so that your service instances are independent from each other and can fail without a service interruption. However, some apps, such as databases, must be stateful. For those cases, consider to create a stateful set and use [file](/docs/containers?topic=containers-file_storage#file_statefulset), [block](/docs/containers?topic=containers-block_storage#block_statefulset), or [object](/docs/containers?topic=containers-object_storage#cos_statefulset) storage as the persistent storage for your stateful set. You can also install [Portworx](/docs/containers?topic=containers-portworx) on top of your bare metal worker nodes and use Portworx as a highly available software-defined storage solution to manage persistent storage for your stateful set. |
| [`DaemonSet` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) | Use a daemon set when you must run the same pod on every worker node in your cluster. Pods that are managed by a daemon set are automatically scheduled when a worker node is added to a cluster. Typical use cases include log collectors, such as `logstash` or `prometheus`, that collect logs from every worker node to provide insight into the health of a cluster or an app. |
| [`Job` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) | A job ensures that one or more pods run successfully to completion. You might use a job for queues or batch jobs to support parallel processing of separate but related work items, such as a certain number of frames to render, emails to send, and files to convert. To schedule a job to run at certain times, use a [`CronJob` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).|
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
* [Services](#app-service) to expose the app service on a port
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
<ul><li><strong>File system</strong>: You can mount an entire file or a set of variables to a pod. A file is created for each entry based on the key name contents of the file that are set to the value.</li>
<li><strong>Environment variable</strong>: Dynamically set the environment variable for a container spec.</li>
<li><strong>Command-line argument</strong>: Set the command-line argument that is used in a container spec.</li></ul></dd>

<dt>Secret</dt>
<dd>Provide sensitive information to your workloads, such as follows. Note that other users of the cluster might have access to the secret, so be sure that you know the secret information can be shared with those users.
<ul><li><strong>Personally identifiable information (PII)</strong>: Store sensitive information such as email addresses or other types of information that are required for company compliance or government regulation in secrets.</li>
<li><strong>Credentials</strong>: Put credentials such as passwords, keys, and tokens in a secret to reduce the risk of accidental exposure. For example, when you [bind a service](/docs/containers?topic=containers-service-binding#bind-services) to your cluster, the credentials are stored in a secret.</li></ul></dd>
</dl>

Want to make your secrets even more secured? Ask your cluster admin to [enable {{site.data.keyword.keymanagementservicefull}}](/docs/containers?topic=containers-encryption#keyprotect) in your cluster to encrypt new and existing secrets.
{: tip}

### How can I add IBM services to my app, such as Watson?
See [Adding services to apps](/docs/containers?topic=containers-service-binding#adding_app).

### How can I make sure that my app has the right resources?
When you [specify your app YAML file](#app_yaml), you can add Kubernetes functionalities to your app configuration that help your app get the right resources. In particular, [set resource limits and requests ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for each container that is defined in your YAML file.
{: shortdesc}

Additionally, your cluster admin might set up resource controls that can affect your app deployment, such as the following.
*  [Resource quotas ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
*  [Pod priority](/docs/containers?topic=containers-pod_priority#pod_priority)

### How can I access my app?
You can access your app privately within the cluster by [using a `clusterIP` service](/docs/containers?topic=containers-cs_network_planning#in-cluster).
{: shortdesc}

If you want to expose your app publicly, you have different options that depend on your cluster type.
*  **Free cluster**: You can expose your app by using a [NodePort service](/docs/containers?topic=containers-nodeport#nodeport).
*  **Standard cluster**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#external).
*  **Cluster that is made private by using Calico**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#private_both_vlans). You also must use a Calico preDNAT network policy to block the public node ports.
*  **Private VLAN-only standard cluster**: You can expose your app by using a [NodePort, load balancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan). You also must open the port for the service's private IP address in your firewall.

### After I deploy my app, how can I monitor its health?
You can set up {{site.data.keyword.Bluemix_notm}} [logging and monitoring](/docs/containers?topic=containers-health#health) for your cluster. You might also choose to integrate with a third-party [logging or monitoring service](/docs/containers?topic=containers-supported_integrations#health_services).
{: shortdesc}

### How can I keep my app up-to-date?
If you want to dynamically add and remove apps in response to workload usage, see [Scaling apps](/docs/containers?topic=containers-app#app_scaling).
{: shortdesc}

If you want to manage updates to your app, see [Managing rolling deployments](/docs/containers?topic=containers-app#app_rolling).

### How can I control who has access to my app deployments?
The account and cluster administrators can control access on many different levels: the cluster, Kubernetes namespace, pod, and container.
{: shortdesc}

With {{site.data.keyword.Bluemix_notm}} IAM, you can assign permissions to individual users, groups, or service accounts at the cluster-instance level.  You can scope cluster access down further by restricting users to particular namespaces within the cluster. For more information, see [Assigning cluster access](/docs/containers?topic=containers-users#users).

To control access at the pod level, you can [configure pod security policies with Kubernetes RBAC](/docs/containers?topic=containers-psp#psp).

Within the app deployment YAML, you can set the security context for a pod or container. For more information, review the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/).

Want to control access at the application level? To create a sign-on flow that you can update at anytime without changing your app code try using [{{site.data.keyword.appid_long_notm}}](/docs/services/appid?topic=appid-getting-started).
{: tip}


## Deploying apps with the Kubernetes dashboard
{: #app_ui}

When you deploy an app to your cluster by using the Kubernetes dashboard, a deployment resource automatically creates, updates, and manages the pods in your cluster. For more information about using the dashboard, see [the Kubernetes docs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/).
{:shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? For clusters that run Kubernetes version 1.12 or later, your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin:

-   [Install the required CLIs](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).
-   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
-   Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources.
-   To [launch the Kubernetes dashboard from the console](#db_gui), you must be assigned a [platform role](/docs/containers?topic=containers-users#platform). If you are assigned only a service role but no platform role, [launch the Kubernetes dashboard from the CLI](#db_cli).

To deploy your app:

1.  Open the Kubernetes [dashboard](#cli_dashboard) and click **+ Create**.
2.  Enter your app details in one of two ways.
  * Select **Specify app details below** and enter the details.
  * Select **Upload a YAML or JSON file** to upload your app [configuration file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

  Need help with your configuration file? Check out this [example YAML file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). In this example, a container is deployed from the **ibmliberty** image in the US-South region. Learn more about [securing your personal information](/docs/containers?topic=containers-security#pi) when you work with Kubernetes resources.
  {: tip}

3.  Verify that you successfully deployed your app in one of the following ways.
  * In the Kubernetes dashboard, click **Deployments**. A list of successful deployments is displayed.
  * If your app is [publicly available](/docs/containers?topic=containers-cs_network_planning#public_access), navigate to the cluster overview page in your {{site.data.keyword.containerlong}} dashboard. Copy the subdomain, which is located in the cluster summary section and paste it into a browser to view your app.

<br />


## Deploying apps with the CLI
{: #app_cli}

After a cluster is created, you can deploy an app into that cluster by using the Kubernetes CLI.
{:shortdesc}

Before you begin:

-   Install the required [CLIs](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).
-   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
-   Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To deploy your app:

1.  Create a configuration file based on [Kubernetes best practices ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/overview/). Generally, a configuration file contains configuration details for each of the resources you are creating in Kubernetes. Your script might include one or more of the following sections:

    -   [Deployment ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Defines the creation of pods and replica sets. A pod includes an individual containerized app and replica sets control multiple instances of pods.

    -   [Service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/): Provides front-end access to pods by using a worker node or load balancer public IP address, or a public Ingress route.

    -   [Ingress ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Specifies a type of load balancer that provides routes to access your app publicly.

    Learn more about [securing your personal information](/docs/containers?topic=containers-security#pi) when you work with Kubernetes resources.

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

Before you begin:
*   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
*   Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To deploy apps to specific worker nodes:

1.  Get the ID of the worker pool that you want to deploy app pods to.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2.  List the worker nodes that are in the worker pool, and note one of the **Private IP** addresses.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
    ```
    {: pre}

3.  Describe the worker node. In the **Labels** output, note the worker pool ID label, `ibm-cloud.kubernetes.io/worker-pool-id`.

    <p class="tip">The steps in this topic use a worker pool ID to deploy app pods only to worker nodes within that worker pool. To deploy app pods to specific worker nodes by using a different label, note this label instead. For example, to deploy app pods only to worker nodes on a specific private VLAN, use the `privateVLAN=` label.</p>

    ```
    kubectl describe node <worker_node_private_IP>
    ```
    {: pre}

    Example output:
    ```
    Name:               10.xxx.xx.xxx
    Roles:              <none>
    Labels:             arch=amd64
                        beta.kubernetes.io/arch=amd64
                        beta.kubernetes.io/instance-type=b3c.4x16.encrypted
                        beta.kubernetes.io/os=linux
                        failure-domain.beta.kubernetes.io/region=us-south
                        failure-domain.beta.kubernetes.io/zone=dal10
                        ibm-cloud.kubernetes.io/encrypted-docker-data=true
                        ibm-cloud.kubernetes.io/ha-worker=true
                        ibm-cloud.kubernetes.io/iaas-provider=softlayer
                        ibm-cloud.kubernetes.io/machine-type=b3c.4x16.encrypted
                        ibm-cloud.kubernetes.io/sgx-enabled=false
                        ibm-cloud.kubernetes.io/worker-pool-id=00a11aa1a11aa11a1111a1111aaa11aa-11a11a
                        ibm-cloud.kubernetes.io/worker-version=1.12.7_1534
                        kubernetes.io/hostname=10.xxx.xx.xxx
                        privateVLAN=1234567
                        publicVLAN=7654321
    Annotations:        node.alpha.kubernetes.io/ttl=0
    ...
    ```
    {: screen}

4. [Add an affinity rule ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) for the worker pool ID label to the app deployment.

    Example YAML:

    ```
    apiVersion: apps/v1
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
                  - key: ibm-cloud.kubernetes.io/worker-pool-id
                    operator: In
                    values:
                    - <worker_pool_ID>
    ...
    ```
    {: codeblock}

    In the **affinity** section of the example YAML, `ibm-cloud.kubernetes.io/worker-pool-id` is the `key` and `<worker_pool_ID>` is the `value`.

5. Apply the updated deployment configuration file.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

6. Verify that the app pods deployed to the correct worker nodes.

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

        In the previous example output, the app pod `cf-py-d7b7d94db-vp8pq` is on a worker node with the IP address `10.xxx.xx.xxx`.

    3. List the worker nodes in the worker pool that you designated in your app deployment.

        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

        Example output:

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b3c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b3c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b3c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        If you created an app affinity rule based on another factor, get that value instead. For example, to verify that the app pod deployed to a worker nodes on a specific VLAN, view the VLAN that the worker node is on by running `ibmcloud ks worker-get --cluster <cluster_name_or_ID> --worker <worker_ID>`.
        {: tip}

    4. In the output, verify that the worker node with the private IP address that you identified in the previous step is deployed in this worker pool.

<br />


## Deploying an app on a GPU machine
{: #gpu_app}

If you have a [bare metal graphics processing unit (GPU) machine type](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node), you can schedule mathematically intensive workloads onto the worker node. For example, you might run a 3D app that uses the Compute Unified Device Architecture (CUDA) platform to share the processing load across the GPU and CPU to increase performance.
{:shortdesc}

In the following steps, you learn how to deploy workloads that require the GPU. You can also [deploy apps](#app_ui) that don't need to process their workloads across both the GPU and CPU. After, you might find it useful to play around with mathematically intensive workloads such as the [TensorFlow ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.tensorflow.org/) machine learning framework with [this Kubernetes demo ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/pachyderm/pachyderm/tree/master/examples/ml/tensorflow).

Before you begin:
* [Create a bare metal GPU machine type](/docs/containers?topic=containers-clusters#clusters_ui). Note that this process can take more than 1 business day to complete.
* Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

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

    <table summary="A table that describes in Column 1 the YAML file fields and in Column 2 how to fill out those fields.">
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
    <td>Specify a command to run in the container. In this example, the <code>[ "/usr/test/nvidia-smi" ]</code>command refers to a binary file that is on the GPU machine, so you must also set up a volume mount.</td>
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


## Launching the Kubernetes dashboard
{: #cli_dashboard}

Open a Kubernetes dashboard on your local system to view information about a cluster and its worker nodes. [In the {{site.data.keyword.Bluemix_notm}} console](#db_gui), you can access the dashboard with a convenient one-click button. [With the CLI](#db_cli), you can access the dashboard or use the steps in an automation process such as for a CI/CD pipeline.
{:shortdesc}

Do you have so many resources and users in your cluster that the Kubernetes dashboard is a little slow? For clusters that run Kubernetes version 1.12 or later, your cluster admin can scale the `kubernetes-dashboard` deployment by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.
{: tip}

Before you begin:
* Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources.
* To [launch the Kubernetes dashboard from the console](#db_gui), you must be assigned a [platform role](/docs/containers?topic=containers-users#platform). If you are assigned only a service role but no platform role, [launch the Kubernetes dashboard from the CLI](#db_cli).
* [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

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


## Scaling apps
{: #app_scaling}

With Kubernetes, you can enable [horizontal pod autoscaling ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) to automatically increase or decrease the number of instances of your apps based on CPU.
{:shortdesc}

Looking for information about scaling Cloud Foundry applications? Check out [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling?topic=Auto-Scaling%20-get-started). Want to scale your worker nodes instead of your pods? Check out the [cluster autoscaler](/docs/containers?topic=containers-ca#ca).
{: tip}

Before you begin:
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
- Heapster monitoring must be deployed in the cluster that you want to autoscale.
- Make sure that you are assigned a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

Steps:

1.  Deploy your app to a cluster from the CLI. When you deploy your app, you must request CPU.

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table summary="A table that describes in Column 1 the Kubectl command options and in Column 2 how to fill out those options.">
    <caption>Command components for `kubectl run`</caption>
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

    <table summary="A table that describes in Column 1 the Kubectl command options and in Column 2 how to fill out those options.">
    <caption>Command components for `kubectl autoscale`</caption>
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

Before you begin:
*   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
*   Create a [deployment](#app_cli).
*   Make sure that you have a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources in the namespace.

To manage rolling updates to your apps:
1.  To make sure that your deployments are marked as ready only when the container is running and ready to service requests, add [liveness and readiness probes to your deployment](#probe).

2.  Update your deployment to include a rolling update strategy that specifies the maximum surge and unavailable pods or percentage of pods during the update.

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:  
      name: nginx-test
    spec:
      replicas: 10
      selector:
        matchLabels:
          service: http-server
      minReadySeconds: 5
      progressDeadlineSeconds: 600
      strategy: 
        type: RollingUpdate  
        rollingUpdate:    
          maxUnavailable: 50%
          maxSurge: 2
    ...
    ```
    {: codeblock}

    <table summary="A table that describes in Column 1 the YAML file fields and in Column 2 how to fill out those fields.">
    <caption>YAML components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>spec.minReadySeconds</code></td>
    <td>By default, deployments wait until the pod is marked as `ready` to continue with the rollout. If you notice that the deployment continues to create pods even though your app in the most recent pod is not yet ready, use this field to slow down the deployment rollout. For example, if you specify `5`, the deployment waits for 5 seconds after the pod is `ready` before it creates the next pod.</td>
    </tr>
    <tr>
    <td><code>spec.progressDeadlineSeconds</code></td>
    <td>Set a timeout in seconds before a deployment is considered failed. For example, without a timeout, if your new app version has a bug and hangs immediately, the rollout cannot continue because the pod never reaches a `ready` state. If you set this timeout to `600` seconds, then if any phase of the rollout fails to progress for 10 minutes, the deployment is marked as failed and the rollout stops.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.type</code></td>
    <td>Specify the `RollingUpdate` strategy type.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.rollingUpdate.maxUnavailable</code></td>
    <td>Set the maximum number of pods that can be unavailable during an update, as a number (`2`) or percentage (`50%`). Generally, use a percentage so that if you change the number of replicas later you don't have to remember to update the number here, unless you want to limit the rollout to allow only one pod to be down at a time. If you never want to fall below 100% capacity, set this value to `0%` and specify the `spec.strategy.type.rollingUpdate.maxSurge` parameter.</td>
    </tr>
    <tr>
    <td><code>spec.strategy.rollingUpdate.maxSurge</code></td>
    <td>Set how many extra resources the deployment can use during the rollout, as a number (`2`) or percentage (`50%`). For example, if your deployment specifies `10` replicas and you set the `maxSurge` to `2`, then during the rollout, 2 new replicas are created. You now have 12 replicas (10 existing, 2 new). After the 2 new replicas are ready, the deployment scales down the old replicas to 8 to meet the specified 10 replicas. This process continues until the rollout is complete and all 10 replicas run the new version.<p class="tip">If you want to perform a blue-green instantaneous switch style update, set the `maxSurge` to `100%`. The deployment creates all the new required replicas, then scales down the old version replicas to 0.</p></td>
    </tr>
    </tbody></table>

3.  [Roll out ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) a change. For example, you might want to change the image that you used in your initial deployment.

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

4.  Check the status of your deployment.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

    If you notice something in the status that you want time to follow up on, you can pause and resume your rollout with the following commands.

    ```
    kubectl rollout pause deployment <deployment_name>
    ```
    {: pre}

    ```
    kubectl rollout resume deployment <deployment_name>
    ```
    {: pre}

5.  Roll back a change.
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


