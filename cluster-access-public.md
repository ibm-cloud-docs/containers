---

copyright:
  years: 2014, 2026
lastupdated: "2026-08-20"

keywords: kubernetes, clusters, access, public, endpoint, console, cli, login

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Accessing clusters through the public cloud service endpoint
{: #cluster-access-public}

For {{site.data.keyword.containerlong_notm}} Classic and VPC clusters that have a public cloud service endpoint enabled, you can log in from the CLI or a graphical dashboard.
{: shortdesc}

## Before you begin
{: #access-public-prereqs}

1. [Install the required CLI tools](/docs/containers?topic=containers-cli-install), including the {{site.data.keyword.cloud_notm}} CLI, {{site.data.keyword.containershort_notm}} plug-in (`ibmcloud ks`), and Kubernetes CLI (`kubectl`). For quick access to test features in your cluster, you can also use the [{{site.data.keyword.cloud-shell_notm}}](/docs/containers?topic=containers-cli-install).
1. If your network is protected by a company firewall, [allow access](/docs/containers?topic=containers-firewall#corporate) to the {{site.data.keyword.cloud_notm}} and {{site.data.keyword.containerlong_notm}} API endpoints and ports.
1. Verify your cluster is healthy: `ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID`.

## Connecting from the CLI
{: #access-public-cli}

1. Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
    ```sh
    ibmcloud ks cluster config -c CLUSTER_NAME_OR_ID
    ```
    {: pre}

1. Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
    ```sh
    kubectl config current-context
    ```
    {: pre}

    Example output
    ```sh
    <cluster_name>/<cluster_ID>
    ```
    {: screen}

## Connecting to the Headlamp dashboard
{: #access-public-dashboard}

[Headlamp](/docs/containers?topic=containers-headlamp-addon) is the recommended graphical dashboard for managing and monitoring your cluster resources. It uses {{site.data.keyword.cloud_notm}} IAM authentication and is automatically exposed through your cluster's default ingress hostname after you install the add-on.

1. [Install the Headlamp add-on](/docs/containers?topic=containers-headlamp-addon#headlamp-install) if you haven't already.
1. Get your cluster's default ingress hostname.
    ```sh
    ibmcloud ks cluster get -c CLUSTER_NAME_OR_ID | grep "Ingress Subdomain"
    ```
    {: pre}

1. Open `https://headlamp.<ingress_subdomain>` in a browser and click **Sign In**.

### Legacy: Connecting with kubectl proxy
{: #access-public-dashboard-legacy}

The upstream `kubernetes-dashboard` project is archived and no longer installed on new clusters as of version 1.36. Use [Headlamp](#access-public-dashboard) instead.
{: deprecated}

If your cluster still has the legacy Kubernetes dashboard installed:

1. Start a local proxy.
    ```sh
    kubectl proxy
    ```
    {: pre}

1. Open the following URL in a web browser.
    ```sh
    http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
    ```
    {: codeblock}

## Connecting with an API key
{: #access-public-cli-apikey}

See [Accessing clusters from automation tools by using an API key](/docs/containers?topic=containers-cluster-access-automation).
