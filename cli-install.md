---

copyright: 
  years: 2014, 2024
lastupdated: "2024-01-03"


keywords: containers,kubernetes, ic, ks, kubectl


subcollection: containers

 


---


{{site.data.keyword.attribute-definition-list}}

# Installing the CLI
{: #cli-install}


You can use the following tools to manage your {{site.data.keyword.containerlong_notm}} clusters. While you can install a subset of the tools, all the following tools are recommended.
{: shortdesc}


[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf} [{{site.data.keyword.satelliteshort}}]{: tag-satellite}


## Understanding the CLI tools
{: #cli-understand}

| CLI | Description |
| --- | --- |
| `ibmcloud` | You can use the `ibmcloud` CLI to login to your account, add users, manage your catalogs and more. |
| `ks` plug-in | After installing the `ibmcloud` CLI, you can use the `ks` plug-in to create and manage {{site.data.keyword.containerlong_notm}} clusters. |
| `kubectl` | You can use the `kubectl` CLI to manage resources within your clusters like pods, deployments, and more. |
{: caption="Table 1: CLI tools" caption-side="bottom"}


{{../cli/index.md#step1-install-idt}}

{{../cli/index.md#step2-verify-idt}}

{{../cli/index.md#step3-install-idt-manually}}

To install the `container-service` or `ks` plugin, run the following command.

```sh
ibmcloud plugin install ks
```
{: pre}


## Install the Kubernetes CLI
{: #install-kubectl-cli}
{: step}

You can use the `kubectl` CLI to deploy and manage resources in your {{site.data.keyword.containerlong_notm}} cluster.



To install the `kubectl` CLI, see [Install tools](https://kubernetes.io/docs/tasks/tools/){: external}.

For a full list of `kubectl` commands, see the [Command line tool (`kubectl`) reference](https://kubernetes.io/docs/reference/kubectl/){: external}.








