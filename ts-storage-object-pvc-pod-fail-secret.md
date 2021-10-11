---

copyright: 
  years: 2014, 2021
lastupdated: "2021-10-08"

keywords: kubernetes, iks, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---
{{site.data.keyword.attribute-definition-list}}



# Why does PVC or pod creation fail due to not finding the Kubernetes secret?
{: #cos_secret_access_fails}

**Infrastructure provider**:
* ![Classic infrastructure provider icon.](images/icon-classic-2.svg) Classic
* ![VPC infrastructure provider icon.](images/icon-vpc-2.svg) VPC




When you create your PVC or deploy a pod that mounts the PVC, the creation or deployment fails.
{: tsSymptoms}

Example error message for a PVC creation failure.

```sh
cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
```
{: screen}

Example error message for a pod creation failure.

```sh
persistentvolumeclaim "pvc-3" not found (repeated 3 times)
```
{: screen}


The Kubernetes secret that you created is not referenced correctly in your deployment yaml or is not set to the `ibm/ibmc-s3fs` type.
{: tsCauses}


This task requires [**Writer** or **Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-users#checking-perms) for all namespaces.
{: tsResolve}

1. List the secrets in your cluster and review the secret type. The secret must show `ibm/ibmc-s3fs` as the **Type**.

    ```sh
    kubectl get secrets --all-namespaces
    ```
    {: pre}

2. If your secret does not show `ibm/ibmc-s3fs` as the **Type**, [re-create your secret](/docs/containers?topic=containers-object_storage#create_cos_secret).

3. Check your YAML configuration file for your PVC and pod to verify that you used the correct secret.




