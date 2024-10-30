---

copyright: 
  years: 2023, 2024
lastupdated: "2024-10-30"

connectivitykeywords: kubernetes, errhpaetpi, ingress, autoscaler, alb

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why does the Ingress status show an `ERRHPAETPI` error?
{: #ts-ingress-errhpaetpi}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
Autoscaling is ineffective (ERRHPAETPI).
```
{: screen}

The `ExternalTrafficPolicy` setting for the `LoadBalancer` service of your ALB is set to `Local`. This configuration is incompatible with ALB autoscaling for clusters running on classic infrastructure.
{: tsCauses}

ALB autoscaling is not supported for ALBs with `ExternalTrafficPolicy` set to `Local`.
{: tsResolve}

To resolve the issue, choose one of the following options.

- Change the `ExternalTrafficPolicy` setting.
- Disable ALB autoscaling. 

Before you change the `ExternalTrafficPolicy` setting, review the information about [Enabling source IP preservation](/docs/containers?topic=containers-loadbalancer&interface=ui#lb_source_ip) for details on how this change might impact your cluster setup. If you decide that need to maintain source IP preservation, follow the step to disable ALB autoscaling instead.
{: important}

- To change the `ExternalTrafficPolicy` setting.

    1. Run the command to edit the load balancer service.
        ```sh
        kubectl edit service -n kube-system <albID>
        ```
        {: pre}

    1. Find the `spec.externalTrafficPolicy` line and update the value to `Cluster`.

    1. Save and apply the changes. Wait 10 to 15 minutes for the updates to apply. Then, check to see if the warning is resolved.

    1. If the issue persists, contact support. Include a detailed list of the troubleshooting steps you took. Open a [support case](/docs/account?topic=account-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.

- To disable ALB autoscaling.

    1. Run the command to disable autoscaling for the cluster.
        ```sh
        ibmcloud ks ingress alb autoscale unset -c <clusterID>
        ```
        {: pre}

    1. Wait 10 to 15 minutes for the updates to apply. Then, check to see if the warning is resolved.

    1. If the issue persists, contact support. Include a detailed list of the troubleshooting steps you took. Open a [support case](/docs/account?topic=account-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.
