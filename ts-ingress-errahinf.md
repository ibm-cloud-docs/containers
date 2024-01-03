---

copyright:
  years: 2022, 2024
lastupdated: "2024-01-03"


keywords: containers, ingress status, troubleshoot ingress, errahinf

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRAHINF` error?
{: #ts-ingress-errahinf}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The ALB health Ingress resource is not found on the cluster (ERRAHINF).
```
{: screen}

{{site.data.keyword.containerlong_notm}} deploys a managed Ingress resource to every cluster. If the service is missing from your cluster, this might result in invalid health check results.
{: tsCauses}

Manually create the health service.
{: tsResolve}

1. Run the following command and make a note of your **Ingress subdomain** and **Ingress secret**.
    ```sh
    ibmcloud ks cluster get -c CLUSTER
    ```
    {: pre}

1. Copy the following service configuration and save it to a file called `ingress.yaml`. 

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      annotations:
        kubernetes.io/ingress.class: public-iks-k8s-nginx
        nginx.ingress.kubernetes.io/ssl-redirect: "false"
      name: k8s-alb-health
      namespace: kube-system
    spec:
      rules:
      - host: albhealth.<ingress-subdomain>
        http:
          paths:
          - backend:
              service:
                name: ibm-k8s-controller-health
                port:
                  number: 80
            path: /
            pathType: ImplementationSpecific
      tls:
      - hosts:
        - albhealth.<ingress-subdomain>
        secretName: <ingress-secret>
    ```
    {: codeblock}

1. Add the **Ingress subdomain** and **Ingress secret** that you retrieved in step 1 to the Ingress configuration file.

1. Create the Ingress resource in your cluster.

    ```sh
    kubectl apply -f ingress.yaml
    ```
    {: pre}
    
1. Wait 10-15 minutes, then retry the **`ibmcloud ks ingress status-report get`** command to see if the issue is resolved.

1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.

