---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-17"

keywords: kubernetes, iks, ibmcloud, ic, ks, kubectl

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Setting up the CLI
{: #cs_cli_install}

You can use the {{site.data.keyword.containerlong}} CLI to create and manage your Kubernetes clusters. To use the API, see [Setting up the API](/docs/containers?topic=containers-cs_api_install).
{:shortdesc}

## Installing the IBM Cloud CLI and plug-ins
{: #cs_cli_install_steps}

Install the required CLIs to create and manage your Kubernetes clusters in {{site.data.keyword.containerlong_notm}}, and to deploy containerized apps to your cluster.
{:shortdesc}

This task includes the information for installing these CLIs and plug-ins:

-   {{site.data.keyword.cloud_notm}} CLI
-   {{site.data.keyword.containerlong_notm}} plug-in
-   {{site.data.keyword.registryshort_notm}} plug-in

If you want to use the {{site.data.keyword.cloud_notm}} console instead, after your cluster is created, you can run CLI commands directly from your web browser in the [Kubernetes Terminal](#cli_web).
{: tip}

<br>
To install the CLIs:

1.  Install the [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cloud-cli-getting-started#idt-prereq){: external}. This installation includes:
    -   The base {{site.data.keyword.cloud_notm}} CLI (`ibmcloud`).
    -   The {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`).
    -   {{site.data.keyword.registryshort_notm}} plug-in (`ibmcloud cr`). Use this plug-in to set up your own namespace in a multi-tenant, highly available, and scalable private image registry that is hosted by IBM, and to store and share Docker images with other users. Docker images are required to deploy containers into a cluster.
    -   The Kubernetes CLI (`kubectl`) that matches the default version: 1.15.10.<p class="note">If you plan to use a cluster that runs a different version, you might need to [install that version of the Kubernetes CLI separately](#kubectl). If you have an (OpenShift) cluster, you [install the `oc` and `kubectl` CLIs together](/docs/openshift?topic=openshift-openshift-cli).</p>
    -   The Helm CLI (`helm`). You might use Helm as a package manager to install {{site.data.keyword.cloud_notm}} services and complex apps to your cluster via Helm charts. You must still [set up Helm](/docs/containers?topic=containers-helm) in each cluster where you want to use Helm.

    Plan to use the CLI often? Try [Enabling shell autocompletion for {{site.data.keyword.cloud_notm}} CLI (Linux/MacOS only)](/docs/cli/reference/ibmcloud?topic=cloud-cli-shell-autocomplete#shell-autocomplete-linux).
    {: tip}

2.  Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.
    ```
    ibmcloud login
    ```
    {: pre}

    If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
    {: tip}

4.  Verify that the {{site.data.keyword.containerlong_notm}} plug-in and {{site.data.keyword.registryshort_notm}} plug-ins are installed correctly.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    Example output:
    ```
    Listing installed plug-ins...

    Plugin Name                            Version   Status        
    container-registry                     0.1.404     
    container-service/kubernetes-service   0.4.66
    ```
    {: screen}

For reference information about these CLIs, see the documentation for those tools.

-   [`ibmcloud` commands](/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_cli)
-   [`ibmcloud ks` commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)
-   [`ibmcloud cr` commands](/docs/Registry?topic=container-registry-cli-plugin-containerregcli)

## Installing the Kubernetes CLI (`kubectl`)
{: #kubectl}

To view a local version of the Kubernetes dashboard and to deploy apps into your clusters, install the Kubernetes CLI (`kubectl`). The latest stable version of `kubectl` is installed with the base {{site.data.keyword.cloud_notm}} CLI. However, to work with your cluster, you must instead install the Kubernetes CLI `major.minor` version that matches the Kubernetes cluster `major.minor` version that you plan to use. If you use a `kubectl` CLI version that does not match at least the `major.minor` version of your clusters, you might experience unexpected results. For example, [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2). Make sure to keep your Kubernetes cluster and CLI versions up-to-date.
{: shortdesc}

Using an OpenShift cluster? [Install the OpenShift CLI (`oc`)](/docs/openshift?topic=openshift-openshift-cli). If you have both Red Hat OpenShift on IBM Cloud and Ubuntu {{site.data.keyword.containershort_notm}} clusters, make sure to use the `kubectl` binary file that matches your cluster `major.minor` Kubernetes version. You might want to set up multiple directories on your local machine to organize different `kubectl` versions and then create aliases in your terminal for these directories.
{: tip}

1.  If you already have a cluster, check that the version of your client `kubectl` CLI matches the version of the cluster API server.
    1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2.  Compare the client and server versions. If the client does not match the server, continue to the next step. If the versions match, you already installed the appropriate version of `kubectl`.
        ```
        kubectl version --short
        ```
        {: pre}
2.  Download the Kubernetes CLI `major.minor` version that matches the Kubernetes cluster `major.minor` version that you plan to use. The current {{site.data.keyword.containerlong_notm}} default Kubernetes version is 1.15.10. 
    -   **OS X**: [https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/darwin/amd64/kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/darwin/amd64/kubectl){: external}
    -   **Linux**: [https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/linux/amd64/kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/linux/amd64/kubectl){: external}
    -   **Windows**: Install the Kubernetes CLI in the same directory as the {{site.data.keyword.cloud_notm}} CLI. This setup saves you some file path changes when you run commands later. [https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/windows/amd64/kubectl.exe](https://storage.googleapis.com/kubernetes-release/release/v1.15.10/bin/windows/amd64/kubectl.exe){: external}

3.  If you use OS X or Linux, complete the following steps.
    1.  Move the executable file to the `/usr/local/bin` directory.
        ```
        mv /<filepath>/kubectl /usr/local/bin/kubectl
        ```
        {: pre}

    2.  Make sure that `/usr/local/bin` is listed in your `PATH` system variable. The `PATH` variable contains all directories where your operating system can find executable files. The directories that are listed in the `PATH` variable serve different purposes. `/usr/local/bin` is used to store executable files for software that is not part of the operating system and that was manually installed by the system administrator.
        ```
        echo $PATH
        ```
        {: pre}
        Example CLI output:
        ```
        /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
        ```
        {: screen}

    3.  Make the file executable.
        ```
        chmod +x /usr/local/bin/kubectl
        ```
        {: pre}
4.  If you have clusters that run different versions of Kubernetes, such as 1.17.3 and 1.16.7, download each `kubectl` version binary file to a separate directory. Then, you can set up an alias in your local terminal profile to point to the `kubectl` binary file directory that matches the `kubectl` version of the cluster that you want to work with, or [run the CLI from a container](#cs_cli_container).
5.  **Optional**: [Enable autocompletion for `kubectl` commands](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion){: external}. The steps vary depending on the shell that you use.

Next, start [Creating Kubernetes clusters from the CLI with {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-clusters#clusters_cli_steps).

For more information about the Kubernetes CLI, see the [`kubectl` reference docs](https://kubectl.docs.kubernetes.io/){: external}.
{: note}

<br />


## Running the CLI in a container on your computer
{: #cs_cli_container}

Instead of installing each of the CLIs individually on your computer, you can install the CLIs into a container that runs on your computer.
{:shortdesc}

Before you begin, [install Docker for Mac](https://docs.docker.com/docker-for-mac/install/){: external} or [Windows](https://docs.docker.com/docker-for-windows/install/){: external} to build and run images locally. If you are using Windows 8 or earlier, you can install the [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/){: external} instead.

1. Create an image from the provided Dockerfile.

    ```
    docker build -t <image_name> https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/install-clis-container/Dockerfile
    ```
    {: pre}

2. Deploy the image locally as a container and mount a volume to access local files.

    ```
    docker run -it -v /local/path:/container/volume <image_name>
    ```
    {: pre}

3. Begin running `ibmcloud ks` and `kubectl` commands from the interactive shell. If you create data that you want to save, save that data to the volume that you mounted. When you exit the shell, the container stops.

<br />



## Configuring the CLI to run `kubectl`
{: #cs_cli_configure}

You can use the commands that are provided with the Kubernetes CLI to manage clusters in {{site.data.keyword.cloud_notm}}.
{:shortdesc}

All `kubectl` commands that are available in Kubernetes 1.15.10 are supported for use with clusters in {{site.data.keyword.cloud_notm}}. After you create a cluster, set the context for your local CLI to that cluster with an environment variable. Then, you can run the Kubernetes `kubectl` commands to work with your cluster in {{site.data.keyword.cloud_notm}}.

Before you can run `kubectl` commands:
* [Install the required CLIs](#cs_cli_install).
* [Create a cluster](/docs/containers?topic=containers-clusters#clusters_cli_steps).
* Make sure that you have a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources. If you have only a service role but no platform role, you need the cluster admin to give you the cluster name and ID, or the **Viewer** platform role to list clusters.

Depending on which [version of the {{site.data.keyword.containerlong_notm}} plug-in you use](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_beta), you must follow different steps to use `kubectl` commands.
* Version 0.4 (default) or earlier: Ensure that your {{site.data.keyword.containerlong_notm}} plug-in uses the latest `0.4` version by running `ibmcloud plugin update kubernetes-service`. Then, see [Configuring the CLI to run `kubectl` for kubernetes-service version 0.4 or earlier](#cs_cli_configure_0.4).
* Version 1.0 (beta): To use `1.0`, set the `IKS_BETA_VERSION` environment variable by running `export IKS_BETA_VERSION=1.0`. Then, see [Configuring the CLI to run `kubectl` for kubernetes-service version 1.0](#cs_cli_configure_1.0).

### Configuring the CLI to run `kubectl` for kubernetes-service version 0.4 or earlier
{: #cs_cli_configure_0.4}

In CLI plug-in version 0.4 and earlier, `cluster config` provides a command that you must copy and paste to set the new `kubeconfig` file as your current `KUBECONFIG` environment variable. You must set your environment variable before you can interact with your cluster.
{: shortdesc}

1.  Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.
    ```
    ibmcloud login
    ```
    {: pre}

    If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
    {: tip}

2.  Select an {{site.data.keyword.cloud_notm}} account. If you are assigned to multiple {{site.data.keyword.cloud_notm}} organizations, select the organization where the cluster was created. Clusters are specific to an organization, but are independent from an {{site.data.keyword.cloud_notm}} space. Therefore, you are not required to select a space.

3.  To create and work with clusters in a resource group other than the default, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have [**Viewer** access](/docs/containers?topic=containers-users#platform) to the resource group.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

4.  List all of the clusters in the account to get the name of the cluster. If you have only an {{site.data.keyword.cloud_notm}} IAM service role and cannot view clusters, ask your cluster admin for the IAM platform **Viewer** role, or the cluster name and ID.
    ```
    ibmcloud ks cluster ls
    ```
    {: pre}

5.  Set the cluster as the context for this session. Complete these configuration steps every time that you work with your cluster.
    1.  Get the command to set the environment variable and download the Kubernetes configuration files. <p class="tip">Using Windows PowerShell? Include the `--powershell` flag to get environment variables in Windows PowerShell format.</p>
        ```
        ibmcloud ks cluster config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        After downloading the configuration files, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

        Example:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.

        **Mac or Linux users**: Instead of running the `ibmcloud ks cluster config` command and copying the `KUBECONFIG` environment variable, you can run `ibmcloud ks cluster config --export <cluster-name>`. Depending on your shell, you can set up your shell by running `eval $(ibmcloud ks cluster config --export <cluster-name>)`.
        {: tip}

    3.  Verify that the `KUBECONFIG` environment variable is set properly.

        Example:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output:
        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

6.  Verify that the `kubectl` commands run properly with your cluster by checking the Kubernetes CLI server version.
    ```
    kubectl version  --short
    ```
    {: pre}

    Example output:
    ```
    Client Version: v1.15.10
    Server Version: v1.15.10
    ```
    {: screen}

Now, you can run `kubectl` commands to manage your clusters in {{site.data.keyword.cloud_notm}}. For a full list of commands, see the [Kubernetes documentation](https://kubectl.docs.kubernetes.io/){: external}.

If you are using Windows and the Kubernetes CLI is not installed in the same directory as the {{site.data.keyword.cloud_notm}} CLI, you must change directories to the path where the Kubernetes CLI is installed to run `kubectl` commands successfully.
{: tip}

### Configuring the CLI to run `kubectl` for kubernetes-service version 1.0
{: #cs_cli_configure_1.0}

In CLI plug-in version 1.0, `cluster config` appends the new `kubeconfig` file to your existing `kubeconfig` file in `~/.kube/config` or the first file that is set by the `KUBECONFIG` environment variable. After you run `ibmcloud ks cluster config`, you can interact with your cluster immediately. Note that any pre-existing `kubeconfig` files are not merged automatically.
{: shortdesc}

1.  Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.
    ```
    ibmcloud login
    ```
    {: pre}

    If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
    {: tip}

2.  Select an {{site.data.keyword.cloud_notm}} account. If you are assigned to multiple {{site.data.keyword.cloud_notm}} organizations, select the organization where the cluster was created. Clusters are specific to an organization, but are independent from an {{site.data.keyword.cloud_notm}} space. Therefore, you are not required to select a space.

3.  To create and work with clusters in a resource group other than the default, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have [**Viewer** access](/docs/containers?topic=containers-users#platform) to the resource group.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

4.  List all of the clusters in the account to get the name of the cluster. If you have only an {{site.data.keyword.cloud_notm}} IAM service role and cannot view clusters, ask your cluster admin for the IAM platform **Viewer** role, or the cluster name and ID.
    ```
    ibmcloud ks cluster ls
    ```
    {: pre}

5.  Set the cluster as the context for this session. This command appends the new `kubeconfig` configuration file to your existing `kubeconfig` in `~/.kube/config` or the first file in the `KUBECONFIG` environment variable. Complete this configuration step every time that you work with your cluster.
    ```
    ibmcloud ks cluster config --cluster <cluster_name_or_ID>
    ```
    {: pre}

6.  Verify that the `KUBECONFIG` environment variable is set properly.

    Example:
    ```
    echo $KUBECONFIG
    ```
    {: pre}

    Output:
    ```
    /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
    ```
    {: screen}

7.  Verify that the `kubectl` commands run properly with your cluster by checking the Kubernetes CLI server version.
    ```
    kubectl version  --short
    ```
    {: pre}

    Example output:
    ```
    Client Version: v1.15.10
    Server Version: v1.15.10
    ```
    {: screen}

Now, you can run `kubectl` commands to manage your clusters in {{site.data.keyword.cloud_notm}}. For a full list of commands, see the [Kubernetes documentation](https://kubectl.docs.kubernetes.io/){: external}.

If you are using Windows and the Kubernetes CLI is not installed in the same directory as the {{site.data.keyword.cloud_notm}} CLI, you must change directories to the path where the Kubernetes CLI is installed to run `kubectl` commands successfully.
{: tip}

<br />


## Updating the CLI
{: #cs_cli_upgrade}

You might want to update the CLIs periodically to use new features.
{:shortdesc}

This task includes the information for updating these CLIs.

-   {{site.data.keyword.cloud_notm}} CLI version 0.8.0 or later
-   {{site.data.keyword.containerlong_notm}} plug-in
-   Kubernetes CLI version 1.15.10 or later
-   {{site.data.keyword.registryshort_notm}} plug-in

<br>
To update the CLIs:

1.  Update the {{site.data.keyword.cloud_notm}} CLI. Download the [latest version](/docs/cli?topic=cloud-cli-getting-started){: external} and run the installer.

2. Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.

    ```
    ibmcloud login
    ```
    {: pre}

     If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
     {: tip}

3.  Update the {{site.data.keyword.containerlong_notm}} plug-in.
    1.  Install the update from the {{site.data.keyword.cloud_notm}} plug-in repository.

        ```
        ibmcloud plugin update kubernetes-service 
        ```
        {: pre}

    2.  Verify the plug-in installation by running the following command and checking the list of the plug-ins that are installed.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        The {{site.data.keyword.containerlong_notm}} plug-in is displayed in the results as kubernetes-service.

    3.  Initialize the CLI.

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [Update the Kubernetes CLI](#kubectl).

5.  Update the {{site.data.keyword.registryshort_notm}} plug-in.
    1.  Install the update from the {{site.data.keyword.cloud_notm}} plug-in repository.

        ```
        ibmcloud plugin update container-registry 
        ```
        {: pre}

    2.  Verify the plug-in installation by running the following command and checking the list of the plug-ins that are installed.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        The registry plug-in is displayed in the results as container-registry.

<br />


## Uninstalling the CLI
{: #cs_cli_uninstall}

If you no longer need the CLI, you can uninstall it.
{:shortdesc}

This task includes the information for removing these CLIs:


-   {{site.data.keyword.containerlong_notm}} plug-in
-   Kubernetes CLI
-   {{site.data.keyword.registryshort_notm}} plug-in

To uninstall the CLIs:

1.  Uninstall the {{site.data.keyword.containerlong_notm}} plug-in.

    ```
    ibmcloud plugin uninstall kubernetes-service
    ```
    {: pre}

2.  Uninstall the {{site.data.keyword.registryshort_notm}} plug-in.

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

4.  Verify the plug-ins were uninstalled by running the following command and checking the list of the plug-ins that are installed.

    ```
    ibmcloud plugin list
    ```
    {: pre}

    The kubernetes-service and the container-registry plug-in are not displayed in the results.

<br />


## Using the Kubernetes web terminal in your web browser
{: #cli_web}

The Kubernetes web terminal allows you to use the {{site.data.keyword.cloud_notm}} CLI to manage your cluster directly from your web browser.
{: shortdesc}

You can use the Kubernetes web terminal for quick access and testing of your cluster. Do not use it for production workloads.
{: important}

If you use the cluster dashboard in the {{site.data.keyword.cloud_notm}} console to manage your clusters but want to quickly make more advanced configuration changes, you can now run CLI commands directly from your web browser in the Kubernetes web terminal. The Kubernetes Terminal is enabled with the base [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cloud-cli-getting-started){: external}, the {{site.data.keyword.containerlong_notm}} plug-in, and the {{site.data.keyword.registryshort_notm}} plug-in. Additionally, the terminal context is already set to the cluster that you are working with so that you can run Kubernetes `kubectl` commands to work with your cluster.

Any files that you download and edit locally, such as YAML files, are stored temporarily in Kubernetes Terminal and do not persist across sessions.
{: note}

To install and launch the Kubernetes web terminal:

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the web terminal.
2.  From the upper right of the cluster detail page, click the **Web terminal** button.
3.  Click **Install**. It might take a few minutes for the terminal add-on to install.
4.  Click the **Web terminal** button again. The terminal opens in your browser.
5.  VPC clusters: Configure access to external endpoints, such as the {{site.data.keyword.containerlong_notm}} API, from the web terminal. Choose between the following options:
    * Enable a [public gateway](/docs/vpc-on-classic-network?topic=vpc-on-classic-network-about-networking-for-vpc#use-a-public-gateway) on each VPC subnet that your worker nodes are attached to. This ensures that the `kube-terminal` pod in your cluster is always deployed to a worker node on a subnet that has external access.
    * Edit the `KUBECONFIG` file to use the private service endpoint for your cluster.
      1. In the web terminal, edit the `KUBECONFIG` file.
        ```
        vim $KUBECONFIG
        ```
        {: pre}
      2. Type `i` to switch to insert mode so that you can edit the file.
      3. In the service endpoint URL for the `server` field, add `private.` before the region. For example, if the service endpoint URL is `https://c1.us-south.containers.cloud.ibm.com:20267`, change it to `https://c1.private.us-south.containers.cloud.ibm.com:20267`.
      4. Type `Esc` (escape key) to exit insert mode.
      5. Type `:wq` to save and exit your file.

Next time, you can launch the Kubernetes Terminal simply by clicking the **Web terminal** button.
