---

copyright:
  years: 2022, 2024
lastupdated: "2024-08-28"


keywords: containers, ingress status, troubleshoot ingress, erradruh

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRADRUH` error?
{: #ts-ingress-erradruh}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
One or more ALB pod is not in running state (ERRADRUH).
```
{: screen}

One or more ALBs have replicas that are not running.
{: tsCauses}

Complete the following steps to verify your cluster setup.
{: tsResolve}

1. List your ALB pods.
    ```sh
    kubectl get pods -n kube-system | grep -E "public-cr|private-cr"
    ```
    {: pre}

    Example output
    ```sh
    public-crcn0hav5w07nccmt0iufg-alb1-7df65f554f-nkgzl   1/1     Running   0          30h
public-crcn0hav5w07nccmt0iufg-alb1-7df65f554f-qk97w   0/1     Pending   0          30h
    ```
    {: screen}
    
1. Describe the ALB pods that are not running and review the `Events` section.
    ```sh
    kubectl describe pod POD -n kube-system
    ```
    {: pre}


1. If you notice scheduler problems, follow the steps:
    1. List your ALBs using the **`ibmcloud ks ingress alb ls`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_albs).
    1. List your workers using the **`ibmcloud ks worker ls`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_workers).
    1. **Classic clusters**: Ensure you have at least two worker nodes in the VLANs where your ALBs are deployed. See [Adding worker nodes and zones to clusters](/docs/containers?topic=containers-add-workers-classic).
    1. **VPC clusters**: Ensure you have at least two worker nodes in the zones where your ALBs are deployed. See [Adding worker nodes and zones to clusters](/docs/containers?topic=containers-add-workers-vpc).
    1. Ensure that your workers are healthy. For more information, see [Worker node states](/docs/containers?topic=containers-worker-node-state-reference).
    1. Ensure your nodes are not tainted or cordoned. For more information, see [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) and [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/).
        
1. If you notice pod restarts, follow the steps.
    1. Get the logs for the failing pod.
        ```sh
        kubectl logs --previous -n kube-system <POD NAME>
        ```
        {: pre}
        
    1. Review the logs and adjust the Ingress resource configurations or the Ingress ConfigMap in the `kube-system` namespace. For more information, see the NGINX Ingress [Annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) and [ConfigMap](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/).
        
1. Wait a few minutes and verify if the failing pods are now running.

1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.
