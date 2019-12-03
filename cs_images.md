---

copyright:
  years: 2014, 2019
lastupdated: "2019-12-03"

keywords: kubernetes, iks, registry, pull secret, secrets

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
{:preview: .preview} 

# Building containers from images
{: #images}

A Docker image is the basis for every container that you create with {{site.data.keyword.containerlong}}.
{:shortdesc}

An image is created from a Dockerfile, which is a file that contains instructions to build the image. A Dockerfile might reference build artifacts in its instructions that are stored separately, such as an app, the app's configuration, and its dependencies.

## Planning image registries
{: #planning_images}

Images are typically stored in a registry that can either be accessible by the public (public registry) or set up with limited access for a small group of users (private registry).
{:shortdesc}

Public registries, such as Docker Hub, can be used to get started with Docker and Kubernetes to create your first containerized app in a cluster. But when it comes to enterprise applications, use a private registry, like the one provided in {{site.data.keyword.registryshort_notm}} to protect your images from being used and changed by unauthorized users. Private registries must be set up by the cluster admin to ensure that the credentials to access the private registry are available to the cluster users.


You can use multiple registries with {{site.data.keyword.containerlong_notm}} to deploy apps to your cluster.

|Registry|Description|Benefit|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry?topic=registry-getting-started#getting-started)|With this option, you can set up your own secured Docker image repository in {{site.data.keyword.registryshort_notm}} where you can safely store and share images between cluster users.|<ul><li>Manage access to images in your account.</li><li>Use {{site.data.keyword.IBM_notm}} provided images and sample apps, such as {{site.data.keyword.IBM_notm}} Liberty, as a parent image and add your own app code to it.</li><li>Automatic scanning of images for potential vulnerabilities by Vulnerability Advisor, including OS specific recommendations to fix them.</li></ul>|
|Any other private registry|Connect any existing private registry to your cluster by creating an [image pull secret ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/containers/images/). The secret is used to securely save your registry URL and credentials in a Kubernetes secret.|<ul><li>Use existing private registries independent of their source (Docker Hub, organization owned registries, or other private Cloud registries).</li></ul>|
|[Public Docker Hub![External link icon](../icons/launch-glyph.svg "External link icon")](https://hub.docker.com/){: #dockerhub}|Use this option to use existing public images from Docker Hub directly in your [Kubernetes deployment![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) when no Dockerfile changes are needed. <p>**Note:** Keep in mind that this option might not meet your organization's security requirements, like access management, vulnerability scanning, or app privacy.</p>|<ul><li>No additional setup is needed for your cluster.</li><li>Includes a variety of open-source applications.</li></ul>|
{: caption="Public and private image registry options" caption-side="top"}

After you set up an image registry, cluster users can use the images to deploy apps to the cluster.

{[gdpr_images]}

{[white-space.md]}

{[pg-images.md]}

## Deprecated: Using a registry token to deploy containers from an {{site.data.keyword.registrylong_notm}} image
{: #namespace_token}

You can deploy containers to your cluster from an IBM-provided public image or a private image that is stored in your namespace in {{site.data.keyword.registryshort_notm}}. Existing clusters use a registry [token](/docs/services/Registry?topic=registry-registry_access#registry_tokens) that is stored in a cluster `imagePullSecret` to authorize access to pull images from the `registry.bluemix.net` domain names.
{:shortdesc}

For clusters that were created before **1 July 2019**, non-expiring registry tokens and secrets were automatically created for both the [nearest regional registry and the global registry](/docs/services/Registry?topic=registry-registry_overview#registry_regions). The global registry securely stores public, IBM-provided images that you can refer to across your deployments instead of having different references for images that are stored in each regional registry. The regional registry securely stores your own private Docker images. The tokens are used to authorize read-only access to any of your namespaces that you set up in {{site.data.keyword.registryshort_notm}} so that you can work with these public (global registry) and private (regional registry) images.

Each token must be stored in a Kubernetes `imagePullSecret` so that it is accessible to a Kubernetes cluster when you deploy a containerized app. When your cluster is created, {{site.data.keyword.containerlong_notm}} automatically stores the tokens for the global (IBM-provided public images) and regional registries in Kubernetes image pull secrets. The image pull secrets are added to the `default` Kubernetes namespace, the `kube-system` namespace, and the list of secrets in the `default` service account for those namespaces.

This method of using a token to authorize cluster access to {{site.data.keyword.registrylong_notm}} for the `registry.bluemix.net` domain names is deprecated. Before tokens become unsupported, update your deployments to [use the API key method](#cluster_registry_auth) to authorize cluster access to the new `icr.io` registry domain names.
{: deprecated}

Depending on where the image is and where the container is, you must deploy containers by following different steps.
*   [Deploy a container to the `default` Kubernetes namespace with an image that is in the same region as your cluster](#token_default_namespace)
*   [Deploy a container to a different Kubernetes namespace than `default`](#token_copy_imagePullSecret)
*   [Deploy a container with an image that is in a different region or {{site.data.keyword.cloud_notm}} account than your cluster](#token_other_regions_accounts)
*   [Deploy a container with an image that is from a private, non-IBM registry](#private_images)

By using this initial setup, you can deploy containers from any image that is available in a namespace in your {{site.data.keyword.cloud_notm}} account into the **default** namespace of your cluster. To deploy a container into other namespaces of your cluster, or to use an image that is stored in another {{site.data.keyword.cloud_notm}} region or in another {{site.data.keyword.cloud_notm}} account, you must [create your own image pull secret for your cluster](#other).
{: note}

### Deprecated: Deploying images to the `default` Kubernetes namespace with a registry token
{: #token_default_namespace}

With the registry token that is stored in the image pull secret, you can deploy a container from any image that is available in your regional {{site.data.keyword.registrylong_notm}} into the **default** namespace of your cluster.
{: shortdesc}

Before you begin:
1. [Set up a namespace in {{site.data.keyword.registryshort_notm}} and push images to this namespace](/docs/services/Registry?topic=registry-getting-started#gs_registry_namespace_add).
2. [Create a cluster](/docs/containers?topic=containers-clusters#clusters_ui).
3. {[target]}

To deploy a container into the **default** namespace of your cluster, create a configuration file.

1.  Create a deployment configuration file that is named `mydeployment.yaml`.
2.  Define the deployment and the image that you want to use from your namespace in {{site.data.keyword.registryshort_notm}}.

    To use a private image from a namespace in {{site.data.keyword.registryshort_notm}}:

    ```
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

    **Tip:** To retrieve your namespace information, run `{[iccr]} namespace-list`.

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

5. [Deploy a container by using the `imagePullSecret`](#use_imagePullSecret) in your namespace.


### Deprecated: Accessing token-authorized images in other {{site.data.keyword.cloud_notm}} regions and accounts
{: #token_other_regions_accounts}

To access images in other {{site.data.keyword.cloud_notm}} regions or accounts, you must create a registry token and save your credentials in an image pull secret.
{: shortdesc}

Tokens that authorize access to `registry.<region>.bluemix.net` domains are deprecated. You can no longer create new tokens. Instead, create cluster image pull secrets that use [API key credentials](#imagePullSecret_migrate_api_key) to pull images from the `icr.io` registry domains.
{: deprecated}

1.  List tokens in your {{site.data.keyword.cloud_notm}} account.

    ```
    {[iccr]} token-list
    ```
    {: pre}

2.  Note the token ID that you want to use.
3.  Retrieve the value for your token. Replace <em>&lt;token_ID&gt;</em> with the ID of the token that you retrieved in the previous step.

    ```
    {[iccr]} token-get <token_id>
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
    <td>Required. The user name to log in to your private registry. For {{site.data.keyword.registryshort_notm}}, the user name is set to the value <strong><code>token</code></strong>.</td>
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

6.  [Deploy a container by using the image pull secret](#use_imagePullSecret) in your namespace.
