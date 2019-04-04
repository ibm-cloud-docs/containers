---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-04"

keywords: kubernetes, iks, helm, without tiller, private cluster tiller, integrations, helm chart

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}


# Adding services by using Helm charts
{: #helm}

[Helm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://helm.sh) is a Kubernetes package manager that uses Helm charts to define, install, and upgrade complex Kubernetes apps in your cluster.
{:shortdesc}

To deploy Helm charts, you must install the Helm CLI on your local machine and install the Helm server Tiller in your cluster. The image for Tiller is stored in the public Google Container Registry. To access the image during Tiller installation, your cluster must allow public network connectivity to the public Google Container Registry. Clusters that have the public service endpoint enabled can automatically access the image. Private clusters that are protected with a custom firewall, or clusters that have enabled the private service endpoint only, do not allow access to the Tiller image. Instead, you can [pull the image to your local machine, and push the image to your namespace in {{site.data.keyword.registryshort_notm}}](#private_local_tiller), or [install Helm charts without using Tiller](#private_install_without_tiller).
{: note}

## Setting up Helm in a cluster with public access
{: #public_helm_install}

If your cluster has enabled the public service endpoint, you can install the Helm server Tiller by using the public image in the Google Container Registry.
{: shortdesc}

Before you begin:
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
- To install Tiller with a Kubernetes service account and cluster role binding in the `kube-system` namespace, make sure that you have the [`cluster-admin` role](/docs/containers?topic=containers-users#access_policies).

To install Helm in a cluster with public access: 

1. Install the <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="External link icon"></a> on your local machine.

2. **Important**: To maintain cluster security, create a service account for Tiller in the `kube-system` namespace and a Kubernetes RBAC cluster role binding for the `tiller-deploy` pod by applying the following YAML file from the [{{site.data.keyword.Bluemix_notm}} `kube-samples` repository](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml). 
    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml
    ```
    {: pre}

3. Initialize the Helm CLI and install Tiller in your cluster with the service account that you created.
   ```
   helm init --service-account tiller
   ```
   {: pre}

4.  Verify that the installation is successful.
    1.  Verify that the Tiller service account is created.
        ```
        kubectl get serviceaccount -n kube-system | grep tiller
        ```
        {: pre}

        Example output:
        ```
        NAME                                 SECRETS   AGE
        tiller                               1         2m
        ```
        {: screen}

    2.  Verify that the `tiller-deploy` pod has a **Status** of `Running` in your cluster.
        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Example output:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
        ```
        {: screen}

5. Add the {{site.data.keyword.Bluemix_notm}} Helm repositories to your Helm instance.
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}

   ```
   helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
   ```
   {: pre}

6. Update the repos to retrieve the latest versions of all Helm charts.
   ```
   helm repo update
   ```
   {: pre}

7. List the Helm charts that are currently available in the {{site.data.keyword.Bluemix_notm}} repositories.
   ```
   helm search ibm
   ```
   {: pre}

   ```
   helm search ibm-charts
   ```
   {: pre}

8. Identify the Helm chart that you want to install and follow the instructions in the Helm chart `README` to install the Helm chart in your cluster.


## Private clusters: Pushing the Tiller image to your namespace in IBM Cloud Container Registry
{: #private_local_tiller}

You can pull the Tiller image to your local machine, push the image to your namespace in {{site.data.keyword.registryshort_notm}} and install Tiller in your private cluster by using the image in {{site.data.keyword.registryshort_notm}}.
{: shortdesc}

If you wish to install a Helm chart without using Tiller, see [Private clusters: Installing Helm charts without using Tiller](#private_install_without_tiller). 
{: tip}

Before you begin:
- Install Docker on your local machine. If you installed the [{{site.data.keyword.Bluemix_notm}} CLI](/docs/cli?topic=cloud-cli-ibmcloud-cli#ibmcloud-cli), Docker is already installed.
- [Install the {{site.data.keyword.registryshort_notm}} CLI plug-in and set up a namespace](/docs/services/Registry?topic=registry-getting-started#gs_registry_cli_install).
- To install Tiller with a Kubernetes service account and cluster role binding in the `kube-system` namespace, make sure that you have the [`cluster-admin` role](/docs/containers?topic=containers-users#access_policies).

To install Tiller by using {{site.data.keyword.registryshort_notm}}:

1. Install the <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="External link icon"></a> on your local machine.
2. Connect to your private cluster by using the {{site.data.keyword.Bluemix_notm}} infrastructure VPN tunnel that you set up.
3. **Important**: To maintain cluster security, create a service account for Tiller in the `kube-system` namespace and a Kubernetes RBAC cluster role binding for the `tiller-deploy` pod by applying the following YAML file from the [{{site.data.keyword.Bluemix_notm}} `kube-samples` repository](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml). 
    1. [Get the Kubernetes service account and cluster role binding YAML file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml).

    2. Create the Kubernetes resources in your cluster.
       ```
       kubectl apply -f service-account.yaml
       ```
       {: pre}

       ```
       kubectl apply -f cluster-role-binding.yaml
       ```
       {: pre}

4. [Find the version of Tiller ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.cloud.google.com/gcr/images/kubernetes-helm/GLOBAL/tiller?gcrImageListsize=30) that you want to install in your cluster. If you do not need a specific version, use the latest one.

5. Pull the Tiller image from the public Google Container Registry to your local machine.
   ```
   docker pull gcr.io/kubernetes-helm/tiller:v2.11.0
   ```
   {: pre}

   Example output:
   ```
   docker pull gcr.io/kubernetes-helm/tiller:v2.13.0
   v2.13.0: Pulling from kubernetes-helm/tiller
   48ecbb6b270e: Pull complete
   d3fa0712c71b: Pull complete
   bf13a43b92e9: Pull complete
   b3f98be98675: Pull complete
   Digest: sha256:c4bf03bb67b3ae07e38e834f29dc7fd43f472f67cad3c078279ff1bbbb463aa6
   Status: Downloaded newer image for gcr.io/kubernetes-helm/tiller:v2.13.0
   ```
   {: screen}

6. [Push the Tiller image to your namespace in {{site.data.keyword.registryshort_notm}}](/docs/services/Registry?topic=registry-getting-started#gs_registry_images_pushing).

7. To access the image in {{site.data.keyword.registryshort_notm}} from inside your cluster, [copy the image pull secret from the default namespace to the `kube-system` namespace](/docs/containers?topic=containers-images#copy_imagePullSecret).

8. Install Tiller in your private cluster by using the image that you stored in your namespace in {{site.data.keyword.registryshort_notm}}.
   ```
   helm init --tiller-image <region>.icr.io/<mynamespace>/<myimage>:<tag> --service-account tiller
   ```
   {: pre}

9. Add the {{site.data.keyword.Bluemix_notm}} Helm repositories to your Helm instance.
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}

   ```
   helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
   ```
   {: pre}

10. Update the repos to retrieve the latest versions of all Helm charts.
    ```
    helm repo update
    ```
    {: pre}

11. List the Helm charts that are currently available in the {{site.data.keyword.Bluemix_notm}} repositories.
    ```
    helm search ibm
    ```
    {: pre}

    ```
    helm search ibm-charts
    ```
    {: pre}

12. Identify the Helm chart that you want to install and follow the instructions in the Helm chart `README` to install the Helm chart in your cluster.


## Private clusters: Installing Helm charts without using Tiller
{: #private_install_without_tiller}

If you don't want to install Tiller in your private cluster, you can manually create the Helm chart YAML files and apply them by using `kubectl` commands.
{: shortdesc}

The steps in this example show how to install Helm charts from the {{site.data.keyword.Bluemix_notm}} Helm chart repositories in your private cluster. If you want to install a Helm chart that is not stored in one of the {{site.data.keyword.Bluemix_notm}} Helm chart repositories, you must follow the instructions in this topic to create the YAML files for your Helm chart. In addition, you must download the Helm chart image from the public container registry, push it to your namespace in {{site.data.keyword.registryshort_notm}}, and update the `values.yaml` file to use the image in {{site.data.keyword.registryshort_notm}}.
{: note}

1. Install the <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="External link icon"></a> on your local machine.
2. Connect to your private cluster by using the {{site.data.keyword.Bluemix_notm}} infrastructure VPN tunnel that you set up.
3. Add the {{site.data.keyword.Bluemix_notm}} Helm repositories to your Helm instance.
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}

   ```
   helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
   ```
   {: pre}

4. Update the repos to retrieve the latest versions of all Helm charts.
   ```
   helm repo update
   ```
   {: pre}

5. List the Helm charts that are currently available in the {{site.data.keyword.Bluemix_notm}} repositories.
   ```
   helm search ibm
   ```
   {: pre}

   ```
   helm search ibm-charts
   ```
   {: pre}

6. Identify the Helm chart that you want to install, download the Helm chart to your local machine, and unpack the files of your Helm chart. The following example shows how to download the Helm chart for the cluster autoscaler version 1.0.3 and unpack the files in a `cluster-autoscaler` directory.
   ```
   helm fetch ibm/ibm-iks-cluster-autoscaler --untar --untardir ./cluster-autoscaler --version 1.0.3
   ```
   {: pre}

7. Navigate to the directory where you unpacked the Helm chart files.
   ```
   cd cluster-autoscaler
   ```
   {: pre}

8. Create an `output` directory for the YAML files that you generate by using the files in your Helm chart.
   ```
   mkdir output
   ```
   {: pre}

9. Open the `values.yaml` file and make any changes that are required by the Helm chart installation instructions.
   ```
   nano ibm-iks-cluster-autoscaler/values.yaml
   ```
   {: pre}

10. Use your local Helm installation to create all Kubernetes YAML files for your Helm chart. The YAML files are stored in the `output` directory that you created earlier.
    ```
    helm template --values ./ibm-iks-cluster-autoscaler/values.yaml --output-dir ./output ./ibm-iks-cluster-autoscaler
    ```
    {: pre}

    Example output:
    ```
    wrote ./output/ibm-iks-cluster-autoscaler/templates/ca-configmap.yaml
    wrote ./output/ibm-iks-cluster-autoscaler/templates/ca-service-account-roles.yaml
    wrote ./output/ibm-iks-cluster-autoscaler/templates/ca-service.yaml
    wrote ./output/ibm-iks-cluster-autoscaler/templates/ca-deployment.yaml
    ```
    {: screen}

11. Deploy all YAML files to your private cluster.
    ```
    kubectl apply --recursive --filename ./output
    ```
   {: pre}

12. Optional: Remove all YAML files from the `output` directory.
    ```
    kubectl delete --recursive --filename ./output
    ```
    {: pre}

## Related Helm links
{: #helm_links}

Review the following links to find additional Helm information. 
{: shortdesc}

* View the available Helm charts that you can use in {{site.data.keyword.containerlong_notm}} in the [Helm Charts Catalog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/kubernetes/solutions/helm-charts).
* Learn more about the Helm commands that you can use to set up and manage Helm charts in the <a href="https://docs.helm.sh/helm/" target="_blank">Helm documentation <img src="../icons/launch-glyph.svg" alt="External link icon"></a>.
* Learn more about how you can [increase deployment velocity with Kubernetes Helm Charts ![External link icon](../icons/launch-glyph.svg "External link icon")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/). 

