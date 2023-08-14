---

copyright:
  years: 2014, 2023
lastupdated: "2023-08-14"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why do ALB pods not deploy to worker nodes?
{: #alb-pod-affinity}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


When you run `kubectl get pods -n kube-system | grep alb`, either no ALB pods or only some ALB pods successfully deployed to your worker nodes.
{: tsSymptoms}

When you describe an ALB pod by running `kubectl describe pod -n kube-system <pod_name>`, you see a message similar to the following in the **Events** section of the output.
```sh
0/3 nodes are available: 1 node(s) didn’t match pod affinity/anti-affinity, 2 node(s) didn’t match node selector.
```
{: screen}


Ingress requires at least two worker nodes per zone to ensure high availability and apply periodic updates.
{: tsCauses}

By default, ALB pods have two replicas. However, ALB pods have anti-affinity rules to ensure that only one pod is scheduled to each worker node for high availability. When only one worker node exists per zone in a classic or VPC cluster, or if only one worker node exists on a VLAN that your classic cluster is attached to, ALB pods can't deploy correctly.
{: tsResolve}

1. Check the number of worker nodes per zone in your cluster.
    ```sh
    ibmcloud ks worker ls -c <cluster_name_or_ID>
    ```
    {: pre}

    * Classic and VPC clusters: If only one worker node exists in a zone, increase the number of worker nodes in that zone.
        * **If you don't use edge nodes**: Ensure that at least two worker nodes exist in each zone by resizing an existing worker pool, [creating a new worker pool in a VPC cluster](/docs/containers?topic=containers-add-workers-vpc#vpc_add_pool), or [creating a new worker pool in a classic cluster](/docs/containers?topic=containers-add-workers-classic#add_pool).
        * **If you use edge nodes**: Ensure that at least two [edge worker nodes](/docs/containers?topic=containers-edge) are enabled in each zone.
    * Classic clusters only: If more than one worker node exists in each zone of your classic cluster, your worker nodes might be connected to different VLANs within one zone so that only one worker node exists on a private VLAN. Continue to the next step.

2. For each worker node in one zone, get the private VLAN that the worker node is attached to.
    ```sh
    ibmcloud ks worker get -w <worker_ID> -c <cluster_name_or_ID>
    ```
    {: pre}

3. If only one worker node exists on a private VLAN, and the other worker nodes in the zone are attached to a different private VLAN, [create a new worker pool](/docs/containers?topic=containers-add-workers-classic) with a size of at least one worker node. When you add a zone to the worker pool in step 6, specify the same zone and private VLAN as the worker node that you previously identified.

4. Repeat these steps for each zone in your cluster to ensure that more than one worker node exists on a private VLAN.

After the new worker nodes deploy, the ALB pods are automatically scheduled to deploy to those worker nodes.






