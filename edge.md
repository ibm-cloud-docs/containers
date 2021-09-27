---

copyright: 
  years: 2014, 2021
lastupdated: "2021-09-27"

keywords: kubernetes, iks, affinity, taint

subcollection: containers

---




{{site.data.keyword.attribute-definition-list}}


# Classic: Restricting network traffic to edge worker nodes
{: #edge}

Edge worker nodes can improve the security of your {{site.data.keyword.containerlong}} cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload.
{: shortdesc}

When these worker nodes are marked for networking only, other workloads cannot consume the CPU or memory of the worker node and interfere with networking.

If you want to restrict network traffic to edge worker nodes in a multizone cluster, at least two edge worker nodes must be enabled per zone for high availability of load balancer or Ingress pods. Create an edge node worker pool that spans all the zones in your cluster, with at least two worker nodes per zone.
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

    To ensure that ALB pods are always scheduled to edge worker nodes if they are present and not scheduled to non-edge worker nodes, you must create or use an existing worker pool that has at least three edge worker nodes per zone. During the update of an ALB pod, a new ALB pod rolls out to replace an existing ALB pod. However, ALB pods have anti-affinity rules that do not permit a pod to deploy to a worker node where another ALB pod already exists. If you have only two edge nodes per zone, both ALB pod replicas already exist on those edge nodes, so the new ALB pod must be scheduled on a non-edge worker node. When three edge nodes are present in a zone, the new ALB pod can be scheduled to the third edge node. Then, the old ALB pod is removed.
    {: important}

2. Verify that the worker pool and worker nodes have the `dedicated=edge` label.
    * To check the worker pool
        ```
        ibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

    * To check individual worker nodes, review the **Labels** field of the output of the following command.
        ```
        kubectl describe node <worker_node_private_IP>
        ```
        {: pre}

3. Retrieve all existing NLBs and ALBs in the cluster.
    ```
    kubectl get services --all-namespaces | grep LoadBalancer
    ```
    {: pre}

    In the output, note the **Namespace** and **Name** of each load balancer service. For example, the following output shows four load balancer services: one public NLB in the `default` namespace, and one private and two public ALBs in the `kube-system` namespace.
    ```
    NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                     AGE
    default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                                11m
    kube-system   private-crdf253b6025d64944ab99ed63bb4567b6-alb1  LoadBalancer   172.21.158.78    10.185.94.150   80:31015/TCP,443:31401/TCP,9443:32352/TCP   25d
    kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP                  25d
    kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP                  25d
    ```
    {: screen}

4. Using the output from the previous step, run the following command for each NLB and ALB. This command redeploys the NLB or ALB to an edge worker node.You can deploy both public and private NLBs and ALBs to the edge worker nodes.

    ```
    kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
    ```
    {: pre}

    Example output
    ```
    service "webserver-lb" configured
    ```
    {: screen}

5. To verify that networking workloads are restricted to edge nodes, confirm that NLB and ALB pods are scheduled onto the edge nodes and are not scheduled onto non-edge nodes.

    * NLB pods
        1. Confirm that the NLB pods are deployed to edge nodes. Search for the external IP address of the load balancer service that is listed in the output of step 3. Replace the periods (`.`) with hyphens (`-`). Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
        ```
        kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
        ```
        {: pre}

        Example output
        ```
        ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
        ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
        ```
        {: screen}

    2. Confirm that no NLB pods are deployed to non-edge nodes. Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
        ```
        kubectl describe nodes -l dedicated!=edge | grep "169-46-17-2"
        ```
        {: pre}

        * If the NLB pods are correctly deployed to edge nodes, no NLB pods are returned. Your NLBs are successfully rescheduled onto only edge worker nodes.
        * If NLB pods are returned, continue to the next step.

    * ALB pods:
        1. Confirm that all ALB pods are deployed to edge nodes. Each public and private ALB that is enabled in your cluster has two pods.
        ```
        kubectl describe nodes -l dedicated=edge | grep alb
        ```
        {: pre}

        Example output for a cluster with two zones in which one default private and two default public ALBs are enabled:
        ```
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb2-57df7c7b5b-tp6xw    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb2-57df7c7b5b-z5p2v    0 (0%)        0 (0%)      0 (0%)           0 (0%)
        ```
        {: screen}

    2. Confirm that no ALB pods are deployed to non-edge nodes.
        ```
        kubectl describe nodes -l dedicated!=edge | grep alb
        ```
        {: pre}

        * If the ALB pods are correctly deployed to edge nodes, no ALB pods are returned. Your ALBs are successfully rescheduled onto only edge worker nodes.
        * If ALB pods are returned, continue to the next step.

6. If NLB or ALB pods are still deployed to non-edge nodes, you can delete the pods so that they redeploy to edge nodes. **Important**: Delete only one pod at a time, and verify that the pod is rescheduled onto an edge node before you delete other pods.
    1. Delete a pod. Example for if one of the `webserver-lb` NLB pods did not schedule to an edge node:
    ```
    kubectl delete pod ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg
    ```
    {: pre}

    2. Verify that the pod is rescheduled onto an edge worker node. Rescheduling is automatic, but might take a few minutes. Example for the `webserver-lb` NLB that has an external IP address of `169.46.17.2`:
    ```
    kubectl describe nodes -l dedicated=edge | grep "169-46-17-2"
    ```
    {: pre}

    Example output:
    ```
    ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-wz6dg                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
    ibm-system                 ibm-cloud-provider-ip-169-46-17-2-76fcb4965d-2z64r                 5m (0%)       0 (0%)      10Mi (0%)        0 (0%)
    ```
    {: screen}

</br>You labeled worker nodes in a worker pool with `dedicated=edge` and redeployed all of the existing ALBs and NLBs to the edge nodes. All subsequent ALBs and NLBs that are added to the cluster are also deployed to an edge node in your edge worker pool. Next, prevent other [workloads from running on edge worker nodes](#edge_workloads) and [block inbound traffic to NodePorts on worker nodes](/docs/containers?topic=containers-network_policies#block_ingress).


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

1. Apply a taint to the worker nodes with the `dedicated=edge` label. The taint prevents pods from running on the worker node and removes pods that do not have the `dedicated=edge` label from the worker node. The pods that are removed are redeployed to other worker nodes with capacity.

    To apply a taint to all existing and future worker nodes in a worker pool:
    ```
    ibmcloud ks worker-pool taint set -c <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> --taint dedicated=edge:NoExecute
    ```
    {: pre}

    To apply a taint to individual worker nodes:
    ```
    kubectl taint node -l dedicated=edge dedicated=edge:NoExecute
    ```
    {: pre}

    Now, only pods with the `dedicated=edge` toleration are deployed to your edge worker nodes.

2. Verify that your edge nodes are tainted.
    ```
    kubectl describe nodes -l dedicated=edge | egrep "Taints|Hostname"
    ```
    {: pre}

    Example output:
    ```
    Taints:             dedicated=edge:NoExecute
        Hostname:    10.176.48.83
      Taints:             dedicated=edge:NoExecute
    Hostname:    10.184.58.7
    ```
    {: screen}

3. If you choose to [enable source IP preservation for an NLB 1.0 service](/docs/containers?topic=containers-loadbalancer#lb_source_ip), ensure that app pods are scheduled onto the edge worker nodes by [adding edge node affinity to app pods](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). App pods must be scheduled onto edge nodes to receive incoming requests.

4. Optional: You can remove a taint from the worker nodes.

    To remove all taints from all worker nodes in a worker pool,
    ```
    ibmcloud ks worker-pool taint rm -c <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
    ```
    {: pre}

    To remove individual taints from individual worker nodes,
    ```
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}

