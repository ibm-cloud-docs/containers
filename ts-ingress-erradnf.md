---

copyright:
  years: 2022, 2024
lastupdated: "2024-01-03"


keywords: containers, ingress, troubleshoot ingress, deployment missing, erradnf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRADNF` error?
{: #ts-ingress-erradnf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The ALB deployment is not found on the cluster (ERRADNF).
```
{: screen}

One or more ALBs does not have a corresponding deployment on the cluster.
{: tsCauses}

Each ALB that is in enabled state must have a corresponding deployment on the cluster. Disable and re-enable each ALB that does not have a deployment.
{: tsResolve}


1. Ensure that your cluster masters and worker nodes are healthy.
    - [Reviewing master health](/docs/containers?topic=containers-debug_master#review-master-health).
    - [Worker node states](/docs/containers?topic=containers-worker-node-state-reference).
1. List your ALBs with the **`ibmcloud ks ingress alb ls`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_albs). Each ALB that is `enabled` must have a corresponding Deployment on the cluster.
1. List the deployments in the `kube-system` namespace. 
    ```sh
    kubectl get deployments -n kube-system
    ```
    {: pre}

1. Disable ALBs that don't have a deployment by using the **`ibmcloud ks ingress alb disable`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_disable).

1. Wait 10 minutes.

1. Re-enable ALBs by using the **`ibmcloud ks ingress alb enable`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).

1. Wait 15-20 minutes, then check if the deployments are created.
    ```sh
    kubectl get deployments -n kube-system
    ```
    {: pre}
    
1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.



