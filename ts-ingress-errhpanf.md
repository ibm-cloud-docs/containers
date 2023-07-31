---

copyright: 
  years: 2023, 2023
lastupdated: "2023-07-31"

connectivitykeywords: kubernetes, errhpanf, ingress, autoscaler, alb

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why does the Ingress status show an `ERRHPANF` error?
{: #ts-ingress-errhpanf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The autoscaler resource is missing (ERRHPANF).
```
{: screen}

The horizontal pod autoscaler (HPA) resource is missing for the ALB, and the deployment does not scale dynamically with the load. The HPA resource might be configured incorrectly, which prevents the resource from applying to the cluster.
{: tsCauses}


Check the HPA resource configuration for errors. Then, apply the resource again. 
{: tsResolve}

For more information on ALB autoscaling, see [Dynamically scaling ALBs with autoscaler](/docs/containers?topic=containers-ingress-alb-manage#alb_replicas_autoscaler).
{: note}

1. Get the autoscale configuration.
    ```sh
    ibmcloud ks ingress alb autoscale get -c <clusterID> --alb <albID>
    ```
    {: pre}

1. Fix any errors in the configuration. If you specified custom metrics, ensure they are in valid YAML format and that the YAML snippet contains a list of [MetricSpec (autoscaling.k8s.io/v2)](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#metricspec-v2-autoscaling){: external}.

1. Run the command to update the ALB and apply the corrected configuration.
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


