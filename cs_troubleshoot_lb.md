---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-05"

keywords: kubernetes, iks, nginx, nlb, help

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Load balancers
{: #cs_troubleshoot_lb}

As you use {{site.data.keyword.containerlong}}, consider these techniques for general load balancer troubleshooting and debugging.
{: shortdesc}

While you troubleshoot, you can use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to run tests and gather pertinent information from your cluster.
{: tip}

## Classic clusters: Cannot connect to an app via a network load balancer (NLB) service
{: #cs_loadbalancer_fails}

{: tsSymptoms}
You publicly exposed your app by creating an NLB service in your classic cluster. When you tried to connect to your app by using the public IP address of the NLB, the connection failed or timed out.

{: tsCauses}
Your NLB service might not be working properly for one of the following reasons:

-   The cluster is a free cluster or a standard cluster with only one worker node.
-   The cluster is not fully deployed yet.
-   The configuration script for your NLB service includes errors.

{: tsResolve}
To troubleshoot your NLB service:

1.  Check that you set up a standard cluster that is fully deployed and has at least two worker nodes to ensure high availability for your NLB service.

  ```
  ibmcloud ks worker ls --cluster <cluster_name_or_ID>
  ```
  {: pre}

    In your CLI output, make sure that the **Status** of your worker nodes displays **Ready** and that the **Machine Type** shows a flavor other than **free**.

2. For version 2.0 NLBs: Ensure that you complete the [NLB 2.0 prerequisites](/docs/containers?topic=containers-loadbalancer-v2#ipvs_provision).

3. Check the accuracy of the configuration file for your NLB service.
    * Version 2.0 NLBs:
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myservice
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP
             port: 8080
          externalTrafficPolicy: Local
        ```
        {: screen}

        1. Check that you defined **LoadBalancer** as the type for your service.
        2. Check that you included the `service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"` annotation.
        3. In the `spec.selector` section of the LoadBalancer service, ensure that the `<selector_key>` and `<selector_value>` is the same as the key/value pair that you used in the `spec.template.metadata.labels` section of your deployment YAML. If labels do not match, the **Endpoints** section in your LoadBalancer service displays **<none>** and your app is not accessible from the internet.
        4. Check that you used the **port** that your app listens on.
        5. Check that you set `externalTrafficPolicy` to `Local`.

    * Version 1.0 NLBs:
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myservice
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: screen}

        1. Check that you defined **LoadBalancer** as the type for your service.
        2. In the `spec.selector` section of the LoadBalancer service, ensure that the `<selector_key>` and `<selector_value>` is the same as the key/value pair that you used in the `spec.template.metadata.labels` section of your deployment YAML. If labels do not match, the **Endpoints** section in your LoadBalancer service displays **<none>** and your app is not accessible from the internet.
        3. Check that you used the **port** that your app listens on.

3.  Check your NLB service and review the **Events** section to find potential errors.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    Look for the following error messages:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>To use the NLB service, you must have a standard cluster with at least two worker nodes.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the NLB service request. Add a portable subnet to the cluster and try again</code></pre></br>This error message indicates that no portable public IP addresses are left to be allocated to your NLB service. Refer to <a href="/docs/containers?topic=containers-subnets#subnets">Adding subnets to clusters</a> to find information about how to request portable public IP addresses for your cluster. After portable public IP addresses are available to the cluster, the NLB service is automatically created.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>You defined a portable public IP address for your load balancer YAML by using the **`loadBalancerIP`** section, but this portable public IP address is not available in your portable public subnet. In the **`loadBalancerIP`** section your configuration script, remove the existing IP address and add one of the available portable public IP addresses. You can also remove the **`loadBalancerIP`** section from your script so that an available portable public IP address can be allocated automatically.</li>
    <li><pre class="screen"><code>No available nodes for NLB services</code></pre>You do not have enough worker nodes to deploy an NLB service. One reason might be that you deployed a standard cluster with more than one worker node, but the provisioning of the worker nodes failed.</li>
    <ol><li>List available worker nodes.</br><pre class="pre"><code>kubectl get nodes</code></pre></li>
    <li>If at least two available worker nodes are found, list the worker node details.</br><pre class="pre"><code>ibmcloud ks worker get --cluster &lt;cluster_name_or_ID&gt; --worker &lt;worker_ID&gt;</code></pre></li>
    <li>Make sure that the public and private VLAN IDs for the worker nodes that were returned by the <code>kubectl get nodes</code> and the <code>ibmcloud ks worker get</code> commands match.</li></ol></li></ul>

4.  If you use a custom domain to connect to your NLB service, make sure that your custom domain is mapped to the public IP address of your NLB service.
    1.  Find the public IP address of your NLB service.
        ```
        kubectl describe service <service_name> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  Check that your custom domain is mapped to the portable public IP address of your NLB service in the Pointer record (PTR).

<br />


## Classic clusters: Cannot deploy a load balancer
{: #cs_subnet_limit}

{: tsSymptoms}
When you describe the `ibm-cloud-provider-vlan-ip-config` configmap in your classic cluster, you might see an error message similar to the following example output.
```
kubectl describe cm ibm-cloud-provider-vlan-ip-config -n kube-system
```
{: pre}
```
Warning  CreatingLoadBalancerFailed ... ErrorSubnetLimitReached: There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
In standard clusters, the first time that you create a cluster in a zone, a public VLAN and a private VLAN in that zone are automatically provisioned for you in your IBM Cloud infrastructure account. In that zone, 1 public portable subnet is requested on the public VLAN that you specify and 1 private portable subnet is requested on the private VLAN that you specify. For {{site.data.keyword.containerlong_notm}}, VLANs have a limit of 40 subnets. If the cluster's VLAN in a zone already reached that limit, you might not have a portable public IP address available to create a network load balancer (NLB).

To view how many subnets a VLAN has:
1.  From the [IBM Cloud infrastructure console](https://cloud.ibm.com/classic?), select **Network** > **IP Management** > **VLANs**.
2.  Click the **VLAN Number** of the VLAN that you used to create your cluster. Review the **Subnets** section to see whether 40 or more subnets exist.

{: tsResolve}
If you need a new VLAN, order one by [contacting {{site.data.keyword.cloud_notm}} support](/docs/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans). Then, [create a cluster](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create) that uses this new VLAN.

If you have another VLAN that is available, you can [set up VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning) in your existing cluster. After, you can add new worker nodes to the cluster that use the other VLAN with available subnets. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).

If you are not using all the subnets in the VLAN, you can reuse subnets on the VLAN by adding them to your cluster.
1. Check that the subnet that you want to use is available.
  <p class="note">The infrastructure account that you use might be shared across multiple {{site.data.keyword.cloud_notm}} accounts. In this case, even if you run the `ibmcloud ks subnets` command to see subnets with **Bound Clusters**, you can see information only for your clusters. Check with the infrastructure account owner to make sure that the subnets are available and not in use by any other account or team.</p>

2. Use the [`ibmcloud ks cluster subnet add` command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_add) to make an existing subnet available to your cluster.

3. Verify that the subnet was successfully created and added to your cluster. The subnet CIDR is listed in the **Subnet VLANs** section.
    ```
    ibmcloud ks cluster get --show-resources <cluster_name_or_ID>
    ```
    {: pre}

    In this example output, a second subnet was added to the `2234945` public VLAN:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

4. Verify that the portable IP addresses from the subnet that you added are used for the load balancer's **EXTERNAL-IP**. It might take several minutes for the services to use the portable IP addresses from the newly-added subnet.
  ```
  kubectl get svc -n kube-system
  ```
  {: pre}

<br />


## Classic clusters: Source IP preservation fails when using tainted nodes
{: #cs_source_ip_fails}

{: tsSymptoms}
In a classic cluster, you enabled source IP preservation for a [version 1.0 load balancer](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations) service by changing `externalTrafficPolicy` to `Local` in the service's configuration file. However, no traffic reaches the back-end service for your app.

{: tsCauses}
When you enable source IP preservation for load balancer services, the source IP address of the client request is preserved. The service forwards traffic to app pods on the same worker node only to ensure that the request packet's IP address isn't changed. Typically, load balancer service pods are deployed to the same worker nodes that the app pods are deployed to. However, some situations exist where the service pods and app pods might not be scheduled onto the same worker node. If you use [Kubernetes taints](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/){: external} on worker nodes, any pods that don't have a taint toleration are prevented from running on the tainted worker nodes. Source IP preservation might not be working based on the type of taint you used:

* **Edge node taints**: You [added the `dedicated=edge` label](/docs/containers?topic=containers-edge#edge_nodes) to two or more worker nodes on each public VLAN in your cluster to ensure that load balancer pods deploy to those worker nodes only. Then, you also [tainted those edge nodes](/docs/containers?topic=containers-edge#edge_workloads) to prevent any other workloads from running on edge nodes. However, you didn't add an edge node affinity rule and toleration to your app deployment. Your app pods can't be scheduled on the same tainted nodes as the service pods, and no traffic reaches the back-end service for your app.

* **Custom taints**: You used custom taints on several nodes so that only app pods with that taint toleration can deploy to those nodes. You added affinity rules and tolerations to the deployments of your app and load balancer service so that their pods deploy to only those nodes. However, `ibm-cloud-provider-ip` `keepalived` pods that are automatically created in the `ibm-system` namespace ensure that the load balancer pods and the app pods are always scheduled onto the same worker node. These `keepalived` pods don't have the tolerations for the custom taints that you used. They can't be scheduled on the same tainted nodes that your app pods are running on, and no traffic reaches the back-end service for your app.

{: tsResolve}
Resolve the issue by choosing one of the following options:

* **Edge node taints**: To ensure that your load balancer and app pods deploy to tainted edge nodes, [add edge node affinity rules and tolerations to your app deployment](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). Load balancer pods have these affinity rules and tolerations by default.

* **Custom taints**: Remove custom taints that the `keepalived` pods don't have tolerations for. Instead, you can [label worker nodes as edge nodes, and then taint those edge nodes](/docs/containers?topic=containers-edge).

If you complete one of the above options but the `keepalived` pods are still not scheduled, you can get more information about the `keepalived` pods:

1. Get the `keepalived` pods.
    ```
    kubectl get pods -n ibm-system
    ```
    {: pre}

2. In the output, look for `ibm-cloud-provider-ip` pods that have a **Status** of `Pending`. Example:
    ```
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t     0/1       Pending   0          2m        <none>          <none>
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-8ptvg     0/1       Pending   0          2m        <none>          <none>
    ```
    {:screen}

3. Describe each `keepalived` pod and look for the **Events** section. Address any error or warning messages that are listed.
    ```
    kubectl describe pod ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t -n ibm-system
    ```
    {: pre}

<br />


## VPC clusters: Cannot connect to an app via load balancer
{: #vpc_ts_lb}

{: tsSymptoms}
You publicly exposed your app by creating a Kubernetes `LoadBalancer` service in your VPC cluster. When you try to connect to your app by using the hostname that is assigned to the Kubernetes `LoadBalancer`, the connection fails or times out.

When you run `kubectl describe svc <kubernetes_lb_service_name>`, you might see a warning message similar to one of the following in the **Events** section:
```
The VPC load balancer that routes requests to this Kubernetes `LoadBalancer` service is offline.
```
{: screen}
```
The VPC load balancer that routes requests to this Kubernetes `LoadBalancer` service was deleted from your VPC.
```
{: screen}

{: tsCauses}
When you create a Kubernetes `LoadBalancer` service in your cluster, a VPC load balancer is automatically created in your VPC. The VPC load balancer routes requests only to the app that the Kubernetes `LoadBalancer` service exposes. Requests cannot be routed to your app in the following situations:
* A VPC security group is blocking incoming traffic to your worker nodes, including incoming requests to your app.
* The VPC load balancer is offline, such as due to load balancer provisioning errors or VSI connection errors.
* The VPC load balancer is deleted through the VPC console or the CLI.
* The VPC load balancer's DNS entry is still registering.

{: tsResolve}
1. If you use use non-default [VPC security groups](/docs/vpc?topic=vpc-using-security-groups), allow traffic requests that are routed by the VPC load balancer to node ports on your worker nodes.
  1. Target Generation 1 of VPC compute.
     ```
     ibmcloud is target --gen 1
     ```
     {: pre}
  2. List your security groups. For your **VPC**, if only the default security group with a randomly generated name is listed, inbound traffic to the node ports on the worker is already allowed. If you have another security group, note its ID.
    ```
    ibmcloud is security-groups
    ```
    {: pre}
    Example output with only the default security group of a randomly generated name, `preppy-swimmer-island-green-refreshment`:
    ```
    ID                                     Name                                       Rules   Network interfaces         Created                     VPC                      Resource group
    1a111a1a-a111-11a1-a111-111111111111   preppy-swimmer-island-green-refreshment    4       -                          2019-08-12T13:24:45-04:00   <vpc_name>(bbbb222b-.)   c3c33cccc33c333ccc3c33cc3c333cc3
    ```
    {: screen}
  3. Add a rule to allow inbound TCP traffic on ports 30000-32767. For more information about the command options, see the [`security-group-rule-add` CLI reference docs](/docs/vpc-on-classic?topic=vpc-infrastructure-cli-plugin-vpc-reference#security-group-rule-add).
    ```
    ibmcloud is security-group-rule-add <security_group_ID> inbound tcp --port-min 30000 --port-max 32767
    ```
    {: pre}

2. Verify that the VPC load balancer for the Kubernetes `LoadBalancer` service exists. In the output, look for the VPC load balancer that is formatted `kube-<cluster_ID>-<kubernetes_lb_service_UID>`. You can get the Kubernetes `LoadBalancer` service UID by running `kubectl get svc <service_name> -o yaml`.
  ```
  ibmcloud is load-balancers
  ```
  {: pre}
  * If the VPC load balancer is not listed, it was deleted through the VPC console or the CLI. To re-create the VPC load balancer for your Kubernetes `LoadBalancer` service, restart the Kubernetes master by running `ibmcloud ks cluster master refresh --cluster <cluster_name_or_id>`. <p class="tip">If you want to remove the load-balancing setup for an app in your VPC cluster, delete the Kubernetes `LoadBalancer` service by running `kubectl delete svc <kubernetes_lb_service_name>`. The VPC load balancer that is associated with the Kubernetes `LoadBalancer` service is automatically deleted from your VPC.</p>
  * If the VPC load balancer is listed, its DNS entry might still be registering. When a VPC load balancer is created, the hostname is registered through a public DNS. In some cases, it can take several minutes for this DNS entry to be replicated to the specific DNS that your client is using. You can either wait for the hostname to be registered in your DNS, or access the VPC load balancer directly by using one of its IP addresses. To find the VPC load balancer IP addresses, look for the **Public IP** column in the output of `ibmcloud is load-balancers`. If after several minutes you cannot reach the load balancer, it might be offline due to provisioning or connection issues. [Open an {{site.data.keyword.cloud_notm}} support case](https://cloud.ibm.com/unifiedsupport/cases/add). For the type, select **Technical**. For the category, select **Network** in the VPC section. In the description, include your cluster ID and the VPC load balancer ID.

<br />


## VPC clusters: Kubernetes `LoadBalancer` service fails because no IPs are available
{: #vpc_no_lb}

{: tsSymptoms}
You publicly exposed your app by creating a Kubernetes `LoadBalancer` service in your VPC cluster. When you run `kubectl describe svc <kubernetes_lb_service_name>`, you see a warning message in the **Events** section similar to one of the following:
```
The subnet with ID(s) '<subnet_id>' has insufficient available ipv4 addresses.
```
{: screen}

{: tsCauses}
When you create a Kubernetes `LoadBalancer` service in your cluster, a VPC load balancer is automatically created in your VPC. The VPC load balancer puts a floating IP address for your Kubernetes `LoadBalancer` service behind a hostname that you can access your app through.

In VPC clusters, both worker nodes and services are assigned IP addresses from the same subnets. Traffic routing is enabled between subnets, so when all IP addresses in a subnet for a zone are used by worker nodes or services, you can still create new worker nodes or services in that zone because they use IP addresses from subnets in other zones. However, if all IP addresses on all subnets are in use, a new Kubernetes `LoadBalancer` service cannot be successfully provisioned.

{: tsResolve}
After you create a VPC subnet, you cannot resize it or change its IP range. Instead, you must create a larger VPC subnet in one or more zones where you have worker nodes. Then you create a new worker pool using the larger subnets.

1. [Create a new VPC subnet](https://cloud.ibm.com/vpc/provision/network){: external} in the same VPC and in one or more zones where your cluster has worker nodes. Make sure that you create a subnet that can support both the number of worker nodes and services that you plan to create in your cluster. The default CIDR size of each VPC subnet is `/24`, which can support up to 253 worker nodes and services. To check your cluster's VPC and zones, run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.

2. Create a new worker pool in your cluster.
     ```
     ibmcloud ks worker-pool create vpc-classic --name <name> --cluster <cluster_name_or_ID> --flavor <flavor> --size-per-zone <number_of_worker_nodes> --label <key>=<value>
     ```
     {: pre}

3. Using the ID for the larger subnets that you created in step 1, add the zones to the worker pool. Repeat the following command for each zone and subnet.
    ```
    ibmcloud ks zone add vpc-classic --zone <zone> --subnet-id <subnet_id> --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name>
    ```
    {: pre}

4. After a few minutes, verify that your `LoadBalancer` service is successfully provisioned onto one of the new subnets. If the service is provisioned successfully, no `Warning` or `Error` events are displayed.
  ```
  kubectl describe svc <kubernetes_lb_service_name>
  ```
  {: pre}

<br />


## Feedback, questions, and support
{: #getting_help}

Still having issues with your cluster? Review different ways to get help and support for your {{site.data.keyword.containerlong_notm}} clusters. For any questions or feedback, post in Slack.
{: shortdesc}

**General ways to resolve issues**<br>
1. Keep your cluster environment up to date.
   * Check monthly for available security and operating system patches to [update your worker nodes](/docs/containers?topic=containers-update#worker_node).
   * [Update your cluster](/docs/containers?topic=containers-update#master) to the latest default version for [{{site.data.keyword.containershort}}](/docs/containers?topic=containers-cs_versions).
2. Make sure that your command line tools are up to date.
   * In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and flags.
   * Make sure that [your `kubectl` CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) client matches the same Kubernetes version as your cluster server. [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2).
<br>

**Reviewing issues and status**<br>
1. To see whether {{site.data.keyword.cloud_notm}} is available, [check the {{site.data.keyword.cloud_notm}} status page](https://cloud.ibm.com/status?selected=status){: external}.
2. Filter for the **Kubernetes Service** component.
<br>

**Feedback and questions**<br>
1. Post in the {{site.data.keyword.containershort}} Slack.
   * If you are an external user, post in the [#general](https://ibm-container-service.slack.com/archives/C4G6362ER){: external} channel.
   * If you are an IBMer, use the [#armada-users](https://ibm-argonauts.slack.com/archives/C4S4NUCB1) channel.<p class="tip">If you do not use an IBMid for your {{site.data.keyword.cloud_notm}} account, [request an invitation](https://cloud.ibm.com/kubernetes/slack){:external} to this Slack.</p>
2. Review forums such as {{site.data.keyword.containershort}} help, Stack Overflow, and IBM Developer to see whether other users ran into the same issue. When you use the forums to ask a question, tag your question so that it is seen by the {{site.data.keyword.cloud_notm}} development teams.
   * If you have technical questions about developing or deploying clusters or apps with {{site.data.keyword.containerlong_notm}}, post your question on [Stack Overflow](https://stackoverflow.com/questions/tagged/ibm-cloud+containers){: external} and tag your question with `ibm-cloud`, `containers`, and `openshift`.
   * For questions about the service and getting started instructions, use the [IBM Developer Answers](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix){: external} forum. Include the `ibm-cloud` and `containers` tags.
   * See [Getting help](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) for more details about using the forums.
<br>

**Getting help**<br>
1.  Contact IBM Support by opening a case. To learn about opening an IBM support case, or about support levels and case severities, see [Contacting support](/docs/get-support?topic=get-support-getting-customer-support).
2.  In your support case, for **Category**, select **Containers**.
3.  For the **Offering**, select your {{site.data.keyword.containershort}} cluster.<p class="tip">When you report an issue, include your cluster ID. To get your cluster ID, run `ibmcloud ks cluster ls`. You can also use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to gather and export pertinent information from your cluster to share with IBM Support.</p>


