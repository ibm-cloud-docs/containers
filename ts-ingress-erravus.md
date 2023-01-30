---

copyright:
  years: 2022, 2023
lastupdated: "2023-01-30"

keywords: containers, ingress, troubleshoot ingress, ingress operator, ingress cluster operator, unsupported version, erravus

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}



# Why does the Ingress status show an `ERRAVUS` error?
{: #ts-ingress-erravus}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}

You can use the the `ibmcloud ks ingress status-report ignored-errors add` command to add an error to the ignored-errors list. Ignored errors still appear in the output of the `ibmcloud ks ingress status-report get` command, but are ignored when calculating the overall Ingress Status.
{: tip}

When you check the status of your cluster's Ingress components by running the `ibmcloud ks ingress status-report get` command, you see an error similar to the following example.
{: tsSymptoms}

```sh
The ALB version is no longer supported (ERRAVUS).
```
{: screen}

One or more of your ALBs is running an version that is no longer supported.
{: tsCauses}

For any ALBs that use an unsupported version, update your ALBs.
{: tsResolve}


1. List the supported ALB versions by using the **`ibmcloud ks ingress alb versions`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_versions). Make a note of the supported versions.

1. List your ALBs by using the **`ibmcloud ks ingress alb ls`** [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_albs) and check the version in the `Build` column.

1. Update any ALBs that use an unsupported version. For more information, see [Updating ALBs](/docs/containers?topic=containers-ingress-alb-manage#alb-update).

1. Wait 10 to 15 minutes, then check if the warning is resolved by running the **`ibmcloud ks ingress alb ls`** command.

1. If the issue persists, contact support. Open a [support case](/docs/get-support?topic=get-support-using-avatar). In the case details, be sure to include any relevant log files, error messages, or command outputs.



