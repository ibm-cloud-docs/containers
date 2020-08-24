---

copyright:
  years: 2014, 2020
lastupdated: "2020-08-24"

keywords: kubernetes, iks, ibmcloud, ic, ks, kubectl

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: #java .ph data-hd-programlang='java'}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: #swift .ph data-hd-programlang='swift'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vb.net: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Setting up the CLI
{: #cs_cli_install}

You can use the {{site.data.keyword.containerlong}} CLI to create and manage your Kubernetes clusters. To use the API, see [Setting up the API](/docs/containers?topic=containers-cs_api_install).
{: shortdesc}

## Installing the IBM Cloud CLI and plug-ins
{: #cs_cli_install_steps}

Install the required CLIs to create and manage your Kubernetes clusters in {{site.data.keyword.containerlong_notm}}, and to deploy containerized apps to your cluster.
{: shortdesc}

This task includes the information for installing these CLIs and plug-ins:

* {{site.data.keyword.cloud_notm}} CLI (`ibmcloud`)
* {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`)
* {{site.data.keyword.registrylong_notm}} plug-in (`ibmcloud cr`)

If you want to use the {{site.data.keyword.cloud_notm}} console instead, you can run CLI commands directly from your web browser in the [{{site.data.keyword.cloud-shell_notm}}](#cloud-shell) or, after your cluster is created, the [Kubernetes Web Terminal](#cli_web).
{: tip}

<br>
To install the CLIs:

1.  Install the [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cli-getting-started#idt-prereq){: external}. This installation includes:
    -   The base {{site.data.keyword.cloud_notm}} CLI (`ibmcloud`).
    -   The {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`).
    -   {{site.data.keyword.registrylong_notm}} plug-in (`ibmcloud cr`). Use this plug-in to set up your own namespace in a multi-tenant, highly available, and scalable private image registry that is hosted by IBM, and to store and share Docker images with other users. Docker images are required to deploy containers into a cluster.
    -   The Kubernetes CLI (`kubectl`) that matches the default version: 1.17.11.<p class="note">If you plan to use a cluster that runs a different version, you might need to [install that version of the Kubernetes CLI separately](#kubectl).</p>
    -   The Helm CLI (`helm`). You might use Helm as a package manager to install {{site.data.keyword.cloud_notm}} services and complex apps to your cluster via Helm charts. You must still [set up Helm](/docs/containers?topic=containers-helm) in each cluster where you want to use Helm.

    Plan to use the CLI often? Try [Enabling shell autocompletion for {{site.data.keyword.cloud_notm}} CLI (Linux/MacOS only)](/docs/cli/reference/ibmcloud?topic=cli-shell-autocomplete#shell-autocomplete-linux).
    {: tip}

2.  Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.
    ```
    ibmcloud login
    ```
    {: pre}

    If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
    {: tip}

3.  To create a logging configuration for {{site.data.keyword.la_full_notm}} or a monitoring configuration for {{site.data.keyword.mon_full_notm}} for your cluster, install the {{site.data.keyword.containerlong_notm}} observability plug-in (`ibmcloud ob`).
    ```
    ibmcloud plugin install observe-service
    ```
    {: pre}

4.  Verify that the {{site.data.keyword.containerlong_notm}} plug-in and {{site.data.keyword.registrylong_notm}} plug-in are installed correctly.
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

-   [`ibmcloud` commands](/docs/cli/reference/ibmcloud?topic=cli-ibmcloud_cli#ibmcloud_cli)
-   [`ibmcloud ks` commands](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)
-   [`ibmcloud cr` commands](/docs/Registry?topic=container-registry-cli-plugin-containerregcli)

<br />




## Installing the Kubernetes CLI (`kubectl`)
{: #kubectl}

To view a local version of the Kubernetes dashboard and to deploy apps into your clusters, install the Kubernetes CLI (`kubectl`). The latest stable version of `kubectl` is installed with the base {{site.data.keyword.cloud_notm}} CLI. However, to work with your cluster, you must instead install the Kubernetes CLI `major.minor` version that matches the Kubernetes cluster `major.minor` version that you plan to use. If you use a `kubectl` CLI version that does not match at least the `major.minor` version of your clusters, you might experience unexpected results. For example, [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2). Make sure to keep your Kubernetes cluster and CLI versions up-to-date.
{: shortdesc}

Using both {{site.data.keyword.openshiftlong_notm}} and Ubuntu {{site.data.keyword.containershort_notm}} clusters? Make sure to use the `kubectl` binary file that matches your cluster `major.minor` Kubernetes version. You might want to set up multiple directories on your local machine to organize different `kubectl` versions and then create aliases in your terminal for these directories.
{: tip}

1.  If you already have a cluster, check that the version of your client `kubectl` CLI matches the version of the cluster API server.
    1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2.  Compare the client and server versions. If the client does not match the server, continue to the next step. If the versions match, you already installed the appropriate version of `kubectl`.
        ```
        kubectl version --short
        ```
        {: pre}
2.  Download the Kubernetes CLI `major.minor` version that matches the Kubernetes cluster `major.minor` version that you plan to use. The current {{site.data.keyword.containerlong_notm}} default Kubernetes version is 1.17.11.
    -   **OS X**: [https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/darwin/amd64/kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/darwin/amd64/kubectl){: external}
    -   **Linux**: [https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/linux/amd64/kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/linux/amd64/kubectl){: external}
    -   **Windows**: Install the Kubernetes CLI in the same directory as the {{site.data.keyword.cloud_notm}} CLI. This setup saves you some file path changes when you run commands later. [https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/windows/amd64/kubectl.exe](https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/windows/amd64/kubectl.exe){: external}

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
4.  If you have clusters that run different versions of Kubernetes, such as 1.18.8 and 1.16.14, download each `kubectl` version binary file to a separate directory. Then, you can set up an alias in your local terminal profile to point to the `kubectl` binary file directory that matches the `kubectl` version of the cluster that you want to work with, or [run the CLI from a container](#cs_cli_container).
5.  **Optional**: [Enable autocompletion for `kubectl` commands](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion){: external}. The steps vary depending on the shell that you use.

Next, start [Creating Kubernetes clusters from the CLI with {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-clusters#clusters_cli_steps).

For more information about the Kubernetes CLI, see the [`kubectl` reference docs](https://kubectl.docs.kubernetes.io/){: external}.
{: note}

<br />


## Running the CLI in a container on your computer
{: #cs_cli_container}

Instead of installing each of the CLIs individually on your computer, you can install the CLIs into a container that runs on your computer.
{: shortdesc}

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
{: shortdesc}

All `kubectl` commands that are available in Kubernetes 1.17.11 are supported for use with clusters in {{site.data.keyword.cloud_notm}}. After you create a cluster, set the context for your local CLI to that cluster with an environment variable. Then, you can run the Kubernetes `kubectl` commands to work with your cluster in {{site.data.keyword.cloud_notm}}.

Before you can run `kubectl` commands:
* [Install the required CLIs](#cs_cli_install).
* [Create a cluster](/docs/containers?topic=containers-clusters#clusters_cli_steps).
* Make sure that you have a [service role](/docs/containers?topic=containers-users#platform) that grants the appropriate Kubernetes RBAC role so that you can work with Kubernetes resources. If you have only a service role but no platform role, you need the cluster admin to give you the cluster name and ID, or the **Viewer** platform role to list clusters.

To run `kubectl` commands to manage your cluster:

1. Depending on which [version of the {{site.data.keyword.containerlong_notm}} plug-in you use](/docs/containers?topic=containers-cs_cli_changelog#changelog_beta), you must follow different steps to use `kubectl` commands.
  * **Version 1.0 (default)**: Ensure that your {{site.data.keyword.containerlong_notm}} plug-in uses the latest `0.4` version by running `ibmcloud plugin update kubernetes-service`. In CLI plug-in version 1.0, `cluster config` appends the new `kubeconfig` file to your existing `kubeconfig` file in `~/.kube/config` or the [last file that is set by the `KUBECONFIG` environment variable](#cli_temp_kubeconfig). After you run `ibmcloud ks cluster config`, you can interact with your cluster immediately, and quickly [change the context to other clusters in the Kubernetes context](/docs/containers?topic=containers-cs_cli_install#cli_config_multiple). Note that any pre-existing `kubeconfig` files are not merged automatically.
  * **Version 0.4 (deprecated) or earlier**: In CLI plug-in version 0.4 or earlier, `cluster config` provides a command that you must copy and paste to set the new `kubeconfig` file as your current `KUBECONFIG` environment variable. You must set your environment variable before you can interact with your cluster.

2.  Log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your {{site.data.keyword.cloud_notm}} credentials when prompted.
    ```
    ibmcloud login
    ```
    {: pre}

    If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.cloud_notm}} CLI. Enter your username and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
    {: tip}

3.  Select an {{site.data.keyword.cloud_notm}} account. If you are assigned to multiple {{site.data.keyword.cloud_notm}} organizations, select the organization where the cluster was created. Clusters are specific to an organization, but are independent from an {{site.data.keyword.cloud_notm}} space. Therefore, you are not required to select a space.

4.  To create and work with clusters in a resource group other than the default, target that resource group. To see the resource group that each cluster belongs to, run `ibmcloud ks cluster ls`. **Note**: You must have [**Viewer** access](/docs/containers?topic=containers-users#platform) to the resource group.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

5.  List all of the clusters in the account to get the name of the cluster. If you have only an {{site.data.keyword.cloud_notm}} IAM service role and cannot view clusters, ask your cluster admin for the IAM platform **Viewer** role, or the cluster name and ID.
    ```
    ibmcloud ks cluster ls
    ```
    {: pre}

6.  Set the cluster as the context for this session. Complete these configuration steps every time that you work with your cluster. The following command sets the context by downloading and adding the `kubeconfig` file for your cluster to your existing `kubeconfig` file in `~/.kube/config` (`<user_profile>/.kube/config` in Windows) or the last file in the `KUBECONFIG` environment variable.
    ```
    ibmcloud ks cluster config --cluster <cluster_name_or_ID>
    ```
    {: pre}

7.  Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
    ```
    kubectl config current-context
    ```
    {: pre}

    Example output:
    ```
    <cluster_name>/<cluster_ID>
    ```
    {: screen}

Now, you can run `kubectl` commands to manage your cluster in {{site.data.keyword.cloud_notm}}. For a full list of commands, see the [Kubernetes documentation](https://kubectl.docs.kubernetes.io/){: external}. If you have more than one cluster, you can [switch the CLI context across multiple clusters](#cli_config_multiple).

If you are using Windows and the Kubernetes CLI is not installed in the same directory as the {{site.data.keyword.cloud_notm}} CLI, you must change directories to the path where the Kubernetes CLI is installed to run `kubectl` commands successfully.
{: tip}

<br />


## Setting the Kubernetes context for multiple clusters
{: #cli_config_multiple}

You can use the {{site.data.keyword.containerlong_notm}} plug-in CLI to add the `kubeconfig` file for multiple clusters to the Kubernetes context of your terminal. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){: external}.
{: shortdesc}

Before you begin:
*   [Update the {{site.data.keyword.containerlong_notm}} plug-in](#cs_cli_upgrade) to at least version 1.0.
    ```
    ibmcloud plugin update kubernetes-service
    ```
    {: pre}
* To make sure that you have an {{site.data.keyword.cloud_notm}} account and other prerequisite settings, see [Configuring the CLI to run `kubectl`](#cs_cli_configure)

To set the Kubernetes context for multiple clusters:
1.  Get the **Name** or **ID** of the clusters that you want to set the Kubernetes context for.
    ```
    ibmcloud ks cluster ls
    ```
    {: pre}
2.  Add the `kubeconfig` file for the cluster to the Kubernetes context for your terminal. The Kubernetes context is set by the `~/.kube/config` file (`<user_profile>/.kube/config` in Windows), or the [last file that is set by the `KUBECONFIG` environment variable](#cli_temp_kubeconfig), on your local machine.
    ```
    ibmcloud ks cluster config -c <cluster_name_or_ID>
    ```
    {: pre}
3.  Repeat step 2 for each cluster that you want to set the Kubernetes context for.
4.  Check which cluster your terminal is currently set to use.
    ```
    kubectl config current-context
    ```
    {: pre}

    Example output:
    ```
    <cluster_name>/<cluster_ID>
    ```
    {: pre}
5.  List the available Kubernetes contexts and note the **Name** of a cluster context that you want to use.
    ```
    kubectl config get-contexts
    ```
    {: pre}
6.  Set the Kubernetes context to another cluster. You can switch the Kubernetes configuration context for each terminal that uses the `kubeconfig` file, or specify the context on each `kubectl` command.

    *   **Switch the Kubernetes context**: Use the context of a different cluster. Replace `<context>` with the context that you previously retrieved.

        ```
        kubectl config use-context <context>
        ```
        {: pre}

    *   **Specify the Kubernetes context per command**: For clusters that run the same version of Kubernetes as other clusters, you can switch between contexts by specifying the context in each `kubectl` command. Replace `<context>` with the context that you previously retrieved.
        ```
        kubectl --context=<context> <command>
        ```
        {: pre}

        Example:
        ```
        kubectl --context=mycluster/abc123 get pods
        ```
        {: pre}

        Plan to switch contexts by command often? Create an alias for each cluster in your terminal for the context. For example: `alias kprod='kubectl --context=mycluster/abc123'`. Then you can use the alias to switch clusters.
        {: tip}

<br />


## Creating a temporary `kubeconfig` file
{: #cli_temp_kubeconfig}

Instead of merging the `kubeconfig` file of [multiple clusters](#cli_config_multiple) into the Kubernetes context, you might want a separate `kubeconfig` file per cluster. For example, you might have automation that relies on {{site.data.keyword.containerlong_notm}} plug-in CLI version 0.4 or earlier behavior and need time to adapt your scripts to the new CLI version 1.0.
{: shortdesc}

1.  Get the **Name** and **ID** of the cluster that you want to download a separate `kubeconfig` file for.
    ```
    ibmcloud ks clusters
    ```
    {: pre}
2.  Set your `KUBECONFIG` environment variable in your terminal to a temporary directory.
    ```
    export KUBECONFIG=$(mktemp).yaml
    ```
    {: pre}
3.  Download the `kubeconfig` file to the temporary directory that you just created.
    ```
    ibmcloud ks cluster config -c <cluster_name_or_ID>
    ```
    {: pre}
4.  Optional: Get the `kubeconfig` file that you just downloaded.
    *   To list the path of the `kubeconfig` file:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Example output:
        ```
        /tmp/tmp.zhK6bD5Lpw
        ```
        {: screen}
    *   To print the `kubeconfig` file in your terminal:
        ```
        cat $KUBECONFIG
        ```
        {: pre}
5.  Verify that the Kubernetes context is set for your cluster, such as by listing pods.
    ```
    kubectl get pods
    ```
    {: pre}
6.  Repeat these steps when you want to use a different cluster or open a new terminal session.

<br />




## Updating the CLI
{: #cs_cli_upgrade}

Update the CLIs regularly to use new features.
{: shortdesc}

This task includes the information for updating the following CLIs:
-   {{site.data.keyword.cloud_notm}} CLI version 0.8.0 or later
-   {{site.data.keyword.containerlong_notm}} plug-in
-   Kubernetes CLI version 1.17.11 or later
-   {{site.data.keyword.registrylong_notm}} plug-in


[Version 1.0 of the CLI plug-in was released on 16 March 2020](/docs/containers?topic=containers-cs_cli_changelog#changelog_beta). This version contains permanent syntax and behavior changes that are not backwards compatible.</br></br>To maintain all CLI functionality, update and test any automation before you update to 1.0 by checking out the [`ibmcloud ks script update` command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#script_update) and setting your `IKS_BETA_VERSION` environment variable to `1.0`. After you update your scripts, update your CLI to version `1.0` of the plug-in.
{: important}


<br>
To update the CLIs:

1.  Update the {{site.data.keyword.cloud_notm}} CLI. Download the [latest version](/docs/cli?topic=cli-getting-started){: external} and run the installer.

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

        The {{site.data.keyword.containerlong_notm}} plug-in is displayed in the results as `kubernetes-service`.

    3.  Initialize the CLI.

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [Update the Kubernetes CLI](#kubectl).

5.  Update the {{site.data.keyword.registrylong_notm}} plug-in.
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

        The registry plug-in is displayed in the results as `container-registry`.

<br />


## Uninstalling the CLI
{: #cs_cli_uninstall}

If you no longer need the CLI, you can uninstall it.
{: shortdesc}

This task includes the information for removing these CLIs:


-   {{site.data.keyword.containerlong_notm}} plug-in
-   {{site.data.keyword.registrylong_notm}} plug-in

To uninstall the CLIs:

1.  Uninstall the {{site.data.keyword.containerlong_notm}} plug-in.

    ```
    ibmcloud plugin uninstall kubernetes-service
    ```
    {: pre}

2.  Uninstall the {{site.data.keyword.registrylong_notm}} plug-in.

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

4.  Verify the plug-ins were uninstalled by running the following command and checking the list of the plug-ins that are installed.

    ```
    ibmcloud plugin list
    ```
    {: pre}

    The `kubernetes-service` and the `container-registry` plug-in are not displayed in the results.

5.  [Uninstall the {{site.data.keyword.cloud_notm}} CLI.](/docs/cli?topic=cli-uninstall-ibmcloud-cli)

6.  Uninstall the Kubernetes CLI.
    ```
    sudo rm /usr/local/bin/kubectl
    ```
    {: pre}

<br />


## Using the {{site.data.keyword.cloud-shell_notm}} in your web browser (beta)
{: #cloud-shell}

[{{site.data.keyword.cloud-shell_full}}](https://cloud.ibm.com/shell){: external} allows you to use the {{site.data.keyword.cloud_notm}} CLI and various CLI plug-ins to manage your cluster directly from your web browser.
{: shortdesc}

<img src="images/icon-beta-flair.png" alt="Beta icon" width="30" style="width:30px; border-style: none"/> The {{site.data.keyword.cloud-shell_notm}} is a beta feature that is subject to change. Do not use it for production workloads.
{: preview}

The {{site.data.keyword.cloud-shell_notm}} is enabled with several [plug-ins and tools](/docs/cloud-shell?topic=cloud-shell-plugins-tools), including the base {{site.data.keyword.cloud_notm}} CLI (`ibmcloud`), the {{site.data.keyword.containerlong_notm}} plug-in (`ibmcloud ks`), the {{site.data.keyword.registrylong_notm}} plug-in (`ibmcloud cr`), and the Kubernetes CLI (`kubectl`).

While you use the {{site.data.keyword.cloud-shell_short}}, keep in mind the following limitations:
* You can open up to five concurrent sessions, which operate independently so you can work with different resources, regions, and accounts at once.
* Any files that you download and edit locally, such as YAML files, are stored temporarily in the {{site.data.keyword.cloud-shell_short}} and do not persist across sessions.
* {{site.data.keyword.cloud-shell_short}} has a usage quota that limits you to 4 hours of continuous use or up to 30 hours within a week.

To launch and use the {{site.data.keyword.cloud-shell_notm}}:

1. In the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){:external} menu bar, click the {{site.data.keyword.cloud-shell_short}} icon ![{{site.data.keyword.cloud-shell_notm}} icon](../icons/terminal-cloud-shell.svg).
2. A session starts and automatically logs you in to the {{site.data.keyword.cloud_notm}} CLI with your current account credentials.
3. Target your session context to the cluster that you want to work with so that you can manage the cluster with `kubectl` commands.
  1.  Download and add the `kubeconfig` configuration file for your cluster to your existing `kubeconfig` in `~/.kube/config` or the last file in the `KUBECONFIG` environment variable.
      ```
      ibmcloud ks cluster config --cluster <cluster_name_or_ID>
      ```
      {: pre}
  2.    Verify that `kubectl` commands run properly and that the Kubernetes context is set to your cluster.
        ```
        kubectl config current-context
        ```
        {: pre}

        Example output:
        ```
        <cluster_name>/<cluster_ID>
        ```
        {: screen}


## Using the Kubernetes web terminal in your web browser
{: #cli_web}

After you create your cluster, the Kubernetes web terminal allows you to use the {{site.data.keyword.cloud_notm}} CLI to manage your cluster directly from your web browser.
{: shortdesc}

You can use the Kubernetes web terminal for quick access and testing of your cluster. Do not use it for production workloads.
{: important}

If you use the cluster dashboard in the {{site.data.keyword.cloud_notm}} console to manage your clusters but want to quickly make more advanced configuration changes, you can now run CLI commands directly from your web browser in the Kubernetes web terminal. The Kubernetes Terminal is enabled with the base [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cli-getting-started){: external}, the {{site.data.keyword.containerlong_notm}} plug-in, and the {{site.data.keyword.registrylong_notm}} plug-in. Additionally, the terminal context is already set to the cluster that you are working with so that you can run Kubernetes `kubectl` commands to work with your cluster.

Any files that you download and edit locally, such as YAML files, are stored temporarily in Kubernetes Terminal and do not persist across sessions.
{: note}

To install and launch the Kubernetes web terminal:

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the web terminal.
2. In the **Actions...** drop-down list at the top of the cluster detail screen, select **Web terminal**.
3. Click **Install**. It might take a few minutes for the terminal add-on to install. <p class="tip">To resolve some common issues that you might encounter during the add-on deployment, see [Reviewing add-on state and statuses](/docs/containers?topic=containers-cs_troubleshoot_addons#debug_addons).</p>
4. In the **Actions...** drop-down list, select **Web terminal** again. The terminal opens in your browser.
5. VPC clusters: Configure access to external endpoints, such as the {{site.data.keyword.containerlong_notm}} API, from the web terminal. Choose between the following options:
    * Enable a [public gateway](/docs/vpc?topic=vpc-about-networking-for-vpc#public-gateway-for-external-connectivity) on each VPC subnet that your worker nodes are attached to. This ensures that the `kube-terminal` pod in your cluster is always deployed to a worker node on a subnet that has external access.
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
