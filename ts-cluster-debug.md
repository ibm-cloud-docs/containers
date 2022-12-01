---

copyright: 
  years: 2014, 2022
lastupdated: "2022-12-01"

keywords: kubernetes

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Debugging clusters
{: #debug_clusters}
{: troubleshoot}
{: support}

Review the options to debug your clusters and find the root causes for failures.
{: shortdesc}

Supported infrastructure providers
:   Classic
:   VPC

1. List your cluster and find the `State` of the cluster.

    ```sh
    ibmcloud ks cluster ls
    ```
    {: pre}

1. Review the `State` of your cluster. If your cluster is in a **Critical**, **Delete failed**, or **Warning** state, or is stuck in the **Pending** state for a long time. For more information, see [cluster states](/docs/containers?topic=containers-cluster-states-reference). 

1. Review the state of each worker node. For more information, see [worker node states](/docs/containers?topic=containers-worker-node-state-reference).
    ```sh
    ibmcloud ks worker ls -c CLUSTER
    ```
    {: pre}

1. Review the [common worker node issues](/docs/containers?topic=containers-common_worker_nodes_issues). 

1. Start [debugging the worker nodes](/docs/containers?topic=containers-debug_worker_nodes).

1. Review the site map for additional [troubleshooting information](/docs/containers?topic=containers-cs_sitemap#sitemap_troubleshooting).