## Isolating ALB proxy workloads to edge nodes in classic gateway-enabled clusters
{: #edge_gateway}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Create a worker pool of edge nodes in your gateway-enabled cluster to ensure that Ingress application load balancers (ALB) pods are deployed to those worker nodes only.
{: shortdesc}

When you create a [classic cluster with a gateway](/docs/containers?topic=containers-plan_clusters#gateway), the cluster is created with a `compute` worker pool of compute worker nodes that are connected to a private VLAN only, and a `gateway` worker pool of gateway worker nodes that are connected to public and private VLANs. Gateway worker nodes help you achieve network connectivity separation between the internet or an on-premises data center and the compute workload that runs in your cluster. By default, all network load balancer (NLB) and Ingress application load balancer (ALB) pods deploy to the gateway worker nodes, which are also tainted so that no compute workloads can be scheduled onto them.

If you want to provide another level of network separation between the public network and workloads in your compute worker nodes, you can optionally create a worker pool of edge nodes. As opposed to gateway nodes, the edge nodes have only private network connectivity and cannot be accessed directly from the public network. NLB pods remain deployed to the gateway worker nodes, but ALB pods are deployed to only edge nodes. By deploying only ALBs to edge nodes, all layer 7 proxy management is kept separate from the gateway worker nodes so that TLS termination and HTTP request routing is completed by the ALBs on the private network only. The edge nodes are also tainted so that no compute workloads can be scheduled onto them.

If you use Ingress ALBs to expose your apps, requests to the path for your app are first routed to the load balancer that exposes your ALBs in the gateway worker pool. The traffic is then load balanced over the private network to one of the ALB pods that is deployed in the edge worker pool. Finally, the ALB in the edge worker pool proxies the request to one of your app pods in your worker pools of compute worker nodes. For more information about the flow of traffic through Ingress ALBs in gateway-enabled clusters, see the [Ingress architecture diagram](/docs/containers?topic=containers-ingress-about#classic-gateway).

Before you begin

* Ensure that you have the following [{{site.data.keyword.cloud_notm}} IAM roles](/docs/containers?topic=containers-users#checking-perms) for {{site.data.keyword.containerlong_notm}}:
    * Any platform access role for the cluster
    * **Writer** or **Manager** service access role for all namespaces
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To create an edge node worker pool in a gateway-enabled classic cluster,

1. Retrieve all of the **Worker Zones** that your existing worker nodes are connected to.
    ```
    ibmcloud ks cluster get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output:
    ```
    ...
    Worker Zones:                   dal10, dal12
    ```
    {: screen}

2. For each zone, list available private VLANs. Note the private VLAN ID that you want to use.
    ```
    ibmcloud ks vlan ls --zone <zone>
    ```
    {: pre}

3. For each zone, review the available [flavors for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).
    ```
    ibmcloud ks flavors --zone <zone>
    ```
    {: pre}

4. Create a worker pool for your edge worker nodes. Your worker pool includes the machine type, the number of worker nodes that you want to have, and the edge labels that you want to add to the worker nodes. When you create the worker pool, your worker nodes are not yet provisioned. Continue with the next step to add worker nodes to your edge worker pool.
    ```
    ibmcloud ks worker pool create classic --cluster <cluster_name_or_ID> --name edge --flavor <flavor> --size-per-zone 2 --labels dedicated=edge,node-role.kubernetes.io/edge=true,ibm-cloud.kubernetes.io/private-cluster-role=worker
    ```
    {: pre}

5. Deploy worker nodes in the `edge` worker pool by adding the zones that you previously retrieved to the worker pool. Repeat this command for each zone. All worker nodes in this `edge` pool are connected to a private VLAN only.
    ```
    ibmcloud ks zone add classic --zone <zone> --cluster <cluster_name_or_ID> --worker-pool edge --private-vlan <private_VLAN_ID>
    ```
    {: pre}

6. Verify that the worker pool and worker nodes are provisioned and have the `dedicated=edge` label.
    * To check the worker pool:
        ```
        ibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

    * To check individual worker nodes, review the **Labels** field of the output of the following command. Your edge nodes are ready when the **Status** is `Ready`.
        ```
        kubectl describe node <worker_node_private_IP>
        ```
        {: pre}

7. Retrieve all existing ALBs in the cluster. In the output, note the **Namespace** and **Name** of each ALB.
    ```
    kubectl get services --all-namespaces | grep alb
    ```
    {: pre}

    Example output
    ```
    NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                     AGE
    kube-system   private-crdf253b6025d64944ab99ed63bb4567b6-alb1  LoadBalancer   172.21.158.78    10.xxx.xx.xxx   80:31015/TCP,443:31401/TCP,9443:32352/TCP   25d
    kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.xx.xxx.xx   80:30286/TCP,443:31363/TCP                  25d
    ```
    {: screen}

8. Using the output from the previous step, run the following command for each ALB. This command redeploys the ALB to an edge worker node.
    ```
    kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
    ```
    {: pre}

    Example output
    ```
    service "private-crdf253b6025d64944ab99ed63bb4567b6-alb1" configured
    ```
    {: screen}

9. Verify that ALB pods are scheduled onto edge nodes and are not scheduled onto compute nodes.
    1. Confirm that all ALB pods are deployed to edge nodes. Each public and private ALB that is enabled in your cluster has two pods.
    ```
    kubectl describe nodes -l dedicated=edge | grep alb
    ```
    {: pre}

    Example output
    ```
    kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                private-crdf253b6025d64944ab99ed63bb4567b6-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                public-crdf253b6025d64944ab99ed63bb4567b6-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    ```
    {: screen}

    2. Confirm that no ALB pods are deployed to non-edge nodes.
    ```
    kubectl describe nodes -l dedicated!=edge | grep alb
    ```
    {: pre}

    * If the ALB pods are correctly deployed to edge nodes, no ALB pods are returned. Your ALBs are successfully rescheduled onto only edge worker nodes.
    * If ALB pods are returned, continue to the next step.

10. If ALB pods are still deployed to non-edge nodes, you can delete the pods so that they redeploy to edge nodes. **Important**: Delete only one pod at a time, and verify that the pod is rescheduled onto an edge node before you delete other pods.
    1. Delete a pod.
        ```
        kubectl delete pod <pod_name>
        ```
        {: pre}

    2. Verify that the pod is rescheduled onto an edge worker node. Rescheduling is automatic, but might take a few minutes.
        ```
        kubectl describe nodes -l dedicated=edge | grep "<pod_name>"
        ```
        {: pre}

You labeled worker nodes in a worker pool with `dedicated=edge` and redeployed all of the existing ALBs to the edge nodes. All subsequent ALBs that are enabled in or added to the cluster are also deployed to an edge node in your edge worker pool.




