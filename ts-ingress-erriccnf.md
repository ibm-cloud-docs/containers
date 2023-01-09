---

copyright:
  years: 2022, 2023
lastupdated: "2023-01-06"

keywords: containers, ingress, troubleshoot ingress, configmap missing, erriccnf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Why is the Ingress controller ConfigMap missing from my cluster?
{: #ts-ingress-erriccnf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The ingress controller configmap is not found on the cluster (ERRICCNF).
```
{: screen}

The Ingress controller ConfigMap is missing from your cluster.
{: tsCauses}

Create the ConfigMap.
{: tsResolve}

1. Run the following command to create the ConfigMap.
    ```sh
    kubectl create -f https://github.com/IBM-Cloud/kube-samples/blob/master/ingress-config/ibm-k8s-controller-config.yaml
    ```
    {: pre}
    
1. Wait 10 to 15 minutes, then check if the warning is resolved by running the `ibmcloud ks ingress status-report get` command.

1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.


