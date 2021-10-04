---

copyright:
  years: 2021, 2021
lastupdated: "2021-10-04"

keywords: kubectl, exec, timeout

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why doesn't the `kubectl exec` command automatically timeout?
{: ts-kubectl-exec-timeout}

When you use kubectl version 1.21 to run `kubectl exec <pod_name>`, the command does not automatically timeout. 
{: tsSymptoms}

There is a known issue in `kubectl` version 1.21 that prevents `kubectl exec <pod_name>` from timing out.
{: tsCauses}

[Install `kubectl` version 1.20 or earlier](/docs/containers?topic=containers-cs_cli_install#kubectl). For clusters that run on Kubernetes versions 1.21 or 1.22, use `kubectl` version 1.20. For clusters that run on earlier Kubernetes versions, use the `kubectl` version that matches the `major.minor` Kubernetes version of your cluster. 
{: tsResolve}
