---

copyright: 
  years: 2014, 2022
lastupdated: "2022-02-28"

keywords: kubernetes, affinity, taint

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Restricting network traffic to edge worker nodes on classic infrastructure
{: #edge}

Edge worker nodes can improve the security of your {{site.data.keyword.containerlong}} cluster by allowing fewer worker nodes by isolating the networking workload.
{: shortdesc}

When you mark these worker nodes for networking only, other workloads can't consume the CPU or memory of the worker node and interfere with networking.

If you want to restrict network traffic to edge worker nodes in a multizone cluster, you must have at least two edge worker nodes per zone for high availability of load balancer or Ingress pods. Create an edge node worker pool that spans all the zones in your cluster, with at least two worker nodes per zone.
{: tip}

## Isolating networking workloads to edge nodes
{: #edge_nodes}

Add the `dedicated=edge` label to worker nodes on each public or private VLAN in your cluster. The labels ensure that network load balancers (NLBs) and Ingress application load balancers (ALBs) are deployed to those worker nodes only. For NLBs, ensure that two or more worker nodes per zone are edge nodes. For ALBs, ensure that three or more worker nodes per zone are edge nodes. Both public and private NLBs and ALBs can deploy to edge worker nodes.
{: shortdesc}

Using a gateway-enabled cluster? See [Isolating networking workloads to edge nodes in classic gateway-enabled clusters](#edge_gateway) instead.
{: tip}

Before you begin

* Ensure that you have the following [{{site.data.keyword.cloud_notm}} IAM roles](/docs/containers?topic=containers-users#checking-perms):
    * Any platform access role for the cluster
    * **Writer** or **Manager** service access role for all namespaces
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To create an edge node worker pool,

1. [Create a worker pool](/docs/containers?topic=containers-add_workers#add_pool) that spans all zones in your cluster and has at least two workers per zone if you use NLBs or 3 or more workers per zone if you use ALBs. In the `ibmcloud ks worker-pool create` command, include the `--label dedicated=edge` flag to label all worker nodes in the pool. All worker nodes in this pool, including any worker nodes that you add later, are labeled as edge nodes.

    If you want to use an existing worker pool, the pool must span all zones in your cluster and have at least two worker nodes per zone. You can label the worker pool with `dedicated=edge` by using the [`ibmcloud ks worker-pool label set` command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_label_set).
    {: tip}

    To ensure that ALB pods are always scheduled to edge worker nodes if they are present and not scheduled to non-edge worker nodes, you must create or use an existing worker pool that has at least three edge worker nodes per zone. During the update of an ALB pod, a new ALB pod rolls out to replace an existing ALB pod. However, ALB pods have anti-affinity rules that don't permit a pod to deploy to a worker node where another ALB pod already exists. If you have only two edge nodes per zone, both ALB pod replicas already exist on those edge nodes, so the new ALB pod must be scheduled on a non-edge worker node. When three edge nodes are present in a zone, the new ALB pod can be scheduled to the third edge node. Then, the old ALB pod is removed.
    {: important}

2. Verify that the worker pool and worker nodes have the `dedicated=edge` label.
    * To check the worker pool
        ```sh
        ibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

    * To check individual worker nodes, review the **Labels** field of the output of the following command.
        ```sh
        kubectl describe node <worker_node_private_IP>
        ```
        {: pre}

3. Retrieve all existing NLBs in the cluster.
    ```sh
    kubectl get services --all-namespaces | grep LoadBalancer
    ```
    {: pre}

    In the output, note the **Namespace** and **Name** of each load balancer service. For example, the following output shows one public NLB in the `default` namespace.
    ```sh
    NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                     AGE
    default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                                11m
    ```
    {: screen}

4. Using the output from the previous step, run the following command for each NLB. This command redeploys the NLB to an edge worker node. You can deploy both public and private NLBs to the edge worker nodes.

    ```sh
    kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
    ```
    {: pre}

    Example output

    ```sh
    service "webserver-lb" configured
    ```
    {: screen}

5. To verify that networking workloads are restricted to edge nodes, confirm that NLB are scheduled onto the edge nodes and are not scheduled onto non-edge nodes.

    * NLB pods
        1. Confirm that the NLB pods are deployed to edge nodes. Search for the external IP address of the load balancer service that is listed in the output of step 3. Replace the periods (`.`) with hyphens (`-`). Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
            ```sh
            kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
            ```
            {: pre}

            Example output
            ```sh
            ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
            ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
            ```
            {: screen}

        2. Confirm that no NLB pods are deployed to non-edge nodes. Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
            ```sh
            kubectl describe nodes -l dedicated!=edge | grep "169-46-17-2"
            ```
            {: pre}

            * If the NLB pods are correctly deployed to edge nodes, no NLB pods are returned. Your NLBs are successfully rescheduled onto only edge worker nodes.
            * If NLB pods are returned, continue to the next step.


6. If NLB pods are still deployed to non-edge nodes, you can delete the pods so that they redeploy to edge nodes. **Important**: Delete only one pod at a time, and verify that the pod is rescheduled onto an edge node before you delete other pods.
    1. Delete a pod. Example for if one of the `webserver-lb` NLB pods did not schedule to an edge node:
        ```sh
        kubectl delete pod ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg
        ```
        {: pre}

    2. Verify that the pod is rescheduled onto an edge worker node. Rescheduling is automatic, but might take a few minutes. Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
        ```sh
        kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
        ```
        {: pre}

        Example output

        ```sh
        ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
        ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
        ```
        {: screen}

7. Retrieve all existing ALBs in the cluster. Review the command output. For each ALB that has a **Status** of **enabled**, note the **ALB ID** and **Build**.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ALB ID                                Enabled   State     Type      Load Balancer Hostname                      Zone         Build                                  Status
    private-crc81nk5l10gfhdql4i3qg-alb1   true      enabled   private   e9dd35e6-us-south.lb.test.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   enabled
    public-crc81nk5l10gfhdql4i3qg-alb1    true      enabled   public    38daf55c-us-south.lb.test.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   healthy
    ```
    {: screen}

8. Using the output from the previous step, run the `ibmcloud ks ingress alb update` command for each enabled ALB. This command redeploys the ALB to an edge worker node. 

    When you run this command to redeploy the ALB to an edge worker node, the ALB also updates to the latest version. If you do not want to update the ALB to the latest version, include the `--version` flag and specify the version listed under **Build** in the output from the previous step. 
    {: tip}

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --alb <ALB_ID> [--version <build_version>] 
    ```
    {: pre}

    Example output

    ```sh
    Updating ALB pods for private-crc81nk5l10gfhdql4i3qg-alb1 to version '1.1.1_1949_iks' in cluster c81nk5l10gfhdql4i3qg...
    OK
    ```
    {: screen}

9. Verify that ALB pods are scheduled onto edge nodes and are not scheduled onto compute nodes.
    1. Confirm that all ALB pods are deployed to edge nodes. Each public and private ALB that is enabled in your cluster has two pods.

        ```sh
        kubectl describe nodes -l dedicated=edge | grep alb
        ```
        {: pre}

        Example output

        ```sh
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        ```
        {: screen}

    2. Confirm that no ALB pods are deployed to non-edge nodes.

        ```sh
        kubectl describe nodes -l dedicated!=edge | grep alb
        ```
        {: pre}

        If the ALB pods are correctly deployed to edge nodes, no ALB pods are returned. Your ALBs are successfully rescheduled onto only edge worker nodes.



You labeled worker nodes in a worker pool with `dedicated=edge` and redeployed all the existing ALBs and NLBs to the edge nodes. All subsequent ALBs and NLBs that are added to the cluster are also deployed to an edge node in your edge worker pool. Next, prevent other [workloads from running on edge worker nodes](#edge_workloads) and [block inbound traffic to NodePorts on worker nodes](/docs/containers?topic=containers-network_policies#block_ingress).


## Preventing app workloads from running on edge worker nodes
{: #edge_workloads}

A benefit of edge worker nodes is that they can be specified to run networking services only.
{: shortdesc}

Using the `dedicated=edge` toleration means that all network load balancer (NLB) and Ingress application load balancer (ALB) services are deployed to the labeled worker nodes only. However, to prevent other workloads from running on edge worker nodes and consuming worker node resources, you must use [Kubernetes taints](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external}.


Using a gateway-enabled cluster? See [Isolating networking workloads to edge nodes in classic gateway-enabled clusters](#edge_gateway) instead.
{: tip}

Before you begin
- Ensure you that have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role for all namespaces](/docs/containers?topic=containers-users#checking-perms).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To prevent other workloads from running on edge worker nodes,

1. Apply a taint to the worker nodes with the `dedicated=edge` label. The taint prevents pods from running on the worker node and removes pods that don't have the `dedicated=edge` label from the worker node. The pods that are removed are redeployed to other worker nodes with capacity.

    To apply a taint to all existing and future worker nodes in a worker pool:
    ```sh
    ibmcloud ks worker-pool taint set -c <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> --taint dedicated=edge:NoExecute
    ```
    {: pre}

    To apply a taint to individual worker nodes:
    ```sh
    kubectl taint node -l dedicated=edge dedicated=edge:NoExecute
    ```
    {: pre}

    Now, only pods with the `dedicated=edge` toleration are deployed to your edge worker nodes.

2. Verify that your edge nodes are tainted.
    ```sh
    kubectl describe nodes -l dedicated=edge | egrep "Taints|Hostname"
    ```
    {: pre}

    Example output

    ```sh
    Taints:             dedicated=edge:NoExecute
        Hostname:    10.176.48.83
      Taints:             dedicated=edge:NoExecute
    Hostname:    10.184.58.7
    ```
    {: screen}

3. If you choose to [enable source IP preservation for an NLB 1.0 service](/docs/containers?topic=containers-loadbalancer#lb_source_ip), ensure that app pods are scheduled onto the edge worker nodes by [adding edge node affinity to app pods](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). App pods must be scheduled onto edge nodes to receive incoming requests.

4. Optional: You can remove a taint from the worker nodes.

    To remove all taints from all worker nodes in a worker pool,
    ```sh
    ibmcloud ks worker-pool taint rm -c <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
    ```
    {: pre}

    To remove individual taints from individual worker nodes,
    ```sh
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}

## Isolating ALB proxy workloads to edge nodes in classic gateway-enabled clusters
{: #edge_gateway}

![Classic infrastructure provider icon.](images/icon-classic-2.svg) Create a worker pool of edge nodes in your gateway-enabled cluster to ensure that Ingress application load balancers (ALB) pods are deployed to those worker nodes only.
{: shortdesc}

When you create a [classic cluster with a gateway](/docs/containers?topic=containers-plan_basics#gateway), the cluster is created with a `compute` worker pool of compute worker nodes that are connected to a private VLAN only, and a `gateway` worker pool of gateway worker nodes that are connected to public and private VLANs. Gateway worker nodes help you achieve network connectivity separation between the internet or an on-premises data center and the compute workload that runs in your cluster. By default, all network load balancer (NLB) and Ingress application load balancer (ALB) pods deploy to the gateway worker nodes, which are also tainted so that no compute workloads can be scheduled onto them.

To ensure that ALB pods are always scheduled to gateway worker nodes if they are present and not scheduled to non-gateway worker nodes, you must create or use an existing worker pool that has at least two gateway worker nodes per zone. If you have only one gateway node per zone, the ALB pods will be scheduled on a non-gateway worker node. When two gateway nodes are present in a zone, the new ALB pod can be scheduled to the second gateway node.
{: important}

If you want to provide another level of network separation between the public network and workloads in your compute worker nodes, you can optionally create a worker pool of edge nodes. As opposed to gateway nodes, the edge nodes have only private network connectivity and can't be accessed directly from the public network. NLB pods remain deployed to the gateway worker nodes, but ALB pods are deployed to only edge nodes. By deploying only ALBs to edge nodes, all layer 7 proxy management is kept separate from the gateway worker nodes so that TLS termination and HTTP request routing is completed by the ALBs on the private network only. The edge nodes are also tainted so that no compute workloads can be scheduled onto them.

If you use Ingress ALBs to expose your apps, requests to the path for your app are first routed to the load balancer that exposes your ALBs in the gateway worker pool. The traffic is then load balanced over the private network to one of the ALB pods that is deployed in the edge worker pool. Finally, the ALB in the edge worker pool proxies the request to one of your app pods in your worker pools of compute worker nodes. For more information about the flow of traffic through Ingress ALBs in gateway-enabled clusters, see the [Ingress architecture diagram](/docs/containers?topic=containers-ingress-about#classic-gateway).

Before you begin

* Ensure that you have the following [{{site.data.keyword.cloud_notm}} IAM roles](/docs/containers?topic=containers-users#checking-perms) for {{site.data.keyword.containerlong_notm}}:
    * Any platform access role for the cluster
    * **Writer** or **Manager** service access role for all namespaces
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To create an edge node worker pool in a gateway-enabled classic cluster,

1. Retrieve all the **Worker Zones** that your existing worker nodes are connected to.
    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ...
    Worker Zones:                   dal10, dal12
    ```
    {: screen}

2. For each zone, list available private VLANs. Note the private VLAN ID that you want to use.
    ```sh
    ibmcloud ks vlan ls --zone <zone>
    ```
    {: pre}

3. For each zone, review the available [flavors for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).
    ```sh
    ibmcloud ks flavors --zone <zone>
    ```
    {: pre}

4. Create a worker pool for your edge worker nodes. Your worker pool includes the machine type, the number of worker nodes that you want to have, and the edge labels that you want to add to the worker nodes. When you create the worker pool, your worker nodes are not yet provisioned. Continue with the next step to add worker nodes to your edge worker pool.
    ```sh
    ibmcloud ks worker-pool create classic --cluster <cluster_name_or_ID> --name edge --flavor <flavor> --size-per-zone 2 --labels dedicated=edge,node-role.kubernetes.io/edge=true,ibm-cloud.kubernetes.io/private-cluster-role=worker
    ```
    {: pre}

5. Deploy worker nodes in the `edge` worker pool by adding the zones that you previously retrieved to the worker pool. Repeat this command for each zone. All worker nodes in this `edge` pool are connected to a private VLAN only.
    ```sh
    ibmcloud ks zone add classic --zone <zone> --cluster <cluster_name_or_ID> --worker-pool edge  --private-vlan <private_VLAN_ID> --private-only
    ```
    {: pre}

6. Verify that the worker pool and worker nodes are provisioned and have the `dedicated=edge` label.
    * To check the worker pool:
        ```sh
        ibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

    * To check individual worker nodes, review the **Labels** field of the output of the following command. Your edge nodes are ready when the **Status** is `Ready`.
        ```sh
        kubectl describe node <worker_node_private_IP>
        ```
        {: pre}

7. Retrieve all existing ALBs in the cluster. Review the command output. For each ALB that has a **Status** of **enabled**, note the **ALB ID** and **Build**.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ALB ID                                Enabled   State     Type      Load Balancer Hostname                      Zone         Build                                  Status
    private-crc81nk5l10gfhdql4i3qg-alb1   true      enabled   private   e9dd35e6-us-south.lb.test.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   enabled
    public-crc81nk5l10gfhdql4i3qg-alb1    true      enabled   public    38daf55c-us-south.lb.test.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   healthy
    ```
    {: screen}

8. Using the output from the previous step, run the `ibmcloud ks ingress alb update` command for each enabled ALB. This command redeploys the ALB to an edge worker node. For the `--version` flag, use the version listed under **Build** in the output from the previous step. 

    When you run this command to redeploy the ALB to an edge worker node, the ALB also updates to the latest version. If you do not want to update the ALB to the latest version, include the `--version` flag and specify the version listed under **Build** in the output from the previous step. 
    {: tip}

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --version <build_version> --alb <ALB_ID> 
    ```
    {: pre}

    Example output

    ```sh
    Updating ALB pods for private-crc81nk5l10gfhdql4i3qg-alb1 to version '1.1.1_1949_iks' in cluster c81nk5l10gfhdql4i3qg...
    OK
    ```
    {: screen}

9. Verify that ALB pods are scheduled onto edge nodes and are not scheduled onto compute nodes.
    1. Confirm that all ALB pods are deployed to edge nodes. Each public and private ALB that is enabled in your cluster has two pods.
        ```sh
        kubectl describe nodes -l dedicated=edge | grep alb
        ```
        {: pre}

        Example output

        ```sh
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        ```
        {: screen}

    2. Confirm that no ALB pods are deployed to non-edge nodes.
        ```sh
        kubectl describe nodes -l dedicated!=edge | grep alb
        ```
        {: pre}

        If the ALB pods are correctly deployed to edge nodes, no ALB pods are returned. Your ALBs are successfully rescheduled onto only edge worker nodes.





