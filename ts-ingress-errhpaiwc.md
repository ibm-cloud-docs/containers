---

copyright: 
  years: 2023, 2023
lastupdated: "2023-08-14"

connectivitykeywords: kubernetes, errhpaiwc, ingress, autoscaler, alb

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why does the Ingress status show an `ERRHPAIWC` error?
{: #ts-ingress-errhpaiwc}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The cluster does not have enough worker nodes to satisfy the autoscaling configuration (ERRHPAIWC).
```
{: screen}

The cluster does not have enough compatible workers to meet the replica count specified in your ALB autoscaler configuration.
{: tsCauses}

Determine the number of required worker nodes. Then, update your autoscaler configuration replica count or add extra workers to your cluster to accommodate the requirements. 
{: tsResolve}

For more information on ALB autoscaling, see [Dynamically scaling ALBs with autoscaler](/docs/containers?topic=containers-ingress-alb-manage#alb_replicas_autoscaler).
{: note}

1. List your ALBs. In the output, identify the ALB that is relevant to the autoscaler error.  For classic clusters, note the ALB type and VLAN. For VPC clusters, note the ALB zones.
    ```sh
    ibmcloud ks ingress alb ls -c <clusterID>
    ```
    {: pre}

1. List and count the total number of worker nodes that are compatible with ALBs. If your cluster has dedicated edge nodes, then ALBs are scheduled only to those nodes. In this case, include the `--selector dedicated=edge` option in the above commands.

    If your cluster has dedicated edge nodes, then ALBs are scheduled only to those nodes. In this case, include the `--selector dedicated=edge` option in the above commands.
    {: note}

    - **Classic cluster with public ALB**
        ```sh
        kubectl get nodes --selector publicVLAN=<ALB VLAN>
        ```
        {: pre}

    - **Classic cluster with private ALB**
        ```sh
        kubectl get nodes --selector privateVLAN=<ALB VLAN>
        ```
        {: pre}

    - **VPC cluster**
        ```sh
        kubectl get nodes --selector ibm-cloud.kubernetes.io/zone=<ALB zone>
        ```
        {: pre}


1. Update the autoscaler configuration or add extra worker nodes to you cluster to accommodate the number of nodes found in the previous step.
    - **To update the autoscaler configuration**
        1. Get the ALB autoscaler configuration.
            ```sh
            ibmcloud ks ingress alb autoscale get -c <clusterID> --alb <albID>
            ```
            {: pre}

        1. Adjust the maximum replica count. The specified value should be equal to or less than the number of nodes found in the previous step.

        1. Apply the updated autoscaler configuration.
            ```sh
            ibmcloud ks ingress alb autoscale set -c <clusterID> --alb <albID>
            ```
            {: pre}
    
    - **To add extra worker nodes to the cluster**
        1. Follow the steps in [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic) or [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc). Make sure to add workers to the appropriate zone and VLAN identified in previous steps. If you are using edge nodes, label them as `dedicated=edge`.

1. Wait 15 to 20 minutes for the changes to apply. Then check if the warning is resolved. 

1. If the issue persists, contact support. Include a detailed list of the troubleshooting steps you took. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.


