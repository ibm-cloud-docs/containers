---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-05"

keywords: kubernetes, iks, node scaling

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
{:gif: data-image-type='gif'}


# Scaling clusters (preview beta)
{: #ca}

With the {{site.data.keyword.containerlong_notm}} `ibm-iks-cluster-autoscaler` plug-in, you can scale the worker pools in your cluster automatically to increase or decrease the number of worker nodes in the worker pool based on the sizing needs of your scheduled workloads. The `ibm-iks-cluster-autoscaler` plug-in is based on the [Kubernetes Cluster-Autoscaler project ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler).
{: shortdesc}

Need help or have feedback on the cluster autoscaler? If you are an external user, [register for the public Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://bxcs-slack-invite.mybluemix.net/) and post in the [#cluster-autoscaler ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com/messages/CF6APMLBB) channel. If you are an IBMer, post in the [internal Slack ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-argonauts.slack.com/messages/C90D3KZUL) channel.
{: note}

Keep reading for more information about how cluster autoscaler works, or skip to the instructions for using it.
* [Deploying the cluster autoscaler Helm chart to your cluster](#ca_helm)
* [Updating the cluster autoscaler configmap](#ca_cm)
* [Customizing the cluster autoscaler Helm chart configuration values](#ca_chart_values)
* [Limiting apps to run on only certain autoscaled worker pools](#ca_limit_pool)
* [Removing the cluster autoscaler](#ca_rm)

Want to autoscale your pods instead? Check out [Scaling apps](/docs/containers?topic=containers-app#app_scaling).
{: tip}

## Understanding how the cluster autoscaler works
{: #ca_about}

The cluster autoscaler periodically scans the cluster to adjust the number of worker nodes within the worker pools that it manages in response to your workload resource requests and any custom settings that you configure, such as scanning intervals. Every minute, the cluster autoscaler checks for the following situations.
{: shortdesc}

*   **Pending pods to scale up**: A pod is considered pending when insufficient compute resources exist to schedule the pod on a worker node. When the cluster autoscaler detects pending pods, the autoscaler scales up your worker nodes evenly across zones to meet the workload resource requests.
*   **Underutilized worker nodes to scale down**: By default, worker nodes that run with less than 50% of the total compute resources requested for 10 minutes or more and that can reschedule their workloads onto other worker nodes are considered underutilized. If the cluster autoscaler detects underutilized worker nodes, it scales down your worker nodes one at a time so that you have only the compute resources that you need. If you want, you can [customize](/docs/containers?topic=containers-ca#ca_chart_values) the default scale-down utilization threshold of 50% for 10 minutes.

Scanning and scaling up and down happens at regular intervals over time, and depending on the number of worker nodes might take a longer period of time to complete, such as 30 minutes.

The cluster autoscaler adjusts the number of worker nodes by considering the [resource requests ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) that you define for your deployments, not actual worker node usage. If your pods and deployments don't request appropriate amounts of resources, you must adjust their configuration files. The cluster autoscaler can't adjust them for you. Also keep in mind that worker nodes use some of their compute resources for basic cluster functionality, default and custom [add-ons](/docs/containers?topic=containers-update#addons), and [resource reserves](/docs/containers?topic=containers-plan_clusters#resource_limit_node).
{: note}

<br>
**What does scaling up and down look like?**<br>
In general, the cluster autoscaler calculates the number of worker nodes that your cluster needs to run its workload. Scaling the cluster up or down depends on many factors including the following.
*   The minimum and maximum worker node size per zone that you set.
*   Your pending pod resource requests and certain metadata that you associate with the workload, such as anti-affinity, labels to place pods only on certain machine types, or [pod disruption budgets![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/).
*   The worker pools that the cluster autoscaler manages, potentially across zones in a [multizone cluster](/docs/containers?topic=containers-plan_clusters#multizone).
*   For more information, see the [Kubernetes Cluster Autoscaler FAQs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md).

**How is this behavior different from worker pools that are not manage by the cluster autoscaler?**<br>
When you [create a worker pool](/docs/containers?topic=containers-clusters#add_pool), you specify how many worker nodes per zone it has. The worker pool maintains that number of worker nodes until you [resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) or [rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) it. The worker pool does not add or remove worker nodes for you. If you have more pods than can be scheduled, the pods remain in pending state until you resize the worker pool.

When you enable the cluster autoscaler for a worker pool, worker nodes are scaled up or down in response to your pod spec settings and resource requests. You don't need to resize or rebalance the worker pool manually.

**Can I see an example of how the cluster autoscaler scales up and down?**<br>
Consider the following image for an example of scaling the cluster up and down.

_Figure: Autoscaling a cluster up and down._
![Autoscaling a cluster up and down GIF](images/cluster-autoscaler-x3.gif){: gif}

1.  The cluster has four worker nodes in two worker pools that are spread across two zones. Each pool has one worker node per zone, but **Worker Pool A** has a machine type of `u2c.2x4` and **Worker Pool B** has a machine type of `b2c.4x16`. Your total compute resources are roughly 10 cores (2 cores x 2 worker nodes for **Worker Pool A**, and 4 cores x 2 worker nodes for **Worker Pool B**). Your cluster currently runs a workload that requests 6 of these 10 cores. Note that additional computing resources are taken up on each worker node by the [reserved resources](/docs/containers?topic=containers-plan_clusters#resource_limit_node) required to run the cluster, worker nodes, and any add-ons such as the cluster autoscaler.
2.  The cluster autoscaler is configured to manage both worker pools with the following minimum and maximum size-per-zone:
    *  **Worker Pool A**: `minSize=1`, `maxSize=5`.
    *  **Worker Pool B**: `minSize=1`, `maxSize=2`.
3.  You schedule deployments that require 14 additional pod replicas of an app that requests 1 core of CPU per replica. One pod replica can be deployed on the current resources, but the other 13 are pending.
4.  The cluster autoscaler scales up your worker nodes within these constraints to support the additional 13 pod replicas resource requests.
    *  **Worker Pool A**: 7 worker nodes are added in a round-robin method as evenly as possible across the zones. The worker nodes increase the cluster compute capacity by roughly 14 cores (2 cores x 7 worker nodes).
    *  **Worker Pool B**: 2 worker nodes are added evenly across the zones, reaching the `maxSize` of 2 worker nodes per zone. The worker nodes increase cluster capacity by roughly 8 cores (4 cores x 2 worker node).
5.  The 20 pods with 1-core requests are distributed as follows across the worker nodes. Note that because worker nodes have resource reserves as well as pods that run to cover default cluster features, the pods for your workload cannot use all the available compute resources of a worker node. For example, although the `b2c.4x16` worker nodes have 4 cores, only 3 pods that request a minimum of 1 core each can be scheduled onto the worker nodes.
    <table summary="A table that describes the distribution of workload in scaled cluster.">
    <caption>Distribution of workload in scaled cluster.</caption>
    <thead>
    <tr>
      <th>Worker Pool</th>
      <th>Zone</th>
      <th>Type</th>
      <th># worker nodes</th>
      <th># pods</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>A</td>
      <td>dal10</td>
      <td>u2c.2x4</td>
      <td>4 nodes</td>
      <td>3 pods</td>
    </tr>
    <tr>
      <td>A</td>
      <td>dal12</td>
      <td>u2c.2x4</td>
      <td>5 nodes</td>
      <td>5 pods</td>
    </tr>
    <tr>
      <td>B</td>
      <td>dal10</td>
      <td>b2c.4x16</td>
      <td>2 nodes</td>
      <td>6 pods</td>
    </tr>
    <tr>
      <td>B</td>
      <td>dal12</td>
      <td>b2c.4x16</td>
      <td>2 nodes</td>
      <td>6 pods</td>
    </tr>
    </tbody>
    </table>
6.  You no longer need the additional workload, so you delete the deployment. After a short period of time, the cluster autoscaler detects that your cluster no longer needs all its compute resources and begins to scale down the worker nodes one at a time.
7.  Your worker pools are scaled down. The cluster autoscaler scans at regular intervals to check for pending pod resource requests and underutilized worker nodes to scale your worker pools up or down.

<br>
**How can I make sure my worker node and deployment practices are scalable?**<br>
Make the most out of the cluster autoscaler by organizing your worker node and app workloads strategies. For more information, see the [Kubernetes Cluster Autoscaler FAQs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md).

<br>
**What are some general guidelines for worker pools and nodes?**<br>
*   You can run only one `ibm-iks-cluster-autoscaler` per cluster.
*   The cluster autoscaler scales your cluster in response to your workload [resource requests ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/). As such, you do not need to [resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) or [rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) your worker pools.
*   Don't use the `ibmcloud ks worker-rm` [command](/docs/containers?topic=containers-cs_cli_reference#cs_worker_rm) to remove individual worker nodes from your worker pool, which can unbalance the worker pool.
*   Because taints cannot be applied at the worker pool level, do not [taint worker nodes](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) to avoid unexpected results. For example, when you deploy a workload that is not tolerated by the tainted worker nodes, the worker nodes are not considered for scaleup and more worker nodes might be ordered even if the cluster has sufficient capacity. However, the tainted worker nodes are still identified as underutilized if they have less than the threshold (by default 50%) of their resources utilized and thus are considered for scaledown.

<br>
**What are some general guidelines for app workloads?**<br>
*   Keep in mind that autoscaling is based on the compute usage that your workload configurations request, and does not consider other factors such as machine costs.
*   Specify [resource requests ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for all your deployments because the resource requests are what the cluster autoscaler uses to calculate how many worker nodes are needed to run the workload.
*   Use [pod disruption budgets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/) to prevent abrupt rescheduling or deletions of your pods.
*   If you're using pod priority, you can [edit the priority cutoff ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-does-cluster-autoscaler-work-with-pod-priority-and-preemption) to change what types of priority trigger scaling up. By default, the priority cutoff is zero (`0`).

<br>
**Why are my autoscaled worker pools unbalanced?**<br>
During a scaleup, the cluster autoscaler balances nodes across zones, with a permitted difference of plus or minus one (+/- 1) worker node. Your pending workloads might not request enough capacity to make each zone balanced. In this case, if you want to manually balance the worker pools, [update your cluster autoscaler configmap](#ca_cm) to remove the unbalanced worker pool. Then run the `ibmcloud ks worker-pool-rebalance` [command](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance), and add the worker pool back to the cluster autoscaler configmap.

**Why can't I resize or rebalance my worker pool?**<br>
When the cluster autoscaler is enabled for a worker pool, you cannot [resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) or [rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) your worker pools. You must [edit the configmap](#ca_cm) to change the worker pool minimum or maximum sizes, or disable cluster autoscaling for that worker pool.

Further, if you do not disable the worker pools before you uninstall the `ibm-iks-cluster-autoscaler` Helm chart, the worker pools cannot be resized manually. Reinstall the `ibm-iks-cluster-autoscaler` Helm chart, [edit the configmap](#ca_cm) to disable the worker pool, and try again.

<br />


## Deploying the cluster autoscaler Helm chart to your cluster
{: #ca_helm}

Install the {{site.data.keyword.containerlong_notm}} cluster autoscaler plug-in with a Helm chart to autoscale worker pools in your cluster.
{: shortdesc}

**Before you begin**:

1.  [Install the required CLI and plug-ins](/docs/cli?topic=cloud-cli-ibmcloud-cli):
    *  {{site.data.keyword.Bluemix_notm}} CLI (`ibmcloud`)
    *  {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`)
    *  {{site.data.keyword.registrylong_notm}} plug-in (`ibmcloud cr`)
    *  Kubernetes (`kubectl`)
    *  Helm (`helm`)
2.  [Create a standard cluster](/docs/containers?topic=containers-clusters#clusters_ui) that runs **Kubernetes version 1.12 or later**.
3.   [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
4.  Confirm that your {{site.data.keyword.Bluemix_notm}} Identity and Access Management credentials are stored in the cluster. The cluster autoscaler uses this secret to authenticate.
    ```
    kubectl get secrets -n kube-system | grep storage-secret-store
    ```
    {: pre}
5.  The cluster autoscaler can scale only worker pools that have the `ibm-cloud.kubernetes.io/worker-pool-id` label.
    1.  Check if your worker pool has the required label.
        ```
        ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> | grep Labels
        ```
        {: pre}

        Example output of a worker pool with the label:
        ```
        Labels:             ibm-cloud.kubernetes.io/worker-pool-id=a1aa111111b22b22cc3c3cc444444d44-4d555e5
        ```
        {: screen}
    2.  If your worker pool does not have the required label, [add a new worker pool](/docs/containers?topic=containers-clusters#add_pool) and use this worker pool with the cluster autoscaler.


<br>
**To install the `ibm-iks-cluster-autoscaler` plug-in in your cluster**:

1.  [Follow the instructions](/docs/containers?topic=containers-integrations#helm) to install the **Helm version 2.11 or later** client on your local machine, and install the Helm server (tiller) with a service account in your cluster.
2.  Verify that tiller is installed with a service account.

    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    Example output:

    ```
    NAME                                 SECRETS   AGE
    tiller                               1         2m
    ```
    {: screen}
3.  Add and update the Helm repo where the cluster autoscaler Helm chart is.
    ```
    helm repo add ibm https://registry.bluemix.net/helm/ibm/
    ```
    {: pre}
    ```
    helm repo update
    ```
    {: pre}
4.  Install the cluster autoscaler Helm chart in the `kube-system` namespace of your cluster.

    You can also [customize the cluster autoscaler settings](#ca_chart_values) such as the amount of time it waits before scaling worker nodes up or down.
    {: tip}

    ```
    helm install ibm/ibm-iks-cluster-autoscaler --namespace kube-system --name ibm-iks-cluster-autoscaler
    ```
    {: pre}

    Example output:
    ```
    NAME:   ibm-iks-cluster-autoscaler
    LAST DEPLOYED: Thu Nov 29 13:43:46 2018
    NAMESPACE: kube-system
    STATUS: DEPLOYED

    RESOURCES:
    ==> v1/ClusterRole
    NAME                       AGE
    ibm-iks-cluster-autoscaler  1s

    ==> v1/Pod(related)

    NAME                                        READY  STATUS             RESTARTS  AGE
    ibm-iks-cluster-autoscaler-67c8f87b96-qbb6c  0/1    ContainerCreating  0         1s

    ==> v1/ConfigMap

    NAME              AGE
    iks-ca-configmap  1s

    ==> v1/ClusterRoleBinding
    ibm-iks-cluster-autoscaler  1s

    ==> v1/Role
    ibm-iks-cluster-autoscaler  1s

    ==> v1/RoleBinding
    ibm-iks-cluster-autoscaler  1s

    ==> v1/Service
    ibm-iks-cluster-autoscaler  1s

    ==> v1beta1/Deployment
    ibm-iks-cluster-autoscaler  1s

    ==> v1/ServiceAccount
    ibm-iks-cluster-autoscaler  1s

    NOTES:
    Thank you for installing: ibm-iks-cluster-autoscaler. Your release is named: ibm-iks-cluster-autoscaler

    For more information about using the cluster autoscaler, refer to the chart README.md file.
    ```
    {: screen}

5.  Verify that the installation is successful.

    1.  Check that the cluster autoscaler pod is in a **Running** state.
        ```
        kubectl get pods --namespace=kube-system | grep ibm-iks-cluster-autoscaler
        ```
        {: pre}
        Example output:
        ```
        ibm-iks-cluster-autoscaler-8497bfc968-dbn7w   1/1       Running   0          9m
        ```
        {: screen}
    2.  Check that the cluster autoscaler service is created.
        ```
        kubectl get service --namespace=kube-system | grep ibm-iks-cluster-autoscaler
        ```
        {: pre}
        Example output:
        ```
        ibm-iks-cluster-autoscaler   ClusterIP   172.21.xxx.xx    <none>        8085/TCP        9m
        ```
        {: screen}

6.  Repeat these steps for every cluster where you want to provision the cluster autoscaler.

7.  To start scaling your worker pools, see [Updating the cluster autoscaler configuration](#ca_cm).

<br />


## Updating the cluster autoscaler configmap
{: #ca_cm}

Update the cluster autoscaler configmap to enable automatically scaling worker nodes in your worker pools based on the minimum and maximum values that you set.
{: shortdesc}

After you edit the configmap to enable a worker pool, the cluster autoscaler begins to scale your cluster in response to your workload requests. As such, you cannot [resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) or [rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) your worker pools. Scanning and scaling up and down happens at regular intervals over time, and depending on the number of worker nodes might take a longer period of time to complete, such as 30 minutes. Later, if you want to [remove the cluster autoscaler](#ca_rm), you must first disable each worker pool in the configmap.
{: note}

**Before you begin**:
*  [Install the `ibm-iks-cluster-autoscaler` plug-in](#ca_helm).
*  [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**To update the cluster autoscaler configmap and values**:

1.  Get the cluster autoscaler configmap YAML file.
    ```
    kubectl get cm iks-ca-configmap -n kube-system -o yaml > iks-ca-configmap.yaml
    ```
    {: pre}
    Example output:
    ```
    apiVersion: v1
    data:
      workerPoolsConfig.json: |
        [
         {"name": "default","minSize": 1,"maxSize": 2,"enabled":false}
        ]
    kind: ConfigMap
    metadata:
      creationTimestamp: 2018-11-29T18:43:46Z
      name: iks-ca-configmap
      namespace: kube-system
      resourceVersion: "2227854"
      selfLink: /api/v1/namespaces/kube-system/configmaps/iks-ca-configmap
      uid: b45d047b-f406-11e8-b7f0-82ddffc6e65e
    ```
    {: screen}
2.  Edit the configmap with the parameters to define how the cluster autoscaler scales your cluster worker pool. Note that unless you [disabled](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure) application load balancers (ALBs) in your standard cluster, you must change the `minSize` to `2` per zone so that the ALB pods can be spread for high availability.

    <table>
    <caption>Cluster autoscaler configmap parameters</caption>
    <thead>
    <th>Parameter with default value</th>
    <th>Description</th>
    </thead>
    <tr>
    <td>`"name": "default"`</td>
    <td>Replace `"default"` with the name or ID of the worker pool that you want to scale. To list worker pools, run `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`.<br><br>
    To manage more than one worker pool, copy the JSON line to a comma-separated line, such as follows. <pre class="codeblock">[
     {"name": "default","minSize": 1,"maxSize": 2,"enabled":false},
     {"name": "Pool2","minSize": 2,"maxSize": 5,"enabled":true}
    ]</pre><br><br>
    **Note**: The cluster autoscaler can scale only worker pools that have the `ibm-cloud.kubernetes.io/worker-pool-id` label. To check if your worker pool has the required label, run `ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> | grep Labels`. If your worker pool does not have the required label, [add a new worker pool](/docs/containers?topic=containers-clusters#add_pool) and use this worker pool with the cluster autoscaler.</td>
    </tr>
    <tr>
    <td>`"minSize": 1`</td>
    <td>Specify the minimum number of worker nodes per zone to be in the worker pool at all times. The value must be 2 or greater so that your ALB pods can be spread for high availability. If you [disabled](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure) the ALB in your standard cluster, you can set the value to `1`.</td>
    </tr>
    <tr>
    <td>`"maxSize": 2`</td>
    <td>Specify the maximum number of worker nodes per zone to be in the worker pool. The value must be equal to or greater than the value that you set for the `minSize`.</td>
    </tr>
    <tr>
    <td>`"enabled":false`</td>
    <td>Set the value to `true` for the cluster autoscaler to manage scaling for the worker pool. Set the value to `false` to stop the cluster autoscaler from scaling the worker pool.<br><br>
    Later, if you want to [remove the cluster autoscaler](#ca_rm), you must first disable each worker pool in the configmap.</td>
    </tr>
    </tbody>
    </table>
3.  Apply your changes to the cluster.
    ```
    kubectl apply -f iks-ca-configmap.yaml
    ```
    {: pre}
4.  Get your cluster autoscaler pod.
    ```
    kubectl get pods -n kube-system
    ```
    {: pre}
5.  Review the **`Events`** section of the cluster autoscaler pod for a **`ConfigUpdated`** event to verify that the configmap is successfully updated. The event message for your configmap is in the following format: `minSize:maxSize:PoolName:<SUCCESS|FAILED>:error message`.

    ```
    kubectl describe pod -n kube-system <cluster_autoscaler_pod>
    ```
    {: pre}

    Example output:
    ```
		Name:               ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6
		Namespace:          kube-system
		...
		Events:
		Type     Reason         Age   From                                        Message
		----     ------         ----  ----                                        -------

		Normal  ConfigUpdated  3m    ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6  {"1:3:default":"SUCCESS:"}
    ```
    {: screen}

## Customizing the cluster autoscaler Helm chart configuration values
{: #ca_chart_values}

Customize the cluster autoscaler settings such as the amount of time it waits before scaling worker nodes up or down.
{: shortdesc}

**Before you begin**:
*  [Install the `ibm-iks-cluster-autoscaler` plug-in](#ca_helm).
*  [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**To update the cluster autoscaler values**:

1.  Review the cluster autoscaler Helm chart configuration values. The cluster autoscaler comes with default settings. However, you might want to change some values such as the scale-down or scanning intervals, depending on how often you change your cluster workloads.
    ```
    helm get values ibm-iks-cluster-autoscaler -a
    ```
    {: pre}

    Example output:
    ```
    expander: least-waste
    image:
      pullPolicy: Always
      repository: registry.ng.bluemix.net/armada-master/ibmcloud-cluster-autoscaler
      tag: dev1
    maxNodeProvisionTime: 120m
    resources:
      limits:
        cpu: 300m
        memory: 300Mi
      requests:
        cpu: 100m
        memory: 100Mi
    scaleDownDelayAfterAdd: 10m
    scaleDownDelayAfterDelete: 10m
    scaleDownUtilizationThreshold: 0.5
    scaleDownUnneededTime: 10m
    scanInterval: 1m
    skipNodes:
      withLocalStorage: true
      withSystemPods: true
    ```
    {: codeblock}

    <table>
    <caption>Cluster autoscaler configuration values</caption>
    <thead>
    <th>Parameter</th>
    <th>Description</th>
    <th>Default value</th>
    </thead>
    <tbody>
    <tr>
    <td>`api_route`</td>
    <td>Set the [{{site.data.keyword.containerlong_notm}} API endpoint](/docs/containers?topic=containers-cs_cli_reference#cs_api) for the region that your cluster is in.</td>
    <td>No default; uses the targeted region that your cluster is in.</td>
    </tr>
    <tr>
    <td>`expander`</td>
    <td>Specify how the cluster autoscaler determines which worker pool to scale if you have multiple worker pools. Possible values are:
    <ul><li>`random`: Selects randomly between `most-pods` and `least-waste`.</li>
    <li>`most-pods`: Selects the worker pool that is able to schedule the most pods when scaling up. Use this method if you are using `nodeSelector` to make sure that pods land on specific worker nodes.</li>
    <li>`least-waste`: Selects the worker pool that has the least unused CPU, or in case of a tie the least unused memory, after scaling up. Use this method if you have multiple worker pools with large CPU and memory machine types, and want to use these larger machines only when pending pods need large amounts of resources.</li></ul></td>
    <td>random</td>
    </tr>
    <tr>
    <td>`image.repository`</td>
    <td>Specify the cluster autoscaler Docker image to use.</td>
    <td>registry.bluemix.net/ibm/ibmcloud-cluster-autoscaler</td>
    </tr>
    <tr>
    <td>`image.pullPolicy`</td>
    <td>Specify when to pull the Docker image. Possible values are:
    <ul><li>`Always`: Pulls the image every time that the pod is started.</li>
    <li>`IfNotPresent`: Pulls the image only if the image is not already present locally.</li>
    <li>`Never`: Assumes that the image exists locally and never pulls the image.</li></ul></td>
    <td>Always</td>
    </tr>
    <tr>
    <td>`maxNodeProvisionTime`</td>
    <td>Set the maximum amount of time in minutes that a worker node can take to begin provisioning before the cluster autoscaler cancels the scale-up request.</td>
    <td>120m</td>
    </tr>
    <tr>
    <td>`resources.limits.cpu`</td>
    <td>Set the maximum amount of worker node CPU that the `ibm-iks-cluster-autoscaler` pod can consume.</td>
    <td>300m</td>
    </tr>
    <tr>
    <td>`resources.limits.memory`</td>
    <td>Set the maximum amount of worker node memory that the `ibm-iks-cluster-autoscaler` pod can consume.</td>
    <td>300Mi</td>
    </tr>
    <tr>
    <td>`resources.requests.cpu`</td>
    <td>Set the minimum amount of worker node CPU that the `ibm-iks-cluster-autoscaler` pod starts with.</td>
    <td>100m</td>
    </tr>
    <tr>
    <td>`resources.requests.memory`</td>
    <td>Set the minimum amount of worker node memory that the `ibm-iks-cluster-autoscaler` pod starts with.</td>
    <td>100Mi</td>
    </tr>
    <tr>
    <td>`scaleDownUnneededTime`</td>
    <td>Set the amount of time in minutes that a worker node must be unnecessary before it can be scaled down.</td>
    <td>10m</td>
    </tr>
    <tr>
    <td>`scaleDownDelayAfterAdd`, `scaleDownDelayAfterDelete`</td>
    <td>Set the amount of time in minutes that the cluster autoscaler waits to start scaling actions again after scaling up (`add`) or scaling down (`delete`).</td>
    <td>10m</td>
    </tr>
    <tr>
    <td>`scaleDownUtilizationThreshold`</td>
    <td>Set the worker node utilization threshold. If the worker node utilization goes below the threshold, the worker node is considered to be scaled down. Worker node utilization is calculated as the sum of the CPU and memory resources that are requested by all pods that run on the worker node divided by the worker node resource capacity.</td>
    <td>0.5</td>
    </tr>
    <tr>
    <td>`scanInterval`</td>
    <td>Set how often in minutes that the cluster autoscaler scans for workload usage that triggers scaling up or down.</td>
    <td>1m</td>
    </tr>
    <tr>
    <td>`skipNodes.withLocalStorage`</td>
    <td>When set to `true`, worker nodes that have pods that are saving data to local storage are not scaled down.</td>
    <td>true</td>
    </tr>
    <tr>
    <td>`skipNodes.withSystemPods`</td>
    <td>When set to `true`, worker nodes that have `kube-system` pods are not scaled down. Do not set the value to `false` because scaling down `kube-system` pods might have unexpected results.</td>
    <td>true</td>
    </tr>
    </tbody>
    </table>
2.  To change any of the cluster autoscaler configuration values, update the Helm chart with the new values.
    ```
    helm upgrade --set scanInterval=2m ibm-iks-cluster-autoscaler ibm/ibm-iks-cluster-autoscaler -i
    ```
    {: pre}

    To reset the chart to the default values:
    ```
    helm upgrade --reset-values ibm-iks-cluster-autoscaler ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}
3.  To verify your changes, review the Helm chart values again.
    ```
    helm get values ibm-iks-cluster-autoscaler -a
    ```
    {: pre}

## Limiting apps to run on only certain autoscaled worker pools
{: #ca_limit_pool}

To limit a pod deployment to a specific worker pool that is managed by the cluster autoscaler, use labels and `nodeSelector`.
{: shortdesc}

**Before you begin**:
*  [Install the `ibm-iks-cluster-autoscaler` plug-in](#ca_helm).
*  [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

**To limit pods to run on certain autoscaled worker pools**:

1.  Create the worker pool with the label that you want to use.
    ```
    ibmcloud ks worker-pool-create --name <name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_worker_nodes> --labels <key>=<value>
    ```
    {: pre}
2.  [Add the worker pool to the cluster autoscaler configuration](#ca_cm).
3.  In your pod spec template, match the `nodeSelector` to the label that you used in your worker pool.
    ```
    ...
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      nodeSelector:
        app: nginx
    ...
    ```
    {: codeblock}
4.  Deploy the pod. Because of the matching label, the pod is scheduled onto a worker node that is in the labeled worker pool.
    ```
    kubectl apply -f pod.yaml
    ```
    {: pre}

<br />


## Updating the cluster autoscaler Helm chart
{: #ca_helm_up}

You can update the existing cluster autoscaler Helm chart to the latest version. To check your current Helm chart version, run `helm ls | grep cluster-autoscaler`.
{: shortdesc}

Updating to the latest Helm chart from version 1.0.2 or earlier? [Follow these instructions](#ca_helm_up_102).
{: note}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Update the Helm repo to retrieve the latest version of all Helm charts in this repo.
    ```
    helm repo update
    ```
    {: pre}

2.  Optional: Download the latest Helm chart to your local machine. Then, unzip the package and review the `release.md` file to find the latest release information.
    ```
    helm fetch ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}

3.  Find the name of the cluster autoscaler Helm chart that you installed in your cluster.
    ```
    helm ls | grep cluster-autoscaler
    ```
    {: pre}

    Example output:
    ```
    myhelmchart 	1       	Mon Jan  7 14:47:44 2019	DEPLOYED	ibm-ks-cluster-autoscaler-1.0.0  	kube-system
    ```
    {: screen}

4.  Update the cluster autoscaler Helm chart to the latest version.
    ```
    helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibm-iks-cluster-autoscaler
    ```
    {: pre}

5.  Verify that the [cluster autoscaler configmap](#ca_cm) `workerPoolsConfig.json` section is set to `"enabled": true` for the worker pools that you want to scale.
    ```
    kubectl describe cm iks-ca-configmap -n kube-system
    ```
    {: pre}

    Example output:
    ```
    Name:         iks-ca-configmap
    Namespace:    kube-system
    Labels:       <none>
    Annotations:  kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","data":{"workerPoolsConfig.json":"[\n {\"name\": \"docs\",\"minSize\": 1,\"maxSize\": 3,\"enabled\":true}\n]\n"},"kind":"ConfigMap",...

    Data
    ====
    workerPoolsConfig.json:
    ----
    [
     {"name": "docs","minSize": 1,"maxSize": 3,"enabled":true}
    ]

    Events:  <none>
    ```
    {: screen}

### Updating to the latest Helm chart from version 1.0.2 or earlier
{: #ca_helm_up_102}

The latest Helm chart version of the cluster autoscaler requires a full removal of previously installed cluster autoscaler Helm chart versions. If you installed the Helm chart version 1.0.2 or earlier, uninstall that version first before you install the latest Helm chart of the cluster autoscaler.
{: shortdesc}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Get your cluster autoscaler configmap.
    ```
    kubectl get cm iks-ca-configmap -n kube-system -o yaml > iks-ca-configmap.yaml
    ```
    {: pre}
2.  Remove all worker pools from the configmap by setting the `"enabled"` value to `false`.
    ```
    kubectl edit cm iks-ca-configmap -n kube-system
    ```
    {: pre}
3.  If you applied custom settings to the Helm chart, note your custom settings.
    ```
    helm get values ibm-ks-cluster-autoscaler -a
    ```
    {: pre}
4.  Uninstall your current Helm chart.
    ```
    helm delete --purge ibm-ks-cluster-autoscaler
    ```
    {: pre}
5.  Update the Helm chart repo to get the latest cluster autoscaler Helm chart version.
    ```
    helm repo update
    ```
    {: pre}
6.  Install the latest cluster autoscaler Helm chart. Apply any custom settings that you previously used with the `--set` flag, such as `scanInterval=2m`.
    ```
    helm install  ibm/ibm-iks-cluster-autoscaler --namespace kube-system --name ibm-iks-cluster-autoscaler [--set <custom_settings>]
    ```
    {: pre}
7.  Apply the cluster autoscaler configmap that you previously retrieved to enabled autoscaling for your worker pools.
    ```
    kubectl apply -f iks-ca-configmap.yaml
    ```
    {: pre}
8.  Get your cluster autoscaler pod.
    ```
    kubectl get pods -n kube-system
    ```
    {: pre}
9.  Review the **`Events`** section of the cluster autoscaler pod and look for a **`ConfigUpdated`** event to verify that the configmap is successfully updated. The event message for your configmap is in the following format: `minSize:maxSize:PoolName:<SUCCESS|FAILED>:error message`.
    ```
    kubectl describe pod -n kube-system <cluster_autoscaler_pod>
    ```
    {: pre}

    Example output:
    ```
		Name:               ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6
		Namespace:          kube-system
		...
		Events:
		Type     Reason         Age   From                                        Message
		----     ------         ----  ----                                        -------

		Normal  ConfigUpdated  3m    ibm-iks-cluster-autoscaler-857c4d9d54-gwvc6  {"1:3:default":"SUCCESS:"}
    ```
    {: screen}

<br />


## Removing the cluster autoscaler
{: #ca_rm}

If you do not want to automatically scale your worker pools, you can uninstall the cluster autoscaler Helm chart. After the removal, you must [resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize) or [rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance) your worker pools manually.
{: shortdesc}

Before you begin: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  In the [cluster autoscaler configmap](#ca_cm), remove the worker pool by setting the `"enabled"` value to `false`.
    ```
    kubectl edit cm iks-ca-configmap -n kube-system
    ```
    {: pre}
    Example output:
    ```
    apiVersion: v1
    data:
      workerPoolsConfig.json: |
        [
         {"name": "default","minSize": 1,"maxSize": 2,"enabled":false},
         {"name":"mypool","minSize":1,"maxSize":5,"enabled":false}
        ]
    kind: ConfigMap
    ...
    ```
2.  List your existing Helm charts and note the name of the cluster autoscaler.
    ```
    helm ls
    ```
    {: pre}
3.  Remove the existing Helm chart from your cluster.
    ```
    helm delete --purge <ibm-iks-cluster-autoscaler_name>
    ```
    {: pre}
