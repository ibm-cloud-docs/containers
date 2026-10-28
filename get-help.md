---

copyright: 
  years: 2014, 2026
lastupdated: "2026-10-28"


keywords: containers, {{site.data.keyword.containerlong_notm}}, support, get help

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# Getting help and support for your cluster
{: #get-help}

If you experience an issue or have questions when using your cluster, you can use the following resources before you open a support case.
{: shortdesc}

* Troubleshoot with [{{site.data.keyword.paver_full}}](http://cloud.paver.ibm.com){: external}. {{site.data.keyword.paver}} is an embedded AI operator that understands your account context, creates a resolution plan, and executes changes on your behalf, while always requiring your approval before touching your live environment.
* Gather the details of your cluster environment, as described in the following sections.
* Check the status of the {{site.data.keyword.Bluemix_notm}} platform and resources by going to the [Status page](/status){: external}.
* Review [Stack Overflow](https://stackoverflow.com/questions/tagged/ibm-cloud){: external} to see whether other users experienced the same problem. When you ask a question, tag the question with `ibm-cloud`, so that it's seen by the {{site.data.keyword.Bluemix_notm}} development teams.

If you still can't resolve the problem, you can [open a support case](#support-case). If you're looking to provide feedback, see [Submitting feedback](/docs/overview?topic=overview-feedback).

Before you open a support case, gather relevant information about your cluster environment.
{: tip}

Looking for the Diagnostics and Debug tool? That add-on is no longer supported. [IBM Cloud Monitoring](/docs/containers?topic=containers-monitoring) is recommended for monitoring and diagnosing problems in your cluster. Additional troubleshooting links that might be relevant include [Troubleshooting worker nodes in Critical or NotReady state](/docs/containers?topic=containers-ts-critical-notready) and [Troubleshooting apps in IBM Cloud Kubernetes Service](/docs/containers?topic=containers-debug_clusters).
{: tip}

## Get your cluster details
{: #cluster-details}

1. Get your cluster details.

    ```sh
    ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID
    ```
    {: pre}

2. If your issue involves worker nodes, get the worker node details.

    1. List all worker nodes in the cluster, and note the **ID** of any worker nodes with an unhealthy **State** or **Status**.
    
        ```sh
        ibmcloud ks worker ls -c CLUSTER_NAME_OR_ID
        ```
        {: pre}

    2. Get the details of the unhealthy worker node.
    
        ```sh
        ibmcloud ks worker get -w WORKER_ID -c CLUSTER_NAME_OR_ID
        ```
        {: pre}

3. For issues with resources within your cluster such as pods or services, log in to the cluster and use the Kubernetes API to get more information about them.



## Open a support case
{: #support-case}

1. Contact IBM Support by [opening a case](https://cloud.ibm.com/unifiedsupport/cases/form){: external}.

1. For the **Problem type**, search for or select {{site.data.keyword.containerlong_notm}}.

1. For the **Case details**, provide a descriptive title and include the details that you previously gathered. From the **Resources**, you can also select the cluster that the issue is related to.

1. Be as specific as possible and include and architecture diagrams or supplemental materials that you think you could help IBM Support troubleshoot the issue.
