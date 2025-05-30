---

copyright: 
  years: 2014, 2025
lastupdated: "2025-05-30"


keywords: containers, {{site.data.keyword.containerlong_notm}}, support, get help

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# Contacting support
{: #get-help}

Still having issues with your cluster? Review different ways to get help and support for your {{site.data.keyword.containerlong_notm}} clusters. For any questions or feedback, post in Slack.
{: shortdesc}

Before you open a support case, gather relevant information about your cluster environment.
{: tip}

## Get your cluster details
{: #cluster-details}

1. Get your cluster details.

    ```sh
    ibmcloud ks cluster get -c <cluster_name_or_ID>
    ```
    {: pre}

2. If your issue involves worker nodes, get the worker node details.

    1. List all worker nodes in the cluster, and note the **ID** of any worker nodes with an unhealthy **State** or **Status**.
    
        ```sh
        ibmcloud ks worker ls -c <cluster_name_or_ID>
        ```
        {: pre}

    2. Get the details of the unhealthy worker node.
    
        ```sh
        ibmcloud ks worker get -w <worker_ID> -c <cluster_name_or_ID>
        ```
        {: pre}

3. For issues with resources within your cluster such as pods or services, log in to the cluster and use the Kubernetes API to get more information about them.

    You can also use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-debug-tool) to gather and export pertinent information to share with IBM Support.
    {: tip}



## Open a support case
{: #support-case}

1. Contact IBM Support by [opening a case](https://cloud.ibm.com/unifiedsupport/cases/form){: external}.

1. For the **Problem type**, search for or select {{site.data.keyword.containerlong_notm}}.

1. For the **Case details**, provide a descriptive title and include the details that you previously gathered. From the **Resources**, you can also select the cluster that the issue is related to.

1. Be as specific as possible and include and architecture diagrams or supplemental materials that you think you could help IBM Support troubleshoot the issue.
