---

copyright:
  years: 2022, 2026
lastupdated: "2026-10-02"


keywords: containers, ingress, troubleshoot ingress, errahsnf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Ingress error: ERRAHSNF
{: #ts-ingress-errahsnf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
One or more ALB health service is not found on the cluster (ERRAHSNF).
```
{: screen}

{{site.data.keyword.containerlong_notm}} deploys managed health check services to every cluster. If one or more service is missing from your cluster, this might result in invalid health check results.
{: tsCauses}

Trigger a reconcile on the health ingresses.
{: tsResolve}

1. Run the following command either for all ALBs or target at least one enabled ALB.
    ```sh
    ibmcloud ks ingress alb update --cluster CLUSTER [--alb ALB ...] [--output OUTPUT] [-q] [--version VERSION]
    ```
    {: pre}

1. Wait 10-15 minutes, then retry the **`ibmcloud ks ingress status-report get`** command to see if the issue is resolved.

1. If the issue persists, contact support. Open a [support case](/docs/support?topic=support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.
