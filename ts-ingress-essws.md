---

copyright: 
  years: 2022, 2022
lastupdated: "2022-11-14"

keywords: kubernetes, help, network, connectivity, essws

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}


# Why does the Ingress status show an ESSWS error?
{: #ts-ingress-essws}
{: troubleshoot}
{: support}

Supported infrastructure providers
:   Classic
:   VPC
:   {{site.data.keyword.satelliteshort}}

When you check the status of your cluster's Ingress components by running the **`ibmcloud ks ingress status`** command, you see an error similar to the following example.
{: tsSymptoms}

```sh
Secret status shows a warning (ESSWS).
```
{: screen}

There was an error when attempting to apply the secret to your cluster.
{: tsCauses}

To view the specific error, run the **`ibmcloud ks ingress secret ls`** commands and review the `Status` column.
{: tsResovle}

`Error api_request_failed`
:   There was an issue uploading the new certificate to the registered instance for the cluster. Verify the instance details using the **`ibmcloud ks ingress instance ls`** command.

`Error secret_apply_failed`
:   There was an issue applying the secret to your cluster. Follow the steps to [ensure your cluster control plane is healthy](/docs/containers?topic=containers-debug_master#review-master-health).

`Error namespace_not_found`
:   The namespace for the secret is no longer found in the cluster. If you no longer need the secret for that namespace, you can remove it with the **`ibmcloud ks ingress secret rm`** command. Otherwise, recreate the namespace on the cluster.

If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.


