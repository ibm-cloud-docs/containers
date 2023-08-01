---

copyright: 
  years: 2023, 2023
lastupdated: "2023-08-01"

connectivitykeywords: kubernetes, errhpana, ingress, autoscaler, alb

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why does the Ingress status show an `ERRHPANA` error?
{: #ts-ingress-errhpana}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
Autoscaling is failing (ERRHPANA).
```
{: screen}

There are issues with the horizontal pod autoscaler (HPA) resource that are preventing autoscaling from functioning. 
{: tsCauses}

View the HPA resource status for additional information on the error. Check the resource for issues or formatting errors that may prevent the autoscaler from functioning.
{: tsResolve}

For more information on ALB autoscaling, see [Dynamically scaling ALBs with autoscaler](/docs/containers?topic=containers-ingress-alb-manage#alb_replicas_autoscaler).
{: note}

1. Get the details of the HPA resource.
    ```sh
    kubectl describe horizontalpodautoscaler -n kube-system <albID>
    ```
    {: pre}

1. In the command output, find the `Conditions` section and check the `ScalingActive` status. If the status field shows `False`, check the `Reason` and `Message` field for more information that might resolve the issue.


1. Check the configuration metrics. Correct any issues or formatting errors. If you specified custom metrics, ensure they are in valid YAML format and that the YAML snippet contains a list of [MetricSpec (autoscaling.k8s.io/v2)](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#metricspec-v2-autoscaling){: external}.
    ```sh
    ibmcloud ks ingress alb autoscale get -c <clusterID> --alb <albID>
    ```
    {: pre}

    Run the command to apply any changes and update the autoscaler configuration.
    ```sh
    ibmcloud ks ingress alb autoscale set 
    ```
    {: pre}

1. Wait 10 to 15 minutes for the changes to apply. Then check if the warning is resolved. 
    ```sh
    ibmcloud ks ingress status-report get
    ```
    {: pre}

1. If the issue persists, contact support. Include a detailed list of the troubleshooting steps you took. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.





