---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-18"

keywords: kubernetes, iks, registry, pull secret, secrets

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




# Building containers from images
{: #images}


A Docker image is the basis for every container that you create with {{site.data.keyword.containerlong}}.
{:shortdesc}

An image is created from a Dockerfile, which is a file that contains instructions to build the image. A Dockerfile might reference build artifacts in its instructions that are stored separately, such as an app, the app's configuration, and its dependencies.

## Deploying containers from an {{site.data.keyword.registryshort_notm}} image to the `default` Kubernetes namespace
{: #namespace}

You can deploy containers to your cluster from an IBM-provided public image or a private image that is stored in your {{site.data.keyword.registryshort_notm}} namespace. For more information about how your cluster accesses registry images, see [Understanding how your cluster is authorized to pull images from {{site.data.keyword.registrylong_notm}}](/docs/containers?topic=containers-registry#cluster_registry_auth).
{:shortdesc}

Before you begin:
1. [Set up a namespace in {{site.data.keyword.registryshort_notm}} and push images to this namespace](/docs/Registry?topic=registry-getting-started#gs_registry_namespace_add).
2. [Create a cluster](/docs/containers?topic=containers-clusters).
3. If you have an existing cluster that was created before **25 February 2019**, [update your cluster to use the API key `imagePullSecret`](/docs/containers?topic=containers-registry#imagePullSecret_migrate_api_key).
4. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To deploy a container into the **default** namespace of your cluster:

1.  Create a deployment configuration file that is named `mydeployment.yaml`.
2.  Define the deployment and the image to use from your namespace in {{site.data.keyword.registryshort_notm}}.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: <app_name>-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - name: <app_name>
            image: <region>.icr.io/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    Replace the image URL variables with the information for your image:
    *  **`<app_name>`**: The name of your app.
    *  **`<region>`**: The regional {{site.data.keyword.registryshort_notm}} API endpoint for the registry domain. To list the domain for the region that you are logged in to, run `ibmcloud cr api`.
    *  **`<namespace>`**: The registry namespace. To get your namespace information, run `ibmcloud cr namespace-list`.
    *  **`<my_image>:<tag>`**: The image and tag that you want to use to build the container. To get the images available in your registry, run `ibmcloud cr images`.

3.  Create the deployment in your cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

<br />


## Referring to the image pull secret in your pod deployment
{: #pod_imagePullSecret}

If the cluster administrator did not [store the image pull secret in the Kubernetes service account](/docs/containers?topic=containers-registry#use_imagePullSecret), all deployments that do not specify a service account cannot use the image pull secret to deploy containers. Instead, you can define an image pull secret in your pod deployment. When you refer to the image pull secret in a pod deployment, the image pull secret is valid for this pod only and cannot be shared across pods in the Kubernetes namespace.
{: shortdesc}

Before you begin:
* [Create an image pull secret](/docs/containers?topic=containers-registry#other) to access images in other registries or Kubernetes namespaces other than `default`.
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Steps:

1.  Create a pod configuration file that is named `mypod.yaml`.
2.  Define the pod and the image pull secret to access images in {{site.data.keyword.registrylong_notm}}.

    To access a private image:
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: <container_name>
          image: <region>.icr.io/<namespace_name>/<image_name>:<tag>
      imagePullSecrets:
        - name: <secret_name>
    ```
    {: codeblock}

    To access an {{site.data.keyword.cloud_notm}} public image:
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: <container_name>
          image: icr.io/<image_name>:<tag>
      imagePullSecrets:
        - name: <secret_name>
    ```
    {: codeblock}

    <table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;container_name&gt;</em></code></td>
    <td>The name of the container to deploy to your cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;namespace_name&gt;</em></code></td>
    <td>The registry namespace where the image is stored. To list available namespaces, run `ibmcloud cr namespace-list`.</td>
    </tr>
    <tr>
    <td><code><em>&lt;image_name&gt;</em></code></td>
    <td>The name of the image to use. To list available images in an {{site.data.keyword.cloud_notm}} account, run `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code><em>&lt;tag&gt;</em></code></td>
    <td>The version of the image that you want to use. If no tag is specified, the image that is tagged <strong>latest</strong> is used by default.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>The name of the image pull secret that you created earlier.</td>
    </tr>
    </tbody></table>

3.  Save your changes.
4.  Create the deployment in your cluster.
    ```
    kubectl apply -f mypod.yaml
    ```
    {: pre}

<br />


## Pushing images to {{site.data.keyword.registryshort_notm}}
{: #push-images}

After the cluster administrator [sets up an image registry with {{site.data.keyword.registryshort_notm}}](/docs/Registry?topic=registry-getting-started#getting-started), you can securely store and share Docker images with other users by adding images to your namespace.
{: shortdesc}

For example, you might pull an image from any private or public registry source, and then tag it for later use in {{site.data.keyword.registryshort_notm}}. Or, you might push a Docker image that you work with to your namespace so that other users can access the image. To get started, see [Adding images to your namespace](/docs/Registry?topic=registry-registry_images_).

<br />


## Managing security of images in {{site.data.keyword.registryshort_notm}} with Vulnerability Advisor
{: #push-images}

Vulnerability Advisor checks the security status of container images that are provided by IBM, third parties, or added to your organization's {{site.data.keyword.registryshort_notm}} namespace.
{: shortdesc}

When you add an image to a namespace, the image is automatically scanned by Vulnerability Advisor to detect security issues and potential vulnerabilities. If security issues are found, instructions are provided to help fix the reported vulnerability. To get started, see [Managing image security with Vulnerability Advisor](/docs/Registry?topic=va-va_index).

<br />



## Deprecated: Using a registry token to deploy containers from an {{site.data.keyword.registrylong_notm}} image
{: #namespace_token}

You can deploy containers to your cluster from an IBM-provided public image or a private image that is stored in your namespace in {{site.data.keyword.registryshort_notm}}. Existing clusters use a registry [token](/docs/Registry?topic=registry-registry_access#registry_tokens) that is stored in a cluster `imagePullSecret` to authorize access to pull images from the `registry.bluemix.net` domain names.
{:shortdesc}

For clusters that were created before **1 July 2019**, non-expiring registry tokens and secrets were automatically created for both the [nearest regional registry and the global registry](/docs/Registry?topic=registry-registry_overview#registry_regions). The global registry securely stores public, IBM-provided images that you can refer to across your deployments instead of having different references for images that are stored in each regional registry. The regional registry securely stores your own private Docker images. The tokens are used to authorize read-only access to any of your namespaces that you set up in {{site.data.keyword.registryshort_notm}} so that you can work with these public (global registry) and private (regional registry) images.

Each token must be stored in a Kubernetes `imagePullSecret` so that it is accessible to a Kubernetes cluster when you deploy a containerized app. When your cluster is created, {{site.data.keyword.containerlong_notm}} automatically stores the tokens for the global (IBM-provided public images) and regional registries in Kubernetes image pull secrets. The image pull secrets are added to the `default` Kubernetes namespace, the `kube-system` namespace, and the list of secrets in the `default` service account for those namespaces.

This method of using a token to authorize cluster access to {{site.data.keyword.registrylong_notm}} for the `registry.bluemix.net` domain names is deprecated. Before tokens become unsupported, update your deployments to [use the API key method](/docs/containers?topic=containers-registry#cluster_registry_auth) to authorize cluster access to the new `icr.io` registry domain names.
{: deprecated}

Depending on where the image is and where the container is, you must deploy containers by following different steps.
*   [Deploy a container to the `default` Kubernetes namespace with an image that is in the same region as your cluster](#token_default_namespace)
*   [Deploy a container to a different Kubernetes namespace than `default`](#token_copy_imagePullSecret)
*   [Deploy a container with an image that is in a different region or {{site.data.keyword.cloud_notm}} account than your cluster](#token_other_regions_accounts)
*   [Deploy a container with an image that is from a private, non-IBM registry](#private_images)

By using this initial setup, you can deploy containers from any image that is available in a namespace in your {{site.data.keyword.cloud_notm}} account into the **default** namespace of your cluster. To deploy a container into other namespaces of your cluster, or to use an image that is stored in another {{site.data.keyword.cloud_notm}} region or in another {{site.data.keyword.cloud_notm}} account, you must [create your own image pull secret for your cluster](/docs/containers?topic=containers-registry#other).
{: note}

### Deprecated: Deploying images to the `default` Kubernetes namespace with a registry token
{: #token_default_namespace}

With the registry token that is stored in the image pull secret, you can deploy a container from any image that is available in your regional {{site.data.keyword.registrylong_notm}} into the **default** namespace of your cluster.
{: shortdesc}

Before you begin:
1. [Set up a namespace in {{site.data.keyword.registryshort_notm}} and push images to this namespace](/docs/Registry?topic=registry-getting-started#gs_registry_namespace_add).
2. [Create a cluster](/docs/containers?topic=containers-clusters#clusters_ui).
3. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To deploy a container into the **default** namespace of your cluster, create a configuration file.

1.  Create a deployment configuration file that is named `mydeployment.yaml`.
2.  Define the deployment and the image that you want to use from your namespace in {{site.data.keyword.registryshort_notm}}.

    To use a private image from a namespace in {{site.data.keyword.registryshort_notm}}:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: <app_name>-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - name: <app_name>
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Tip:** To retrieve your namespace information, run `ibmcloud cr namespace-list`.

3.  Create the deployment in your cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tip:** You can also deploy an existing configuration file, such as one of the IBM-provided public images. This example uses the **ibmliberty** image in the US-South region.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Deprecated: Copying the token-based image pull secret from the default namespace to other namespaces in your cluster
{: #token_copy_imagePullSecret}

You can copy the image pull secret with registry token credentials that is automatically created for the `default` Kubernetes namespace to other namespaces in your cluster.
{: shortdesc}

1. List available namespaces in your cluster.
   ```
   kubectl get namespaces
   ```
   {: pre}

   Example output:
   ```
   default          Active    79d
   ibm-cert-store   Active    79d
   ibm-system       Active    79d
   istio-system     Active    34d
   kube-public      Active    79d
   kube-system      Active    79d
   ```
   {: screen}

2. Optional: Create a namespace in your cluster.
   ```
   kubectl create namespace <namespace_name>
   ```
   {: pre}

3. Copy the image pull secrets from the `default` namespace to the namespace of your choice. The new image pull secrets are named `bluemix-<namespace_name>-secret-regional` and `bluemix-<namespace_name>-secret-international`.
   ```
   kubectl get secret bluemix-default-secret-regional -o yaml | sed 's/default/<namespace_name>/g' | kubectl -n <namespace_name> create -f -
   ```
   {: pre}

   ```
   kubectl get secret bluemix-default-secret-international -o yaml | sed 's/default/<namespace_name>/g' | kubectl -n <namespace_name> create -f -
   ```
   {: pre}

4.  Verify that the secrets are created successfully.
    ```
    kubectl get secrets --namespace <namespace_name>
    ```
    {: pre}

5. [Deploy a container by using the `imagePullSecret`](/docs/containers?topic=containers-app#pod_imagePullSecret) in your namespace.


### Deprecated: Accessing token-authorized images in other {{site.data.keyword.cloud_notm}} regions and accounts
{: #token_other_regions_accounts}

To access images in other {{site.data.keyword.cloud_notm}} regions or accounts, you must create a registry token and save your credentials in an image pull secret.
{: shortdesc}

Tokens that authorize access to `registry.<region>.bluemix.net` domains are deprecated. You can no longer create new tokens. Instead, create cluster image pull secrets that use [API key credentials](/docs/containers?topic=containers-registry#imagePullSecret_migrate_api_key) to pull images from the `icr.io` registry domains.
{: deprecated}

1.  List tokens in your {{site.data.keyword.cloud_notm}} account.

    ```
    ibmcloud cr token-list
    ```
    {: pre}

2.  Note the token ID that you want to use.
3.  Retrieve the value for your token. Replace <em>&lt;token_ID&gt;</em> with the ID of the token that you retrieved in the previous step.

    ```
    ibmcloud cr token-get <token_id>
    ```
    {: pre}

    Your token value is displayed in the **Token** field of your CLI output.

4.  Create the Kubernetes secret to store your token information.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_URL> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Understanding this command's components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Required. The Kubernetes namespace of your cluster where you want to use the secret and deploy containers to. Run <code>kubectl get namespaces</code> to list all namespaces in your cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Required. The name that you want to use for your image pull secret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_URL&gt;</em></code></td>
    <td>Required. The URL to the image registry where your namespace is set up.<ul><li>For namespaces that are set up in US-South and US-East <code>registry.ng.bluemix.net</code></li><li>For namespaces that are set up in UK-South <code>registry.eu-gb.bluemix.net</code></li><li>For namespaces that are set up in EU-Central (Frankfurt) <code>registry.eu-de.bluemix.net</code></li><li>For namespaces that are set up in Australia (Sydney) <code>registry.au-syd.bluemix.net</code></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Required. The username to log in to your private registry. For {{site.data.keyword.registryshort_notm}}, the username is set to the value <strong><code>token</code></strong>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Required. The value of your registry token that you retrieved earlier.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Required. If you have one, enter your Docker email address. If you do not, enter a fictional email address, as for example a@b.c. This email is mandatory to create a Kubernetes secret, but is not used after creation.</td>
    </tr>
    </tbody></table>

5.  Verify that the secret was created successfully. Replace <em>&lt;kubernetes_namespace&gt;</em> with the namespace where you created the image pull secret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

6.  [Deploy a container by using the image pull secret](/docs/containers?topic=containers-app#pod_imagePullSecret) in your namespace.
