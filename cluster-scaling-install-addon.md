---

copyright: 
  years: 2014, 2025
lastupdated: "2025-07-30"


keywords: kubernetes, node scaling, ca, autoscaler

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}




# Enabling the cluster autoscaler add-on in your cluster
{: #cluster-scaling-install-addon}

You can enable the add-on from the console or the command the line.


Because the cluster autoscaler doesn't recognize GPU labels, it can't scale up or down based on GPU consumption.
{: important}

## Enabling the cluster autoscaler add-on from the console
{: #autoscaler-enable-console}
{: ui}
    
1. From the [{{site.data.keyword.containerlong_notm}} cluster dashboard](https://cloud.ibm.com/containers/cluster-management/clusters), select the cluster where you want to enable autoscaling.
1. In the **Add-ons** section, locate the Cluster Autoscaler add-on and click **Install**

## Enabling the cluster autoscaler add-on from the CLI
{: #autoscaler-enable-CLI}
{: cli}
    
1. Enable the `cluster-autoscaler` add-on by running the following command.
    ```sh
    ibmcloud ks cluster addon enable cluster-autoscaler --cluster <cluster_name>
    ```
    {: pre}

    Example output
    
    ```sh
    Enabling add-on `cluster-autoscaler` for cluster <cluster_name>...
    The add-on might take several minutes to deploy and become ready for use.
    OK
    ```
    {: screen}

1. Verify that the add-on is installed and `Ready`.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name>
    ```
    {: pre}

    Example output

    ```sh
    NAME                 Version   Health State   Health Status   
    cluster-autoscaler   1.0.1     normal         Addon Ready
    ```
    {: screen}

1. No worker pools are configured for scaling after enabling the add-on. To set up autoscaling on your worker pools, [edit the cluster autoscaler configmap](/docs/containers?topic=containers-cluster-scaling-install-addon-enable).





## Updating the cluster autoscaler add-on
{: #cluster-scaling-install-addon-update-addon}

The cluster autoscaler has two types of updates.

Patch updates
:   Patch updates are delivered automatically by IBM and don't contain any feature updates or changes in the supported add-on and cluster versions.

Release updates
:   Release updates contain new features for the cluster autoscaler or changes in the supported add-on or cluster versions. You must manually apply release updates to your cluster autoscaler add-on.

To update the cluster autoscaler add-on:

1. Check the version of the cluster autoscaler add-on that is deployed in your cluster. If an update is available, review the [release notes](/docs/containers?topic=containers-ca_changelog) for the latest add-on version.
    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name>
    ```
    {: pre}

    If you upgrade your cluster to a version that isn't supported by the cluster autoscaler add-on, your apps might experience downtime and your cluster might not scale.
    {: important}

2. Update the cluster autoscaler add-on.

    ```sh
    ibmcloud ks cluster addon update cluster-autoscaler --version <version-to-update> --cluster <cluster_name>
    ```
    {: pre}

3. Verify the add-on is successfully updated and `Ready`.

    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name>
    ```
    {: pre}
    
    
## Removing the cluster autoscaler add-on from the console
{: #autoscaler-remove-console}
{: ui}

1. [Edit the autoscaler ConfigMap](/docs/containers?topic=containers-cluster-scaling-install-addon-enable) to stop scaling your working pools.

1. From the [{{site.data.keyword.containerlong_notm}} cluster dashboard](https://cloud.ibm.com/containers/cluster-management/clusters), select the cluster where you want to enable autoscaling.

1. Locate the Cluster Autoscaler add-on and click **Uninstall**


## Removing the cluster autoscaler add-on from the CLI
{: #autoscaler-remove-cli}
{: cli}

1. [Edit the autoscaler ConfigMap](/docs/containers?topic=containers-cluster-scaling-install-addon-enable) to stop scaling your working pools.
    
1. Disable the `cluster-autoscaler` add-on.

    ```sh
    ibmcloud ks cluster addon disable cluster-autoscaler --cluster <cluster_name>
    ```
    {: pre}

1. Verify that the add-on was removed.

    ```sh
    ibmcloud ks cluster addon ls --cluster <cluster_name>
    ```
    {: pre}
    
