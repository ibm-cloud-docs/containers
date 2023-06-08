---

copyright:
  years: 2014, 2023
lastupdated: "2023-06-08"

keywords: kubernetes

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why do my pods fail to deploy after applying a pod security policy?
{: #ts-app-psp}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


After creating a pod or running `kubectl get events` to check on a pod deployment, you see an error message similar to the following.
{: tsSymptoms}

```sh
unable to validate against any pod security policy
```
{: screen}


[The `PodSecurityPolicy` admission controller](/docs/containers?topic=containers-psp) checks the authorization of the user or service account that tried to create the pod.
{: tsCauses}

If no pod security policy supports the user or service account, then the `PodSecurityPolicy` admission controller prevents the pods from being created.

If you deleted one of the pod security policy resources for [{{site.data.keyword.IBM_notm}} cluster management](/docs/containers?topic=containers-psp#ibm_psp), you might experience similar issues.


Make sure that the user or service account is authorized by a pod security policy. You might need to [modify an existing policy](/docs/containers?topic=containers-psp#customize_psp).
{: tsResolve}

If you deleted an {{site.data.keyword.IBM_notm}} cluster management resource, refresh the Kubernetes master to restore it.

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
2. Refresh the Kubernetes master to restore it.

    ```sh
    ibmcloud ks cluster master refresh
    ```
    {: pre}







