---

copyright:
  years: 2022, 2024
lastupdated: "2024-03-04"


keywords: containers, ingress, troubleshoot ingress, loadbalancer missing, errsnf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRSNF` error?
{: #ts-ingress-errsnf}
{: troubleshoot}
{: support}


[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following.
{: tsSymptoms}

```sh
The load balancer service is missing (ERRSNF).
```
{: screen}

ALBs are exposed using LoadBalancer services, but one or more of these services are missing from the cluster.
{: tsCauses}

Disable and re-enable your Ingress ALB.
{: tsResolve}


1. List your ALBs.

    ```sh
    ibmcloud ks ingress alb ls -c <cluster>
    ```
    {: pre}

1. List the services in the `kube-system` namespace.

    ```sh
    kubectl get services -n kube-system
    ```
    {: pre}

1. Review the ALB and services lists to look for missing services.

    Classic
    :   All ALBs that have an enabled state must have an existing LoadBalancer service with a name matching the ALB IDs.

    VPC
    :   If you have at least one public ALB in `enabled` state, there must be an existing public LoadBalancer service having the `public-cr-CLUSTER-ID` prefix in its name. Similarly, if you have at least one private ALB in `enabled` state, there must be an existing private LoadBalancer service having the `private-cr-CLUSTER-ID` prefix in its name.

1. Complete the following steps for each missing service.
    1. Disable the corresponding ALB using the `ibmcloud ks ingress alb disable` command.
    1. Wait until the ALB deployment is removed from the `kube-system` namespace.
    1. Re-enable the ALB using the `ibmcloud ks ingress alb enable` command.
    1. Wait 10 to 15 minutes, then check that the LoadBalancer services are created.
    
1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.


