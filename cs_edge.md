---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-30"

keywords: kubernetes, iks

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



# Restricting network traffic to edge worker nodes
{: #edge}

Edge worker nodes can improve the security of your Kubernetes cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload in {{site.data.keyword.containerlong}}.
{:shortdesc}

When these worker nodes are marked for networking only, other workloads cannot consume the CPU or memory of the worker node and interfere with networking.

If you have a multizone cluster and want to restrict network traffic to edge worker nodes, at least 2 edge worker nodes must be enabled in each zone for high availability of load balancer or Ingress pods. Create an edge node worker pool that spans all the zones in your cluster, with at least 2 worker nodes per zone.
{: tip}

## Labeling worker nodes as edge nodes
{: #edge_nodes}

Add the `dedicated=edge` label to two or more worker nodes on each public VLAN in your cluster to ensure that Ingress and load balancers are deployed to those worker nodes only.
{:shortdesc}

Before you begin:

1. Ensure you have the following [{{site.data.keyword.Bluemix_notm}} IAM roles](/docs/containers?topic=containers-users#platform):
  * Any platform role for the cluster
  * **Writer** or **Manager** service role for all namespaces
2. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
3. Ensure that your cluster has a least one public VLAN. Edge worker nodes are not available for clusters with private VLANs only.
4. [Create a new worker pool](/docs/containers?topic=containers-clusters#add_pool) that spans all the zone in your cluster and has at least 2 workers per zone.

To label worker nodes as edge nodes:

1. List the worker nodes in your edge node worker pool. Use the **Private IP** address to identify the nodes.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. Label the worker nodes with `dedicated=edge`. After a worker node is marked with `dedicated=edge`, all subsequent Ingress and load balancers are deployed to an edge worker node.

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. Retrieve all of the existing load balancers and Ingress application load balancers (ALBs) in the cluster.

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  In the output, look for services that have the **Type** of **LoadBalancer**. Note the **Namespace** and **Name** of each load balancer service. For example, in the following output, there are 3 load balancer services: the load balancer `webserver-lb` in the `default` namespace, and the Ingress ALBs, `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` and `public-crdf253b6025d64944ab99ed63bb4567b6-alb2`, in the `kube-system` namespace.

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. Using the output from the previous step, run the following command for each load balancer and Ingress ALB. This command redeploys the load balancer or Ingress ALB to an edge worker node. Only public load balancers or ALBs must be redeployed.

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  Example output:

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

You labeled worker nodes with `dedicated=edge` and redeployed all of the existing load balancers and Ingress to the edge worker nodes. Next, prevent other [workloads from running on edge worker nodes](#edge_workloads) and [block inbound traffic to NodePorts on worker nodes](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Preventing workloads from running on edge worker nodes
{: #edge_workloads}

A benefit of edge worker nodes is that they can be specified to run networking services only.
{:shortdesc}

Using the `dedicated=edge` toleration means that all load balancer and Ingress services are deployed to the labeled worker nodes only. However, to prevent other workloads from running on edge worker nodes and consuming worker node resources, you must use [Kubernetes taints ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

Before you begin:
- Ensure you have the [**Manager** {{site.data.keyword.Bluemix_notm}} IAM service role for all namespaces](/docs/containers?topic=containers-users#platform).
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To prevent other workloads from running on edge worker nodes:

1. List all of the worker nodes with the `dedicated=edge` label.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Apply a taint to each worker node that prevents pods from running on the worker node and that removes pods that do not have the `dedicated=edge` label from the worker node. The pods that are removed are redeployed on other worker nodes with capacity.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
  Now, only pods with the `dedicated=edge` toleration are deployed to your edge worker nodes.

3. If you choose to [enable source IP preservation for a load balancer 1.0 service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), ensure that app pods are scheduled onto the edge worker nodes by [adding edge node affinity to app pods](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes). App pods must be scheduled onto edge nodes to receive incoming requests.

4. To remove a taint, run the following command.
    ```
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}
