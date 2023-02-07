---

copyright:
  years: 2022, 2023
lastupdated: "2023-02-06"

keywords: containers, ingress, troubleshoot ingress, errahsnf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRAHSNF` error?
{: #ts-ingress-errahsnf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The ALB health service is not found on the cluster (ERRAHSNF).
```
{: screen}

{{site.data.keyword.containerlong_notm}} deploys a managed health check service to every cluster. If the service is missing from your cluster, this might result in invalid health check results.
{: tsCauses}

Manually create the health service.
{: tsResolve}

1. Copy the following service configuration and save it to a file called `service.yaml`.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: ibm-k8s-controller-health
      namespace: kube-system
    spec:
      ports:
      - name: http
        port: 80
        protocol: TCP
        targetPort: 8283
      selector:
        alb-image-type: community
      type: ClusterIP
    ```
    {: codeblock}
    
1. Create the health check service in your cluster.

    ```sh
    kubectl apply -f service.yaml
    ```
    {: pre}
    
1. Wait 10-15 minutes, then retry the **`ibmcloud ks ingress status-report get`** command to see if the issue is resolved.

1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.

