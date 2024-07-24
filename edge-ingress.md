---

copyright: 
  years: 2024, 2024
lastupdated: "2024-07-24"


keywords: containers, kubernetes, affinity, taint, edge node, edge

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# Isolating Ingress resources to edge worker nodes
{: #edge}

To ensure that ALB pods are always scheduled to edge worker nodes if they are present and not scheduled to non-edge worker nodes, you must create or use an existing worker pool that has at least two edge worker nodes per zone.

During the update of an ALB pod, a new ALB pod rolls out to replace an existing ALB pod. To keep the ALB available during update, the rolling update ensures that at least one ALB pod is active. However, ALB pods have anti-affinity rules that don't permit two ALB pods on the same worker. When at least two edge nodes are present in a zone, the new ALB pod can be replaced on one of them while the other one keeps running. 

For high availability of the ALB, the edge node label is ignored when there aren't enough edge nodes in each region, and the ALB pods are scheduled to non-edge nodes as well.

The steps to isolate ALB workloads to edge nodes is the same for both classic and VPC infrastructure. However, the naming convention for the ALB External IP is different for each type. For ALBs on classic infrastructure, the External IP is a standard IP address such as `169.46.17.2`. For ALBs on VPC infrastructure, the External IP is a hostname such as `f3bee8b5-us-south.lb.appdomain.cloud`.






* Ensure that you have the following IAM roles:
    * Any platform access role for the cluster
    * **Writer** or **Manager** service access role for all namespaces
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

To isolate your workload to edge worker nodes:

1. Create a worker pool with the label `dedicated=edge` or add the label to one of your existing worker pools.
    * To create a Classic worker pool, you can use the `worker-pool create classic` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_create).
        ```sh
        ibmcloud oc worker-pool create classic --name POOL_NAME --cluster CLUSTER --flavor FLAVOR --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION --label dedicated=edge
        ```
        {: pre}

    * To create a VPC worker pool, you can use the `worker-pool create vpc-gen2` [command](/docs/containers?topic=containers-kubernetes-service-cli#cli_worker_pool_create_vpc_gen2).
        ```sh
        ibmcloud oc worker-pool create vpc-gen2 --name POOL_NAME --cluster CLUSTER --flavor FLAVOR --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION --label dedicated=edge
        ```
        {: pre}

    * To label an existing worker pool, you can use the `worker-pool label set` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_pool_label_set).
        ```sh
        ibmcloud oc worker-pool label set --cluster CLUSTER --worker-pool POOL --label dedicated=edge
        ```
        {: pre}

1. Verify that the worker pool and worker nodes have the `dedicated=edge` label.
    * To check the worker pool, use the `get` command.
        ```sh
        ibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID>
        ```
        {: pre}

    * To check individual worker nodes, review the **Labels** field of the output of the following command.
        ```sh
        kubectl describe node <worker_node_private_IP>
        ```
        {: pre}



1. Retrieve all existing ALBs in the cluster. Review the command output. For each ALB that has a **Status** of **enabled**, note the **ALB ID** and **Build**.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    ALB ID                                Enabled   State     Type      Load Balancer Hostname                      Zone         Build                                  Status
    private-crc81nk5l10gfhdql4i3qg-alb1   true      enabled   private   e9dd35e6-us-south.lb.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   enabled
    public-crc81nk5l10gfhdql4i3qg-alb1    true      enabled   public    38daf55c-us-south.lb.appdomain.cloud   us-south-3   ingress:1.1.1_1949_iks/ingress-auth:   healthy
    ```
    {: screen}

1. Using the output from the previous step, run the `ibmcloud ks ingress alb update` command for each enabled ALB. This command redeploys the ALB to an edge worker node. 

    When you run this command to redeploy the ALB to an edge worker node, the ALB also updates to the latest version. If you do not want to update the ALB to the latest version, include the `--version` option and specify the version listed under **Build** in the output from the previous step. 
    {: tip}

    ```sh
    ibmcloud ks ingress alb update -c <cluster_name_or_ID> --alb <ALB_ID> [--version <build_version>] 
    ```
    {: pre}

    Example output

    ```sh
    Updating ALB pods for private-crc81nk5l10gfhdql4i3qg-alb1 to version '1.1.1_1949_iks' in cluster crc81nk5l10gfhdql4i3qg...
    OK
    ```
    {: screen}

1. Confirm that all ALB pods are deployed to edge nodes. Each public and private ALB that is enabled in your cluster has two pods.

    ```sh
    kubectl describe nodes -l dedicated=edge | grep alb
    ```
    {: pre}

    Example output

    ```sh
    kube-system                private-crc81nk5l10gfhdql4i3qg-alb1-d5dd478db-27pv4    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                private-crc81nk5l10gfhdql4i3qg-alb1-d5dd478db-7p9q6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                public-crc81nk5l10gfhdql4i3qg-alb1-5ff8cdff89-s77z6    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    kube-system                public-crc81nk5l10gfhdql4i3qg-alb1-5ff8cdff89-kvs9f    0 (0%)        0 (0%)      0 (0%)           0 (0%)
    ```
    {: screen}

1. Confirm that no ALB pods are deployed to non-edge nodes.

    ```sh
    kubectl describe nodes -l dedicated!=edge | grep alb
    ```
    {: pre}

    If the ALB pods are correctly deployed to edge nodes, no ALB pods are returned. This means your ALBs are successfully rescheduled onto only edge worker nodes.




You labeled worker nodes in a worker pool with `dedicated=edge` and redeployed all the existing ALBs to the edge nodes. All subsequent ALBs that are added to the cluster are also deployed to an edge node in your edge worker pool. Next, you can prevent other [workloads from running on edge worker nodes](/docs/containers?topic=containers-edge-workload-prevent).

