---

copyright:
  years: 2021, 2024
lastupdated: "2024-01-03"


keywords: kubernetes, kubectl, exec, timeout

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why doesn't the `kubectl exec` command automatically timeout?
{: #ts-kubectl-exec-timeout}
{: support}

When you use kubectl version 1.21 or later to run `kubectl exec <pod_name>`, the command does not automatically timeout. 
{: tsSymptoms}

There is a known issue that prevents the `kubectl exec <pod_name>` command from timing out in `kubectl` versions 1.21 and later.
{: tsCauses}

For clusters that run on Kubernetes version 1.21 or later, run the `kubectl exec` command with `kubectl` version 1.20. To run all other commands, use the `kubectl` version that matches the `major.minor` version of your Kubernetes cluster. 
{: tsResolve}

1. [Download the binary file for `kubectl` version 1.20](/docs/containers?topic=containers-cli-install) and rename it to `kubectl-1.20` or similar.

2. To run `kubectl exec`, refer to the renamed 1.20 version.

```sh
kubectl-1.20 exec <pod_name>
```
{: pre}

## Links to additional information
{: #additional-link-info}

- [`kubectl` 1.21 and containerd fail to follow `stream_idle_timeout`](https://github.com/containerd/containerd/issues/5563){: external}
- [`exec` timeout does not kick users out on `kubectl` client 1.21](https://github.com/kubernetes/kubernetes/issues/102569){: external}

